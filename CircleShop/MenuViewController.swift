//
//  MenuViewController.swift
//  CircleShop
//
//  Created by yue zheng on 11/8/14.
//  Copyright (c) 2014 yue zheng. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var transitionsNavigationController: UINavigationController!
    var menuItems: [String] = ["Yue","Setting", "Logout"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // topViewController is the transitions navigation controller at this point.
        // It is initially set as a User Defined Runtime Attributes in storyboards.
        // We keep a reference to this instance so that we can go back to it without losing its state.
        self.transitionsNavigationController = self.slidingViewController().topViewController as UINavigationController
        // Do any additional setup after loading the view.
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.view.endEditing(true)
    }
    
    func tableView(tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.menuItems.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("MenuCell") as MenuTableViewCell
        cell.textLabel.text = self.menuItems[indexPath.row]
        cell.backgroundColor = UIColor.clearColor()
        println("234234")

        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        // This undoes the Zoom Transition's scale because it affects the other transitions.
        // You normally wouldn't need to do anything like this, but we're changing transitions
        // dynamically so everything needs to start in a consistent state.
        self.slidingViewController().topViewController.view.layer.transform = CATransform3DMakeScale(1, 1, 1);
        
        let text = self.menuItems[indexPath.row]
        
        if text == "Yue" {
            
//            self.slidingViewController().topViewController = self.transitionsNavigationController;
        } else if text == "Settings" {
            self.slidingViewController().topViewController = self.storyboard?.instantiateViewControllerWithIdentifier("circle_navigation_controller") as UIViewController
        } else if text == "Logout" {
            User.logOut()
            let window = UIApplication.sharedApplication().windows.first as UIWindow
            (window.rootViewController as UINavigationController).popToRootViewControllerAnimated(true)
        }
        
        
        self.slidingViewController().resetTopViewAnimated(true)
    }
    

    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
