//
//  ViewController.swift
//  Todoey-2019
//
//  Created by Tihomir Dimitrov on 15.01.19.
//  Copyright © 2019 Tihomir Dimitrov. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    var itemArray = [Item]()

    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        let newItem = Item()
        newItem.title = "Find Mike"
        itemArray.append(newItem)

        let newItem1 = Item()
        newItem1.title = "Buy Eggos"
        itemArray.append(newItem1)

        if let items = defaults.array(forKey: "TodoListArray") as? [Item] {
            itemArray = items
        }
    }

    // MARK: Tableview Datasource Methods

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)

        let item = itemArray[indexPath.row]

        cell.textLabel?.text = item.title

        cell.accessoryType = item.done ? .checkmark :.none

        return cell
    }

    // MARK: Tableview Delegate Methods

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //        print(itemArray[indexPath.row])

        itemArray[indexPath.row].done = !itemArray[indexPath.row].done

        tableView.reloadData()

        tableView.deselectRow(at: indexPath, animated: true)
    }
    // MARK: Add new items

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {

        var textField = UITextField()

        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)

        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            // What will happen once user clicks the Add Item button on our UIAlert
            print("Success")

            let newItem = Item()
            newItem.title = textField.text!

            self.itemArray.append(newItem)

            self.defaults.set(self.itemArray, forKey: "TodoListArray")

            self.tableView.reloadData()

        }

        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Item"
            textField = alertTextField
        }

        alert.addAction(action)

        present(alert, animated: true, completion: nil)

    }

}

