Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A800C433EF
	for <git@archiver.kernel.org>; Tue,  4 Jan 2022 12:43:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233103AbiADMni (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Jan 2022 07:43:38 -0500
Received: from mail-sn1anam02on2060.outbound.protection.outlook.com ([40.107.96.60]:49798
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233080AbiADMnh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Jan 2022 07:43:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XoYDDFl5QCfoXUHoYULOMqbwyaFuDUQyGFh5jKp/mbbqvaiQI44p1izbnWIv7EexEDRtfIA8yTnGu4hFtFqKdm32zy6GiMO7s813ikxCXi7e03aweOKdYGamkdAm5T1h0oBzldG6HGebiqaFGvLVOht/Uv9p/c8NNfcoi9gsI9jklmvK5mGwXtvUg35edGQWhLGpW1PXpKjs+a4hbmJekn+QfKhLuL6HMYVgxe8JKGKk51rdpn8cp300FRCwWNjsm/olsTKUcE3br7zrKKyg54CJodh/kZI5bakpYJVNLAcc0ASGstKfNqUejhWKqOKV/2aU3o6kHkNeg5VMZP7vGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZeKxFTbwMPGG1VXa7CBQw6XWvqJP7t36n9pbClpDl3Q=;
 b=lyh2AJkbCKnr0U6BcnMLysFmr088oM6IMm0N4TmWezYIikgv3T+aQdXAJRAd+WpxtcrSa0ARcdPRFBgKfjZemSxu2g8lIe8coer6NaZZkFv3A7oEhREDQC2UE4+pKcLVQzc/Aw+gFYCHNPn2e9C1cGhRemPf9kkrb6Uac87Sz85swvvZJfk2FK39iWv1omRRyOLYQROl+y2Jfccr0GhR4m2rDArxn3BURuw544DtL66g2olUdX60+SD2BTLjlQg8mLJ8VPTGbEF2bpjLa0sWLr6Srx6Aj8W1Of78XcvpWtMoXTVRAYg2sBiekYoOWb9dBxni7LlOJOaSQVtiLbeVBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZeKxFTbwMPGG1VXa7CBQw6XWvqJP7t36n9pbClpDl3Q=;
 b=iyqPePbADFNEtVpM0a+Is0FywvZ2HKm/DHrWomCPVryz8XhN3DpxkwPwa3mPhXtxzbieyrMxWQ7Obh5x0eMY6P0E2yr3+a2DAfUAdxlrefzlKaLR9lsj8BEFny9MZQvDex7RpatIzsPgFYZ+/AWrQkfY0FvyGOuLZap7OBUDEVPIwLphtqnQ27PSMrl667kMPDd9zkEaR18vn0nKEftW09wKONv0USqjFAmKgtsAfR9ABsoXzOJywYcmQbBfrIjDOwhJY1LXd5ANtQcDwffj8TF1inMyDNlPdFJ73uy9HuDtUSXANBCXMYGsvbwaXtL9L6VsBcNTQYJBxAcQ42+gbQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB4849.namprd12.prod.outlook.com (2603:10b6:208:1c2::17)
 by MN2PR12MB4344.namprd12.prod.outlook.com (2603:10b6:208:26e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.14; Tue, 4 Jan
 2022 12:43:33 +0000
Received: from BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::516f:3a1f:4951:ebd6]) by BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::516f:3a1f:4951:ebd6%5]) with mapi id 15.20.4844.016; Tue, 4 Jan 2022
 12:43:33 +0000
From:   Joel Holdsworth <jholdsworth@nvidia.com>
To:     git@vger.kernel.org, Luke Diamand <luke@diamand.org>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Tzadik Vanderhoof <tzadik.vanderhoof@gmail.com>,
        Dorgon Chang <dorgonman@hotmail.com>,
        Joachim Kuebart <joachim.kuebart@gmail.com>,
        Daniel Levin <dendy.ua@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Ben Keene <seraphire@gmail.com>,
        Andrew Oakley <andrew@adoakley.name>,
        Joel Holdsworth <jholdsworth@nvidia.com>
