Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5374CC4332F
	for <git@archiver.kernel.org>; Fri, 18 Nov 2022 11:32:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241348AbiKRLcO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Nov 2022 06:32:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241100AbiKRLbZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Nov 2022 06:31:25 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD7207CBB0
        for <git@vger.kernel.org>; Fri, 18 Nov 2022 03:31:20 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id f7so6734163edc.6
        for <git@vger.kernel.org>; Fri, 18 Nov 2022 03:31:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jdn61e8sDlxNj/Upzywkgx2Ay9LC/zQqr4qZQU/Rzpk=;
        b=cxsxXi1KANaTRxdGunGZEuu8FO4GF3GsGTdm2x8+e8N+tKZILt93E2pwamXmdq1PGL
         D9DFI0BqdgqzvVzXB7Juax0BmcCeYhxPdxJWqPaU3CZC0tFn5iIkIb0IHHSeocw0epC9
         TsrjetZJwUtxrzzns6DPlaNJFs+WflsXERDoVqsni9EMhop8zIHi81y9L94NNcMjAawP
         ClTkR0dNG/9dNCpPVu1QwKu7Z6fFTEU0eQ2vWrRqpf4R5OxUoTt7RWH54MTKZK3m/hvG
         WX1wKjXixxh8UYQXI/fyCrUmIXZ7AGXu7R1JZOCHCCAhz+JcJSj8BJ3mwH5V9D4vBE2S
         qYBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jdn61e8sDlxNj/Upzywkgx2Ay9LC/zQqr4qZQU/Rzpk=;
        b=z1Cz6G8xo7swM7vcyeQnF3nqpeSLNld5+HIZJYXakIbSHyvYYGZvY4WNrX6kfDq+dK
         sn7ZvVs45o50STVRxCEzZBYYWju7+i8PSBx9b2YsfWp9i7L3wTYiFqL0tYSBMtrZc3z1
         dfjdOWwbMkk3trjd/9zzQC7sCgnunMVdy2DC/mQOQQhmf4XWBMtpGXxOoJFy7+KJYsTm
         j0+Tqy1mr3q/mwUaxLjsPCSz3vqBdzwv/Garp/UO3rrIIiz8xLgVr/xjYqWNru9CDtm8
         QBPG0dUWbaKegxeM0BpDhBEwvI57iZRWlyyBGkRNfQWiqDFdOL6cR2LCjALY0iqgZAiu
         bB4w==
X-Gm-Message-State: ANoB5plgD9RpldRcNm0uJG16O/TWHzCO4ECrGq1XbDK+FN8lYYf1zSQv
        em1fxkGDvNX5aiH7ErnJlXUf8iSAB0O90Q==
X-Google-Smtp-Source: AA0mqf6YSgICFM6tnNh8nHvhRniF4a/85qv+39zH80Po0qiHew1CHLiS0S4bj5OCGgjeILeMEaFfKw==
X-Received: by 2002:a50:fd98:0:b0:467:5f07:b575 with SMTP id o24-20020a50fd98000000b004675f07b575mr5860806edt.65.1668771078760;
        Fri, 18 Nov 2022 03:31:18 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id cw24-20020a056402229800b0046730154ccbsm1713302edb.42.2022.11.18.03.31.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 03:31:18 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 11/12] cocci: apply "pending" index-compatibility to some "builtin/*.c"
Date:   Fri, 18 Nov 2022 12:31:05 +0100
Message-Id: <patch-11.12-3cb15ff40f6-20221118T112205Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1511.gcdcff1f1dc2
In-Reply-To: <cover-00.12-00000000000-20221118T112205Z-avarab@gmail.com>
References: <cover-00.12-00000000000-20221118T112205Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Apply "index-compatibility.pending.cocci" rule to those "builtin/*",
and commit the ones that have 3 uses or less of the relevant
macros.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/add.c            | 6 +++---
 builtin/check-attr.c     | 2 +-
 builtin/check-ignore.c   | 2 +-
 builtin/checkout-index.c | 7 ++++---
 builtin/clean.c          | 2 +-
 builtin/clone.c          | 2 +-
 builtin/describe.c       | 5 +++--
 builtin/diff-files.c     | 2 +-
 builtin/diff-index.c     | 4 ++--
 builtin/diff-tree.c      | 2 +-
 builtin/fsck.c           | 2 +-
 builtin/merge-index.c    | 4 ++--
 builtin/merge-ours.c     | 2 +-
 builtin/rebase.c         | 4 ++--
 builtin/reset.c          | 7 ++++---
 builtin/rev-parse.c      | 2 +-
 16 files changed, 29 insertions(+), 26 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index 23f9f0e08bb..566c27e5311 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -312,7 +312,7 @@ static int edit_patch(int argc, const char **argv, const char *prefix)
 
 	git_config(git_diff_basic_config, NULL); /* no "diff" UI options */
 
