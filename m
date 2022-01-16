Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C276C433EF
	for <git@archiver.kernel.org>; Sun, 16 Jan 2022 16:07:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233455AbiAPQHo (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 16 Jan 2022 11:07:44 -0500
Received: from mail-dm6nam11on2054.outbound.protection.outlook.com ([40.107.223.54]:56160
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235587AbiAPQHh (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Jan 2022 11:07:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mxGgV8IlCLKeDM0XS/don7+UfVM/VpvxC9Af8TgT//X+92sR1ks/oKBfbMkJpqRxyqZp66qSfPEFfB+Thnw1bOFxDwDDXkgQ8gbLkbFRFhrOIg622UkniKznXzHn03NXLYYtCL23RCUUa2wYR35UkrV5uAWzAi7mkiI7pE2cHgH36+ZSF3bVkbGZ1Vuxe0CD7psSzZFJqtqSarwdKxbdoS/bPn+wCRvXQtgtzHox3gJWwc/OSRJF2iW4G7vYABJZc12T3dXmORxyIq+ssgkvj62N0fd9RztYnRScj7f7d97RxnlbGBKZfXwX3rKxWEhfuKF/oUGq6GSw/BaAPp7Vpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wQmmJWKf4PLRoEBWKYDDhzKn4rz5jXlZmIfJIkrbPFs=;
 b=TMMSOCO/Ou+hMDcCqnEjV9zSLhK7n0lBSGewOHq9cXHtftEUcLMocnhPS0MqUJ0cgpcTpbjWvrljoscT33rKDqlm8b8oo0g3JNtVfpB0UpXWG1tCTZ0Aa9Cpz8ICSIwooAUrPJp8DehfFgz6v1o1e2+ANIKx9oT5QAyakqiv67Jnjji2w8srCN85JkHV+6lfu1AVkilSq/iplnVUDrg56KeP0DlHvCp0YMcCroFaEtG79NUdq6tBtBPLy7dQMkcizxj7WsYyV+PSuo3NMkODdTXq0PK1cIWkCWd4w0GGAgnmmhjIrPE7/mURveYnxoId3PyquqVvGfAYWZQcKZfX4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wQmmJWKf4PLRoEBWKYDDhzKn4rz5jXlZmIfJIkrbPFs=;
 b=E6sndq2L/m1aS12l91hh4bkezClG2jttp/uyx+MnCTWsAGFJzjZ/QhmfuT+f4OHRGE2OZLkCcyE/Xe0BpJB95QL+kZTTMNJDCNZK435rerGiinwbGbhA7zJExtq4/utPXFhTdIOgzXltamhDvFrUTjgdd+lwjXR+RuuEQZZTsdB0SO8MOPJHsOlrfRIrTnPMyI0r2fCtil4mpSzMB/yerONLCUJNMQ2IG2CfW+UoEoE9sbQ1t3wa0p0kh5otBC4oD8RC7qScgcD6vdga4MstklDk4/aSdpvBY7z1nZZMbWvCwDnSkumaVY/w/c4/sWR31wzIm8egeAVfUGxRwSD/rQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB4849.namprd12.prod.outlook.com (2603:10b6:208:1c2::17)
 by BYAPR12MB2597.namprd12.prod.outlook.com (2603:10b6:a03:6e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.12; Sun, 16 Jan
 2022 16:07:33 +0000
Received: from BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::509e:bbb9:e1fb:26ed]) by BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::509e:bbb9:e1fb:26ed%4]) with mapi id 15.20.4888.013; Sun, 16 Jan 2022
 16:07:33 +0000
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
Subject: [PATCH v3 10/21] git-p4: removed brackets when assigning multiple return values
Date:   Sun, 16 Jan 2022 16:05:39 +0000
Message-Id: <20220116160550.514637-11-jholdsworth@nvidia.com>
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
X-MS-Office365-Filtering-Correlation-Id: 526650c0-ce20-4d1a-0117-08d9d90a4ded
X-MS-TrafficTypeDiagnostic: BYAPR12MB2597:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB2597140D4DD6E33A9FB1F52AC8569@BYAPR12MB2597.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:284;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RuKl2wqossWtD4fb9/ym4qutas7S6az+TTBtR5OD1gufNL1F0gz7jiRfWyltR1UFAHF1WTGlsHrkja3BkpYjTZ+HkAC6JKeef19ULAaHngpANxgA3TkcIEP3KWoGBr2h+IPYEQcSlmGrFjwIpIA+2ARIZcUHF+W8ltrO/xbtrGBRGGE570SbFul0hWlGsr2PYd56cw+P2W96MHlgtj0LQp9WvWZdTGkHH7Qc+7/rG6RyiWs6buooBvCL6D8f0JC/JzmuKO9LR5tLGfXnJJSHyFcZ/MFpkZ+J7eg9th+YcEeQXexOjmInk4ySYDRwXsaO2vmStjrWys8Vo2Jn+pVz4gfcAvcUUXgxKOFjnD2knX0q/dhvKnaN1651O3vzablHZJ/Rf88I7rbABkb6LGH0gCiVFrigJ3/CwIn8MYNydH28CS7WSl/iAQuOwwz/ozRPenQei2p0fWSMb4V/tGhGuPNnACHYVzhdV8dtJeuy7FdLGaLwAL8YYRiUtx76qqiI4pYt/EE8tib5pf5eztyrKB7GNU27aTa9Tvy31M9j39/xqC1fkmzCyOo5I47bBRKtfSWK8JBlU+KMMTPkgrBlk52awI5TdbTkBSTLeF8j2HoIsfBmd5tmMx4OeholHU+brm0nu2jpAIX+uhmtK+sM7Che4kSVmUgm/x1vlJa3RjjjBPEI//EuirtVDNJ0KFokwWLlIzuQctCbMiK0m89jGg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(38350700002)(38100700002)(8936002)(4326008)(83380400001)(186003)(1076003)(6512007)(110136005)(54906003)(107886003)(8676002)(5660300002)(316002)(66556008)(66476007)(55236004)(6506007)(52116002)(86362001)(36756003)(508600001)(66946007)(2906002)(26005)(7416002)(2616005)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3DsD/Pey2CdAkR3kspSQQBZHsZcnOygpu4AI6OfD6MUyJDLlA1bPCMZBAKBT?=
 =?us-ascii?Q?YW+KaYh2tAFcp9ktemFkwPdu9JDkY08x8vLJHdm1gySWhxfZKOlyWnUna2pU?=
 =?us-ascii?Q?O/qeRSrlZT0dBOORT6r1BdvfSuK846mD28CkpnhZ2bfWZ0wHXHOsCQnCz01E?=
 =?us-ascii?Q?OUezuY3gk4gYtW8Ev9KMiNcRoMXlYuGWrkzgMugvJYRNVZKJRzW0UnRcOQCH?=
 =?us-ascii?Q?zSXoo8oZ3t/MV1VayL+28DqbKLyfFrFvfj+wBYBDx/dWZLpiST7/e08QpXHt?=
 =?us-ascii?Q?LC2fQAQWHdHvnO7TWqoUp2IEh62KZXUAxqtylNFbQgOJFKUFpczkuhSPux3V?=
 =?us-ascii?Q?Pt64agWfFyjaurM7plGE7o1zGqJloQ6fz7c6JbltcTneIkZHdj+3REdWHnBX?=
 =?us-ascii?Q?jSYpwSSzk+9Og1DaL6uerqepRu/UKZ0P0wbliY5lKDPavVZAJ4BbdVHs+uN+?=
 =?us-ascii?Q?m/5bU28pZq9pzEVhZ55gwToTFyNkAdTgNBKc5FnHvfECDkoxVDl20QjgySqK?=
 =?us-ascii?Q?Uy4JoEl2NkXi+7Ro+kDvqzTtHoMpYqv7EyBmvAWMw9VNIUJSLDycr+rVUtMv?=
 =?us-ascii?Q?jLLwqyWQHgIL3NGVSTsrwJbrTmqvn5/PU4gAvcOmzlJqpXtW5uBQZHB198Ww?=
 =?us-ascii?Q?rhU/mgfARFvoY7YNWxxdJlJlu2Q8KB+xB90P4AB+1MoPAmpXWAqB+J2qX2JG?=
 =?us-ascii?Q?SkGkK8xN7hJJ2wkgVWCG/Zzl8XisWANZwXmyE3TsR5cd2XgcVByTduanU16k?=
 =?us-ascii?Q?vcSJGl0+QeUvXqfUeyOzMrpp+yvCRAKGBGrEv7VyKZKaPiQN9PONoTF9d6DW?=
 =?us-ascii?Q?P4WPe0syYUzeX7UdZfjpRujtG9fXagv+mJT5reA9ZFHbdw/0M4hY7dLf7EXt?=
 =?us-ascii?Q?hdU/0Z0UiJgZm/jxp7gRiYwdIgr81TVoRBp4G0TIb8DrEAawLXwvWWsg4f/o?=
 =?us-ascii?Q?QEQ8ZPX+YizVzPUqe2JEnl8ckhST/Cl9Vu2CEOXkhF+0zxxvlgQPHRgguOTM?=
 =?us-ascii?Q?ZXJXlmZQbRbI1jF05R3MO3gZrkMhiXEa9hXgAUL99dgADy2aF3210qsftDRu?=
 =?us-ascii?Q?gjrMtkTQq4p53WZ4kyIwYRBJ4aYOLOQiGc6rOza4y2HgfooQ8xZA3ymP9gyY?=
 =?us-ascii?Q?AelxPbtR7iSPIUeqhW3rqztHJx426IH7vpUWm7ofbQksMFmgiE7vFPvYGedi?=
 =?us-ascii?Q?XpKm6gTg5+JXd6jQsgHexnVwXOl1EZ6EQ8MetfrMFEp5uLHrBeysgXS/0Hdd?=
 =?us-ascii?Q?vkyCBJILBII6byv63SohP95pNqSNLyKZmad6FVrXD30UgM1XSFuuRwlav3NI?=
 =?us-ascii?Q?tgRxV4r2NIjrCVBtbxCfOaByzkZ5ETsGFfub97sTZdr+lJ1dD6EH8mIU0hI1?=
 =?us-ascii?Q?EPni09lR/KCv1gle0JecFs4O3zXwLxJ4ilNIdC7qTXvJ80WW6Z+RK0jn9oIe?=
 =?us-ascii?Q?60H4WK/hKvWZyY+61debUqSsKiUT1u/4zDlZFRZATgNBvbQRa4R6X9yOw2uz?=
 =?us-ascii?Q?xRzOrpyUOG+/mw+tp4ozZaBFQ1eD2ecQqSkY7tLHCEEcFGRChbc5qb07+R0F?=
 =?us-ascii?Q?9kBCYKkGjnsZBy61dZklmU5epQanjiresLQnkPgqbl7idXO58ZL96WKCXInA?=
 =?us-ascii?Q?WsfIKajyFHga/YIpuM5j0pE=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 526650c0-ce20-4d1a-0117-08d9d90a4ded
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2022 16:07:33.1789
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q0sTzQHadmfxxUt4WiHG0PIN63ntaizDI9eycXEl6BQh6IWFmx0Gc9lUu7ilgcQSb8k2LhUfn+YX3C1xCKzRPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2597
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In several places, git-p4 contains code of the form:

