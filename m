Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 630EC1F87F
	for <e@80x24.org>; Sun, 18 Nov 2018 16:48:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727332AbeKSDIz (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Nov 2018 22:08:55 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35197 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727082AbeKSDIz (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Nov 2018 22:08:55 -0500
Received: by mail-lj1-f196.google.com with SMTP id x85-v6so24169350ljb.2
        for <git@vger.kernel.org>; Sun, 18 Nov 2018 08:48:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vn1Lkdh0jGAa6LUlObctc9zM4PSJ2ZIrK51Np4nPTYE=;
        b=hz10VwlEkU14yi4FUCn/ElEPti7CF23cf5LOYmZY2FHdin0FlCf6fj0exWe0QQNrBX
         CuH3QYVU0dflGYkjtX5gAzMbHGzGkQ2Mc2TSj5IdAXAJZ4wcp4alPx0sASOvcWVycNUj
         KdDpMvqZIITyLJXzWnbkHBV7PXDf5OkY3T9iwIRf6e5IaXAKwx8zelOp3HzUmeLzkngD
         tNl+hl4BO9Un9l/WzDQ2aacAxMfRuLBdML5bbY5QZ8ttUeUXwRxT7NxwzUkUjHR3na9n
         QLoXvNN4gaRHJE2LnHezJhDuwPo+fB/aJDMb/yyAgXZ9d4hSDxZ2iUGOevdrKenqArE3
         z7cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vn1Lkdh0jGAa6LUlObctc9zM4PSJ2ZIrK51Np4nPTYE=;
        b=Roie91Gh6m+dWtv/Ctu8YOyvZzxB7yL4HxxuZ7czPUgDBIXbh/Dx4CZDaUatVd+n94
         cKszzS5HLMIe99DmcL8D3PyqeOLfeD0XFZtehlxEZFLywAJkBQWqgr2Z3jDvg/rfBF6+
         OmkV2+GTp3YFa8ABv0qYBpXa2Vv9ECMjgTqZfKliR2bUGHKwQhpaMg7fAJbMJtBwK5g7
         hW/7mtpeE3PJqHAH4cSwmmca9MKorSo00yHBLx9MKIHazRzj0xUdDLOHX3e4jEqucUCW
         gwPg2LZShLy0nVjZ6rfk/KhyrP1uw/Z418TGN4RHWCgUkaXjSuVUHrljvB+s7X6ZfCBD
         8oPg==
X-Gm-Message-State: AGRZ1gL3zH4l/2W5v9F/dDUQS2g3v75d0v+YxKcFehO1fpv+CVrPEvQd
        gPqW9KcfHovtMLAF2aQfpOnFL/we
X-Google-Smtp-Source: AJdET5fGD24QepH2nuOdwMEaB8O6XUBqKdzPwFUIUrUFbOc/zdzZ0uY60X7LY9gdk6VXEU3rAWp8mw==
X-Received: by 2002:a2e:45d:: with SMTP id 90-v6mr9844266lje.110.1542559687800;
        Sun, 18 Nov 2018 08:48:07 -0800 (PST)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id f29sm4461603lfa.46.2018.11.18.08.48.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 18 Nov 2018 08:48:07 -0800 (PST)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 1/5] tree.c: make read_tree*() take 'struct repository *'
Date:   Sun, 18 Nov 2018 17:47:56 +0100
Message-Id: <20181118164800.32759-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.1327.g328c130451.dirty
In-Reply-To: <20181118164800.32759-1-pclouds@gmail.com>
References: <20181118164800.32759-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These functions call tree_entry_interesting() which will soon require
a 'struct index_state *' to be passed in. Instead of just changing the
function signature to take an index, update to take a repo instead
because these functions do need object database access.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 archive.c          |  6 ++++--
 builtin/checkout.c |  3 ++-
 builtin/log.c      |  5 +++--
 builtin/ls-files.c |  2 +-
 builtin/ls-tree.c  |  3 ++-
 merge-recursive.c  |  3 ++-
 tree.c             | 18 ++++++++++--------
 tree.h             | 18 +++++++++++-------
 8 files changed, 35 insertions(+), 23 deletions(-)

diff --git a/archive.c b/archive.c
index fd556c28e4..bfa9cc20c9 100644
--- a/archive.c
+++ b/archive.c
@@ -285,7 +285,8 @@ int write_archive_entries(struct archiver_args *args,
 		git_attr_set_direction(GIT_ATTR_INDEX);
 	}
 
-	err = read_tree_recursive(args->tree, "", 0, 0, &args->pathspec,
+	err = read_tree_recursive(args->repo, args->tree, "",
+				  0, 0, &args->pathspec,
 				  queue_or_write_archive_entry,
 				  &context);
 	if (err == READ_TREE_RECURSIVE)
@@ -346,7 +347,8 @@ static int path_exists(struct archiver_args *args, const char *path)
 	ctx.args = args;
 	parse_pathspec(&ctx.pathspec, 0, 0, "", paths);
 	ctx.pathspec.recursive = 1;
-	ret = read_tree_recursive(args->tree, "", 0, 0, &ctx.pathspec,
+	ret = read_tree_recursive(args->repo, args->tree, "",
+				  0, 0, &ctx.pathspec,
 				  reject_entry, &ctx);
 	clear_pathspec(&ctx.pathspec);
 	return ret != 0;
diff --git a/builtin/checkout.c b/builtin/checkout.c
index acdafc6e4c..c9dda8e82e 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -115,7 +115,8 @@ static int update_some(const struct object_id *oid, struct strbuf *base,
 
 static int read_tree_some(struct tree *tree, const struct pathspec *pathspec)
 {
-	read_tree_recursive(tree, "", 0, 0, pathspec, update_some, NULL);
+	read_tree_recursive(the_repository, tree, "", 0, 0,
+			    pathspec, update_some, NULL);
 
 	/* update the index with the given tree's info
 	 * for all args, expanding wildcards, and exit
diff --git a/builtin/log.c b/builtin/log.c
index 061d4fd864..d493fa915e 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -639,8 +639,9 @@ int cmd_show(int argc, const char **argv, const char *prefix)
 					diff_get_color_opt(&rev.diffopt, DIFF_COMMIT),
 					name,
 					diff_get_color_opt(&rev.diffopt, DIFF_RESET));
-			read_tree_recursive((struct tree *)o, "", 0, 0, &match_all,
-					show_tree_object, rev.diffopt.file);
+			read_tree_recursive(the_repository, (struct tree *)o, "",
+					    0, 0, &match_all, show_tree_object,
+					    rev.diffopt.file);
 			rev.shown_one = 1;
 			break;
 		case OBJ_COMMIT:
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 7f9919a362..8db0cccbf3 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -441,7 +441,7 @@ void overlay_tree_on_index(struct index_state *istate,
 			       PATHSPEC_PREFER_CWD, prefix, matchbuf);
 	} else
 		memset(&pathspec, 0, sizeof(pathspec));
-	if (read_tree(tree, 1, &pathspec, istate))
+	if (read_tree(the_repository, tree, 1, &pathspec, istate))
 		die("unable to read tree entries %s", tree_name);
 
 	for (i = 0; i < istate->cache_nr; i++) {
diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index fe3b952cb3..6855f7fea5 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -185,5 +185,6 @@ int cmd_ls_tree(int argc, const char **argv, const char *prefix)
 	tree = parse_tree_indirect(&oid);
 	if (!tree)
 		die("not a tree object");
-	return !!read_tree_recursive(tree, "", 0, 0, &pathspec, show_tree, NULL);
+	return !!read_tree_recursive(the_repository, tree, "", 0, 0,
+				     &pathspec, show_tree, NULL);
 }
diff --git a/merge-recursive.c b/merge-recursive.c
index acc2f64a4e..b9467f5ecf 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -463,7 +463,8 @@ static void get_files_dirs(struct merge_options *o, struct tree *tree)
 {
 	struct pathspec match_all;
 	memset(&match_all, 0, sizeof(match_all));
-	read_tree_recursive(tree, "", 0, 0, &match_all, save_files_dirs, o);
+	read_tree_recursive(the_repository, tree, "", 0, 0,
+			    &match_all, save_files_dirs, o);
 }
 
 static int get_tree_entry_if_blob(const struct object_id *tree,
diff --git a/tree.c b/tree.c
index 215d3fdc7c..ecd8c8ac29 100644
--- a/tree.c
+++ b/tree.c
@@ -60,7 +60,8 @@ static int read_one_entry_quick(const struct object_id *oid, struct strbuf *base
 				  ADD_CACHE_JUST_APPEND);
 }
 
-static int read_tree_1(struct tree *tree, struct strbuf *base,
+static int read_tree_1(struct repository *r,
+		       struct tree *tree, struct strbuf *base,
 		       int stage, const struct pathspec *pathspec,
 		       read_tree_fn_t fn, void *context)
 {
@@ -99,7 +100,7 @@ static int read_tree_1(struct tree *tree, struct strbuf *base,
 		else if (S_ISGITLINK(entry.mode)) {
 			struct commit *commit;
 
-			commit = lookup_commit(the_repository, entry.oid);
+			commit = lookup_commit(r, entry.oid);
 			if (!commit)
 				die("Commit %s in submodule path %s%s not found",
 				    oid_to_hex(entry.oid),
@@ -118,7 +119,7 @@ static int read_tree_1(struct tree *tree, struct strbuf *base,
 		len = tree_entry_len(&entry);
 		strbuf_add(base, entry.path, len);
 		strbuf_addch(base, '/');
-		retval = read_tree_1(lookup_tree(the_repository, &oid),
+		retval = read_tree_1(r, lookup_tree(r, &oid),
 				     base, stage, pathspec,
 				     fn, context);
 		strbuf_setlen(base, oldlen);
@@ -128,7 +129,8 @@ static int read_tree_1(struct tree *tree, struct strbuf *base,
 	return 0;
 }
 
-int read_tree_recursive(struct tree *tree,
+int read_tree_recursive(struct repository *r,
+			struct tree *tree,
 			const char *base, int baselen,
 			int stage, const struct pathspec *pathspec,
 			read_tree_fn_t fn, void *context)
@@ -137,7 +139,7 @@ int read_tree_recursive(struct tree *tree,
 	int ret;
 
 	strbuf_add(&sb, base, baselen);
-	ret = read_tree_1(tree, &sb, stage, pathspec, fn, context);
+	ret = read_tree_1(r, tree, &sb, stage, pathspec, fn, context);
 	strbuf_release(&sb);
 	return ret;
 }
@@ -152,8 +154,8 @@ static int cmp_cache_name_compare(const void *a_, const void *b_)
 				  ce2->name, ce2->ce_namelen, ce_stage(ce2));
 }
 
-int read_tree(struct tree *tree, int stage, struct pathspec *match,
-	      struct index_state *istate)
+int read_tree(struct repository *r, struct tree *tree, int stage,
+	      struct pathspec *match, struct index_state *istate)
 {
 	read_tree_fn_t fn = NULL;
 	int i, err;
@@ -181,7 +183,7 @@ int read_tree(struct tree *tree, int stage, struct pathspec *match,
 
 	if (!fn)
 		fn = read_one_entry_quick;
-	err = read_tree_recursive(tree, "", 0, stage, match, fn, istate);
+	err = read_tree_recursive(r, tree, "", 0, stage, match, fn, istate);
 	if (fn == read_one_entry || err)
 		return err;
 
diff --git a/tree.h b/tree.h
index d4807dc805..9383745073 100644
--- a/tree.h
+++ b/tree.h
@@ -3,7 +3,7 @@
 
 #include "object.h"
 
-extern const char *tree_type;
+struct repository;
 struct strbuf;
 
 struct tree {
@@ -12,6 +12,8 @@ struct tree {
 	unsigned long size;
 };
 
+extern const char *tree_type;
+
 struct tree *lookup_tree(struct repository *r, const struct object_id *oid);
 
 int parse_tree_buffer(struct tree *item, void *buffer, unsigned long size);
@@ -29,12 +31,14 @@ struct tree *parse_tree_indirect(const struct object_id *oid);
 #define READ_TREE_RECURSIVE 1
 typedef int (*read_tree_fn_t)(const struct object_id *, struct strbuf *, const char *, unsigned int, int, void *);
 
-extern int read_tree_recursive(struct tree *tree,
-			       const char *base, int baselen,
-			       int stage, const struct pathspec *pathspec,
-			       read_tree_fn_t fn, void *context);
+int read_tree_recursive(struct repository *r,
+			struct tree *tree,
+			const char *base, int baselen,
+			int stage, const struct pathspec *pathspec,
+			read_tree_fn_t fn, void *context);
 
-extern int read_tree(struct tree *tree, int stage, struct pathspec *pathspec,
-		     struct index_state *istate);
+int read_tree(struct repository *r, struct tree *tree,
+	      int stage, struct pathspec *pathspec,
+	      struct index_state *istate);
 
 #endif /* TREE_H */
-- 
2.19.1.1327.g328c130451.dirty

