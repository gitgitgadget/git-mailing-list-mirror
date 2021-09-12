Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AD6BC433F5
	for <git@archiver.kernel.org>; Sun, 12 Sep 2021 13:23:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2786D6113E
	for <git@archiver.kernel.org>; Sun, 12 Sep 2021 13:23:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235554AbhILNY4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Sep 2021 09:24:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235454AbhILNYv (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Sep 2021 09:24:51 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A7E0C061574
        for <git@vger.kernel.org>; Sun, 12 Sep 2021 06:23:37 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id e26so4660865wmk.2
        for <git@vger.kernel.org>; Sun, 12 Sep 2021 06:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=lD+F5ROkJ1GD99oCdCR4e2ZGsZUS65fErrzTrsgh7hQ=;
        b=UuGzt1FaIZd5ec/aOINpUT8F0zDs80U2CcBuZkxHVZyjKZs4kz4BRi81hfrh7/EyZs
         nJluh8TDno+vPzy88OhDlHw7gkcPltEOHBhuWdtdJOL8yfWD6QKBcm/qngwzdhvn1gIG
         wnkBEdl0XG1yX1EbR7UPm4cdw05l2cdnvO7FXBFs+cD1K3APn33bO1Ha6f/pcpEVxpW6
         EzRGdbMjwkn/NvHfS46ktOBepmpog/FWQrtovtLzl2/CwYPjAvNjxbEQlHMgNsRUACIU
         pYb7FAi4q2tsVIet2hEFLkgoTFZ6e8qCHZcR/ti59Ik9K4Z9vwS/yRYjqlFSbRtINeHS
         RVAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=lD+F5ROkJ1GD99oCdCR4e2ZGsZUS65fErrzTrsgh7hQ=;
        b=zAEfXyrcZiASoRQkRaTI9LhDIqd3OVweBUz8RGuDrCtHSDL5J5jE91LYWrgNQRIilc
         boGcceNVPYTPCJL+22jcoWap6J5h1rbT8gppxbKeUtYF4GX6szJMlPjL3gTg7IC33Dm8
         dih/mA/Q7DDx6kOp/txZdO/EBJ/yjFemiFwfxQb3uI9ENnuY0jIlwHZ3pgtanqlHNFmt
         nFe/eaWhJfXp0KQ0dl2tZjnLZpUch4QMspr3XZM6vkaL0pArSPHKSLriaTDK0TQ/gx7H
         bnBxZmnEFhRgIcYoDsGeCoLuZTZv8vbGKfknyIbJAbtvUs7oQaPJcO45cmBqrzKMEXU0
         1GWg==
X-Gm-Message-State: AOAM530d3g1Km7TeeHANqkY1mvKSiiFgQXxeVUA77W+0+3HmTusawDsN
        gNSmIN60tB/ZvecRiZSF2onxngWwPDw=
X-Google-Smtp-Source: ABdhPJwM3+rf/R+ANNfZvtzhVdYED7usYxLMnctPmlE4b+09J9YbbMqKkQdLvjvaL8fV3xURBtRpyA==
X-Received: by 2002:a05:600c:219:: with SMTP id 25mr6591144wmi.157.1631453015934;
        Sun, 12 Sep 2021 06:23:35 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k17sm4636551wmj.0.2021.09.12.06.23.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Sep 2021 06:23:35 -0700 (PDT)
Message-Id: <bac6cedfc8d50511975f146c41f1577f41976c6f.1631453010.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1018.v2.git.1631453010.gitgitgadget@gmail.com>
References: <pull.1018.git.1629842085.gitgitgadget@gmail.com>
        <pull.1018.v2.git.1631453010.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 12 Sep 2021 13:23:22 +0000
Subject: [PATCH v2 06/14] add: fail when adding an untracked sparse file
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, gitster@pobox.com, matheus.bernardino@usp.br,
        stolee@gmail.com, vdye@github.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The add_files() method in builtin/add.c takes a set of untracked files
that are being added by the input pathspec and inserts them into the
index. If these files are outside of the sparse-checkout cone, then they
gain the SKIP_WORKTREE bit at some point. However, this was not checked
before inserting into the index, so these files are added even though we
want to avoid modifying the index outside of the sparse-checkout cone.

Add a check within add_files() for these files and write the advice
about files outside of the sparse-checkout cone.

This behavior change modifies some existing tests within t1092. These
tests intended to document how a user could interact with the existing
behavior in place. Many of these tests need to be marked as expecting
failure. A future change will allow these tests to pass by adding a flag
to 'git add' that allows users to modify index entries outside of the
sparse-checkout cone.

The 'submodule handling' test is intended to document what happens to
directories that contain a submodule when the sparse index is enabled.
It is not trying to say that users should be able to add submodules
outside of the sparse-checkout cone, so that test can be modified to
avoid that operation.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/add.c                            | 14 +++++++++
 t/t1092-sparse-checkout-compatibility.sh | 37 ++++++++++++++++++------
 2 files changed, 42 insertions(+), 9 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index 88a6c0c69fb..8ea9cae0e7a 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -443,6 +443,7 @@ static void check_embedded_repo(const char *path)
 static int add_files(struct dir_struct *dir, int flags)
 {
 	int i, exit_status = 0;
+	struct string_list matched_sparse_paths = STRING_LIST_INIT_NODUP;
 
 	if (dir->ignored_nr) {
 		fprintf(stderr, _(ignore_error));
@@ -456,6 +457,11 @@ static int add_files(struct dir_struct *dir, int flags)
 	}
 
 	for (i = 0; i < dir->nr; i++) {
+		if (!path_in_sparse_checkout(dir->entries[i]->name, &the_index)) {
+			string_list_append(&matched_sparse_paths,
+					   dir->entries[i]->name);
+			continue;
+		}
 		if (add_file_to_index(&the_index, dir->entries[i]->name, flags)) {
 			if (!ignore_add_errors)
 				die(_("adding files failed"));
@@ -464,6 +470,14 @@ static int add_files(struct dir_struct *dir, int flags)
 			check_embedded_repo(dir->entries[i]->name);
 		}
 	}
+
+	if (matched_sparse_paths.nr) {
+		advise_on_updating_sparse_paths(&matched_sparse_paths);
+		exit_status = 1;
+	}
+
+	string_list_clear(&matched_sparse_paths, 0);
+
 	return exit_status;
 }
 
diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index 5b3f55e355e..997442b13e3 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -301,8 +301,6 @@ test_expect_success 'add, commit, checkout' '
 	test_all_match git checkout -
 '
 
-# NEEDSWORK: This documents current behavior, but is not a desirable
-# behavior (untracked files are handled differently than tracked).
 test_expect_success 'add outside sparse cone' '
 	init_repos &&
 
@@ -312,7 +310,9 @@ test_expect_success 'add outside sparse cone' '
 	test_sparse_match test_must_fail git add folder1/a &&
 	test_i18ngrep "Disable or modify the sparsity rules" sparse-checkout-err &&
 	test_sparse_unstaged folder1/a &&
-	test_sparse_match git add folder1/newfile
+	test_sparse_match test_must_fail git add folder1/newfile &&
+	test_i18ngrep "Disable or modify the sparsity rules" sparse-checkout-err &&
+	test_sparse_unstaged folder1/newfile
 '
 
 test_expect_success 'commit including unstaged changes' '
@@ -343,7 +343,11 @@ test_expect_success 'commit including unstaged changes' '
 	test_all_match git status --porcelain=v2
 '
 
-test_expect_success 'status/add: outside sparse cone' '
+# NEEDSWORK: Now that 'git add folder1/new' fails, the changes being
+# attempted here fail for the sparse-checkout and sparse-index repos.
+# We must enable a way for adding files outside the sparse-checkout
+# done, even if it is by an optional flag.
+test_expect_failure 'status/add: outside sparse cone' '
 	init_repos &&
 
 	# folder1 is at HEAD, but outside the sparse cone
@@ -368,10 +372,11 @@ test_expect_success 'status/add: outside sparse cone' '
 	test_sparse_match test_must_fail git add --refresh folder1/a &&
 	test_i18ngrep "Disable or modify the sparsity rules" sparse-checkout-err &&
 	test_sparse_unstaged folder1/a &&
+	test_sparse_match test_must_fail git add folder1/new &&
+	test_i18ngrep "Disable or modify the sparsity rules" sparse-checkout-err &&
+	test_sparse_unstaged folder1/new &&
 
-	# NEEDSWORK: Adding a newly-tracked file outside the cone succeeds
-	test_sparse_match git add folder1/new &&
-
+	# NEEDSWORK: behavior begins to deviate here.
 	test_all_match git add . &&
 	test_all_match git status --porcelain=v2 &&
 	test_all_match git commit -m folder1/new &&
@@ -527,7 +532,7 @@ test_expect_success 'merge, cherry-pick, and rebase' '
 # Right now, users might be using this flow to work through conflicts,
 # so any solution should present advice to users who try this sequence
 # of commands to follow whatever new method we create.
-test_expect_success 'merge with conflict outside cone' '
+test_expect_failure 'merge with conflict outside cone' '
 	init_repos &&
 
 	test_all_match git checkout -b merge-tip merge-left &&
@@ -541,12 +546,18 @@ test_expect_success 'merge with conflict outside cone' '
 	test_all_match git status --porcelain=v2 &&
 
 	# 2. Add the file with conflict markers
+	# NEEDSWORK: Even though the merge conflict removed the
+	# SKIP_WORKTREE bit from the index entry for folder1/a, we should
+	# warn that this is a problematic add.
 	test_all_match git add folder1/a &&
 	test_all_match git status --porcelain=v2 &&
 
 	# 3. Rename the file to another sparse filename and
 	#    accept conflict markers as resolved content.
 	run_on_all mv folder2/a folder2/z &&
+	# NEEDSWORK: This mode now fails, because folder2/z is
+	# outside of the sparse-checkout cone and does not match an
+	# existing index entry with the SKIP_WORKTREE bit cleared.
 	test_all_match git add folder2 &&
 	test_all_match git status --porcelain=v2 &&
 
@@ -555,7 +566,7 @@ test_expect_success 'merge with conflict outside cone' '
 	test_all_match git rev-parse HEAD^{tree}
 '
 
-test_expect_success 'cherry-pick/rebase with conflict outside cone' '
+test_expect_failure 'cherry-pick/rebase with conflict outside cone' '
 	init_repos &&
 
 	for OPERATION in cherry-pick rebase
@@ -572,11 +583,17 @@ test_expect_success 'cherry-pick/rebase with conflict outside cone' '
 		test_all_match git status --porcelain=v2 &&
 
 		# 2. Add the file with conflict markers
+		# NEEDSWORK: Even though the merge conflict removed the
+		# SKIP_WORKTREE bit from the index entry for folder1/a, we should
+		# warn that this is a problematic add.
 		test_all_match git add folder1/a &&
 		test_all_match git status --porcelain=v2 &&
 
 		# 3. Rename the file to another sparse filename and
 		#    accept conflict markers as resolved content.
+		# NEEDSWORK: This mode now fails, because folder2/z is
+		# outside of the sparse-checkout cone and does not match an
+		# existing index entry with the SKIP_WORKTREE bit cleared.
 		run_on_all mv folder2/a folder2/z &&
 		test_all_match git add folder2 &&
 		test_all_match git status --porcelain=v2 &&
@@ -654,6 +671,7 @@ test_expect_success 'clean' '
 test_expect_success 'submodule handling' '
 	init_repos &&
 
+	test_sparse_match git sparse-checkout add modules &&
 	test_all_match mkdir modules &&
 	test_all_match touch modules/a &&
 	test_all_match git add modules &&
@@ -663,6 +681,7 @@ test_expect_success 'submodule handling' '
 	test_all_match git commit -m "add submodule" &&
 
 	# having a submodule prevents "modules" from collapse
+	test_sparse_match git sparse-checkout set deep/deeper1 &&
 	test-tool -C sparse-index read-cache --table >cache &&
 	grep "100644 blob .*	modules/a" cache &&
 	grep "160000 commit $(git -C initial-repo rev-parse HEAD)	modules/sub" cache
-- 
gitgitgadget

