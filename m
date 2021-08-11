Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60E36C4338F
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 07:46:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 409A060551
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 07:46:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235795AbhHKHq5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Aug 2021 03:46:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235822AbhHKHqv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Aug 2021 03:46:51 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94F46C061798
        for <git@vger.kernel.org>; Wed, 11 Aug 2021 00:46:28 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id a8so2056207pjk.4
        for <git@vger.kernel.org>; Wed, 11 Aug 2021 00:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jb9tRMMhc7xvBcIKeJ9haLxUh2npQixe0JQrmS9Y7qo=;
        b=gAgfWAaTHM4tKViekJBvjTQu59dYTv4BLrf+2ageu4kg5b/bFQuj1fIaJtaO7HT+pS
         KL/f2RI4yd8XY0n5GrN5K1AseJt9Dc9P7w4eWHh1hXfqkDBhIXs2I9pHvnDWO2qDyRmn
         yDi4DaNJ+1xFtleDk34RiPvPwycsnqqOA4F1OTMjofMwmkx0sJMk7PP62BzD5EJQEAcC
         R66+1IF+bBxz/nahcuy2/PxSr2iuDs9Gy45CgO5V0Uwb7m401qtJ+E1xx0/0lYYxSQ2q
         Artq7wCBERej38Fr1nLY4efI1DCSbunCeZguZuS8ff5E+jphZRkNYp1a+aiiC3kb9gHg
         yWGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jb9tRMMhc7xvBcIKeJ9haLxUh2npQixe0JQrmS9Y7qo=;
        b=WqM3DFaeyRK/Wv2fNGebbTEHUJncVqZm2lbfTuIBifm1uZP/ONm1JMsxgBizHadx4O
         KB5K6+HEDnEr2RFP9JGWlWUacCcZKCIfYOBy7qs1HZZvNFwSv7vCEUaF7z9BzIHMQaf/
         bFea6ur4qmAXbHCJNFQfyAm9KAr3bUhyx5QfT0i4NhvhsfdUc+Ewk0zGjQ2uURv3qbbs
         aFvLEWbmyfGAvH9J63F/N00wrt4c+k3AJv6pTR2MaOT0craAGwEIHumA5uhcd08oltR3
         vy52aI4gmQ6NsqNSBYWCv3S8GgKzimVVMHVsQG/znLok2r15MbWBH/oJidnYYLGzoYPz
         xuXA==
X-Gm-Message-State: AOAM53272z5GYl4ElFrAosZElId5UvWhF7cxzDlxurFwUTTcA39lv+FA
        5tWBEdiKHTUBDJC4aZYyMwTjs4k5fWoxqsre
X-Google-Smtp-Source: ABdhPJzh8hRvkwSYN8qEwlFQhzz/ZmMPbE1gxQHD25rs4i4f5Fou6EbQbP7VROqaBuwSPo42zTVEVA==
X-Received: by 2002:aa7:8115:0:b029:3c4:30f7:bf68 with SMTP id b21-20020aa781150000b02903c430f7bf68mr33241767pfi.28.1628667988159;
        Wed, 11 Aug 2021 00:46:28 -0700 (PDT)
Received: from localhost.localdomain ([47.246.98.155])
        by smtp.gmail.com with ESMTPSA id u13sm26179672pfi.51.2021.08.11.00.46.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Aug 2021 00:46:27 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
To:     dyroneteng@gmail.com
Cc:     avarab@gmail.com, git@vger.kernel.org, jonathantanmy@google.com
Subject: [PATCH v4 4/7] packfile-uri: support for excluding tree objects
Date:   Wed, 11 Aug 2021 15:45:51 +0800
Message-Id: <bbb0413cc41811d5a8cd6025fc546657e88e48c6.1628666093.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.31.1.449.gb2aa5456a8.dirty
In-Reply-To: <cover.1628666093.git.dyroneteng@gmail.com>
References: <cover.1628666093.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This commit supports the use of `uploadpack.excludeobject` to exclude
tree objects, which means that when a type object is configured as
packfile-uri, the tree object itself and all objects contains will be
recursively excluded.

