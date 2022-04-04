Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A76E2C433F5
	for <git@archiver.kernel.org>; Mon,  4 Apr 2022 05:11:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239063AbiDDFN0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Apr 2022 01:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377367AbiDDFM4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Apr 2022 01:12:56 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9790F381AA
        for <git@vger.kernel.org>; Sun,  3 Apr 2022 22:10:57 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id q19so5730657wrc.6
        for <git@vger.kernel.org>; Sun, 03 Apr 2022 22:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=0jsxRoW67GVD5R6Gk779WevfVi8y8jCqX/lOnIChAhI=;
        b=TinuuNjs04aGA91Uw7PwKDU1l0sCpFgcgeY7AStXSKvNSNZdSLMAljq8nK3QCFpcxf
         7lnCIxMVYJSU8bP+aZSa17bgqt0uVWanhOMlDe+h0jWFlMeRRBKinBBKmMi9+G+ePgOn
         J+xm6a334wzEaZQM9YiIwJ7mEvL+UeetwEUHLXRar945rXMqwnf59cQEnGobyB3K/lK7
         lAznKEHIPwuYwxnErxDR6TiYjBFsQQ8A3HkoRd9hoQZsDQUmqhGtODQzDCb5igF9sRBU
         2YDQSRXGvOonJhKe38ipeQNqSWxSyzl3PfVKTlBfUU/SMD5IDi7XzPxbDv5XfSzqTsNQ
         jEww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=0jsxRoW67GVD5R6Gk779WevfVi8y8jCqX/lOnIChAhI=;
        b=6hDtNuuLaQLVvMripCpGdKLoDltNGRLrlibfqWgDTYAPHnKvs+4K2IXIULRiQ1JZfd
         qI4BN896dBpuIQ+Ohc1VWr9GKJdy8uVfSrEF3ZR+1plsLmNN1tos7g7M2z2wDmJPlzDc
         fEic71ei66YXzcX4K+cJRoLYszBfFl+t5K6+6u2dgTry8MZi8y/5H55iNUtBxijU5D9j
         JkZDViS2OMe4D5shodgcHHsD/R8MheALLSy/ZxouufxN194uc50szd6yrMEwqqnxZKhx
         5EnRa0JEb5efsEzwytsfkAqiGkOhuCsACK6oukZvkSyCAUfP9U+IQOm6YA0GtIzPO8vN
         LxuA==
X-Gm-Message-State: AOAM5303QmcpirSXxdXAe1gdh43+R3Mnuuh2zPsLvF8AzrfSrFvKZXir
        7+4ye2tCUvJO1NUYcJ+0M0/Wc14clgo=
X-Google-Smtp-Source: ABdhPJw0wAckZwL5QdN2Z/2TxQlL4ZtUYlNQqqnfA4Dck4HnMK08mQznEn+vu1+ozuIt8ctG7aq62A==
X-Received: by 2002:adf:ed09:0:b0:206:81c:1eda with SMTP id a9-20020adfed09000000b00206081c1edamr6622202wro.430.1649049055814;
        Sun, 03 Apr 2022 22:10:55 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i9-20020a5d5849000000b002058631cfacsm8561529wrf.61.2022.04.03.22.10.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Apr 2022 22:10:55 -0700 (PDT)
Message-Id: <pull.1202.git.1649049054600.gitgitgadget@gmail.com>
From:   "Tao Klerks via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 04 Apr 2022 05:10:54 +0000
Subject: [PATCH] git-p4: support explicit sync of arbitrary existing git-p4
 refs
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Tao Klerks <tao@klerks.biz>, Tao Klerks <tao@klerks.biz>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Tao Klerks <tao@klerks.biz>

