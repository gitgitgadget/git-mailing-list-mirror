Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7D7BC433FE
	for <git@archiver.kernel.org>; Thu, 10 Feb 2022 16:47:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244729AbiBJQrX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Feb 2022 11:47:23 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244701AbiBJQrP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Feb 2022 11:47:15 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2054.outbound.protection.outlook.com [40.107.96.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7914E1BE
        for <git@vger.kernel.org>; Thu, 10 Feb 2022 08:47:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lsrm6Or0ajSW4L+yLCwhErl942yxBuyyD3I1dnWNv8pfSSNtySp/nmjBos5j8SAtKSI5KP9igS3kkqqU3Xhvji23ijkMk6mw3CJSU7PQ7cgrrIBG0z+5nK6LpypiJZU7sL3t0TidFy3yETt303PcN4wG6dqDATHfg5x2gJ4W1CWsUyDhY0ju+xtO09FDi5w7Jd3a0GvkNVsn1o+3XPpdsWidOGmh6JJy2ygkAVmIyEPd4YQtPhLH8HrSDy5mBLvEz06onrcdfJuSlMollNVc+4c/UCGFF4AR6LWebibj69XccDBC5NkNhvUxww75h1QF0wm+KVUsPCleHMTLx0RJzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1pqC+qKfClyLETXDbWBzaz0F9KFRTe95WzS+7PmkFR4=;
 b=OTzirK9okbVmzoINtyGMBxSq/ez7gxbLQCkXCYuPLg09JvLI2DWD3dxxOaClCDI0y+h18RGeJ+zunLrAMCIepmS2ovcjHG9fbDbxm2zUpiC0HZMfGE0dI52xdD+TUOhk/ChNZ+L8FpiI7iERlbo1oYqJRSTlpchUt4KSklmE2hhMJcJrjBeNurwTES026qFbAFuJsnp2Cy5o4djgBsNL7igyBG7x7JpeCkB3zBNHyMR0KZXyt3slVU3MyRMN961iRLIya0CFC5HV7cavWi7406gvRnRBdOY/uWrorGFgywZJYUkxi5hEAFVDvlVJWybAev6IzkfV6b4vTJ4C/vX+Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1pqC+qKfClyLETXDbWBzaz0F9KFRTe95WzS+7PmkFR4=;
 b=LOJj8R3PJE2NTUuOhve5GAA+M5t1EsPn9Rwb6LkEpO6tEzKE0exdHQfLAKj4YYv/3QS4VtEhBLoO8kRXR574eb2mEHm8rHjOTPJvIuqZ3b2bS7ewe5U2o2zZ5QC35khgGPrKr2k4wTiGTRT7JeZnMWPl+ciTbNf7wMrmlmIgrq2tpxz6y8aoDET0y3ArAVTqhhfmJiTkBQN6CUANa2ndV5Jip83iNSM01D17soewkjoqjvc4dWHQ8BRIizqzTeaEDr3GpQpI5m+uBnYPQgCGSxEsdySuOHZCYGPtGn3O0LZ0YexhGY6qO/wcvQbhL5P/wYp1ihbi8rOQZAM3l2vmdA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB4849.namprd12.prod.outlook.com (2603:10b6:208:1c2::17)
 by BN6PR12MB1362.namprd12.prod.outlook.com (2603:10b6:404:1a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Thu, 10 Feb
 2022 16:47:14 +0000
Received: from BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::dca7:5323:3:cc10]) by BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::dca7:5323:3:cc10%2]) with mapi id 15.20.4951.021; Thu, 10 Feb 2022
 16:47:14 +0000
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
Subject: [PATCH v4 10/22] git-p4: removed brackets when assigning multiple return values
Date:   Thu, 10 Feb 2022 16:46:15 +0000
Message-Id: <20220210164627.279520-11-jholdsworth@nvidia.com>
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
X-MS-Office365-Filtering-Correlation-Id: 96fa8221-7d3a-4780-2c2b-08d9ecb4fd61
X-MS-TrafficTypeDiagnostic: BN6PR12MB1362:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB13625DB15FC1AAEA7EC1811CC82F9@BN6PR12MB1362.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:284;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X8HXd/Ri6Ya6qxNlarUkl7Yh54N5UsXqsPwhd6cgr54wwg7Qxu2e1KlObNmhY+QbKcYn+9t5fkxqqSxbwIlgXPqFiBQWYE5oEA6uNqmI0qk360HHuKfyyJmSrdN4KxehEWtZ+lOAr0UepRqxCK1F0BKQ3bD1WzqjOj7F0/dWaSJD3xc4L7r7RO+A2n2O8PfXXMU6EKwhAMzC0NwSpBuwTJ1sPUec17+77oG82K8/zTiA9htFJ/U0WI3PsWZBfr16p32kHoxRXtUs8BEU4B7YWkBrspWrHFp01/8iH3XfnJNKjIbYf6JNd7wMjge8vttjmcS6bfvBd7SrABiIMJi7oQdA1Bm8/vRNyep/kTHAd41+JhYxQpOUyvJ+iOfatYEcSiUVks95Csde4UeZ7Mm/MQsSzQN96pnawaYGFE+UCBBr4MgU8yVoWo6QrWN3UwkvAIBZ/zbmBd11aUnO/k9JLZJ3eyG50HrXsa42/qlSXlM7EI7XAxI3VuiD+d9/D3SV0f8yh/fzBf3lk0X/QWn5BT1Oz5WJprKX92tqVjuZUaolXdhTG6IJ1Ayu+rGFvHAFpk2SE3DxWVYzQOtiEjG6g9CwuOP9UoZk2XxMzTcrNAsI1Rp1W1Gl28A/gpEvHA31Ns151eAvDphwzEYR5f9mLtWUpirkTz1hbGDLLJQDSN4JRWBfiVYLA7KjHPPisT3fQj7CdOjXM8cxhhezfrxyxA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(86362001)(6486002)(7416002)(2906002)(8676002)(66946007)(52116002)(6506007)(8936002)(83380400001)(2616005)(38100700002)(38350700002)(4326008)(1076003)(107886003)(508600001)(66556008)(66476007)(5660300002)(6512007)(36756003)(55236004)(316002)(110136005)(54906003)(26005)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UMicQYSsKqkaevJbaNYFUTuDnq4JAXupUY52nwirEKQLglyy4ohP7e/+hC7J?=
 =?us-ascii?Q?Smae6CyPhYw2TnXYpQ4dgXimvnLsxGj52bhlH0J9GGrg4QGD/Okr6/28A+9+?=
 =?us-ascii?Q?4L59DJNHU6efVOhF/YcxD1wrQ0s3J8L8E5pQB3ij43FdU/flEeMP5Hw5/kFy?=
 =?us-ascii?Q?ggtiIMg09pA9uuAn01mR6scwDWE/IEJCHTss9NP+EZNaXYL+hImg1uYMHeOO?=
 =?us-ascii?Q?8fIsJSMlB6H5Clc9ERprSpE21nuPV5sm7Da+MF+BAGRItiv3jNFn+PObOVp6?=
 =?us-ascii?Q?GOxjgD/LzWCHqtvyzTAf/1SuVjTIhHT+2SxbW8nR4kmOH5FvTncZZPJrtE5T?=
 =?us-ascii?Q?5Nw9SxfBrahBApAXGj+7QC7G322nm9FsPC5MC81TzSB4VuBNFNA41DM1uLcZ?=
 =?us-ascii?Q?RyHkGaPcMiG4t9bD/FCPw0ZFoYJ189RLg1rwBfXW9dAn5EF7WNtxduH2W6hy?=
 =?us-ascii?Q?SnlnTXKmhYLTlzLDakwZYDzoikWNHiW5+2Avi9RGIitI+vVOlkSAkhQb55Tb?=
 =?us-ascii?Q?ld8TDNMCv+VE78VQhX2jVupd+sxIrMFqxZm7CrSyUQ/4PhzxZcnU78Tnuhaj?=
 =?us-ascii?Q?2wioZHNcSHz//EcXSH0fH211a21MSNzl9F2ooCVV8pnKXRAcZ7Xi3EsWihQW?=
 =?us-ascii?Q?1+KcMeRisqYbCjbJRxKYBgm+rqh/UOxcEEJuAQ1S/0a3UHZ59isNJIR/qCiE?=
 =?us-ascii?Q?awnPJNbUelNiOr2EWvGlreGZqYHPAvlK/zgc8/uXOl7jAMkQxT4iEVZd7GTl?=
 =?us-ascii?Q?U0DRFDBWZSU2pCcayii7tmkWGvfI6CwKXlkW0wZmidJqAdtwB7QMXz4q36sF?=
 =?us-ascii?Q?FzYRGiVO/uAwKlC9jOkMkYCo/y6CdWEgk4wuGjJdfOAIkPcwNQEgBFBWVzDO?=
 =?us-ascii?Q?vJ+HBIIW6Hpy7ykGbN8rNrgytLyHbHMbuN2eyl3bRk/d4Hcq65c/wktg1Rso?=
 =?us-ascii?Q?6ATxZLpVQIQbWXkabJV19+GR3wp0vCjtVdUbjb1fPqYL2qsSj7qsb9nAmgF8?=
 =?us-ascii?Q?uGKAsLNwb5Xm8YlpVUMu9D7oLp8XA1VRA4Vj3pCDj5P4syrH8d5Chku3ENok?=
 =?us-ascii?Q?X9g0jOPkZTLkBJr8banUfRPAc2n5nD8N7nVNichbawCBfXIPW1k2pHkDgFPH?=
 =?us-ascii?Q?nYqB5V2d/s2muO7MrtnhmswYlhXg/IpQ/ByEICX8T41W0dlXghkRpCGEUWgg?=
 =?us-ascii?Q?vqPmQhXgHnV667TKt2/FJM8ifzgpJ3jvZgIGIQdSeeM/sS/4IQTNDC2eHSxp?=
 =?us-ascii?Q?7/NbuVN3+J7qoLslxkSbueX5To2GIi2igVpoHvi8ybxIFnl3sDrVtBMR0klY?=
 =?us-ascii?Q?BH6dwxdApqqYeyT/XnIjlMiO6ke7uZw5v8XBQZ+FnVuCfbu6VWnlD8tFCBBr?=
 =?us-ascii?Q?3zgwcbqhzamvex64MsqHQZukGpW1kNIGj+l4FUNPyzzVzLq23w+6ZICm652W?=
 =?us-ascii?Q?uvUUdmsX/kFaS6A3tPIPs1gs9e7B7iME/wn1V1z5BtuMYnT8ekq/lRPJrdST?=
 =?us-ascii?Q?m/nOHecaHutTtDw5MEHyw4KwniGT7ROGJGK0qJtiRyIVpwmZ9cgqah4ITD5N?=
 =?us-ascii?Q?tKo/n+2leEF35os32gImFMGBF2nw9HQ6xD1CSg/mZUOQa8oujhODHJZ1C2WJ?=
 =?us-ascii?Q?VK7HEvaBP0FyXKjvu5/IjyY=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96fa8221-7d3a-4780-2c2b-08d9ecb4fd61
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2022 16:47:14.0639
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZyW0kYZjeDSkOziFo003ELKKlvOBZXA1PeaBUh5kzcb2/DeVi1qks2A4qRplpuX82aTqpiHMBX7Y5W4KtkSOdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1362
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
 git-p4.py | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 0353bca289..0d444d2aa4 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -285,7 +285,7 @@ def read_pipe_full(c, *k, **kw):
 
     p = subprocess.Popen(
         c, stdout=subprocess.PIPE, stderr=subprocess.PIPE, *k, **kw)
