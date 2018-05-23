Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 442141F42D
	for <e@80x24.org>; Wed, 23 May 2018 22:20:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934938AbeEWWUm (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 May 2018 18:20:42 -0400
Received: from mail-wr0-f172.google.com ([209.85.128.172]:43726 "EHLO
        mail-wr0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934779AbeEWWUh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 May 2018 18:20:37 -0400
Received: by mail-wr0-f172.google.com with SMTP id r13-v6so16881170wrj.10
        for <git@vger.kernel.org>; Wed, 23 May 2018 15:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TSvQmoPb05zX8HpbK+jCbcLXiTiPRbtVFBR9jSjTUAA=;
        b=EzKxjptQfzccJnsyrx+cJT8FfHqV5HcALsLMg5bDl6sAO0wbJ2ovdiu714kZeL8Otw
         fn6SGhE9TIg+rfhi7WnnxWXA5zbmFyKnyLQWMGzsTaN2LMEdTfUxRYMQHom7+W91YLzK
         QJApJMPHmXnnP9kZWxOfNnMOb+kc732F7r55o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TSvQmoPb05zX8HpbK+jCbcLXiTiPRbtVFBR9jSjTUAA=;
        b=Ieo5utEDJ2IYwl7v6HFAbchknfJY0S/L04QTWHVBRHiCTUMkuw4iz8Ghw1dib3kH2T
         1gnzKbHKfCUiBgwgQ9KxYpRmz8dKUmZArWQSxjedfuAzwQMSDNp6WekeZfpkWVlqHy73
         /uppFv9Pp+TVFZIAQ2glBXa646KCViSU8HnY0kPy/p+tNLg+/jOpX4otEF8neuhixV61
         lyFL680kEDoUSj/NW6NiD+CKdZU2YWNsyZ2k8YVaboiNHT8ssjpDsdn9xDxVxDuQlw1D
         iRaHjJp2WESW/xtCznf2mptBr68DEgwXl9UYqXrMPsxeYVPwtSuNGb98aqBr9YHiNdbL
         uv6g==
X-Gm-Message-State: ALKqPwccDPfQtXegPV0+6/MKDyif3zorVS5trBlZhkHkDT1RYyJ73iif
        bttVWOgtUNpH5huOI9ENWTMfjissFSU=
X-Google-Smtp-Source: AB8JxZpBe+k/tzonaypzjf8qwl+YbmLz5vY4WTP5uVXvFlu6oqmgP7KYNjDaQyhQfXPJqzL12oY7NQ==
X-Received: by 2002:adf:80d0:: with SMTP id 74-v6mr4436121wrl.273.1527114035016;
        Wed, 23 May 2018 15:20:35 -0700 (PDT)
Received: from ethel.corp.roku (cpc92728-cmbg20-2-0-cust351.5-4.cable.virginm.net. [82.29.15.96])
        by smtp.gmail.com with ESMTPSA id q2-v6sm20858994wrm.26.2018.05.23.15.20.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 May 2018 15:20:34 -0700 (PDT)
From:   Luke Diamand <luke@diamand.org>
To:     git@vger.kernel.org
Cc:     Andrey Mazo <amazo@checkvideo.com>,
        Junio C Hamano <gitster@pobox.com>,
        Romain Merland <merlorom@yahoo.fr>,
        Miguel Torroja <miguel.torroja@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        George Vanburgh <gvanburgh@bloomberg.net>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Luke Diamand <luke@diamand.org>
Subject: [PATCHv6 1/1] git-p4: add unshelve command
Date:   Wed, 23 May 2018 23:20:26 +0100
Message-Id: <20180523222026.6609-2-luke@diamand.org>
X-Mailer: git-send-email 2.17.0.392.gdeb1a6e9b7
In-Reply-To: <20180523222026.6609-1-luke@diamand.org>
References: <20180523222026.6609-1-luke@diamand.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This can be used to "unshelve" a shelved P4 commit into
a git commit.

For example:

  $ git p4 unshelve 12345

The resulting commit ends up in the branch:
   refs/remotes/p4/unshelved/12345

If that branch already exists, it is renamed - for example
the above branch would be saved as p4/unshelved/12345.1.

git-p4 checks that the shelved changelist is based on files
which are at the same Perforce revision as the origin branch
being used for the unshelve (HEAD by default). If they are not,
it will refuse to unshelve. This is to ensure that the unshelved
change does not contain other changes mixed-in.

The reference branch can be changed manually with the "--origin"
option.

The change adds a new Unshelve command class. This just runs the
existing P4Sync code tweaked to handle a shelved changelist.

Signed-off-by: Luke Diamand <luke@diamand.org>
---
 Documentation/git-p4.txt |  32 ++++++
 git-p4.py                | 213 ++++++++++++++++++++++++++++++++-------
 t/t9832-unshelve.sh      | 138 +++++++++++++++++++++++++
 3 files changed, 347 insertions(+), 36 deletions(-)
 create mode 100755 t/t9832-unshelve.sh

diff --git a/Documentation/git-p4.txt b/Documentation/git-p4.txt
index d8c8f11c9f..d3cb249fc2 100644
--- a/Documentation/git-p4.txt
+++ b/Documentation/git-p4.txt
@@ -164,6 +164,31 @@ $ git p4 submit --shelve
 $ git p4 submit --update-shelve 1234 --update-shelve 2345
 ----
 
+
+Unshelve
+~~~~~~~~
+Unshelving will take a shelved P4 changelist, and produce the equivalent git commit
+in the branch refs/remotes/p4/unshelved/<changelist>.
+
+The git commit is created relative to the current origin revision (HEAD by default).
+If the shelved changelist's parent revisions differ, git-p4 will refuse to unshelve;
+you need to be unshelving onto an equivalent tree.
+
+The origin revision can be changed with the "--origin" option.
+
+If the target branch in refs/remotes/p4/unshelved already exists, the old one will
+be renamed.
+
+----
+$ git p4 sync
+$ git p4 unshelve 12345
+$ git show refs/remotes/p4/unshelved/12345
+<submit more changes via p4 to the same files>
+$ git p4 unshelve 12345
+<refuses to unshelve until git is in sync with p4 again>
+
+----
+
 OPTIONS
 -------
 
@@ -337,6 +362,13 @@ These options can be used to modify 'git p4 rebase' behavior.
 --import-labels::
 	Import p4 labels.
 
+Unshelve options
+~~~~~~~~~~~~~~~~
+
+--origin::
+    Sets the git refspec against which the shelved P4 changelist is compared.
+    Defaults to p4/master.
+
 DEPOT PATH SYNTAX
 -----------------
 The p4 depot path argument to 'git p4 sync' and 'git p4 clone' can
diff --git a/git-p4.py b/git-p4.py
index 7bb9cadc69..74d58afad3 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -316,12 +316,17 @@ def p4_last_change():
     results = p4CmdList(["changes", "-m", "1"], skip_info=True)
     return int(results[0]['change'])
 
-def p4_describe(change):
+def p4_describe(change, shelved=False):
     """Make sure it returns a valid result by checking for
        the presence of field "time".  Return a dict of the
        results."""
 
-    ds = p4CmdList(["describe", "-s", str(change)], skip_info=True)
+    cmd = ["describe", "-s"]
+    if shelved:
+        cmd += ["-S"]
+    cmd += [str(change)]
+
+    ds = p4CmdList(cmd, skip_info=True)
     if len(ds) != 1:
         die("p4 describe -s %d did not return 1 result: %s" % (change, str(ds)))
 
@@ -662,6 +667,12 @@ def gitBranchExists(branch):
                             stderr=subprocess.PIPE, stdout=subprocess.PIPE);
     return proc.wait() == 0;
 
+def gitUpdateRef(ref, newvalue):
+    subprocess.check_call(["git", "update-ref", ref, newvalue])
+
+def gitDeleteRef(ref):
+    subprocess.check_call(["git", "update-ref", "-d", ref])
+
 _gitConfig = {}
 
 def gitConfig(key, typeSpecifier=None):
@@ -2411,6 +2422,7 @@ class P4Sync(Command, P4UserMap):
         self.tempBranches = []
         self.tempBranchLocation = "refs/git-p4-tmp"
         self.largeFileSystem = None
+        self.suppress_meta_comment = False
 
         if gitConfig('git-p4.largeFileSystem'):
             largeFileSystemConstructor = globals()[gitConfig('git-p4.largeFileSystem')]
@@ -2421,6 +2433,18 @@ class P4Sync(Command, P4UserMap):
         if gitConfig("git-p4.syncFromOrigin") == "false":
             self.syncWithOrigin = False
 
+        self.depotPaths = []
+        self.changeRange = ""
+        self.previousDepotPaths = []
+        self.hasOrigin = False
+
+        # map from branch depot path to parent branch
+        self.knownBranches = {}
+        self.initialParents = {}
+
+        self.tz = "%+03d%02d" % (- time.timezone / 3600, ((- time.timezone % 3600) / 60))
+        self.labels = {}
+
     # Force a checkpoint in fast-import and wait for it to finish
     def checkpoint(self):
         self.gitStream.write("checkpoint\n\n")
@@ -2429,7 +2453,20 @@ class P4Sync(Command, P4UserMap):
         if self.verbose:
             print "checkpoint finished: " + out
 
-    def extractFilesFromCommit(self, commit):
+    def cmp_shelved(self, path, filerev, revision):
+        """ Determine if a path at revision #filerev is the same as the file
+            at revision @revision for a shelved changelist. If they don't match,
+            unshelving won't be safe (we will get other changes mixed in).
+
+            This is comparing the revision that the shelved changelist is *based* on, not
+            the shelved changelist itself.
+        """
+        ret = p4Cmd(["diff2", "{0}#{1}".format(path, filerev), "{0}@{1}".format(path, revision)])
+        if verbose:
+            print("p4 diff2 path %s filerev %s revision %s => %s" % (path, filerev, revision, ret))
+        return ret["status"] == "identical"
+
+    def extractFilesFromCommit(self, commit, shelved=False, shelved_cl = 0, origin_revision = 0):
         self.cloneExclude = [re.sub(r"\.\.\.$", "", path)
                              for path in self.cloneExclude]
         files = []
@@ -2452,6 +2489,19 @@ class P4Sync(Command, P4UserMap):
             file["rev"] = commit["rev%s" % fnum]
             file["action"] = commit["action%s" % fnum]
             file["type"] = commit["type%s" % fnum]
+            if shelved:
+                file["shelved_cl"] = int(shelved_cl)
+
+                # For shelved changelists, check that the revision of each file that the
+                # shelve was based on matches the revision that we are using for the
+                # starting point for git-fast-import (self.initialParent). Otherwise
+                # the resulting diff will contain deltas from multiple commits.
+
+                if file["action"] != "add" and \
+                    not self.cmp_shelved(path, file["rev"], origin_revision):
+                    sys.exit("change {0} not based on {1} for {2}, cannot unshelve".format(
+                        commit["change"], self.initialParent, path))
+
             files.append(file)
             fnum = fnum + 1
         return files
@@ -2743,7 +2793,16 @@ class P4Sync(Command, P4UserMap):
             def streamP4FilesCbSelf(entry):
                 self.streamP4FilesCb(entry)
 
-            fileArgs = ['%s#%s' % (f['path'], f['rev']) for f in filesToRead]
+            fileArgs = []
+            for f in filesToRead:
+                if 'shelved_cl' in f:
+                    # Handle shelved CLs using the "p4 print file@=N" syntax to print
+                    # the contents
+                    fileArg = '%s@=%d' % (f['path'], f['shelved_cl'])
+                else:
+                    fileArg = '%s#%s' % (f['path'], f['rev'])
+
+                fileArgs.append(fileArg)
 
             p4CmdList(["-x", "-", "print"],
                       stdin=fileArgs,
@@ -2844,11 +2903,15 @@ class P4Sync(Command, P4UserMap):
         self.gitStream.write(details["desc"])
         if len(jobs) > 0:
             self.gitStream.write("\nJobs: %s" % (' '.join(jobs)))
-        self.gitStream.write("\n[git-p4: depot-paths = \"%s\": change = %s" %
-                             (','.join(self.branchPrefixes), details["change"]))
-        if len(details['options']) > 0:
-            self.gitStream.write(": options = %s" % details['options'])
-        self.gitStream.write("]\nEOT\n\n")
+
+        if not self.suppress_meta_comment:
+            self.gitStream.write("\n[git-p4: depot-paths = \"%s\": change = %s" %
+                                (','.join(self.branchPrefixes), details["change"]))
+            if len(details['options']) > 0:
+                self.gitStream.write(": options = %s" % details['options'])
+            self.gitStream.write("]\n")
+
+        self.gitStream.write("EOT\n\n")
 
         if len(parent) > 0:
             if self.verbose:
@@ -3162,10 +3225,10 @@ class P4Sync(Command, P4UserMap):
         else:
             return None
 
-    def importChanges(self, changes):
+    def importChanges(self, changes, shelved=False, origin_revision=0):
         cnt = 1
         for change in changes:
-            description = p4_describe(change)
+            description = p4_describe(change, shelved)
             self.updateOptionDict(description)
 
             if not self.silent:
@@ -3235,7 +3298,7 @@ class P4Sync(Command, P4UserMap):
                                 print "Parent of %s not found. Committing into head of %s" % (branch, parent)
                             self.commit(description, filesForCommit, branch, parent)
                 else:
-                    files = self.extractFilesFromCommit(description)
+                    files = self.extractFilesFromCommit(description, shelved, change, origin_revision)
                     self.commit(description, files, self.branch,
                                 self.initialParent)
                     # only needed once, to connect to the previous commit
@@ -3300,17 +3363,23 @@ class P4Sync(Command, P4UserMap):
             print "IO error with git fast-import. Is your git version recent enough?"
             print self.gitError.read()
 
+    def openStreams(self):
+        self.importProcess = subprocess.Popen(["git", "fast-import"],
+                                              stdin=subprocess.PIPE,
+                                              stdout=subprocess.PIPE,
+                                              stderr=subprocess.PIPE);
+        self.gitOutput = self.importProcess.stdout
+        self.gitStream = self.importProcess.stdin
+        self.gitError = self.importProcess.stderr
 
-    def run(self, args):
-        self.depotPaths = []
-        self.changeRange = ""
-        self.previousDepotPaths = []
-        self.hasOrigin = False
-
-        # map from branch depot path to parent branch
-        self.knownBranches = {}
-        self.initialParents = {}
+    def closeStreams(self):
+        self.gitStream.close()
+        if self.importProcess.wait() != 0:
+            die("fast-import failed: %s" % self.gitError.read())
+        self.gitOutput.close()
+        self.gitError.close()
 
+    def run(self, args):
         if self.importIntoRemotes:
             self.refPrefix = "refs/remotes/p4/"
         else:
@@ -3497,15 +3566,7 @@ class P4Sync(Command, P4UserMap):
                     b = b[len(self.projectName):]
                 self.createdBranches.add(b)
 
-        self.tz = "%+03d%02d" % (- time.timezone / 3600, ((- time.timezone % 3600) / 60))
-
-        self.importProcess = subprocess.Popen(["git", "fast-import"],
-                                              stdin=subprocess.PIPE,
-                                              stdout=subprocess.PIPE,
-                                              stderr=subprocess.PIPE);
-        self.gitOutput = self.importProcess.stdout
-        self.gitStream = self.importProcess.stdin
-        self.gitError = self.importProcess.stderr
+        self.openStreams()
 
         if revision:
             self.importHeadRevision(revision)
@@ -3585,11 +3646,7 @@ class P4Sync(Command, P4UserMap):
             missingP4Labels = p4Labels - gitTags
             self.importP4Labels(self.gitStream, missingP4Labels)
 
-        self.gitStream.close()
-        if self.importProcess.wait() != 0:
-            die("fast-import failed: %s" % self.gitError.read())
-        self.gitOutput.close()
-        self.gitError.close()
+        self.closeStreams()
 
         # Cleanup temporary branches created during import
         if self.tempBranches != []:
@@ -3721,6 +3778,89 @@ class P4Clone(P4Sync):
 
         return True
 
+class P4Unshelve(Command):
+    def __init__(self):
+        Command.__init__(self)
+        self.options = []
+        self.origin = "HEAD"
+        self.description = "Unshelve a P4 changelist into a git commit"
+        self.usage = "usage: %prog [options] changelist"
+        self.options += [
+                optparse.make_option("--origin", dest="origin",
+                    help="Use this base revision instead of the default (%s)" % self.origin),
+        ]
+        self.verbose = False
+        self.noCommit = False
+        self.destbranch = "refs/remotes/p4/unshelved"
+
+    def renameBranch(self, branch_name):
+        """ Rename the existing branch to branch_name.N
+        """
+
+        found = True
+        for i in range(0,1000):
+            backup_branch_name = "{0}.{1}".format(branch_name, i)
+            if not gitBranchExists(backup_branch_name):
+                gitUpdateRef(backup_branch_name, branch_name) # copy ref to backup
+                gitDeleteRef(branch_name)
+                found = True
+                print("renamed old unshelve branch to {0}".format(backup_branch_name))
+                break
+
+        if not found:
+            sys.exit("gave up trying to rename existing branch {0}".format(sync.branch))
+
+    def findLastP4Revision(self, starting_point):
+        """ Look back from starting_point for the first commit created by git-p4
+            to find the P4 commit we are based on, and the depot-paths.
+        """
+
+        for parent in (range(65535)):
+            log = extractLogMessageFromGitCommit("{0}^{1}".format(starting_point, parent))
+            settings = extractSettingsGitLog(log)
+            if settings.has_key('change'):
+                return settings
+
+        sys.exit("could not find git-p4 commits in {0}".format(self.origin))
+
+    def run(self, args):
+        if len(args) != 1:
+            return False
+
+        if not gitBranchExists(self.origin):
+            sys.exit("origin branch {0} does not exist".format(self.origin))
+
+        sync = P4Sync()
+        changes = args
+        sync.initialParent = self.origin
+
+        # use the first change in the list to construct the branch to unshelve into
+        change = changes[0]
+
+        # if the target branch already exists, rename it
+        branch_name = "{0}/{1}".format(self.destbranch, change)
+        if gitBranchExists(branch_name):
+            self.renameBranch(branch_name)
+        sync.branch = branch_name
+
+        sync.verbose = self.verbose
+        sync.suppress_meta_comment = True
+
+        settings = self.findLastP4Revision(self.origin)
+        origin_revision = settings['change']
+        sync.depotPaths = settings['depot-paths']
+        sync.branchPrefixes = sync.depotPaths
+
+        sync.openStreams()
+        sync.loadUserMapFromCache()
+        sync.silent = True
+        sync.importChanges(changes, shelved=True, origin_revision=origin_revision)
+        sync.closeStreams()
+
+        print("unshelved changelist {0} into {1}".format(change, branch_name))
+
+        return True
+
 class P4Branches(Command):
     def __init__(self):
         Command.__init__(self)
@@ -3775,7 +3915,8 @@ commands = {
     "rebase" : P4Rebase,
     "clone" : P4Clone,
     "rollback" : P4RollBack,
-    "branches" : P4Branches
+    "branches" : P4Branches,
+    "unshelve" : P4Unshelve,
 }
 
 
diff --git a/t/t9832-unshelve.sh b/t/t9832-unshelve.sh
new file mode 100755
index 0000000000..48ec7679b8
--- /dev/null
+++ b/t/t9832-unshelve.sh
@@ -0,0 +1,138 @@
+#!/bin/sh
+
+last_shelved_change () {
+	p4 changes -s shelved -m1 | cut -d " " -f 2
+}
+
+test_description='git p4 unshelve'
+
+. ./lib-git-p4.sh
+
+test_expect_success 'start p4d' '
+	start_p4d
+'
+
+test_expect_success 'init depot' '
+	(
+		cd "$cli" &&
+		echo file1 >file1 &&
+		p4 add file1 &&
+		p4 submit -d "change 1" &&
+		: >file_to_delete &&
+		p4 add file_to_delete &&
+		p4 submit -d "file to delete"
+	)
+'
+
+test_expect_success 'initial clone' '
+	git p4 clone --dest="$git" //depot/@all
+'
+
+test_expect_success 'create shelved changelist' '
+	(
+		cd "$cli" &&
+		p4 edit file1 &&
+		echo "a change" >>file1 &&
+		echo "new file" >file2 &&
+		p4 add file2 &&
+		p4 delete file_to_delete &&
+		p4 opened &&
+		p4 shelve -i <<EOF
+Change: new
+Description:
+	Test commit
+
+	Further description
+Files:
+	//depot/file1
+	//depot/file2
+	//depot/file_to_delete
+EOF
+
+	) &&
+	(
+		cd "$git" &&
+		change=$(last_shelved_change) &&
+		git p4 unshelve $change &&
+		git show refs/remotes/p4/unshelved/$change | grep -q "Further description" &&
+		git cherry-pick refs/remotes/p4/unshelved/$change &&
+		test_path_is_file file2 &&
+		test_cmp file1 "$cli"/file1 &&
+		test_cmp file2 "$cli"/file2 &&
+		test_path_is_missing file_to_delete
+	)
+'
+
+test_expect_success 'update shelved changelist and re-unshelve' '
+	test_when_finished cleanup_git &&
+	(
+		cd "$cli" &&
+		change=$(last_shelved_change) &&
+		echo "file3" >file3 &&
+		p4 add -c $change file3 &&
+		p4 shelve -i -r <<EOF &&
+Change: $change
+Description:
+	Test commit
+
+	Further description
+Files:
+	//depot/file1
+	//depot/file2
+	//depot/file3
+	//depot/file_to_delete
+EOF
+		p4 describe $change
+	) &&
+	(
+		cd "$git" &&
+		change=$(last_shelved_change) &&
+		git p4 unshelve $change &&
+		git diff refs/remotes/p4/unshelved/$change.0 refs/remotes/p4/unshelved/$change | grep -q file3
+	)
+'
+
+# This is the tricky case where the shelved changelist base revision doesn't
+# match git-p4's idea of the base revision
+#
+# We will attempt to unshelve a change that is based on a change one commit
+# ahead of p4/master
+
+test_expect_success 'create shelved changelist based on p4 change ahead of p4/master' '
+	git p4 clone --dest="$git" //depot/@all &&
+	(
+		cd "$cli" &&
+		p4 revert ... &&
+		p4 edit file1 &&
+		echo "foo" >>file1 &&
+		p4 submit -d "change:foo" &&
+		p4 edit file1 &&
+		echo "bar" >>file1 &&
+		p4 shelve -i <<EOF &&
+Change: new
+Description:
+	Change to be unshelved
+Files:
+	//depot/file1
+EOF
+		change=$(last_shelved_change) &&
+		p4 describe -S $change | grep -q "Change to be unshelved"
+	)
+'
+
+# Now try to unshelve it. git-p4 should refuse to do so.
+test_expect_success 'try to unshelve the change' '
+	test_when_finished cleanup_git &&
+	(
+		change=$(last_shelved_change) &&
+		cd "$git" &&
+		test_must_fail git p4 unshelve $change 2>out.txt &&
+		grep -q "cannot unshelve" out.txt
+	)
+'
+
+test_expect_success 'kill p4d' '
+	kill_p4d
+'
+
+test_done
-- 
2.17.0.392.gdeb1a6e9b7

