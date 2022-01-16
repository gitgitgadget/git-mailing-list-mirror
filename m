Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A9FDC433EF
	for <git@archiver.kernel.org>; Sun, 16 Jan 2022 16:07:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233554AbiAPQHW (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 16 Jan 2022 11:07:22 -0500
Received: from mail-mw2nam10on2054.outbound.protection.outlook.com ([40.107.94.54]:57472
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233325AbiAPQHU (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Jan 2022 11:07:20 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MDscsO9/gWUsCoJsGJK8h1ueK94UAfdTWONGVbNDfFFX7PPLQJyCKvwFD2z50A+ebLRtDM5NjMHuiqswAocVWdMBH7MOL+xDc0yiofITo6LDM3OxYyL3dfK8ulEaR5rSn3DMNyx6wgve/M1ynM3k3KeNiy4juqf+RSKpX2uV9AlVlthNRdYHyNbGcRbnB9yatry5CKktwf9uHtplAbwb5+M1DcHNecwURzih8LyKCCiL2T6fw0D4pfu7aDDjfLfEn/WZJ6TcUqEyAPkzZPdfxNvJUJGkNsfjPmwy++YahYUp16YYi9zy08tUpu1gJabAWTOpkX5vTeX32V5YuAt0JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Ob1fUm31AXt+byeolv8X7vdxkZSjpHLomAqwJro4oY=;
 b=ecgLD3sTU3ihCImYTYFUrenIIg+QwUGq4zdvYJLFa0JF9WWOkaQNpiiPEOBTdZE/DH2MvDLCLCflbs4v+D2EZiUqV0r8kJczbIAlsf12fTPmxQK1yDpVebrD8rtsYq174xvUU3QrHJOUTRtmDIT8S7hBVqBK8eVF2U0I7fj4GgXjnz/OrjdJyfJdC6Dae1vgkAxqnqt7ykfIlQK3Ha7xP8Q+AEH4rq4Pi0hGDu64JHsMNbPlRXa5RAI/j63Y/NQ0FLkxEUZQBMoDEu6YR6HuMRz6Lwwl4a3128y9Pxb3IfoJSPQrqlH+2Mc4GUqI08DP2uLSAC2Nqwg6M95Zv8+6XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Ob1fUm31AXt+byeolv8X7vdxkZSjpHLomAqwJro4oY=;
 b=hcm6LnpSflV+E9QEQOeOl8L+aqbsnJ8XNtpIzOJ3wzH7Gp6dIlM97V3CTNz0Fcc9Ytn83hdj9t/ECRnc1dxFpQCr0vQjJ00Z+Pgsa1Qh2c6ESQZiow1p/k2fPpxQxqUhs5+EWtrhVfF06xndQQ6ovV7xDBGNq2ly9jRgw3zPovzArx9GK4bn6rBT8HHNJPpR54tv8sBJ8U88Be6wFU3SY6RWcBQF6jHAd5C4Jap+2p+6LbYI7SRhAiIk62NgMH+Je/6uaBunwFigUF4J7Xb8aO206c1JnXqdjfvJQvqY8i5rVFedTt7TxuNxTbptx5ShgRiAVD8UIfJVkgvrOJdxtA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB4849.namprd12.prod.outlook.com (2603:10b6:208:1c2::17)
 by MN2PR12MB3088.namprd12.prod.outlook.com (2603:10b6:208:c4::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.12; Sun, 16 Jan
 2022 16:07:18 +0000
Received: from BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::509e:bbb9:e1fb:26ed]) by BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::509e:bbb9:e1fb:26ed%4]) with mapi id 15.20.4888.013; Sun, 16 Jan 2022
 16:07:17 +0000
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
Subject: [PATCH v3 02/21] git-p4: remove unneeded semicolons from statements
Date:   Sun, 16 Jan 2022 16:05:31 +0000
Message-Id: <20220116160550.514637-3-jholdsworth@nvidia.com>
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
X-MS-Office365-Filtering-Correlation-Id: c5d0c497-234e-42df-ac67-08d9d90a44d0
X-MS-TrafficTypeDiagnostic: MN2PR12MB3088:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB30884C1D5B1A0F7A775926D9C8569@MN2PR12MB3088.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1091;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kDyV8ITAc/v/7hbCvfmrlNF/M+G2HRLA+FILykCihJFb3+z4nFt8TeCIuHxJWhOd77aN7z991xVu/Mymr8qxCtT1MgJMXEeR8t6L4kBQ+nxoirgqfM1ErhGngZuonxtkMAzhPgkFldfrIehAuX2jMPvMV6cVIEgpgXzUcMJ8dJ5tnenHVcbYLIew7oNEzNzKKdLgDoqSNCwqRthsmT60/nOlnfDZ1zLJttRzL1GR6czQRXXEz8b2BHr78J2h345uC/TW1cjiGmUsRf+BObsjN91T47kAq6e5lBspJBCVkDZWVVxucRyqMyOYT6P3rHV2t6VGHCyXzdHjr+EWYU4IZjTc/2fN2EYfBVMis/+JAxsW0xBvbUCFbvpMW34m6sMt2/391DXIRWZaLlp5Ae6H2QplNTqdfzf2c9gPtG5WIYPiARRyhdJJzxDU09VVyc5BSKIbCaePI6eXBNkl87zbMNqm+zQbA4M/4Wep+juLzyJJBuhgNkZautily/b3/aOrJTPWO9uYDyRzR9R07mCgrLsV+vMX4JOOGxkgwVSLNFBDLuq75gJxuExzIU70ayGVloq3SxkJD4frw7A7ZeMb6AtG7XmGcMjSJDkfnVAcNubV7LcjzUAozPQ0z/5u13TY4HJNyURu80Vt965I5vGFAoXsP0kE6Mj8e7939PuyNT6RpMbBdAO03arqA4/sr5Pc6dnDB796Sz8yBqIgk7bL3A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6506007)(36756003)(54906003)(107886003)(7416002)(110136005)(83380400001)(2906002)(186003)(52116002)(38100700002)(316002)(6486002)(8936002)(38350700002)(2616005)(4326008)(8676002)(6512007)(5660300002)(66946007)(508600001)(86362001)(55236004)(1076003)(26005)(66556008)(66476007)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GkGu3DKzz01J7u6LEOFvSLyeLsV/yB3z9I6/tIFSZmtVxFVfmhUIPEZZ9IM0?=
 =?us-ascii?Q?sphTFsrbqbc8zTowaMW+hZLWrgwEUcRHtAcib7e5nBZQ+Gbb6YpiJ9KiiU+d?=
 =?us-ascii?Q?X10llS+rHMX/XDnpQgvB2Zt069z8g7wzyuUyjGtcLpb63hlU30PG+JeL/Anr?=
 =?us-ascii?Q?K+lhoJ+ndQJegwCMNrFkxVHeYxWv1+R4MomXCFmsL1nfX0EnzVX/Ry9rtJtq?=
 =?us-ascii?Q?7+2ld88TtvpNxAFyvLP1L3YRw5JbfvRXZ/GupT2n0fpbH9+VsOpOc3B8PSXq?=
 =?us-ascii?Q?s7ETiQ2U4VaKotfeCKocvjLGMdLqXQPU12NfkDKIqykQh+ZqoIoWufVm9cEb?=
 =?us-ascii?Q?s3+C1vM0qTGzMhdsysxknLyvvbWeJPbtmgT2EKUCcA+dsXFa7gMXvM8Sx5wI?=
 =?us-ascii?Q?/wcPhLypcQFXrMqumoSPJvk38qlhPc02Txo4hilLCLuqgX284PwryBO8uEMY?=
 =?us-ascii?Q?lPjwLi929WuMP9QmXIaSgWxXGQl3/Y38/EQ4LOgtpMYEAdzZVsmWiVjmxc+t?=
 =?us-ascii?Q?ardoZ8A871SF+GC8SWehSuHNz6FMjqsTQE201hiJwBfBKnG0bLKSxA+210av?=
 =?us-ascii?Q?9IFRBVQTDW8rbrtHyspbJYgbXZ//hO9TJKeUyu8pnTYxt9mDWisNfdNmHZBI?=
 =?us-ascii?Q?JnZ9xksWfTRQ5BGZr6dnh3jstBqrGgT1IINw7phw6vJboURPc5HQ7ASFe5AK?=
 =?us-ascii?Q?khBOLMxIJ6DXbq5ng3W+ySS6gxbE9URC9X5+n130DYDas4zoYVefDFktK9b9?=
 =?us-ascii?Q?L0V24CuQorZGninFUREuvgAqfwZP9M/EW0i6t8K5xAsOfzxxLWGfWODzdps7?=
 =?us-ascii?Q?4cWcWxc9Vjpyv5fvz7kHdgo1KFiG2QBnNhvshSSQ7pczD3ZLh2zrmyL08MLr?=
 =?us-ascii?Q?PXO4oIxKneRDI+wE102zFzzmIci51A3Gtoeo7HinMzXejuoX1Dyw7aaOCLL2?=
 =?us-ascii?Q?T+t5yEatITTGrC1i1qoCqYElmYEs0QM4ToNcM961lzY3xfzMfcMP+Ifv63T0?=
 =?us-ascii?Q?NuxQP6pIX10wUu1ujIC7r5fi5lGRZEyJKAAhGRGrk7k2OY8Ka8H3ajJlluaC?=
 =?us-ascii?Q?HDAVjjaEaOOWTMekBzhKWQhCvARpC9lPzrPdneOT16LDO63Ds7Uo6hjrji8v?=
 =?us-ascii?Q?Wsafxqp1YiqAvbNCegm6HzqXmfboJnTBwPJwr9TwTshMWF3RcS4oEj271yit?=
 =?us-ascii?Q?wj97cZYK2RSB3RcLjhzTi/0lYjbn2DHIycf/47SOdG6D4FQhGQmL7gJXaWoC?=
 =?us-ascii?Q?1wTub9WpXg76mmw4PrWLxVWjCisN6C2NtR1/SEqkxQkybm39kTpwFd3CCY+t?=
 =?us-ascii?Q?yOzw59n/C4Kqoz4V+uxV/NiALO9/slhKbDrf1bbq2P30DJuOdWxKRTlwSAeQ?=
 =?us-ascii?Q?hvoBP4oVTv3GNtcxZ7qX2/PeOrakqtw9rb7XzBS8mGe6qT7jwQrvEpeoH8nh?=
 =?us-ascii?Q?ALBZ1Ukhnta54Z/bVRH7F1cDEP39PtVmWPShmuhqVOsmYYVbdnSznfqlcCe8?=
 =?us-ascii?Q?Smyo4jeWfkvRA6XWSZv/8+yYwJZu26SVrkGLk5OZDnuS2BlugIoQzOxe3pLA?=
 =?us-ascii?Q?7xxo0NYMaa7lOQ/IyJnSyND8rfmr5Aafztdy9ny3oJTT5bqaUnNDP6EBK9kw?=
 =?us-ascii?Q?0xJ73O8BbHXNji80vLN26NI=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5d0c497-234e-42df-ac67-08d9d90a44d0
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2022 16:07:17.8155
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H8VKfREfTecNyRSfvBdoDb9MfZmsskXFh1rzvLxCB1GrUnqBJ4ssaQsUZgQ0dxSGg+YLYQvVKvjEn7bACjBAFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3088
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Python allows the usage of compound statements where multiple statements
are written on a single line separared by semicolons. It is also
possible to add a semicolon after a single statement, however this is
generally considered to be untidy, and is unnecessary.

