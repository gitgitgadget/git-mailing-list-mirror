Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04C26C433F5
	for <git@archiver.kernel.org>; Tue, 19 Oct 2021 11:39:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7FF461372
	for <git@archiver.kernel.org>; Tue, 19 Oct 2021 11:39:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbhJSLlc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Oct 2021 07:41:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235350AbhJSLla (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Oct 2021 07:41:30 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5F88C06161C
        for <git@vger.kernel.org>; Tue, 19 Oct 2021 04:39:17 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id ls14-20020a17090b350e00b001a00e2251c8so2422501pjb.4
        for <git@vger.kernel.org>; Tue, 19 Oct 2021 04:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uYHWS382IB+PsHQ2WHWpSXNLEyy5R5xwegvG/GZvoN0=;
        b=OpYRLLhlQmjmF7/fAcdlhd3dN86zoC3sdsp2mb0a7bBsJhtgOr1+p4KYXR7R3+MXb/
         YeOegty8yKBzYUVGW88lqH/clL1GlLCNF//M8DSkHtrIredyqbpW9f86YIbxF3YAdwK4
         pgtTzCFuAJJ7b//+OiEz7lyJmSFkAWp23gppGkbl/VwA3JdSuSwK0fgx+DkGmEFJPRqG
         43/tHt2veO6spIyYn9tt9sBfZX9qEjkAOBLWJUgr1l2AGz0g5IByNmAHVFbqcEhgDoQs
         YoXvD9qtPAnr62xsbxoGcSOgPXpfHzFg/dINNob9By/u9A67wWe0yZpyo+/R2R0o5ISu
         7JTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uYHWS382IB+PsHQ2WHWpSXNLEyy5R5xwegvG/GZvoN0=;
        b=c9hwecLUaB1D+zq8Ks1rvsTugjnLIX9r4kukbPkq5SLxjD6ydXt8k0R+xHF2H2EF4O
         anOmA63U48Ras8tKfDYlHIm2O7mLv7DwGOsji2no/GSG4m9tjRsPfdp/ca9r3w3vpcqY
         t3ypfLOpFliknODM9XjSZJBmouP2Bz8xo5Lz8FlgHdstZYsypeKmch8gXwiSeB1Da4pa
         Z+wBgakpOrbV69boFWZYivYZOhjBCAY773wOoBKCbrxxlTA8S+EgVuQ5mMUmuSpZADsv
         w811nsM1GalOKWT3qdsPgLrAUsB5Nfppk7/cA11FzTbXaNZeCMfJbPOQsIhPBwyv9c/G
         HRqw==
X-Gm-Message-State: AOAM533rTHjYJhdedYsrhfvX3IunttVa2Izn2l/umXNfsO10Q872d3dS
        3kbDJhroehS7vPz9evEmKDJCKxrrmZc=
X-Google-Smtp-Source: ABdhPJyyTaRptwGzMX682dMfhqKT1eqljlugEE1s1/+WbqpJGcfOysnNJwYZfm+rqxNVubUS6+2FYQ==
X-Received: by 2002:a17:902:6902:b0:13f:c1cd:88f1 with SMTP id j2-20020a170902690200b0013fc1cd88f1mr10012905plk.36.1634643557028;
        Tue, 19 Oct 2021 04:39:17 -0700 (PDT)
Received: from localhost.localdomain ([205.204.117.96])
        by smtp.gmail.com with ESMTPSA id l207sm16430861pfd.199.2021.10.19.04.39.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Oct 2021 04:39:16 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong@alibaba-inc.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, avarab@gmail.com, jonathantanmy@google.com,
        bagasdotme@gmail.com, adlternative@gmail.com, stolee@gmail.com,
        Teng Long <dyroneteng@gmail.com>
Subject: [PATCH v6 03/12] Replace `show_data` with structure `show_info`
Date:   Tue, 19 Oct 2021 19:38:27 +0800
Message-Id: <dced036f89b44cf5b719287bbb82727ea4cc9543.1634634814.git.tenglong@alibaba-inc.com>
X-Mailer: git-send-email 2.31.1.453.g945ddc3a74.dirty
In-Reply-To: <cover.1634634814.git.tenglong@alibaba-inc.com>
References: <cover.1634634814.git.tenglong@alibaba-inc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Teng Long <dyroneteng@gmail.com>

During the pack-objects process, "show_object" function will be called
to find and show the object the function contains three parameters:

	1. struct object *obj
	2. const char *name
	3. void *show_data

This commit replace "show_data" with with a new structure `show_info`,
it has two members:

	1. void *show_data
        2. void *show_cache

The `show_data` in `show_info `is the same purpose with the original
one, is the callback when showing the objects.

The `show_cache` is the cache that ownership the relationship data.
It stores around the extra data for showing the objects, for example,
carry the ownership relationship between blob or tree objects and the
referred commit to avoid redundant and expensive calculations.

Signed-off-by: Teng Long <dyroneteng@gmail.com>
---
 builtin/describe.c     |  9 +++++----
 builtin/pack-objects.c | 23 +++++++++++++----------
 builtin/rev-list.c     | 11 ++++++-----
 bundle.c               |  5 +++--
 list-objects.c         | 29 +++++++++++++++++++++++------
 list-objects.h         | 11 ++++++++---
 pack-bitmap.c          | 16 +++++++++-------
 reachable.c            | 11 +++++++----
 shallow.c              |  4 ++--
 9 files changed, 76 insertions(+), 43 deletions(-)

diff --git a/builtin/describe.c b/builtin/describe.c
index 40482d8e9f..a6a9e64fb0 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -479,15 +479,16 @@ struct process_commit_data {
 	struct rev_info *revs;
 };
 
-static void process_commit(struct commit *commit, void *data)
+static void process_commit(struct commit *commit, struct show_info *info)
 {
-	struct process_commit_data *pcd = data;
+	struct process_commit_data *pcd = info->show_data;
 	pcd->current_commit = commit->object.oid;
 }
 
-static void process_object(struct object *obj, const char *path, void *data)
+static void process_object(struct object *obj, const char *path,
+			   struct show_info *info)
 {
-	struct process_commit_data *pcd = data;
+	struct process_commit_data *pcd = info->show_data;
 
 	if (oideq(&pcd->looking_for, &obj->oid) && !pcd->dst->len) {
 		reset_revision_walk();
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 17053dc85a..a41a0a3ea7 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3106,13 +3106,13 @@ static int add_object_entry_from_pack(const struct object_id *oid,
 	return 0;
 }
 
-static void show_commit_pack_hint(struct commit *commit, void *_data)
+static void show_commit_pack_hint(struct commit *commit, struct show_info *info)
 {
 	/* nothing to do; commits don't have a namehash */
 }
 
 static void show_object_pack_hint(struct object *object, const char *name,
-				  void *_data)
+				  struct show_info *info)
 {
 	struct object_entry *oe = packlist_find(&to_pack, &object->oid);
 	if (!oe)
@@ -3284,7 +3284,7 @@ static void read_object_list_from_stdin(void)
 /* Remember to update object flag allocation in object.h */
 #define OBJECT_ADDED (1u<<20)
 
-static void show_commit(struct commit *commit, void *data)
+static void show_commit(struct commit *commit, struct show_info *info)
 {
 	add_object_entry(&commit->object.oid, OBJ_COMMIT, NULL, 0);
 	commit->object.flags |= OBJECT_ADDED;
@@ -3296,7 +3296,8 @@ static void show_commit(struct commit *commit, void *data)
 		propagate_island_marks(commit);
 }
 
-static void show_object(struct object *obj, const char *name, void *data)
+static void show_object(struct object *obj, const char *name,
+			struct show_info *info)
 {
 	add_preferred_base_object(name);
 	add_object_entry(&obj->oid, obj->type, name, 0);
@@ -3318,7 +3319,8 @@ static void show_object(struct object *obj, const char *name, void *data)
 	}
 }
 
-static void show_object__ma_allow_any(struct object *obj, const char *name, void *data)
+static void show_object__ma_allow_any(struct object *obj, const char *name,
+				      struct show_info *info)
 {
 	assert(arg_missing_action == MA_ALLOW_ANY);
 
@@ -3329,10 +3331,11 @@ static void show_object__ma_allow_any(struct object *obj, const char *name, void
 	if (!has_object(the_repository, &obj->oid, 0))
 		return;
 
-	show_object(obj, name, data);
+	show_object(obj, name, info);
 }
 
-static void show_object__ma_allow_promisor(struct object *obj, const char *name, void *data)
+static void show_object__ma_allow_promisor(struct object *obj, const char *name,
+					   struct show_info *info)
 {
 	assert(arg_missing_action == MA_ALLOW_PROMISOR);
 
@@ -3343,7 +3346,7 @@ static void show_object__ma_allow_promisor(struct object *obj, const char *name,
 	if (!has_object(the_repository, &obj->oid, 0) && is_promisor_object(&obj->oid))
 		return;
 
-	show_object(obj, name, data);
+	show_object(obj, name, info);
 }
 
 static int option_parse_missing_action(const struct option *opt,
@@ -3591,12 +3594,12 @@ static int get_object_list_from_bitmap(struct rev_info *revs)
 
 static void record_recent_object(struct object *obj,
 				 const char *name,
-				 void *data)
+				 struct show_info *info)
 {
 	oid_array_append(&recent_objects, &obj->oid);
 }
 
-static void record_recent_commit(struct commit *commit, void *data)
+static void record_recent_commit(struct commit *commit, struct show_info *info)
 {
 	oid_array_append(&recent_objects, &commit->object.oid);
 }
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index b4d8ea0a35..116d8d39f1 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -94,9 +94,9 @@ static off_t get_object_disk_usage(struct object *obj)
 }
 
 static void finish_commit(struct commit *commit);
-static void show_commit(struct commit *commit, void *data)
+static void show_commit(struct commit *commit, struct show_info *s_info)
 {
-	struct rev_list_info *info = data;
+	struct rev_list_info *info = s_info->show_data;
 	struct rev_info *revs = info->revs;
 
 	display_progress(progress, ++progress_counter);
@@ -266,12 +266,13 @@ static int finish_object(struct object *obj, const char *name, void *cb_data)
 	return 0;
 }
 
-static void show_object(struct object *obj, const char *name, void *cb_data)
+static void show_object(struct object *obj, const char *name,
+			struct show_info *s_info)
 {
-	struct rev_list_info *info = cb_data;
+	struct rev_list_info *info = s_info->show_data;
 	struct rev_info *revs = info->revs;
 
-	if (finish_object(obj, name, cb_data))
+	if (finish_object(obj, name, info))
 		return;
 	display_progress(progress, ++progress_counter);
 	if (show_disk_usage)
diff --git a/bundle.c b/bundle.c
index 693d619551..d4c71ee2b4 100644
--- a/bundle.c
+++ b/bundle.c
@@ -437,9 +437,9 @@ struct bundle_prerequisites_info {
 	int fd;
 };
 
-static void write_bundle_prerequisites(struct commit *commit, void *data)
+static void write_bundle_prerequisites(struct commit *commit, struct show_info *info)
 {
-	struct bundle_prerequisites_info *bpi = data;
+	struct bundle_prerequisites_info *bpi = info->show_data;
 	struct object *object;
 	struct pretty_print_context ctx = { 0 };
 	struct strbuf buf = STRBUF_INIT;
@@ -530,6 +530,7 @@ int create_bundle(struct repository *r, const char *path,
 		die("revision walk setup failed");
 	bpi.fd = bundle_fd;
 	bpi.pending = &revs_copy.pending;
+
 	traverse_commit_list(&revs, write_bundle_prerequisites, NULL, &bpi);
 	object_array_remove_duplicates(&revs_copy.pending);
 
diff --git a/list-objects.c b/list-objects.c
index e19589baa0..bffce67dd8 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -29,6 +29,10 @@ static void process_blob(struct traversal_context *ctx,
 	struct object *obj = &blob->object;
 	size_t pathlen;
 	enum list_objects_filter_result r;
+	struct show_info show_info;
+
+	show_info.show_data = ctx->show_data;
+	show_info.show_cache = NULL;
 
 	if (!ctx->revs->blob_objects)
 		return;
@@ -60,7 +64,7 @@ static void process_blob(struct traversal_context *ctx,
 	if (r & LOFR_MARK_SEEN)
 		obj->flags |= SEEN;
 	if (r & LOFR_DO_SHOW)
-		ctx->show_object(obj, path->buf, ctx->show_data);
+		ctx->show_object(obj, path->buf, &show_info);
 	strbuf_setlen(path, pathlen);
 }
 
@@ -154,10 +158,14 @@ static void process_tree(struct traversal_context *ctx,
 {
 	struct object *obj = &tree->object;
 	struct rev_info *revs = ctx->revs;
+	struct show_info show_info;
 	int baselen = base->len;
 	enum list_objects_filter_result r;
 	int failed_parse;
 
+	show_info.show_data = ctx->show_data;
+	show_info.show_cache = NULL;
+
 	if (!revs->tree_objects)
 		return;
 	if (!obj)
@@ -191,7 +199,7 @@ static void process_tree(struct traversal_context *ctx,
 	if (r & LOFR_MARK_SEEN)
 		obj->flags |= SEEN;
 	if (r & LOFR_DO_SHOW)
-		ctx->show_object(obj, base->buf, ctx->show_data);
+		ctx->show_object(obj, base->buf, &show_info);
 	if (base->len)
 		strbuf_addch(base, '/');
 
@@ -207,8 +215,7 @@ static void process_tree(struct traversal_context *ctx,
 	if (r & LOFR_MARK_SEEN)
 		obj->flags |= SEEN;
 	if (r & LOFR_DO_SHOW)
-		ctx->show_object(obj, base->buf, ctx->show_data);
-
+		ctx->show_object(obj, base->buf, &show_info);
 	strbuf_setlen(base, baselen);
 	free_tree_buffer(tree);
 }
@@ -322,8 +329,12 @@ static void add_pending_tree(struct rev_info *revs, struct tree *tree)
 static void traverse_trees_and_blobs(struct traversal_context *ctx,
 				     struct strbuf *base)
 {
+	struct show_info show_info;
 	int i;
 
+	show_info.show_data = ctx->show_data;
+	show_info.show_cache = NULL;
+
 	assert(base->len == 0);
 
 	for (i = 0; i < ctx->revs->pending.nr; i++) {
@@ -335,7 +346,7 @@ static void traverse_trees_and_blobs(struct traversal_context *ctx,
 			continue;
 		if (obj->type == OBJ_TAG) {
 			obj->flags |= SEEN;
-			ctx->show_object(obj, name, ctx->show_data);
+			ctx->show_object(obj, name, &show_info);
 			continue;
 		}
 		if (!path)
@@ -358,8 +369,13 @@ static void do_traverse(struct traversal_context *ctx)
 {
 	struct commit *commit;
 	struct strbuf csp; /* callee's scratch pad */
+	struct show_info show_info;
 	strbuf_init(&csp, PATH_MAX);
 
+
+	show_info.show_data = ctx->show_data;
+	show_info.show_cache = NULL;
+
 	while ((commit = get_revision(ctx->revs)) != NULL) {
 		/*
 		 * an uninteresting boundary commit may not have its tree
@@ -375,7 +391,8 @@ static void do_traverse(struct traversal_context *ctx)
 			die(_("unable to load root tree for commit %s"),
 			      oid_to_hex(&commit->object.oid));
 		}
-		ctx->show_commit(commit, ctx->show_data);
+
+		ctx->show_commit(commit, &show_info);
 
 		if (ctx->revs->tree_blobs_in_commit_order)
 			/*
diff --git a/list-objects.h b/list-objects.h
index a952680e46..c7b61e9e10 100644
--- a/list-objects.h
+++ b/list-objects.h
@@ -5,9 +5,14 @@ struct commit;
 struct object;
 struct rev_info;
 
-typedef void (*show_commit_fn)(struct commit *, void *);
-typedef void (*show_object_fn)(struct object *, const char *, void *);
-void traverse_commit_list(struct rev_info *, show_commit_fn, show_object_fn, void *);
+struct show_info {
+    void *show_data; /* the data necessary for showing the object */
+    void *show_cache; /* the cache ownership relationship data for showing the object */
+};
+
+typedef void (*show_commit_fn)(struct commit *, struct show_info *);
+typedef void (*show_object_fn)(struct object *, const char *, struct show_info *);
+void traverse_commit_list(struct rev_info *, show_commit_fn, show_object_fn, void *show_data);
 
 typedef void (*show_edge_fn)(struct commit *);
 void mark_edges_uninteresting(struct rev_info *revs,
diff --git a/pack-bitmap.c b/pack-bitmap.c
index 3ed15431cd..0dcfa5b50e 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -459,9 +459,10 @@ struct bitmap_show_data {
 	struct bitmap *base;
 };
 
-static void show_object(struct object *object, const char *name, void *data_)
+static void show_object(struct object *object, const char *name,
+			struct show_info *info)
 {
-	struct bitmap_show_data *data = data_;
+	struct bitmap_show_data *data = info->show_data;
 	int bitmap_pos;
 
 	bitmap_pos = bitmap_position(data->bitmap_git, &object->oid);
@@ -473,7 +474,7 @@ static void show_object(struct object *object, const char *name, void *data_)
 	bitmap_set(data->base, bitmap_pos);
 }
 
-static void show_commit(struct commit *commit, void *data)
+static void show_commit(struct commit *commit, struct show_info *info)
 {
 }
 
@@ -628,6 +629,7 @@ static struct bitmap *find_objects(struct bitmap_index *bitmap_git,
 		show_data.bitmap_git = bitmap_git;
 		show_data.base = base;
 
+
 		traverse_commit_list_filtered(filter, revs,
 					      show_commit, show_object,
 					      &show_data, NULL);
@@ -1268,9 +1270,9 @@ struct bitmap_test_data {
 };
 
 static void test_show_object(struct object *object, const char *name,
-			     void *data)
+			     struct show_info *info)
 {
-	struct bitmap_test_data *tdata = data;
+	struct bitmap_test_data *tdata = info->show_data;
 	int bitmap_pos;
 
 	bitmap_pos = bitmap_position(tdata->bitmap_git, &object->oid);
@@ -1281,9 +1283,9 @@ static void test_show_object(struct object *object, const char *name,
 	display_progress(tdata->prg, ++tdata->seen);
 }
 
-static void test_show_commit(struct commit *commit, void *data)
+static void test_show_commit(struct commit *commit, struct show_info *info)
 {
-	struct bitmap_test_data *tdata = data;
+	struct bitmap_test_data *tdata = info->show_data;
 	int bitmap_pos;
 
 	bitmap_pos = bitmap_position(tdata->bitmap_git,
diff --git a/reachable.c b/reachable.c
index 77a60c70a5..4f78954c62 100644
--- a/reachable.c
+++ b/reachable.c
@@ -47,14 +47,15 @@ static int add_one_ref(const char *path, const struct object_id *oid,
  * The traversal will have already marked us as SEEN, so we
  * only need to handle any progress reporting here.
  */
-static void mark_object(struct object *obj, const char *name, void *data)
+static void mark_object(struct object *obj, const char *name,
+			struct show_info *info)
 {
-	update_progress(data);
+	update_progress(info->show_data);
 }
 
-static void mark_commit(struct commit *c, void *data)
+static void mark_commit(struct commit *c, struct show_info *info)
 {
-	mark_object(&c->object, NULL, data);
+	mark_object(&c->object, NULL, info);
 }
 
 struct recent_data {
@@ -230,6 +231,7 @@ void mark_reachable_objects(struct rev_info *revs, int mark_reflog,
 		return;
 	}
 
+
 	/*
 	 * Set up the revision walk - this will move all commits
 	 * from the pending list to the commit walking list.
@@ -244,6 +246,7 @@ void mark_reachable_objects(struct rev_info *revs, int mark_reflog,
 			die("unable to mark recent objects");
 		if (prepare_revision_walk(revs))
 			die("revision walk setup failed");
+
 		traverse_commit_list(revs, mark_commit, mark_object, &cp);
 	}
 
diff --git a/shallow.c b/shallow.c
index 9ed18eb884..ab1e49eba4 100644
--- a/shallow.c
+++ b/shallow.c
@@ -185,9 +185,9 @@ struct commit_list *get_shallow_commits(struct object_array *heads, int depth,
 	return result;
 }
 
-static void show_commit(struct commit *commit, void *data)
+static void show_commit(struct commit *commit, struct show_info *info)
 {
-	commit_list_insert(commit, data);
+	commit_list_insert(commit, info->show_data);
 }
 
 /*
-- 
2.31.1.453.g945ddc3a74.dirty

