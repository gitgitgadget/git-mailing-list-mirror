Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3175EC4332F
	for <git@archiver.kernel.org>; Thu, 10 Feb 2022 16:47:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244684AbiBJQrD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Feb 2022 11:47:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244670AbiBJQq7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Feb 2022 11:46:59 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2047.outbound.protection.outlook.com [40.107.96.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7992122
        for <git@vger.kernel.org>; Thu, 10 Feb 2022 08:47:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FQ6ctFueQwbPyHrVzMpDIUO8S+gM/tiXYrb2ajpRjlOCvvYrfhmQF1Fkk1YNNCOHKhHG7fmrSxepUwjhJB3QA/UgPOMil0HxmTWC3ItTAffYuQdGhJAG7jHJwSrJmwfpQDPd2LS2AkxTU4gqxwLLhbz5IjYQGyffvQyPi4kE4GxEUIEfeA252v/EbJQvXPNPlUpnVD6+UGwyxRsQGEY+G4XI1QVJoWH/Gi+O/Sl7DP41HxuTAzqI+LZuE8ThLkUnChcRKmZ7zZGjws6sn7KgDxR/DoB2wrihAzAw90/qAUS6VflmegLNP2c5VybAZMAZlSvA7AsxEKLRyZtEo4PgRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xDFtmGco4Pck3P0NQCQMGHFKUDdDLMdF9Bv0WV+BF9k=;
 b=BsKINJm+O9x6/vQok29OnOE8gTLFgqDhQyU4s+hEJM0iWdLbsEwrSlcsvE5ajKuWjvX6B23GHeIJP1h8QwY4hbEByFrrDGy0CtvWD9dyCrc4BezXCm7ryDRMgxK75rMAOlI5zQhaVCgkLJ4gA2UXodz/fLx7mle/U3iUEQmO/baF0Ab1vzD1qYI5cKvj23BMyGxcxHOmOHGk2CAGC6w/6yNdqc+Fh4KAiruzNi9METC7W7wT/PrDrSY8R9NXWjcoSISf5FhUgQTNnGjkwvelAg23XSzrsqYwO6v9HnXLO8OLbNIgoxm/mQyi8fa+eLPmyeGALVyZ+mzUTF1nQqGN1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xDFtmGco4Pck3P0NQCQMGHFKUDdDLMdF9Bv0WV+BF9k=;
 b=Ldl4eu2YIVKaZV6yj1t/V+qe3V16fNvtVHt4RRpsYZbZxwZHWJf8yQLJJBRclSraOXBQ3BpkcELuEMFEY/jzi4s+/wXOFcw6MBABkkdmv1Wzmk9QpR6cRpaTubtRFVIttkxeQXjFrW/BbUbO4cztrqhtcjhwCJ0xPZO0ceC17/S5MtASe3Qt4KWEMFYdRsvgK3uMzeLhhyXf0VKudIuVxez48zEQL4biJGpp4Saiyqt00mpqzziUUjp01nxhBSZ1/8BCDIiRCAaoioYAyRNx38YdAh/JSZ90/eUPM0L7rucgPw6xBGc4h1vn/3qXfi+n/eQ2ytcecUFLF1mtTNUWcA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB4849.namprd12.prod.outlook.com (2603:10b6:208:1c2::17)
 by BN6PR12MB1362.namprd12.prod.outlook.com (2603:10b6:404:1a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Thu, 10 Feb
 2022 16:46:58 +0000
Received: from BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::dca7:5323:3:cc10]) by BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::dca7:5323:3:cc10%2]) with mapi id 15.20.4951.021; Thu, 10 Feb 2022
 16:46:58 +0000
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
Subject: [PATCH v4 02/22] git-p4: remove unneeded semicolons from statements
Date:   Thu, 10 Feb 2022 16:46:07 +0000
Message-Id: <20220210164627.279520-3-jholdsworth@nvidia.com>
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
X-MS-Office365-Filtering-Correlation-Id: 0d7f57f1-f2f3-4195-27d0-08d9ecb4f3ec
X-MS-TrafficTypeDiagnostic: BN6PR12MB1362:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB136262D336856C6148D2F446C82F9@BN6PR12MB1362.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1091;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v+t+eSQgupM027IQTbsjdNJ+4gvxUf65H1KCO/Ve2fdLbL+RkuDi66T/krtuRUD62BRpWRlqWfSKkK0D8McCjyiTFFipwj6fJPqmsjHHg47fboZSgRBVXSx26KJRM5AxyxEZuTPS7CDdOO5MFB1ZQGKdDvIfDXF4Ysdm2soj19cJW4pHHBPFTDxHIYizcaiN9ocoUN7DBp/IZkd8tDif59esajzUTJMn6BOfO+lgj/qtcOOWj6ODXqvp/StzY5CqNkbl46tbskEz6MzxtYoiqS3o6hnVfvXqvpzBwC1bf4dOfxs3gyY/To9bMQkxNCzUxA32zZRkeOzmBmiHQC0POmaXmcZkk2NlLG6gxcCO5zz6hSf0u9G77mAsPHqlqtOTiLXny8WlaxFTOfgnRz1uIxnemxb3PTuoxMztGPumMq/J5wORnt3/8FiMUcrwEOtJUPDhQRNJPH1tEtUAVXW094l2miFQwPr3qYV1W0PtlfByhBYEd9n/GqpZLage8Q+ItxYwtnuoVR29pA3U79DoFCweaIPQTMlW1hqqjqFm1TfiwWcB8eOB/eI+DPu9aevg8koAIZey0X2K1klFMIqPHfdoAr9Sal8oDw5e8jLAkdS42q9uZFPY3HIXmJa+LPVyfndfVViX1DPDl4Y66QpmlxuY5J7AfDXJjVWbw+EZWwAH+u5bUQelwNVven7SXIR29lkkQvDQq7JnvO4HNYFx+A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(86362001)(6486002)(7416002)(2906002)(8676002)(66946007)(52116002)(6506007)(8936002)(83380400001)(2616005)(38100700002)(38350700002)(4326008)(1076003)(107886003)(508600001)(66556008)(66476007)(5660300002)(6512007)(36756003)(55236004)(6666004)(316002)(110136005)(54906003)(26005)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VhZUutQOgXh5FPmnZSsfQR5jm0nXcdwgjcXhoOzNrvBBubiIWVyb2y1KXzPH?=
 =?us-ascii?Q?BcfeoVVKLUAllWqjdelE0NYTr2nTEg189XRR7sf1w/gdWYuQBfJ5Nmu5tXPl?=
 =?us-ascii?Q?3nP86PflawAyYfFwO9oB5IOHk5iOeuWRzE47H27JA7RnETYJgyfENNywZruj?=
 =?us-ascii?Q?8BX1a//A97SOOEEDBOU4nCJFbBUVpDHsc4dV1HdaMAoLPUNhFQsbPNBtzfTy?=
 =?us-ascii?Q?8rFJXPx2a1nPlgKqNggc12LjGY02r6E4ihpf1GT8r5Jk8RJkytY4ETOAEjQ2?=
 =?us-ascii?Q?jCFYyjJc5mK6cOA26wGPPRjf0mS3fmAZoRw6FpeF18eyvVF25hI0oeECQRLj?=
 =?us-ascii?Q?68Dds42QSU7EYGe2f6T+jdpcDnqTySC+Dm+CwM32PvMvm1bdJhYqyRvQxXmx?=
 =?us-ascii?Q?Epv8o1Xu8hheWY/t9IUKGSpmPfpXkigWaTsmYwv820MUjmZZcPWWkuIGzILf?=
 =?us-ascii?Q?YjV/cfBEhrTLY66kJg5IlFIXDMBhKRGNmn3cbNMT7sJpnFnQz+/Zbs6Uh45s?=
 =?us-ascii?Q?ucvWzMWQD5zWmEqnXgDva1625FB2Qhb5C/iyjOdRWZPLBa+6cDB6imB7iqtB?=
 =?us-ascii?Q?ETuRhONYHffJ3eIi74nFYC+7lONsu00pRFIexIxoWps4DjrBxwyk10Aa+utb?=
 =?us-ascii?Q?lVW13b41Qt3j1fZJlIEb6wvGIGepkUcTnMg/DzH/TDnuUB9zk71J5l7T6Jvv?=
 =?us-ascii?Q?mo+IQfq9/F/gp1wdwcfZAM5uMM9uCPGW4oInroBnhgdxP7XPwDgv5Sm5m4pL?=
 =?us-ascii?Q?5zjGzIaXZHYcWaqPJf1FS3G2lI85YDepTiH41+zVFbtifLUTbq081OuGAqk4?=
 =?us-ascii?Q?FZhR9vf5Scr/BATSGO8pTH3nsKO+mZoP6fizpXz7GIg4dL4KX9gt19GmvVPe?=
 =?us-ascii?Q?KISda4R3eN0bXiAEu/hLCYVRJpwgI7gZHgSHl//VKgoJ2FJ2vOwXOUL9ymUG?=
 =?us-ascii?Q?56ZdACtTnWS4lFlpt9IxBZTmu2pcfPnBmw323K7yfh7NxpB0KfwC89Rr2NjH?=
 =?us-ascii?Q?e5JNggZ0RlENLD1DuJKounTH+CXnaimPEQoUmrHiGuC0SyPmDCmR3F2YCCWZ?=
 =?us-ascii?Q?45CJhbWxYSOGecfHcnrVeU1ZfAFQPim8cVsGIWIXyWSea6aK84U3XWEnnA5q?=
 =?us-ascii?Q?X8U6ojLCFokxFbRRuLAw1QVo+h4d1QN0ELoLmHKyPgzZn89zhLWcwx3wqp4y?=
 =?us-ascii?Q?D08q5IUyzyOj7UiCwy+MxftlcSm6HzJOE70o/FbK/2x9HAl/jGueYveFAk/Y?=
 =?us-ascii?Q?zNTTL31eRq+9R7y16bpt22NxU9ZfEOMafmPBfvOntpaaRngC9rWySGRSg5yx?=
 =?us-ascii?Q?+37pFuwAHqwr4bUJT24/EXQ0ja41awLbLy2jkVbR3VB0tHBIxLro4SWnehts?=
 =?us-ascii?Q?FvxPGIIPU0TuSwWuoHK5+RyuHJmaC+qHgn0s76LQBMZLpfGu66bZrhyIFGji?=
 =?us-ascii?Q?8ZrdVy7dy/HrWE7I6oRyHs/Tz0FQK8MiqOf/qakMdjQYgi6DKPoRhp36v917?=
 =?us-ascii?Q?NpPhqhnWsxOfgGkS8aBzCR0c/22GETn/i9ZmtDh6kjgQ/GJDrzNbCzTESgHu?=
 =?us-ascii?Q?plAjtnAzWztLElP5HSOUYuyf68D3j0FSA9rEBj2Z9WDdbs5i3WQX/KCHMaGZ?=
 =?us-ascii?Q?sgkroCeuCyBzLJMFZxRyUGg=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d7f57f1-f2f3-4195-27d0-08d9ecb4f3ec
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2022 16:46:58.2275
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Loui2LeKT7U7/k8NuHhl4LtpvbNhd69GXgAAg+GMyL1z3AhMGNkSNHv0mvud0/cQ9n4VlDwNzmL5Ye2v419FVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1362
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
index 265182b088..aabf657a57 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -813,7 +813,7 @@ def p4Cmd(cmd, *k, **kw):
     result = {}
     for entry in list:
         result.update(entry)
