Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C942C433F5
	for <git@archiver.kernel.org>; Thu, 13 Jan 2022 13:48:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235499AbiAMNsY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Jan 2022 08:48:24 -0500
Received: from mail-dm6nam10on2042.outbound.protection.outlook.com ([40.107.93.42]:49472
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235480AbiAMNsT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jan 2022 08:48:19 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R89oFbWFFajZ1LVCEPKstajniu/wW8hcikFZC7eu7pNR8JLrlzLgUMchqlj9VL9sBz9+wKERMHsqXvqatURJvgpfKG8nRE0L3S034q28cund5X5I2q0Fhl0LEsC4ZmFGWJOySMLwfTsCYxkedjga4BJJXnuN5FTQtzlp3TxvnJJMNlD00u1OtJP1r/x5UahAFKT9RD3hBwIV2SliGfgDh9yWKKkwyuDmyidYHeyfKyr1tgjpOuRUaTag1QdL9/A3VJpbkHkCsvLyrhEXNuqdKElzvxOJ4ZQdMPftfOLqA6dfLayTxzgEMH1e9zxP5UQkGtoyy6yev9k5+4Liv9736g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xX+3DOIjmm51bZ6nnSGnBKMX9LKrx7QoRbEemMBoOWY=;
 b=RP8fiZNOMGjbJy7ZYFSKJWVPjjga0066+Y1vNV9GwfKsXhZoQuJemqqJRUDW/89EOyzIIqT3jEtTFkCDlkwb6zMKrlfvKlvopH6oFxY6t9zzdyEPg4ahrpC3g0CKqmbHGWTkjSX99pD/idKRYHK3asKh0Y71xPfYSbhOOG7n8YVz3OfMcUl4GhH1oUEatPWXeL7E40ovBFKB/swKzw6KqyCCFS+q2lT4JXpj8VcrAVh7so4GSJm3xNJXobvNcClzDwOG3VtUjmOED0sqf0HXN5Al/fbQJIn5uZtnb137ZQvHNhf+thWnDjj2BoW5FZblb/YEf8uHl02X7nths3lxLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xX+3DOIjmm51bZ6nnSGnBKMX9LKrx7QoRbEemMBoOWY=;
 b=cD9guryrThkDpmk9p46N1ZDYCCX7kUfyQ5RmWgOmP0ENSxvDkBURDc3ymY87y/C3JBGFEHrHZwQxS/JYsJq8QWJOjPYA8nj4NXmPmRErBa2KPftpGR8oWw7FcxH/v3cBs7hmPCO2M6FIzw4MF7iNgYlWcxkNOt0NOHIT7tCYwG0U6u0dvRjxWCrBRpejCZHI2ZFiX9Dd7GneT+VRkROzyYmMH/UOijgG0iKU4YvbO0ODxJEX2E8YO8PRrSU1GXrvHzbE8pPmDb4Kx5QVfPBlBvGtN3j/YUmtagfHt0eSzezK6eVcxSSn6dKOXtyhHzzRa7p1wNs4Qg2dsxXHpbyDJw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB4849.namprd12.prod.outlook.com (2603:10b6:208:1c2::17)
 by MN2PR12MB3791.namprd12.prod.outlook.com (2603:10b6:208:167::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Thu, 13 Jan
 2022 13:48:18 +0000
Received: from BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::509e:bbb9:e1fb:26ed]) by BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::509e:bbb9:e1fb:26ed%4]) with mapi id 15.20.4888.011; Thu, 13 Jan 2022
 13:48:18 +0000
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
Subject: [PATCH v2 10/21] git-p4: removed brackets when assigning multiple return values
Date:   Thu, 13 Jan 2022 13:47:17 +0000
Message-Id: <20220113134728.23192-11-jholdsworth@nvidia.com>
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
X-MS-Office365-Filtering-Correlation-Id: 7d8eaa77-aedc-4a25-7023-08d9d69b5aa0
X-MS-TrafficTypeDiagnostic: MN2PR12MB3791:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB37919204DEFA99972164F364C8539@MN2PR12MB3791.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:284;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rR4mrvv8XBz9ckG9U1vLDbf8C4U93yK5uSYp0rp6O1Q9LKSFgI/XrRv2hRSb8Izd+aPUO041GgiGgmj7osWGcIkNisV8bGGpuW71LLXTr8/WRzwwDQNF4XFxGbStz4bYmqbi3YommrkcECCNHazgqmDglpmVt9kayYvh2aKd0ABTWabjzOHLslOctZ9PoDC9CDmRo3+18/8hJKTIndUFv4OtaqEowF6sYoaPRUvAx/hbz40cCnIs9J0zC0Ltp6UJzOAuuRWdpe4dSqUPC4LcA3kZnL5FEjMOn02WwN2nohgTHQQPe82VzzcJmBCuAsjj99gNHg3dAd4/i4VuzWXIl5Y9B9SBZWu4LT9HQPfJvxd2h11nIdr1EaqWmS9hm8XqN9vFaCbA+Eesf8Zo6j9jZAd4pZsBOmGQ1fBF8VN/451s4K5iFQOllKvGJm/WkcWuiFmb0SjKENq4+N+5ae42pVip4DxsV69/+qgnSDZdk65pQGPjs+y+1L+LzRDmxRAYj4ZMpGSxIgYcpEnWaIl6MSImI7wq6pDzuXbINAwlrr95YxBb2IinO68KIgJidlCStgU4HYROTZMZ5qC4nA/acsqsnOfYaaNfVDdYDAIi7jnoaRhWYNeR6gU+8euxYGBRSDtqn6PKbPC8SD23oa/ook9r+BmeJOXYV4hzfhCbP5GIK8I21iVB7sogi1youVj2++mEOw8PibxqccVyEPUVXw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(316002)(5660300002)(2906002)(8676002)(186003)(66946007)(66476007)(6486002)(66556008)(7416002)(52116002)(38350700002)(110136005)(508600001)(36756003)(8936002)(83380400001)(1076003)(4326008)(86362001)(6512007)(2616005)(107886003)(6506007)(54906003)(38100700002)(55236004)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yYxnVPFNQwflew/cZVhWlZhxWV5XkbFgHEq/IHwlRsv0QZaUlJ2DvknStywZ?=
 =?us-ascii?Q?dKblXt8kWFNB4/80xkGiMSRYE3ysxe36xaXz+CsaTGdvdT3+jlRxKpxu8OIS?=
 =?us-ascii?Q?9dCnvQo8l6vCkjgNcvw55ZrIHOkDj0YKJygzeH4BUB6S9wpwCm84QHuswsPp?=
 =?us-ascii?Q?Zv/1wvbG8/PIv6PaFxffBK8MtlbzIBT1SW8VjBtBuUdmDQ0VE0zNYOM2hCCK?=
 =?us-ascii?Q?23iXRNFCs/3GWC97otgq/COwDHJAG8Lx8S0/bw0fWyShcVBcU9F8UgJfIunI?=
 =?us-ascii?Q?u5xob3ScDBG2aXeuEvnBTDjUoYHnPl+IYJdRl1QQqt4bNoXkTe5HzsscmI38?=
 =?us-ascii?Q?Ny350bKJSC6GubqjjuWcWBdx2cfUo3i2W39ZvhM2Y2PBmZqyJ9PK9T6TROiQ?=
 =?us-ascii?Q?gKtH7QTVsAmJmr+Q4SwW6FTk83Ip31vFMPnvqb7/kK1XZ7Lpcw0c8D9ZvXa4?=
 =?us-ascii?Q?UbP29j23ibuKenEuRD9LQLCgVAtY4k7sgLXxOji4mAu5e5lhShN2nmjPrg6K?=
 =?us-ascii?Q?j+OUFLtGa0zacgt0axk++i2dSoyT9aZY9L7x2WMgpJ9SW1o2UZYDaqYSWhBO?=
 =?us-ascii?Q?QhCaVnloZuIPSGecyIVlW/Pwc98DVw+5hMBIfGvoQaKFLQH7w5I20Ocl/zBF?=
 =?us-ascii?Q?6zhHOUWtRAOTDMlTX5vVnVN9WvzhjbaortTixqATsoGgDwYYSll9SA9g0STd?=
 =?us-ascii?Q?PLUNqFK0S9Z5cjQyaK5+FRMz9LlaCGM9QzQx+3q9dMk24OBdQIEPqiqbaezY?=
 =?us-ascii?Q?a3TlBOhkfCiC/jhW5Rtl2nZ4M0usMdof5Ai1XeZOt6rqe8Npo10SfTM0GBDw?=
 =?us-ascii?Q?1Mz76A9ISrjVqOmVkrA23UKiiV2TRVmvpWym3yNivs8+pQ8XwrvvOzIcxBzH?=
 =?us-ascii?Q?VZnWJ7NTyEmXJMTvmbs/vhsuXzftJ/g1FqHWy4i9nVPSF15Jhfx+ZlKL0wX5?=
 =?us-ascii?Q?FUKNKt9bTbXehF56AUQJojMieWcgU7OGCUgsZ76s72zSd9KNjIuysvcPJP2m?=
 =?us-ascii?Q?5l16KX3bb9OtJ1sXiQqgz5I/dY+N2pAbh4TiHvjGs3t+4kLMKFl2w9t9gm51?=
 =?us-ascii?Q?+9/ZDfbA5IMnSxSVQ4OvX16EUJwLcAXtSOarNUlxn7HHnykmb3DtYkIWmGIC?=
 =?us-ascii?Q?aJWC7jmg6cPNJ9W0ttLb1YoHPchZirk2rvYNkGsRuayLAWxF8vGu6u4obhgR?=
 =?us-ascii?Q?3zjYsYNTXPARuYBu0eEWnD2P08+ihqEknxpTDSb1j1r1RtStftiNZvUWzM4i?=
 =?us-ascii?Q?GmBY0H9K9foRu1qC+QHZvB/nIL6Q/tV0QflAlWFV8/wBI8u2fYaycTFDdqwa?=
 =?us-ascii?Q?0NVx+GCopToQJ90kToulr7z2yP99SC6cp2lEr3JyC2ocP5BO1es9mlKSba8K?=
 =?us-ascii?Q?5gkriWATJpOwadsM6gqLf70H00Lzrava37vMfB+HkZsXKLglbKcyMZmiGxLe?=
 =?us-ascii?Q?yZ9sii6s7vd6CV+ncnq95hC0LXx1LlLxd+d2dzXezohhqdugNVCYDHBfh9HX?=
 =?us-ascii?Q?9t8aaaCQ5opYjXOGjPlZIAoEulpr8+M1JHo3SxWIlV4f1TPnn9NaTkrQYLLi?=
 =?us-ascii?Q?F4QD9NeUiSCDn0ctBuJdba2jVV485rFOHO3vqFw4NPEo2upZ7gEW+GFNTJPl?=
 =?us-ascii?Q?uDHsWn+CHo3Z+xXakT+qCm8=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d8eaa77-aedc-4a25-7023-08d9d69b5aa0
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2022 13:48:17.9936
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LMz07Gl64AbsLM3ozlzvWkof+RmbbfutXAqmvTL1MiwBuhIawFCoeDLb3j4PC8TZ/c4Rqil6MU4kQTTsbcq1Lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3791
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
index a5052bf35c..e069e8b448 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -303,7 +303,7 @@ def run_hook_command(cmd, param):
     cli = [cmd] + param
     use_shell = False
     if platform.system() == 'Windows':