-    (out, err) = p.communicate()
+    out, err = p.communicate()
     return (p.returncode, out, decode_text_stream(err))
 
 
@@ -296,7 +296,7 @@ def read_pipe(c, ignore_error=False, raw=False, *k, **kw):
 
        If raw is True, do not attempt to decode output text.
        """
-    (retcode, out, err) = read_pipe_full(c, *k, **kw)
+    retcode, out, err = read_pipe_full(c, *k, **kw)
     if retcode != 0:
         if ignore_error:
             out = ""
@@ -311,7 +311,7 @@ def read_pipe_text(c, *k, **kw):
     """Read output from a command with trailing whitespace stripped. On error,
        returns None.
        """
-    (retcode, out, err) = read_pipe_full(c, *k, **kw)
+    retcode, out, err = read_pipe_full(c, *k, **kw)
     if retcode != 0:
         return None
     else:
@@ -365,7 +365,7 @@ def p4_has_move_command():
         return False
     cmd = p4_build_cmd(["move", "-k", "@from", "@to"])
     p = subprocess.Popen(cmd, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
-    (out, err) = p.communicate()
+    out, err = p.communicate()
     err = decode_text_stream(err)
     # return code will be 1 in either case
     if err.find("Invalid option") >= 0:
@@ -606,7 +606,7 @@ def p4_keywords_regexp_for_file(file):
     if not os.path.exists(file):
         return None
     else:
-        (type_base, type_mods) = split_p4_type(p4_type(file))
+        type_base, type_mods = split_p4_type(p4_type(file))
         return p4_keywords_regexp_for_type(type_base, type_mods)
 
 
@@ -1154,7 +1154,7 @@ def p4ChangesForPaths(depotPaths, changeRange, requestedBlockSize):
         parts = changeRange.split(',')
         assert len(parts) == 2
         try:
-            (changeStart, changeEnd) = p4ParseNumericChangeRange(parts)
+            changeStart, changeEnd = p4ParseNumericChangeRange(parts)
             block_size = chooseBlockSize(requestedBlockSize)
         except ValueError:
             changeStart = parts[0][1:]
@@ -1379,7 +1379,7 @@ def processContent(self, git_mode, relPath, contents):
            """
         if self.exceedsLargeFileThreshold(relPath, contents) or self.hasLargeFileExtension(relPath):
             contentTempFile = self.generateTempFile(contents)
