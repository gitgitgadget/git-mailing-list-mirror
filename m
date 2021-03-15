Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B418AC433DB
	for <git@archiver.kernel.org>; Mon, 15 Mar 2021 23:45:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EFE764E86
	for <git@archiver.kernel.org>; Mon, 15 Mar 2021 23:45:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233822AbhCOXol (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Mar 2021 19:44:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230455AbhCOXoH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Mar 2021 19:44:07 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 805DDC061756
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 16:44:07 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id e10so9548922wro.12
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 16:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=f4/lG/U2Vg0HkQMl303MSFHu3SZ9csC675lL67q7NtQ=;
        b=tjRqnKJLI66Nl84Vf+qfsi7EXWv7UsPNq7vaWOW/MzuyEz0R8ZVuLf+MPcY2IEfZux
         bZK2KRABrs3/Fvcnolla/fr9b4JCHrO1l1eRbP4Wcd2HxfY6KuhCTrhOYTeMwczTuUM1
         IEngQ0ktYpVD/AKMc0fVHxhJj1a8P5CDJzRieOWbp38M+fy/6nhUA7k981YkZ+xLHfNH
         jqJ45mDuJuNDKNdy0cAc1Hg7Gr1Sop30TUpqIzVJccJ/HYiRossil68qUe1rhEp9llYl
         73XaKMq39crtmcdGhaTKthAH+fOI4Gng2WdBKSi1mrkVMwmO52fRDRfi/rSEdowAeguc
         qByA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f4/lG/U2Vg0HkQMl303MSFHu3SZ9csC675lL67q7NtQ=;
        b=ku8wi/Gep0en/boQ9u1lXzrVT6ooeahh/u75atOWiOu5hEZ2uzFGyNY8ZFSh8+Wzbc
         j7c9ExQe2n+IWMPJyGwixfkBd9YIhGumn0QodStIPtCOVlxAlKnBkaneS480s3OTGQrk
         ABEnLaQxiAUa5l4pCmC6Ru8BGHzt0yecKurgr4Hqal64A5RX8UjD7aHtki17J2ygmS3c
         qZcMBWS/Kguc0B56W6u1BMeyPqfVO8SNohmz5zuQEdrJlE/f0EixWD1nX6sdL6yf4eMK
         K4BBkD4Oo0o8hjrUUybWBFar7yEQjxo4fYVaDSIkTk2HLAX6ch/752nr8HTBA5ZoBaMn
         Hlsg==
X-Gm-Message-State: AOAM532a9jdcOnQTmEIZC86ewn9k19mCHnBlp7/ezJl3lxr4F8vBMlvd
        TOITF3/F+olT8h15/0SXf1LMhrOyS2yung==
X-Google-Smtp-Source: ABdhPJwivjUA5iinAUb67FfwCHUpq4Xa+WYw9GqVin0E7EQcyUFC66NUxg9VI3hTf56s+YYlKnsm6w==
X-Received: by 2002:adf:f648:: with SMTP id x8mr1876742wrp.157.1615851845985;
        Mon, 15 Mar 2021 16:44:05 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id z7sm20417268wrt.70.2021.03.15.16.44.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 16:44:05 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 7/9] tree.h API: rename read_tree_recursive() to read_tree()
Date:   Tue, 16 Mar 2021 00:43:42 +0100
Message-Id: <20210315234344.28427-8-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.rc2.211.g1d0b8788b3
In-Reply-To: <20210308022138.28166-1-avarab@gmail.com>
References: <20210308022138.28166-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rename the read_tree_recursive() function to just read_tree(). We had
another read_tree() function that I've refactored away in preceding
steps, since all in-tree users read trees recursively with a callback
we can change the name to signify that this is the norm.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 archive.c          | 14 +++++++-------
 builtin/checkout.c |  6 +++---
 builtin/log.c      |  6 +++---
 builtin/ls-files.c |  2 +-
 builtin/ls-tree.c  |  4 ++--
 merge-recursive.c  |  4 ++--
 tree.c             |  8 ++++----
 tree.h             |  8 ++++----
 8 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/archive.c b/archive.c
index 6669a4bd147..c19300ecb9b 100644
--- a/archive.c
+++ b/archive.c
@@ -317,10 +317,10 @@ int write_archive_entries(struct archiver_args *args,
 		git_attr_set_direction(GIT_ATTR_INDEX);
 	}
 
