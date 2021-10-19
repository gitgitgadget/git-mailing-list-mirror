Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DB11C433F5
	for <git@archiver.kernel.org>; Tue, 19 Oct 2021 11:40:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13C306137D
	for <git@archiver.kernel.org>; Tue, 19 Oct 2021 11:40:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235489AbhJSLmL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Oct 2021 07:42:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235498AbhJSLly (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Oct 2021 07:41:54 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D39DC06176D
        for <git@vger.kernel.org>; Tue, 19 Oct 2021 04:39:28 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id v20so13463455plo.7
        for <git@vger.kernel.org>; Tue, 19 Oct 2021 04:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mTjz36S2/kKRiYRHnpQKCD7edZZpLQNZ2bu0JLnEONg=;
        b=gRtUYtIxv/pDXYfNmgHq3wSBcdqu3NEBrwVwlvw10uM9JcLSfNtNb5PEQJJDKtxvZf
         CUskBYvRZonfps4UKZzjWhqslRtFu4J8Y8tn2R4drXbEL2NBMri5lcZnUaXLcJonLqF7
         aJzaWbs+wIXo78m6H1iiibeuU6yF4iESmxLhitoYFA2EB+Rsl6DqbNMJuAXovrmp9naf
         K6kqs27BMbtK0fZiUK35e9UertdAJQJpExSOx1kZbvDgAzrnirk6Qa46uCHPrIRNQXDW
         s/IlIpKTCcXzkxLcP9wgtRRbuZLj87KhtNoy0sil4k56KW5cr6NSOUDbcqYpdE+cHjlA
         q6ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mTjz36S2/kKRiYRHnpQKCD7edZZpLQNZ2bu0JLnEONg=;
        b=2z8C9H0rHIxvVrMMXbK5hchqTos66kz99wv9iSgvlpUPjaOAh6JhuJ3lmB2fJ8Ta4+
         iQAtRogwbLqSgDaJaMuCVFH/9JAU1KmjzAyED5sFiuneP0xHpQZcbW0fOyQa6gCkmCGg
         UJrleiT//fRb4KPLhO6VptRI/ezCb6yqiOtmA8EXg5C6nPlH3V7AoWhu+0oPHdA/Lqei
         K6iz2dL/kqN5rtQnC6THIZ53ThZiiOA973Ichs+8of8+6tcg/zFbsQ9OcP+iBxHmiB8w
         tzUC0YcjLIqjvF0SbAJB+CtV5z9edVtqmSWzJXkQg2dDHe93W6Oe+txVQllsXzZIqBGD
         RQrw==
X-Gm-Message-State: AOAM533TLuFM1FoURS72PYt09teOeJNgxSAc+ShpF+sV5RGjIug8Wir/
        Dnlnczpyr4kV4Ph5zgit7dglMMWlnyM=
X-Google-Smtp-Source: ABdhPJzwrqqGCeM4h+fX647MEZZidfRK1Ncn3BJsBVGeqzAW6T54nCUdBvX5MwI1KdA2pbZJKLrLVA==
X-Received: by 2002:a17:903:32c7:b0:13e:ea76:f8cb with SMTP id i7-20020a17090332c700b0013eea76f8cbmr32801966plr.74.1634643567235;
        Tue, 19 Oct 2021 04:39:27 -0700 (PDT)
Received: from localhost.localdomain ([205.204.117.96])
        by smtp.gmail.com with ESMTPSA id l207sm16430861pfd.199.2021.10.19.04.39.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Oct 2021 04:39:26 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong@alibaba-inc.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, avarab@gmail.com, jonathantanmy@google.com,
        bagasdotme@gmail.com, adlternative@gmail.com, stolee@gmail.com,
        Teng Long <dyroneteng@gmail.com>
Subject: [PATCH v6 06/12] packfile-uri: support for excluding commits
Date:   Tue, 19 Oct 2021 19:38:30 +0800
Message-Id: <c29efeac21a6770324a58488b0d53709778c83de.1634634814.git.tenglong@alibaba-inc.com>
X-Mailer: git-send-email 2.31.1.453.g945ddc3a74.dirty
In-Reply-To: <cover.1634634814.git.tenglong@alibaba-inc.com>
References: <cover.1634634814.git.tenglong@alibaba-inc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Teng Long <dyroneteng@gmail.com>

This commit work on the exlusion of commit objects, and the
Its excluding `level` can be configured as "ET_SELF", "ET_INCLUDE"
or "ET_REACHABLE".

Exclusion scope on different level:

1. When a commit is specified to be excluded with level "ET_SELF", only the
commit object itself will be excluded.

2. When it's specified to be excluded with level "ET_INCLUDE", exclude
all trees and blobs contained in its top-level tree, as well as the
commit itself.

3. When it is specified with level "ET_REACHABLE", exclude its
ancestors, as well as the objects need to be excluded under the level
"ET_INCLUDED".

Signed-off-by: Teng Long <dyroneteng@gmail.com>
---
 builtin/pack-objects.c | 83 +++++++++++++++++++++++++++++++++---------
 list-objects.c         | 37 +++++++++++--------
 object.c               | 19 ++++++++--
 object.h               | 14 ++++++-
 revision.c             | 34 ++++++++++++-----
 revision.h             |  3 ++
 6 files changed, 144 insertions(+), 46 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 75461483c0..e7b27ef443 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -36,6 +36,7 @@
 #include "trace2.h"
 #include "shallow.h"
 #include "promisor-remote.h"
+#include "commit-reach.h"
 
 #define IN_PACK(obj) oe_in_pack(&to_pack, obj)
 #define SIZE(obj) oe_size(&to_pack, obj)
@@ -1354,11 +1355,14 @@ static int want_object_in_pack_one(struct packed_git *p,
 static int want_object_in_pack(const struct object_id *oid,
 			       int exclude,
 			       struct packed_git **found_pack,
-			       off_t *found_offset)
+			       off_t *found_offset,
+			       struct referred_objects *referred_objs)
 {
 	int want;
 	struct list_head *pos;
 	struct multi_pack_index *m;
+	struct configured_exclusion *ex;
+	struct configured_exclusion *commit_ex;
 
 	if (!exclude && local && has_loose_object_nonlocal(oid))
 		return 0;
@@ -1394,9 +1398,16 @@ static int want_object_in_pack(const struct object_id *oid,
 	}
 
 	if (uri_protocols.nr) {
-		struct configured_exclusion *ex =
-			oidmap_get(&configured_exclusions, oid);
+		if (referred_objs) {
+			struct commit *commit = referred_objs->commit;
+			if (commit) {
+				commit_ex = oidmap_get(&configured_exclusions, &commit->object.oid);
+				if (match_packfile_uri_exclusions(commit_ex) && commit_ex->level > ET_SELF)
+					return 0;
+			}
+		}
 
+		ex = oidmap_get(&configured_exclusions, oid);
 		if (ex && match_packfile_uri_exclusions(ex)) {
 			oidset_insert(&excluded_by_config, oid);
 			return 0;
@@ -1436,7 +1447,8 @@ static const char no_closure_warning[] = N_(
 );
 
 static int add_object_entry(const struct object_id *oid, enum object_type type,
-			    const char *name, int exclude)
+			    const char *name, int exclude,
+			    struct referred_objects *referred_objs)
 {
 	struct packed_git *found_pack = NULL;
 	off_t found_offset = 0;
@@ -1446,7 +1458,7 @@ static int add_object_entry(const struct object_id *oid, enum object_type type,
 	if (have_duplicate_entry(oid, exclude))
 		return 0;
 
-	if (!want_object_in_pack(oid, exclude, &found_pack, &found_offset)) {
+	if (!want_object_in_pack(oid, exclude, &found_pack, &found_offset, referred_objs)) {
 		/* The pack is missing an object, so it will not have closure */
 		if (write_bitmap_index) {
 			if (write_bitmap_index != WRITE_BITMAP_QUIET)
@@ -1472,7 +1484,7 @@ static int add_object_entry_from_bitmap(const struct object_id *oid,
 	if (have_duplicate_entry(oid, 0))
 		return 0;
 
-	if (!want_object_in_pack(oid, 0, &pack, &offset))
+	if (!want_object_in_pack(oid, 0, &pack, &offset, NULL))
 		return 0;
 
 	create_object_entry(oid, type, name_hash, 0, 0, pack, offset);
@@ -1612,7 +1624,7 @@ static void add_pbase_object(struct tree_desc *tree,
 		if (name[cmplen] != '/') {
 			add_object_entry(&entry.oid,
 					 object_type(entry.mode),
-					 fullname, 1);
+					 fullname, 1, NULL);
 			return;
 		}
 		if (S_ISDIR(entry.mode)) {
@@ -1680,7 +1692,7 @@ static void add_preferred_base_object(const char *name)
 	cmplen = name_cmp_len(name);
 	for (it = pbase_tree; it; it = it->next) {
 		if (cmplen == 0) {
-			add_object_entry(&it->pcache.oid, OBJ_TREE, NULL, 1);
+			add_object_entry(&it->pcache.oid, OBJ_TREE, NULL, 1, NULL);
 		}
 		else {
 			struct tree_desc tree;
@@ -2882,7 +2894,7 @@ static void add_tag_chain(const struct object_id *oid)
 			die(_("unable to pack objects reachable from tag %s"),
 			    oid_to_hex(oid));
 
-		add_object_entry(&tag->object.oid, OBJ_TAG, NULL, 0);
+		add_object_entry(&tag->object.oid, OBJ_TAG, NULL, 0, NULL);
 
 		if (tag->tagged->type != OBJ_TAG)
 			return;
@@ -3050,8 +3062,6 @@ static int git_pack_config(const char *k, const char *v, void *cb)
 		    *oid_end != ' ' ||
 		    parse_oid_hex(oid_end + 1, &pack_hash, &pack_end) ||
 		    *pack_end != ' ')
-			die(_("value of uploadpack.blobpackfileuri must be "
-			      "of the form '<object-hash> <pack-hash> <uri>' (got '%s')"), v);
 		if (oidmap_get(&configured_exclusions, &ex->e.oid))
 			die(_("object already configured in another "
 			      "uploadpack.blobpackfileuri (got '%s')"), v);
@@ -3114,7 +3124,7 @@ static int add_object_entry_from_pack(const struct object_id *oid,
 		return 0;
 
 	ofs = nth_packed_object_offset(p, pos);
-	if (!want_object_in_pack(oid, 0, &p, &ofs))
+	if (!want_object_in_pack(oid, 0, &p, &ofs, NULL))
 		return 0;
 
 	oi.typep = &type;
@@ -3307,7 +3317,7 @@ static void read_object_list_from_stdin(void)
 			die(_("expected object ID, got garbage:\n %s"), line);
 
 		add_preferred_base_object(p + 1);
-		add_object_entry(&oid, OBJ_NONE, p + 1, 0);
+		add_object_entry(&oid, OBJ_NONE, p + 1, 0, NULL);
 	}
 }
 
@@ -3316,7 +3326,7 @@ static void read_object_list_from_stdin(void)
 
 static void show_commit(struct commit *commit, struct show_info *info)
 {
-	add_object_entry(&commit->object.oid, OBJ_COMMIT, NULL, 0);
+	add_object_entry(&commit->object.oid, OBJ_COMMIT, NULL, 0, NULL);
 	commit->object.flags |= OBJECT_ADDED;
 
 	if (write_bitmap_index)
@@ -3329,8 +3339,9 @@ static void show_commit(struct commit *commit, struct show_info *info)
 static void show_object(struct object *obj, const char *name,
 			struct show_info *info)
 {
+	struct referred_objects *referred_objs = info->show_cache;
 	add_preferred_base_object(name);
-	add_object_entry(&obj->oid, obj->type, name, 0);
+	add_object_entry(&obj->oid, obj->type, name, 0, referred_objs);
 	obj->flags |= OBJECT_ADDED;
 
 	if (use_delta_islands) {
@@ -3483,7 +3494,7 @@ static void add_objects_in_unpacked_packs(void)
 		QSORT(in_pack.array, in_pack.nr, ofscmp);
 		for (i = 0; i < in_pack.nr; i++) {
 			struct object *o = in_pack.array[i].object;
-			add_object_entry(&o->oid, o->type, "", 0);
+			add_object_entry(&o->oid, o->type, "", 0, NULL);
 		}
 	}
 	free(in_pack.array);
@@ -3499,7 +3510,7 @@ static int add_loose_object(const struct object_id *oid, const char *path,
 		return 0;
 	}
 
-	add_object_entry(oid, type, "", 0);
+	add_object_entry(oid, type, "", 0, NULL);
 	return 0;
 }
 
@@ -3665,6 +3676,42 @@ static void mark_bitmap_preferred_tips(void)
 	}
 }
 
+static void reuse_exclusion_packfile(struct rev_info *revs)
+{
+	struct commit *commit;
+	struct oidmap_iter iter;
+	struct configured_exclusion *ex;
+	struct object_id ex_oid;
+	struct commit *ex_commit;
+	struct commit_list *list = revs->commits;
+	struct commit_list *newlist = NULL;
+	struct commit_list **p = &newlist;
+
+	if (revs->limited)
+		return;
+	while (list) {
+		commit = pop_commit(&list);
+		if (commit_list_contains(commit, newlist)) {
+			continue;
+		}
+		p = commit_list_append(commit, p);
+		oidmap_iter_init(&configured_exclusions, &iter);
+		while ((ex = oidmap_iter_next(&iter)) && ex->level == ET_REACHABLE) {
+			ex_oid = ex->e.oid;
+			ex_commit = lookup_commit_reference(the_repository, &ex_oid);
+			if (!ex_commit)
+				die("Not a valid commit name %s", oid_to_hex(&ex_oid));
+			if (!in_merge_bases(ex_commit, commit))
+				continue;
+			oidset_insert(&excluded_by_config, &ex_oid);
+			ex_commit->object.flags |= UNINTERESTING;
+			p = commit_list_append(ex_commit, p);
+			break;
+		}
+	}
+	revs->commits = newlist;
+}
+
 static void get_object_list(int ac, const char **av)
 {
 	struct rev_info revs;
@@ -3726,6 +3773,8 @@ static void get_object_list(int ac, const char **av)
 		die(_("revision walk setup failed"));
 	mark_edges_uninteresting(&revs, show_edge, sparse);
 
+	reuse_exclusion_packfile(&revs);
+
 	if (!fn_show_object)
 		fn_show_object = show_object;
 	traverse_commit_list_filtered(&filter_options, &revs,
diff --git a/list-objects.c b/list-objects.c
index bffce67dd8..b32213ecf1 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -24,7 +24,8 @@ struct traversal_context {
 static void process_blob(struct traversal_context *ctx,
 			 struct blob *blob,
 			 struct strbuf *path,
-			 const char *name)
+			 const char *name,
+			 struct referred_objects *referred_obj)
 {
 	struct object *obj = &blob->object;
 	size_t pathlen;
@@ -32,7 +33,7 @@ static void process_blob(struct traversal_context *ctx,
 	struct show_info show_info;
 
 	show_info.show_data = ctx->show_data;
-	show_info.show_cache = NULL;
+	show_info.show_cache = referred_obj;
 
 	if (!ctx->revs->blob_objects)
 		return;
@@ -101,11 +102,13 @@ static void process_gitlink(struct traversal_context *ctx,
 static void process_tree(struct traversal_context *ctx,
 			 struct tree *tree,
 			 struct strbuf *base,
-			 const char *name);
+			 const char *name,
+			 struct referred_objects *referred_objs);
 
 static void process_tree_contents(struct traversal_context *ctx,
 				  struct tree *tree,
-				  struct strbuf *base)
+				  struct strbuf *base,
+				  struct referred_objects *referred_objs)
 {
 	struct tree_desc desc;
 	struct name_entry entry;
@@ -133,7 +136,7 @@ static void process_tree_contents(struct traversal_context *ctx,
 				    entry.path, oid_to_hex(&tree->object.oid));
 			}
 			t->object.flags |= NOT_USER_GIVEN;
-			process_tree(ctx, t, base, entry.path);
+			process_tree(ctx, t, base, entry.path, referred_objs);
 		}
 		else if (S_ISGITLINK(entry.mode))
 			process_gitlink(ctx, entry.oid.hash,
@@ -146,7 +149,7 @@ static void process_tree_contents(struct traversal_context *ctx,
 				    entry.path, oid_to_hex(&tree->object.oid));
 			}
 			b->object.flags |= NOT_USER_GIVEN;
-			process_blob(ctx, b, base, entry.path);
+			process_blob(ctx, b, base, entry.path, referred_objs);
 		}
 	}
 }
@@ -154,7 +157,8 @@ static void process_tree_contents(struct traversal_context *ctx,
 static void process_tree(struct traversal_context *ctx,
 			 struct tree *tree,
 			 struct strbuf *base,
-			 const char *name)
+			 const char *name,
+			 struct referred_objects *referred_objs)
 {
 	struct object *obj = &tree->object;
 	struct rev_info *revs = ctx->revs;
@@ -163,9 +167,6 @@ static void process_tree(struct traversal_context *ctx,
 	enum list_objects_filter_result r;
 	int failed_parse;
 
-	show_info.show_data = ctx->show_data;
-	show_info.show_cache = NULL;
-
 	if (!revs->tree_objects)
 		return;
 	if (!obj)
@@ -196,6 +197,9 @@ static void process_tree(struct traversal_context *ctx,
 					       LOFS_BEGIN_TREE, obj,
 					       base->buf, &base->buf[baselen],
 					       ctx->filter);
+	show_info.show_cache = referred_objs;
+	show_info.show_data = ctx->show_data;
+
 	if (r & LOFR_MARK_SEEN)
 		obj->flags |= SEEN;
 	if (r & LOFR_DO_SHOW)
@@ -206,7 +210,7 @@ static void process_tree(struct traversal_context *ctx,
 	if (r & LOFR_SKIP_TREE)
 		trace_printf("Skipping contents of tree %s...\n", base->buf);
 	else if (!failed_parse)
-		process_tree_contents(ctx, tree, base);
+		process_tree_contents(ctx, tree, base, referred_objs);
 
 	r = list_objects_filter__filter_object(ctx->revs->repo,
 					       LOFS_END_TREE, obj,
@@ -321,9 +325,9 @@ void mark_edges_uninteresting(struct rev_info *revs,
 	}
 }
 
-static void add_pending_tree(struct rev_info *revs, struct tree *tree)
+static void add_pending_tree(struct rev_info *revs, struct tree *tree, struct commit *referred_commit)
 {
-	add_pending_object(revs, &tree->object, "");
+	add_pending_object_with_referred_commit(revs, &tree->object, "", referred_commit);
 }
 
 static void traverse_trees_and_blobs(struct traversal_context *ctx,
@@ -340,6 +344,7 @@ static void traverse_trees_and_blobs(struct traversal_context *ctx,
 	for (i = 0; i < ctx->revs->pending.nr; i++) {
 		struct object_array_entry *pending = ctx->revs->pending.objects + i;
 		struct object *obj = pending->item;
+		struct referred_objects *referred_objs = pending->referred_objects;
 		const char *name = pending->name;
 		const char *path = pending->path;
 		if (obj->flags & (UNINTERESTING | SEEN))
@@ -352,11 +357,11 @@ static void traverse_trees_and_blobs(struct traversal_context *ctx,
 		if (!path)
 			path = "";
 		if (obj->type == OBJ_TREE) {
-			process_tree(ctx, (struct tree *)obj, base, path);
+			process_tree(ctx, (struct tree *)obj, base, path, referred_objs);
 			continue;
 		}
 		if (obj->type == OBJ_BLOB) {
-			process_blob(ctx, (struct blob *)obj, base, path);
+			process_blob(ctx, (struct blob *)obj, base, path, referred_objs);
 			continue;
 		}
 		die("unknown pending object %s (%s)",
@@ -386,7 +391,7 @@ static void do_traverse(struct traversal_context *ctx)
 		else if (get_commit_tree(commit)) {
 			struct tree *tree = get_commit_tree(commit);
 			tree->object.flags |= NOT_USER_GIVEN;
-			add_pending_tree(ctx->revs, tree);
+			add_pending_tree(ctx->revs, tree, commit);
 		} else if (commit->object.parsed) {
 			die(_("unable to load root tree for commit %s"),
 			      oid_to_hex(&commit->object.oid));
diff --git a/object.c b/object.c
index 14188453c5..f86b52c4d6 100644
--- a/object.c
+++ b/object.c
@@ -322,14 +322,18 @@ void object_list_free(struct object_list **list)
  */
 static char object_array_slopbuf[1];
 
-void add_object_array_with_path(struct object *obj, const char *name,
-				struct object_array *array,
-				unsigned mode, const char *path)
+void add_object_array_with_path_and_referred_commit(struct object *obj, const char *name,
+						    struct object_array *array,
+						    unsigned mode, const char *path,
+						    struct commit *referred_commit)
 {
 	unsigned nr = array->nr;
 	unsigned alloc = array->alloc;
 	struct object_array_entry *objects = array->objects;
 	struct object_array_entry *entry;
+	struct referred_objects *referred_objs;
+	referred_objs = xmalloc(sizeof(struct referred_objects));
+	referred_objs->commit = referred_commit;
 
 	if (nr >= alloc) {
 		alloc = (alloc + 32) * 2;
@@ -339,6 +343,7 @@ void add_object_array_with_path(struct object *obj, const char *name,
 	}
 	entry = &objects[nr];
 	entry->item = obj;
+	entry->referred_objects = referred_objs;
 	if (!name)
 		entry->name = NULL;
 	else if (!*name)
@@ -354,6 +359,13 @@ void add_object_array_with_path(struct object *obj, const char *name,
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
@@ -368,6 +380,7 @@ static void object_array_release_entry(struct object_array_entry *ent)
 	if (ent->name != object_array_slopbuf)
 		free(ent->name);
 	free(ent->path);
+	free(ent->referred_objects);
 }
 
 struct object *object_array_pop(struct object_array *array)
diff --git a/object.h b/object.h
index 87a6da47c8..4db0ecc3f2 100644
--- a/object.h
+++ b/object.h
@@ -52,9 +52,20 @@ struct object_array {
 		char *name;
 		char *path;
 		unsigned mode;
+		/*
+		* referred_objects or NULL.  If non-NULL, it will
+		* temporary storage the referred objects when
+		* traversing the specified object. Space for time,
+		* reduce related computing costs (such as packfile-uri
+		* exclusion), clean up when the traversal is over.
+		*/
+		struct referred_objects *referred_objects;
 	} *objects;
 };
 
+struct referred_objects{
+    struct commit *commit;
+};
 #define OBJECT_ARRAY_INIT { 0, 0, NULL }
 
 /*
@@ -157,7 +168,8 @@ void object_list_free(struct object_list **list);
 /* Object array handling .. */
 void add_object_array(struct object *obj, const char *name, struct object_array *array);
 void add_object_array_with_path(struct object *obj, const char *name, struct object_array *array, unsigned mode, const char *path);
-
+void add_object_array_with_path_and_referred_commit(struct object *obj, const char *name, struct object_array *array,
+						    unsigned mode, const char *path, struct commit *referred_commit);
 /*
  * Returns NULL if the array is empty. Otherwise, returns the last object
  * after removing its entry from the array. Other resources associated
diff --git a/revision.c b/revision.c
index 4853c85d0b..89a8b311ea 100644
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
+							     struct commit *referred_commit)
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
+					 struct commit *referred_commit)
+{
+	add_pending_object_with_path_and_referred_commit(revs, obj, name, mode, NULL, referred_commit);
+}
+
+void add_pending_object_with_referred_commit(struct rev_info *revs,
+					     struct object *obj, const char *name,
+					     struct commit *referred_commit)
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
index a24f72dcd1..b2e0c0b9b7 100644
--- a/revision.h
+++ b/revision.h
@@ -423,6 +423,9 @@ void show_object_with_name(FILE *, struct object *, const char *);
  */
 void add_pending_object(struct rev_info *revs,
 			struct object *obj, const char *name);
+void add_pending_object_with_referred_commit(struct rev_info *revs,
+					     struct object *obj, const char *name,
+					     struct commit *referred_commit);
 
 void add_pending_oid(struct rev_info *revs,
 		     const char *name, const struct object_id *oid,
-- 
2.31.1.453.g945ddc3a74.dirty