Signed-off-by: Teng Long <dyroneteng@gmail.com>
---
 builtin/pack-objects.c | 30 ++++++++++++++++++++----------
 list-objects.c         | 32 ++++++++++++++++++--------------
 object.c               |  6 +++++-
 object.h               | 13 ++++++++++++-
 4 files changed, 55 insertions(+), 26 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 63f3aed70a..4ff12ec525 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1312,13 +1312,14 @@ static int want_object_in_pack(const struct object_id *oid,
 			       int exclude,
 			       struct packed_git **found_pack,
 			       off_t *found_offset,
-			       struct object *referred_commit)
+			       struct referred_objects *referred_objs)
 {
 	int want;
 	struct list_head *pos;
 	struct multi_pack_index *m;
+	struct configured_exclusion *commit_ex;
+	struct configured_exclusion *tree_ex;
 	struct configured_exclusion *ex;
-	struct configured_exclusion *referred_ex;
 
 	if (!exclude && local && has_loose_object_nonlocal(oid))
 		return 0;
@@ -1354,14 +1355,23 @@ static int want_object_in_pack(const struct object_id *oid,
 	}
 
 	if (uri_protocols.nr) {
-		if (referred_commit) {
-			referred_ex = oidmap_get(&configured_exclusions, &referred_commit->oid);
-			if (referred_ex && match_packfile_uri_exclusions(referred_ex))
+		if (referred_objs && referred_objs->commit) {
+			commit_ex = oidmap_get(&configured_exclusions, &referred_objs->commit->oid);
+			if (match_packfile_uri_exclusions(commit_ex))
 				return 0;
 		}
 
+		if (referred_objs && referred_objs->trees) {
+			struct object_list *p;
+			for (p = referred_objs->trees; p; p = p->next) {
+				tree_ex = oidmap_get(&configured_exclusions, &p->item->oid);
+				if (match_packfile_uri_exclusions(tree_ex))
+					return 0;
+			}
+		}
+
 		ex = oidmap_get(&configured_exclusions, oid);
-		if (ex && match_packfile_uri_exclusions(ex)) {
+		if (match_packfile_uri_exclusions(ex)) {
 			oidset_insert(&excluded_by_config, oid);
 			return 0;
 		}
@@ -1401,7 +1411,7 @@ static const char no_closure_warning[] = N_(
 
 static int add_object_entry(const struct object_id *oid, enum object_type type,
 			    const char *name, int exclude,
-			    struct object *referred_commit)
+			    struct referred_objects *referred_objs)
 {
 	struct packed_git *found_pack = NULL;
 	off_t found_offset = 0;
@@ -1411,7 +1421,7 @@ static int add_object_entry(const struct object_id *oid, enum object_type type,
 	if (have_duplicate_entry(oid, exclude))
 		return 0;
 
-	if (!want_object_in_pack(oid, exclude, &found_pack, &found_offset, referred_commit)) {
+	if (!want_object_in_pack(oid, exclude, &found_pack, &found_offset, referred_objs)) {
 		/* The pack is missing an object, so it will not have closure */
 		if (write_bitmap_index) {
 			if (write_bitmap_index != WRITE_BITMAP_QUIET)
@@ -3262,9 +3272,9 @@ static void show_commit(struct commit *commit, void *data)
 
 static void show_object(struct object *obj, const char *name, void *show_data, void *carry_data)
 {
-	struct object *referred_commit = carry_data;
+	struct referred_objects *referred_objs = carry_data;
 	add_preferred_base_object(name);
-	add_object_entry(&obj->oid, obj->type, name, 0, referred_commit);
+	add_object_entry(&obj->oid, obj->type, name, 0, referred_objs);
 	obj->flags |= OBJECT_ADDED;
 
 	if (use_delta_islands) {
diff --git a/list-objects.c b/list-objects.c
index 968d842ceb..49f177cb56 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -25,7 +25,7 @@ static void process_blob(struct traversal_context *ctx,
 			 struct blob *blob,
 			 struct strbuf *path,
 			 const char *name,
-			 struct object *referred_commit)
+			 struct referred_objects *referred_objs)
 {
 	struct object *obj = &blob->object;
 	size_t pathlen;
@@ -61,7 +61,7 @@ static void process_blob(struct traversal_context *ctx,
 	if (r & LOFR_MARK_SEEN)
 		obj->flags |= SEEN;
 	if (r & LOFR_DO_SHOW)
-		ctx->show_object(obj, path->buf, ctx->show_data, referred_commit);
+		ctx->show_object(obj, path->buf, ctx->show_data, referred_objs);
 	strbuf_setlen(path, pathlen);
 }
 
@@ -99,19 +99,22 @@ static void process_tree(struct traversal_context *ctx,
 			 struct tree *tree,
 			 struct strbuf *base,
 			 const char *name,
-			 struct object *referred_commit);
+			 struct referred_objects *referred_objs);
 
 static void process_tree_contents(struct traversal_context *ctx,
 				  struct tree *tree,
 				  struct strbuf *base,
-				  struct object *referred_commit)
+				  struct referred_objects *referred_objs)
 {
 	struct tree_desc desc;
 	struct name_entry entry;
 	enum interesting match = ctx->revs->diffopt.pathspec.nr == 0 ?
 		all_entries_interesting : entry_not_interesting;
+	struct referred_objects *referred_buf;
 
 	init_tree_desc(&desc, tree->buffer, tree->size);
+	referred_buf = xmemdupz(referred_objs, sizeof(struct referred_objects));
+	object_list_insert(&tree->object, &referred_buf->trees);
 
 	while (tree_entry(&desc, &entry)) {
 		if (match != all_entries_interesting) {
@@ -132,7 +135,7 @@ static void process_tree_contents(struct traversal_context *ctx,
 				    entry.path, oid_to_hex(&tree->object.oid));
 			}
 			t->object.flags |= NOT_USER_GIVEN;
-			process_tree(ctx, t, base, entry.path, referred_commit);
+			process_tree(ctx, t, base, entry.path, referred_buf);
 		}
 		else if (S_ISGITLINK(entry.mode))
 			process_gitlink(ctx, entry.oid.hash,
@@ -145,16 +148,17 @@ static void process_tree_contents(struct traversal_context *ctx,
 				    entry.path, oid_to_hex(&tree->object.oid));
 			}
 			b->object.flags |= NOT_USER_GIVEN;
-			process_blob(ctx, b, base, entry.path, referred_commit);
+			process_blob(ctx, b, base, entry.path, referred_buf);
 		}
 	}
+	free(referred_buf);
 }
 
 static void process_tree(struct traversal_context *ctx,
 			 struct tree *tree,
 			 struct strbuf *base,
 			 const char *name,
-			 struct object *referred_commit)
+			 struct referred_objects *referred_objs)
 {
 	struct object *obj = &tree->object;
 	struct rev_info *revs = ctx->revs;
@@ -195,14 +199,14 @@ static void process_tree(struct traversal_context *ctx,
 	if (r & LOFR_MARK_SEEN)
 		obj->flags |= SEEN;
 	if (r & LOFR_DO_SHOW)
-		ctx->show_object(obj, base->buf, ctx->show_data, referred_commit);
+		ctx->show_object(obj, base->buf, ctx->show_data, referred_objs);
 	if (base->len)
 		strbuf_addch(base, '/');
 
 	if (r & LOFR_SKIP_TREE)
 		trace_printf("Skipping contents of tree %s...\n", base->buf);
 	else if (!failed_parse)
-		process_tree_contents(ctx, tree, base, referred_commit);
+		process_tree_contents(ctx, tree, base, referred_objs);
 
 	r = list_objects_filter__filter_object(ctx->revs->repo,
 					       LOFS_END_TREE, obj,
@@ -211,7 +215,7 @@ static void process_tree(struct traversal_context *ctx,
 	if (r & LOFR_MARK_SEEN)
 		obj->flags |= SEEN;
 	if (r & LOFR_DO_SHOW)
-		ctx->show_object(obj, base->buf, ctx->show_data, referred_commit);
+		ctx->show_object(obj, base->buf, ctx->show_data, referred_objs);
 
 	strbuf_setlen(base, baselen);
 	free_tree_buffer(tree);
@@ -333,24 +337,24 @@ static void traverse_trees_and_blobs(struct traversal_context *ctx,
 	for (i = 0; i < ctx->revs->pending.nr; i++) {
 		struct object_array_entry *pending = ctx->revs->pending.objects + i;
 		struct object *obj = pending->item;
-		struct object *referred_commit = pending->referred_commit;
+		struct referred_objects *referred_objs = pending->referred_objects;
 		const char *name = pending->name;
 		const char *path = pending->path;
 		if (obj->flags & (UNINTERESTING | SEEN))
 			continue;
 		if (obj->type == OBJ_TAG) {
 			obj->flags |= SEEN;
-			ctx->show_object(obj, name, ctx->show_data, referred_commit);
+			ctx->show_object(obj, name, ctx->show_data, referred_objs);
 			continue;
 		}
 		if (!path)
 			path = "";
 		if (obj->type == OBJ_TREE) {
-			process_tree(ctx, (struct tree *)obj, base, path, referred_commit);
+			process_tree(ctx, (struct tree *)obj, base, path, referred_objs);
 			continue;
 		}
 		if (obj->type == OBJ_BLOB) {
-			process_blob(ctx, (struct blob *)obj, base, path, referred_commit);
+			process_blob(ctx, (struct blob *)obj, base, path, referred_objs);
 			continue;
 		}
 		die("unknown pending object %s (%s)",
diff --git a/object.c b/object.c
index 6b1ce2fcde..69ba0baf95 100644
--- a/object.c
+++ b/object.c
@@ -331,6 +331,7 @@ void add_object_array_with_path_and_referred_commit(struct object *obj, const ch
 	unsigned alloc = array->alloc;
 	struct object_array_entry *objects = array->objects;
 	struct object_array_entry *entry;
+	struct referred_objects *referred_objs = xmalloc(sizeof(struct referred_objects));
 
 	if (nr >= alloc) {
 		alloc = (alloc + 32) * 2;
@@ -338,9 +339,11 @@ void add_object_array_with_path_and_referred_commit(struct object *obj, const ch
 		array->alloc = alloc;
 		array->objects = objects;
 	}
+	referred_objs->commit = referred_commit;
+	referred_objs->trees = NULL;
 	entry = &objects[nr];
 	entry->item = obj;
-	entry->referred_commit = referred_commit;
+	entry->referred_objects = referred_objs;
 	if (!name)
 		entry->name = NULL;
 	else if (!*name)
@@ -377,6 +380,7 @@ static void object_array_release_entry(struct object_array_entry *ent)
 	if (ent->name != object_array_slopbuf)
 		free(ent->name);
 	free(ent->path);
+	free(ent->referred_objects);
 }
 
 struct object *object_array_pop(struct object_array *array)
diff --git a/object.h b/object.h
index d63819ab91..3785546adf 100644
--- a/object.h
+++ b/object.h
@@ -52,12 +52,23 @@ struct object_array {
 		char *name;
 		char *path;
 		unsigned mode;
-		struct object *referred_commit;
+		 /*
+		 * referred_objects or NULL.  If non-NULL, it will
+		 * temporary storage the referred commit and trees when
+		 * traversing the specified object. Space for time,
+		 * reduce related computing costs (such as packfile-uri
+		 * exclusion), clean up when the traversal is over.
+		 */
+		struct referred_objects *referred_objects;
 	} *objects;
 };
 
 #define OBJECT_ARRAY_INIT { 0, 0, NULL }
 
+struct referred_objects{
+    struct object *commit;
+    struct object_list *trees;
+};
 /*
  * object flag allocation:
  * revision.h:               0---------10         15             23------26
-- 
2.31.1.449.gb2aa5456a8.dirty