With the --branch argument of the "sync" subcommand, git-p4 enables
you to import a perforce branch/path to an arbitrary git ref, using
a full ref path, or to refs/remotes/p4/* or refs/heads/p4/*,
depending on --import-local, using a short ref name.

However, when you later want to explicitly sync such a given ref to
pick up subsequent p4 changes, it only works if the ref was placed
in the p4 path *and* has only one path component (no "/").

This limitation results from a bad assumption in the
existing-branch sync logic, and also means you cannot individually
sync branches detected by --detect-branches, as these also get a
"/" in their names.

Fix "git p4 sync --branch", when called with an existing ref, so
that it works correctly regardless of whether the ref is in the p4
path or not, and (in the case of refs in the p4 path) regardless of
whether it has a "/" in its short name or not.

Also add tests to validate that these branch-specific syncs work
as expected.

Signed-off-by: Tao Klerks <tao@klerks.biz>
---
    git-p4: support explicit sync of arbitrary existing git-p4 refs

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1202%2FTaoK%2Fgit-p4-structured-paths-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1202/TaoK/git-p4-structured-paths-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1202

 git-p4.py                | 52 +++++++++++++++++-------
 t/t9800-git-p4-basic.sh  | 85 ++++++++++++++++++++++++++++++++++++++++
 t/t9801-git-p4-branch.sh | 10 +++++
 3 files changed, 133 insertions(+), 14 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index a9b1f904410..48d5805ee41 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -893,6 +893,36 @@ def gitConfigList(key):
             _gitConfig[key] = []
     return _gitConfig[key]
 
+def fullP4Ref(incomingRef, importIntoRemotes=True):
+    """Standardize a given provided p4 ref value to a full git ref:
+         refs/foo/bar/branch -> use it exactly
+         p4/branch -> prepend refs/remotes/ or refs/heads/
+         branch -> prepend refs/remotes/p4/ or refs/heads/p4/"""
+    if incomingRef.startswith("refs/"):
+        return incomingRef
+    if importIntoRemotes:
+        prepend = "refs/remotes/"
+    else:
+        prepend = "refs/heads/"
+    if not incomingRef.startswith("p4/"):
+        prepend += "p4/"
+    return prepend + incomingRef
+
+def shortP4Ref(incomingRef, importIntoRemotes=True):
+    """Standardize to a "short ref" if possible:
+         refs/foo/bar/branch -> ignore
+         refs/remotes/p4/branch or refs/heads/p4/branch -> shorten
+         p4/branch -> shorten"""
+    if importIntoRemotes:
+        longprefix = "refs/remotes/p4/"
+    else:
+        longprefix = "refs/heads/p4/"
+    if incomingRef.startswith(longprefix):
+        return incomingRef[len(longprefix):]
+    if incomingRef.startswith("p4/"):
+        return incomingRef[3:]
+    return incomingRef
+
 def p4BranchesInGit(branchesAreInRemotes=True):
     """Find all the branches whose names start with "p4/", looking
        in remotes or heads as specified by the argument.  Return
@@ -3750,9 +3780,13 @@ class P4Sync(Command, P4UserMap):
 
             # restrict to just this one, disabling detect-branches
             if branch_arg_given:
-                short = self.branch.split("/")[-1]
+                short = shortP4Ref(self.branch, self.importIntoRemotes)
                 if short in branches:
                     self.p4BranchesInGit = [ short ]
+                elif self.branch.startswith('refs/') and \
+                        branchExists(self.branch) and \
+                        '[git-p4:' in extractLogMessageFromGitCommit(self.branch):
+                    self.p4BranchesInGit = [ self.branch ]
             else:
                 self.p4BranchesInGit = branches.keys()
 
@@ -3769,7 +3803,8 @@ class P4Sync(Command, P4UserMap):
 
             p4Change = 0
             for branch in self.p4BranchesInGit:
-                logMsg =  extractLogMessageFromGitCommit(self.refPrefix + branch)
+                logMsg = extractLogMessageFromGitCommit(fullP4Ref(branch,
+                                                        self.importIntoRemotes))
 
                 settings = extractSettingsGitLog(logMsg)
 
@@ -3802,18 +3837,7 @@ class P4Sync(Command, P4UserMap):
                 if not self.silent and not self.detectBranches:
                     print("Performing incremental import into %s git branch" % self.branch)
 
-        # accept multiple ref name abbreviations:
-        #    refs/foo/bar/branch -> use it exactly
-        #    p4/branch -> prepend refs/remotes/ or refs/heads/
-        #    branch -> prepend refs/remotes/p4/ or refs/heads/p4/
-        if not self.branch.startswith("refs/"):
-            if self.importIntoRemotes:
-                prepend = "refs/remotes/"
-            else:
-                prepend = "refs/heads/"
-            if not self.branch.startswith("p4/"):
-                prepend += "p4/"
-            self.branch = prepend + self.branch
+        self.branch = fullP4Ref(self.branch, self.importIntoRemotes)
 
         if len(args) == 0 and self.depotPaths:
             if not self.silent:
diff --git a/t/t9800-git-p4-basic.sh b/t/t9800-git-p4-basic.sh
index 806005a793a..cc457765c2e 100755
--- a/t/t9800-git-p4-basic.sh
+++ b/t/t9800-git-p4-basic.sh
@@ -74,6 +74,91 @@ test_expect_success 'git p4 sync new branch' '
 	)
 '
 
+#
+# Setup as before, and then explicitly sync imported branch, using a
+# different ref format.
+#
+test_expect_success 'git p4 sync existing branch without changes' '
+	test_create_repo "$git" &&
+	test_when_finished cleanup_git &&
+	(
+		cd "$git" &&
+		test_commit head &&
+		git p4 sync --branch=depot //depot@all &&
+		git p4 sync --branch=refs/remotes/p4/depot >out &&
+		test_i18ngrep "No changes to import!" out
+	)
+'
+
+#
+# Same as before, relative branch name.
+#
+test_expect_success 'git p4 sync existing branch with relative name' '
+	test_create_repo "$git" &&
+	test_when_finished cleanup_git &&
+	(
+		cd "$git" &&
+		test_commit head &&
+		git p4 sync --branch=branch1 //depot@all &&
+		git p4 sync --branch=p4/branch1 >out &&
+		test_i18ngrep "No changes to import!" out
+	)
+'
+
+#
+# Same as before, with a nested branch path, referenced different ways.
+#
+test_expect_success 'git p4 sync existing branch with nested path' '
+	test_create_repo "$git" &&
+	test_when_finished cleanup_git &&
+	(
+		cd "$git" &&
+		test_commit head &&
+		git p4 sync --branch=p4/some/path //depot@all &&
+		git p4 sync --branch=some/path >out &&
+		test_i18ngrep "No changes to import!" out
+	)
+'
+
+#
+# Same as before, with a full ref path outside the p4/* namespace.
+#
+test_expect_success 'git p4 sync branch explicit ref without p4 in path' '
+	test_create_repo "$git" &&
+	test_when_finished cleanup_git &&
+	(
+		cd "$git" &&
+		test_commit head &&
+		git p4 sync --branch=refs/remotes/someremote/depot //depot@all &&
+		git p4 sync --branch=refs/remotes/someremote/depot >out &&
+		test_i18ngrep "No changes to import!" out
+	)
+'
+
+test_expect_success 'git p4 sync nonexistent ref' '
+	test_create_repo "$git" &&
+	test_when_finished cleanup_git &&
+	(
+		cd "$git" &&
+		test_commit head &&
+		git p4 sync --branch=depot //depot@all &&
+		test_must_fail git p4 sync --branch=depot2 2>errs &&
+		test_i18ngrep "Perhaps you never did" errs
+	)
+'
+
+test_expect_success 'git p4 sync existing non-p4-imported ref' '
+	test_create_repo "$git" &&
+	test_when_finished cleanup_git &&
+	(
+		cd "$git" &&
+		test_commit head &&
+		git p4 sync --branch=depot //depot@all &&
+		test_must_fail git p4 sync --branch=refs/heads/master 2>errs &&
+		test_i18ngrep "Perhaps you never did" errs
+	)
+'
+
 test_expect_success 'clone two dirs' '
 	(
 		cd "$cli" &&
diff --git a/t/t9801-git-p4-branch.sh b/t/t9801-git-p4-branch.sh
index 50a6f8bad5c..759a14fa87c 100755
--- a/t/t9801-git-p4-branch.sh
+++ b/t/t9801-git-p4-branch.sh
@@ -129,6 +129,16 @@ test_expect_success 'import depot, branch detection' '
 	)
 '
 
+test_expect_success 'sync specific detected branch' '
+	test_when_finished cleanup_git &&
+	git p4 clone --dest="$git" --detect-branches //depot@all &&
+	(
+		cd "$git" &&
+		git p4 sync --branch=depot/branch2 >out &&
+		test_i18ngrep "No changes to import!" out
+	)
+'
+
 test_expect_success 'import depot, branch detection, branchList branch definition' '
 	test_when_finished cleanup_git &&
 	test_create_repo "$git" &&

base-commit: 805e0a68082a217f0112db9ee86a022227a9c81b
-- 
gitgitgadget
