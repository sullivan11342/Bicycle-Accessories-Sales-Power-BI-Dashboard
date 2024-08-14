/****** Script for SelectTopNRows command from SSMS  ******/

-- Tutorial walkthrough and raw data can be found here: https://www.youtube.com/watch?v=z7o5Wju-PZg&t=277s

-- USE ALI AHMAD Data Portfolio Project for the following:

--STEP 1. CLEANSE THE DimDate TABLE

SELECT 
[DateKey]
      ,[FullDateAlternateKey] AS DATE
     -- ,[DayNumberOfWeek]
      ,[EnglishDayNameOfWeek] AS DAY
    --  ,[SpanishDayNameOfWeek]
     -- ,[FrenchDayNameOfWeek]
     -- ,[DayNumberOfMonth]
     -- ,[DayNumberOfYear]
      ,[WeekNumberOfYear] AS Weeknr
      ,[EnglishMonthName] AS Month
	  ,LEFT([EnglishMonthName],3) AS Monthshort
     -- ,[SpanishMonthName]
    --  ,[FrenchMonthName]
      ,[MonthNumberOfYear] AS Monthno
      ,[CalendarQuarter] AS Quarter
      ,[CalendarYear] AS Year
    --  ,[CalendarSemester]
    --  ,[FiscalQuarter]
    --  ,[FiscalYear]
    --  ,[FiscalSemester]
  FROM [AdventureWorksDW2019].[dbo].[DimDate]
  WHERE calendaryear >= 2019;

  -- use https://codebeautify.org/sqlformatter to clean up your code. 
  --Results posted below.

  SELECT 
  [DateKey], 
  [FullDateAlternateKey] 
  -- ,[DayNumberOfWeek], 

  [EnglishDayNameOfWeek] --  ,[SpanishDayNameOfWeek]
  -- ,[FrenchDayNameOfWeek]
  -- ,[DayNumberOfMonth]
  -- ,[DayNumberOfYear]
  , 
  [WeekNumberOfYear], 
  [EnglishMonthName] -- ,[SpanishMonthName]
  --  ,[FrenchMonthName]
  , 
  [MonthNumberOfYear], 
  [CalendarQuarter], 
  [CalendarYear] --  ,[CalendarSemester]
  --  ,[FiscalQuarter]
  --  ,[FiscalYear]
  --  ,[FiscalSemester]
FROM 
  [AdventureWorksDW2019].[dbo].[DimDate]

  --(more or less it looks better, lol)




-----------------------------------------STEP 2: Cleanse the DimCustomers table;

SELECT c.[CustomerKey] AS Customerkey,
--    ,[GeographyKey]
--    ,[CustomerAlternateKey]
--    ,[Title]
      c.[FirstName] AS [First Name],
--    ,[MiddleName]
      c.[LastName] AS [Last Name],
      c.firstname + ' ' + lastName AS [Full Name],
--    ,[BirthDate]
--    ,[MaritalStatus]
--    ,[Suffix]
CASE c.gender WHEN 'M' THEN 'Male' WHEN 'F' THEN 'Female' END AS Gender,
--      ,[EmailAddress]
--      ,[YearlyIncome]
--      ,[TotalChildren]
--      ,[NumberChildrenAtHome]
--      ,[EnglishEducation]
--      ,[SpanishEducation]
--     ,[FrenchEducation]
--      ,[EnglishOccupation]
--      ,[SpanishOccupation]
--      ,[FrenchOccupation]
--      ,[HouseOwnerFlag]
--      ,[NumberCarsOwned]
--      ,[AddressLine1]
--      ,[AddressLine2]
--      ,[Phone]
      c.DateFirstPurchase AS DateFirstPurchase,
--      ,[CommuteDistance]
g.city AS [customer City]
FROM 
	dbo.dimcustomer AS c
	LEFT JOIN dbo.DimGeography AS g on g.geographykey = c.geographykey
ORDER BY
customerkey ASC




--------------------------------------------------------- step 3: Cleanse DimProduct table: 



SELECT p.[ProductKey]
      ,p.[ProductAlternateKey] AS ProductItemcode
--      ,[ProductSubcategoryKey]
--      ,[WeightUnitMeasureCode]
--      ,[SizeUnitMeasureCode]
      ,p.[EnglishProductName] AS [Product Name],
	  ps.Englishproductsubcategoryname AS [Sub Category], -- joined in from sub category table
	  pc.englishproductcategoryname AS [product category], -- joined in from category table
--      ,[SpanishProductName]
--      ,[FrenchProductName]
--      ,[StandardCost]
--      ,[FinishedGoodsFlag]
      p.[Color] AS [product color],
--      ,[SafetyStockLevel]
--      ,[ReorderPoint]
--      ,[ListPrice]
      p.[Size] AS [product size],
--      ,[SizeRange]
--      ,[Weight]
--      ,[DaysToManufacture]
      p.[ProductLine] AS [Product Line],
--      ,[DealerPrice]
--      ,[Class]
--      ,[Style]
      p.[ModelName] AS [Product Model Name],
--      ,[LargePhoto]
      p.[EnglishDescription] AS [Product Description],
--      ,[FrenchDescription]
--      ,[ChineseDescription]
--      ,[ArabicDescription]
--      ,[HebrewDescription]
--      ,[ThaiDescription]
--      ,[GermanDescription]
--      ,[JapaneseDescription]
--      ,[TurkishDescription]
--      ,[StartDate]
--      ,[EndDate]

  ISNULL ( p.Status, 'outdated') AS [product status]
  FROM dimproduct as p
  LEFT JOIN DimProductsubCategory AS ps ON ps.ProductSubcategoryKey = p.ProductSubcategoryKey
  LEFT JOIN DimProductCategory AS pc ON ps.ProductCategoryKey = pc.ProductCategoryKey
  Order by
  p.productkey asc; 



  ------------------------------------------------ step 4. Cleanse the internet sales table

  SELECT 
	   [ProductKey]
      ,[OrderDateKey]
      ,[DueDateKey]
      ,[ShipDateKey]
      ,[CustomerKey]
--      ,[PromotionKey]
--      ,[CurrencyKey]
--      ,[SalesTerritoryKey]
      ,[SalesOrderNumber]
--      ,[SalesOrderLineNumber]
--      ,[RevisionNumber]
--      ,[OrderQuantity]
--      ,[UnitPrice]
--      ,[ExtendedAmount]
--      ,[UnitPriceDiscountPct]
--      ,[DiscountAmount]
--      ,[ProductStandardCost]
--      ,[TotalProductCost]
      ,[SalesAmount]
--      ,[TaxAmt]
--      ,[Freight]
--      ,[CarrierTrackingNumber]
--      ,[CustomerPONumber]
--      ,[OrderDate]
--      ,[DueDate]
--      ,[ShipDate]

  FROM [AdventureWorksDW2019].[dbo].[FactInternetSales]
  WHERE Left (orderDateKey, 4) >= YEAR(GetDate()) -2 -- ensures we always only bring two years of date from extraction.
  ORDER BY salesamount ASC; 

  select sum(salesamount) AS TotalSalesAmount FROM [AdventureWorksDW2019].[dbo].[FactInternetSales]
  WHERE Left (orderDateKey, 4) >= YEAR(GetDate()) -2


  select * from budget

  select salesamount

  select sum(salesamount) from factinternetsales
  WHERE Left (orderDateKey, 4) >= YEAR(GetDate()) -2
  AND Orderdate BETWEEN 20220101 AND 2022