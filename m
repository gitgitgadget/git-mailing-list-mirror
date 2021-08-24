Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1233C4320E
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 21:55:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCE3B613D2
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 21:55:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238595AbhHXVzo (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Aug 2021 17:55:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238290AbhHXVzg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Aug 2021 17:55:36 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D602BC061764
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 14:54:51 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id n5so21000184wro.12
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 14:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=j4VGYWR9mA/cViJvu3yL7KCsiqk2cVMZlAu7B3NC73M=;
        b=ceHEL7cc1JVxvf/oGxCfD+KB9U10wVFBAv1LA2R7qSCxVGl/kdijIss5Wh4XIMRr4Q
         omG/5fwmBo9olilvWfNPgm+JGvA8AbEDxIyx0RcLHrfoVBkUa8S3j1FpbsIe6bkgGmpW
         LMLULKalpf1LJpKR+cBkCznTz3+ekn344wP4kczAl4cg9Jl5j60hhhIAPxXokqqk1qAc
         BexPIj9ToldZ3FGNtLLJxzEeFMrF4so0dsxlIhdBZ2LGvGDcPYU0tQBe0uovgCS+XT5A
         Z4BI4BKWoSMN5UchmwYqr5BUz5dtGW+O0OV3rdfnPiAz1cAb3mTlwaLv1CgdAWgBWzyK
         yTaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=j4VGYWR9mA/cViJvu3yL7KCsiqk2cVMZlAu7B3NC73M=;
        b=fLEQYkiX7fpUIPVYEFTHbVTsnPUtXqlPhyUdl1Ob9b73UMMyXhPKSyRGyI3yMyTvrL
         CmatKoQOvIIBbfZcDllQnbbnbgTRX21OTrXFVohXkW4euC61HndUWiFSo2L2AwSGL443
         snNrvX9r6gah3hiucyEp8XiNbMDetLa6iDPa1k6uMvJ1s8iNs1K7KiKChTsEBwIFlZ50
         OOuiTGD1LsbmN0DOW9HSP9nFgW353xW4Wh+zN5anLpDRm7HEk4a3IPZ65kMu3miCWLOv
         0ELss6q55d7Eqri7r3BMrQIce4P9E2hObCZIM78PM9tekhG05vnRYHsd407r9uJTDcQ7
         NoPg==
X-Gm-Message-State: AOAM531/aP7wCDVJ+XEe22d8j0/HQoysOZ8KVbB+JB9kH8wM6ZJx5QET
        AlCIob4j2Rk/gl2wXTIVZ8+SJoZErpY=
X-Google-Smtp-Source: ABdhPJwxLZSYdhhvBHWKWrC7zDM9FJm2XOs6ylQThTCZ1TKwwpxO8N1v64WaIHyWRJt4QfxKbZU2JA==
X-Received: by 2002:adf:df08:: with SMTP id y8mr21841130wrl.124.1629842090514;
        Tue, 24 Aug 2021 14:54:50 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z11sm2646958wrw.53.2021.08.24.14.54.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 14:54:50 -0700 (PDT)
Message-Id: <6edadbc2000bd6d2ec76cbeff08b309ae4928b37.1629842085.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1018.git.1629842085.gitgitgadget@gmail.com>
References: <pull.1018.git.1629842085.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 24 Aug 2021 21:54:39 +0000
Subject: [PATCH 07/13] add: implement the --sparse option
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, gitster@pobox.com, matheus.bernardino@usp.br,
        stolee@gmail.com, Derrick Stolee <derrickstolee@github.com>,
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
 builtin/add.c                            | 10 ++++++---
 t/t1092-sparse-checkout-compatibility.sh | 28 ++++++++----------------
 t/t3705-add-sparse-checkout.sh           |  8 +++++++
 4 files changed, 32 insertions(+), 23 deletions(-)

diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
index be5e3ac54b8..bb79016d2ca 100644
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
+	linkgit:git-sparse-checkout[1] for more.
+
 -i::
 --interactive::
 	Add modified contents in the working tree interactively to
diff --git a/builtin/add.c b/builtin/add.c
index 3a109276b74..68f2de80594 100644
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
@@ -379,6 +380,7 @@ static struct option builtin_add_options[] = {
 	OPT_BOOL( 0 , "refresh", &refresh_only, N_("don't add, only refresh the index")),
 	OPT_BOOL( 0 , "ignore-errors", &ignore_add_errors, N_("just skip files which cannot be added because of errors")),
 	OPT_BOOL( 0 , "ignore-missing", &ignore_missing, N_("check if - even missing - files are ignored in dry run")),
+	OPT_BOOL(0, "sparse", &include_sparse, N_("allow updating entries outside of the sparse-checkout cone")),
 	OPT_STRING(0, "chmod", &chmod_arg, "(+|-)x",
 		   N_("override the executable bit of the listed files")),
 	OPT_HIDDEN_BOOL(0, "warn-embedded-repo", &warn_on_embedded_repo,
@@ -457,7 +459,8 @@ static int add_files(struct dir_struct *dir, int flags)
 	}
 
 	for (i = 0; i < dir->nr; i++) {
-		if (!path_in_sparse_checkout(dir->entries[i]->name, &the_index)) {
+		if (!include_sparse &&
+		    !path_in_sparse_checkout(dir->entries[i]->name, &the_index)) {
 			string_list_append(&only_match_skip_worktree,
 					   dir->entries[i]->name);
 			continue;
@@ -642,7 +645,8 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 			if (seen[i])
 				continue;
 
-			if (matches_skip_worktree(&pathspec, i, &skip_worktree_seen)) {
+			if (!include_sparse &&
+			    matches_skip_worktree(&pathspec, i, &skip_worktree_seen)) {
 				string_list_append(&only_match_skip_worktree,
 						   pathspec.items[i].original);
 				continue;
diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index c2a4eec548d..1e7799fd76a 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -329,11 +329,7 @@ test_expect_success 'commit including unstaged changes' '
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
@@ -355,15 +351,16 @@ test_expect_failure 'status/add: outside sparse cone' '
 	test_sparse_match test_must_fail git add folder1/a &&
 	test_sparse_match test_must_fail git add --refresh folder1/a &&
 	test_sparse_match test_must_fail git add folder1/new &&
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
@@ -507,12 +504,7 @@ test_expect_success 'merge, cherry-pick, and rebase' '
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
@@ -528,17 +520,15 @@ test_expect_failure 'merge with conflict outside cone' '
 	# 2. Add the file with conflict markers
 	# NEEDSWORK: Even though the merge conflict removed the
 	# SKIP_WORKTREE bit from the index entry for folder1/a, we should
-	# warn that this is a problematic add.
-	test_sparse_match test_must_fail git add folder1/a &&
+	# warn that this is a problematic add when --sparse is not set.
+	test_all_match git add --sparse folder1/a &&
 	test_all_match git status --porcelain=v2 &&
 
 	# 3. Rename the file to another sparse filename and
 	#    accept conflict markers as resolved content.
 	run_on_all mv folder2/a folder2/z &&
-	# NEEDSWORK: This mode now fails, because folder2/z is
-	# outside of the sparse-checkout cone and does not match an
-	# existing index entry with the SKIP_WORKTREE bit cleared.
 	test_sparse_match test_must_fail git add folder2 &&
+	test_all_match git add --sparse folder2 &&
 	test_all_match git status --porcelain=v2 &&
 
 	test_all_match git merge --continue &&
diff --git a/t/t3705-add-sparse-checkout.sh b/t/t3705-add-sparse-checkout.sh
index 2b1fd0d0eef..99c27dd9fb7 100755
--- a/t/t3705-add-sparse-checkout.sh
+++ b/t/t3705-add-sparse-checkout.sh
@@ -152,4 +152,12 @@ test_expect_success 'add obeys advice.updateSparsePath' '
 
 '
 
+test_expect_success 'add allows sparse entries with --sparse' '
+	git sparse-checkout set a &&
+	echo modified >sparse_entry &&
+	test_must_fail git add sparse_entry &&
+	git add --sparse sparse_entry 2>stderr &&
+	test_must_be_empty stderr
+'
+
 test_done
-- 
gitgitgadget

