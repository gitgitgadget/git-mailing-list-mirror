Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20709C433F5
	for <git@archiver.kernel.org>; Wed, 12 Jan 2022 13:49:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353713AbiALNt0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Jan 2022 08:49:26 -0500
Received: from mail-dm6nam12on2043.outbound.protection.outlook.com ([40.107.243.43]:52832
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236601AbiALNr6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jan 2022 08:47:58 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jtRoe4Uc00nEJjcr2+XYnVxKd69eyqamzGfROKSZ2x+57bFspse3ZQi5H1ifTA2vNz+q6JgZ4ghLFuuX0l9t78zN4oQx2dIRrRNzER6STyt4T/gWQNwRyEopx4IRlxXHuAKi/nhnARGBH7Q9h8g6tcmeumEqdFlzNe5EIzAxnE6aQBGXMz/YumPn7+8rofbvRLUBaMTB3LOkYNL8foDgSppFSSfyho9dNaj1v4Ixnp33ZUHWIyj3P/YRjxRPceEN1GLhX75aLfq6jjq5p8t8Q9++Exrc8rTYCbdKbp4ViKHzmnGY13KvNjMwq3xhHp1G3sLlIyKSVwSi2LyMVohXAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OdVU2WZkaABXu3nYmQ/eXg9L3hO08QKQLjegoiBU6o4=;
 b=HuHiupCcfZi6Zs/U7Yea7rgirkkuBvT+M6FOZjhhKd7Z027jLAQPzuOj90iG0H8en7oeKYtKrMxYPwXGlDYNXswa0Etc1/Qxv7OqJZ8lAh614qTTB/FlUjAvjeeWKi3gRhr1LC5bPYh+5rLyBtKMDpS041qbSucmf1LOz4Ra0Canx89/YDwZ2D8gJR01ftb2xG9TCSpzB92/AGg6L7/3+KLhd1i6nsLdYWSODf7KcvwRrlSj2qij1Js39XwCq9AvNszSlo/8eQ28tYWSp/me7klm55Rbx1pth+u7VFDQCLS6aZ8DItrqTKYhkxtv7N0m0QlyHuKUiu41/vaUbFhw4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OdVU2WZkaABXu3nYmQ/eXg9L3hO08QKQLjegoiBU6o4=;
 b=BEKOK6jVK7iyQjlLpFmFymrnQ2HHZX2g8WOVBLNPckpgJFeM9gz9iaZyLeXrI+XZ7w5IkAD2ndsakIaSon6HsRqPrm7B7/GLsJYpvkpdUK5G8qHXtSX2se7jbBbnKp0hapTIPQHTzXe6TOcLi1wzQf2zddohoFs3l9hsXaQJS3ECxHKy54iLucOv5D9L/X108DQ51UehEbwtxNe8rPeomBz5vxxVzRAVPfRaHbMyUAUYjwingZ8gXWfun7j+F9s8y9ORB2enhw8x/CLoUdXYQC7EthFO0z5uq6Xo1/xkJ/+iSBjG+rQSeXtUI+TtMa9kaY6hrpgmm+EKVPfRCniPwQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB4849.namprd12.prod.outlook.com (2603:10b6:208:1c2::17)
 by DM5PR12MB1594.namprd12.prod.outlook.com (2603:10b6:4:e::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4867.11; Wed, 12 Jan 2022 13:47:30 +0000
Received: from BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::509e:bbb9:e1fb:26ed]) by BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::509e:bbb9:e1fb:26ed%4]) with mapi id 15.20.4888.010; Wed, 12 Jan 2022
 13:47:30 +0000
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
Subject: [PATCH 11/20] git-p4: remove extraneous spaces before function arguments
Date:   Wed, 12 Jan 2022 13:46:26 +0000
Message-Id: <20220112134635.177877-12-jholdsworth@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220112134635.177877-1-jholdsworth@nvidia.com>
References: <20220112134635.177877-1-jholdsworth@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM3PR04CA0137.eurprd04.prod.outlook.com (2603:10a6:207::21)
 To BL0PR12MB4849.namprd12.prod.outlook.com (2603:10b6:208:1c2::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7d819d2b-3536-4e64-f47b-08d9d5d213e7
X-MS-TrafficTypeDiagnostic: DM5PR12MB1594:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB1594917B60DF48748CF2C8E2C8529@DM5PR12MB1594.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mTrAEBvcoDU+dCDN0/2MUTlszhXC/yNFuTdzK6PjoTSr87b0wKhTrY19uhVoSgpPS/Ij2URKzK1Uf7Ztjh2nWCdZZa3lzylkB4oJe7h1Afy6X/jwQTZj0gQZdMj2yRgXShfw7x9CCgTtx1vdUvQypQsE8N57owpV7IuwtAWJvsd1Oz+ZYm2JCL/SkyZqqLgzWLGs0HLYFDmQJqYvD/8QYEBTW2rwaxrtREca23YpPBRbPcoVLi1UxDn7kHLYzNSFGxVp0dd0AclaVnx018zJW3K20W29N+iRCQuevBj1HBmo2ubpjlI6Hy6cuyh5TaVyZASJ+EE7dc8BEYmn7b/y3L9f1iAqac/947gw2XZDK6dnLw6ueS5XzRPiMoBwVB0GAUS8XlZkxLqf+71mQ3x4FFbz8PzRnMHJRCdiLfB680f2pXEBCjOvTurLJ5EHhcBbFUySv5bWabvvZ79BziSdUUsiUPVnaP9BnlppNonFMqj1PeFjPbo/wy7U2WN2E+pfVsX6e1K4+qUGmok6wgTmdkt+FqIVyetDIe7muWjlhtsy/JUbRdiMeSXJnlFvKlOnyDdMUTjmsROzpTGw4TXrs9IQ61XEt+UcL0Pj2Zb21fOAx2L7JFFuNNSEKCe1aqfXfd/WY1Vp1CBC65uVEccueapi3hfFC+2YWcLYH6+dKgla6bsi1U/xF5YmLJM7DjVW6fWiY0vEqRbdCgLIAGDh67WdCE82cbdFKaV58Tmp950Lm4iVHnCWBaXCeIQaJRusPePngfhPcC75k4QldDisUupba3oVWCv5S3eVyIRPMls=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6486002)(5660300002)(1076003)(26005)(38350700002)(2616005)(55236004)(186003)(54906003)(66946007)(52116002)(38100700002)(6666004)(8936002)(7416002)(83380400001)(8676002)(107886003)(66476007)(6512007)(508600001)(36756003)(316002)(86362001)(6506007)(2906002)(4326008)(110136005)(66556008)(966005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?t7DkBDJlqmxmtUj/0sPZ4UhWgqgYVdMK5c85De++hrAt5uSDuqLBYdM3IsHk?=
 =?us-ascii?Q?sr42eWLzSX3/BzkcFdmT4V44NceZEy6c2VRSQ8pPJZAq7pizRZOLU6cFfnCG?=
 =?us-ascii?Q?k74Y2xlMkQrkGlDVZQURC3yqPf+5da3GN6wS0495Ottp1+eDBlm1Ug7Bxb0Q?=
 =?us-ascii?Q?m9n20oQJBAHKepZTHqb5E93g45UHsaRKKZK9QEWjWj4hhmE38qtmFymlBLZX?=
 =?us-ascii?Q?wgFhQNmNYD4FCh78mi5Yn3Oca3MAVX0pK32Em+6maVW59oG/gh7HyoWoIYb5?=
 =?us-ascii?Q?DoL07RCmCjVvpInXMtqVwW+D1zad86z8U3/t+g3jP3/nDzX4g1gb/AGtm8+b?=
 =?us-ascii?Q?/F7ZLX/GSaayHnVsG8zdchHPnGA+sZorDUE8Fq9JMpuGDQ2ooJXHn3soVKUV?=
 =?us-ascii?Q?zHFa7oLW0tq6F7ipeCp5quQJVpFl5aBVEL8h1MJfjxg5+qZ8C37nAOUVUPtj?=
 =?us-ascii?Q?bFQBHty/U1t85iFFjK+ilStFn+3WgeL6AnLS2bE3HBXA0t4udeFF/KIbexhO?=
 =?us-ascii?Q?VPaLChAQtGbslwMbdqoGrzGIN6c+VFKI3tWxT+TVi00i+Ut5bBcj2d/jihCD?=
 =?us-ascii?Q?Kd+aCE7vvJpabkpcooxZc9c1LTHzRzZDHdZ3D9kbNMHO1n5ZZhLXbXuzNxyD?=
 =?us-ascii?Q?/cS+KIy8h25HivNqz+LwUIaXH7/QKijXNE6W83F3lOOkmcdfEWIikFs7JqRm?=
 =?us-ascii?Q?BWbTj1VAskYjaT2jI8Q11bm7HtVdFtLtTrRSQA8vIsIdwX1P5jS2sJTF5Wn8?=
 =?us-ascii?Q?y537btm2RYduTJLkx8zMsy2+3tvsMrpOV6T5Dnr8anvkg+wW8xCEvLo0KiSJ?=
 =?us-ascii?Q?imqvC873K7bySmLa8jTnKlO5dJDnF0RvHEftafnOBggIf4GuVWNWgENf6P9W?=
 =?us-ascii?Q?HgR/MOVGCnsIKtseRvOFTCrfAxE//wzzdJZBfjmg1sWjiivRbOQfa6qdgFRk?=
 =?us-ascii?Q?9o2hVACph5et5F6kHL53aYuTgJcuddxnOBr2mJz94b8zNi0ehiZItL6V0Tzv?=
 =?us-ascii?Q?UMyWjHqo4KfMLI64lSeQB4C5usLHm6u7C6zAH8iuQHTsQeiDyM/5pUd6KiDp?=
 =?us-ascii?Q?CZtq3Tj+KxVfs70zw0G+/A+/W5Om2NlbfTFOmybZvQgfla9piUPMnFLSuX6P?=
 =?us-ascii?Q?M8WUyzL3WFo/qtG37xDCLVYnbNY9gMc/dW7NwT+M6gjFR+nqLIKJP1yjWpkE?=
 =?us-ascii?Q?U1WS8/94k25Dn/zZou5T5TizOGCCf2fdzTibkSO/Sj3U6mONGEaq283DCNcP?=
 =?us-ascii?Q?TuUbjA2ugg/+dMshoI4S4PoCwByVS7Zk6DFp7diPuoyAXayL5GFN9M1CT1FW?=
 =?us-ascii?Q?YS+3SdIFe60nE70FSizoDd4wg0LoSfK67KeOz1bIVRzi7oD0LrIe2MmPf+rM?=
 =?us-ascii?Q?O3l5gEEtvjbYS0qil+nyGtlF8UzF6gwfNUqxo5u9HUROCNdUm0Yzaeai59SJ?=
 =?us-ascii?Q?SL0wAvcVoO+I1EPcaGqNoE6YDx+n5RvccbFj9pWtuldps3RogOjguOAe/QLx?=
 =?us-ascii?Q?C4hidRajxh1yQVGJQduvFt5xCoGV7m5jB5afz3wK5MHpYe2mjIC9PV0C9WxO?=
 =?us-ascii?Q?NDRyJrIX+U12ICw8E4Tt4qRI4TQOglryF1x1u5U2W/o/bGOLFCCl+mMEs6+Q?=
 =?us-ascii?Q?pNmiXyaGjgNf4so2aY4MdQw=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d819d2b-3536-4e64-f47b-08d9d5d213e7
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2022 13:47:30.4390
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k0E7wIQXB7hXqjE5bdGT3KvYhjOFibpITv0CekFxeSVUS8hrdN9TtnlOqQD99XfIAQ6xKYuNSz/4F1bTRhQ6UA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1594
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

PEP8 recommends that there should be no spaces before function arguments
in the in the "Pet Peeves" section:

https://www.python.org/dev/peps/pep-0008/#pet-peeves

Signed-off-by: Joel Holdsworth <jholdsworth@nvidia.com>
---
 git-p4.py | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 0e54be57b3..f7b6df104f 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -984,16 +984,16 @@ def extractSettingsGitLog(log):
     values = {}
     for line in log.split("\n"):
         line = line.strip()
-        m = re.search (r"^ *\[git-p4: (.*)\]$", line)
+        m = re.search(r"^ *\[git-p4: (.*)\]$", line)
         if not m:
             continue
 
-        assignments = m.group(1).split (':')
+        assignments = m.group(1).split(':')
         for a in assignments:
-            vals = a.split ('=')
+            vals = a.split('=')
             key = vals[0].strip()
-            val = ('='.join (vals[1:])).strip()
-            if val.endswith ('\"') and val.startswith('"'):
+            val = ('='.join(vals[1:])).strip()
+            if val.endswith('\"') and val.startswith('"'):
                 val = val[1:-1]
 
             values[key] = val
@@ -2347,9 +2347,9 @@ def applyCommit(self, id):
             # Revert changes if we skip this patch
             if not submitted or self.shelve:
                 if self.shelve:
-                    print ("Reverting shelved files.")
+                    print("Reverting shelved files.")
                 else:
-                    print ("Submission cancelled, undoing p4 changes.")
+                    print("Submission cancelled, undoing p4 changes.")
                 sys.stdout.flush()
                 for f in editedFiles | filesToDelete:
                     p4_revert(f)
@@ -4018,7 +4018,7 @@ def run(self, args):
                                     i = i - 1
                                     break
 
-                            paths.append ("/".join(cur_list[:i + 1]))
+                            paths.append("/".join(cur_list[:i + 1]))
 
                         self.previousDepotPaths = paths
 
@@ -4047,8 +4047,8 @@ def run(self, args):
         else:
             if self.depotPaths and self.depotPaths != args:
                 print("previous import used depot path %s and now %s was specified. "
-                       "This doesn't work!" % (' '.join (self.depotPaths),
-                                               ' '.join (args)))
+                       "This doesn't work!" % (' '.join(self.depotPaths),
+                                               ' '.join(args)))
                 sys.exit(1)
 
             self.depotPaths = sorted(args)
@@ -4088,7 +4088,7 @@ def run(self, args):
                 if len(self.changesFile) == 0:
                     revision = "#head"
 
-            p = re.sub ("\.\.\.$", "", p)
+            p = re.sub("\.\.\.$", "", p)
             if not p.endswith("/"):
                 p += "/"
 
-- 
2.34.1

