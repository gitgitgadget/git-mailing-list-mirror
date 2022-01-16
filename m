Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C461C433FE
	for <git@archiver.kernel.org>; Sun, 16 Jan 2022 16:08:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235584AbiAPQID (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 16 Jan 2022 11:08:03 -0500
Received: from mail-mw2nam12on2064.outbound.protection.outlook.com ([40.107.244.64]:61889
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233535AbiAPQH7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Jan 2022 11:07:59 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bJ8NldJJe2AIl9jrjiKhb08f6iCmKTY31+E4w/7kLqP/SvrKyv/wsrWet868yFob+PJ6z2hYC2w0PDawignzjAy8gpSdRfkIZntz4PaDh2MhcO1MhUXVP+hCgpGvWKxzeUfRyOmXp5ovP2k05oZ7LMIt+THmq33FPBepGKGQe+1KN1DrsxqohIKS1Wznz7ONuFbOz5UvkDIZPVVz7nYr2JJV7lOKOztZkhs+duZdPZTzlYR3gVymg434dxrLRAMtV3772+gkEN+kclbi+SfLGtmTodU3HN3Jnz91wJU87UaRIHVkUNCgU0Rf09hMI2VAyiwg7nS0K2AX1kJ9ruxWVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9jVt4V30/mRrZMdIceTKpsdOsbaI1VykzTIrm7kbpbM=;
 b=aIwogOhRPkuIH/vOS49umLd1pb/VdaBFM+VLFup3pt3lBejwkWaCsbu/SopwzyYQOMRcsZq8hD2hx/wZt1z2Ut/uWbMe1BQp/JTjwq5X5Dgtfzpws49A1B31XziLRP4YSNVOb22EVJ5DwExClHCsqfAQMV323iCh8TQeH9sPWei3Pjgix8nNQGp+sdB5mZm9urpc8MysCWL4BRXga4p0XQ+ggyu/DcOmqU1ztmLdaFmqD/cgCI+/NaR7ZSw6P0KbrWzEBSBgA4iXFzlNsESRtkdd8u8u03mMwiARsYsUFiYlc5qcx7a1iLk7uhb1aX68g3zj61YlzPa3eKAKzr1DdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9jVt4V30/mRrZMdIceTKpsdOsbaI1VykzTIrm7kbpbM=;
 b=lI70RnXHGfFigyKp9PdGSyzdZSZxYTndzTQ3wcHKAnvwKGD6tMlxLz9O2iW1u9gl3Pe4m5++oJV5ThMotMXQClyWveUgLDNhhC4v63Lzdgis5+M/xaGeuTzWRae40twjL2HgJT8Q6ErSwaX9FR14mI0pXDleeV2wH1LxZpaFBdyzsWSaUqv2/iIpVj2WKBwz5+JMiv0wHex1GP5cayCsEckZVAXsZDr3E9+ow1KYw0rGBwkDF8UNb2tz7HZIUXXX6b30XGtTNAIx7TBK0QAJo5VFbuOBkjIFFFVTwRVag4hZG1H6wwrOZ5xlqTlMg4A/ALqItdVd1HyBmLBraHC6lg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB4849.namprd12.prod.outlook.com (2603:10b6:208:1c2::17)
 by BYAPR12MB2597.namprd12.prod.outlook.com (2603:10b6:a03:6e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.12; Sun, 16 Jan
 2022 16:07:40 +0000
Received: from BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::509e:bbb9:e1fb:26ed]) by BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::509e:bbb9:e1fb:26ed%4]) with mapi id 15.20.4888.013; Sun, 16 Jan 2022
 16:07:40 +0000
From:   Joel Holdsworth <jholdsworth@nvidia.com>
To:     git@vger.kernel.org, Luke Diamand <luke@diamand.org>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Cc:     Tzadik Vanderhoof <tzadik.vanderhoof@gmail.com>,
        Dorgon Chang <dorgonman@hotmail.com>,
        Joachim Kuebart <joachim.kuebart@gmail.com>,
        Daniel Levin <dendy.ua@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Ben Keene <seraphire@gmail.com>,
        Andrew Oakley <andrew@adoakley.name>,
        Joel Holdsworth <jholdsworth@nvidia.com>