(a, b) = foo()

In each case, multiple values are returned through a tuple or a list and
bound into multiple values.

The brackets around the assigned variables are redundant and can be
removed:

a, b = foo()

Signed-off-by: Joel Holdsworth <jholdsworth@nvidia.com>
---
 git-p4.py | 40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 534f260e9f..385ad98384 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -300,7 +300,7 @@ def run_hook_command(cmd, param):
     cli = [cmd] + param
     use_shell = False
     if platform.system() == 'Windows':
-        (root,ext) = os.path.splitext(cmd)
+        root, ext = os.path.splitext(cmd)
         if ext == "":
             exe_path = os.environ.get("EXEPATH")
             if exe_path is None:
@@ -343,7 +343,7 @@ def read_pipe_full(c, *k, **kw):
 
     p = subprocess.Popen(
         c, stdout=subprocess.PIPE, stderr=subprocess.PIPE, *k, **kw)
-    (out, err) = p.communicate()
+    out, err = p.communicate()
     return (p.returncode, out, decode_text_stream(err))
 
 
@@ -354,7 +354,7 @@ def read_pipe(c, ignore_error=False, raw=False, *k, **kw):
 
        If raw is True, do not attempt to decode output text.
        """
-    (retcode, out, err) = read_pipe_full(c, *k, **kw)
+    retcode, out, err = read_pipe_full(c, *k, **kw)
     if retcode != 0:
         if ignore_error:
             out = ""
@@ -369,7 +369,7 @@ def read_pipe_text(c, *k, **kw):
     """Read output from a command with trailing whitespace stripped. On error,
        returns None.
        """
-    (retcode, out, err) = read_pipe_full(c, *k, **kw)
+    retcode, out, err = read_pipe_full(c, *k, **kw)
     if retcode != 0:
         return None
     else:
@@ -423,7 +423,7 @@ def p4_has_move_command():
         return False
     cmd = p4_build_cmd(["move", "-k", "@from", "@to"])
     p = subprocess.Popen(cmd, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
-    (out, err) = p.communicate()
+    out, err = p.communicate()
     err = decode_text_stream(err)
     # return code will be 1 in either case
     if err.find("Invalid option") >= 0:
@@ -664,7 +664,7 @@ def p4_keywords_regexp_for_file(file):
     if not os.path.exists(file):
         return None
     else:
-        (type_base, type_mods) = split_p4_type(p4_type(file))
+        type_base, type_mods = split_p4_type(p4_type(file))
         return p4_keywords_regexp_for_type(type_base, type_mods)
 
 
@@ -1212,7 +1212,7 @@ def p4ChangesForPaths(depotPaths, changeRange, requestedBlockSize):
         parts = changeRange.split(',')
         assert len(parts) == 2
         try:
-            (changeStart, changeEnd) = p4ParseNumericChangeRange(parts)
+            changeStart, changeEnd = p4ParseNumericChangeRange(parts)
             block_size = chooseBlockSize(requestedBlockSize)
         except ValueError:
             changeStart = parts[0][1:]
@@ -1437,7 +1437,7 @@ def processContent(self, git_mode, relPath, contents):
            """
         if self.exceedsLargeFileThreshold(relPath, contents) or self.hasLargeFileExtension(relPath):
             contentTempFile = self.generateTempFile(contents)
