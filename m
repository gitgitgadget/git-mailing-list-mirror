Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7720C6FD1C
	for <git@archiver.kernel.org>; Fri, 24 Mar 2023 15:51:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232372AbjCXPv3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Mar 2023 11:51:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232200AbjCXPv2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2023 11:51:28 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2086.outbound.protection.outlook.com [40.107.21.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CA2815885
        for <git@vger.kernel.org>; Fri, 24 Mar 2023 08:51:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JFfl/b8dP8BiNxVPzMq1TND1qakvTA0c0AdsMjiuGR/t1yxq9E27g/2YXqgOHaB1ez7HYb8QYvydqbJW2DdHTRuSaColtfAMuaHCiaWiNQB3zFPpBfB61Wh0BLrN9KWfTnE0zrysUkODRh2VJMC51Grin28Fvf4JzilJmzPCyMWACN9P6SokGCegi2QbWbk5gxUvxGR+CFUiIOiDowLeYg6lEFIo+qffJIFVukpGX20/i8F/g6uhlAyXIXHmkbbLundSCXMaITEKMQpxQd8ydZMmiqc1JL+kAnzNM3m/TMWQyEcL6lvHJ7tFgaIlwSJUxjrR52wQZkES6jfYXnek4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a7cwJ/6gmBTSKn1+hhDvNsOmvHIhIsJRTOZ4xuiiP1g=;
 b=L0SCWLYY4U+kWBudzMZKkmtJJdB/CEnZ8YQgtoqp3dafZb2y0gozBJyBCdntrYuSXdzbGuoMV1u/P4gd8c+mH8kX9ScoHj/DqZE5UybgE8zpCOLGxS+5L0MAUmSUT+uOredXmg207OPTP+zlCXbAaqhQDmA3Kppiplqk6bfkJ88lFjSiZ8Yi3oydDWHSvhw6jIZGM75Pxp28Jzm9SD5Hv8ssoNVjr9tFiktCy8uyz6FZPurxVIDMkjLlOvS4Y3LtXbqhg4hk++PgWQM7aRiiJBlvDY5Gu+S4brzQvJFeziuk1spH/5YmkIhUoF7JAjO8ITfjKGEDeLdpi87hX0JAeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sap.com; dmarc=pass action=none header.from=sap.com; dkim=pass
 header.d=sap.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sap.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a7cwJ/6gmBTSKn1+hhDvNsOmvHIhIsJRTOZ4xuiiP1g=;
 b=gWED1JLVHW54cf8HZoi2wrN3Nd1ejtlPdegjb+b+Nt0UunfloDiybasAMafN6rTXRRMNG3K8yFTwRaOdyuM80SEOBAKTdseyP/pbqjrGCIMfo1smO7byQvTKZS9oN4nEnygw4DFY1NM3jWxhHp0bf311wi1IOfzBOnd7HL/gGLZEdtxCwzUPAbZBToqJe45AfOoFRhXRezbSMoX4Tvm6D4F1QcURF/6rMOIs3NWjQGfsFhhGzBTlUMZ9pKj4B4aI19W/8jz411vPinXI7xYzUUugBMwrEFgJwyUcCHkLAmMExp0j9fp//yy8vzrDJEfaT+rgTf4+rXGUZ/de1fZPzA==
Received: from AS1PR02MB8185.eurprd02.prod.outlook.com (2603:10a6:20b:474::9)
 by AM9PR02MB6628.eurprd02.prod.outlook.com (2603:10a6:20b:2cf::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Fri, 24 Mar
 2023 15:51:21 +0000
Received: from AS1PR02MB8185.eurprd02.prod.outlook.com
 ([fe80::2593:92e4:cab0:14de]) by AS1PR02MB8185.eurprd02.prod.outlook.com
 ([fe80::2593:92e4:cab0:14de%9]) with mapi id 15.20.6178.038; Fri, 24 Mar 2023
 15:51:21 +0000
From:   "Baumann, Moritz" <moritz.baumann@sap.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Feature Request: Option to make "git rev-list --objects" output
 duplicate objects
Thread-Topic: Feature Request: Option to make "git rev-list --objects" output
 duplicate objects
Thread-Index: AdleZgb9LbFh6JNJTEaFo9PrT/CbJw==
Date:   Fri, 24 Mar 2023 15:51:21 +0000
Message-ID: <AS1PR02MB8185A45DB63216699AFB2C5494849@AS1PR02MB8185.eurprd02.prod.outlook.com>
Accept-Language: en-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-processedbytemplafy: true
x-templafyemailsigvstoversion: 7.51.1.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sap.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS1PR02MB8185:EE_|AM9PR02MB6628:EE_
x-ms-office365-filtering-correlation-id: ae2d8e58-bc16-48d3-96a5-08db2c7f9d6b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5psIvRw+0oVfMomJbs3HCCW83BWnt4dM4zQCItR0IF8BKw3S9kZc91TFxWnUU8GqRaaa/IiessvoF5KK7ogpFWM46ekAnjjRpA9lWNMXyJsNYwMxhp0LuIsAGwBjIFJYMy5eugI0JEdmjeF18sdsO9M7QybOXNG7XRxT5FIpF/c+FiS+H0Q/VDF0WtMaIo3E+xw9JUDXwd8mUuu4ZtFKPK+qiEpCS94LQe6BSAl0q0AGl+NjXFnDVbS46Ey6Xvigg8Kw5ubiTRs6Z2yKFyqllcB1pNAv+7c66BlVbAm+98WOU9ljff77YJ+HDpasSWcaElV1/dXOYE8E9MUN6OnkYOBhh+i6IbNjktqr8f79/ooEGjfFXLndAQo0wtBxNB2bbm/O9EmCxdVSEbE2XU63DfI/s0fEkm43OYbgsAbfEaCpM0RDb9A3cU660iqqt3lqLvVEeYY/yXzETuscPUxyG6ZDWgSW2NSw99FzNHAuM4+IaHHTkmzk3Cf6cVG7aFyL4b/mpVithboQ0MoliCWmkDVewjVVLxEoKdB608aBjwRxiBSDQpw2Z9TPZ6QSLbkE1gmHA5kcEAUZ76G6+Pzl00XkqfA3CpOlbMU2+XQb6kKacFmNeV9tDFxKFEzadXry4BT6GBvo62qpUly1HvfR1foNrZufBPfJMOT0q3LAyAiJNWcU30m1KeYzW40d8791s+yLCtw6Sa0y92IWoeNpiA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS1PR02MB8185.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(396003)(346002)(39860400002)(366004)(136003)(451199018)(83380400001)(9686003)(26005)(6506007)(33656002)(38070700005)(186003)(71200400001)(7696005)(478600001)(66476007)(66556008)(76116006)(66946007)(316002)(82960400001)(66446008)(8936002)(8676002)(5660300002)(6916009)(52536014)(86362001)(64756008)(122000001)(2906002)(41300700001)(38100700002)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MDlXc29VVmtReWhoMVRNSUdXL3dva2NoRC9uNGRVaGJjN3grLzY4SUtKd2pW?=
 =?utf-8?B?bmI2b2J0THhYS2N6Q2VRSXllRFUxb1U2bHNmVGsyOUYxQTcvY3QwaSt0WHdx?=
 =?utf-8?B?M3ZWSC9pTUdxeG1CeFFBN0lCWHVYT1pYb1o3aXpPdWJoRHRhNUNkV0g3Zi9s?=
 =?utf-8?B?UjJBbjFSMDNTWENSRkhBdzN1YlhWblorUWlSdklOV2hobW5PV1VuYVZmdEJI?=
 =?utf-8?B?UEZ5Y0Roa0dQOVhkQ25scUlNVWZFUzBLdFhqYmd0UDBUOUFYUGtoV1pGeFo4?=
 =?utf-8?B?ZWN6RjdWR3RwWC9ZV3c1VkZTeTdxQ1FNVXdBOXc0ZWk4bU14QVdIc25WV21a?=
 =?utf-8?B?aHFMMTZZOS9wM2RJZUczLzBiYTR4WEJ5Q2dlVDJHenZIRHhHMDd3MUdTVkM2?=
 =?utf-8?B?QzRXUWRFdGtTVlNCTTRLWDhUUjQvUGE1NkEvSWNUTG5iVTZqS0oyQ2ZOdFhk?=
 =?utf-8?B?c1BtWHcydVlubXg1ZDk0bGpnL3Z6dEQ5UVZ1Mms3YUN6WnJEZ0tIVm8xTks5?=
 =?utf-8?B?eVVsSDNJVUdkbUluRXFlZmt6TlZ6V29ORGNDcnVmcGFQRXBxTWNvUkhVVDVi?=
 =?utf-8?B?YWttRTl5NHBITk4yazRCS0czMzIvbEVvNzhhWnFyWTdEdWdOOGN2TXpkUkc0?=
 =?utf-8?B?dkpQckU3TXV0dVh3TFVwREJyN2FUeUFaR0lTQ3hoNVFIeEs2Y1U1eFE4NE9O?=
 =?utf-8?B?S3N0cGRvbHZ5YUJGWUM0bjJ4T1Q0ajF6TFJwV25rWDU3R1BQOVNqckREeEdT?=
 =?utf-8?B?QnQ5ak1VTndMT1N4a1lqZ21MNUJIN0hPTmMxUVZiQ2Vub3RJc3JkT0E4U0JF?=
 =?utf-8?B?YUh1WWMwbG1sSEdMdCtTRkRtL1R1bkkvYlJyYk5LczZ6bmIxRU9RNWZiaEhT?=
 =?utf-8?B?Y2dxeXdWZVB4ODVocjRpTTUrSWxtRnlING43SVVJT3VQSHR2YUNsaHYrc1No?=
 =?utf-8?B?R2lnS2FYT0h6NitxRm01bTVLTGMzb0tkZVpBbzkwRHM3YVNkSXhIV0MvMVBo?=
 =?utf-8?B?STBRSWxiK0FGTGF6ajFDRGRmczJaK0JuRUVnUWVsaTdqcU1Mb1BUQ3hpNWJW?=
 =?utf-8?B?Snc1NGZSSm9GYlV2b2h2N0ZNYTFLMEdmTHEzWjkwWWUxeVU4bWVOMmpCSnd4?=
 =?utf-8?B?b0xVUnNGeXBPVnRmTysyS0RoZWV2TEk3Z2ozTjl3OHNuTTZZUGFVV2Jac2NM?=
 =?utf-8?B?S0huVzhhWDFCTTR5YmJYRjFOZHJrMU1neFd0STVIaGM3eGlKb0VjVS9pK3gv?=
 =?utf-8?B?c2xrcUR4dEp1NDdaMWdRZXZmYVNOMHl0SFBGK2NsOVJJYk9zK3Q1d3ZLY0tG?=
 =?utf-8?B?M2prVHovZnJpaXZFWHQzS2ZVQXhpdGNnRjBRano0UW1aRlFDMFFhaTdsczdG?=
 =?utf-8?B?UzUvY3p2ZU1GY0hKeHVvdU9LbmQwcjV3REpKNUx4ZXhMdUNkSkw3ckdVbG9M?=
 =?utf-8?B?bitrS2RTRW94NzBGLzFmK3ZpbGlxdTgzNlc0eGtQWnFQUjAwa0g5QWRYeHNP?=
 =?utf-8?B?UUZReVVmWXN1eTZQUUh5Umd3OTdMbUhyS0xJUi96STJCbWZneURKSGdHMWhW?=
 =?utf-8?B?ZHZid0x0dzBGZXI1T3A4ajRQN25qZ2lmNGsxZ3g2QTh6UENSckk3YWYyWlFJ?=
 =?utf-8?B?UkpiTGU2bDNlWG1xQmxBSVdZVWt2WUNFNXJ1UWNtbVVCVmxiTGQyVStTbnNn?=
 =?utf-8?B?NHlxcjVtQmlHd3BRTS9pZkhUNTZlRnRhbVdZRHVrenI0MDRKZXR2bFpqZWFV?=
 =?utf-8?B?VEx3bjFoK1hBME9XL05TTUxzbGVCR2NzR0dodjRMU2xyNzVXL0xtdUdJN3Jy?=
 =?utf-8?B?WFo0aHoveFVQcUNleW5MYUVlb0N6ZjluSS9SMUo4UEd6UGFIclV1V3JKU2Ru?=
 =?utf-8?B?dlZWeFo1ZXlnREUwWXRLS21ZQmlZUmFjbmNITGxtU2RVN2JBS05DYVVZSytv?=
 =?utf-8?B?OGRlTVpHOWxQb21ZK3NYSmxTbis3Q3dyOFlkU05VT1lUWElsbDgzMVNMSUpL?=
 =?utf-8?B?d3A2WjFMdERCazBZVFFaWGZaOFlxZVRpSk5kWWk3aGgwQ2ZqK0wxUDJCbzVi?=
 =?utf-8?B?cm1QOEVSTTVFd0tVejNFK3RiNmRvSEZUZnBzaVNHYklhMklOaVV1NnFEUFdh?=
 =?utf-8?Q?7w2PZjKhO9vbrWh7ENdKkovfr?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sap.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS1PR02MB8185.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae2d8e58-bc16-48d3-96a5-08db2c7f9d6b
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2023 15:51:21.6287
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 42f7676c-f455-423c-82f6-dc2d99791af7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oCJyYhutmwX1ynulWy2befqscZGd9CdoRm9Xi7xkOuPT8k3V0wHe4ey69iJqq4dFFRLT4j8rGlXJGSDqyPgcyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR02MB6628
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

R29vZCBhZnRlcm5vb24sDQoNCldoaWxlIHJld3JpdGluZyBhIHNsb3cgcHJlLXJlY2VpdmUgaG9v
ayB0byAoaG9wZWZ1bGx5KSBzcGVlZCBpdCB1cCwgSSByYW4gaW50bw0KdGhlIGZvbGxvd2luZyBw
cm9ibGVtOg0KDQpXZSB3YW50IHRvIHBlcmZvcm0gYSBidW5jaCBvZiBjaGVja3Mgb24gYWxsIG5l
d2x5IHB1c2hlZCBmaWxlcywgc29tZSBvZiB3aGljaA0KYXJlIGJhc2VkIG9uIHRoZSBmaWxlIGNv
bnRlbnRzIGFuZCBzb21lIG9mIHdoaWNoIGFyZSBiYXNlZCBvbiB0aGUgZmlsZSBuYW1lLg0KSSBz
dGFydGVkIHdpdGjigKYNCg0KICBnaXQgcmV2LWxpc3QgLS1wcmV0dHk9Zm9ybWF0OicnIC0tbm8t
Y29tbWl0LWhlYWRlciBcDQogIC0tb2JqZWN0cyAtLWZpbHRlcj1vYmplY3Q6dHlwZT1ibG9iICIk
bmV3X2hlYWQiIC0tbm90IC0tYWxsDQoNCuKApmFuZCB0aGVuIHVzZWQgdGhlIHJlc3VsdGluZyBs
aXN0IGZvciBhbGwgc3Vic2VxdWVudCBjaGVja3MuIEFmdGVyIHdyaXRpbmcgc29tZQ0KdW5pdCB0
ZXN0cywgSSBub3RpY2VkIHRoYXQgdGhlIHJldHVybmVkIGxpc3QgaXMgbm90IHN1ZmZpY2llbnQ6
IElmIHlvdSBnZW5lcmF0ZQ0KdGhlIGV4YWN0IHNhbWUgZmlsZSB0d2ljZSwgb25jZSB3aXRoIGEg
ImJhZCIgbmFtZSBhbmQgb25jZSB3aXRoIGEgImdvb2QiIG5hbWUsDQp5b3Ugd2lsbCBvbmx5IHNl
ZSBvbmUgb2YgdGhvc2UgbmFtZXMgYW5kIHRoZXJlZm9yZSB0aGUgaG9vayB3aWxsIG1pc3Rha2Vu
bHkNCmFsbG93IHRoZSBwdXNoLg0KDQpTbywgd2hhdCBJIHdvdWxkIHdhbnQvbmVlZCBpcyBhbiBv
cHRpb24gdGhhdCBmb3JjZXMgImdpdCByZXYtbGlzdCAtLW9iamVjdHMiDQp0byBvdXRwdXQgdGhl
IG9iamVjdCBtdWx0aXBsZSB0aW1lcyBpZiBpdCBoYXMgbXVsdGlwbGUgbmFtZXMgaW4gdGhlIGNv
bW1pdA0KcmFuZ2UuIEFkbWl0dGVkbHksIHN1Y2ggYW4gb3B0aW9uIHdvdWxkIGxpa2VseSBvbmx5
IGJlIHVzZWZ1bCBmb3IgaG9va3MgdGhhdA0KdmFsaWRhdGUgZmlsZSBuYW1lcy4NCg0KV291bGQg
aXQgYmUgZmVhc2libGUgdG8gaW1wbGVtZW50IHN1Y2ggYW4gb3B0aW9uPyBJZiBzbywgZG9lcyBp
dCBzb3VuZCBsaWtlIGENCmdvb2Qgb3IgYmFkIGlkZWE/DQoNCklzIHRoZXJlIGFueSBhbHRlcm5h
dGl2ZSBmb3IgbXkgdXNlIGNhc2UgdGhhdCBkb2Vzbid0IGludm9sdmUgd2Fsa2luZyB0aGUNCmNv
bW1pdHMgb25lLWJ5LW9uZT8gKFRoYXQncyB3aGF0IHdlIHByZXZpb3VzbHkgZGlkIGFuZCB3aGF0
IHR1cm5lZCBvdXQgdG8gYmUNCnF1aXRlIHNsb3cgb24gb3VyIHJlcG9zaXRvcnkuKQ0KDQpCZXN0
IHJlZ2FyZHMsDQpNb3JpdHogQmF1bWFubg0K
