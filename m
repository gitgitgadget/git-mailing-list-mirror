Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D96831F97E
	for <e@80x24.org>; Fri, 12 Oct 2018 05:28:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727444AbeJLM73 (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Oct 2018 08:59:29 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33106 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727227AbeJLM71 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Oct 2018 08:59:27 -0400
Received: by mail-pg1-f193.google.com with SMTP id y18-v6so5288490pge.0
        for <git@vger.kernel.org>; Thu, 11 Oct 2018 22:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=99Ht1zglTmyd1+6kbNAK9s3LX45ScfLvWksdkrRxR9s=;
        b=JJGJZ9c1Fg39KC+dztFb48U6JzOqWanpexu7CA2wkN84INi5jshOpzJz3wQTPTTyhA
         7F02Dzuv72hbdXNcemxCOxvY00kpgf1zlX9HfeBfqDoeiKlaMvHRCeqY6ZhohotcBqFu
         N0yo2idnbiQhJvmyxpvXPkgeIncidRLXJbrIk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=99Ht1zglTmyd1+6kbNAK9s3LX45ScfLvWksdkrRxR9s=;
        b=iBCwash7leIQxweyg0MFfZTiENOs+S/jmudX1tYzag8lHvq+Ri81rHRqOQE1O0kf3+
         64cwc5UkMYHgQAlUDUJZfSMYW0dQwgK/Pe7/ZIzrB3rXyxOplExmFBH86ZApEtA8CmJM
         7Xk+AptVm6z2dKnO3d+cFUOE7exAj6m1dqP8Qqpv1Mxc5lVZcWI/OVPRE6U8yV5dgHeY
         ccQmw6FMijzk3xqmWkM3z2QOs+NnAPQix2HangukqVxPenpRawqOOr5884nxNnBD2QrC
         WjP2ZUrZWsTBwr4cucRINAqf5A4/4DaH9J/oEY1P+r1KyRpjI8zGcyuySPKspAMRZ/Ma
         F3tg==
X-Gm-Message-State: ABuFfogP3IgBADAokNkF1JwI27/Lc3svj9Kyyr/cyye2pCo4frXj2Rci
        9yBSGb81LsAbF3hVYUVsh6tpfQnXsCFKOJAd
X-Google-Smtp-Source: ACcGV60oe0sz7IwMpQvbp7Vq61utx2/vkdEF3VTk3PW2whv9mQ8cU7bGwh4BmodeAEQVMaUN8KDLTQ==
X-Received: by 2002:a62:1c06:: with SMTP id c6-v6mr4672188pfc.41.1539322124470;
        Thu, 11 Oct 2018 22:28:44 -0700 (PDT)
Received: from lgd-kipper.hsd1.ca.comcast.net ([2601:646:8581:1fcf:8286:f2ff:fe24:931b])
        by smtp.gmail.com with ESMTPSA id t26-v6sm209110pfa.158.2018.10.11.22.28.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Oct 2018 22:28:43 -0700 (PDT)
From:   Luke Diamand <luke@diamand.org>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Chen Bin <chenbin.sh@gmail.com>,
        Miguel Torroja <miguel.torroja@gmail.com>,
        George Vanburgh <gvanburgh@bloomberg.net>,
        Merland Romain <merlorom@yahoo.fr>,
        Vinicius Kursancew <viniciusalexandre@gmail.com>,
        larsxschneider@gmail.com, Lex Spoon <lex@lexspoon.org>,
        Luke Diamand <luke@diamand.org>
Subject: [PATCHv1 3/3] git-p4: fully support unshelving changelists
Date:   Fri, 12 Oct 2018 06:28:33 +0100
Message-Id: <20181012052833.6945-4-luke@diamand.org>
X-Mailer: git-send-email 2.19.1.272.gf84b9b09d4
In-Reply-To: <20181012052833.6945-1-luke@diamand.org>
References: <20181012052833.6945-1-luke@diamand.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The previous git-p4 unshelve support would check for changes
in Perforce to the files being unshelved since the original
shelve, and would complain if any were found.

This was to ensure that the user wouldn't end up with both the
shelved change delta, and some deltas from other changes in their
git commit.

e.g. given fileA:
      the
      quick
      brown
      fox

  change1: s/the/The/   <- p4 shelve this change
  change2: s/fox/Fox/   <- p4 submit this change
  git p4 unshelve 1     <- FAIL

This change teaches the P4Unshelve class to always create a parent
commit which matches the P4 tree (for the files being unshelved) at
the point prior to the P4 shelve being created (which is reported
in the p4 description for a shelved changelist).

That then means git-p4 can always create a git commit matching the
P4 shelve that was originally created, without any extra deltas.

The user might still need to use the --origin option though - there
is no way for git-p4 to work out the versions of all of the other
*unchanged* files in the shelve, since this information is not recorded
by Perforce.

Additionally this fixes handling of shelved 'move' operations.

Signed-off-by: Luke Diamand <luke@diamand.org>
---
 Documentation/git-p4.txt |  4 +-
 git-p4.py                | 84 +++++++++++++++++++++++-----------------
 t/t9832-unshelve.sh      | 69 ++++++++++++++++++++++++++-------
 3 files changed, 106 insertions(+), 51 deletions(-)

diff --git a/Documentation/git-p4.txt b/Documentation/git-p4.txt
index c7705ae6e7..d8332e99c1 100644
--- a/Documentation/git-p4.txt
+++ b/Documentation/git-p4.txt
@@ -177,8 +177,8 @@ Unshelving will take a shelved P4 changelist, and produce the equivalent git com
 in the branch refs/remotes/p4-unshelved/<changelist>.
 
 The git commit is created relative to the current origin revision (HEAD by default).
-If the shelved changelist's parent revisions differ, git-p4 will refuse to unshelve;
-you need to be unshelving onto an equivalent tree.
+A parent commit is created based on the origin, and then the unshelve commit is
+created based on that.
 
 The origin revision can be changed with the "--origin" option.
 
diff --git a/git-p4.py b/git-p4.py
index 76c18a22e9..1998c3e141 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -1306,6 +1306,9 @@ def processContent(self, git_mode, relPath, contents):
             return LargeFileSystem.processContent(self, git_mode, relPath, contents)
 
 class Command:
+    delete_actions = ( "delete", "move/delete", "purge" )
+    add_actions = ( "add", "move/add" )
+
     def __init__(self):
         self.usage = "usage: %prog [options]"
         self.needsGit = True
@@ -2524,7 +2527,6 @@ def map_in_client(self, depot_path):
         return ""
 
 class P4Sync(Command, P4UserMap):
-    delete_actions = ( "delete", "move/delete", "purge" )
 
     def __init__(self):
         Command.__init__(self)
@@ -2612,20 +2614,7 @@ def checkpoint(self):
         if self.verbose:
             print("checkpoint finished: " + out)
 
-    def cmp_shelved(self, path, filerev, revision):
-        """ Determine if a path at revision #filerev is the same as the file
-            at revision @revision for a shelved changelist. If they don't match,
-            unshelving won't be safe (we will get other changes mixed in).
-
-            This is comparing the revision that the shelved changelist is *based* on, not
-            the shelved changelist itself.
-        """
-        ret = p4Cmd(["diff2", "{0}#{1}".format(path, filerev), "{0}@{1}".format(path, revision)])
-        if verbose:
-            print("p4 diff2 path %s filerev %s revision %s => %s" % (path, filerev, revision, ret))
-        return ret["status"] == "identical"
-
-    def extractFilesFromCommit(self, commit, shelved=False, shelved_cl = 0, origin_revision = 0):
+    def extractFilesFromCommit(self, commit, shelved=False, shelved_cl = 0):
         self.cloneExclude = [re.sub(r"\.\.\.$", "", path)
                              for path in self.cloneExclude]
         files = []
@@ -2650,17 +2639,6 @@ def extractFilesFromCommit(self, commit, shelved=False, shelved_cl = 0, origin_r
             file["type"] = commit["type%s" % fnum]
             if shelved:
                 file["shelved_cl"] = int(shelved_cl)
-
-                # For shelved changelists, check that the revision of each file that the
-                # shelve was based on matches the revision that we are using for the
-                # starting point for git-fast-import (self.initialParent). Otherwise
-                # the resulting diff will contain deltas from multiple commits.
-
-                if file["action"] != "add" and \
-                    not self.cmp_shelved(path, file["rev"], origin_revision):
-                    sys.exit("change {0} not based on {1} for {2}, cannot unshelve".format(
-                        commit["change"], self.initialParent, path))
-
             files.append(file)
             fnum = fnum + 1
         return files
@@ -3032,7 +3010,7 @@ def hasBranchPrefix(self, path):
             print('Ignoring file outside of prefix: {0}'.format(path))
         return hasPrefix
 
-    def commit(self, details, files, branch, parent = ""):
+    def commit(self, details, files, branch, parent = "", allow_empty=False):
         epoch = details["time"]
         author = details["user"]
         jobs = self.extractJobsFromCommit(details)
@@ -3046,7 +3024,10 @@ def commit(self, details, files, branch, parent = ""):
         files = [f for f in files
             if self.inClientSpec(f['path']) and self.hasBranchPrefix(f['path'])]
 
-        if not files and not gitConfigBool('git-p4.keepEmptyCommits'):
+        if gitConfigBool('git-p4.keepEmptyCommits'):
+            allow_empty = True
+
+        if not files and not allow_empty:
             print('Ignoring revision {0} as it would produce an empty commit.'
                 .format(details['change']))
             return
@@ -3387,10 +3368,10 @@ def searchParent(self, parent, branch, target):
         else:
             return None
 
-    def importChanges(self, changes, shelved=False, origin_revision=0):
+    def importChanges(self, changes, origin_revision=0):
         cnt = 1
         for change in changes:
-            description = p4_describe(change, shelved)
+            description = p4_describe(change)
             self.updateOptionDict(description)
 
             if not self.silent:
@@ -3460,7 +3441,7 @@ def importChanges(self, changes, shelved=False, origin_revision=0):
                                 print("Parent of %s not found. Committing into head of %s" % (branch, parent))
                             self.commit(description, filesForCommit, branch, parent)
                 else:
-                    files = self.extractFilesFromCommit(description, shelved, change, origin_revision)
+                    files = self.extractFilesFromCommit(description)
                     self.commit(description, files, self.branch,
                                 self.initialParent)
                     # only needed once, to connect to the previous commit
@@ -3957,7 +3938,6 @@ def __init__(self):
         self.verbose = False
         self.noCommit = False
         self.destbranch = "refs/remotes/p4-unshelved"
-        self.origin = "p4/master"
 
     def renameBranch(self, branch_name):
         """ Rename the existing branch to branch_name.N
@@ -3989,6 +3969,32 @@ def findLastP4Revision(self, starting_point):
 
         sys.exit("could not find git-p4 commits in {0}".format(self.origin))
 
+    def createShelveParent(self, change, branch_name, sync, origin):
+        """ Create a commit matching the parent of the shelved changelist 'change'
+        """
+        parent_description = p4_describe(change, shelved=True)
+        parent_description['desc'] = 'parent for shelved changelist {}\n'.format(change)
+        files = sync.extractFilesFromCommit(parent_description, shelved=False, shelved_cl=change)
+
+        parent_files = []
+        for f in files:
+            # if it was added in the shelved changelist, it won't exist in the parent
+            if f['action'] in self.add_actions:
+                continue
+
+            # if it was deleted in the shelved changelist it must not be deleted
+            # in the parent - we might even need to create it if the origin branch
+            # does not have it
+            if f['action'] in self.delete_actions:
+                f['action'] = 'add'
+
+            parent_files.append(f)
+
+        sync.commit(parent_description, parent_files, branch_name,
+                parent=origin, allow_empty=True)
+        print("created parent commit for {0} based on {1} in {2}".format(
+            change, self.origin, branch_name))
+
     def run(self, args):
         if len(args) != 1:
             return False
@@ -3998,9 +4004,8 @@ def run(self, args):
 
         sync = P4Sync()
         changes = args
-        sync.initialParent = self.origin
 
-        # use the first change in the list to construct the branch to unshelve into
+        # only one change at a time
         change = changes[0]
 
         # if the target branch already exists, rename it
@@ -4013,14 +4018,21 @@ def run(self, args):
         sync.suppress_meta_comment = True
 
         settings = self.findLastP4Revision(self.origin)
-        origin_revision = settings['change']
         sync.depotPaths = settings['depot-paths']
         sync.branchPrefixes = sync.depotPaths
 
         sync.openStreams()
         sync.loadUserMapFromCache()
         sync.silent = True
-        sync.importChanges(changes, shelved=True, origin_revision=origin_revision)
+
+        # create a commit for the parent of the shelved changelist
+        self.createShelveParent(change, branch_name, sync, self.origin)
+
+        # create the commit for the shelved changelist itself
+        description = p4_describe(change, True)
+        files = sync.extractFilesFromCommit(description, True, change)
+
+        sync.commit(description, files, branch_name, "")
         sync.closeStreams()
 
         print("unshelved changelist {0} into {1}".format(change, branch_name))
diff --git a/t/t9832-unshelve.sh b/t/t9832-unshelve.sh
index c3d15ceea8..98beadffe4 100755
--- a/t/t9832-unshelve.sh
+++ b/t/t9832-unshelve.sh
@@ -19,8 +19,10 @@ test_expect_success 'init depot' '
 		p4 add file1 &&
 		p4 submit -d "change 1" &&
 		: >file_to_delete &&
+		: >file_to_move &&
 		p4 add file_to_delete &&
-		p4 submit -d "file to delete"
+		p4 add file_to_move &&
+		p4 submit -d "add files to delete"
 	)
 '
 
@@ -36,6 +38,8 @@ test_expect_success 'create shelved changelist' '
 		echo "new file" >file2 &&
 		p4 add file2 &&
 		p4 delete file_to_delete &&
+		p4 edit file_to_move &&
+		p4 move file_to_move moved_file &&
 		p4 opened &&
 		p4 shelve -i <<EOF
 Change: new
@@ -47,6 +51,8 @@ Files:
 	//depot/file1
 	//depot/file2
 	//depot/file_to_delete
+	//depot/file_to_move
+	//depot/moved_file
 EOF
 
 	) &&
@@ -59,7 +65,9 @@ EOF
 		test_path_is_file file2 &&
 		test_cmp file1 "$cli"/file1 &&
 		test_cmp file2 "$cli"/file2 &&
-		test_path_is_missing file_to_delete
+		test_path_is_missing file_to_delete &&
+		test_path_is_missing file_to_move &&
+		test_path_is_file moved_file
 	)
 '
 
@@ -92,6 +100,18 @@ EOF
 	)
 '
 
+shelve_one_file () {
+	description="Change to be unshelved" &&
+	file="$1" &&
+	p4 shelve -i <<EOF
+Change: new
+Description:
+	$description
+Files:
+	$file
+EOF
+}
+
 # This is the tricky case where the shelved changelist base revision doesn't
 # match git-p4's idea of the base revision
 #
@@ -108,29 +128,52 @@ test_expect_success 'create shelved changelist based on p4 change ahead of p4/ma
 		p4 submit -d "change:foo" &&
 		p4 edit file1 &&
 		echo "bar" >>file1 &&
-		p4 shelve -i <<EOF &&
-Change: new
-Description:
-	Change to be unshelved
-Files:
-	//depot/file1
-EOF
+		shelve_one_file //depot/file1 &&
 		change=$(last_shelved_change) &&
-		p4 describe -S $change | grep -q "Change to be unshelved"
+		p4 describe -S $change >out.txt &&
+		grep -q "Change to be unshelved" out.txt
 	)
 '
 
-# Now try to unshelve it. git-p4 should refuse to do so.
+# Now try to unshelve it.
 test_expect_success 'try to unshelve the change' '
 	test_when_finished cleanup_git &&
 	(
 		change=$(last_shelved_change) &&
 		cd "$git" &&
-		test_must_fail git p4 unshelve $change 2>out.txt &&
-		grep -q "cannot unshelve" out.txt
+		git p4 unshelve $change >out.txt &&
+		grep -q "unshelved changelist $change" out.txt
 	)
 '
 
+# Specify the origin. Create 2 unrelated files, and check that
+# we only get the one in HEAD~, not the one in HEAD.
+
+test_expect_success 'unshelve specifying the origin' '
+	(
+		cd "$cli" &&
+		: >unrelated_file0 &&
+		p4 add unrelated_file0 &&
+		p4 submit -d "unrelated" &&
+		: >unrelated_file1 &&
+		p4 add unrelated_file1 &&
+		p4 submit -d "unrelated" &&
+		: >file_to_shelve &&
+		p4 add file_to_shelve &&
+		shelve_one_file //depot/file_to_shelve
+	) &&
+	git p4 clone --dest="$git" //depot/@all &&
+	test_when_finished cleanup_git &&
+	(
+		cd "$git" &&
+		change=$(last_shelved_change) &&
+		git p4 unshelve --origin HEAD~ $change &&
+		git checkout refs/remotes/p4-unshelved/$change &&
+		test_path_is_file unrelated_file0 &&
+		test_path_is_missing unrelated_file1 &&
+		test_path_is_file file_to_shelve
+	)
+'
 test_expect_success 'kill p4d' '
 	kill_p4d
 '
-- 
2.19.1.272.gf84b9b09d4