Subject: [PATCH v3 14/21] git-p4: remove spaces between dictionary keys and colons
Date:   Sun, 16 Jan 2022 16:05:43 +0000
Message-Id: <20220116160550.514637-15-jholdsworth@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220116160550.514637-1-jholdsworth@nvidia.com>
References: <20220116160550.514637-1-jholdsworth@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM6PR08CA0019.eurprd08.prod.outlook.com
 (2603:10a6:20b:b2::31) To BL0PR12MB4849.namprd12.prod.outlook.com
 (2603:10b6:208:1c2::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 18dea26d-aa6b-49d1-d31f-08d9d90a525c
X-MS-TrafficTypeDiagnostic: BYAPR12MB2597:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB25975148982D6A8FA7596AB3C8569@BYAPR12MB2597.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:407;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /OvxDn7V6uD63P+rccJz8yM15zHpoSCnu+1M5pTYFJ/jmOEtSgwKYCfPFqnJm9Mvhf4NpFIv6Srk8xueFYHJ+xixi98d8sFQL4hlK9PfGMojP3PvWtbGe8zIr7y+kLgcGVREEFbsWIi6wM7GfVOw3Rho9TOy3ypbCz/RuIANAiMEbp0ENYMHAHrFLk+XzM3z7QGMssPrE7XQNf8xkWC3vlxFSBNrYKMEMBEqrs0NzuqVim8T+4YDtaL7Q9OJByhYSv+oWzkbtb4SzzXdT7cyqOR74FImLpHu8tfXmUjKEc+WAl598gGqT6mhoWfBph43D11ZNGGEYXt0gk0ACkjNHXax3yKsUSoY2m0mZ578lkmy+09ndIo4AusdAKpDeKpYNhM5ocjd2sAME/gSntTuMeM7dzlEXvAdFmYmA1Z19SF8aWA1uGhyVgMjIF7taOQx/MMkb99qp3MHPFMYJhDPfQKvAp9KwZyUJ0mpfEJDCIDTGRgXDwpNMZXvlLtCanXdyH4RVSLWgfGTz8HYF2eEE/NzxkymgaUSNxQRs0qTLTwmVh1jc480jCrRYjNzWjQKy/FZWfb3eBDMmpE6hqEBOStqptEBtGydIVCVqxYdzuK1DW/R/jZcmOWgLy3f0Tamirh8u9o3L/nfjMUp1mYMGvzWU7CaOOxm3W8bGyqHGd5OiHvoTb2U2r7jvMUWsHI42skNHjXRS9Ol3sZPuqOPuw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(38350700002)(38100700002)(8936002)(4326008)(83380400001)(186003)(1076003)(4744005)(6512007)(110136005)(54906003)(107886003)(8676002)(5660300002)(316002)(66556008)(66476007)(55236004)(6506007)(52116002)(86362001)(36756003)(508600001)(66946007)(2906002)(26005)(7416002)(2616005)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RL3j5YivCK+8oTr99db0DVEsA8rvl0pigDIEwB9UdOt5LTE9qHHsN41vMyYU?=
 =?us-ascii?Q?gXUd3tYMLUI786KKEzlGd/nZN95ZlC18MyRjZlsOh/sktIQwWUKxHyLsKHe5?=
 =?us-ascii?Q?USImkP6e4028bKqNfyV+LS/7ZVxy4/CLherXJJ0h034QlEUO3VAk5QQQZ+K4?=
 =?us-ascii?Q?1OHY5dYFe0Hws7ssH0fOMDuC5AxDeK5Nbj/35yEiESQk+QKYvVHLduNtVjnQ?=
 =?us-ascii?Q?KkCfUfX7zVRlIsQnklFkAlfCOAemLwljXjCui/gA9PflIlww8fmjWMql06eB?=
 =?us-ascii?Q?ZOnmZWIg0LDPt6o40tWEx33rPMgPDsfK0DfTyqdeeeYChhe20ThJEf/KILZ+?=
 =?us-ascii?Q?nVq4JIZJUMWy9wqQXidXM+MI1Bp2J4qKDTjTRDMKF+kHOQKck/XcJA4n9z7D?=
 =?us-ascii?Q?/xV7lvYtA8KDaURR5EQCMsFAWArSVToasb0IyRNYKW9Uvk2EyHKg3GFIXZ8y?=
 =?us-ascii?Q?xp+yqBodSnatxuqvDm83E3e6HH7hFqkwTvZNZiy0+HW7MqKURrlQIMabmExl?=
 =?us-ascii?Q?rbwUUmOyi/VmhnhtrYHveHO1NidBW+j5K6sPNxJqOUyUMmYBfefxEVA/yeOG?=
 =?us-ascii?Q?kRAPaDcSAg0HY1+hgksKApFt8/X7m7uu8QTuP7+SU5iLc04BWJIAdtjgeBUq?=
 =?us-ascii?Q?lgcif7inAsfn8Pav1dPl1unxmxXtvTmaOQtmR5tHaHRsRHiSZ088OmNc7FAw?=
 =?us-ascii?Q?MaR6Q7l8gFBgwa0ZLMRxIUQegMoR2ftjdVXVM3d8TgmLbwBVhOzhHODQJR9w?=
 =?us-ascii?Q?9qxgKHu2pbloj606ychFLmwjPAjdLi+af3b137J5qQxHdnDOZbkcO6ew5/y4?=
 =?us-ascii?Q?Yc/lFBBJ7XBABVG0AXJED4NqdUx4xbO4m2d60DXTT0dKfU5mIhSbPInBgvPo?=
 =?us-ascii?Q?Zmj5fB0I6o0xZE0Vy0oq/ZBDupORsQP8yFGz92zeYu2D1A+UYpbtq+cJ2aKQ?=
 =?us-ascii?Q?orCLHNI5TGuMNFeA3NP/QLvCALx11YlWi/i/d35UnlTVapjd+O5oC6PgrFPB?=
 =?us-ascii?Q?zbMg9e1CAKpvYOuhLp04UKoS5RFeycsQy5ZIdXFt0Hs2mzPI8Ziu4CjnlNp2?=
 =?us-ascii?Q?LHJBDRHaG2YcrupnPlkyE8NsFEQGJq1+0yrIWfTMcbmsH11aXrBRURhS0LvQ?=
 =?us-ascii?Q?R9KqfEUjeRbsRsF7HkY3ggXezvHLbDrhqjKCUr+TWrZAridUpgSRPpxdoZ2W?=
 =?us-ascii?Q?B9OyQHxE4zM24TsYibM4FsUGB2buPD9xBN5N5SpfQm/7FpcDFVBl8ComvInd?=
 =?us-ascii?Q?lJLuIZ/UFxj7mlhK3YiEGJaWLhhuWzdzLUE8FYyQsXZE6KGEV+6nfBau6o+U?=
 =?us-ascii?Q?RDIR18pkUng1SRgRosmTmeEuf5llOr9WSG5dENH8TQmhZpyUdlShp1JxZGRV?=
 =?us-ascii?Q?8b2ZsDaFWHq+o37A116EXI3SCfN9bIBB6OVESP3BUt4rauvs5pWbpNy3DsN9?=
 =?us-ascii?Q?bQoZGw2jUGjRsrSYk0M7Api5cEaLOW4C3f82P8gYpJ3ol3D+AhCNoTs6NM/V?=
 =?us-ascii?Q?pDuqqUUHmwwgr0UBElrZ5BsP55FrJvD7GIEca4HoW6sMPjYSt+PhDm22n+vJ?=
 =?us-ascii?Q?EtLYJnK6TgD/vroFlp31Bn/DfRgO8I7wmBKAZ4UdvWzWwhoDWsZHwGh06hT0?=
 =?us-ascii?Q?e2j2abez4jGITCBwaNdL9gY=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18dea26d-aa6b-49d1-d31f-08d9d90a525c
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2022 16:07:40.6537
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4kGgxANfPrQRcD6+D2sohmWYxKQZJsHN0d/fq+mBx3mlTg883UUVz0t32SmvNIwekibc55cn0qynwFbzLXYqWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2597
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

PEP8 makes no specific recommendation about spaces preceding colons in
dictionary declarations, but all the code examples contained with it
declare dictionaries with a single space after the colon, and none
before.

Signed-off-by: Joel Holdsworth <jholdsworth@nvidia.com>
---
 git-p4.py | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 971ee52197..b542d47a03 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -4437,13 +4437,13 @@ def printUsage(commands):
 
 
 commands = {
-    "submit" : P4Submit,
-    "commit" : P4Submit,
-    "sync" : P4Sync,
-    "rebase" : P4Rebase,
-    "clone" : P4Clone,
-    "branches" : P4Branches,
-    "unshelve" : P4Unshelve,
+    "submit": P4Submit,
+    "commit": P4Submit,
+    "sync": P4Sync,
+    "rebase": P4Rebase,
+    "clone": P4Clone,
+    "branches": P4Branches,
+    "unshelve": P4Unshelve,
 }
 
 
-- 
2.34.1