-    return result;
+    return result
 
 
 def p4Where(depotPath):
@@ -914,8 +914,8 @@ def extractSettingsGitLog(log):
 
 def gitBranchExists(branch):
     proc = subprocess.Popen(["git", "rev-parse", branch],
-                            stderr=subprocess.PIPE, stdout=subprocess.PIPE);
-    return proc.wait() == 0;
+                            stderr=subprocess.PIPE, stdout=subprocess.PIPE)
+    return proc.wait() == 0
 
 
 def gitUpdateRef(ref, newvalue):
@@ -3530,8 +3530,8 @@ def gitCommitByP4Change(self, ref, change):
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
@@ -3607,12 +3607,12 @@ def importChanges(self, changes, origin_revision=0):
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
@@ -3680,7 +3680,7 @@ def importHeadRevision(self, revision):
                                  % info['data'])
                 if info['data'].find("must refer to client") >= 0:
                     sys.stderr.write("This particular p4 error is misleading.\n")
-                    sys.stderr.write("Perhaps the depot path was misspelled.\n");
+                    sys.stderr.write("Perhaps the depot path was misspelled.\n")
                     sys.stderr.write("Depot path:  %s\n" % " ".join(self.depotPaths))
                 sys.exit(1)
             if 'p4ExitCode' in info:
