Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3013FC433EF
	for <git@archiver.kernel.org>; Tue,  4 Jan 2022 12:35:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233005AbiADMe7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Jan 2022 07:34:59 -0500
Received: from mail-mw2nam12on2050.outbound.protection.outlook.com ([40.107.244.50]:2528
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229502AbiADMe6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Jan 2022 07:34:58 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VhYu74PqKBUUHyraoAC13TV9B20ajnxaOpM6xvNOT0WeOmJEgxH3Smafrrllx85dn1i5LXiom91JTe3XcSqpD75cfl5TqR9/G7xbP8RtmtwoX46bp+aBMvuQWk4lNQLoaMmeiRPB9utSlRHaySh5hjzjfjQcXJ85D4N1QJCD4qBJLO1ycPuMmbliXqWWNF6fGJWPc3v3F4fE+3xp8Ox4+gp5QA8vDixJZRuzfTHMslD258/8BVNoOrGQ8GdRlljf8FaH+LYm9yoH5bt1WWFTdN3cXeJm+Ep38Wq3BVJhgJOSbsWra1xoDmZ2Fp6UvY486J7oiA9j+IR+SGsvPK/2Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/gU3MF7gGQYtV4aF8/ecE33bN7jRFtySedVwflNQ9jU=;
 b=VphClMQpc0FsxGMgNHzcJxpBflDKj4gvtiVI70vrg59POysbnANopA/BfKjdKyvr12CWsOWz4d7Y/XP/i+itRxXKgva3q8oqQb+1BECFOwKOOF7Liz54yuXFb4Nc9iNjeteDg/98ZcY5wY430RxsHq4fv21UgN/CBnpGfaFxZ/Wkn4Apnt102QvnFlkmZZLkT2cCCkESIgSnyh5o4PD3W5i9rFJltrZZ1YauEefFgzktHsz3y0w6fA5NPAAPI2JKEviRNzFS3xNOeGlN5kVY9oSo1q6UXl+/KMZTAIAn2dxmCqu1iw+WUSc8FRC8ikzE8dmMFtaGvDEfySInCq1dsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/gU3MF7gGQYtV4aF8/ecE33bN7jRFtySedVwflNQ9jU=;
 b=q08O9dWTWvoJ9kB4B3kJwSGFzF26V24wfQktJEaAch4ncKithjtT3v+mJNKd19wYMlIXZUGa2yEyk7sXNr3GiA7iC6c0uN4mUB+D948RF7LZjQHork4j8JMLV2y2Z3Kr5xwtZ7pXdrknHIMZviAmK7nDCpeQetTMnU6+CCzD2J4Du9meK66sVCnhKA8eKGJz/sX5M1ylB0bfM9PWph2tFQonLgr5VOMhIZkGz+WK/WIlZgwpq7x9x+UsU2A3e7JArqkUvayHn15Kug9mTJj4c2E8mTjdBgAorstcfbTimK1Xk9rEfNj8JJF4VlaC9HnystqK7S7kvhSmbekhBv0toQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB4849.namprd12.prod.outlook.com (2603:10b6:208:1c2::17)
 by BL0PR12MB4866.namprd12.prod.outlook.com (2603:10b6:208:1cf::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Tue, 4 Jan
 2022 12:34:57 +0000
Received: from BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::516f:3a1f:4951:ebd6]) by BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::516f:3a1f:4951:ebd6%5]) with mapi id 15.20.4844.016; Tue, 4 Jan 2022
 12:34:57 +0000
From:   Joel Holdsworth <jholdsworth@nvidia.com>
To:     git@vger.kernel.org
Cc:     Tzadik Vanderhoof <tzadik.vanderhoof@gmail.com>,
        Dorgon Chang <dorgonman@hotmail.com>,
        Joachim Kuebart <joachim.kuebart@gmail.com>,
        Daniel Levin <dendy.ua@gmail.com>,
        Luke Diamand <luke@diamand.org>,
        Ben Keene <seraphire@gmail.com>,
        Andrew Oakley <andrew@adoakley.name>,
        Joel Holdsworth <jholdsworth@nvidia.com>