-            (pointer_git_mode, contents, localLargeFile) = self.generatePointer(contentTempFile)
+            pointer_git_mode, contents, localLargeFile = self.generatePointer(contentTempFile)
             if pointer_git_mode:
                 git_mode = pointer_git_mode
             if localLargeFile:
@@ -1808,7 +1808,7 @@ def patchRCSKeywords(self, file, regexp):
         """Attempt to zap the RCS keywords in a p4 controlled file matching the
            given regex.
            """
-        (handle, outFileName) = tempfile.mkstemp(dir='.')
+        handle, outFileName = tempfile.mkstemp(dir='.')
         try:
             with os.fdopen(handle, "wb") as outFile, open(file, "rb") as inFile:
                 for line in inFile.readlines():
@@ -1840,7 +1840,7 @@ def p4UserForCommit(self,id):
     def checkValidP4Users(self,commits):
         """Check if any git authors cannot be mapped to p4 users."""
         for id in commits:
-            (user,email) = self.p4UserForCommit(id)
+            user, email = self.p4UserForCommit(id)
             if not user:
                 msg = "Cannot find p4 user for email %s in commit %s." % (email, id)
                 if gitConfigBool("git-p4.allowMissingP4Users"):
@@ -1915,7 +1915,7 @@ def prepareSubmitTemplate(self, changelist=None):
            outside the depot path we're committing into.
            """
 
-        [upstream, settings] = findUpstreamBranchPoint()
+        upstream, settings = findUpstreamBranchPoint()
 
         template = """\
 # A Perforce Change Specification.