Signed-off-by: Joel Holdsworth <jholdsworth@nvidia.com>
---
 git-p4.py | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index c098fa852f..3d30a71d1e 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -871,7 +871,7 @@ def p4Cmd(cmd, *k, **kw):
     result = {}
     for entry in list:
         result.update(entry)
-    return result;
+    return result
 
 
 def p4Where(depotPath):
@@ -972,8 +972,8 @@ def extractSettingsGitLog(log):
 
 def gitBranchExists(branch):
     proc = subprocess.Popen(["git", "rev-parse", branch],
-                            stderr=subprocess.PIPE, stdout=subprocess.PIPE);
-    return proc.wait() == 0;
+                            stderr=subprocess.PIPE, stdout=subprocess.PIPE)
+    return proc.wait() == 0
 
 
 def gitUpdateRef(ref, newvalue):
@@ -3588,8 +3588,8 @@ def gitCommitByP4Change(self, ref, change):
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
@@ -3665,12 +3665,12 @@ def importChanges(self, changes, origin_revision=0):
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
@@ -3738,7 +3738,7 @@ def importHeadRevision(self, revision):
                                  % info['data'])
                 if info['data'].find("must refer to client") >= 0:
                     sys.stderr.write("This particular p4 error is misleading.\n")
-                    sys.stderr.write("Perhaps the depot path was misspelled.\n");
+                    sys.stderr.write("Perhaps the depot path was misspelled.\n")
                     sys.stderr.write("Depot path:  %s\n" % " ".join(self.depotPaths))
                 sys.exit(1)
             if 'p4ExitCode' in info:
