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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDFECC433E9
	for <git@archiver.kernel.org>; Mon, 15 Mar 2021 23:45:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F31764F5F
	for <git@archiver.kernel.org>; Mon, 15 Mar 2021 23:45:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233851AbhCOXol (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Mar 2021 19:44:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232667AbhCOXoH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Mar 2021 19:44:07 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91FF1C06174A
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 16:44:06 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id t9so6540118wrn.11
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 16:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RMjpsxsdFrtzWHGdZw4TLFazfML8SVjM+Ogw6juZ6uw=;
        b=YhxHowqLfLJoTKt6oF7zfyHldXVR4dV+DMlyKREzHD4+zpfx5dKgw6uQh27eKB3fV3
         IcIwug9irQTJXUAefvSDm3lqszSvL5O52MgRfjIs0IY1XAv83grzryq31cLf3Pyt/bet
         gITEz/ZM13fP+3J/xDbG2j1NKbiAOQZ533vMSbA+tyByrSO0r9EXpxx83YAZCNzAYzvD
         9YU1uy+uQDb05TCMdvkhOpE/FH2TEQUywHbHLNL010OldHxqEtTlQtxKI8fyBOSyfG8l
         Lci1x0DO3J2h164x3mt5/f0eIYloRoCfbelvaEo08hw+QtktpCVcNT4o7RwX7t2YUizK
         KqrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RMjpsxsdFrtzWHGdZw4TLFazfML8SVjM+Ogw6juZ6uw=;
        b=ZMzs8wMaRqJO9fjEa6y7EfYW3WeuFW7sQuY+rr4RIpIVZgNst0E26HDYp0rgFNB4k8
         BAaWTkjW0WDhofGIjRaaE9dA3LkqFBWW37iiYbKMOBA4nbRUtbvEb4pyN4VkcyR1LmhY
         yiD3bns/e1q6Ij+gi55tIz5IK4De87V6aacr/vMF5xmjWPTWzZilvHIujVH5mhpNVnAO
         pbQS9kKVP6IxSFKZjgeAnUeKL8x8iamkZZRm8ErZKA5WEk+XWBQG7us8smqNOwOwA7Pg
         3w9CpHMbakaDLxbAgsNhXBy8EExdmP6ijPnOVfNUBoeOIvfy9GBLjWubenX7KKesT3O7
         wlNQ==
X-Gm-Message-State: AOAM5330Nu+L3sK2qTwpa4mqSse/vv2Y10a65laFdP9rVqGFKxfbzGrr
        mtwMRTrWL9jet7oUFfUEy+taQO19C3t0Jg==
X-Google-Smtp-Source: ABdhPJzjZQPhR+tcy+JsRZ0FFnl94R7ZqjMGVVZ2VIKJCauIL82qLKhO20kRIAqQkN73DQM9NAi5ww==
X-Received: by 2002:a5d:400f:: with SMTP id n15mr1837553wrp.89.1615851845010;
        Mon, 15 Mar 2021 16:44:05 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id z7sm20417268wrt.70.2021.03.15.16.44.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 16:44:04 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 6/9] tree.h API: remove "stage" parameter from read_tree_recursive()
Date:   Tue, 16 Mar 2021 00:43:41 +0100
Message-Id: <20210315234344.28427-7-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.rc2.211.g1d0b8788b3
In-Reply-To: <20210308022138.28166-1-avarab@gmail.com>
References: <20210308022138.28166-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The read_tree_recursive() function took a "stage" parameter that is
passed through as-is. As it turns out nothing used this parameter in a
way that they couldn't just move to the callback function they
defined, so let's get rid of it.

If anyone needs to pass such information in the future they can use
the "void *context" parameter.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 archive.c          |  9 +++++----
 builtin/checkout.c |  4 ++--
 builtin/log.c      |  4 ++--
 builtin/ls-files.c | 14 +++++++-------
 builtin/ls-tree.c  |  4 ++--
 merge-recursive.c  |  4 ++--
 tree.c             | 10 +++++-----
 tree.h             |  4 ++--
 8 files changed, 27 insertions(+), 26 deletions(-)

