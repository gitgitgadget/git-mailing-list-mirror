Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 942A2C433F5
	for <git@archiver.kernel.org>; Thu, 13 Jan 2022 13:48:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235479AbiAMNsG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Jan 2022 08:48:06 -0500
Received: from mail-mw2nam12on2045.outbound.protection.outlook.com ([40.107.244.45]:51904
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235473AbiAMNsE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jan 2022 08:48:04 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AE/J0bJBQj6MVNcXi9Vv4ESPuG4xRfSpPid9w8EdOcRdHbCvOjEBupu54x8FKCWS3k1fgwQwxMKEk6/bJ+jUGJ/2yMvjedlC1fhX3P2uAFmhojmKKQMVhW5GE68QMDak2nN3/S4iW3FCr4ukWe8rTppv6spx/5Fofs1I9Aji4xcIVsKK6l4YhyBW0HgueWwbjzcBkspkleY7rSqsZmCJtthXXJZXhA48c9v+5BF4buiI1Ck5aJZZfwnTotrD/TXsIRcLKJcmh4Ll2GR4EAqWCbN+1HAE2++3StAJc7Zrc3Hh1T5dM8s6NATLSThmqPQY5rqK3XRTR9hvjfoeUVDroQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2lQghhGYCPz6fsvShaLJRBzHARDeG4vx4suYKkcgrqk=;
 b=PJoRSnVnRiEuZxbLCBsoZkGierAHTU0gvJW20A/wBkAY/JcaUEVuZbwz7wy6yPt5XJa45l9Pg1loCnURW7HRfhAN6eU3AM2DC5gnWDQPDSVJF+YFu5e4CrRI3BU+i9mmBU5A9X0mPm3SYC4q+86wBl3v6sNv3nrcYbDnk/WNIsJFqlesZ8kM48znCQhCrFsOnPXId86lMBtcwU3/q1bbo9K26acOXhqzeVQszEw8W/MN0+XliViBEuVZpR+KHHC8M0eIp5ny5rIabkhAWo+KAMQGu/usl88cvqEA5Ol4FrbP/Q/nBTC8VTFE3lJAY/MF0qH48cIg5/F2pnYVYRfxcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2lQghhGYCPz6fsvShaLJRBzHARDeG4vx4suYKkcgrqk=;
 b=pHSH/Z46eIp4lmV3MrfDqkRJhtYsNqcOLeeDn0pduWasIRkVfiQERf+7X3tVq38xawxy4eqK247Rs8K9/Hf88qyTvVVDCREMQoVcyfSwZyaBECupZLRcBytQfh/lMqXlroV1xt8Kx5y064k+fwmYEvrkgVrqF8ttzWi0W4tgj1YqgpUWTnIMUiF2+z+Mrus3GMs0imfKD9u5Qc8RK3ePuAgzdPsbfEXTux7J9VEc92eVEcwcApi0nTQGZPfV97hX2HoVuXoEj36aCbHLIvnJv3srjPgzD6d7pc1GWFloIxYvpPiusZltmwGGMnV+axj1x7BFYl+cpGyGSxF46dd2Sg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB4849.namprd12.prod.outlook.com (2603:10b6:208:1c2::17)
 by SN1PR12MB2447.namprd12.prod.outlook.com (2603:10b6:802:27::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Thu, 13 Jan
 2022 13:48:03 +0000
Received: from BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::509e:bbb9:e1fb:26ed]) by BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::509e:bbb9:e1fb:26ed%4]) with mapi id 15.20.4888.011; Thu, 13 Jan 2022
 13:48:03 +0000
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
Subject: [PATCH v2 02/21] git-p4: remove unneeded semicolons from statements
Date:   Thu, 13 Jan 2022 13:47:09 +0000
Message-Id: <20220113134728.23192-3-jholdsworth@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220113134728.23192-1-jholdsworth@nvidia.com>
References: <20220113134728.23192-1-jholdsworth@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR06CA0101.eurprd06.prod.outlook.com
 (2603:10a6:208:fa::42) To BL0PR12MB4849.namprd12.prod.outlook.com
 (2603:10b6:208:1c2::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7dd3e932-9533-4910-f3a8-08d9d69b51db
X-MS-TrafficTypeDiagnostic: SN1PR12MB2447:EE_
X-Microsoft-Antispam-PRVS: <SN1PR12MB2447AC4F3E8A31274765C97BC8539@SN1PR12MB2447.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1091;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9aur5mtv5FXEeVUbfrajwJMv6tc5uz5uEe+6VRabC2ryyvMBjTKkw54w1DBAcVqgvTLzdrhHy81lZQL6LpyFJn/cczeouvaZGlT2bWyItxJxo9mTZIKpuh0UX/yzrbqFeJUD+JfN6FcWUZLojcITlLrmhek37wKOrsgkJfW0mClPTf05oboV2kglzm9wtRgWc6feMGj43WBsRdC7nls+UqqXvhR72r5TKU3+Dt45vIQiuMfoMLzyTFJIf9jEFbJ6yBSqC0QikDtAhplGqqF8cvWulwKuWrAv2ZpqJF/AP7eVXoA+wau78R7hdCr14nO91Q3+JX0632ZZG93HTEo1UqPmjiG5Jr3YkdFDoxdlCN1mAchGM/D5/yJalDbwH6aL48aP1v75SQyI7VSKemnQ01u5O+4NgM6Sgc+KEvJsAoBNpp1nAAOeXVBv0v3bxN61FvHh5IHwUN+RDfus8vG1UQK38kmL0+GmJnCCJGKaZY1NyuT3Q+h41i0aH740XsYW4FpAM2jnWIPvSHCZGU0KxRq0kIXHANcnaUDV4mkJENik63rOg1sImS4RuMJSP3XIVBlix9YqXTN3Tl2R6qq2rxuCUcIAjErdily5GOcjC+2KQmEg1/ZS301koB7nvAuzYiQxyh3KEWcAJupFH3pvrXrKyDmEFbwx0Afa8TUagkAOE3SuKKIXgYUWCsqbM5KpR2KgGTk+iXxGXHaDdi+cJw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66476007)(1076003)(8676002)(66946007)(8936002)(26005)(83380400001)(55236004)(2616005)(4326008)(107886003)(6512007)(36756003)(6486002)(186003)(54906003)(316002)(38350700002)(110136005)(38100700002)(7416002)(508600001)(66556008)(5660300002)(6506007)(2906002)(52116002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qmm0BEqbMpxPJLpE/xA7l7al4JZvgW1u6ggTidoCEA50r/HBFdM50bJ2IyO7?=
 =?us-ascii?Q?jeg5B/6+2eD+rLvSzlGJoRWvkizOiw94c6X6D+PjUefCEBXrajG5K90RGGrA?=
 =?us-ascii?Q?I9QcjPHVe6dtZuAxXR/zfEOpfal/28jQoBd3q70H17qgXv2s0sJ7jIOxbXaD?=
 =?us-ascii?Q?0oHI/dTFaRO895p2VV2fJ8T08C8pDc9mLlSCKjqIvkdLTtOVKDKhto9BODXn?=
 =?us-ascii?Q?s/d86NPWHH5I3d3urJpSQWup1ZUWW1GxDgQS3oHNgD73qK7smGWTriKeR+MA?=
 =?us-ascii?Q?sHM4qPvFCAoU3J17FIs1HuVMYkKtG98yHDXag29NYiBif0CbW8f/GHD0hoc+?=
 =?us-ascii?Q?CKWi6J76b3t2MqEkjo7b0IoI7Aemu70sCWVx3ZnAWMrpj0jeVuNfQqLlVQwn?=
 =?us-ascii?Q?ca1DvU0CzF/hLERGqP1w11lDU4KvUTD5R/IvGOZnITq0o3XfBGpmBbzqmWzv?=
 =?us-ascii?Q?fKY9sg4Q63FEf2eiajBodjMyt1Wfp46M0viHAzRf+KgxEuKNO9/lVZ/SvrBW?=
 =?us-ascii?Q?NVB0cTF1t7o6+MHKmyYMrf/W8BM1P+2oP0MJnKsyxboTM4IQmvwfUE9cjTwG?=
 =?us-ascii?Q?luDBve8obVPwy8qEx74PsIEgGQxU23oi5hfFLHJzAw5biNc8DqiK5lLnMI9t?=
 =?us-ascii?Q?Rk5ksN4jOJHCMrUP003IHU90rTEt61fVt3nbvTZTot2k+/ijKEs1FcECF2Uz?=
 =?us-ascii?Q?xScC0p+GM0QeHdlK4jzR2ofBKpvPgeT6Dnl7n2DELWiJVDJvPO/ADFUv6EhD?=
 =?us-ascii?Q?IE5YQl+tLB6mYGGOXTntTDmUw4dOUIdHdNUrAXea/dryczv152gYM8XxHsgw?=
 =?us-ascii?Q?EiE5JaMm/9pXvjPwmTRIkXiGG0/iOtO8C3Z8TUmO3xdJvLGYbVK4LxgoSzej?=
 =?us-ascii?Q?1iJoxbePb1q1YlME6anWB9uK9YUSk09GggTpKbPqw/s5KYiL2XP+TpwRqI9J?=
 =?us-ascii?Q?V8/YzGQzapLWoPSEOSPfz5/VWK29TdF2gk6uJSDRPQ7Gr0fqC2ZkvVAEuJB7?=
 =?us-ascii?Q?O32B1g2E1JFfS1YLj5jaoFhvHSH7eBJZiYl2AKBGdHtodWXw6Z6x8NyiVp8H?=
 =?us-ascii?Q?ByOy9WiL9540eijoUcsKDr16KQ5RS//1ip5JhwtZm083i5pYk0d1ExaxuBbB?=
 =?us-ascii?Q?vToSsZtLLOZn36jBxPfrD9zRzsFP79hlLMvUM5aRugzvoFUSvXd9feRtEE6K?=
 =?us-ascii?Q?SCNORBPpSZEx/b6XQKF8rCFwAi/CtDjvCjHtjqqu1u1QELbIPJZmLixsDv0u?=
 =?us-ascii?Q?+gQ/iB/1JwTGL45s0IziJEn5NV7PnLI1M85c9oDTMd740t8dPsUSOFs9vHrT?=
 =?us-ascii?Q?dWQUD7OjN2cozxnTJqVabaeJT5arnI3+loC8d/WUp6OzN13k352lVFNtjgJu?=
 =?us-ascii?Q?trAYh/j7+Mh7GVpqsG7tICCjMpOH8sMJJU/CZl4qloOMzEnHXBUtb7CWm23A?=
 =?us-ascii?Q?9rhCAC0WWp/fy5C1yRw9JEtI2y6MOxKr601cYHGYIdLmYB8d4Wc3mEIiBkun?=
 =?us-ascii?Q?7J5+76Brr9yEFHNrhUyYtFBNvY/x5l6+1RgZJClYNjh9yI6YBNYGS5mHAip1?=
 =?us-ascii?Q?mVvUZXAdxV5C1MSovtoWPF0fcQbDJUkx3Hja1v6/jZu1tBn0I7H9dORDOixj?=
 =?us-ascii?Q?WdTEymixiHc323fAhXAbccM=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dd3e932-9533-4910-f3a8-08d9d69b51db
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2022 13:48:03.4092
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gk4UCYJZ3ch1moT2t2IiUKEfr2hETt0v1f20Zocj74FujF0LkUz9LcpQzQ+VHhfTBVhivvzbaRyq+T+3qS2uFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2447
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