-            (pointer_git_mode, contents, localLargeFile) = self.generatePointer(contentTempFile)
+            pointer_git_mode, contents, localLargeFile = self.generatePointer(contentTempFile)
             if pointer_git_mode:
                 git_mode = pointer_git_mode
             if localLargeFile:
@@ -1750,7 +1750,7 @@ def patchRCSKeywords(self, file, regexp):
         """Attempt to zap the RCS keywords in a p4 controlled file matching the
            given regex.
            """
-        (handle, outFileName) = tempfile.mkstemp(dir='.')
+        handle, outFileName = tempfile.mkstemp(dir='.')
         try:
             with os.fdopen(handle, "wb") as outFile, open(file, "rb") as inFile:
                 for line in inFile.readlines():
@@ -1782,7 +1782,7 @@ def p4UserForCommit(self,id):
     def checkValidP4Users(self,commits):
         """Check if any git authors cannot be mapped to p4 users."""
         for id in commits:
-            (user,email) = self.p4UserForCommit(id)
+            user, email = self.p4UserForCommit(id)
             if not user:
                 msg = "Cannot find p4 user for email %s in commit %s." % (email, id)
                 if gitConfigBool("git-p4.allowMissingP4Users"):
@@ -1857,7 +1857,7 @@ def prepareSubmitTemplate(self, changelist=None):
            outside the depot path we're committing into.
            """
 
-        [upstream, settings] = findUpstreamBranchPoint()
+        upstream, settings = findUpstreamBranchPoint()
 
         template = """\
 # A Perforce Change Specification.
