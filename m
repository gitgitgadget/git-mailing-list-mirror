Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5B03C433B4
	for <git@archiver.kernel.org>; Sat,  8 May 2021 16:12:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8403610CD
	for <git@archiver.kernel.org>; Sat,  8 May 2021 16:12:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbhEHQNj (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 8 May 2021 12:13:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbhEHQNj (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 May 2021 12:13:39 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B346C061574
        for <git@vger.kernel.org>; Sat,  8 May 2021 09:12:36 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id l18-20020a1ced120000b029014c1adff1edso8741916wmh.4
        for <git@vger.kernel.org>; Sat, 08 May 2021 09:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=l803FxbubDPADIyepqabnKp/o5iRwZQ1hdcxO2Gfai0=;
        b=RJ70A/7y2wsI3TbV/K/F/5rbPC1+qymJ75UoRZtsVtfG/NudKd0BbGzZTO4bGl7mmp
         iS7QgpJMa1UNtt1rjSDVM6dlfw6Sf1FG376B47zKBnQLVZc+rMc6v+dlh2WC6TpvN4tI
         kk1bRDK8g8ipl5QOk6OBpyUWpklWK/gmNNFJFZrd+A7SfppAsBesDNaAIX8yeIHDGoen
         wkR3aVzEosXJA2VN7OtlyESaVFIExLXHqNHx1+tUkp/I5NPFLeuejW1VgGE3vbmlhBKy
         XUQ6jIyFCrAnpUXjYAHJHg4oyLZURnnUmHJ8g/sbxFqhRuIJbXmVh+aJrqYgLilB99Ym
         towg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=l803FxbubDPADIyepqabnKp/o5iRwZQ1hdcxO2Gfai0=;
        b=Sd1DSSFJxtdcZpFkxD9n218e9xJnDnSosZi42XPe/1oxYn7b7SON+k5JPsoxTCZ+NG
         eRTDB4MQRJGcLM7M596ZSILZZR3NOSReU91eZ6CaVSmUL8wdEFce+N5vKcdBXkbIWnAA
         i2NI83VRY8pkqYdV+sh4WMn4m/XnzhL/k6hR+TPRteM7TJhgiv69rwt7COSkkmtmKmRO
         oLC2hQgPJQL6lnglgTMcnk2urwftfPgtWymxzw3TZ2bAs1DgeTis1tDR0M+Q1rkc+P6A
         jzKTdY+BUS7ceXfDrOsC9Fb2XSfWQvybyOPu66/7Amwa94WspezL/ZYIDYKr4U0lRkza
         zZ8A==
X-Gm-Message-State: AOAM530/7YWpubOzihnEjVK3sPS5V87B8RervNC8pW7O6sJKEuj1CiO9
        5/IrD8nvhWcZdjNoRXC9z8Wu6PQ4D8Y=
X-Google-Smtp-Source: ABdhPJzf03ZtQgeapGuXCs5XUOhzcB8TIW6SOm7QHh/u3bD9UFAnRuM+V4Kz9ZDz4KZL2/LV/CX43w==
X-Received: by 2002:a05:600c:230f:: with SMTP id 15mr15704117wmo.19.1620490355005;
        Sat, 08 May 2021 09:12:35 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c15sm13930094wrr.3.2021.05.08.09.12.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 May 2021 09:12:34 -0700 (PDT)
Message-Id: <pull.941.git.1620490353758.gitgitgadget@gmail.com>
From:   "Evan McLain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 08 May 2021 16:12:33 +0000
Subject: [PATCH] git-p4: fix "git p4 sync" after ignored changelist
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Evan McLain <git.commit@none-of-yer.biz>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Evan McLain <git.commit@none-of-yer.biz>

After a sync/clone, if the very next p4 change is outside the client
view (and therefore "empty" as far as git-p4 is concerned), a
subsequent sync will fail with a message like:

     "fast-import failed: warning: Not updating refs/remotes/p4/master
      (new tip xxxxxx does not contain yyyyyy)"

The bug is caused by discarding the parent commit information
unconditionally after processing a p4 change, whether the change was
committed or not.  This leaves the next non-empty commit disconnected
from its parent, causing fast-import to fail.  This only occurs when
git-p4.keepEmptyCommits is false, but that is the default.

Rename P4Sync.commit() to maybeCommit() and return True if the change
is committed, or False if ignored. Clear P4Sync.initialParent only if
maybeCommit() returns True.

Diagnosed by IanH at https://stackoverflow.com/a/39876288/2033415

Signed-off-by: Evan McLain <git.commit@none-of-yer.biz>
---
    git-p4: fix "git p4 sync" after ignored changelist
    
    After a sync/clone, if the very next p4 change is outside the client
    view (and therefore "empty" as far as git-p4 is concerned), a subsequent
    sync will fail with a message like:
    
     "fast-import failed: warning: Not updating refs/remotes/p4/master
      (new tip xxxxxx does not contain yyyyyy)"
    
    
    The bug is caused by discarding the parent commit information
    unconditionally after processing a p4 change, whether the change was
    committed or not. This leaves the next non-empty commit disconnected
    from its parent, causing fast-import to fail. This only occurs when
    git-p4.keepEmptyCommits is false, but that is the default.
    
    Rename P4Sync.commit() to maybeCommit() and return True if the change is
    committed, or False if ignored. Clear P4Sync.initialParent only if
    maybeCommit() returns True.
    
    Diagnosed by IanH at https://stackoverflow.com/a/39876288/2033415
    
    Signed-off-by: Evan McLain git.commit@none-of-yer.biz
    
    ===
    
    There may be some other latent bugs here that I haven't fixed. In
    particular, there seems to be a similar flow when detecting branches
    with del self.initialParents[branch]. I wasn't sure how to set up a
    repro case to expose that error, so I just fixed the bug I understood.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-941%2Femclain%2Fem%2Ffix-p4-sync-after-ignored-change-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-941/emclain/em/fix-p4-sync-after-ignored-change-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/941

 git-p4.py                     | 29 +++++++++++++++------------
 t/t9809-git-p4-client-view.sh | 37 +++++++++++++++++++++++++++++++++++
 2 files changed, 53 insertions(+), 13 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 09c9e93ac401..f15818e1a842 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -3251,7 +3251,9 @@ def findShadowedFiles(self, files, change):
                     'rev': record['headRev'],
                     'type': record['headType']})
 
