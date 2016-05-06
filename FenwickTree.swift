
import Foundation

struct FenwickTree: CustomDebugStringConvertible {
    
    let count: Int
    var data: [Int]
    var tree: [Int]
    
    init(count: Int) {
        self.count = count
        self.data = Array(count: count, repeatedValue: 0)
        self.tree = Array(count: count + 1, repeatedValue: 0)
    }
    
    subscript (index: Int) -> Int {
        get {
            return data[index]
        }
        set {
            let oldValue = data[index];
            let delta = newValue - oldValue
            data[index] = newValue
            var x = index + 1
            while x <= count {
                tree[x] += delta
                x += x & -x
            }
        }
    }
    
    func sum(index: Int) -> Int {
        var sum = 0
        var x = index + 1
        while x > 0 {
            sum += tree[x]
            x -= x & -x
        }
        return sum
    }
    
    func sumOnRange(range: Range<Int>) -> Int {
        let l = range.startIndex, r = range.endIndex - 1
        return l == r ? data[l] : sum(r) - sum(l)
    }
    
    var debugDescription: String {
        return "\(data) \(tree)"
    }

}

var tree = FenwickTree(count: 16)
for i in 0..<16 {
    tree[i] = i + 1
}
//print(tree)
print(tree.sum(7))
print(tree.sum(2))
print(tree.sumOnRange(4...5))
