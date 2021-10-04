Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EC39C43217
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 00:46:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40C4A6103B
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 00:46:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232014AbhJDAsN (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 3 Oct 2021 20:48:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231967AbhJDAsH (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Oct 2021 20:48:07 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81761C0613EC
        for <git@vger.kernel.org>; Sun,  3 Oct 2021 17:46:19 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id v17so27482955wrv.9
        for <git@vger.kernel.org>; Sun, 03 Oct 2021 17:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mAwWdLQI94A6oAvvZU0Xn0wBJFWa2z7IYqmzNSG/X6o=;
        b=kYEqYsG9tG32HwQ6BK4PjBIH3dhsP1We2bNEi9Ktmyh5BoRhvONzbJDbSa8PjsnqVa
         Mc+aWugJD1DxAX/3TlFOvf7b29oP/7sjbLqUm9sEOdgUnxZuAC1JGkALzlg9IJ5Iujaz
         lm3cy/61oX+LIcyI7R9whjuaSl+vFmzI9tU1u9UkazlHkD84+TdIyWTKyBSDudwJqig8
         FH2uYu3FIb4ZdtSU1S9ZHU3JD6wP0FomIuTlglTLxlpCvIYTuPaYePp6IBIOCSeYMhWL
         JOA4WXP7GnLSwowor0zzf8zt5nrQHOqUtTFHw7HiNI8pHGG1rBlfTssrmHO3kGwUEQqS
         FC2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mAwWdLQI94A6oAvvZU0Xn0wBJFWa2z7IYqmzNSG/X6o=;
        b=FNI8mx6Xqx9q77KjD+jvju1G8eumK7pT/5on6n762GebvN2U4bDt+Sqlfg5G00/xUz
         T2HXj3hfgM0PrQMOUI56y+5lmHxgWmBdqkHVgo0kMyPZRKLIEQnzj0dyeYlKdNvdQOJr
         qi99LMAeggmVklpfze8sCkjg9cZGul3lPJGKZABuf439pC6Ngpy0lvwM61/4vOg9nseI
         yCcN7vGq5k06RFXMsVRBhcOuLmSoC8UQkX+C2CCD6Wlkkf4sC5/khrVbxjs623sGgSv9
         cKzMppn9REeY9BuF47RkvfN/ZKaNdhUsT7iP8SlHd+N9QuLX9FwpJf54mkDRVAh3QEZJ
         3s1g==
X-Gm-Message-State: AOAM531N7o7YDeZLn/dIH9Gvq5wvznx+LgEJUFDr+ISFRvn2XQ/NWvcw
        ETRpN4LXK0/Zw2PRs3sZJos4DWGyimFBcQ==
X-Google-Smtp-Source: ABdhPJxefHDyJSui1WEtmpirLMy/UIWi+C8xX8f747HgsNiZPVy01kpevglmRpQ978NLjsU23A/3HQ==
X-Received: by 2002:adf:a2c8:: with SMTP id t8mr11092429wra.215.1633308377812;
        Sun, 03 Oct 2021 17:46:17 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q7sm13526773wrc.55.2021.10.03.17.46.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Oct 2021 17:46:17 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Andrzej Hunt <ajrhunt@google.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 03/10] unpack-trees.[ch]: embed "dir" in "struct unpack_trees_options"
Date:   Mon,  4 Oct 2021 02:46:04 +0200
Message-Id: <patch-03.10-aaad6fce194-20211004T002226Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1404.g83021034c5d
In-Reply-To: <cover-00.10-00000000000-20211004T002226Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20211004T002226Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the "struct dir" in "struct unpack_trees_options" away from a
pointer to being embedded in the struct itself, this mean that we can
initialize it with our new UNPACK_TREES_OPTIONS_INIT macro.

As it turned out nothing actually needed to provide its own "struct
dir" to this API, there's another patch to "hide" the struct instead,
see the discussion at [1], but I think just allocating it on the stack
along with the rest makes more sense.

This fixes a memory leak in "builtin/checkout.c" that's been there
since the clear_unpack_trees_porcelain() function was added in
1c41d2805e4 (unpack_trees_options: free messages when done,
2018-05-21), i.e. we still had a memory leak from allocating the "dir"
member here. That "dir" member had in turn been with us ever since
782c2d65c24 (Build in checkout, 2008-02-07).

This fixes that memory leak, and allows us to remove the boilerplate
dir_clear() elsewhere in favor of just using
clear_unpack_trees_porcelain().

1. https://lore.kernel.org/git/87ilyjviiy.fsf@evledraar.gmail.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/checkout.c  |  5 ++---
 builtin/read-tree.c | 11 ++++-------
 merge-ort.c         |  7 ++-----
 merge.c             |  7 ++-----
 unpack-trees.c      | 10 ++++------
 unpack-trees.h      |  4 +++-
 6 files changed, 17 insertions(+), 27 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index fea4533dbec..d4b88affba7 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -745,9 +745,8 @@ static int merge_working_tree(const struct checkout_opts *opts,
 				       &new_branch_info->commit->object.oid :
 				       &new_branch_info->oid, NULL);
 		if (opts->overwrite_ignore) {
-			topts.dir = xcalloc(1, sizeof(*topts.dir));
-			topts.dir->flags |= DIR_SHOW_IGNORED;
-			setup_standard_excludes(topts.dir);
+			topts.dir.flags |= DIR_SHOW_IGNORED;
+			setup_standard_excludes(&topts.dir);
 		}
 		tree = parse_tree_indirect(old_branch_info->commit ?
 					   &old_branch_info->commit->object.oid :
diff --git a/builtin/read-tree.c b/builtin/read-tree.c
index 847182fdad6..06f3b97ac05 100644
--- a/builtin/read-tree.c
+++ b/builtin/read-tree.c
@@ -53,20 +53,17 @@ static int index_output_cb(const struct option *opt, const char *arg,
 static int exclude_per_directory_cb(const struct option *opt, const char *arg,
 				    int unset)
 {
-	struct dir_struct *dir;
 	struct unpack_trees_options *opts;
 
 	BUG_ON_OPT_NEG(unset);
 
 	opts = (struct unpack_trees_options *)opt->value;
 
-	if (opts->dir)
+	if (opts->dir.exclude_per_dir)
 		die("more than one --exclude-per-directory given.");
 
-	dir = xcalloc(1, sizeof(*opts->dir));
-	dir->flags |= DIR_SHOW_IGNORED;
-	dir->exclude_per_dir = arg;
-	opts->dir = dir;
+	opts->dir.flags |= DIR_SHOW_IGNORED;
+	opts->dir.exclude_per_dir = arg;
 	/* We do not need to nor want to do read-directory
 	 * here; we are merely interested in reusing the
 	 * per directory ignore stack mechanism.
@@ -208,7 +205,7 @@ int cmd_read_tree(int argc, const char **argv, const char *cmd_prefix)
 	if ((opts.update || opts.index_only) && !opts.merge)
 		die("%s is meaningless without -m, --reset, or --prefix",
 		    opts.update ? "-u" : "-i");
-	if ((opts.dir && !opts.update))
+	if ((opts.dir.exclude_per_dir && !opts.update))
 		die("--exclude-per-directory is meaningless unless -u");
 	if (opts.merge && !opts.index_only)
 		setup_work_tree();
diff --git a/merge-ort.c b/merge-ort.c
index 75d2b8e4b99..e526b78b88d 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -4045,9 +4045,8 @@ static int checkout(struct merge_options *opt,
 	unpack_opts.verbose_update = (opt->verbosity > 2);
 	unpack_opts.fn = twoway_merge;
 	if (1/* FIXME: opts->overwrite_ignore*/) {
-		CALLOC_ARRAY(unpack_opts.dir, 1);
-		unpack_opts.dir->flags |= DIR_SHOW_IGNORED;
-		setup_standard_excludes(unpack_opts.dir);
+		unpack_opts.dir.flags |= DIR_SHOW_IGNORED;
+		setup_standard_excludes(&unpack_opts.dir);
 	}
 	parse_tree(prev);
 	init_tree_desc(&trees[0], prev->buffer, prev->size);
@@ -4056,8 +4055,6 @@ static int checkout(struct merge_options *opt,
 
 	ret = unpack_trees(2, trees, &unpack_opts);
 	clear_unpack_trees_porcelain(&unpack_opts);
-	dir_clear(unpack_opts.dir);
-	FREE_AND_NULL(unpack_opts.dir);
 	return ret;
 }
 
diff --git a/merge.c b/merge.c
index 086f04b0f97..9cb32990dd9 100644
--- a/merge.c
+++ b/merge.c
@@ -53,7 +53,6 @@ int checkout_fast_forward(struct repository *r,
 	struct unpack_trees_options opts = UNPACK_TREES_OPTIONS_INIT;
 	struct tree_desc t[MAX_UNPACK_TREES];
 	int i, nr_trees = 0;
-	struct dir_struct dir = DIR_INIT;
 	struct lock_file lock_file = LOCK_INIT;
 
 	refresh_index(r->index, REFRESH_QUIET, NULL, NULL, NULL);
@@ -80,9 +79,8 @@ int checkout_fast_forward(struct repository *r,
 	}
 
 	if (overwrite_ignore) {
-		dir.flags |= DIR_SHOW_IGNORED;
-		setup_standard_excludes(&dir);
-		opts.dir = &dir;
+		opts.dir.flags |= DIR_SHOW_IGNORED;
+		setup_standard_excludes(&opts.dir);
 	}
 
 	opts.head_idx = 1;
@@ -100,7 +98,6 @@ int checkout_fast_forward(struct repository *r,
 		clear_unpack_trees_porcelain(&opts);
 		return -1;
 	}
-	dir_clear(&dir);
 	clear_unpack_trees_porcelain(&opts);
 
 	if (write_locked_index(r->index, &lock_file, COMMIT_LOCK))
diff --git a/unpack-trees.c b/unpack-trees.c
index 393c1f35a5d..94767d3f96f 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -196,6 +196,7 @@ void unpack_trees_options_init(struct unpack_trees_options *o)
 void clear_unpack_trees_porcelain(struct unpack_trees_options *opts)
 {
 	strvec_clear(&opts->msgs_to_free);
+	dir_clear(&opts->dir);
 	memset(opts->msgs, 0, sizeof(opts->msgs));
 }
 
@@ -2085,7 +2086,7 @@ static int verify_clean_subdirectory(const struct cache_entry *ce,
 	 */
 	int namelen;
 	int i;
-	struct dir_struct d;
+	struct dir_struct d = DIR_INIT;
 	char *pathbuf;
 	int cnt = 0;
 
@@ -2136,9 +2137,7 @@ static int verify_clean_subdirectory(const struct cache_entry *ce,
 	 */
 	pathbuf = xstrfmt("%.*s/", namelen, ce->name);
 
-	memset(&d, 0, sizeof(d));
-	if (o->dir)
-		d.exclude_per_dir = o->dir->exclude_per_dir;
+	d.exclude_per_dir = o->dir.exclude_per_dir;
 	i = read_directory(&d, o->src_index, pathbuf, namelen+1, NULL);
 	if (i)
 		return add_rejected_path(o, ERROR_NOT_UPTODATE_DIR, ce->name);
@@ -2179,8 +2178,7 @@ static int check_ok_to_remove(const char *name, int len, int dtype,
 	if (ignore_case && icase_exists(o, name, len, st))
 		return 0;
 
-	if (o->dir &&
-	    is_excluded(o->dir, o->src_index, name, &dtype))
+	if (is_excluded(&o->dir, o->src_index, name, &dtype))
 		/*
 		 * ce->name is explicitly excluded, so it is Ok to
 		 * overwrite it.
diff --git a/unpack-trees.h b/unpack-trees.h
index 892b65ea623..40c4841748d 100644
--- a/unpack-trees.h
+++ b/unpack-trees.h
@@ -5,6 +5,7 @@
 #include "strvec.h"
 #include "string-list.h"
 #include "tree-walk.h"
+#include "dir.h"
 
 #define MAX_UNPACK_TREES MAX_TRAVERSE_TREES
 
@@ -66,7 +67,7 @@ struct unpack_trees_options {
 		     dry_run;
 	const char *prefix;
 	int cache_bottom;
-	struct dir_struct *dir;
+	struct dir_struct dir;
 	struct pathspec *pathspec;
 	merge_fn_t fn;
 	const char *msgs[NB_UNPACK_TREES_WARNING_TYPES];
@@ -93,6 +94,7 @@ struct unpack_trees_options {
 
 #define UNPACK_TREES_OPTIONS_INIT { \
 	.msgs_to_free = STRVEC_INIT, \
+	.dir = DIR_INIT, \
 }
 void unpack_trees_options_init(struct unpack_trees_options *o);
 
-- 
2.33.0.1404.g83021034c5d

