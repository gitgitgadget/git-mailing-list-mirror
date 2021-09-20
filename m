Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EE32C433FE
	for <git@archiver.kernel.org>; Mon, 20 Sep 2021 23:37:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3098560F48
	for <git@archiver.kernel.org>; Mon, 20 Sep 2021 23:37:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239079AbhITXix (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Sep 2021 19:38:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239553AbhITXgw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Sep 2021 19:36:52 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C391EC0EDAFD
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 10:45:45 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id q11so32027115wrr.9
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 10:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=A8TgwsbfHxO9u2oNd2R9FA5mxbQVoLEmF9HajWMbfbA=;
        b=H9kuWiM2kVvOd+5A59Sac9k0FpWoREM0aFYAqQrKhLx9zgo3UOtvde7y2zEMbJMnIO
         BhPJ+/6SteViMfe5Q0i5Jhdh0MEn8wrALFl3Rp9glIIEIcXmO5mynrUy9pXdpmV8F7Me
         gYzkRDG4BQ1HgVx/l03aq/zv8vxIKBmmHO6H/FCEHbbUeltT8Wr+IfXzjUEnaBdHaLRn
         XpptoHmjAhx+zn8lpZaxdanUfNBvB+bkqTc1yoNM9MsnIElVWtkCBXaqGfHDkv76Pwcs
         PNbtXi4yWKkxGw6/ISflBG8w8Wyfx4SUQeBXVjQWW8Ww6NP8IdSJd/K+wMfUX8CL6hUo
         t0iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=A8TgwsbfHxO9u2oNd2R9FA5mxbQVoLEmF9HajWMbfbA=;
        b=pwJ2q+ESwd0veQtcLj2/pmR3Zx3uFN82FR5DuhO0E6g4hRgZVmLwhcB7uIy+8O9NDh
         v+Zh406Oxcxt0u3dFClkCzUmkdSN/j/539SOXJPB7vHLtNi3xtuYNLm51uRGb4+ex3hr
         jTt+APKNxF7sY86m7d2U4FT0fFFbBPsufzJSFwimTJBXU3/fCcYyD9t3iZD9K0DUa0XD
         6xoWCtcSXxQ/tsLMr+IMGZ5Dil+wGjsYUdJkad/J5qFVcY5j5WnOPMcIp13UWu5H+WC4
         Bda42r/aj/aYKe7WdkJnzsBsCZ7vuMLW7lSu9IjTGCDs6HuxqOI/kTnpfAzNL2QkMxa2
         LoaQ==
X-Gm-Message-State: AOAM530+AtWsHEK3vcIljESui3BTTlRAQYx0I26xjhr0sV1sZfwqHBRF
        ybKd3pR9EbCz2PX573t0TJx2p5eEzMk=
X-Google-Smtp-Source: ABdhPJxhVImqTSon5ZA00diq0MJ/cwQFJW1D/Mg7GLtl0XDLrPKp2Zz27sdElgzKkFz5eRuVrnt2Aw==
X-Received: by 2002:a05:6000:18ab:: with SMTP id b11mr18041475wri.131.1632159944259;
        Mon, 20 Sep 2021 10:45:44 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j14sm16822732wrp.21.2021.09.20.10.45.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 10:45:43 -0700 (PDT)
Message-Id: <6014ac8ab9ed699065dca21d7dfba059c98b8a52.1632159937.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1018.v3.git.1632159937.gitgitgadget@gmail.com>
References: <pull.1018.v2.git.1631453010.gitgitgadget@gmail.com>
        <pull.1018.v3.git.1632159937.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 20 Sep 2021 17:45:31 +0000
Subject: [PATCH v3 08/14] add: implement the --sparse option
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, gitster@pobox.com, matheus.bernardino@usp.br,
        stolee@gmail.com, vdye@github.com,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

We previously modified 'git add' to refuse updating index entries
outside of the sparse-checkout cone. This is justified to prevent users
from accidentally getting into a confusing state when Git removes those
files from the working tree at some later point.

Unfortunately, this caused some workflows that were previously possible
to become impossible, especially around merge conflicts outside of the
sparse-checkout cone. These were documented in tests within t1092.

We now re-enable these workflows using a new '--sparse' option to 'git
add'. This allows users to signal "Yes, I do know what I'm doing with
these files," and accept the consequences of the files leaving the
worktree later.

We delay updating the advice message until implementing a similar option
in 'git rm' and 'git mv'.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/git-add.txt                |  9 +++++++-
 builtin/add.c                            | 12 ++++++----
 t/t1092-sparse-checkout-compatibility.sh | 29 +++++++++---------------
 t/t3705-add-sparse-checkout.sh           | 17 +++++++++++++-
 4 files changed, 43 insertions(+), 24 deletions(-)

diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
index be5e3ac54b8..11eb70f16c7 100644
--- a/Documentation/git-add.txt
+++ b/Documentation/git-add.txt
@@ -9,7 +9,7 @@ SYNOPSIS
 --------
 [verse]
 'git add' [--verbose | -v] [--dry-run | -n] [--force | -f] [--interactive | -i] [--patch | -p]
-	  [--edit | -e] [--[no-]all | --[no-]ignore-removal | [--update | -u]]
+	  [--edit | -e] [--[no-]all | --[no-]ignore-removal | [--update | -u]] [--sparse]
 	  [--intent-to-add | -N] [--refresh] [--ignore-errors] [--ignore-missing] [--renormalize]
 	  [--chmod=(+|-)x] [--pathspec-from-file=<file> [--pathspec-file-nul]]
 	  [--] [<pathspec>...]
@@ -79,6 +79,13 @@ in linkgit:gitglossary[7].
 --force::
 	Allow adding otherwise ignored files.
 
+--sparse::
+	Allow updating index entries outside of the sparse-checkout cone.
+	Normally, `git add` refuses to update index entries whose paths do
+	not fit within the sparse-checkout cone, since those files might
+	be removed from the working tree without warning. See
+	linkgit:git-sparse-checkout[1] for more details.
+
 -i::
 --interactive::
 	Add modified contents in the working tree interactively to
diff --git a/builtin/add.c b/builtin/add.c
index 09c3fad6321..f8e3930608d 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -30,6 +30,7 @@ static int patch_interactive, add_interactive, edit_interactive;
 static int take_worktree_changes;
 static int add_renormalize;
 static int pathspec_file_nul;
+static int include_sparse;
 static const char *pathspec_from_file;
 static int legacy_stash_p; /* support for the scripted `git stash` */
 
@@ -46,7 +47,7 @@ static int chmod_pathspec(struct pathspec *pathspec, char flip, int show_only)
 		struct cache_entry *ce = active_cache[i];
 		int err;
 
-		if (ce_skip_worktree(ce))
+		if (!include_sparse && ce_skip_worktree(ce))
 			continue;
 
 		if (pathspec && !ce_path_match(&the_index, ce, pathspec, NULL))
@@ -95,7 +96,7 @@ static void update_callback(struct diff_queue_struct *q,
 		struct diff_filepair *p = q->queue[i];
 		const char *path = p->one->path;
 
-		if (!path_in_sparse_checkout(path, &the_index))
+		if (!include_sparse && !path_in_sparse_checkout(path, &the_index))
 			continue;
 
 		switch (fix_unmerged_status(p, data)) {
@@ -383,6 +384,7 @@ static struct option builtin_add_options[] = {
 	OPT_BOOL( 0 , "refresh", &refresh_only, N_("don't add, only refresh the index")),
 	OPT_BOOL( 0 , "ignore-errors", &ignore_add_errors, N_("just skip files which cannot be added because of errors")),
 	OPT_BOOL( 0 , "ignore-missing", &ignore_missing, N_("check if - even missing - files are ignored in dry run")),
+	OPT_BOOL(0, "sparse", &include_sparse, N_("allow updating entries outside of the sparse-checkout cone")),
 	OPT_STRING(0, "chmod", &chmod_arg, "(+|-)x",
 		   N_("override the executable bit of the listed files")),
 	OPT_HIDDEN_BOOL(0, "warn-embedded-repo", &warn_on_embedded_repo,
@@ -461,7 +463,8 @@ static int add_files(struct dir_struct *dir, int flags)
 	}
 
 	for (i = 0; i < dir->nr; i++) {
-		if (!path_in_sparse_checkout(dir->entries[i]->name, &the_index)) {
+		if (!include_sparse &&
+		    !path_in_sparse_checkout(dir->entries[i]->name, &the_index)) {
 			string_list_append(&matched_sparse_paths,
 					   dir->entries[i]->name);
 			continue;
@@ -646,7 +649,8 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 			if (seen[i])
 				continue;
 
-			if (matches_skip_worktree(&pathspec, i, &skip_worktree_seen)) {
+			if (!include_sparse &&
+			    matches_skip_worktree(&pathspec, i, &skip_worktree_seen)) {
 				string_list_append(&only_match_skip_worktree,
 						   pathspec.items[i].original);
 				continue;
diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index ba2483732ff..b11fc540415 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -343,11 +343,7 @@ test_expect_success 'commit including unstaged changes' '
 	test_all_match git status --porcelain=v2
 '
 
-# NEEDSWORK: Now that 'git add folder1/new' fails, the changes being
-# attempted here fail for the sparse-checkout and sparse-index repos.
-# We must enable a way for adding files outside the sparse-checkout
-# done, even if it is by an optional flag.
-test_expect_failure 'status/add: outside sparse cone' '
+test_expect_success 'status/add: outside sparse cone' '
 	init_repos &&
 
 	# folder1 is at HEAD, but outside the sparse cone
@@ -375,15 +371,16 @@ test_expect_failure 'status/add: outside sparse cone' '
 	test_sparse_match test_must_fail git add folder1/new &&
 	grep "Disable or modify the sparsity rules" sparse-checkout-err &&
 	test_sparse_unstaged folder1/new &&
+	test_sparse_match git add --sparse folder1/a &&
+	test_sparse_match git add --sparse folder1/new &&
 
-	# NEEDSWORK: behavior begins to deviate here.
-	test_all_match git add . &&
+	test_all_match git add --sparse . &&
 	test_all_match git status --porcelain=v2 &&
 	test_all_match git commit -m folder1/new &&
 	test_all_match git rev-parse HEAD^{tree} &&
 
 	run_on_all ../edit-contents folder1/newer &&
-	test_all_match git add folder1/ &&
+	test_all_match git add --sparse folder1/ &&
 	test_all_match git status --porcelain=v2 &&
 	test_all_match git commit -m folder1/newer &&
 	test_all_match git rev-parse HEAD^{tree}
@@ -527,12 +524,7 @@ test_expect_success 'merge, cherry-pick, and rebase' '
 	done
 '
 
-# NEEDSWORK: This test is documenting current behavior, but that
-# behavior can be confusing to users so there is desire to change it.
-# Right now, users might be using this flow to work through conflicts,
-# so any solution should present advice to users who try this sequence
-# of commands to follow whatever new method we create.
-test_expect_failure 'merge with conflict outside cone' '
+test_expect_success 'merge with conflict outside cone' '
 	init_repos &&
 
 	test_all_match git checkout -b merge-tip merge-left &&
@@ -549,17 +541,16 @@ test_expect_failure 'merge with conflict outside cone' '
 	test_sparse_match test_must_fail git add folder1/a &&
 	grep "Disable or modify the sparsity rules" sparse-checkout-err &&
 	test_sparse_unstaged folder1/a &&
+	test_all_match git add --sparse folder1/a &&
 	test_all_match git status --porcelain=v2 &&
 
 	# 3. Rename the file to another sparse filename and
 	#    accept conflict markers as resolved content.
 	run_on_all mv folder2/a folder2/z &&
-	# NEEDSWORK: This mode now fails, because folder2/z is
-	# outside of the sparse-checkout cone and does not match an
-	# existing index entry with the SKIP_WORKTREE bit cleared.
 	test_sparse_match test_must_fail git add folder2 &&
 	grep "Disable or modify the sparsity rules" sparse-checkout-err &&
 	test_sparse_unstaged folder2/z &&
+	test_all_match git add --sparse folder2 &&
 	test_all_match git status --porcelain=v2 &&
 
 	test_all_match git merge --continue &&
@@ -567,7 +558,7 @@ test_expect_failure 'merge with conflict outside cone' '
 	test_all_match git rev-parse HEAD^{tree}
 '
 
-test_expect_failure 'cherry-pick/rebase with conflict outside cone' '
+test_expect_success 'cherry-pick/rebase with conflict outside cone' '
 	init_repos &&
 
 	for OPERATION in cherry-pick rebase
@@ -590,6 +581,7 @@ test_expect_failure 'cherry-pick/rebase with conflict outside cone' '
 		test_sparse_match test_must_fail git add folder1/a &&
 		grep "Disable or modify the sparsity rules" sparse-checkout-err &&
 		test_sparse_unstaged folder1/a &&
+		test_all_match git add --sparse folder1/a &&
 		test_all_match git status --porcelain=v2 &&
 
 		# 3. Rename the file to another sparse filename and
@@ -601,6 +593,7 @@ test_expect_failure 'cherry-pick/rebase with conflict outside cone' '
 		test_sparse_match test_must_fail git add folder2 &&
 		grep "Disable or modify the sparsity rules" sparse-checkout-err &&
 		test_sparse_unstaged folder2/z &&
+		test_all_match git add --sparse folder2 &&
 		test_all_match git status --porcelain=v2 &&
 
 		test_all_match git $OPERATION --continue &&
diff --git a/t/t3705-add-sparse-checkout.sh b/t/t3705-add-sparse-checkout.sh
index 5899f270d02..0434cdfd9c6 100755
--- a/t/t3705-add-sparse-checkout.sh
+++ b/t/t3705-add-sparse-checkout.sh
@@ -167,7 +167,13 @@ test_expect_success 'git add fails outside of sparse-checkout definition' '
 
 	git update-index --no-skip-worktree sparse_entry &&
 	test_must_fail git add sparse_entry &&
-	test_sparse_entry_unstaged
+	test_sparse_entry_unstaged &&
+
+	# Avoid munging CRLFs to avoid an error message
+	git -c core.autocrlf=input add --sparse sparse_entry 2>stderr &&
+	test_must_be_empty stderr &&
+	test-tool read-cache --table >actual &&
+	grep "^100644 blob.*sparse_entry\$" actual
 '
 
 test_expect_success 'add obeys advice.updateSparsePath' '
@@ -178,4 +184,13 @@ test_expect_success 'add obeys advice.updateSparsePath' '
 
 '
 
+test_expect_success 'add allows sparse entries with --sparse' '
+	git sparse-checkout set a &&
+	echo modified >sparse_entry &&
+	test_must_fail git add sparse_entry &&
+	test_sparse_entry_unchanged &&
+	git add --sparse sparse_entry 2>stderr &&
+	test_must_be_empty stderr
+'
+
 test_done
-- 
gitgitgadget

