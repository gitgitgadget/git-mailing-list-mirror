Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F3D661F576
	for <e@80x24.org>; Thu, 22 Feb 2018 09:50:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753227AbeBVJum (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Feb 2018 04:50:42 -0500
Received: from mail-wm0-f51.google.com ([74.125.82.51]:38994 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753216AbeBVJue (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Feb 2018 04:50:34 -0500
Received: by mail-wm0-f51.google.com with SMTP id 191so2527313wmm.4
        for <git@vger.kernel.org>; Thu, 22 Feb 2018 01:50:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wwvCccCiOIhX40OSMmj0vI1iwQNc9o1Y7yNj3RWYmHA=;
        b=Uu+9TgAK+eDKZBtTeOIzq56EglNMyf+cIIcI59vhd+e5FI1wFUnVrAeVHcBjYWaaOM
         6c2zBfl+5EHAlSfa+PCrdX5u1eMbS6jU1arTba90G5siaWHv5NBCDvkjmK9gRiZ10+X4
         CGbMCnv5xxvOJz0abdd3qv9lFeT0XwXlLFAeU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wwvCccCiOIhX40OSMmj0vI1iwQNc9o1Y7yNj3RWYmHA=;
        b=eFybIHNsJokeH/KjHWb4HauLsw1n7ZoWc1v8gwz9ay/60D+IW/Lchstpwy0Umf07ez
         j68WB7cCDByeXUBB5Ji6Jcvv2KlawP47FedUtl8suc8kuTfFGlMlVSiuhkcF5yaNJTSU
         puKlLQaKqR5wFwiq79Vsf5d6pjZL+a9L748TVtnXo7gHkzDy3k4ONf4noIijqacCFQfC
         5wHyfl8SWeOQpJ9GbowTxbiVMLNsTitBJ9bTOcwh9mn/m37JwNQ8dzj4uD266Yh+9iYP
         nGsEj8Sj9bQTdxwE8grwehOJDaTJiccWVMPQYclsHhXvea8ikSf/s17FW5l4roOO8bi4
         Fqrw==
X-Gm-Message-State: APf1xPA86pWsKDQSWz56DtYSs1yKiFMeI/nkabcsZYvGKg9vQh5iehMJ
        1l2xzFitZgrbEgRctMEdVsGI2s/d
X-Google-Smtp-Source: AH8x224QWeVrZuHS5WIexHfeqf1dQo8WxSibvO899d7hvzkZw+IgtKSrIOVPElwichBGmDCvpscN2A==
X-Received: by 10.28.147.73 with SMTP id v70mr3130217wmd.128.1519293030854;
        Thu, 22 Feb 2018 01:50:30 -0800 (PST)
Received: from ethel.corp.roku (cpc92728-cmbg20-2-0-cust351.5-4.cable.virginm.net. [82.29.15.96])
        by smtp.gmail.com with ESMTPSA id m187sm3022wmg.0.2018.02.22.01.50.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Feb 2018 01:50:30 -0800 (PST)
From:   Luke Diamand <luke@diamand.org>
To:     git@vger.kernel.org
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        miguel.torroja@gmail.com, gvanburgh@bloomberg.net,
        Luke Diamand <luke@diamand.org>
Subject: [PATCH 1/1] git-p4: add unshelve command
Date:   Thu, 22 Feb 2018 09:50:22 +0000
Message-Id: <20180222095022.6227-2-luke@diamand.org>
X-Mailer: git-send-email 2.15.1.272.gc310869385
In-Reply-To: <20180222095022.6227-1-luke@diamand.org>
References: <20180222095022.6227-1-luke@diamand.org>
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

Signed-off-by: Luke Diamand <luke@diamand.org>
---
 Documentation/git-p4.txt |  22 ++++++++
 git-p4.py                | 128 +++++++++++++++++++++++++++++++++++------------
 t/t9832-unshelve.sh      |  67 +++++++++++++++++++++++++
 3 files changed, 186 insertions(+), 31 deletions(-)
 create mode 100755 t/t9832-unshelve.sh

diff --git a/Documentation/git-p4.txt b/Documentation/git-p4.txt
index d8c8f11c9f..910ae63a1c 100644
--- a/Documentation/git-p4.txt
+++ b/Documentation/git-p4.txt
@@ -164,6 +164,21 @@ $ git p4 submit --shelve
 $ git p4 submit --update-shelve 1234 --update-shelve 2345
 ----
 
+
+Unshelve
+~~~~~~~~
+Unshelving will take a shelved P4 changelist, and produce the equivalent git commit
+in the branch refs/remotes/p4/unshelved/<changelist>.
+
+The git commit is created relative to the current p4/master branch, so if this
+branch is behind Perforce itself, it may include more changes than you expected.
+
+----
+$ git p4 sync
+$ git p4 unshelve 12345
+$ git show refs/remotes/p4/unshelved/12345
+----
+
 OPTIONS
 -------
 
@@ -337,6 +352,13 @@ These options can be used to modify 'git p4 rebase' behavior.
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
index 7bb9cadc69..59bd4ff64f 100755
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
 
@@ -2421,6 +2426,18 @@ class P4Sync(Command, P4UserMap):
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
@@ -2429,7 +2446,7 @@ class P4Sync(Command, P4UserMap):
         if self.verbose:
             print "checkpoint finished: " + out
 
-    def extractFilesFromCommit(self, commit):
+    def extractFilesFromCommit(self, commit, shelved=False, shelved_cl = 0):
         self.cloneExclude = [re.sub(r"\.\.\.$", "", path)
                              for path in self.cloneExclude]
         files = []
@@ -2452,6 +2469,9 @@ class P4Sync(Command, P4UserMap):
             file["rev"] = commit["rev%s" % fnum]
             file["action"] = commit["action%s" % fnum]
             file["type"] = commit["type%s" % fnum]
+            if shelved:
+                file["shelved_cl"] = int(shelved_cl)
+
             files.append(file)
             fnum = fnum + 1
         return files
@@ -2743,7 +2763,16 @@ class P4Sync(Command, P4UserMap):
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
@@ -3162,10 +3191,10 @@ class P4Sync(Command, P4UserMap):
         else:
             return None
 
-    def importChanges(self, changes):
+    def importChanges(self, changes, shelved=False):
         cnt = 1
         for change in changes:
-            description = p4_describe(change)
+            description = p4_describe(change, shelved)
             self.updateOptionDict(description)
 
             if not self.silent:
@@ -3235,7 +3264,7 @@ class P4Sync(Command, P4UserMap):
                                 print "Parent of %s not found. Committing into head of %s" % (branch, parent)
                             self.commit(description, filesForCommit, branch, parent)
                 else:
-                    files = self.extractFilesFromCommit(description)
+                    files = self.extractFilesFromCommit(description, shelved, change)
                     self.commit(description, files, self.branch,
                                 self.initialParent)
                     # only needed once, to connect to the previous commit
@@ -3300,17 +3329,23 @@ class P4Sync(Command, P4UserMap):
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
@@ -3497,15 +3532,7 @@ class P4Sync(Command, P4UserMap):
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
@@ -3585,11 +3612,7 @@ class P4Sync(Command, P4UserMap):
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
@@ -3721,6 +3744,48 @@ class P4Clone(P4Sync):
 
         return True
 
+class P4Unshelve(Command):
+    def __init__(self):
+        Command.__init__(self)
+        self.options = []
+        self.description = "Unshelve a P4 changelist into a git commit"
+        self.usage = "usage: %prog [options] changelist"
+        self.options += [
+                optparse.make_option("--no-commit", dest="noCommit",
+                    action='store_true', default=False,
+                    help="do not commit, just update the files"),
+                optparse.make_option("--origin", dest="origin"),
+        ]
+        self.verbose = False
+        self.noCommit = False
+        self.origin = "p4/master"
+        self.destbranch = "refs/remotes/p4/unshelved/%s"
+
+    def run(self, args):
+        if len(args) != 1:
+            return False
+
+        if not gitBranchExists(self.origin):
+            sys.exit("origin branch %s does not exist" % self.origin)
+
+        sync = P4Sync()
+        changes = args
+        sync.initialParent = self.origin
+        sync.branch = self.destbranch % changes[0]
+        sync.verbose = self.verbose
+
+        log = extractLogMessageFromGitCommit(self.origin)
+        settings = extractSettingsGitLog(log)
+        sync.depotPaths = settings['depot-paths']
+        sync.branchPrefixes = sync.depotPaths
+
+        sync.openStreams()
+        sync.loadUserMapFromCache()
+        sync.importChanges(changes, shelved=True)
+        sync.closeStreams()
+
+        return True
+
 class P4Branches(Command):
     def __init__(self):
         Command.__init__(self)
@@ -3775,7 +3840,8 @@ commands = {
     "rebase" : P4Rebase,
     "clone" : P4Clone,
     "rollback" : P4RollBack,
-    "branches" : P4Branches
+    "branches" : P4Branches,
+    "unshelve" : P4Unshelve,
 }
 
 
diff --git a/t/t9832-unshelve.sh b/t/t9832-unshelve.sh
new file mode 100755
index 0000000000..868297507a
--- /dev/null
+++ b/t/t9832-unshelve.sh
@@ -0,0 +1,67 @@
+#!/bin/sh
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
+		p4 submit -d "change 1"
+		: > file_to_delete &&
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
+	test_when_finished cleanup_git &&
+	(
+		cd "$cli" &&
+		p4 edit file1 &&
+		echo "a change" >>file1 &&
+		echo "new file" > file2 &&
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
+		change=$(p4 changes -s shelved -m1 | cut -d " " -f 2) &&
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
+test_expect_success 'kill p4d' '
+	kill_p4d
+'
+
+test_done
-- 
2.15.1.272.gc310869385

