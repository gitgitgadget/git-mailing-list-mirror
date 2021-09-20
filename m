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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F574C433F5
	for <git@archiver.kernel.org>; Mon, 20 Sep 2021 23:39:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E478161159
	for <git@archiver.kernel.org>; Mon, 20 Sep 2021 23:39:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241515AbhITXkk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Sep 2021 19:40:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241514AbhITXih (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Sep 2021 19:38:37 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD0D8C0EFE43
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 10:45:48 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id u15so32046413wru.6
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 10:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=CHuU91yH6kh+CD5Uo0bNvdZ4oWb+wQY5zc7hR6FDZdA=;
        b=LMqPt/aCqmoLdMO9FvTZPZ9quZaJzU6l+AXksivZ1AOD5Ru5lXBh/y10Bdv37vUbUQ
         /50DQNqRZiROzSJKD/gmGyK6/0Us4dPFDl3zK5AijgKYugSsTXikNqdv6oeyTBGAzBe5
         eJ6A2TdQdunGtpOIwavfm3aRmK//UwKOriFNgvFgoC/NJXi/oNHYxWwPbjh2Vo2zEDe5
         QNKewTS8+oEJzbmlH7ElpOo7DQ7bKwoVIblRCTy3X3z9+6AoRrLzhRdi8nmqjR2flF3G
         oYwr7VXHddVWdFe8GOODQxhi2Bh54aCuiZiL4hBjhmwaSnU4O7zhAJUWwnh3BzRiSt/z
         eRrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=CHuU91yH6kh+CD5Uo0bNvdZ4oWb+wQY5zc7hR6FDZdA=;
        b=xVA3U9AT0+g2fGGiKlZnoQylbFDx/crKIGIOocVZDlbQuSNJlDjtMGo3Bk1wVkt4wp
         H0lhdn7OQVi6K71Z5d7zGiZFuWPJLOTQp57Bk+QWdPGMmUepDcGxEZfrrGp9r29Mvq7N
         u7KO0Waii7+gigCp3RNa++alZYkUQdh+X3Ong2qTrK/UvlzoMXyfj94xFT7SpVF0thvq
         SFOSloy+v/Rnsx0buQif3SRQEb0AeRA5CXS4jhGaR38klX8k7JubE/83XpRuVJIN/UUF
         DuJq4SqIxSwr8FKQcRNtOd8D7nYwh4KKZErg/5bnCBfcg/Q2xstdfLBs1BTRXtzQ4HLS
         QUxg==
X-Gm-Message-State: AOAM530ZUFJ08buBgkdci2Hw3GsgLmEr6bxhchiS0ASJ6mp7yNzydICA
        GGsQsY/ScqlAGeLcCLLexlaFWyJPtR4=
X-Google-Smtp-Source: ABdhPJzM2Wcvgrsbr7AYD70tWxFR+NVh6ATlglDhn5GXuKeKJKhBfSiSGnjtWZuIXx6jhl9y1RdOGg==
X-Received: by 2002:adf:f683:: with SMTP id v3mr30998357wrp.423.1632159947403;
        Mon, 20 Sep 2021 10:45:47 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 25sm240476wmo.9.2021.09.20.10.45.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 10:45:47 -0700 (PDT)
Message-Id: <63a9cd80ade83d0307374f46516782ee6a89dd30.1632159937.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1018.v3.git.1632159937.gitgitgadget@gmail.com>
References: <pull.1018.v2.git.1631453010.gitgitgadget@gmail.com>
        <pull.1018.v3.git.1632159937.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 20 Sep 2021 17:45:36 +0000
Subject: [PATCH v3 13/14] mv: refuse to move sparse paths
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

Since cmd_mv() does not operate on cache entries and instead directly
checks the filesystem, we can only use path_in_sparse_checkout() as a
mechanism for seeing if a path is sparse or not. Be sure to skip
returning a failure if '-k' is specified.

To ensure that the advice around sparse paths is the only reason a move
failed, be sure to check this as the very last thing before inserting
into the src_for_dst list.

The tests cover a variety of cases such as whether the target is tracked
or untracked, and whether the source or destination are in or outside of
the sparse-checkout definition.

Helped-by: Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/mv.c                  |  52 ++++++++--
 t/t7002-mv-sparse-checkout.sh | 186 ++++++++++++++++++++++++++++++++++
 2 files changed, 229 insertions(+), 9 deletions(-)
 create mode 100755 t/t7002-mv-sparse-checkout.sh

diff --git a/builtin/mv.c b/builtin/mv.c
index c2f96c8e895..83a465ba831 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -118,21 +118,23 @@ static int index_range_of_same_dir(const char *src, int length,
 int cmd_mv(int argc, const char **argv, const char *prefix)
 {
 	int i, flags, gitmodules_modified = 0;
-	int verbose = 0, show_only = 0, force = 0, ignore_errors = 0;
+	int verbose = 0, show_only = 0, force = 0, ignore_errors = 0, ignore_sparse = 0;
 	struct option builtin_mv_options[] = {
 		OPT__VERBOSE(&verbose, N_("be verbose")),
 		OPT__DRY_RUN(&show_only, N_("dry run")),
 		OPT__FORCE(&force, N_("force move/rename even if target exists"),
 			   PARSE_OPT_NOCOMPLETE),
 		OPT_BOOL('k', NULL, &ignore_errors, N_("skip move/rename errors")),
+		OPT_BOOL(0, "sparse", &ignore_sparse, N_("allow updating entries outside of the sparse-checkout cone")),
 		OPT_END(),
 	};
 	const char **source, **destination, **dest_path, **submodule_gitfile;
-	enum update_mode { BOTH = 0, WORKING_DIRECTORY, INDEX } *modes;
+	enum update_mode { BOTH = 0, WORKING_DIRECTORY, INDEX, SPARSE } *modes;
 	struct stat st;
 	struct string_list src_for_dst = STRING_LIST_INIT_NODUP;
 	struct lock_file lock_file = LOCK_INIT;
 	struct cache_entry *ce;
+	struct string_list only_match_skip_worktree = STRING_LIST_INIT_NODUP;
 
 	git_config(git_default_config, NULL);
 
@@ -176,14 +178,17 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 		const char *src = source[i], *dst = destination[i];
 		int length, src_is_dir;
 		const char *bad = NULL;
+		int skip_sparse = 0;
 
 		if (show_only)
 			printf(_("Checking rename of '%s' to '%s'\n"), src, dst);
 
 		length = strlen(src);
-		if (lstat(src, &st) < 0)
-			bad = _("bad source");
-		else if (!strncmp(src, dst, length) &&
+		if (lstat(src, &st) < 0) {
+			/* only error if existence is expected. */
+			if (modes[i] != SPARSE)
+				bad = _("bad source");
+		} else if (!strncmp(src, dst, length) &&
 				(dst[length] == 0 || dst[length] == '/')) {
 			bad = _("can not move directory into itself");
 		} else if ((src_is_dir = S_ISDIR(st.st_mode))
@@ -212,11 +217,12 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 				dst_len = strlen(dst);
 
 				for (j = 0; j < last - first; j++) {
-					const char *path = active_cache[first + j]->name;
+					const struct cache_entry *ce = active_cache[first + j];
+					const char *path = ce->name;
 					source[argc + j] = path;
 					destination[argc + j] =
 						prefix_path(dst, dst_len, path + length + 1);
-					modes[argc + j] = INDEX;
+					modes[argc + j] = ce_skip_worktree(ce) ? SPARSE : INDEX;
 					submodule_gitfile[argc + j] = NULL;
 				}
 				argc += last - first;
@@ -244,14 +250,36 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 			bad = _("multiple sources for the same target");
 		else if (is_dir_sep(dst[strlen(dst) - 1]))
 			bad = _("destination directory does not exist");
-		else
+		else {
+			/*
+			 * We check if the paths are in the sparse-checkout
+			 * definition as a very final check, since that
+			 * allows us to point the user to the --sparse
+			 * option as a way to have a successful run.
+			 */
+			if (!ignore_sparse &&
+			    !path_in_sparse_checkout(src, &the_index)) {
+				string_list_append(&only_match_skip_worktree, src);
+				skip_sparse = 1;
+			}
+			if (!ignore_sparse &&
+			    !path_in_sparse_checkout(dst, &the_index)) {
+				string_list_append(&only_match_skip_worktree, dst);
+				skip_sparse = 1;
+			}
+
+			if (skip_sparse)
+				goto remove_entry;
+
 			string_list_insert(&src_for_dst, dst);
+		}
 
 		if (!bad)
 			continue;
 		if (!ignore_errors)
 			die(_("%s, source=%s, destination=%s"),
 			     bad, src, dst);
+remove_entry:
 		if (--argc > 0) {
 			int n = argc - i;
 			memmove(source + i, source + i + 1,
@@ -266,6 +294,12 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 		}
 	}
 
+	if (only_match_skip_worktree.nr) {
+		advise_on_updating_sparse_paths(&only_match_skip_worktree);
+		if (!ignore_errors)
+			return 1;
+	}
+
 	for (i = 0; i < argc; i++) {
 		const char *src = source[i], *dst = destination[i];
 		enum update_mode mode = modes[i];
@@ -274,7 +308,7 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 			printf(_("Renaming %s to %s\n"), src, dst);
 		if (show_only)
 			continue;
-		if (mode != INDEX && rename(src, dst) < 0) {
+		if (mode != INDEX && mode != SPARSE && rename(src, dst) < 0) {
 			if (ignore_errors)
 				continue;
 			die_errno(_("renaming '%s' failed"), src);
diff --git a/t/t7002-mv-sparse-checkout.sh b/t/t7002-mv-sparse-checkout.sh
new file mode 100755
index 00000000000..07dbfeb6d17
--- /dev/null
+++ b/t/t7002-mv-sparse-checkout.sh
@@ -0,0 +1,186 @@
+#!/bin/sh
+
+test_description='git mv in sparse working trees'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' "
+	mkdir -p sub/dir sub/dir2 &&
+	touch a b c sub/d sub/dir/e sub/dir2/e &&
+	git add -A &&
+	git commit -m files &&
+
+	cat >sparse_error_header <<-EOF &&
+	The following pathspecs didn't match any eligible path, but they do match index
+	entries outside the current sparse checkout:
+	EOF
+
+	cat >sparse_hint <<-EOF
+	hint: Disable or modify the sparsity rules if you intend to update such entries.
+	hint: Disable this message with \"git config advice.updateSparsePath false\"
+	EOF
+"
+
+test_expect_success 'mv refuses to move sparse-to-sparse' '
+	test_when_finished rm -f e &&
+	git reset --hard &&
+	git sparse-checkout set a &&
+	touch b &&
+	test_must_fail git mv b e 2>stderr &&
+	cat sparse_error_header >expect &&
+	echo b >>expect &&
+	echo e >>expect &&
+	cat sparse_hint >>expect &&
+	test_cmp expect stderr &&
+	git mv --sparse b e 2>stderr &&
+	test_must_be_empty stderr
+'
+
+test_expect_success 'mv refuses to move sparse-to-sparse, ignores failure' '
+	test_when_finished rm -f b c e &&
+	git reset --hard &&
+	git sparse-checkout set a &&
+
+	# tracked-to-untracked
+	touch b &&
+	git mv -k b e 2>stderr &&
+	test_path_exists b &&
+	test_path_is_missing e &&
+	cat sparse_error_header >expect &&
+	echo b >>expect &&
+	echo e >>expect &&
+	cat sparse_hint >>expect &&
+	test_cmp expect stderr &&
+
+	git mv --sparse b e 2>stderr &&
+	test_must_be_empty stderr &&
+	test_path_is_missing b &&
+	test_path_exists e &&
+
+	# tracked-to-tracked
+	git reset --hard &&
+	touch b &&
+	git mv -k b c 2>stderr &&
+	test_path_exists b &&
+	test_path_is_missing c &&
+	cat sparse_error_header >expect &&
+	echo b >>expect &&
+	echo c >>expect &&
+	cat sparse_hint >>expect &&
+	test_cmp expect stderr &&
+
+	git mv --sparse b c 2>stderr &&
+	test_must_be_empty stderr &&
+	test_path_is_missing b &&
+	test_path_exists c
+'
+
+test_expect_success 'mv refuses to move non-sparse-to-sparse' '
+	test_when_finished rm -f b c e &&
+	git reset --hard &&
+	git sparse-checkout set a &&
+
+	# tracked-to-untracked
+	test_must_fail git mv a e 2>stderr &&
+	test_path_exists a &&
+	test_path_is_missing e &&
+	cat sparse_error_header >expect &&
+	echo e >>expect &&
+	cat sparse_hint >>expect &&
+	test_cmp expect stderr &&
+	git mv --sparse a e 2>stderr &&
+	test_must_be_empty stderr &&
+	test_path_is_missing a &&
+	test_path_exists e &&
+
+	# tracked-to-tracked
+	rm e &&
+	git reset --hard &&
+	test_must_fail git mv a c 2>stderr &&
+	test_path_exists a &&
+	test_path_is_missing c &&
+	cat sparse_error_header >expect &&
+	echo c >>expect &&
+	cat sparse_hint >>expect &&
+	test_cmp expect stderr &&
+	git mv --sparse a c 2>stderr &&
+	test_must_be_empty stderr &&
+	test_path_is_missing a &&
+	test_path_exists c
+'
+
+test_expect_success 'mv refuses to move sparse-to-non-sparse' '
+	test_when_finished rm -f b c e &&
+	git reset --hard &&
+	git sparse-checkout set a e &&
+
+	# tracked-to-untracked
+	touch b &&
+	test_must_fail git mv b e 2>stderr &&
+	cat sparse_error_header >expect &&
+	echo b >>expect &&
+	cat sparse_hint >>expect &&
+	test_cmp expect stderr &&
+	git mv --sparse b e 2>stderr &&
+	test_must_be_empty stderr
+'
+
+test_expect_success 'recursive mv refuses to move (possible) sparse' '
+	test_when_finished rm -rf b c e sub2 &&
+	git reset --hard &&
+	# Without cone mode, "sub" and "sub2" do not match
+	git sparse-checkout set sub/dir sub2/dir &&
+
+	# Add contained contents to ensure we avoid non-existence errors
+	mkdir sub/dir2 &&
+	touch sub/d sub/dir2/e &&
+
+	test_must_fail git mv sub sub2 2>stderr &&
+	cat sparse_error_header >expect &&
+	cat >>expect <<-\EOF &&
+	sub/d
+	sub2/d
+	sub/dir/e
+	sub2/dir/e
+	sub/dir2/e
+	sub2/dir2/e
+	EOF
+	cat sparse_hint >>expect &&
+	test_cmp expect stderr &&
+	git mv --sparse sub sub2 2>stderr &&
+	test_must_be_empty stderr &&
+	git commit -m "moved sub to sub2" &&
+	git rev-parse HEAD~1:sub >expect &&
+	git rev-parse HEAD:sub2 >actual &&
+	test_cmp expect actual &&
+	git reset --hard HEAD~1
+'
+
+test_expect_success 'recursive mv refuses to move sparse' '
+	git reset --hard &&
+	# Use cone mode so "sub/" matches the sparse-checkout patterns
+	git sparse-checkout init --cone &&
+	git sparse-checkout set sub/dir sub2/dir &&
+
+	# Add contained contents to ensure we avoid non-existence errors
+	mkdir sub/dir2 &&
+	touch sub/dir2/e &&
+
+	test_must_fail git mv sub sub2 2>stderr &&
+	cat sparse_error_header >expect &&
+	cat >>expect <<-\EOF &&
+	sub/dir2/e
+	sub2/dir2/e
+	EOF
+	cat sparse_hint >>expect &&
+	test_cmp expect stderr &&
+	git mv --sparse sub sub2 2>stderr &&
+	test_must_be_empty stderr &&
+	git commit -m "moved sub to sub2" &&
+	git rev-parse HEAD~1:sub >expect &&
+	git rev-parse HEAD:sub2 >actual &&
+	test_cmp expect actual &&
+	git reset --hard HEAD~1
+'
+
+test_done
-- 
gitgitgadget