-        (root,ext) = os.path.splitext(cmd)
+        root, ext = os.path.splitext(cmd)
         if ext == "":
             exe_path = os.environ.get("EXEPATH")
             if exe_path is None:
@@ -347,7 +347,7 @@ def read_pipe_full(c):
 
     expand = not isinstance(c, list)
     p = subprocess.Popen(c, stdout=subprocess.PIPE, stderr=subprocess.PIPE, shell=expand)
-    (out, err) = p.communicate()
+    out, err = p.communicate()
     return (p.returncode, out, decode_text_stream(err))
 
 
@@ -358,7 +358,7 @@ def read_pipe(c, ignore_error=False, raw=False):
 
        If raw is True, do not attempt to decode output text.
        """
-    (retcode, out, err) = read_pipe_full(c)
+    retcode, out, err = read_pipe_full(c)
     if retcode != 0:
         if ignore_error:
             out = ""
@@ -373,7 +373,7 @@ def read_pipe_text(c):
     """Read output from a command with trailing whitespace stripped. On error,
        returns None.
        """
-    (retcode, out, err) = read_pipe_full(c)
+    retcode, out, err = read_pipe_full(c)
     if retcode != 0:
         return None
     else:
@@ -428,7 +428,7 @@ def p4_has_move_command():
         return False
     cmd = p4_build_cmd(["move", "-k", "@from", "@to"])
     p = subprocess.Popen(cmd, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
-    (out, err) = p.communicate()
+    out, err = p.communicate()
     err = decode_text_stream(err)
     # return code will be 1 in either case
     if err.find("Invalid option") >= 0:
@@ -670,7 +670,7 @@ def p4_keywords_regexp_for_file(file):
     if not os.path.exists(file):
         return None
     else:
-        (type_base, type_mods) = split_p4_type(p4_type(file))
+        type_base, type_mods = split_p4_type(p4_type(file))
         return p4_keywords_regexp_for_type(type_base, type_mods)
 
 
@@ -1227,7 +1227,7 @@ def p4ChangesForPaths(depotPaths, changeRange, requestedBlockSize):
         parts = changeRange.split(',')
         assert len(parts) == 2
         try:
-            (changeStart, changeEnd) = p4ParseNumericChangeRange(parts)
+            changeStart, changeEnd = p4ParseNumericChangeRange(parts)
             block_size = chooseBlockSize(requestedBlockSize)
         except ValueError:
             changeStart = parts[0][1:]
@@ -1452,7 +1452,7 @@ def processContent(self, git_mode, relPath, contents):
            """
         if self.exceedsLargeFileThreshold(relPath, contents) or self.hasLargeFileExtension(relPath):
             contentTempFile = self.generateTempFile(contents)
