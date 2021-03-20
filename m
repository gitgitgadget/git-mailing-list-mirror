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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 894F3C433E6
	for <git@archiver.kernel.org>; Sat, 20 Mar 2021 22:39:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6393761935
	for <git@archiver.kernel.org>; Sat, 20 Mar 2021 22:39:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbhCTWip (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 20 Mar 2021 18:38:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbhCTWiT (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Mar 2021 18:38:19 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA949C061574
        for <git@vger.kernel.org>; Sat, 20 Mar 2021 15:38:18 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id b9so12753242wrt.8
        for <git@vger.kernel.org>; Sat, 20 Mar 2021 15:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HeKTJqhcuP+JV2yLp7cnLHTvUvV3LC//BWeGT4inAI0=;
        b=mOAzvpS5BY635WCKYDrIVJ5xPCg/CeaM8UuMlLPpLKTkXrofDIsHAiQ8ri00WbqVnW
         lZM84qP5/530B2Du76I/cV20zvnDKUQ9uZpzjAvyx8D2dSJw7zVre4zpw8rMqVL3kJtV
         GLk2tG8MkEOY+Q13yP2q8Pbv0+ivhK/rcwoteWYoONASN6i8uOQRTuUHvZ9Y4vjVnsDN
         E8vDgk/hKQxZeTs1hqnGMicBLCwQB5fidK3GIItNGceBr3KnkTmLf+IJyJfDXs/Zme4y
         R8NAa7+jW+BPqbebY2pw1p7xdsM0wbvcEkZ9F3DqWIhIsEem9c1kLdPXfjzb734WephU
         I1fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HeKTJqhcuP+JV2yLp7cnLHTvUvV3LC//BWeGT4inAI0=;
        b=Qe7d86aFfyPY2s8gwVDoU7gol2+VaLXbZrp0wY1qFKrDKp4eO3+bQAn6HcCIPMhDei
         NfQ6sXIaNrb3Ylx0UPXHJVJRWAq6QXY0062KfXjbHBcuq/2aCdqHAgAO6zsntfFic5Mc
         EUApfH9UsVH/LRCMNvCNQKC18j7A0JH0O3isYb5R/R215SV3pFcy6ZwguzcnIBTBXjWw
         LCKQZQhmOkO4q5wbIjNL0J0gZYGR0Nk6zB9vTqgDcwqEK4jcvBBeJlpnrBt76TfyYiii
         poGBWMurCUraZ1aYR4MBwOfq/SJrboRzDEu7THNhkSERjkPE8NgyixPNRYVIt1CjhruL
         UkRg==
X-Gm-Message-State: AOAM532HJRDLyK71Ry1bTTDv4FjN08+Uu5lPrC51xudumhCFmg253hGg
        XTrDwJpUlziWmxg34Pz5LP7GZSH5osfe0A==
X-Google-Smtp-Source: ABdhPJwkw359LixTbbqZ+piwx+nXJvErojQMQqPAWdMIV0EQZewrJo7KjdGdBF4fmLQhDDD1FzOQrQ==
X-Received: by 2002:a05:6000:1363:: with SMTP id q3mr10987570wrz.74.1616279897288;
        Sat, 20 Mar 2021 15:38:17 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v2sm21472697wmj.1.2021.03.20.15.38.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Mar 2021 15:38:16 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 8/8] tree.h API: simplify read_tree_recursive() signature
Date:   Sat, 20 Mar 2021 23:37:51 +0100
Message-Id: <fa157d8baeea3e4686b6df04b3cd9e9bcc3cd9a0.1616279653.git.avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.286.gc175f2cb894
In-Reply-To: <cover.1616279653.git.avarab@gmail.com>
References: <xmqqpmzxy939.fsf@gitster.g> <cover.1616279653.git.avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Simplify the signature of read_tree_recursive() to omit the "base",
"baselen" and "stage" arguments. No callers of it use these parameters
for anything anymore.

The last function to call read_tree_recursive() with a non-"" path was
read_tree_recursive() itself, but that was changed in
ffd31f661d5 (Reimplement read_tree_recursive() using
tree_entry_interesting(), 2011-03-25).

The last user of the "stage" parameter went away in the last commit,
and even that use was mere boilerplate.

So let's remove those and rename the read_tree_recursive() function to
just read_tree(). We had another read_tree() function that I've
refactored away in preceding commits, since all in-tree users read
trees recursively with a callback we can change the name to signify
that this is the norm.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 archive.c          | 18 +++++++++---------
 builtin/checkout.c |  8 ++++----
 builtin/log.c      |  8 ++++----
 builtin/ls-files.c |  6 +++---
 builtin/ls-tree.c  |  6 +++---
 merge-recursive.c  |  6 +++---
 tree.c             | 19 +++++++------------
 tree.h             | 13 ++++++-------
 8 files changed, 39 insertions(+), 45 deletions(-)

diff --git a/archive.c b/archive.c
index 4f271331543..4921dc8a69f 100644
--- a/archive.c
+++ b/archive.c
@@ -229,7 +229,7 @@ static int write_directory(struct archiver_context *c)
 
 static int queue_or_write_archive_entry(const struct object_id *oid,
 		struct strbuf *base, const char *filename,
-		unsigned mode, int stage, void *context)
+		unsigned mode, void *context)
 {
 	struct archiver_context *c = context;
 
@@ -314,10 +314,10 @@ int write_archive_entries(struct archiver_args *args,
 		git_attr_set_direction(GIT_ATTR_INDEX);
 	}
 
-	err = read_tree_recursive(args->repo, args->tree, "",
-				  0, 0, &args->pathspec,
-				  queue_or_write_archive_entry,
-				  &context);
+	err = read_tree(args->repo, args->tree,
+			&args->pathspec,
+			queue_or_write_archive_entry,
+			&context);
 	if (err == READ_TREE_RECURSIVE)
 		err = 0;
 	while (context.bottom) {
@@ -375,7 +375,7 @@ struct path_exists_context {
 };
 
 static int reject_entry(const struct object_id *oid, struct strbuf *base,
-			const char *filename, unsigned mode, int stage,
+			const char *filename, unsigned mode,
 			void *context)
 {
 	int ret = -1;
@@ -403,9 +403,9 @@ static int path_exists(struct archiver_args *args, const char *path)
 	ctx.args = args;
 	parse_pathspec(&ctx.pathspec, 0, 0, "", paths);
 	ctx.pathspec.recursive = 1;
-	ret = read_tree_recursive(args->repo, args->tree, "",
-				  0, 0, &ctx.pathspec,
-				  reject_entry, &ctx);
+	ret = read_tree(args->repo, args->tree,
+			&ctx.pathspec,
+			reject_entry, &ctx);
 	clear_pathspec(&ctx.pathspec);
 	return ret != 0;
 }
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 2d6550bc3c8..0e663905200 100644
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
@@ -155,8 +155,8 @@ static int update_some(const struct object_id *oid, struct strbuf *base,
 
 static int read_tree_some(struct tree *tree, const struct pathspec *pathspec)
 {
-	read_tree_recursive(the_repository, tree, "", 0, 0,
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
index f67b67d80ed..980de590638 100644
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
@@ -681,9 +681,9 @@ int cmd_show(int argc, const char **argv, const char *prefix)
 					diff_get_color_opt(&rev.diffopt, DIFF_COMMIT),
 					name,
 					diff_get_color_opt(&rev.diffopt, DIFF_RESET));
-			read_tree_recursive(the_repository, (struct tree *)o, "",
-					    0, 0, &match_all, show_tree_object,
-					    rev.diffopt.file);
+			read_tree(the_repository, (struct tree *)o,
+				  &match_all, show_tree_object,
+				  rev.diffopt.file);
 			rev.shown_one = 1;
 			break;
 		case OBJ_COMMIT:
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index aa153423b80..60a2913a01e 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -446,7 +446,7 @@ static int read_one_entry_opt(struct index_state *istate,
 }
 
 static int read_one_entry(const struct object_id *oid, struct strbuf *base,
-			  const char *pathname, unsigned mode, int stage,
+			  const char *pathname, unsigned mode,
 			  void *context)
 {
 	struct index_state *istate = context;
@@ -460,7 +460,7 @@ static int read_one_entry(const struct object_id *oid, struct strbuf *base,
  * the stage that will conflict with the entry being added.
  */
 static int read_one_entry_quick(const struct object_id *oid, struct strbuf *base,
-				const char *pathname, unsigned mode, int stage,
+				const char *pathname, unsigned mode,
 				void *context)
 {
 	struct index_state *istate = context;
@@ -522,7 +522,7 @@ void overlay_tree_on_index(struct index_state *istate,
 
 	if (!fn)
 		fn = read_one_entry_quick;
-	err = read_tree_recursive(the_repository, tree, "", 0, 1, &pathspec, fn, istate);
+	err = read_tree(the_repository, tree, &pathspec, fn, istate);
 	if (err)
 		die("unable to read tree entries %s", tree_name);
 
diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index 7cad3f24ebd..3a442631c71 100644
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
-	return !!read_tree_recursive(the_repository, tree, "", 0, 0,
-				     &pathspec, show_tree, NULL);
+	return !!read_tree(the_repository, tree,
+			   &pathspec, show_tree, NULL);
 }
diff --git a/merge-recursive.c b/merge-recursive.c
index b69e694d986..ed31f9496cb 100644
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
@@ -473,8 +473,8 @@ static void get_files_dirs(struct merge_options *opt, struct tree *tree)
 {
 	struct pathspec match_all;
 	memset(&match_all, 0, sizeof(match_all));
-	read_tree_recursive(opt->repo, tree, "", 0, 0,
-			    &match_all, save_files_dirs, opt);
+	read_tree(opt->repo, tree,
+		  &match_all, save_files_dirs, opt);
 }
 
 static int get_tree_entry_if_blob(struct repository *r,
diff --git a/tree.c b/tree.c
index f67c2153054..410e3b477e5 100644
--- a/tree.c
+++ b/tree.c
@@ -13,7 +13,6 @@ const char *tree_type = "tree";
 
 int read_tree_at(struct repository *r,
 		 struct tree *tree, struct strbuf *base,
-		 int stage,
 		 const struct pathspec *pathspec,
 		 read_tree_fn_t fn, void *context)
 {
@@ -39,7 +38,7 @@ int read_tree_at(struct repository *r,
 		}
 
 		switch (fn(&entry.oid, base,
-			   entry.path, entry.mode, stage, context)) {
+			   entry.path, entry.mode, context)) {
 		case 0:
 			continue;
 		case READ_TREE_RECURSIVE:
@@ -73,7 +72,7 @@ int read_tree_at(struct repository *r,
 		strbuf_add(base, entry.path, len);
 		strbuf_addch(base, '/');
 		retval = read_tree_at(r, lookup_tree(r, &oid),
-				      base, stage, pathspec,
+				      base, pathspec,
 				      fn, context);
 		strbuf_setlen(base, oldlen);
 		if (retval)
@@ -82,17 +81,13 @@ int read_tree_at(struct repository *r,
 	return 0;
 }
 
-int read_tree_recursive(struct repository *r,
-			struct tree *tree,
-			const char *base, int baselen,
-			int stage, const struct pathspec *pathspec,
-			read_tree_fn_t fn, void *context)
+int read_tree(struct repository *r,
+	      struct tree *tree,
+	      const struct pathspec *pathspec,
+	      read_tree_fn_t fn, void *context)
 {
 	struct strbuf sb = STRBUF_INIT;
-	int ret;
-
-	strbuf_add(&sb, base, baselen);
-	ret = read_tree_at(r, tree, &sb, stage, pathspec, fn, context);
+	int ret = read_tree_at(r, tree, &sb, pathspec, fn, context);
 	strbuf_release(&sb);
 	return ret;
 }
diff --git a/tree.h b/tree.h
index 123fc41efe6..6efff003e21 100644
--- a/tree.h
+++ b/tree.h
@@ -31,17 +31,16 @@ struct tree *parse_tree_indirect(const struct object_id *oid);
 int cmp_cache_name_compare(const void *a_, const void *b_);
 
 #define READ_TREE_RECURSIVE 1
-typedef int (*read_tree_fn_t)(const struct object_id *, struct strbuf *, const char *, unsigned int, int, void *);
+typedef int (*read_tree_fn_t)(const struct object_id *, struct strbuf *, const char *, unsigned int, void *);
 
 int read_tree_at(struct repository *r,
 		 struct tree *tree, struct strbuf *base,
-		 int stage,
 		 const struct pathspec *pathspec,
 		 read_tree_fn_t fn, void *context);
 
-int read_tree_recursive(struct repository *r,
-			struct tree *tree,
-			const char *base, int baselen,
-			int stage, const struct pathspec *pathspec,
-			read_tree_fn_t fn, void *context);
+int read_tree(struct repository *r,
+	      struct tree *tree,
+	      const struct pathspec *pathspec,
+	      read_tree_fn_t fn, void *context);
+
 #endif /* TREE_H */
-- 
2.31.0.286.gc175f2cb894

