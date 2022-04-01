Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C24EC43217
	for <git@archiver.kernel.org>; Fri,  1 Apr 2022 15:04:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350624AbiDAPFo (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Apr 2022 11:05:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349541AbiDAOqE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Apr 2022 10:46:04 -0400
Received: from b-painless.mh.aa.net.uk (b-painless.mh.aa.net.uk [IPv6:2001:8b0:0:30::52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92EC839B88
        for <git@vger.kernel.org>; Fri,  1 Apr 2022 07:36:09 -0700 (PDT)
Received: from [195.110.77.193] (helo=red.nvidia.com)
        by painless-b.tch.aa.net.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <jholdsworth@nvidia.com>)
        id 1naIEB-009TW3-Ln; Fri, 01 Apr 2022 15:26:15 +0100
From:   Joel Holdsworth <jholdsworth@nvidia.com>
To:     git@vger.kernel.org, Luke Diamand <luke@diamand.org>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Cc:     Tzadik Vanderhoof <tzadik.vanderhoof@gmail.com>,
        Dorgon Chang <dorgonman@hotmail.com>,
        Joachim Kuebart <joachim.kuebart@gmail.com>,
        Daniel Levin <dendy.ua@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Ben Keene <seraphire@gmail.com>,
        Andrew Oakley <andrew@adoakley.name>,
        Joel Holdsworth <jholdsworth@nvidia.com>
Subject: [PATCH v5 10/22] git-p4: removed brackets when assigning multiple return values
Date:   Fri,  1 Apr 2022 15:24:52 +0100
Message-Id: <20220401142504.58995-11-jholdsworth@nvidia.com>
X-Mailer: git-send-email 2.35.GIT
In-Reply-To: <20220401142504.58995-1-jholdsworth@nvidia.com>
References: <20220401142504.58995-1-jholdsworth@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