-	if (read_cache() < 0)
+	if (repo_read_index(the_repository) < 0)
 		die(_("Could not read the index"));
 
 	repo_init_revisions(the_repository, &rev, prefix);
@@ -544,7 +544,7 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 	prepare_repo_settings(the_repository);
 	the_repository->settings.command_requires_full_index = 0;
 
-	hold_locked_index(&lock_file, LOCK_DIE_ON_ERROR);
+	repo_hold_locked_index(the_repository, &lock_file, LOCK_DIE_ON_ERROR);
 
 	/*
 	 * Check the "pathspec '%s' did not match any files" block
@@ -587,7 +587,7 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 		 (!(addremove || take_worktree_changes)
 		  ? ADD_CACHE_IGNORE_REMOVAL : 0));
 
-	if (read_cache_preload(&pathspec) < 0)
+	if (repo_read_index_preload(the_repository, &pathspec, 0) < 0)
 		die(_("index file corrupt"));
 
 	die_in_unpopulated_submodule(&the_index, prefix);
diff --git a/builtin/check-attr.c b/builtin/check-attr.c
index dd833977864..2b9271f816c 100644
--- a/builtin/check-attr.c
+++ b/builtin/check-attr.c
@@ -115,7 +115,7 @@ int cmd_check_attr(int argc, const char **argv, const char *prefix)
 	argc = parse_options(argc, argv, prefix, check_attr_options,
 			     check_attr_usage, PARSE_OPT_KEEP_DASHDASH);
 
-	if (read_cache() < 0) {
+	if (repo_read_index(the_repository) < 0) {
 		die("invalid cache");
 	}
 
diff --git a/builtin/check-ignore.c b/builtin/check-ignore.c
index 21912569650..6ebd0169fc8 100644
--- a/builtin/check-ignore.c
+++ b/builtin/check-ignore.c
@@ -179,7 +179,7 @@ int cmd_check_ignore(int argc, const char **argv, const char *prefix)
 		die(_("--non-matching is only valid with --verbose"));
 
 	/* read_cache() is only necessary so we can watch out for submodules. */
-	if (!no_index && read_cache() < 0)
+	if (!no_index && repo_read_index(the_repository) < 0)
 		die(_("index file corrupt"));
 
 	setup_standard_excludes(&dir);
