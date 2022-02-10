Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9E21C433EF
	for <git@archiver.kernel.org>; Thu, 10 Feb 2022 16:47:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244745AbiBJQrc (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Feb 2022 11:47:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244764AbiBJQrZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Feb 2022 11:47:25 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2056.outbound.protection.outlook.com [40.107.223.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57923125
        for <git@vger.kernel.org>; Thu, 10 Feb 2022 08:47:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BXvzKT2BWw9PXhEQ826aq/IhpjLZOWyaCOHGr6eDzUex5MarBUzTKffgfyX2IgWANeUB/IQ/2Fu9lx7ZFQOFU1UX2R0ss0qwp78dkZSzXgVroSfpG2DfjbcC7BzmmBJrQr8/+4JlSNVSDfoYYUOVcGvYuKRcANd/gU3T/UINBt5MHQXGvMHQ6oI4gpcc/qp+KDnmyZy9cixgsTF+8QzqCAA9N56uByQLl3Z7R5vmLKQxJWqE32cj/deu2Ad7OtnOrz/RiLGl8Vs6jbMP52vDwBH2+tuvTVqBSOsb8Rlh3HyO7163vCxdMJKv+Q8mTRE4y4P3T+2di7plVv/n/GUFPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uxqyfLwjbbjgCetgAPvO0qejjvkS60cCpu07r0cBQmo=;
 b=lT37w6I/bgE6S0ogpklxV+sTzERyzHxxuL+IFeShB1GlLDloRjLfTPptY+LCyMeb9hPO7aZ5WBTl+UkGEySsonrh1OuQA/zmTAq6WparI16jBTnD/FGSahHdLLXrqlkU9p1kisXDu4yAcfF/TepM6aA8PiYDr4sebaYu/qbZHPFZPw83dbjY47Sj7wUM96MLgZ2xWJO1T7qcSr0WQWK5WCJ7pxxpavcL0Sl+WLgETb13o+3npp4U/XUtLB5ZeNgeGBnLKY4zzz6Kht1Wv4UMfJ71jXJ2J1tKxaOoHfLdfNxCFjTNFKTaloxxgYMPBiNQ6/YiMqqsJBmZNzjOM4wOnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uxqyfLwjbbjgCetgAPvO0qejjvkS60cCpu07r0cBQmo=;
 b=TxoAHC5Qu8xiuXLi5LB/EFQBoee44uw/ePtnP5hNuVzjPfX4bAGG3XlH6isNSoFEcKNpGxdBudDIPNFmuuObKjuB/KAy05JmpFt3ZoNhe169Yu6usGjKVH9rFVkkYuzTQG2beLF9bNyWA34tUWYZxIfUkrHWzs69f4y1g7yyJTnldzu9qBrCf3kPZxKe1WOQI3e75zr+KLJ+l6EnX1zkpuq6YoByWexrvrqbHQX0vh/0HOlMqKfg9FFp5z7yAPFJWtSfPX5YklbSA4z6xR5OD2eBJgkIg331EpL58VVVRmbpcvx4KXcnAX7vENGnSHcJCCAKiTVPW+PKpAr7pTQipg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB4849.namprd12.prod.outlook.com (2603:10b6:208:1c2::17)
 by DM5PR12MB2421.namprd12.prod.outlook.com (2603:10b6:4:b4::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Thu, 10 Feb
 2022 16:47:23 +0000
Received: from BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::dca7:5323:3:cc10]) by BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::dca7:5323:3:cc10%2]) with mapi id 15.20.4951.021; Thu, 10 Feb 2022
 16:47:23 +0000
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
Subject: [PATCH v4 15/22] git-p4: ensure every comment has a single #
Date:   Thu, 10 Feb 2022 16:46:20 +0000
Message-Id: <20220210164627.279520-16-jholdsworth@nvidia.com>
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
X-MS-Office365-Filtering-Correlation-Id: 17c32402-3ba1-4f9b-3425-08d9ecb5032b
X-MS-TrafficTypeDiagnostic: DM5PR12MB2421:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB24218B9D9EBCD8743F734BEBC82F9@DM5PR12MB2421.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:357;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lq5ZInSuj6ZNd7iXaaaqXUBCbpOnaL1KNvG4M2qSGtsNnM6mEA31SfCHAsWXBM8AVTUMHvGKnGbKR5Y+o6bjITuVQj9EQON9Ufyd72Os6leKnFuF9BMp1gtThkBo391F8lNkI2AFkeY+2eAGHKEoy1tgGy6XWDCtHJtvF1hi/XUZbjksoVQCIhngq+xavcJhlZVJaifGvMlRf1tzUZjko6fcbRB72/G3Q4RgEfqOyDm//C8gP2crb95Qd5Dud/sqZD306eOUG2FSLiWZ55HnwWrgtDE7B/dc7ylUaZJibdy6wfL2vovTvJUsyRwh1yP1H5W37ypK4dlY7MbCX6+BAY3g6RTQWdJ+/my0uR5qLnj18e+Bt8wW3bGx60NPiYB7Fwsmjw1tefihr2W0ohbv1neD8aKqAoy+gdqGb7jmrgT4v8so9qGpruHQvk0ln1LoEb0bAL9I4dvXEaXy+cZxGBLI4+SlfT8+n1S3H2S3iQEZCAsS1TxdrzBSieVlxJVprzbpa55wdKb4YISfdWG6EY21cX960zbXRiKM2WBxTow5A4gJHH2dXDX3ZFLtztfiC/Rmosm5S3p4Cr9LUmpJpB1P5TUvKjzTz3sjnISQN4a5BDbgdHm/LqP+gHaypWp8XQiSi4QE2yh6JZj3MfTiIE2DK8g7dXDr3GJjjcDB0UCoW3c4LXOPs4vjVcGlhSyZztZ7bF+xXVwZdl0TeZSMz5R5tXX/NXuis1gbO/VBOp0CwiG5JsmOriV0NoQ9GkMwIKKYGjY3JiIu7dsUipo6xgPFrfxE3yCO5wM9tyzowhk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38100700002)(38350700002)(2906002)(52116002)(86362001)(508600001)(6486002)(6512007)(55236004)(6506007)(186003)(8936002)(8676002)(66556008)(66946007)(7416002)(5660300002)(110136005)(1076003)(316002)(4326008)(36756003)(966005)(54906003)(83380400001)(66476007)(2616005)(26005)(107886003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RnTPov+O9DCxM/daj+HmbGb9hQiss8nkaosl8d07geRob4vjMlys1Wz5a1op?=
 =?us-ascii?Q?5KIJHXnJFNgw8AOxGGvYoyO8AshVyLFHlC2pUBsJSkZSXzSxN1cbV0HercUP?=
 =?us-ascii?Q?CXUahr6/LhGH9PjVJVmNlRIGjOg8Ho8pJucJkdWx6uLjHQfJz29bPBBbGU3Y?=
 =?us-ascii?Q?2l0YGo+8LPEn8J5FAxVgjX7uXSK+NOsHYBTUQMrgmL8w5+10HhWXb2suxAhv?=
 =?us-ascii?Q?+6eTgI+xDFjK5XfZfIGReJgva2TCyJMvP5QGC8hmwl+CcpQIX1fru6NYryvv?=
 =?us-ascii?Q?/Zc7NRgScblKEVc+Dy5MVxej6Fs1H7i+1RdP8cRbxy+TQLH6D7kLMXkOQLh7?=
 =?us-ascii?Q?7XN+z40o0pQixUjg6AbHkzGmdVq/bEhfakJv9GOL6DdHGw75YzD3dyoI2V9q?=
 =?us-ascii?Q?JgjFW+1bM65ZLNrxsZPmMiHhoITAsF+e/h8Xm5v42Jgvvtidr43CfDdQxAQg?=
 =?us-ascii?Q?3JOFu7D/cXons7+AaQ7D163VE/aQ/+gPVhIREr4Hz48oAlXfDT8OLvQ+b9o2?=
 =?us-ascii?Q?lDBL4HZ6K5Eecje342YXvzu0G5kd8p4ZoE5cOMheXtQCyQ2x2ucqQ33pDAs8?=
 =?us-ascii?Q?Ep342HJfLF9zLWope7m2AksXNsv1psDsilh7Os553otJ/y3WF0/5xPUTMzXq?=
 =?us-ascii?Q?i6TAvUhLfuzjK3N/FCSQoRZpn5Y+JIkmLvOwdsQiPcdNYq8DEqp4vKH9IkxJ?=
 =?us-ascii?Q?uvlYHlgPFeuataqOQDW77xftsG/+ntfb3lQ4wtwpWSpDXc0crVrraxE0g+QD?=
 =?us-ascii?Q?S4yLNIh5oCzaQTNiet7U8aU6NtsFdpfjf5H2XTPRF2CDHvA9HuykcgpssEVj?=
 =?us-ascii?Q?GeyRkFeIAhmRAu8jh3hCn+4TZZal5f0VHiW4DgclTbeHz4qE1EmsLhhKdh57?=
 =?us-ascii?Q?14D4G9ynhfju1azyKW2bSpkj+b9wIfmP7XuZonCicSJfqdkDV24fDE0NCLYg?=
 =?us-ascii?Q?uhnxX+psYFVeZIQHbHrIhyVBCMzQBt7+FQ39+tXx4M/dqLO7vTZk1UWBHpxS?=
 =?us-ascii?Q?AJU36IT0OJPNZON43Oiuxxna8lSaT9xutr7nr4cy8+LC/jPyVrJfUpShjPS3?=
 =?us-ascii?Q?OQOcCo51ZIQVYvAMqTNIJkuYcxm+hotZU2F4jSKJAozdJrpHH/Mnlxadim6f?=
 =?us-ascii?Q?Kon6sVJmTw+gZAsKMnxfa/8ix8Yecgx7c1/zFFQee8AsafS1UCZFrEwr3/LD?=
 =?us-ascii?Q?5zwhS+9waKRdXdc0a+whilBjtpnaejv+2s5bU1v84NqXzNe2qKUGAhBm7hsD?=
 =?us-ascii?Q?PJYwdl8MVwqcx2mnbeZ9lBJEbealDEX2lUusQrM9nwkf5Jt9+i0H4PVIonaf?=
 =?us-ascii?Q?P6ig65NJ+fKainhce/LIIA/XxwY86YUxOAIxAbpcWiIF0lUJOqk5U1AqkuD9?=
 =?us-ascii?Q?I0CwP5MZgTvVQPoWcPHBkLmtdqd5vOlT+lFp4GXF8Dz+Mhn23LsvFinhZ5tr?=
 =?us-ascii?Q?roGEbLA1i20P4XtIx4cAaFs5vG1AI5SY1yRv58UyeVzItdZzAw3sxvCKPW2T?=
 =?us-ascii?Q?bsqNdOH81iZZ4NNU03egtzWEBbrQAp2M2J2APYbsOf9GcZ+u0jAIAtNUEGXb?=
 =?us-ascii?Q?jbmAEpTI2U0quM4+Oc7wi1mSPwgJ1jNVxuNPwVvY834d6IvnLoVhyBVyNiKl?=
 =?us-ascii?Q?IeDQkqolXfnrLUY5kjKh40E=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17c32402-3ba1-4f9b-3425-08d9ecb5032b
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2022 16:47:23.7440
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2MSTz5cfjBVQebHDcYvPKkz4vY924AwsBB/3U9/+hEFwt+HeDU+xFeKC+kcocETX4aKRm7XRVeQiuGYlDTljNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2421
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