@@ -2049,7 +2049,7 @@ def applyCommit(self, id):
         print("Applying", read_pipe(["git", "show", "-s",
                                      "--format=format:%h %s", id]))
 
-        (p4User, gitEmail) = self.p4UserForCommit(id)
+        p4User, gitEmail = self.p4UserForCommit(id)
 
         diff = read_pipe_lines(
             ["git", "diff-tree", "-r"] + self.diffOpts + ["{}^".format(id), id])
@@ -2214,7 +2214,7 @@ def applyCommit(self, id):
         #
         logMessage = extractLogMessageFromGitCommit(id)
         logMessage = logMessage.strip()
-        (logMessage, jobs) = self.separate_jobs_from_description(logMessage)
+        logMessage, jobs = self.separate_jobs_from_description(logMessage)
 
         template = self.prepareSubmitTemplate(update_shelve)
         submitTemplate = self.prepareLogMessage(template, logMessage, jobs)
@@ -2232,7 +2232,7 @@ def applyCommit(self, id):
             submitTemplate += separatorLine
             submitTemplate += self.get_diff_description(editedFiles, filesToAdd, symlinks)
 
-        (handle, fileName) = tempfile.mkstemp()
+        handle, fileName = tempfile.mkstemp()
         tmpFile = os.fdopen(handle, "w+b")
         if self.isWindows:
             submitTemplate = submitTemplate.replace("\n", "\r\n")