@@ -3847,7 +3847,7 @@ def openStreams(self):
         self.importProcess = subprocess.Popen(["git", "fast-import"],
                                               stdin=subprocess.PIPE,
                                               stdout=subprocess.PIPE,
-                                              stderr=subprocess.PIPE);
+                                              stderr=subprocess.PIPE)
         self.gitOutput = self.importProcess.stdout
         self.gitStream = self.importProcess.stdin
         self.gitError = self.importProcess.stderr
@@ -4033,7 +4033,7 @@ def run(self, args):
         self.loadUserMapFromCache()
         self.labels = {}
         if self.detectLabels:
-            self.getLabels();
+            self.getLabels()
 
         if self.detectBranches:
             ## FIXME - what's a P4 projectName ?
@@ -4119,9 +4119,9 @@ def run(self, args):
 
     def rebase(self):
         if os.system("git update-index --refresh") != 0:
-            die("Some files in your working directory are modified and different than what is in your index. You can use git update-index <filename> to bring the index up to date or stash away all your changes with git stash.");
-        if len(read_pipe(["git", "diff-index", "HEAD", "--"])) > 0:
-            die("You have uncommitted changes. Please commit them before rebasing or stash them away with git stash.");
+            die("Some files in your working directory are modified and different than what is in your index. You can use git update-index <filename> to bring the index up to date or stash away all your changes with git stash.")
+        if len(read_pipe("git diff-index HEAD --")) > 0:
+            die("You have uncommitted changes. Please commit them before rebasing or stash them away with git stash.")
 
         [upstream, settings] = findUpstreamBranchPoint()
         if len(upstream) == 0:
@@ -4420,7 +4420,7 @@ def main():
                                    formatter = HelpFormatter())
 
     try:
-        (cmd, args) = parser.parse_args(sys.argv[2:], cmd);
+        (cmd, args) = parser.parse_args(sys.argv[2:], cmd)
     except:
         parser.print_help()
         raise
@@ -4436,7 +4436,7 @@ def main():
                 if os.path.exists(cmd.gitdir):
                     cdup = read_pipe(["git", "rev-parse", "--show-cdup"]).strip()
                     if len(cdup) > 0:
-                        chdir(cdup);
+                        chdir(cdup)
 
         if not isValidGitDir(cmd.gitdir):
             if isValidGitDir(cmd.gitdir + "/.git"):
-- 
2.34.1

