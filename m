Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5569F1F406
	for <e@80x24.org>; Sat, 12 May 2018 21:24:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751908AbeELVYu (ORCPT <rfc822;e@80x24.org>);
        Sat, 12 May 2018 17:24:50 -0400
Received: from mail-wr0-f170.google.com ([209.85.128.170]:42546 "EHLO
        mail-wr0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751890AbeELVYt (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 May 2018 17:24:49 -0400
Received: by mail-wr0-f170.google.com with SMTP id v5-v6so8513218wrf.9
        for <git@vger.kernel.org>; Sat, 12 May 2018 14:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bwsxX0itZ8Iyz4dTZLpFRhIc0mZxf73ofxgny/4qYO8=;
        b=bF+xG3CPgJ+zMHy2Jqpu7BDXEhRrubuUoYivnE/7gMWWz88bXkHebGMt9LOPBYZKzq
         WIlxlj8uqBNDUqRMzWidaZNcY/GDeDbtyE3LCRq6Y8Bse3iMZBp4cXm1VqszcDDKZahX
         Iy/fd/wEWUqvrQTYCpF3jnZDKOzV5WHxglgmQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bwsxX0itZ8Iyz4dTZLpFRhIc0mZxf73ofxgny/4qYO8=;
        b=AJZRn+411aPLpWVpcawcOgSy0zg1E8ob0gyCqNMLfhpjtRyTZT5vEk00SCq1+AUs47
         OSOvg+zquGU5SeT7vHX9+U7QvmdUgV5Ot1utvXNU+HsiQ3x6zeOOmAUhhWjhXUzApK/w
         zzh7FQUIUXj7zZwIKKpfeUY7MYtan9I+ruvvoavfr5iPI1BUtuwKjG+egxo5ouIyKcIo
         CHGz6Uwrd7IzG4mhvumMoHRtTlnSGHvfaGL+pB2d6QYK2SsAz+J1iSqaxiovv0dzVnae
         0ph61aHx4mL00Fw9A3tj7sVFf7CnqxWA6PibZDl+BxG1ZT7TqYwEXwNbqp1BXyqC0xmW
         TcOg==
X-Gm-Message-State: ALKqPwdcbcpm7CyJTXZU42kmpyRMrmr9v1OuW+dWUEBhoB9e/rNjuoN9
        Fk04IY2e7cRzACpR+GF9lLtCCEiQ
X-Google-Smtp-Source: AB8JxZqLkA95D3ahX6KCS21cq1Jxx0SsMHsQqDzlHXrVC2Oseu2UEbB6gRdQo5TUOhwjdKk/N7skZg==
X-Received: by 2002:adf:85dd:: with SMTP id 29-v6mr2876465wru.120.1526160287252;
        Sat, 12 May 2018 14:24:47 -0700 (PDT)
Received: from ethel.corp.roku (cpc92728-cmbg20-2-0-cust351.5-4.cable.virginm.net. [82.29.15.96])
        by smtp.gmail.com with ESMTPSA id g75-v6sm5076967wmd.15.2018.05.12.14.24.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 12 May 2018 14:24:46 -0700 (PDT)
From:   Luke Diamand <luke@diamand.org>
To:     git@vger.kernel.org
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        Miguel Torroja <miguel.torroja@gmail.com>,
        George Vanburgh <gvanburgh@bloomberg.net>,
        Junio C Hamano <gitster@pobox.com>,
        Merland Romain <merlorom@yahoo.fr>,
        Luke Diamand <luke@diamand.org>
Subject: [PATCH 1/1] git-p4: add unshelve command
Date:   Sat, 12 May 2018 22:24:34 +0100
Message-Id: <20180512212434.28012-2-luke@diamand.org>
X-Mailer: git-send-email 2.17.0.392.gdeb1a6e9b7
In-Reply-To: <20180512212434.28012-1-luke@diamand.org>
References: <20180512212434.28012-1-luke@diamand.org>
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

Caveat:

The unshelving is done against the current "p4/master" branch;
git-p4 uses "p4 print" to get the file contents at the requested
revision, and then fast-import creates a commit relative to p4/master.

Ideally what you would want is for fast-import to create the
commit based on the Perforce "revision" prior to the shelved commit,
but Perforce doesn't have such a concept - to do this, git-p4
would need to figure out the revisions of the individual files
before the shelved changelist, and then construct a temporary
git branch which matched this.

It's possible to do this, but doing so makes this change a lot more
complicated.

This limitation means that if you unshelve a change where some
of the changed files were not based on p4/master, you will get
an amalgam of the change you wanted, and these other changes.

The reference branch can be changed manually with the "--origin"
option.

The change adds a new Unshelve command class. This just runs the
existing P4Sync code tweaked to handle a shelved changelist.

Signed-off-by: Luke Diamand <luke@diamand.org>
---
 Documentation/git-p4.txt |  26 ++++++
 git-p4.py                | 171 ++++++++++++++++++++++++++++++---------
 t/t9832-unshelve.sh      |  99 +++++++++++++++++++++++
 3 files changed, 260 insertions(+), 36 deletions(-)
 create mode 100755 t/t9832-unshelve.sh

diff --git a/Documentation/git-p4.txt b/Documentation/git-p4.txt
index d8c8f11c9f..2d768eec10 100644
--- a/Documentation/git-p4.txt
+++ b/Documentation/git-p4.txt
@@ -164,6 +164,25 @@ $ git p4 submit --shelve
 $ git p4 submit --update-shelve 1234 --update-shelve 2345
 ----
 
+
+Unshelve
+~~~~~~~~
+Unshelving will take a shelved P4 changelist, and produce the equivalent git commit
+in the branch refs/remotes/p4/unshelved/<changelist>.
+
+The git commit is created relative to the current p4/master, so if this
+is behind Perforce itself, it may include more changes than you expected. You can
+change the reference branch with the "--origin" option.
+
+If the target branch in refs/remotes/p4/unshelved already exists, the old one will
+be renamed.
+
+----
+$ git p4 sync
+$ git p4 unshelve 12345
+$ git show refs/remotes/p4/unshelved/12345
+----
+
 OPTIONS
 -------
 
@@ -337,6 +356,13 @@ These options can be used to modify 'git p4 rebase' behavior.
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
index 7bb9cadc69..dcf6dc9f4f 100755
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
@@ -2429,7 +2453,7 @@ class P4Sync(Command, P4UserMap):
         if self.verbose:
             print "checkpoint finished: " + out
 
-    def extractFilesFromCommit(self, commit):
+    def extractFilesFromCommit(self, commit, shelved=False, shelved_cl = 0):
         self.cloneExclude = [re.sub(r"\.\.\.$", "", path)
                              for path in self.cloneExclude]
         files = []
@@ -2452,6 +2476,9 @@ class P4Sync(Command, P4UserMap):
             file["rev"] = commit["rev%s" % fnum]
             file["action"] = commit["action%s" % fnum]
             file["type"] = commit["type%s" % fnum]
+            if shelved:
+                file["shelved_cl"] = int(shelved_cl)
+
             files.append(file)
             fnum = fnum + 1
         return files
@@ -2743,7 +2770,16 @@ class P4Sync(Command, P4UserMap):
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
@@ -2844,11 +2880,15 @@ class P4Sync(Command, P4UserMap):
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
@@ -3162,10 +3202,10 @@ class P4Sync(Command, P4UserMap):
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
@@ -3235,7 +3275,7 @@ class P4Sync(Command, P4UserMap):
                                 print "Parent of %s not found. Committing into head of %s" % (branch, parent)
                             self.commit(description, filesForCommit, branch, parent)
                 else:
-                    files = self.extractFilesFromCommit(description)
+                    files = self.extractFilesFromCommit(description, shelved, change)
                     self.commit(description, files, self.branch,
                                 self.initialParent)
                     # only needed once, to connect to the previous commit
@@ -3300,17 +3340,23 @@ class P4Sync(Command, P4UserMap):
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
@@ -3497,15 +3543,7 @@ class P4Sync(Command, P4UserMap):
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
@@ -3585,11 +3623,7 @@ class P4Sync(Command, P4UserMap):
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
@@ -3721,6 +3755,70 @@ class P4Clone(P4Sync):
 
         return True
 
+class P4Unshelve(Command):
+    def __init__(self):
+        Command.__init__(self)
+        self.options = []
+        self.description = "Unshelve a P4 changelist into a git commit"
+        self.usage = "usage: %prog [options] changelist"
+        self.options += [
+                optparse.make_option("--origin", dest="origin"),
+        ]
+        self.verbose = False
+        self.noCommit = False
+        self.origin = "HEAD"
+        self.destbranch = "refs/remotes/p4/unshelved"
+
+    def run(self, args):
+        if len(args) != 1:
+            return False
+
+        if not gitBranchExists(self.origin):
+            sys.exit("origin branch {} does not exist".format(self.origin))
+
+        sync = P4Sync()
+        changes = args
+        sync.initialParent = self.origin
+
+        # use the first change in the list to construct the branch to unshelve into
+        change = changes[0]
+
+        # if it already exists, rename it
+        branch_name = "{}/{}".format(self.destbranch, change)
+        if gitBranchExists(branch_name):
+            found = True
+            for i in range(0,1000):
+                backup_branch_name = "{}.{}".format(branch_name, i)
+                if not gitBranchExists(backup_branch_name):
+                    gitUpdateRef(backup_branch_name, branch_name) # copy ref to backup
+                    gitDeleteRef(branch_name)
+                    found = True
+                    print("renamed old unshelve branch to {}".format(backup_branch_name))
+                    break
+
+            if not found:
+                sys.exit("gave up trying to rename existing branch {}".format(sync.branch))
+        sync.branch = branch_name
+
+        sync.verbose = self.verbose
+        sync.suppress_meta_comment = True
+
+        print("getting log message from {}".format(self.origin))
+        log = extractLogMessageFromGitCommit("refs/remotes/p4/master")
+        settings = extractSettingsGitLog(log)
+        sync.depotPaths = settings['depot-paths']
+        sync.branchPrefixes = sync.depotPaths
+
+        sync.openStreams()
+        sync.loadUserMapFromCache()
+        sync.silent = True
+        sync.importChanges(changes, shelved=True)
+        sync.closeStreams()
+
+        print("unshelved CL{} into {}".format(change, branch_name))
+
+        return True
+
 class P4Branches(Command):
     def __init__(self):
         Command.__init__(self)
@@ -3775,7 +3873,8 @@ commands = {
     "rebase" : P4Rebase,
     "clone" : P4Clone,
     "rollback" : P4RollBack,
-    "branches" : P4Branches
+    "branches" : P4Branches,
+    "unshelve" : P4Unshelve,
 }
 
 
diff --git a/t/t9832-unshelve.sh b/t/t9832-unshelve.sh
new file mode 100755
index 0000000000..332d30ece9
--- /dev/null
+++ b/t/t9832-unshelve.sh
@@ -0,0 +1,99 @@
+#!/bin/sh
+
+last_shelved_change() {
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
+		p4 submit -d "change 1"
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
+test_expect_success 'kill p4d' '
+	kill_p4d
+'
+
+test_done
-- 
2.17.0.392.gdeb1a6e9b7