@@ -2439,7 +2439,7 @@ def run(self, args):
             if len(allowSubmit) > 0 and not self.master in allowSubmit.split(","):
                 die("%s is not in git-p4.allowSubmit" % self.master)
 
-        [upstream, settings] = findUpstreamBranchPoint()
+        upstream, settings = findUpstreamBranchPoint()
         self.depotPath = settings['depot-paths'][0]
         if len(self.origin) == 0:
             self.origin = upstream
@@ -3039,7 +3039,7 @@ def streamOneP4File(self, file, contents):
                 file_path, relPath, format_size_human_readable(size)))
             sys.stdout.flush()
 
-        (type_base, type_mods) = split_p4_type(file["type"])
+        type_base, type_mods = split_p4_type(file["type"])
 
         git_mode = "100644"
         if "x" in type_mods:
@@ -3104,7 +3104,7 @@ def streamOneP4File(self, file, contents):
             contents = [regexp.sub(br'$\1$', c) for c in contents]
 
         if self.largeFileSystem:
-            (git_mode, contents) = self.largeFileSystem.processContent(git_mode, relPath, contents)
+            git_mode, contents = self.largeFileSystem.processContent(git_mode, relPath, contents)
 
         self.writeToGitStream(git_mode, relPath, contents)
 
@@ -3572,7 +3572,7 @@ def getBranchMapping(self):
         configBranches = gitConfigList("git-p4.branchList")
         for branch in configBranches:
             if branch:
-                (source, destination) = branch.split(":")
+                source, destination = branch.split(":")
                 self.knownBranches[destination] = source
 
                 lostAndFoundBranches.discard(destination)
@@ -4180,7 +4180,7 @@ def rebase(self):
         if len(read_pipe("git diff-index HEAD --")) > 0:
             die("You have uncommitted changes. Please commit them before rebasing or stash them away with git stash.")
 
-        [upstream, settings] = findUpstreamBranchPoint()
+        upstream, settings = findUpstreamBranchPoint()
         if len(upstream) == 0:
             die("Cannot find upstream branchpoint for rebase")
 
@@ -4477,7 +4477,7 @@ def main():
                                    formatter=HelpFormatter())
 
     try:
-        (cmd, args) = parser.parse_args(sys.argv[2:], cmd)
+        cmd, args = parser.parse_args(sys.argv[2:], cmd)
     except:
         parser.print_help()
         raise
-- 
2.34.1