-            (pointer_git_mode, contents, localLargeFile) = self.generatePointer(contentTempFile)
+            pointer_git_mode, contents, localLargeFile = self.generatePointer(contentTempFile)
             if pointer_git_mode:
                 git_mode = pointer_git_mode
             if localLargeFile:
@@ -1823,7 +1823,7 @@ def patchRCSKeywords(self, file, regexp):
         """Attempt to zap the RCS keywords in a p4 controlled file matching the
            given regex.
            """
-        (handle, outFileName) = tempfile.mkstemp(dir='.')
+        handle, outFileName = tempfile.mkstemp(dir='.')
         try:
             with os.fdopen(handle, "wb") as outFile, open(file, "rb") as inFile:
                 for line in inFile.readlines():
@@ -1855,7 +1855,7 @@ def p4UserForCommit(self,id):
     def checkValidP4Users(self,commits):
         """Check if any git authors cannot be mapped to p4 users."""
         for id in commits:
-            (user,email) = self.p4UserForCommit(id)
+            user, email = self.p4UserForCommit(id)
             if not user:
                 msg = "Cannot find p4 user for email %s in commit %s." % (email, id)
                 if gitConfigBool("git-p4.allowMissingP4Users"):
@@ -1930,7 +1930,7 @@ def prepareSubmitTemplate(self, changelist=None):
            outside the depot path we're committing into.
            """
 
-        [upstream, settings] = findUpstreamBranchPoint()
+        upstream, settings = findUpstreamBranchPoint()
 
         template = """\
 # A Perforce Change Specification.