-	err = read_tree_recursive(args->repo, args->tree,
-				  &args->pathspec,
-				  queue_or_write_archive_entry,
-				  &context);
+	err = read_tree(args->repo, args->tree,
+			&args->pathspec,
+			queue_or_write_archive_entry,
+			&context);
 	if (err == READ_TREE_RECURSIVE)
 		err = 0;
 	while (context.bottom) {
@@ -406,9 +406,9 @@ static int path_exists(struct archiver_args *args, const char *path)
 	ctx.args = args;
 	parse_pathspec(&ctx.pathspec, 0, 0, "", paths);
 	ctx.pathspec.recursive = 1;
-	ret = read_tree_recursive(args->repo, args->tree,
-				  &ctx.pathspec,
-				  reject_entry, &ctx);
+	ret = read_tree(args->repo, args->tree,
+			&ctx.pathspec,
+			reject_entry, &ctx);
 	clear_pathspec(&ctx.pathspec);
 	return ret != 0;
 }
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 2c2d58a230f..0e663905200 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -155,8 +155,8 @@ static int update_some(const struct object_id *oid, struct strbuf *base,
 
 static int read_tree_some(struct tree *tree, const struct pathspec *pathspec)
 {
-	read_tree_recursive(the_repository, tree,
-			    pathspec, update_some, NULL);
+	read_tree(the_repository, tree,
+		  pathspec, update_some, NULL);
 
 	/* update the index with the given tree's info
 	 * for all args, expanding wildcards, and exit
@@ -322,7 +322,7 @@ static void mark_ce_for_checkout_overlay(struct cache_entry *ce,
 	 * If it comes from the tree-ish, we already know it
 	 * matches the pathspec and could just stamp
 	 * CE_MATCHED to it from update_some(). But we still
-	 * need ps_matched and read_tree_recursive (and
+	 * need ps_matched and read_tree (and
 	 * eventually tree_entry_interesting) cannot fill
 	 * ps_matched yet. Once it can, we can avoid calling
 	 * match_pathspec() for _all_ entries when
diff --git a/builtin/log.c b/builtin/log.c
index 58acb2b76ab..980de590638 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -681,9 +681,9 @@ int cmd_show(int argc, const char **argv, const char *prefix)
 					diff_get_color_opt(&rev.diffopt, DIFF_COMMIT),
 					name,
 					diff_get_color_opt(&rev.diffopt, DIFF_RESET));
-			read_tree_recursive(the_repository, (struct tree *)o,
-					    &match_all, show_tree_object,
-					    rev.diffopt.file);
+			read_tree(the_repository, (struct tree *)o,
+				  &match_all, show_tree_object,
+				  rev.diffopt.file);
 			rev.shown_one = 1;
 			break;
 		case OBJ_COMMIT:
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index fa9b01b6cc7..13bcc2d8473 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -523,7 +523,7 @@ void overlay_tree_on_index(struct index_state *istate,
 
 	if (!fn)
 		fn = read_one_entry_quick;
-	err = read_tree_recursive(the_repository, tree, &pathspec, fn, istate);
+	err = read_tree(the_repository, tree, &pathspec, fn, istate);
 	if (err)
 		die("unable to read tree entries %s", tree_name);
 
diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index dbb31217beb..3a442631c71 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -185,6 +185,6 @@ int cmd_ls_tree(int argc, const char **argv, const char *prefix)
 	tree = parse_tree_indirect(&oid);
 	if (!tree)
 		die("not a tree object");
-	return !!read_tree_recursive(the_repository, tree,
-				     &pathspec, show_tree, NULL);
+	return !!read_tree(the_repository, tree,
+			   &pathspec, show_tree, NULL);
 }
diff --git a/merge-recursive.c b/merge-recursive.c
index 1593f374495..3d9207455b3 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -473,8 +473,8 @@ static void get_files_dirs(struct merge_options *opt, struct tree *tree)
 {
 	struct pathspec match_all;
 	memset(&match_all, 0, sizeof(match_all));
-	read_tree_recursive(opt->repo, tree,
-			    &match_all, save_files_dirs, opt);
+	read_tree(opt->repo, tree,
+		  &match_all, save_files_dirs, opt);
 }
 
 static int get_tree_entry_if_blob(struct repository *r,
diff --git a/tree.c b/tree.c
index fb4985f22ca..f6de250d7ff 100644
--- a/tree.c
+++ b/tree.c
@@ -81,10 +81,10 @@ static int read_tree_1(struct repository *r,
 	return 0;
 }
 
-int read_tree_recursive(struct repository *r,
-			struct tree *tree,
-			const struct pathspec *pathspec,
-			read_tree_fn_t fn, void *context)
+int read_tree(struct repository *r,
+	      struct tree *tree,
+	      const struct pathspec *pathspec,
+	      read_tree_fn_t fn, void *context)
 {
 	struct strbuf sb = STRBUF_INIT;
 	int ret;
diff --git a/tree.h b/tree.h
index 1309ab997e5..4fb713774a7 100644
--- a/tree.h
+++ b/tree.h
@@ -33,8 +33,8 @@ int cmp_cache_name_compare(const void *a_, const void *b_);
 #define READ_TREE_RECURSIVE 1
 typedef int (*read_tree_fn_t)(const struct object_id *, struct strbuf *, const char *, unsigned int, void *);
 
-int read_tree_recursive(struct repository *r,
-			struct tree *tree,
-			const struct pathspec *pathspec,
-			read_tree_fn_t fn, void *context);
+int read_tree(struct repository *r,
+	      struct tree *tree,
+	      const struct pathspec *pathspec,
+	      read_tree_fn_t fn, void *context);
 #endif /* TREE_H */
-- 
2.31.0.rc2.211.g1d0b8788b3