Subject: [PATCH v3 RESEND 1/2] git-p4: remove "debug" verb
Date:   Tue,  4 Jan 2022 12:34:30 +0000
Message-Id: <20220104123431.1710-2-jholdsworth@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220104123431.1710-1-jholdsworth@nvidia.com>
References: <20220104123431.1710-1-jholdsworth@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS8P250CA0010.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:330::15) To BL0PR12MB4849.namprd12.prod.outlook.com
 (2603:10b6:208:1c2::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5aa47d29-879d-4f79-8981-08d9cf7e9ddf
X-MS-TrafficTypeDiagnostic: BL0PR12MB4866:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB48662E40E3DA7031812CBB87C84A9@BL0PR12MB4866.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3rXcdxvM9krIILGvfJ5tjJk4RB2VOvVCYHXvMDyM2jBXZLp4jz3sZOAnaSBO+YqQAGrwwKVAZUk6Lo0mqIGBv9vDInRCrXgR3VMbawJyMUKKptgvzxo+UQYrACHUB4kT63h2jj46MnX4pGdC7L8KZwJsbOCQTCMD7ZUISwOj/AQjxDOG7drHDwQV4pV9ulapzsT3ddJSdqU5Oje/HwGuu+QKtSq/OWHl4sGDjH7T4JzAnNsT9YKmt2GVPtBMx6Sd0oGX8XSTAlvnjorxu1pU1I/tg8kJD9CTmnBb8VZPxGCtEcjMuFcV+VhquTLS4OZBZa5PFCd9zq3TsWgIFmDn5JtOuoks7ruOvUayHISe6i+q9azLzzHhUuyBAR4+D+nlOWyP+MeDAJHpsNBakS75V3i6JHP+P8fW5y+EdZuiYcLwW+WKd+BXZhjlKjSop4fQoMtCc5ir/4BYZwhcCnh73OpBenQnZ//8ywIullo9VLa5nA0uB/7O6Ib94Wm4DNauQ+jRg9Vs3+kyiDpmmSrkM/IHeEyTNZtxLpkhSbSCd45Zn5qiUAxgZGUzcaQFYo7asJSyrcg/KBMA0qvxm+qayuY2u+Fa2QHekcoloZdN9dR3sABBnd8wY/OauDFdgZlv0ENIszfIRjicjxw1A5/yNfEEtsyWkwBntNOU/dMsNZ/Fy1odBu5lkQU96lIni0RM92jMW96RLFmt/3M9AzPrSA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(86362001)(55236004)(38350700002)(26005)(6666004)(508600001)(2616005)(8936002)(6916009)(8676002)(36756003)(38100700002)(1076003)(316002)(186003)(66946007)(83380400001)(6512007)(52116002)(5660300002)(4326008)(66476007)(6486002)(6506007)(54906003)(107886003)(66556008)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MbXFb+jwEZqytUw+qXZQzXKAnia6bNopNJXsTW+5wfzal370Pn0WZ6Al09YF?=
 =?us-ascii?Q?TIrd68RI7cVNy8WThSZ+D0fepPtJGtD82MicTknoBHHEYm4MFLwsW5iZwEH1?=
 =?us-ascii?Q?rPjHTKpUOwc0/Jwkti5Q/6Ii66oFWdSWoa1piRkmmgyxD7H91FbilHydghsu?=
 =?us-ascii?Q?/fWbxY/KoNRaHWGIquhW2vCjPeaOCT6y7WG2rpsdRL62Z7WcgoKT4Vl0yY60?=
 =?us-ascii?Q?vBIgqPQG0uhrZJjbpYXU2qYxdwEVJEae7QhN7RnN0IyEmQ/qNvblrqFQEmLk?=
 =?us-ascii?Q?W8I48MifPZjOmLISVeH7C64/mqo9JtmGflwSp1X79uKBadqj+skvd/W45fLb?=
 =?us-ascii?Q?cwwuOxzUFi3DRLzrCGipWozRdL5hygeALOFTNS3l9J9CiE+5KgdjMknpz9J/?=
 =?us-ascii?Q?Zz4ES4R3zio4eMr7wfw648t6pi5mW6SqomtSt5Nr43YCa1RR82eme/L8f0xg?=
 =?us-ascii?Q?WHhRfY6CQctPcW1C3KXXqLOrly4JEt3511Xb9Oq3+JcIWCyFx3St+chmsUPa?=
 =?us-ascii?Q?laHSci1vQ43bg2nmli8XtA956nk0YIwzrxeUHeLJzteIgTfTX3aseX67fFp/?=
 =?us-ascii?Q?q49saqeI6NlprHC4oSZBXUpK2Z5VugW5jbOawF6XN3dDx/wIMMjVjDxoWvNW?=
 =?us-ascii?Q?kHTsrsyE2X99HpQA1vt9DhxwjbT5NTPiEQdoQ/kxRKjYdcXNLqNGB91zzyZe?=
 =?us-ascii?Q?NILiO5PdBK4TaKA4u2oH7tsj6Q3ognf6gDq7RDA5L8NYkgscghBSc8B8/X5u?=
 =?us-ascii?Q?YUqtVMHI6sPI09E+dUL5nXSwkawfiH+EVkDnAISlMDk8vt6+9NK46hxfufCH?=
 =?us-ascii?Q?O2zgeENRxkGGEu0KK4ZKiwYMvsQxppzStYggfPGgJR8gDjaKxrRGtyoZMLBc?=
 =?us-ascii?Q?X4v6FSx1xwEHrSQFmQPq3KvOzlU/zmBcErty7HDYFS2592Uq/V3ZxPQ01skk?=
 =?us-ascii?Q?iXDrIs0IwsSmTpGo38bhrZJdSy4Mq2h6/3NhY5nzATffyV67gir6TNkNCRKz?=
 =?us-ascii?Q?g/UWLnEnukOjbgvk9J3fqxb8g4bQYpqgrBBQGtkRNGCbmv+u7mUeT3UXpsLV?=
 =?us-ascii?Q?usKTDA9Hcjshs4LgcS/zDq4bOKeonLmM/pZYGUPZx2yBUJ80ioqZyqo0haDK?=
 =?us-ascii?Q?B8j+fS0CWhFki/xBIlYGgy2AMIhX+7d5E3CKn5S6GedHKEkf8VuezFi8CfTm?=
 =?us-ascii?Q?4ikCAt7C+GB8gzhV17ctAeNzuDNAuUc79w10eAgZ/kEGwFtm3uy+/BbNHCQ7?=
 =?us-ascii?Q?WVYzU9q2Njk7EDv5G/hHS2olrrCRBKtGtOswxVyj5dbK+aNjDprRumLwL36d?=
 =?us-ascii?Q?6W0qT8qXdWiMbHjkPgf10xuKJTCd6HaVesNRraz6+Yi6WKWSmtKzyOX3OyuH?=
 =?us-ascii?Q?qrV3pMFWI/QN92gNolKuc9OH74Yj1LXRiCM0T1Qaps/ASPGGjdBk9LPAkjv5?=
 =?us-ascii?Q?vmorVNa+e5iJwKCWlkUxcovMQZ3kxbGQGk7eJYWdPk1JHQhFNeDSIpt3Hlox?=
 =?us-ascii?Q?6878CVETytWKQ+1PHiw64VtGWjUWnZrgroNKGVxe+jrT4pax9STeQaptLalq?=
 =?us-ascii?Q?qxRkJziJCXa9Ro0eTXYIwYQXLzrKZy4tLzR/U4Q25T3k51ESOopiO6yVhgjP?=
 =?us-ascii?Q?PhRGi+ocQiJD9XYKPgQ2XO8=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5aa47d29-879d-4f79-8981-08d9cf7e9ddf
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2022 12:34:57.3324
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3ZVGbNrhDidaWG5lKLz76/+qz0PSpKrTyb/ljF4lvFVYrv96Q8ACImd027KI/81t/LVdowVd8hpcXuXdVypQjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4866
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The git-p4 "debug" verb is described as "A tool to debug the output of
p4 -G".

The verb is not documented in any detail, but implements a function
which executes an arbitrary p4 command with the -G flag, which causes
perforce to format all output as marshalled Python dictionary objects.

The verb was implemented early in the history of git-p4, and may once
have served a useful purpose to the authors in the early stages of
development. However, the "debug" verb is no longer being used by the
current developers (and users) of git-p4, and whatever purpose the verb
previously offered is easily replaced by invoking p4 directly.

This patch therefore removes the verb from git-p4.

Signed-off-by: Joel Holdsworth <jholdsworth@nvidia.com>
---
 git-p4.py | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 2b4500226a..b7ed8e41ff 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -1532,21 +1532,6 @@ def loadUserMapFromCache(self):
         except IOError:
             self.getUserMapFromPerforceServer()
 
-class P4Debug(Command):
-    def __init__(self):
-        Command.__init__(self)
-        self.options = []
-        self.description = "A tool to debug the output of p4 -G."
-        self.needsGit = False
-
-    def run(self, args):
-        j = 0
-        for output in p4CmdList(args):
-            print('Element: %d' % j)
-            j += 1
-            print(output)
-        return True
-
 class P4RollBack(Command):
     def __init__(self):
         Command.__init__(self)
@@ -4363,7 +4348,6 @@ def printUsage(commands):
     print("")
 
 commands = {
-    "debug" : P4Debug,
     "submit" : P4Submit,
     "commit" : P4Submit,
     "sync" : P4Sync,
-- 
2.34.1