@@ -3789,7 +3789,7 @@ def openStreams(self):
         self.importProcess = subprocess.Popen(["git", "fast-import"],
                                               stdin=subprocess.PIPE,
                                               stdout=subprocess.PIPE,
-                                              stderr=subprocess.PIPE);
+                                              stderr=subprocess.PIPE)
         self.gitOutput = self.importProcess.stdout
         self.gitStream = self.importProcess.stdin
         self.gitError = self.importProcess.stderr
@@ -3975,7 +3975,7 @@ def run(self, args):
         self.loadUserMapFromCache()
         self.labels = {}
         if self.detectLabels:
-            self.getLabels();
+            self.getLabels()
 
         if self.detectBranches:
             ## FIXME - what's a P4 projectName ?
@@ -4061,9 +4061,9 @@ def run(self, args):
 
     def rebase(self):
         if os.system("git update-index --refresh") != 0:
-            die("Some files in your working directory are modified and different than what is in your index. You can use git update-index <filename> to bring the index up to date or stash away all your changes with git stash.");
+            die("Some files in your working directory are modified and different than what is in your index. You can use git update-index <filename> to bring the index up to date or stash away all your changes with git stash.")
         if len(read_pipe(["git", "diff-index", "HEAD", "--"])) > 0:
-            die("You have uncommitted changes. Please commit them before rebasing or stash them away with git stash.");
+            die("You have uncommitted changes. Please commit them before rebasing or stash them away with git stash.")
 
         [upstream, settings] = findUpstreamBranchPoint()
         if len(upstream) == 0:
@@ -4362,7 +4362,7 @@ def main():
                                    formatter = HelpFormatter())
 
     try:
-        (cmd, args) = parser.parse_args(sys.argv[2:], cmd);
+        (cmd, args) = parser.parse_args(sys.argv[2:], cmd)
     except:
         parser.print_help()
         raise
@@ -4378,7 +4378,7 @@ def main():
                 if os.path.exists(cmd.gitdir):
                     cdup = read_pipe(["git", "rev-parse", "--show-cdup"]).strip()
                     if len(cdup) > 0:
-                        chdir(cdup);
+                        chdir(cdup)
 
         if not isValidGitDir(cmd.gitdir):
             if isValidGitDir(cmd.gitdir + "/.git"):
-- 
2.35.GIT