@@ -1991,7 +1991,7 @@ def applyCommit(self, id):
         print("Applying", read_pipe(["git", "show", "-s",
                                      "--format=format:%h %s", id]))
 
-        (p4User, gitEmail) = self.p4UserForCommit(id)
+        p4User, gitEmail = self.p4UserForCommit(id)
 
         diff = read_pipe_lines(
             ["git", "diff-tree", "-r"] + self.diffOpts + ["{}^".format(id), id])
@@ -2156,7 +2156,7 @@ def applyCommit(self, id):
         #
         logMessage = extractLogMessageFromGitCommit(id)
         logMessage = logMessage.strip()
-        (logMessage, jobs) = self.separate_jobs_from_description(logMessage)
+        logMessage, jobs = self.separate_jobs_from_description(logMessage)
 
         template = self.prepareSubmitTemplate(update_shelve)
         submitTemplate = self.prepareLogMessage(template, logMessage, jobs)
@@ -2174,7 +2174,7 @@ def applyCommit(self, id):
             submitTemplate += separatorLine
             submitTemplate += self.get_diff_description(editedFiles, filesToAdd, symlinks)
 
-        (handle, fileName) = tempfile.mkstemp()
+        handle, fileName = tempfile.mkstemp()
         tmpFile = os.fdopen(handle, "w+b")
         if self.isWindows:
             submitTemplate = submitTemplate.replace("\n", "\r\n")
