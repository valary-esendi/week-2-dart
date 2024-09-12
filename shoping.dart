void main() {
  // Sample item prices in the shopping cart
  List<double> itemPrices = [26.83, 16.50, 7.99, 12.00, 5.49, 50.00, 64.39];

  // Filter out items under $10 using an anonymous function
  var filteredItems = itemPrices.where((price) => price >= 10).toList();

  // Check for filtered items and print appropriate message
  if (filteredItems.isEmpty) {
    print('No items priced at \$10 and above.');
  } else {
    print("Items priced \$10 and above: $filteredItems");
  }

  // Calculate the total price of the filtered items (if any)
  double totalPrice = calculateTotal(filteredItems, tax: 0.07);
  print('Total price with tax: \$${totalPrice.toStringAsFixed(2)}');

  // Apply a discount of 10% to the items if there are any
  if (filteredItems.isNotEmpty) {
    double discountPercent = 10;
    double discountedTotal = applyDiscount(filteredItems, (price) {
      return price - (price * (discountPercent / 100));
    });
    print('Total price after discount: \$${discountedTotal.toStringAsFixed(2)}');

    // Calculate an additional special discount using factorial
    double factorialDiscount = calculateFactorialDiscount(filteredItems.length);
    double finalPrice = discountedTotal - (discountedTotal * (factorialDiscount / 100));
    print('Final price after special discount: \$${finalPrice.toStringAsFixed(2)}');
  } else {
    print('No discounts applied, as there are no items with price \$10 or above.');
  }
}

// Function to calculate the total price, with optional tax parameter
double calculateTotal(List<double> prices, {double tax = 0.0}) {
  double total = prices.fold(0, (sum, price) => sum + price);
  return total + (total * tax); // Add tax
}

// Higher-order function to apply a discount to a list of prices
double applyDiscount(List<double> prices, double Function(double) discountFunction) {
  return prices.map(discountFunction).reduce((a, b) => a + b);
}

// Recursive function to calculate the factorial discount
double calculateFactorialDiscount(int n) {
  if (n <= 1) {
    return n <= 0 ? 0 : 1; // 0! = 1 and 1! = 1
  } else {
    return n * calculateFactorialDiscount(n - 1);
  }
}