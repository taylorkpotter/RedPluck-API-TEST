//
//  TPViewController.m
//  jsonTest
//
//  Created by Taylor Potter on 4/1/14.
//  Copyright (c) 2014 potter.io. All rights reserved.
//

#import "TPViewController.h"

@interface TPViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic) NSMutableArray *filings;

@end

@implementation TPViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self downloadFilings];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  static NSString *identifier = @"Cell";
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
  //Pulling out one filing for the row were about to draw
  NSDictionary *filing = _filings[indexPath.row];
  cell.textLabel.text = [filing objectForKey:@"Company Name"];
  return cell;
  
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  // underscore to declare property & count of cells should be equal to filings array.
  return _filings.count;
}

//This is a non asyncronous way to download the json code
- (void) downloadFilings
{
  NSString *jsonString = @"http://redpluck.com/v1/tasks/20/items";
  NSURL *jsonURL = [NSURL URLWithString:jsonString];
  NSData *jsonData = [NSData dataWithContentsOfURL:jsonURL];
  //parses json
  _filings = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
  [_tableView reloadData];
}







@end
