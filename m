Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D10E3C433EF
	for <git@archiver.kernel.org>; Wed, 12 Jan 2022 13:47:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353709AbiALNra (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Jan 2022 08:47:30 -0500
Received: from mail-dm6nam11on2052.outbound.protection.outlook.com ([40.107.223.52]:31597
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1353685AbiALNrQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jan 2022 08:47:16 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OyPep8xmB5oxZyPu7jvrhLLgUthUNO7zTklQBTJMZHFyyiwBid8rm4yAuKmYemjrCffFkuVo6UAKqRGz+15JQ8LYYHJD9irUg8OwS9qLhZ63oJ8fC/HwOSMV0hwvxwkr7CFDUjqGg3BmhoIbju5TNKLf+oiI/XjrS6X+aBju35jTIGfpFBIeKYAX+qfOAd09BZgYLRfPUeYWjSbAsdNwDsb3nRkXfpQMdeO4AF/YUJhlMhheSpb6a1JONm/rQ7+RMd/5Lui3LoTxpjVWjPpl8PaHJ6KLJj8DPR/VOJHhYfxYRU4sIPN88vlTk4WNIavdwC/tnCZbk98C4qObv6pZPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2lQghhGYCPz6fsvShaLJRBzHARDeG4vx4suYKkcgrqk=;
 b=PAbffzrWU0kVHR0zLrKYijjJxs7gYLk0Wqf9t6y1Wo+FTX5O2v/yjsCn/TIN+s7FA01+QlltbHrxpEQjiCxl3NsQZmBzcE/H65pxvf/A7HZECuwfvqzYvzjSCzOEx8HANTBI3Id4K4lCpFTkKNixkC/gjX7WSrcSA1nCn3nYgZGrbE+kW5O0jkjnz9wOqZH6WSD59ag+iluivgOVHGQqZeXTXmW0HmdJjWX10qO3k0WCaccHdG1FBnhYkgs9TWtZS0+8xJ8Pc9MZTmXozVnP5sR1wg/UL1w+WkoXVq83ZJNeAAWQ2Gm/Weh5JXuhiY1QCb454PCcWteoYwzlvbO12A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2lQghhGYCPz6fsvShaLJRBzHARDeG4vx4suYKkcgrqk=;
 b=a2E42ZuuXwG5sFk8xSY8y8MACEvPRRtYCWblnp0bA8H2klzBc4PZOuu8ogia+P3qb1EEmxO05vuqwrMEaPGIe/azdk9XQyiomEcis41cIGJ8Q2KnxudU3RUIOowb0rCvfuJqVNW1lHqodTrFZVJO8GUSH/53w/aA34tdDsgMvrxNhqQT3CFmPzOxWEb7U5B4rRBvoB8vK8WlP+7er7KF4+lABzWojONa1EshjHqqdJAti0KpiJPpDigOOPaM/ONko7ECdnuBxogeZYphgNdTJnzODDnqpK/ROxKV+NzEWvEtn75VRhJY5effkl85cSA14/aQoV9sx00ZneExs0Wu9Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB4849.namprd12.prod.outlook.com (2603:10b6:208:1c2::17)
 by CH2PR12MB4136.namprd12.prod.outlook.com (2603:10b6:610:a4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Wed, 12 Jan
 2022 13:47:12 +0000
Received: from BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::509e:bbb9:e1fb:26ed]) by BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::509e:bbb9:e1fb:26ed%4]) with mapi id 15.20.4888.010; Wed, 12 Jan 2022
 13:47:12 +0000
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
Subject: [PATCH 02/20] git-p4: remove unneeded semicolons from statements
Date:   Wed, 12 Jan 2022 13:46:17 +0000
Message-Id: <20220112134635.177877-3-jholdsworth@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220112134635.177877-1-jholdsworth@nvidia.com>
References: <20220112134635.177877-1-jholdsworth@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM3PR04CA0137.eurprd04.prod.outlook.com (2603:10a6:207::21)
 To BL0PR12MB4849.namprd12.prod.outlook.com (2603:10b6:208:1c2::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 117fef4a-8564-4432-1358-08d9d5d20914
X-MS-TrafficTypeDiagnostic: CH2PR12MB4136:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB41362B735AA730D68F8970C2C8529@CH2PR12MB4136.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1091;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vMCAWS9E7bpSgVE47d8h56YfkWeTu1yZkOJ62X8359rxgTii2Ul9cIC0oWTr1A5UM/KFg28QfNoYx6OWAEYmrY8RYrGY02ReXW7+nUpIoxwT6HXc5Xv6VIWEXGNMAcR9Y9/aaH5uaiHtUyYXvSQYHUSLoN2LDFLNsQF16J2Uxv2IJTGg3vHTiP9Exp+lM43R5w/YSlerZ2qr/oK4hq0WCoyPyfUtbdncCplXyBmT+vW4CPbjl7INjgh0BafJtehpYczHIWGH6PZGMJ+oqlsfPjLcTnEEB7gQzIzNE/mEFkAQUH9YLUnhuQdndaur/h3YuMz52P7+kIkmGpDHJFuNzKErQSbBMCi91pwWJ2uoU2gQ8ABCZyB1ywsn7KHJOnEsRui9NwB6d/XOxaUAnw54mlq0sNEPyU2sY+PV9+emZq3AdPHpNUxh4obUbuPlwyHKnvhqAFJtgGlWBJPjnIjogjz7+kvwOTc+G3jKZ7XgzsJ9mG6CAz8HXPo8wdlTqsDi1FMXtcrenvIx6yO7tiM0jaeF7l2xYa9WOUDYeEB+dxJYE5V/VKWkS38lWsXuvSEA7EiS30hUA6jiHCAjcovuZWUWSxkVpQXXdIT4umV5GF1NO2JW76XsmodR6ZMJmCvnX5L5Pp9HfprZIDxPIQMzyiugO19G44PQ1QSSgYNJh5spVtZNp34SyQ7leXtK/7euJCP8VPwl1bKRFPCLm08CCQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(508600001)(26005)(110136005)(8676002)(6486002)(2616005)(38100700002)(86362001)(7416002)(36756003)(54906003)(5660300002)(8936002)(6512007)(4326008)(52116002)(2906002)(1076003)(66476007)(6506007)(66556008)(186003)(38350700002)(316002)(107886003)(83380400001)(66946007)(55236004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pAhnsXHir0JH2douOnsfWU2so7bnq3vGhI49AytJB2Hf0ncg9qkBRO2HhY5t?=
 =?us-ascii?Q?hnCeb3IIXRSevBJdh3NnrDrnEptrPHa7d9hVV4htutlZzx525uYlTXKH3tTN?=
 =?us-ascii?Q?rvw70vzsB0HqcPDut9KGvuBFsthhXdBpwx6EQ7v3lew6O6cQo5BUAR0cpLjn?=
 =?us-ascii?Q?5PEyZaCMQ5TVH3yKfYwG2o+BtYN0ATnmbBZ3U4ZOY1yq1inBGYY1lSVR/2VY?=
 =?us-ascii?Q?C3th2q46MDu16hTLxXTke+pFITW6Zh5WXIGyS2buJe/Dpv6t6iOAkAXSh905?=
 =?us-ascii?Q?I7STjLgMqT+XvwkwBuZ7wmqKufSv7gSIibASrjQSCz1hBH9NK0NVOoUBXxaQ?=
 =?us-ascii?Q?UtqaS6fiCrKHgz0CYflG9Z2288iWtu5vJ3PTubJGbK76huZ3oWUbEE8z4mup?=
 =?us-ascii?Q?kS03DoQS1QWTyb/6XVEctDg4euJvjE/VEPp6tEOdOJSMU/K/FEbvkfUGRNEI?=
 =?us-ascii?Q?d44fJH6MDZpKS1Gw/mNpnfPwKzf3bk7XV3KogZlr8xyG8usEdZ3XkuXKMf9C?=
 =?us-ascii?Q?L7NaaGcqAKUZvDIEgxZQ8tt46/Kx8xyeg7371C+40BglC4tITYH8uWQqksJz?=
 =?us-ascii?Q?UN+AUNGQULUhTmmbP/Ckmdu2ZEPuk0MLt94dNcBXl9F2EFN9oDRFMR8pRq/u?=
 =?us-ascii?Q?gg5LPNgJLhU0LOgEUbaI7sI4HvD57F3PE6U0Myl7hCOVI6ks2FzUk8Zj077d?=
 =?us-ascii?Q?D3kzBRwUr5Q+6/m3Fb9yPStnVij9wjU6xZaqYBNNyRs2IIwwe0C5RU7ec8aB?=
 =?us-ascii?Q?hdb6zkC3TnlCt9FwxK0rc0IAq/gts5rPZaf/8TMWYsofHO6EhlMvEeEUHRVz?=
 =?us-ascii?Q?UB8qmiBgRlytv7NCjUGfC6n+29zz7qCUZsgWN36LfdNhrmsvA2qOeROY3ZeU?=
 =?us-ascii?Q?KYH3RfVl36q8fAFd368jDheYkVQhbm3OgF43aw8yRH4LyWORBPtc0WyguG4g?=
 =?us-ascii?Q?2cXQY0RtVh4NRa4XcHdLn8qK3DTd4UbbunIWh3l6XKE0pOw8edEoLlpRr0+/?=
 =?us-ascii?Q?PRaiKKDIivJ8wf0XWEDku1CD8Os2MQaQrfQFE3tcZM2a90nCrbedP34OYM3N?=
 =?us-ascii?Q?463Cu3DpWz5P7yj61vDKr423yAR1FP7NAvgRfFndUjAplWuprUpWZ67Vn4BK?=
 =?us-ascii?Q?reOujZdP/FEs/Xwn2qCh4Hf1oJr8ZjOnOqyg8Kkj1zKqefwKme5R9iZmitNY?=
 =?us-ascii?Q?Q2DOmtzKCoEzrrqzemkqbEJjy4LjJi5Xtj147dwaxOTWYnrWxr7gc5PVsDFz?=
 =?us-ascii?Q?DXTQ8bPXRgI2oZvFRijjAV0bpRw92dJfyYfsXXl3qM62wGop9MVZ10xVeS5E?=
 =?us-ascii?Q?n6gluKI6ke0zZInmleHw/6qT96nIIcB81zbF51sFezZ2JHz4xHxmrvmOeZGQ?=
 =?us-ascii?Q?oH7Dt2xfpp0a+J0w24YdKZUWAMmgBD1PTl4qwUyKKHB6N0p435s6rWFzr7a6?=
 =?us-ascii?Q?y30PdpbA+wPuo/VUWp9/G6kNMYQ7jU0UQQmVvo7oUwK9fXm0w/aznDyOsSwU?=
 =?us-ascii?Q?wgUPsm2YrmOt9jfULtG/BmbmfgkY8GKS5K8+RX247BZu5ZP7rFyMGv2ZL1Qi?=
 =?us-ascii?Q?MsheWKmxS6R4fqqMG39sAs2B/yalXuj9vvhnvpIo/IBpTPlexQbw05Llmt0r?=
 =?us-ascii?Q?/kDLqrciD7Jsm0EtCbo/NAE=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 117fef4a-8564-4432-1358-08d9d5d20914
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2022 13:47:12.3825
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6Pc7QyLWK8ANQ7KNX+V+Yujz2by9UbcHPZQjbGhGH7eB5tW0NUYkwCMMIjEr8Gjvi8PKdPyj4N6QrHTbdWMnaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4136
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Python allows the usage of compound statements where multiple statements
are written on a single line separared by semicolons. It is also
possible to add a semicolon after a single statement, however this is
generally considered to be untidy, and is unnecessary.

Signed-off-by: Joel Holdsworth <jholdsworth@nvidia.com>
---
 git-p4.py | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index e6cc0f18a7..cdf64df2b5 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -886,7 +886,7 @@ def p4Cmd(cmd):
     result = {}
     for entry in list:
         result.update(entry)
-    return result;
+    return result
 
 
 def p4Where(depotPath):
@@ -987,8 +987,8 @@ def extractSettingsGitLog(log):
 
 def gitBranchExists(branch):
     proc = subprocess.Popen(["git", "rev-parse", branch],
-                            stderr=subprocess.PIPE, stdout=subprocess.PIPE);
-    return proc.wait() == 0;
+                            stderr=subprocess.PIPE, stdout=subprocess.PIPE)
+    return proc.wait() == 0
 
 
 def gitUpdateRef(ref, newvalue):
@@ -3603,8 +3603,8 @@ def gitCommitByP4Change(self, ref, change):
     def importNewBranch(self, branch, maxChange):
         # make fast-import flush all changes to disk and update the refs using the checkpoint
         # command so that we can try to find the branch parent in the git history
-        self.gitStream.write("checkpoint\n\n");
-        self.gitStream.flush();
+        self.gitStream.write("checkpoint\n\n")
+        self.gitStream.flush()
         branchPrefix = self.depotPaths[0] + branch + "/"
         range = "@1,%s" % maxChange
         #print "prefix" + branchPrefix
@@ -3680,12 +3680,12 @@ def importChanges(self, changes, origin_revision=0):
                                 fullBranch = self.projectName + branch
                                 if fullBranch not in self.p4BranchesInGit:
                                     if not self.silent:
-                                        print("\n    Importing new branch %s" % fullBranch);
+                                        print("\n    Importing new branch %s" % fullBranch)
                                     if self.importNewBranch(branch, change - 1):
                                         parent = ""
                                         self.p4BranchesInGit.append(fullBranch)
                                     if not self.silent:
-                                        print("\n    Resuming with change %s" % change);
+                                        print("\n    Resuming with change %s" % change)
 
                                 if self.verbose:
                                     print("parent determined through known branches: %s" % parent)
@@ -3753,7 +3753,7 @@ def importHeadRevision(self, revision):
                                  % info['data'])
                 if info['data'].find("must refer to client") >= 0:
                     sys.stderr.write("This particular p4 error is misleading.\n")