diff --git a/builtin/checkout-index.c b/builtin/checkout-index.c
index c2aee450c40..9087005b4fb 100644
--- a/builtin/checkout-index.c
+++ b/builtin/checkout-index.c
@@ -65,7 +65,7 @@ static void write_tempfile_record(const char *name, const char *prefix)
 static int checkout_file(const char *name, const char *prefix)
 {
 	int namelen = strlen(name);
-	int pos = cache_name_pos(name, namelen);
+	int pos = index_name_pos(&the_index, name, namelen);
 	int has_same_name = 0;
 	int is_file = 0;
 	int is_skipped = 1;
@@ -249,7 +249,7 @@ int cmd_checkout_index(int argc, const char **argv, const char *prefix)
 	prepare_repo_settings(the_repository);
 	the_repository->settings.command_requires_full_index = 0;
 
-	if (read_cache() < 0) {
+	if (repo_read_index(the_repository) < 0) {
 		die("invalid cache");
 	}
 
@@ -270,7 +270,8 @@ int cmd_checkout_index(int argc, const char **argv, const char *prefix)
 	if (index_opt && !state.base_dir_len && !to_tempfile) {
 		state.refresh_cache = 1;
 		state.istate = &the_index;
-		hold_locked_index(&lock_file, LOCK_DIE_ON_ERROR);
+		repo_hold_locked_index(the_repository, &lock_file,
+				       LOCK_DIE_ON_ERROR);
 	}
 
 	get_parallel_checkout_configs(&pc_workers, &pc_threshold);
diff --git a/builtin/clean.c b/builtin/clean.c
index 7084e685f6f..7bdeb01d30e 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -1012,7 +1012,7 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 	prepare_repo_settings(the_repository);
 	the_repository->settings.command_requires_full_index = 0;
 
-	if (read_cache() < 0)
+	if (repo_read_index(the_repository) < 0)
 		die(_("index file corrupt"));
 
 	pl = add_pattern_list(&dir, EXC_CMDL, "--exclude option");
diff --git a/builtin/clone.c b/builtin/clone.c
index 0e4348686b6..8ab0453a292 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -703,7 +703,7 @@ static int checkout(int submodule_progress, int filter_submodules)
 	/* We need to be in the new work tree for the checkout */
 	setup_work_tree();
 
-	hold_locked_index(&lock_file, LOCK_DIE_ON_ERROR);
+	repo_hold_locked_index(the_repository, &lock_file, LOCK_DIE_ON_ERROR);
 
 	memset(&opts, 0, sizeof opts);
 	opts.update = 1;
diff --git a/builtin/describe.c b/builtin/describe.c
index 23e3f05fb10..4f4a58eef2b 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -653,10 +653,11 @@ int cmd_describe(int argc, const char **argv, const char *prefix)
 			int fd, result;
 
 			setup_work_tree();
-			read_cache();
+			repo_read_index(the_repository);
 			refresh_index(&the_index, REFRESH_QUIET|REFRESH_UNMERGED,
 				      NULL, NULL, NULL);
-			fd = hold_locked_index(&index_lock, 0);
+			fd = repo_hold_locked_index(the_repository,
+						    &index_lock, 0);
 			if (0 <= fd)
 				repo_update_index_if_able(the_repository, &index_lock);
 
diff --git a/builtin/diff-files.c b/builtin/diff-files.c
index 096ea2fedbc..1f3deb13c28 100644
--- a/builtin/diff-files.c
+++ b/builtin/diff-files.c
@@ -76,7 +76,7 @@ int cmd_diff_files(int argc, const char **argv, const char *prefix)
 	    (rev.diffopt.output_format & DIFF_FORMAT_PATCH))
 		diff_merges_set_dense_combined_if_unset(&rev);
 
-	if (read_cache_preload(&rev.diffopt.pathspec) < 0) {
+	if (repo_read_index_preload(the_repository, &rev.diffopt.pathspec, 0) < 0) {
 		perror("read_cache_preload");
 		result = -1;
 		goto cleanup;
diff --git a/builtin/diff-index.c b/builtin/diff-index.c
index aea139b9d8f..a178e774a5a 100644
--- a/builtin/diff-index.c
+++ b/builtin/diff-index.c
@@ -62,11 +62,11 @@ int cmd_diff_index(int argc, const char **argv, const char *prefix)
 		usage(diff_cache_usage);
 	if (!(option & DIFF_INDEX_CACHED)) {
 		setup_work_tree();
-		if (read_cache_preload(&rev.diffopt.pathspec) < 0) {
+		if (repo_read_index_preload(the_repository, &rev.diffopt.pathspec, 0) < 0) {
 			perror("read_cache_preload");
 			return -1;
 		}
-	} else if (read_cache() < 0) {
+	} else if (repo_read_index(the_repository) < 0) {
 		perror("read_cache");
 		return -1;
 	}
diff --git a/builtin/diff-tree.c b/builtin/diff-tree.c
index 85e8c81e594..a724087261d 100644
--- a/builtin/diff-tree.c
+++ b/builtin/diff-tree.c
@@ -120,7 +120,7 @@ int cmd_diff_tree(int argc, const char **argv, const char *prefix)
 
 	git_config(git_diff_basic_config, NULL); /* no "diff" UI options */
 	repo_init_revisions(the_repository, opt, prefix);
-	if (read_cache() < 0)
+	if (repo_read_index(the_repository) < 0)
 		die(_("index file corrupt"));
 	opt->abbrev = 0;
 	opt->diff = 1;
diff --git a/builtin/fsck.c b/builtin/fsck.c
index cd47675e371..d6f9a31e216 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -958,7 +958,7 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 	if (keep_cache_objects) {
 		verify_index_checksum = 1;
 		verify_ce_order = 1;
-		read_cache();
+		repo_read_index(the_repository);
 		/* TODO: audit for interaction with sparse-index. */
 		ensure_full_index(&the_index);
 		for (i = 0; i < the_index.cache_nr; i++) {
diff --git a/builtin/merge-index.c b/builtin/merge-index.c
index a334c513c9d..b1d98294cdd 100644
--- a/builtin/merge-index.c
+++ b/builtin/merge-index.c
@@ -47,7 +47,7 @@ static int merge_entry(int pos, const char *path)
 
 static void merge_one_path(const char *path)
 {
-	int pos = cache_name_pos(path, strlen(path));
+	int pos = index_name_pos(&the_index, path, strlen(path));
 
 	/*
 	 * If it already exists in the cache as stage0, it's
@@ -82,7 +82,7 @@ int cmd_merge_index(int argc, const char **argv, const char *prefix)
 	if (argc < 3)
 		usage("git merge-index [-o] [-q] <merge-program> (-a | [--] [<filename>...])");
 
-	read_cache();
+	repo_read_index(the_repository);
 
 	/* TODO: audit for interaction with sparse-index. */
 	ensure_full_index(&the_index);
diff --git a/builtin/merge-ours.c b/builtin/merge-ours.c
index 3583cff71c7..5d95acf52a6 100644
--- a/builtin/merge-ours.c
+++ b/builtin/merge-ours.c
@@ -25,7 +25,7 @@ int cmd_merge_ours(int argc, const char **argv, const char *prefix)
 	 * commit.  The index must match HEAD, or this merge cannot go
 	 * through.
 	 */
-	if (read_cache() < 0)
+	if (repo_read_index(the_repository) < 0)
 		die_errno("read_cache failed");
 	if (index_differs_from(the_repository, "HEAD", NULL, 0))
 		return 2;
diff --git a/builtin/rebase.c b/builtin/rebase.c
index 5d855fd8f51..345a55755a3 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -292,7 +292,7 @@ static int do_interactive_rebase(struct rebase_options *opts, unsigned flags)
 	if (ret)
 		error(_("could not generate todo list"));
 	else {
-		discard_cache();
+		discard_index(&the_index);
 		if (todo_list_parse_insn_buffer(the_repository, todo_list.buf.buf,
 						&todo_list))
 			BUG("unusable todo list");
@@ -1268,7 +1268,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		if (get_oid("HEAD", &head))
 			die(_("Cannot read HEAD"));
 
-		fd = hold_locked_index(&lock_file, 0);
+		fd = repo_hold_locked_index(the_repository, &lock_file, 0);
 		if (repo_read_index(the_repository) < 0)
 			die(_("could not read index"));
 		refresh_index(the_repository->index, REFRESH_QUIET, NULL, NULL,
diff --git a/builtin/reset.c b/builtin/reset.c
index 25ff76c17a3..5ab03e9616a 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -158,7 +158,7 @@ static void update_index_from_diff(struct diff_queue_struct *q,
 		 * if this entry is outside the sparse cone - this is necessary
 		 * to properly construct the reset sparse directory.
 		 */
-		pos = cache_name_pos(one->path, strlen(one->path));
+		pos = index_name_pos(&the_index, one->path, strlen(one->path));
 		if ((pos >= 0 && ce_skip_worktree(the_index.cache[pos])) ||
 		    (pos < 0 && !path_in_sparse_checkout(one->path, &the_index)))
 			ce->ce_flags |= CE_SKIP_WORKTREE;
@@ -421,7 +421,7 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 	prepare_repo_settings(the_repository);
 	the_repository->settings.command_requires_full_index = 0;
 
-	if (read_cache() < 0)
+	if (repo_read_index(the_repository) < 0)
 		die(_("index file corrupt"));
 
 	/* Soft reset does not touch the index file nor the working tree
@@ -432,7 +432,8 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 
 	if (reset_type != SOFT) {
 		struct lock_file lock = LOCK_INIT;
-		hold_locked_index(&lock, LOCK_DIE_ON_ERROR);
+		repo_hold_locked_index(the_repository, &lock,
+				       LOCK_DIE_ON_ERROR);
 		if (reset_type == MIXED) {
 			int flags = quiet ? REFRESH_QUIET : REFRESH_IN_PORCELAIN;
 			if (read_from_tree(&pathspec, &oid, intent_to_add))
diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index 8f61050bde8..bffdd27bd7e 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -997,7 +997,7 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 				continue;
 			}
 			if (!strcmp(arg, "--shared-index-path")) {
-				if (read_cache() < 0)
+				if (repo_read_index(the_repository) < 0)
 					die(_("Could not read the index"));
 				if (the_index.split_index) {
 					const struct object_id *oid = &the_index.split_index->base_oid;
-- 
2.38.0.1511.gcdcff1f1dc2

