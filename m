Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D1CFC433F5
	for <git@archiver.kernel.org>; Thu, 10 Feb 2022 16:47:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244697AbiBJQr0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Feb 2022 11:47:26 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244710AbiBJQrR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Feb 2022 11:47:17 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2046.outbound.protection.outlook.com [40.107.223.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EBD0192
        for <git@vger.kernel.org>; Thu, 10 Feb 2022 08:47:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E+5VSU+yiSOv2URmi69wa5AEPPMHPnyPKWt4RYm+5B8p1yfaSgMMLR2546r/REAKAPT0bdSdw1hhRX+Ea1M63aRL4ppeYKKEtY5tlxRsuRyFqFDHpAkkmpbof4L2coy1GegxK5omM2ayLw09K+6NBxlfESYZlXPHP5mbejjiWzeAtwkyQCTe5IB9n+ky3cP0dlgrgyUn39TD2h91fZZHUz6yCh2YQ6+mxEvj7h0k6HONh6TBV0WhRMy/eUE+75/ostVBm8DI2jMKejVGklwpLQ1+K1BIdEzCcQXjDyKWoq7EkPwYuhx1aay8XP9UP5ElB7+3YXqCkWnBb4uo+wHNpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aWFp6cVxUZcb31xB9Q3VIY96ODg/FGbZNWiyBZiiQaU=;
 b=ZxbgYLUYOMFsAR9FIGApQ6jPFeWyJuNAlq+SEQP8+/oPyEr1xHtZmpXbzjrXovUjM7Kgm/xDAXJpQWpu68ToU0hRza0spcW2Kv44QneJxtLqiHcDO69OM/Kv/kc556iMC9OOhn9lEujDtetSOdLFH2ZKQtXl5EOONDWIZHXylzI8CCf5WKefAzO8rKVA3R27hJSR1uI4DVm0jh/KqV2A00OD7JQ5jm00bbv6u1DUON72G6wj3za+sJzHFQoriE2xb7vTeCHww1bdpv+Nug2FlqqmaG51nq+YmKQ7Fts9HV2DyWpLP2L1ekLCJ3a6CC9MJeFrh5y5GbeoU442WjgLhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aWFp6cVxUZcb31xB9Q3VIY96ODg/FGbZNWiyBZiiQaU=;
 b=pe3xu+bBsFE5hczybPZe2t5vUCJ7yL7S4hlXNCKOEQ7jcPQiumVSfoJ38sTkCqMsD7bfNIgTM7XSvDYdaEUxBdz7+HezldJoHbXWsjZ3VjJrYmAMh6BMI5M8z6+bHDSMu3uhSI8NFt9uDy3vLCJUk5Y5mLsyB3efZcQ85YmjGoeOMIDX/rFarGebiLENZySXyI+83v4llrmq8jQ+/ojfIbTyNbcl0AcS1+sWLt6Zw89SwJiAGjDuuSG1hMDVODl5QjDkjKzD9ZSwwuCfoGiEwM5Le4AVIRjTwwkVazD6aV0M3Zmu0JB2IsUlHPD3KMkyly4XiC6YAeL89t7yHIjHKw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB4849.namprd12.prod.outlook.com (2603:10b6:208:1c2::17)
 by DM5PR12MB2421.namprd12.prod.outlook.com (2603:10b6:4:b4::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Thu, 10 Feb
 2022 16:47:16 +0000
Received: from BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::dca7:5323:3:cc10]) by BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::dca7:5323:3:cc10%2]) with mapi id 15.20.4951.021; Thu, 10 Feb 2022
 16:47:16 +0000
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
Subject: [PATCH v4 11/22] git-p4: place a single space after every comma
Date:   Thu, 10 Feb 2022 16:46:16 +0000
Message-Id: <20220210164627.279520-12-jholdsworth@nvidia.com>
X-Mailer: git-send-email 2.35.GIT
In-Reply-To: <20220210164627.279520-1-jholdsworth@nvidia.com>
References: <20220210164627.279520-1-jholdsworth@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR04CA0069.eurprd04.prod.outlook.com
 (2603:10a6:208:1::46) To BL0PR12MB4849.namprd12.prod.outlook.com
 (2603:10b6:208:1c2::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bad223d2-192d-4f4d-9025-08d9ecb4fe86
X-MS-TrafficTypeDiagnostic: DM5PR12MB2421:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB24214989E29B03461B56439FC82F9@DM5PR12MB2421.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:67;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8aLnkWlPJFwqO34gV1bPWsuEtBLCRoQAUeRcPFXzdmqH9wG8Adeen333QeAmVBAEJgSx+3LNsg1oqBjEriCHuU4hJ1v30JF98RiCa5Pwc0Knz76qlK6CgR/BDLARjTpSXVy760IyMo3Xt3/enu/Ncr3AzHBAP1mIt7guDE2RvmHe6vANiZ+eIeU6YrpIuqBxafigjSGPenAlVuiug953piKaEawHScpi4u+8vUBaEWEW9dTZ1EifByBkLUKBf11xddjrmHM2NH7844EehP6K/n/dyLWkEAVsVS9BL4Z+m4e/KiQUfwfLktmLs0YDim6elyOF06GA+vJHodB6hnC8qB4Mf/6VS0zyP7Am39KIJpGQt4qWX/AbRzdW+4J8xbkpkBSq8NP0u/TpqrtZ7gHvGSiBsPEwufNoSbvpwMmnkeYiicCEC4MDj1Vc9WGOMXULub3DmJEdaOF2ffgCFs/LbfPnrnbIeBLTftq5Via0VFhUmUOWshSySoqcDxp4tYCjjH4m1gLDlNfGz1SmUNnGD3wkCotOAYenM8BTC3LT9/3eL3nNGws+6dF/7/AGZDYtLZOapkfiGcP1pFkx60jaUn3FRceAWm47plVEOrEIM5rRghAvTxBlBlAgXCfDvecsuj3aXIku5y6jo9zN0rz/FXNuOzWux3HVuFXEkO8h3lXxjyoM11Lah3W2oG+fyFqVJXYSOH8mSkd/z44WoGHm/Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38100700002)(38350700002)(2906002)(52116002)(86362001)(508600001)(6486002)(6512007)(55236004)(6506007)(186003)(8936002)(8676002)(66556008)(66946007)(7416002)(5660300002)(110136005)(1076003)(316002)(4326008)(36756003)(54906003)(83380400001)(66476007)(2616005)(26005)(107886003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?omIifc4+/XHgQQDrMA+bdaQHRwE2BZdngFDKADkHVJTaPdPExM7choDiIxqb?=
 =?us-ascii?Q?kiu2GlEpgxyv4uJhEX9b3fdpxS1aT4SOHAfN5PiWM1pLZZwafIrVOqhgJsec?=
 =?us-ascii?Q?2SR4LpyRTTUmt8Jq73EBQ/Bit1jNZENik6qitYcdMgZWSb7HEQFDmsezDJi4?=
 =?us-ascii?Q?zrwJoO24AVcPXDeXzC+TeNB+z17YkLYOYEUbAitYkv0mbulPYDIvmUvwCSZK?=
 =?us-ascii?Q?RYOoWB6FwvD6KiNQfAb6Rgn9U3/eFSUyOJ+0IHk+ErnlFeOkwy05it07Wzq2?=
 =?us-ascii?Q?O1oclvMSuONbGvaNEsazLRIaq8iaNJgpXOrMYdtpbHsho3K6iAL/+WPpqJO5?=
 =?us-ascii?Q?FkLA8l1Vum37VFIO5gNCVsKu3v2YQ/gZYlbPlmE011Bisjf08gqG4+c2RKdv?=
 =?us-ascii?Q?vnw8Vj4OxOSw1w8nTeeIdyS/4JJXN6QOD9Kb6oDBzZ8sMCJSQmqMnDx07/SV?=
 =?us-ascii?Q?r8fB3W4KuGAgn4xryxv9k+IK67v3UrXboKGsLHbhh3MZvajACR7wkuwRImUt?=
 =?us-ascii?Q?paxgnpC3d8q/ihawwlonHUs7moekeMKD/saiAsOwtdSSkwZtGiTl2hWcWhbW?=
 =?us-ascii?Q?V0z/3Ob4fAD6mqb0mFNcO2SAEZgw/jX7VqwJFksB46DCvFm595kx3BCJ8+/y?=
 =?us-ascii?Q?fx79uP0AV/ikxYwdwLdNbHcxkWNxra3nCZgKJGP7yEIXwbm7pZ201R0PRnxg?=
 =?us-ascii?Q?pj0tEkzfvHw8HU9m9/AYFLLoEbCccMNwDodTBjNxltM0/pHLxCAoYxGE1n5h?=
 =?us-ascii?Q?L8tppWQQZ+PWmzBTbpwV1X6wsnlShyVBPJ6cJChV9I2nPX/ToKlvP8HX6VJJ?=
 =?us-ascii?Q?oW1k/6YWwPDZgmW0hQl23kLun5YSMfFDxs1yEXYOCuc7tvNiiX+Qkj5lXzNZ?=
 =?us-ascii?Q?kHRJba2C/EXEcHkFrVz1jnfYZQ+eh3nAL/oqNiyA5jF9jableapaqyw9n38P?=
 =?us-ascii?Q?IDlnio2R/yVObiXNgWlgMFlrR3epkjl/pxSGb4ciBP2vpAXZp72HMeZ8l7aZ?=
 =?us-ascii?Q?2DMLVBhfa/v+qBI70rI4kPLhr6++ncKx9TWhpq6Js6HgNEus8ZcVnEJVWw/J?=
 =?us-ascii?Q?NZkLh1cQEOeKefpa/ACIcO2Sxm8NRqyqnky0+AgNAvaSVVDZfeefHbemsAYg?=
 =?us-ascii?Q?PiKHWu1dAxtLioypA9/2m1yAGlQzUDkNAutBTk9VdTNCATwg0KvBMYiG9Fmj?=
 =?us-ascii?Q?AWMkfF1/OFmQMil2/0pC5einsr8TZjfBcGzvYULjSl9AWekPu5x/p+BwYbeg?=
 =?us-ascii?Q?UwaiVN8UnCZG1UxGO+ZaOWU8NN/lmgr3T3+alVHZz4JRVit12ZGursptqDTi?=
 =?us-ascii?Q?dfBSir0nahzLGFzoj49YRAxxjeZbjpDwscfBr5Wev7fEcgx8iZQCTNGDj6D4?=
 =?us-ascii?Q?da+8CwFUG2fDKpc1A3UM/pNj8ipaGQU5FXBEIdc13i/1mFUNutdKsS/Ynejm?=
 =?us-ascii?Q?6fmUc1XY9MxIZG+3GftVwUmUWW99Tz/HrzGmkUvak1jiDWKfxKSVH39fM660?=
 =?us-ascii?Q?07+X7AlD0YfWqubDU06RKGrRBA4lVXxIMoDxGlBOUN5mXImkYqS+PsXeKbNy?=
 =?us-ascii?Q?rdW/+NWs3YPPxfMjR6Luc+Gp/KujOEM1MWEHiZYG1zZEfNPoutbwNprikNMQ?=
 =?us-ascii?Q?Zm8l0Tr2Wbe/I1QM11gHe6Q=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bad223d2-192d-4f4d-9025-08d9ecb4fe86
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2022 16:47:15.9830
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UNeTmjW0wqA3ZVi2Mjq/8ltVUtaf66AC55CiwQlE6KBLtthCm5vILs4lokJRTzT2Y2gzovNyx2M9ecO5751BzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2421
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch improves consistency across git-p4 by ensuring all command
separated arguments to function invocations, tuples and lists are
separated by commas with a single space following.

Signed-off-by: Joel Holdsworth <jholdsworth@nvidia.com>
---
 git-p4.py | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 0d444d2aa4..c9081d79ac 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -99,7 +99,7 @@ def p4_build_cmd(cmd):
 
     user = gitConfig("git-p4.user")
     if len(user) > 0:
-        real_cmd += ["-u",user]
+        real_cmd += ["-u", user]
 
     password = gitConfig("git-p4.password")
     if len(password) > 0:
@@ -1766,7 +1766,7 @@ def patchRCSKeywords(self, file, regexp):
 
         print("Patched up RCS keywords in %s" % file)
 
-    def p4UserForCommit(self,id):
+    def p4UserForCommit(self, id):
         """Return the tuple (perforce user,git email) for a given git commit
            id.
            """
@@ -1775,11 +1775,11 @@ def p4UserForCommit(self,id):
                               "--format=%ae", id])
         gitEmail = gitEmail.strip()
         if gitEmail not in self.emails:
-            return (None,gitEmail)
+            return (None, gitEmail)
         else:
-            return (self.emails[gitEmail],gitEmail)
+            return (self.emails[gitEmail], gitEmail)
 
-    def checkValidP4Users(self,commits):
+    def checkValidP4Users(self, commits):
         """Check if any git authors cannot be mapped to p4 users."""
         for id in commits:
             user, email = self.p4UserForCommit(id)
@@ -3203,7 +3203,7 @@ def streamTag(self, gitStream, labelName, labelDetails, commit, epoch):
 
         gitStream.write("tagger %s\n" % tagger)
 
-        print("labelDetails=",labelDetails)
+        print("labelDetails=", labelDetails)
         if 'Description' in labelDetails:
             description = labelDetails['Description']
         else:
@@ -3409,7 +3409,7 @@ def importP4Labels(self, stream, p4Labels):
 
             if not m.match(name):
                 if verbose:
-                    print("label %s does not match regexp %s" % (name,validLabelRegexp))
+                    print("label %s does not match regexp %s" % (name, validLabelRegexp))
                 continue
 
             if name in ignoredP4Labels:
@@ -3730,7 +3730,7 @@ def importHeadRevision(self, revision):
         newestRevision = 0
 
         fileCnt = 0
-        fileArgs = ["%s...%s" % (p,revision) for p in self.depotPaths]
+        fileArgs = ["%s...%s" % (p, revision) for p in self.depotPaths]
 
         for info in p4CmdList(["files"] + fileArgs):
 
@@ -4235,7 +4235,7 @@ def renameBranch(self, branch_name):
         """Rename the existing branch to branch_name.N ."""
 
         found = True
-        for i in range(0,1000):
+        for i in range(0, 1000):
             backup_branch_name = "{0}.{1}".format(branch_name, i)
             if not gitBranchExists(backup_branch_name):
                 gitUpdateRef(backup_branch_name, branch_name) # copy ref to backup
-- 
2.35.GIT