@@ -2381,7 +2381,7 @@ def run(self, args):
             if len(allowSubmit) > 0 and not self.master in allowSubmit.split(","):
                 die("%s is not in git-p4.allowSubmit" % self.master)
 
-        [upstream, settings] = findUpstreamBranchPoint()
+        upstream, settings = findUpstreamBranchPoint()
         self.depotPath = settings['depot-paths'][0]
         if len(self.origin) == 0:
             self.origin = upstream
@@ -2981,7 +2981,7 @@ def streamOneP4File(self, file, contents):
                 file_path, relPath, format_size_human_readable(size)))
             sys.stdout.flush()
 
-        (type_base, type_mods) = split_p4_type(file["type"])
+        type_base, type_mods = split_p4_type(file["type"])
 
         git_mode = "100644"
         if "x" in type_mods:
@@ -3046,7 +3046,7 @@ def streamOneP4File(self, file, contents):
             contents = [regexp.sub(br'$\1$', c) for c in contents]
 
         if self.largeFileSystem:
-            (git_mode, contents) = self.largeFileSystem.processContent(git_mode, relPath, contents)
+            git_mode, contents = self.largeFileSystem.processContent(git_mode, relPath, contents)
 
         self.writeToGitStream(git_mode, relPath, contents)
 
@@ -3514,7 +3514,7 @@ def getBranchMapping(self):
         configBranches = gitConfigList("git-p4.branchList")
         for branch in configBranches:
             if branch:
-                (source, destination) = branch.split(":")
+                source, destination = branch.split(":")
                 self.knownBranches[destination] = source
 
                 lostAndFoundBranches.discard(destination)
@@ -4122,7 +4122,7 @@ def rebase(self):
         if len(read_pipe(["git", "diff-index", "HEAD", "--"])) > 0:
             die("You have uncommitted changes. Please commit them before rebasing or stash them away with git stash.")
 
-        [upstream, settings] = findUpstreamBranchPoint()
+        upstream, settings = findUpstreamBranchPoint()
         if len(upstream) == 0:
             die("Cannot find upstream branchpoint for rebase")
 
@@ -4419,7 +4419,7 @@ def main():
                                    formatter=HelpFormatter())
 
     try:
-        (cmd, args) = parser.parse_args(sys.argv[2:], cmd)
+        cmd, args = parser.parse_args(sys.argv[2:], cmd)
     except:
         parser.print_help()
         raise
-- 
2.35.GIT