@@ -2064,7 +2064,7 @@ def applyCommit(self, id):
         print("Applying", read_pipe(["git", "show", "-s",
                                      "--format=format:%h %s", id]))
 
-        (p4User, gitEmail) = self.p4UserForCommit(id)
+        p4User, gitEmail = self.p4UserForCommit(id)
 
         diff = read_pipe_lines("git diff-tree -r %s \"%s^\" \"%s\"" % (self.diffOpts, id, id))
         filesToAdd = set()
@@ -2228,7 +2228,7 @@ def applyCommit(self, id):
         #
         logMessage = extractLogMessageFromGitCommit(id)
         logMessage = logMessage.strip()
-        (logMessage, jobs) = self.separate_jobs_from_description(logMessage)
+        logMessage, jobs = self.separate_jobs_from_description(logMessage)
 
         template = self.prepareSubmitTemplate(update_shelve)
         submitTemplate = self.prepareLogMessage(template, logMessage, jobs)
@@ -2246,7 +2246,7 @@ def applyCommit(self, id):
             submitTemplate += separatorLine
             submitTemplate += self.get_diff_description(editedFiles, filesToAdd, symlinks)
 
-        (handle, fileName) = tempfile.mkstemp()
+        handle, fileName = tempfile.mkstemp()
         tmpFile = os.fdopen(handle, "w+b")
         if self.isWindows:
             submitTemplate = submitTemplate.replace("\n", "\r\n")