-                    sys.stderr.write("Perhaps the depot path was misspelled.\n");
+                    sys.stderr.write("Perhaps the depot path was misspelled.\n")
                     sys.stderr.write("Depot path:  %s\n" % " ".join(self.depotPaths))
                 sys.exit(1)
             if 'p4ExitCode' in info:
@@ -3861,7 +3861,7 @@ def openStreams(self):
         self.importProcess = subprocess.Popen(["git", "fast-import"],
                                               stdin=subprocess.PIPE,
                                               stdout=subprocess.PIPE,
-                                              stderr=subprocess.PIPE);
+                                              stderr=subprocess.PIPE)
         self.gitOutput = self.importProcess.stdout
         self.gitStream = self.importProcess.stdin
         self.gitError = self.importProcess.stderr
@@ -4047,7 +4047,7 @@ def run(self, args):
         self.loadUserMapFromCache()
         self.labels = {}
         if self.detectLabels:
-            self.getLabels();
+            self.getLabels()
 
         if self.detectBranches:
             ## FIXME - what's a P4 projectName ?
@@ -4133,9 +4133,9 @@ def run(self, args):
 
     def rebase(self):
         if os.system("git update-index --refresh") != 0:
-            die("Some files in your working directory are modified and different than what is in your index. You can use git update-index <filename> to bring the index up to date or stash away all your changes with git stash.");
+            die("Some files in your working directory are modified and different than what is in your index. You can use git update-index <filename> to bring the index up to date or stash away all your changes with git stash.")
         if len(read_pipe("git diff-index HEAD --")) > 0:
-            die("You have uncommitted changes. Please commit them before rebasing or stash them away with git stash.");
+            die("You have uncommitted changes. Please commit them before rebasing or stash them away with git stash.")
 
         [upstream, settings] = findUpstreamBranchPoint()
         if len(upstream) == 0:
@@ -4436,7 +4436,7 @@ def main():
                                    formatter = HelpFormatter())
 
     try:
-        (cmd, args) = parser.parse_args(sys.argv[2:], cmd);
+        (cmd, args) = parser.parse_args(sys.argv[2:], cmd)
     except:
         parser.print_help()
         raise
@@ -4452,7 +4452,7 @@ def main():
                 if os.path.exists(cmd.gitdir):
                     cdup = read_pipe("git rev-parse --show-cdup").strip()
                     if len(cdup) > 0:
-                        chdir(cdup);
+                        chdir(cdup)
 
         if not isValidGitDir(cmd.gitdir):
             if isValidGitDir(cmd.gitdir + "/.git"):
-- 
2.34.1

