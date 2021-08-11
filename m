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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03219C4320A
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 07:46:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D422560551
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 07:46:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235793AbhHKHqt (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Aug 2021 03:46:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235742AbhHKHqt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Aug 2021 03:46:49 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D4BCC061765
        for <git@vger.kernel.org>; Wed, 11 Aug 2021 00:46:26 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id j1so2058182pjv.3
        for <git@vger.kernel.org>; Wed, 11 Aug 2021 00:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2UAbfe/TMEC++Pc4RySHhz0Z658gOHq3pvhpkOBI/iY=;
        b=XUaNPgozapmq8al98bxbm/X3aJ6OhbZ/9PGN7NbsgcGmt7j3yLmd1vwSZGJsfpbWY0
         PJdwybf8lwHjONkwByGtAXZkbn1PUnAfFV0DtZ5cGKddcxYVL5yMLqOCxMvlJErGpyFF
         BuzYqmlHitblpTEsbxcAtDnwxeLNxN93eVO9AK21Za67Z9MiB+c7C+/PJNMJR7YDC54G
         1/Jfq2QrLXzcoXN+qEo1x4AvY5VH7m+8MW42ppmpSRojxKkfcMtSW0b8wE9R456CJmdQ
         sceo6AgFPiUqZnUJKzF/oht9H42M7Vi1OXYaEhv9rYAo9lLh8MeY+Ltt9XpTnLc+Yhgs
         r5Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2UAbfe/TMEC++Pc4RySHhz0Z658gOHq3pvhpkOBI/iY=;
        b=gg4gfqWaV/tzjnp++Gq3Zk3aKo3scU5oF/zFWygV52g1IwTzpGoTJezUxUPMpkVSWw
         8FSppbgB+6yIr7CLE8zV9OD/eccYCRkuMSkv1XaEvPlLrWiMC6UDOciEn5FEGNkHt2NY
         dUCp2eBJmv3IkZQNeBa1HaygQTNndk08SjG+6RRVUgssa1r+DJyGUU44y/THqRr+cD7K
         JFhX0qFuYe6rSKXrP7q4GZjgama2JligW6eD+CZVrs4Am71KqSCxM+yaP+ygSdrylv6o
         sPfFNl+fnw4fDvIUgOvQ59ZVkwZDAJK8EY4STwVs92Nyy3eoI4Lm5NbFDJQpiaq79tIA
         1pug==
X-Gm-Message-State: AOAM530NC4jPirwwxplbVCJMSwn/eCNjJDP6Yy+9JK0T88mH4fWdxOvP
        ZW+skQzLOEXlKRBA5XhOqMdbukA87HzQCQre
X-Google-Smtp-Source: ABdhPJytCsqQ6dC3tvuLXsy4s+5NTu5/DAsyJbNqe5v5tR3jwHrtTYO9EAVsCZjRV9H/QYNsJ4Ompg==
X-Received: by 2002:a17:90a:5502:: with SMTP id b2mr35337053pji.189.1628667985505;
        Wed, 11 Aug 2021 00:46:25 -0700 (PDT)
Received: from localhost.localdomain ([47.246.98.155])
        by smtp.gmail.com with ESMTPSA id u13sm26179672pfi.51.2021.08.11.00.46.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Aug 2021 00:46:25 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
To:     dyroneteng@gmail.com
Cc:     avarab@gmail.com, git@vger.kernel.org, jonathantanmy@google.com
Subject: [PATCH v4 3/7] packfile-uri: support for excluding commit objects
Date:   Wed, 11 Aug 2021 15:45:50 +0800
Message-Id: <f71b3108428b6ba36667e5e8a311ab8ab973d10c.1628666093.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.31.1.449.gb2aa5456a8.dirty
In-Reply-To: <cover.1628666093.git.dyroneteng@gmail.com>
References: <cover.1628666093.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently packfile-uri supports the exclusion of blob objects, but in
some scenarios, users may wish to exclude more types of objects, such as
commit and tree objects, not only because packfile itself supports
storing these object types, but also on the other hand, to make
configuration items maintainable and simpler.

This commit is used to support the recursive exclusion of a commit
object, which means that if the exclusion of a commit is configured as
packfile-uri, the commit itself and all the objects it contains will
also be recursively excluded. In addition, to support this feature, a
new configuration  `uploadpack.excludeobject` is introduced.

The reason for bringing a new configuration is for two considerations.
First, the old configuration supports a single object type (blob), which
limits the use of this feature. Secondly, the name of the old
configuration is not abstract enough, this make extension difficult. If
different object types use different configuration names, the
configuration items will be bloated and difficult to maintain, so the
new configuration is more abstract in name and easy to extend.

Although a new configuration has been introduced, the old one is
still available and compatible with the new configuration. The old
configuration `uploadpack.blobpackfileuri` only supports excluding
blobs. The new configuration `uploadpack.excludeobject` not only
supports excluding blob objects, but also supports excluding commit
objects, as well as recursively excluding tree objects and blob objects
they contain.

Signed-off-by: Teng Long <dyroneteng@gmail.com>
---
 builtin/pack-objects.c | 50 +++++++++++++++++++++++++-----------------
 list-objects.c         | 37 +++++++++++++++++--------------
 object.c               | 15 ++++++++++---
 object.h               |  4 +++-
 revision.c             | 34 ++++++++++++++++++++--------
 revision.h             |  3 +++
 upload-pack.c          |  7 ++++++
 7 files changed, 101 insertions(+), 49 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 5f9ec3566f..63f3aed70a 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1311,11 +1311,14 @@ static int want_object_in_pack_one(struct packed_git *p,
 static int want_object_in_pack(const struct object_id *oid,
 			       int exclude,
 			       struct packed_git **found_pack,
-			       off_t *found_offset)
+			       off_t *found_offset,
+			       struct object *referred_commit)
 {
 	int want;
 	struct list_head *pos;
 	struct multi_pack_index *m;
+	struct configured_exclusion *ex;
+	struct configured_exclusion *referred_ex;
 
 	if (!exclude && local && has_loose_object_nonlocal(oid))
 		return 0;
@@ -1351,9 +1354,13 @@ static int want_object_in_pack(const struct object_id *oid,
 	}
 
 	if (uri_protocols.nr) {
-		struct configured_exclusion *ex =
-			oidmap_get(&configured_exclusions, oid);
+		if (referred_commit) {
+			referred_ex = oidmap_get(&configured_exclusions, &referred_commit->oid);
+			if (referred_ex && match_packfile_uri_exclusions(referred_ex))
+				return 0;
+		}
 
+		ex = oidmap_get(&configured_exclusions, oid);
 		if (ex && match_packfile_uri_exclusions(ex)) {
 			oidset_insert(&excluded_by_config, oid);
 			return 0;
@@ -1393,7 +1400,8 @@ static const char no_closure_warning[] = N_(
 );
 
 static int add_object_entry(const struct object_id *oid, enum object_type type,
-			    const char *name, int exclude)
+			    const char *name, int exclude,
+			    struct object *referred_commit)
 {
 	struct packed_git *found_pack = NULL;
 	off_t found_offset = 0;
@@ -1403,7 +1411,7 @@ static int add_object_entry(const struct object_id *oid, enum object_type type,
 	if (have_duplicate_entry(oid, exclude))
 		return 0;
 
-	if (!want_object_in_pack(oid, exclude, &found_pack, &found_offset)) {
+	if (!want_object_in_pack(oid, exclude, &found_pack, &found_offset, referred_commit)) {
 		/* The pack is missing an object, so it will not have closure */
 		if (write_bitmap_index) {
 			if (write_bitmap_index != WRITE_BITMAP_QUIET)
@@ -1429,7 +1437,7 @@ static int add_object_entry_from_bitmap(const struct object_id *oid,
 	if (have_duplicate_entry(oid, 0))
 		return 0;
 
-	if (!want_object_in_pack(oid, 0, &pack, &offset))
+	if (!want_object_in_pack(oid, 0, &pack, &offset, NULL))
 		return 0;
 
 	create_object_entry(oid, type, name_hash, 0, 0, pack, offset);
@@ -1569,7 +1577,7 @@ static void add_pbase_object(struct tree_desc *tree,
 		if (name[cmplen] != '/') {
 			add_object_entry(&entry.oid,
 					 object_type(entry.mode),
-					 fullname, 1);
+					 fullname, 1, NULL);
 			return;
 		}
 		if (S_ISDIR(entry.mode)) {
@@ -1637,7 +1645,7 @@ static void add_preferred_base_object(const char *name)
 	cmplen = name_cmp_len(name);
 	for (it = pbase_tree; it; it = it->next) {
 		if (cmplen == 0) {
-			add_object_entry(&it->pcache.oid, OBJ_TREE, NULL, 1);
+			add_object_entry(&it->pcache.oid, OBJ_TREE, NULL, 1, NULL);
 		}
 		else {
 			struct tree_desc tree;
@@ -2839,7 +2847,7 @@ static void add_tag_chain(const struct object_id *oid)
 			die(_("unable to pack objects reachable from tag %s"),
 			    oid_to_hex(oid));
 
-		add_object_entry(&tag->object.oid, OBJ_TAG, NULL, 0);
+		add_object_entry(&tag->object.oid, OBJ_TAG, NULL, 0, NULL);
 
 		if (tag->tagged->type != OBJ_TAG)
 			return;
@@ -2994,7 +3002,7 @@ static int git_pack_config(const char *k, const char *v, void *cb)
 			pack_idx_opts.flags &= ~WRITE_REV;
 		return 0;
 	}
-	if (!strcmp(k, "uploadpack.blobpackfileuri")) {
+	if (!strcmp(k, "uploadpack.excludeobject") || !strcmp(k, "uploadpack.blobpackfileuri")) {
 		struct configured_exclusion *ex = xmalloc(sizeof(*ex));
 		const char *oid_end, *pack_end;
 		/*
@@ -3007,11 +3015,11 @@ static int git_pack_config(const char *k, const char *v, void *cb)
 		    *oid_end != ' ' ||
 		    parse_oid_hex(oid_end + 1, &pack_hash, &pack_end) ||
 		    *pack_end != ' ')
-			die(_("value of uploadpack.blobpackfileuri must be "
+			die(_("value of uploadpack.excludeobject or uploadpack.blobpackfileuri must be "
 			      "of the form '<object-hash> <pack-hash> <uri>' (got '%s')"), v);
 		if (oidmap_get(&configured_exclusions, &ex->e.oid))
-			die(_("object already configured in another "
-			      "uploadpack.blobpackfileuri (got '%s')"), v);
+			die(_("object already configured by an earlier "
+			      "uploadpack.excludeobject or uploadpack.blobpackfileuri (got '%s')"), v);
 		ex->pack_hash_hex = xcalloc(1, pack_end - oid_end);
 		memcpy(ex->pack_hash_hex, oid_end + 1, pack_end - oid_end - 1);
 		ex->uri = xstrdup(pack_end + 1);
@@ -3040,7 +3048,7 @@ static int add_object_entry_from_pack(const struct object_id *oid,
 		return 0;
 
 	ofs = nth_packed_object_offset(p, pos);
-	if (!want_object_in_pack(oid, 0, &p, &ofs))
+	if (!want_object_in_pack(oid, 0, &p, &ofs, NULL))
 		return 0;
 
 	oi.typep = &type;
@@ -3233,7 +3241,7 @@ static void read_object_list_from_stdin(void)
 			die(_("expected object ID, got garbage:\n %s"), line);
 
 		add_preferred_base_object(p + 1);
-		add_object_entry(&oid, OBJ_NONE, p + 1, 0);
+		add_object_entry(&oid, OBJ_NONE, p + 1, 0, NULL);
 	}
 }
 
@@ -3242,7 +3250,7 @@ static void read_object_list_from_stdin(void)
 
 static void show_commit(struct commit *commit, void *data)
 {
-	add_object_entry(&commit->object.oid, OBJ_COMMIT, NULL, 0);
+	add_object_entry(&commit->object.oid, OBJ_COMMIT, NULL, 0, NULL);
 	commit->object.flags |= OBJECT_ADDED;
 
 	if (write_bitmap_index)
@@ -3254,8 +3262,9 @@ static void show_commit(struct commit *commit, void *data)
 
 static void show_object(struct object *obj, const char *name, void *show_data, void *carry_data)
 {
+	struct object *referred_commit = carry_data;
 	add_preferred_base_object(name);
-	add_object_entry(&obj->oid, obj->type, name, 0);
+	add_object_entry(&obj->oid, obj->type, name, 0, referred_commit);
 	obj->flags |= OBJECT_ADDED;
 
 	if (use_delta_islands) {
@@ -3406,7 +3415,7 @@ static void add_objects_in_unpacked_packs(void)
 		QSORT(in_pack.array, in_pack.nr, ofscmp);
 		for (i = 0; i < in_pack.nr; i++) {
 			struct object *o = in_pack.array[i].object;
-			add_object_entry(&o->oid, o->type, "", 0);
+			add_object_entry(&o->oid, o->type, "", 0, NULL);
 		}
 	}
 	free(in_pack.array);
@@ -3422,7 +3431,7 @@ static int add_loose_object(const struct object_id *oid, const char *path,
 		return 0;
 	}
 
-	add_object_entry(oid, type, "", 0);
+	add_object_entry(oid, type, "", 0, NULL);
 	return 0;
 }
 
@@ -3841,7 +3850,8 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 			 N_("respect islands during delta compression")),
 		OPT_STRING_LIST(0, "uri-protocol", &uri_protocols,
 				N_("protocol"),
-				N_("exclude any configured uploadpack.blobpackfileuri with this protocol")),
+				N_("exclude any configured uploadpack.excludeobject or "
+				   "uploadpack.blobpackfileuri with this protocol")),
 		OPT_END(),
 	};
 
diff --git a/list-objects.c b/list-objects.c
index 427228a3ba..968d842ceb 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -24,7 +24,8 @@ struct traversal_context {
 static void process_blob(struct traversal_context *ctx,
 			 struct blob *blob,
 			 struct strbuf *path,
-			 const char *name)
+			 const char *name,
+			 struct object *referred_commit)
 {
 	struct object *obj = &blob->object;
 	size_t pathlen;
@@ -60,7 +61,7 @@ static void process_blob(struct traversal_context *ctx,
 	if (r & LOFR_MARK_SEEN)
 		obj->flags |= SEEN;
 	if (r & LOFR_DO_SHOW)
-		ctx->show_object(obj, path->buf, ctx->show_data, NULL);
+		ctx->show_object(obj, path->buf, ctx->show_data, referred_commit);
 	strbuf_setlen(path, pathlen);
 }
 
@@ -97,11 +98,13 @@ static void process_gitlink(struct traversal_context *ctx,
 static void process_tree(struct traversal_context *ctx,
 			 struct tree *tree,
 			 struct strbuf *base,
-			 const char *name);
+			 const char *name,
+			 struct object *referred_commit);
 
 static void process_tree_contents(struct traversal_context *ctx,
 				  struct tree *tree,
-				  struct strbuf *base)
+				  struct strbuf *base,
+				  struct object *referred_commit)
 {
 	struct tree_desc desc;
 	struct name_entry entry;
@@ -129,7 +132,7 @@ static void process_tree_contents(struct traversal_context *ctx,
 				    entry.path, oid_to_hex(&tree->object.oid));
 			}
 			t->object.flags |= NOT_USER_GIVEN;
-			process_tree(ctx, t, base, entry.path);
+			process_tree(ctx, t, base, entry.path, referred_commit);
 		}
 		else if (S_ISGITLINK(entry.mode))
 			process_gitlink(ctx, entry.oid.hash,
@@ -142,7 +145,7 @@ static void process_tree_contents(struct traversal_context *ctx,
 				    entry.path, oid_to_hex(&tree->object.oid));
 			}
 			b->object.flags |= NOT_USER_GIVEN;
-			process_blob(ctx, b, base, entry.path);
+			process_blob(ctx, b, base, entry.path, referred_commit);
 		}
 	}
 }
@@ -150,7 +153,8 @@ static void process_tree_contents(struct traversal_context *ctx,
 static void process_tree(struct traversal_context *ctx,
 			 struct tree *tree,
 			 struct strbuf *base,
-			 const char *name)
+			 const char *name,
+			 struct object *referred_commit)
 {
 	struct object *obj = &tree->object;
 	struct rev_info *revs = ctx->revs;
@@ -191,14 +195,14 @@ static void process_tree(struct traversal_context *ctx,
 	if (r & LOFR_MARK_SEEN)
 		obj->flags |= SEEN;
 	if (r & LOFR_DO_SHOW)
-		ctx->show_object(obj, base->buf, ctx->show_data, NULL);
+		ctx->show_object(obj, base->buf, ctx->show_data, referred_commit);
 	if (base->len)
 		strbuf_addch(base, '/');
 
 	if (r & LOFR_SKIP_TREE)
 		trace_printf("Skipping contents of tree %s...\n", base->buf);
 	else if (!failed_parse)
-		process_tree_contents(ctx, tree, base);
+		process_tree_contents(ctx, tree, base, referred_commit);
 
 	r = list_objects_filter__filter_object(ctx->revs->repo,
 					       LOFS_END_TREE, obj,
@@ -207,7 +211,7 @@ static void process_tree(struct traversal_context *ctx,
 	if (r & LOFR_MARK_SEEN)
 		obj->flags |= SEEN;
 	if (r & LOFR_DO_SHOW)
-		ctx->show_object(obj, base->buf, ctx->show_data, NULL);
+		ctx->show_object(obj, base->buf, ctx->show_data, referred_commit);
 
 	strbuf_setlen(base, baselen);
 	free_tree_buffer(tree);
@@ -314,9 +318,9 @@ void mark_edges_uninteresting(struct rev_info *revs,
 	}
 }
 
-static void add_pending_tree(struct rev_info *revs, struct tree *tree)
+static void add_pending_tree(struct rev_info *revs, struct tree *tree, struct object *referred_commit)
 {
-	add_pending_object(revs, &tree->object, "");
+	add_pending_object_with_referred_commit(revs, &tree->object, "", referred_commit);
 }
 
 static void traverse_trees_and_blobs(struct traversal_context *ctx,
@@ -329,23 +333,24 @@ static void traverse_trees_and_blobs(struct traversal_context *ctx,
 	for (i = 0; i < ctx->revs->pending.nr; i++) {
 		struct object_array_entry *pending = ctx->revs->pending.objects + i;
 		struct object *obj = pending->item;
+		struct object *referred_commit = pending->referred_commit;
 		const char *name = pending->name;
 		const char *path = pending->path;
 		if (obj->flags & (UNINTERESTING | SEEN))
 			continue;
 		if (obj->type == OBJ_TAG) {
 			obj->flags |= SEEN;
-			ctx->show_object(obj, name, ctx->show_data, NULL);
+			ctx->show_object(obj, name, ctx->show_data, referred_commit);
 			continue;
 		}
 		if (!path)
 			path = "";
 		if (obj->type == OBJ_TREE) {
-			process_tree(ctx, (struct tree *)obj, base, path);
+			process_tree(ctx, (struct tree *)obj, base, path, referred_commit);
 			continue;
 		}
 		if (obj->type == OBJ_BLOB) {
-			process_blob(ctx, (struct blob *)obj, base, path);
+			process_blob(ctx, (struct blob *)obj, base, path, referred_commit);
 			continue;
 		}
 		die("unknown pending object %s (%s)",
@@ -370,7 +375,7 @@ static void do_traverse(struct traversal_context *ctx)
 		else if (get_commit_tree(commit)) {
 			struct tree *tree = get_commit_tree(commit);
 			tree->object.flags |= NOT_USER_GIVEN;
-			add_pending_tree(ctx->revs, tree);
+			add_pending_tree(ctx->revs, tree, &commit->object);
 		} else if (commit->object.parsed) {
 			die(_("unable to load root tree for commit %s"),
 			      oid_to_hex(&commit->object.oid));
diff --git a/object.c b/object.c
index 14188453c5..6b1ce2fcde 100644
--- a/object.c
+++ b/object.c
@@ -322,9 +322,10 @@ void object_list_free(struct object_list **list)
  */
 static char object_array_slopbuf[1];
 
-void add_object_array_with_path(struct object *obj, const char *name,
-				struct object_array *array,
-				unsigned mode, const char *path)
+void add_object_array_with_path_and_referred_commit(struct object *obj, const char *name,
+						    struct object_array *array,
+						    unsigned mode, const char *path,
+						    struct object *referred_commit)
 {
 	unsigned nr = array->nr;
 	unsigned alloc = array->alloc;
@@ -339,6 +340,7 @@ void add_object_array_with_path(struct object *obj, const char *name,
 	}
 	entry = &objects[nr];
 	entry->item = obj;
+	entry->referred_commit = referred_commit;
 	if (!name)
 		entry->name = NULL;
 	else if (!*name)
@@ -354,6 +356,13 @@ void add_object_array_with_path(struct object *obj, const char *name,
 	array->nr = ++nr;
 }
 
+void add_object_array_with_path(struct object *obj, const char *name,
+				struct object_array *array,
+				unsigned mode, const char *path)
+{
+	add_object_array_with_path_and_referred_commit(obj, name, array, mode, path, NULL);
+}
+
 void add_object_array(struct object *obj, const char *name, struct object_array *array)
 {
 	add_object_array_with_path(obj, name, array, S_IFINVALID, NULL);
diff --git a/object.h b/object.h
index 87a6da47c8..d63819ab91 100644
--- a/object.h
+++ b/object.h
@@ -52,6 +52,7 @@ struct object_array {
 		char *name;
 		char *path;
 		unsigned mode;
+		struct object *referred_commit;
 	} *objects;
 };
 
@@ -157,7 +158,8 @@ void object_list_free(struct object_list **list);
 /* Object array handling .. */
 void add_object_array(struct object *obj, const char *name, struct object_array *array);
 void add_object_array_with_path(struct object *obj, const char *name, struct object_array *array, unsigned mode, const char *path);
-
+void add_object_array_with_path_and_referred_commit(struct object *obj, const char *name, struct object_array *array,
+						    unsigned mode, const char *path, struct object *referred_commit);
 /*
  * Returns NULL if the array is empty. Otherwise, returns the last object
  * after removing its entry from the array. Other resources associated
diff --git a/revision.c b/revision.c
index 4853c85d0b..65e0926d25 100644
--- a/revision.c
+++ b/revision.c
@@ -304,10 +304,11 @@ void mark_parents_uninteresting(struct commit *commit)
 	commit_stack_clear(&pending);
 }
 
-static void add_pending_object_with_path(struct rev_info *revs,
-					 struct object *obj,
-					 const char *name, unsigned mode,
-					 const char *path)
+static void add_pending_object_with_path_and_referred_commit(struct rev_info *revs,
+							     struct object *obj,
+							     const char *name, unsigned mode,
+							     const char *path,
+							     struct object *referred_commit)
 {
 	struct interpret_branch_name_options options = { 0 };
 	if (!obj)
@@ -326,20 +327,35 @@ static void add_pending_object_with_path(struct rev_info *revs,
 		strbuf_release(&buf);
 		return; /* do not add the commit itself */
 	}
-	add_object_array_with_path(obj, name, &revs->pending, mode, path);
+	add_object_array_with_path_and_referred_commit(obj, name, &revs->pending, mode, path, referred_commit);
 }
 
+static void add_pending_object_with_path(struct rev_info *revs,
+					 struct object *obj,
+					 const char *name, unsigned mode,
+					 const char *path)
+{
+	add_pending_object_with_path_and_referred_commit(revs, obj, name, mode, path, NULL);
+}
 static void add_pending_object_with_mode(struct rev_info *revs,
 					 struct object *obj,
-					 const char *name, unsigned mode)
+					 const char *name, unsigned mode,
+					 struct object *referred_commit)
+{
+	add_pending_object_with_path_and_referred_commit(revs, obj, name, mode, NULL, referred_commit);
+}
+
+void add_pending_object_with_referred_commit(struct rev_info *revs,
+					     struct object *obj, const char *name,
+					     struct object *referred_commit)
 {
-	add_pending_object_with_path(revs, obj, name, mode, NULL);
+	add_pending_object_with_mode(revs, obj, name, S_IFINVALID, referred_commit);
 }
 
 void add_pending_object(struct rev_info *revs,
 			struct object *obj, const char *name)
 {
-	add_pending_object_with_mode(revs, obj, name, S_IFINVALID);
+	add_pending_object_with_mode(revs, obj, name, S_IFINVALID, NULL);
 }
 
 void add_head_to_pending(struct rev_info *revs)
@@ -2817,7 +2833,7 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 		if (get_oid_with_context(revs->repo, revs->def, 0, &oid, &oc))
 			diagnose_missing_default(revs->def);
 		object = get_reference(revs, revs->def, &oid, 0);
-		add_pending_object_with_mode(revs, object, revs->def, oc.mode);
+		add_pending_object_with_mode(revs, object, revs->def, oc.mode, NULL);
 	}
 
 	/* Did the user ask for any diff output? Run the diff! */
diff --git a/revision.h b/revision.h
index a24f72dcd1..f9c9628ed8 100644
--- a/revision.h
+++ b/revision.h
@@ -423,6 +423,9 @@ void show_object_with_name(FILE *, struct object *, const char *);
  */
 void add_pending_object(struct rev_info *revs,
 			struct object *obj, const char *name);
+void add_pending_object_with_referred_commit(struct rev_info *revs,
+					     struct object *obj, const char *name,
+					     struct object *referred_commit);
 
 void add_pending_oid(struct rev_info *revs,
 		     const char *name, const struct object_id *oid,
diff --git a/upload-pack.c b/upload-pack.c
index 5c1cd19612..d26fb351a3 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -1751,6 +1751,13 @@ int upload_pack_advertise(struct repository *r,
 			strbuf_addstr(value, " packfile-uris");
 			free(str);
 		}
+
+		if (!repo_config_get_string(the_repository,
+					    "uploadpack.excludeobject",
+					    &str) && str) {
+			strbuf_addstr(value, " packfile-uris");
+			free(str);
+		}
 	}
 
 	return 1;
-- 
2.31.1.449.gb2aa5456a8.dirty

