Return-Path: <SRS0=iBdC=IG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 553C6C4332E
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 02:22:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37D1665155
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 02:22:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233409AbhCHCWT (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 7 Mar 2021 21:22:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233326AbhCHCWG (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Mar 2021 21:22:06 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B534C06175F
        for <git@vger.kernel.org>; Sun,  7 Mar 2021 18:22:06 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id r17so17144109ejy.13
        for <git@vger.kernel.org>; Sun, 07 Mar 2021 18:22:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Lfj2TXq9L9Kv1/VH/dZ2T7NJOdtNYTC/fGhzsjcpibc=;
        b=bBmxXS0loFW6jbArU5Oxb2puBXYa8javilon7QntcLjqqlMXFlz6ATAZFsA3r73VKT
         YB6q+z9YJY9xLsR5llxlkKlmjr+DF0yNYjdR/pQcDWVlQRczLtKIYCCmFyx8FEvuuGRg
         DwR/qDpKbe/I4hpSFvqytzo+eOs33UwBepfnqfOL0EhtyXOPe7syyJk43JQEEdbNr13m
         3tI4wpxxtGaZiyxR4aHdWfrRky18JTAswJXv9bgNR++yh6GkBrZpV0flJuJsN59rH8hO
         jOwkUIvqy40+eEH3mW7TEjTotI0uqZU+6w6cfeVk0i+69Gbqxqr69DaexT9Om14Do239
         QJcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Lfj2TXq9L9Kv1/VH/dZ2T7NJOdtNYTC/fGhzsjcpibc=;
        b=ljI5ga2qLDXSU/MtdQ3PVzJ88XNqXxidd/Gg+WX8RKldzXRFmWMi9MPk0XyO9phte1
         UYYHOxYVALsw9aJlBuIcH3xduFIZ/9FNmi3yKuB3mv0qkrgi0B9JftJhy3z6YqCcL1E8
         elKI6V+VVSxA/lJfwHghiuaMUMspxXv2mRTGVqIO11VWqCguNZdjF0hSgjozy860mM95
         S3au2AyosyfSYilft7qx8BNJ8MdFqqm+T/9kukoKXDYogWTjDgn4fd9kHtCVt9D+H9oi
         wPyIIMpZYYMOg8z63s7rIMd3SgMJsZyybnXIZuhod8rL+pAk/xApFAHRKv6FtPDubQbB
         U5Yg==
X-Gm-Message-State: AOAM533pYz+djF37ToPBmRKqKtD9oYzBs/6B34Y/1WBLhv/jtvfrtkV5
        3MoklOJ+pXJwyu3ihdOhWoibl7XFa6AKkA==
X-Google-Smtp-Source: ABdhPJyuqevFfIzgvOK6YFFlzSyrxnhka+WjQXMBWZbCidLgFariUFjS0pJR9BIys2X4zUssyd3kSg==
X-Received: by 2002:a17:906:9be1:: with SMTP id de33mr13573346ejc.320.1615170124961;
        Sun, 07 Mar 2021 18:22:04 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id dg26sm6264995edb.88.2021.03.07.18.22.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Mar 2021 18:22:04 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 6/6] tree.h API: remove "stage" parameter from read_tree_recursive()
Date:   Mon,  8 Mar 2021 03:21:38 +0100
Message-Id: <20210308022138.28166-7-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.rc0.126.g04f22c5b82
In-Reply-To: <20210306193458.20633-1-avarab@gmail.com>
References: <20210306193458.20633-1-avarab@gmail.com>
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
2.31.0.rc0.126.g04f22c5b82