@@ -2453,7 +2453,7 @@ def run(self, args):
             if len(allowSubmit) > 0 and not self.master in allowSubmit.split(","):
                 die("%s is not in git-p4.allowSubmit" % self.master)
 
-        [upstream, settings] = findUpstreamBranchPoint()
+        upstream, settings = findUpstreamBranchPoint()
         self.depotPath = settings['depot-paths'][0]
         if len(self.origin) == 0:
             self.origin = upstream
@@ -3053,7 +3053,7 @@ def streamOneP4File(self, file, contents):
                 file_path, relPath, format_size_human_readable(size)))
             sys.stdout.flush()
 
-        (type_base, type_mods) = split_p4_type(file["type"])
+        type_base, type_mods = split_p4_type(file["type"])
 
         git_mode = "100644"
         if "x" in type_mods:
@@ -3118,7 +3118,7 @@ def streamOneP4File(self, file, contents):
             contents = [regexp.sub(br'$\1$', c) for c in contents]
 
         if self.largeFileSystem:
-            (git_mode, contents) = self.largeFileSystem.processContent(git_mode, relPath, contents)
+            git_mode, contents = self.largeFileSystem.processContent(git_mode, relPath, contents)
 
         self.writeToGitStream(git_mode, relPath, contents)
 
@@ -3589,7 +3589,7 @@ def getBranchMapping(self):
         configBranches = gitConfigList("git-p4.branchList")
         for branch in configBranches:
             if branch:
-                (source, destination) = branch.split(":")
+                source, destination = branch.split(":")
                 self.knownBranches[destination] = source
 
                 lostAndFoundBranches.discard(destination)
@@ -4195,7 +4195,7 @@ def rebase(self):
         if len(read_pipe("git diff-index HEAD --")) > 0:
             die("You have uncommitted changes. Please commit them before rebasing or stash them away with git stash.")
 
-        [upstream, settings] = findUpstreamBranchPoint()
+        upstream, settings = findUpstreamBranchPoint()
         if len(upstream) == 0:
             die("Cannot find upstream branchpoint for rebase")
 
@@ -4494,7 +4494,7 @@ def main():
                                    formatter=HelpFormatter())
 
     try:
-        (cmd, args) = parser.parse_args(sys.argv[2:], cmd)
+        cmd, args = parser.parse_args(sys.argv[2:], cmd)
     except:
         parser.print_help()
         raise
-- 
2.34.1