Subject: [PATCH v3 1/2] git-p4: print size values in appropriate units
Date:   Tue,  4 Jan 2022 12:43:06 +0000
Message-Id: <20220104124307.2524-2-jholdsworth@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220104124307.2524-1-jholdsworth@nvidia.com>
References: <20220104124307.2524-1-jholdsworth@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS8PR04CA0184.eurprd04.prod.outlook.com
 (2603:10a6:20b:2f3::9) To BL0PR12MB4849.namprd12.prod.outlook.com
 (2603:10b6:208:1c2::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 97a311ab-f572-48d9-5951-08d9cf7fd190
X-MS-TrafficTypeDiagnostic: MN2PR12MB4344:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB4344E401C84B7F28A1B8E6F2C84A9@MN2PR12MB4344.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EI50/OE4PNWX6/83jsbaeWunBR/GQLjj6I2DwUej9qdzkuGDw6RBZooftwvbBlTG3MgV9COeRArWPKXw81dJQCTdN52KHHZXwPSW9nJgCu3FdRIwSaojaCwYUwWJnq3S/aBd23GIGfsD8zc5ryU5gNX5LdywNfMlATapJ/pyo5m48DUzrmf44wfFZNJnSxB/3O9juUrtLjZCJEkbNow+NQLwBL23yOi3fbteenHISKp5jkwJEQw7fWcXd+kpbVuy43YH3TkxCnjC2Bliwa9asXRkNrdOtl/u4zeOsZ0SZHvsucmlYuQpvFeF9ok9mHIv7Hc0f5cU261qBCsR1ZYZuhPjHLiI7Rll0978X56fmsWD1epgIrsvrHKE0EbrfA1RUklVJfkdHD9xXU1AJiH5FN0ymSM2mwz35RDG+hb4CBPz6CmD/1Qvuz/ZMPLoK/foke1yMKy84tZT6isMd75//hxNEDJJ5B3xphzauc7/mO+FdldfaJdX2dD9/XBNc/WGoJ/2N7z1MFw0iNgLXBjaiBbBQ9XAnRpdYe1TFMlYmGBZS6pxWjFO915zuUALD6BgrPu1RtbCqnRH+4gAM4paSOrgg711lVZkkVzAX1lVaS8R+SqUSsti2qvs0XMH2Qy26EcD2IRn9VGJ3LTIRl88+52xuE6qE0biamIMwJ/P9ZVbwvti6Kqtg65QsYZY4ps8Hr+bSaGWitr1JdXQBkLS1Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(107886003)(66476007)(110136005)(36756003)(508600001)(2616005)(8936002)(8676002)(66946007)(66556008)(7416002)(2906002)(38100700002)(83380400001)(6486002)(316002)(186003)(55236004)(52116002)(6666004)(6506007)(6512007)(5660300002)(38350700002)(4326008)(86362001)(54906003)(26005)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5zRzUfVCo+JZMIjbup7NuA8DluKIGFG97sbmvFu1L0bwYPLOVqvFrTbJ3SAk?=
 =?us-ascii?Q?vSPumtABMqu1/cEDiI5N6+kA98iWLZUw8ZTwB9qATyJ97YWBJlUByC+xUYvf?=
 =?us-ascii?Q?j59UhSEHVzUQ7QdqwdAOa0kGF2tWMP8SEA0AFghuwbefitCJKazsvcZvlrNz?=
 =?us-ascii?Q?gF6aRlsi2Aiphz+D2BDOUvNhNh17BnaJ4GqGiAP346JPzAOB+HqOyM1nO7YG?=
 =?us-ascii?Q?rzDWZtnVQxU+v4F3b9cjIyyKLCIPQ/icGtSpeJ9uQnbzIXS9uqmoki6tORbw?=
 =?us-ascii?Q?RBa+POIbW6GRkhBkq/GGitKXhEXRhmG7haHiqaTwjT2xCHa92UKUK2ZlMQZ7?=
 =?us-ascii?Q?4jjGu2Rsra3ih0NZuKpDAEBt3sX+iy3pJlJwNUUvSm+3SLBdEigKo0nT4gqH?=
 =?us-ascii?Q?x9sS7aHSed3bhnBhSk8ozkjQNVS59Emsl9JxRnRCF2aTzxByWqXTvkgs2D5U?=
 =?us-ascii?Q?G2J1eCanglU51nJgF1YgW7cUEf3r6kOKnBjrPpthagdX6fe7glIrO5F6ERTW?=
 =?us-ascii?Q?xNV1qJcN5syGXxVjkvY6syTRfXYZOqUnbKvBAv93u4XhJaUO6Q4tCJFJ8uAp?=
 =?us-ascii?Q?giv+pZz1lV00n73dP/pF4GeZDagHgQr717dncNqAdeXmisXZVHENbJeNakc3?=
 =?us-ascii?Q?S4tu95exg5jirSHOPJdLrMj4uN5GGG3q2kkf48l6tQ4RDoXn4vuUHz+2NBgY?=
 =?us-ascii?Q?34/r9MrTna+xSGgtH+2e3XRKTwZ3iwMsbCrszOJtAR2WqhL4okJtOOmNI6z7?=
 =?us-ascii?Q?HMEPOQ78GGveKSRSMWyS1PYPJqIYYubDqWmzs0k/YIckiPjvuwKOAm/LazZm?=
 =?us-ascii?Q?rVf2uw3u4wDYEBldEGVRlgpovFNEug4WTBMyrD35+hjpzvQG/yALL8soETcp?=
 =?us-ascii?Q?dpxWG3ewAfks8JK+isDSVMdo4c4k4XUR+pwgRw9mZdndoe6r2ODbBCErEu0H?=
 =?us-ascii?Q?x67cDEQmgo/se9mtlT2RR/S65I8U1SYTB9cVPzayxleGfps9nvchD2eljXG9?=
 =?us-ascii?Q?BGmAy/AKk8xW09ij0Dr4LIZcRDfMsFJnwlc9N6i5ECVHBoHcJ6hvdxy802Um?=
 =?us-ascii?Q?S8CLzbQU0k6R26begXNKhJ2+5pRKBS6PSyGAs3/dhjrIhfyzxNzGeZd5IP2E?=
 =?us-ascii?Q?gA0IieTx42D/Ev5PP6ANUJM0ux4y2AFvAHkU+GTVaGKI85PwF6sx8HXWQuhh?=
 =?us-ascii?Q?3Y8YcA3tREpgs4arLEJShEgol75+ZCRru5stfpVQKeS2d+TDp6W5Am4Y8fjQ?=
 =?us-ascii?Q?wclL78XEIMg9OYOrnhW9e47y5Oo7slx39f8eFAqF6ODh7H4Yux1O+FM/kkje?=
 =?us-ascii?Q?WetEHcxYFqFkxcrIeOpPNwVakN/IzYO64M+0GZjyOTWrg8UK7wvtMbW+55fr?=
 =?us-ascii?Q?dCL1HZlKpBQ8pkQfsIcIIpxYkhjo0OQSlUr3QxqsBO98m9IxWwfl3Sed3TEG?=
 =?us-ascii?Q?PeHHbtotskCQFqHLP5LbKAKy/QLEVm+/symaRhRqgk3NhSP6wYOV+4MOmEN+?=
 =?us-ascii?Q?MQ3sk3X+ZS0m7Kl4Yd+WxlONcHzLfrNtWW8fl72uFg9/1iE/frSof5+/T2VY?=
 =?us-ascii?Q?plPm8l2qk9v93QuY2Lwn4mjYRsH+XyNwMHNPVyU/x/7NpPSXk16bxJJkQPrS?=
 =?us-ascii?Q?q9uncAHXG87pmi3KCX1Pfcg=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97a311ab-f572-48d9-5951-08d9cf7fd190
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2022 12:43:33.4580
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BtK4zZkC/Y5IYO+8ddKbchpBEpky4JIRp3pz+x28PLKFNju6z3xqA1sYBc+slw77BAI3OPi+Lpr8mh6/eTBzBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4344
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The git-p4 script reports file sizes in various log messages.
Previously, in each case the script would print them as the number of
bytes divided by 1048576 i.e. the size in mebibytes, rounded down to an
integer.  This resulted in small files being described as having a size
of "0 MB".

This patch replaces the existing behaviour with a new helper function:
format_size_human_readable, which takes a number of bytes (or any other
quantity), and computes the appropriate prefix to use: none, Ki, Mi, Gi,
Ti, Pi, Ei, Zi, Yi.

For example, a size of 123456 will now be printed as "120.6 KiB" greatly
improving the readability of the log output.

Large valued prefixes such as pebi, exbi, zebi and yobi are included for
completeness, though they not expected to appear in any real-world
Perforce repository!

Signed-off-by: Joel Holdsworth <jholdsworth@nvidia.com>
---
 git-p4.py | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 2b4500226a..74834736fa 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -56,6 +56,18 @@
 
 p4_access_checked = False
 
+def format_size_human_readable(num):
+    """ Returns a number of units (typically bytes) formatted as a human-readable
+        string.
+    """
+    if num < 1024:
+        return '{:d} B'.format(num)
+    for unit in ["Ki", "Mi", "Gi", "Ti", "Pi", "Ei", "Zi"]:
+        num /= 1024.0
+        if num < 1024.0:
+            return "{:3.1f} {}B".format(num, unit)
+    return "{:.1f} YiB".format(num)
+
 def p4_build_cmd(cmd):
     """Build a suitable p4 command line.
 
@@ -2966,7 +2978,8 @@ def streamOneP4File(self, file, contents):
                 size = int(self.stream_file['fileSize'])
             else:
                 size = 0 # deleted files don't get a fileSize apparently
-            sys.stdout.write('\r%s --> %s (%i MB)\n' % (file_path, relPath, size/1024/1024))
+            sys.stdout.write('\r%s --> %s (%s)\n' % (
+                file_path, relPath, format_size_human_readable(size)))
             sys.stdout.flush()
 
         (type_base, type_mods) = split_p4_type(file["type"])
@@ -3064,9 +3077,8 @@ def streamP4FilesCb(self, marshalled):
         if not err and 'fileSize' in self.stream_file:
             required_bytes = int((4 * int(self.stream_file["fileSize"])) - calcDiskFree())
             if required_bytes > 0:
-                err = 'Not enough space left on %s! Free at least %i MB.' % (
-                    os.getcwd(), required_bytes/1024/1024
-                )
+                err = 'Not enough space left on %s! Free at least %s.' % (
+                    os.getcwd(), format_size_human_readable(required_bytes))
 
         if err:
             f = None
@@ -3110,7 +3122,9 @@ def streamP4FilesCb(self, marshalled):
             size = int(self.stream_file["fileSize"])
             if size > 0:
                 progress = 100*self.stream_file['streamContentSize']/size
-                sys.stdout.write('\r%s %d%% (%i MB)' % (self.stream_file['depotFile'], progress, int(size/1024/1024)))
+                sys.stdout.write('\r%s %d%% (%s)' % (
+                    self.stream_file['depotFile'], progress,
+                    format_size_human_readable(size)))
                 sys.stdout.flush()
 
         self.stream_have_file_info = True
-- 
2.34.1