PEP8 recommends that every comment should begin with a single '#'
character.

This guideline is described here:
https://www.python.org/dev/peps/pep-0008/#comments

Signed-off-by: Joel Holdsworth <jholdsworth@nvidia.com>
---
 git-p4.py | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 167bc19775..88c2b5213e 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -895,7 +895,7 @@ def branchExists(ref):
 def extractLogMessageFromGitCommit(commit):
     logMessage = ""
 
-    ## fixme: title is first line of commit, not 1st paragraph.
+    # fixme: title is first line of commit, not 1st paragraph.
     foundTitle = False
     for log in read_pipe_lines(["git", "cat-file", "commit", commit]):
         if not foundTitle:
@@ -3485,7 +3485,7 @@ def getBranchMapping(self):
                     continue
                 source = paths[0]
                 destination = paths[1]
-                ## HACK
+                # HACK
                 if p4PathStartsWith(source, self.depotPaths[0]) and p4PathStartsWith(destination, self.depotPaths[0]):
                     source = source[len(self.depotPaths[0]):-4]
                     destination = destination[len(self.depotPaths[0]):-4]
@@ -3644,7 +3644,7 @@ def importChanges(self, changes, origin_revision=0):
                 if self.detectBranches:
                     branches = self.splitFilesIntoBranches(description)
                     for branch in branches.keys():
-                        ## HACK  --hwn
+                        # HACK  --hwn
                         branchPrefix = self.depotPaths[0] + branch + "/"
                         self.branchPrefixes = [branchPrefix]
 
@@ -4035,7 +4035,7 @@ def run(self, args):
             self.getLabels()
 
         if self.detectBranches:
-            ## FIXME - what's a P4 projectName ?
+            # FIXME - what's a P4 projectName ?
             self.projectName = self.guessProjectName()
 
             if self.hasOrigin:
@@ -4048,7 +4048,7 @@ def run(self, args):
             for b in self.p4BranchesInGit:
                 if b != "master":
 
-                    ## FIXME
+                    # FIXME
                     b = b[len(self.projectName):]
                 self.createdBranches.add(b)
 
@@ -4154,7 +4154,7 @@ def __init__(self):
         self.cloneBare = False
 
     def defaultDestination(self, args):
-        ## TODO: use common prefix of args?
+        # TODO: use common prefix of args?
         depotPath = args[0]
         depotDir = re.sub("(@[^@]*)$", "", depotPath)
         depotDir = re.sub("(#[^#]*)$", "", depotDir)
-- 
2.35.GIT