diff --git a/archive.c b/archive.c
index 9394f170f7f..6669a4bd147 100644
--- a/archive.c
+++ b/archive.c
@@ -231,9 +231,10 @@ static int write_directory(struct archiver_context *c)
 
 static int queue_or_write_archive_entry(const struct object_id *oid,
 		struct strbuf *base, const char *filename,
-		unsigned mode, int stage, void *context)
+		unsigned mode, void *context)
 {
 	struct archiver_context *c = context;
+	int stage = 0;
 
 	while (c->bottom &&
 	       !(base->len >= c->bottom->len &&
@@ -317,7 +318,7 @@ int write_archive_entries(struct archiver_args *args,
 	}
 
 	err = read_tree_recursive(args->repo, args->tree,
-				  0, &args->pathspec,
+				  &args->pathspec,
 				  queue_or_write_archive_entry,
 				  &context);
 	if (err == READ_TREE_RECURSIVE)
@@ -378,7 +379,7 @@ struct path_exists_context {
 
 static int reject_entry(const struct object_id *oid, struct strbuf *base,
 			const char *filename, unsigned mode,
-			int stage, void *context)
+			void *context)
 {
 	int ret = -1;
 	struct path_exists_context *ctx = context;
@@ -406,7 +407,7 @@ static int path_exists(struct archiver_args *args, const char *path)
 	parse_pathspec(&ctx.pathspec, 0, 0, "", paths);
 	ctx.pathspec.recursive = 1;
 	ret = read_tree_recursive(args->repo, args->tree,
-				  0, &ctx.pathspec,
+				  &ctx.pathspec,
 				  reject_entry, &ctx);
 	clear_pathspec(&ctx.pathspec);
 	return ret != 0;
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 21b742c0f07..2c2d58a230f 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -114,7 +114,7 @@ static int post_checkout_hook(struct commit *old_commit, struct commit *new_comm
 }
 
 static int update_some(const struct object_id *oid, struct strbuf *base,
-		const char *pathname, unsigned mode, int stage, void *context)
+		const char *pathname, unsigned mode, void *context)
 {
 	int len;
 	struct cache_entry *ce;
@@ -155,7 +155,7 @@ static int update_some(const struct object_id *oid, struct strbuf *base,
 
 static int read_tree_some(struct tree *tree, const struct pathspec *pathspec)
 {
-	read_tree_recursive(the_repository, tree, 0,
+	read_tree_recursive(the_repository, tree,
 			    pathspec, update_some, NULL);
 
 	/* update the index with the given tree's info
diff --git a/builtin/log.c b/builtin/log.c
index ffa3fb8c286..58acb2b76ab 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -599,7 +599,7 @@ static int show_tag_object(const struct object_id *oid, struct rev_info *rev)
 
 static int show_tree_object(const struct object_id *oid,
 		struct strbuf *base,
-		const char *pathname, unsigned mode, int stage, void *context)
+		const char *pathname, unsigned mode, void *context)
 {
 	FILE *file = context;
 	fprintf(file, "%s%s\n", pathname, S_ISDIR(mode) ? "/" : "");
@@ -682,7 +682,7 @@ int cmd_show(int argc, const char **argv, const char *prefix)
 					name,
 					diff_get_color_opt(&rev.diffopt, DIFF_RESET));
 			read_tree_recursive(the_repository, (struct tree *)o,
-					    0, &match_all, show_tree_object,
+					    &match_all, show_tree_object,
 					    rev.diffopt.file);
 			rev.shown_one = 1;
 			break;
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index cd432ac03cd..fa9b01b6cc7 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -425,7 +425,7 @@ static int read_one_entry_opt(struct index_state *istate,
 			      const struct object_id *oid,
 			      struct strbuf *base,
 			      const char *pathname,
-			      unsigned mode, int stage, int opt)
+			      unsigned mode, int opt)
 {
 	int len;
 	struct cache_entry *ce;
@@ -437,7 +437,7 @@ static int read_one_entry_opt(struct index_state *istate,
 	ce = make_empty_cache_entry(istate, base->len + len);
 
 	ce->ce_mode = create_ce_mode(mode);
-	ce->ce_flags = create_ce_flags(stage);
+	ce->ce_flags = create_ce_flags(1);
 	ce->ce_namelen = base->len + len;
 	memcpy(ce->name, base->buf, base->len);
 	memcpy(ce->name + base->len, pathname, len+1);
@@ -446,12 +446,12 @@ static int read_one_entry_opt(struct index_state *istate,
 }
 
 static int read_one_entry(const struct object_id *oid, struct strbuf *base,
-			  const char *pathname, unsigned mode, int stage,
+			  const char *pathname, unsigned mode,
 			  void *context)
 {
 	struct index_state *istate = context;
 	return read_one_entry_opt(istate, oid, base, pathname,
-				  mode, stage,
+				  mode,
 				  ADD_CACHE_OK_TO_ADD|ADD_CACHE_SKIP_DFCHECK);
 }
 
@@ -460,12 +460,12 @@ static int read_one_entry(const struct object_id *oid, struct strbuf *base,
  * the stage that will conflict with the entry being added.
  */
 static int read_one_entry_quick(const struct object_id *oid, struct strbuf *base,
-				const char *pathname, unsigned mode, int stage,
+				const char *pathname, unsigned mode,
 				void *context)
 {
 	struct index_state *istate = context;
 	return read_one_entry_opt(istate, oid, base, pathname,
-				  mode, stage,
+				  mode,
 				  ADD_CACHE_JUST_APPEND);
 }
 
@@ -523,7 +523,7 @@ void overlay_tree_on_index(struct index_state *istate,
 
 	if (!fn)
 		fn = read_one_entry_quick;
-	err = read_tree_recursive(the_repository, tree, 1, &pathspec, fn, istate);
+	err = read_tree_recursive(the_repository, tree, &pathspec, fn, istate);
 	if (err)
 		die("unable to read tree entries %s", tree_name);
 
diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index 7d3fb2e6d0f..dbb31217beb 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -62,7 +62,7 @@ static int show_recursive(const char *base, int baselen, const char *pathname)
 }
 
 static int show_tree(const struct object_id *oid, struct strbuf *base,
-		const char *pathname, unsigned mode, int stage, void *context)
+		const char *pathname, unsigned mode, void *context)
 {
 	int retval = 0;
 	int baselen;
@@ -185,6 +185,6 @@ int cmd_ls_tree(int argc, const char **argv, const char *prefix)
 	tree = parse_tree_indirect(&oid);
 	if (!tree)
 		die("not a tree object");
-	return !!read_tree_recursive(the_repository, tree, 0,
+	return !!read_tree_recursive(the_repository, tree,
 				     &pathspec, show_tree, NULL);
 }
diff --git a/merge-recursive.c b/merge-recursive.c
index fa7602ff0f2..1593f374495 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -453,7 +453,7 @@ static void unpack_trees_finish(struct merge_options *opt)
 
 static int save_files_dirs(const struct object_id *oid,
 			   struct strbuf *base, const char *path,
-			   unsigned int mode, int stage, void *context)
+			   unsigned int mode, void *context)
 {
 	struct path_hashmap_entry *entry;
 	int baselen = base->len;
@@ -473,7 +473,7 @@ static void get_files_dirs(struct merge_options *opt, struct tree *tree)
 {
 	struct pathspec match_all;
 	memset(&match_all, 0, sizeof(match_all));
-	read_tree_recursive(opt->repo, tree, 0,
+	read_tree_recursive(opt->repo, tree,
 			    &match_all, save_files_dirs, opt);
 }
 
diff --git a/tree.c b/tree.c
index 04eb11aed31..fb4985f22ca 100644
--- a/tree.c
+++ b/tree.c
@@ -13,7 +13,7 @@ const char *tree_type = "tree";
 
 static int read_tree_1(struct repository *r,
 		       struct tree *tree, struct strbuf *base,
-		       int stage, const struct pathspec *pathspec,
+		       const struct pathspec *pathspec,
 		       read_tree_fn_t fn, void *context)
 {
 	struct tree_desc desc;
@@ -38,7 +38,7 @@ static int read_tree_1(struct repository *r,
 		}
 
 		switch (fn(&entry.oid, base,
-			   entry.path, entry.mode, stage, context)) {
+			   entry.path, entry.mode, context)) {
 		case 0:
 			continue;
 		case READ_TREE_RECURSIVE:
@@ -72,7 +72,7 @@ static int read_tree_1(struct repository *r,
 		strbuf_add(base, entry.path, len);
 		strbuf_addch(base, '/');
 		retval = read_tree_1(r, lookup_tree(r, &oid),
-				     base, stage, pathspec,
+				     base, pathspec,
 				     fn, context);
 		strbuf_setlen(base, oldlen);
 		if (retval)
@@ -83,13 +83,13 @@ static int read_tree_1(struct repository *r,
 
 int read_tree_recursive(struct repository *r,
 			struct tree *tree,
-			int stage, const struct pathspec *pathspec,
+			const struct pathspec *pathspec,
 			read_tree_fn_t fn, void *context)
 {
 	struct strbuf sb = STRBUF_INIT;
 	int ret;
 
-	ret = read_tree_1(r, tree, &sb, stage, pathspec, fn, context);
+	ret = read_tree_1(r, tree, &sb, pathspec, fn, context);
 	strbuf_release(&sb);
 	return ret;
 }
diff --git a/tree.h b/tree.h
index 5252b5139dd..1309ab997e5 100644
--- a/tree.h
+++ b/tree.h
@@ -31,10 +31,10 @@ struct tree *parse_tree_indirect(const struct object_id *oid);
 int cmp_cache_name_compare(const void *a_, const void *b_);
 
 #define READ_TREE_RECURSIVE 1
-typedef int (*read_tree_fn_t)(const struct object_id *, struct strbuf *, const char *, unsigned int, int, void *);
+typedef int (*read_tree_fn_t)(const struct object_id *, struct strbuf *, const char *, unsigned int, void *);
 
 int read_tree_recursive(struct repository *r,
 			struct tree *tree,
-			int stage, const struct pathspec *pathspec,
+			const struct pathspec *pathspec,
 			read_tree_fn_t fn, void *context);
 #endif /* TREE_H */
-- 
2.31.0.rc2.211.g1d0b8788b3