-    def commit(self, details, files, branch, parent = "", allow_empty=False):
+    # Commit a p4 change to git, unless it should be ignored.
+    # Returns True if the change was committed to git, or False if it was ignored.
+    def maybeCommit(self, details, files, branch, parent = "", allow_empty=False):
         epoch = details["time"]
         author = details["user"]
         jobs = self.extractJobsFromCommit(details)
@@ -3274,7 +3276,7 @@ def commit(self, details, files, branch, parent = "", allow_empty=False):
         if not files and not allow_empty:
             print('Ignoring revision {0} as it would produce an empty commit.'
                 .format(details['change']))
-            return
+            return False
 
         self.gitStream.write("commit %s\n" % branch)
         self.gitStream.write("mark :%s\n" % details["change"])
@@ -3340,6 +3342,7 @@ def commit(self, details, files, branch, parent = "", allow_empty=False):
                 if not self.silent:
                     print("Tag %s does not match with change %s: file count is different."
                            % (labelDetails["label"], change))
+        return True
 
     # Build a dictionary of changelists and labels, for "detect-labels" option.
     def getLabels(self):
@@ -3676,22 +3679,22 @@ def importChanges(self, changes, origin_revision=0):
                             tempBranch = "%s/%d" % (self.tempBranchLocation, change)
                             if self.verbose:
                                 print("Creating temporary branch: " + tempBranch)
-                            self.commit(description, filesForCommit, tempBranch)
+                            self.maybeCommit(description, filesForCommit, tempBranch)
                             self.tempBranches.append(tempBranch)
                             self.checkpoint()
                             blob = self.searchParent(parent, branch, tempBranch)
                         if blob:
-                            self.commit(description, filesForCommit, branch, blob)
+                            self.maybeCommit(description, filesForCommit, branch, blob)
                         else:
                             if self.verbose:
                                 print("Parent of %s not found. Committing into head of %s" % (branch, parent))
-                            self.commit(description, filesForCommit, branch, parent)
+                            self.maybeCommit(description, filesForCommit, branch, parent)
                 else:
                     files = self.extractFilesFromCommit(description)
-                    self.commit(description, files, self.branch,
-                                self.initialParent)
-                    # only needed once, to connect to the previous commit
-                    self.initialParent = ""
+                    if self.maybeCommit(description, files, self.branch,
+                                        self.initialParent):
+                        # only needed once, to connect to the previous commit
+                        self.initialParent = ""
             except IOError:
                 print(self.gitError.read())
                 sys.exit(1)
@@ -3755,7 +3758,7 @@ def importHeadRevision(self, revision):
 
         self.updateOptionDict(details)
         try:
-            self.commit(details, self.extractFilesFromCommit(details), self.branch)
+            self.maybeCommit(details, self.extractFilesFromCommit(details), self.branch)
         except IOError as err:
             print("IO error with git fast-import. Is your git version recent enough?")
             print("IO error details: {}".format(err))
@@ -4265,8 +4268,8 @@ def createShelveParent(self, change, branch_name, sync, origin):
 
             parent_files.append(f)
 
-        sync.commit(parent_description, parent_files, branch_name,
-                parent=origin, allow_empty=True)
+        sync.maybeCommit(parent_description, parent_files, branch_name,
+                         parent=origin, allow_empty=True)
         print("created parent commit for {0} based on {1} in {2}".format(
             change, self.origin, branch_name))
 
@@ -4307,7 +4310,7 @@ def run(self, args):
         description = p4_describe(change, True)
         files = sync.extractFilesFromCommit(description, True, change)
 
-        sync.commit(description, files, branch_name, "")
+        sync.maybeCommit(description, files, branch_name, "")
         sync.closeStreams()
 
         print("unshelved changelist {0} into {1}".format(change, branch_name))
diff --git a/t/t9809-git-p4-client-view.sh b/t/t9809-git-p4-client-view.sh
index 9c9710d8c7b8..4daf0305474c 100755
--- a/t/t9809-git-p4-client-view.sh
+++ b/t/t9809-git-p4-client-view.sh
@@ -147,6 +147,43 @@ test_expect_success 'later mapping takes precedence (partial repo)' '
 	git_verify $files
 '
 
+# after a sync/clone of a partial client view, if the very next p4 change is outside
+# the view and thus ignored, the a subsequent sync will fail to connect to its parent:
+#     "fast-import failed: warning: Not updating refs/remotes/p4/master
+#      (new tip x does not contain y)"
+test_expect_success 'partial sync bug with ignored change' '
+	client_view "//depot/dir1/... //client/..." &&
+	files="file11 file12" &&
+	client_verify $files &&
+	test_when_finished cleanup_git &&
+	git p4 clone --use-client-spec --dest="$git" //depot &&
+	cli2="$TRASH_DIRECTORY/cli2" &&
+	mkdir -p "$cli2" &&
+	test_when_finished "p4 client -f -d client2 && rm -rf \"$cli2\"" &&
+	(
+		cd "$cli2" &&
+		P4CLIENT=client2 &&
+		cli="$cli2" &&
+		client_view "//depot/... //client2/..." &&
+		p4 sync &&
+		p4 open dir2/file21 &&
+		echo dir2/file21 update >dir2/file21 &&
+		p4 submit -d "update dir2/file21"
+	) &&
+	(
+		cd "$cli" &&
+		p4 sync &&
+		p4 open file11 &&
+		echo file11 update >file11 &&
+		p4 submit -d "update file11"
+	) &&
+	(
+		cd "$git" &&
+		git p4 sync --use-client-spec
+	) &&
+	git_verify $files
+'
+
 # Reading the view backwards,
 #   dir2 goes to cli12
 #   dir1 cannot go to cli12 since it was filled by dir2

base-commit: 48bf2fa8bad054d66bd79c6ba903c89c704201f7
-- 
gitgitgadget
