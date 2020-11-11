Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DC37C5517A
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 19:43:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0807C2087D
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 19:43:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="z8tMN/3z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727805AbgKKTnS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Nov 2020 14:43:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726904AbgKKTnR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Nov 2020 14:43:17 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B5EDC0613D1
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 11:43:17 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id f93so2167054qtb.10
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 11:43:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DXAUWieoTNab9Z6/aRiTnGVEYxvjTtCtn6yRzBGlmbQ=;
        b=z8tMN/3znFOutfKRAuj0Ai3rsglpaPfi4JBbCUQb+Mdu45OS3W/o6tj+7ojittLO2a
         BhjEmPuufkqhbKTtzOAl0AfphIu4prqhDpPyMR4bIx6vhwq4h96QadJNFdWAgnKbYJx6
         SeB6VgIX1X4OJxRDcFSnceVU8aLzQqQJtYvHOdN6Kpe8YtPpvb35nVI1++G8KyO1wCrn
         yOz+ts0cGUo79aujGFUAMLZ43jk6HL192pTj27KE2el5mvzQsjUqhpQA5lLv4vJ3Ht5L
         u71XgELy2FW4WNVIeOKdW5B18It5+c2Zj4w/JijorM+jOHgAtaL8BZFDFCfUIpUueT6u
         z95Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DXAUWieoTNab9Z6/aRiTnGVEYxvjTtCtn6yRzBGlmbQ=;
        b=sJyqKkOKcMlrDB4n7PXDBWsNJHvvCC8IXrwuH/3GPsrTuO8UXXLoQlVDh9233Pfgti
         2OiQLqA053c/0eYlRXQ1+x+sCYaKiIgeF3U8Aama0cTQ1BG4k5LZ7y5GmLvrfN/0DtRW
         O9VnunKlUoZCCFRbMSZzrbTylMz6meja2pOlnr3Rjv0uCHhSu3vABz1cujT40dcw0SZ/
         ZIx3RSJwOLJpe4sbEwQK9CEeoad106icuq1shfqg8763NxtcOoVoonCE3kZPanryJ9ef
         Gk4gu41PaAvDwGXAakzKa6oJtxT6tt36KyFSirn0AtDkESEmJE7+ORlce/cmsTorHcOV
         /UTw==
X-Gm-Message-State: AOAM531ylDC7f/hqJAIXzFYMDOtNj9TRmEcj7Sw6WGv6t+Fxf0IFqoJ7
        b/e+7s7xOBPqjy5RF9MZkg7pZWrXth+LKS1l
X-Google-Smtp-Source: ABdhPJyzc/Q/5XNRn0xLDqUs4Q1S+T3x3hMnpdAXpEYOwRKJwl0eI7QFm1l5eOi73mGhnbDDxqSqAg==
X-Received: by 2002:ac8:6898:: with SMTP id m24mr25111028qtq.157.1605123795698;
        Wed, 11 Nov 2020 11:43:15 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:7ccc:9a51:1ad:2057])
        by smtp.gmail.com with ESMTPSA id i4sm2995640qtw.22.2020.11.11.11.43.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 11:43:15 -0800 (PST)
Date:   Wed, 11 Nov 2020 14:43:12 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, peff@peff.net
Subject: [PATCH 10/23] pack-bitmap-write: reimplement bitmap writing
Message-ID: <2f18d76cfd2c6ab3df7f4391aa824de1ad5f2d5f.1605123652.git.me@ttaylorr.com>
References: <cover.1605123652.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1605123652.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff King <peff@peff.net>

The bitmap generation code works by iterating over the set of commits
for which we plan to write bitmaps, and then for each one performing a
traditional traversal over the reachable commits and trees, filling in
the bitmap. Between two traversals, we can often reuse the previous
bitmap result as long as the first commit is an ancestor of the second.
However, our worst case is that we may end up doing "n" complete
complete traversals to the root in order to create "n" bitmaps.

In a real-world case (the shared-storage repo consisting of all GitHub
forks of chromium/chromium), we perform very poorly: generating bitmaps
takes ~3 hours, whereas we can walk the whole object graph in ~3
minutes.

This commit completely rewrites the algorithm, with the goal of
accessing each object only once. It works roughly like this:

  - generate a list of commits in topo-order using a single traversal

  - invert the edges of the graph (so have parents point at their
    children)

  - make one pass in reverse topo-order, generating a bitmap for each
    commit and passing the result along to child nodes

We generate correct results because each node we visit has already had
all of its ancestors added to the bitmap. And we make only two linear
passes over the commits.

We also visit each tree usually only once. When filling in a bitmap, we
don't bother to recurse into trees whose bit is already set in the
bitmap (since we know we've already done so when setting their bit).
That means that if commit A references tree T, none of its descendants
will need to open T again. I say "usually", though, because it is
possible for a given tree to be mentioned in unrelated parts of history
(e.g., cherry-picking to a parallel branch).

So we've accomplished our goal, and the resulting algorithm is pretty
simple to understand. But there are some downsides, at least with this
initial implementation:

  - we no longer reuse the results of any on-disk bitmaps when
    generating. So we'd expect to sometimes be slower than the original
    when bitmaps already exist. However, this is something we'll be able
    to add back in later.

  - we use much more memory. Instead of keeping one bitmap in memory at
    a time, we're passing them up through the graph. So our memory use
    should scale with the graph width (times the size of a bitmap).

So how does it perform?

For a clone of linux.git, generating bitmaps from scratch with the old
algorithm took 63s. Using this algorithm it takes 205s. Which is much
worse, but _might_ be acceptable if it behaved linearly as the size
grew. It also increases peak heap usage by ~1G. That's not impossibly
large, but not encouraging.

On the complete fork-network of torvalds/linux, it increases the peak
RAM usage by 40GB. Yikes. (I forgot to record the time it took, but the
memory usage was too much to consider this reasonable anyway).

On the complete fork-network of chromium/chromium, I ran out of memory
before succeeding. Some back-of-the-envelope calculations indicate it
would need 80+GB to complete.

So at this stage, we've managed to make things much worse. But because
of the way this new algorithm is structured, there are a lot of
opportunities for optimization on top. We'll start implementing those in
the follow-on patches.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-bitmap-write.c | 303 ++++++++++++++++++++++++--------------------
 1 file changed, 169 insertions(+), 134 deletions(-)

diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index 5e998bdaa7..f2f0b6b2c2 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -110,8 +110,6 @@ void bitmap_writer_build_type_index(struct packing_data *to_pack,
 /**
  * Compute the actual bitmaps
  */
-static struct object **seen_objects;
-static unsigned int seen_objects_nr, seen_objects_alloc;
 
 static inline void push_bitmapped_commit(struct commit *commit, struct ewah_bitmap *reused)
 {
@@ -127,21 +125,6 @@ static inline void push_bitmapped_commit(struct commit *commit, struct ewah_bitm
 	writer.selected_nr++;
 }
 
-static inline void mark_as_seen(struct object *object)
-{
-	ALLOC_GROW(seen_objects, seen_objects_nr + 1, seen_objects_alloc);
-	seen_objects[seen_objects_nr++] = object;
-}
-
-static inline void reset_all_seen(void)
-{
-	unsigned int i;
-	for (i = 0; i < seen_objects_nr; ++i) {
-		seen_objects[i]->flags &= ~(SEEN | ADDED | SHOWN);
-	}
-	seen_objects_nr = 0;
-}
-
 static uint32_t find_object_pos(const struct object_id *oid)
 {
 	struct object_entry *entry = packlist_find(writer.to_pack, oid);
@@ -154,60 +137,6 @@ static uint32_t find_object_pos(const struct object_id *oid)
 	return oe_in_pack_pos(writer.to_pack, entry);
 }
 
-static void show_object(struct object *object, const char *name, void *data)
-{
-	struct bitmap *base = data;
-	bitmap_set(base, find_object_pos(&object->oid));
-	mark_as_seen(object);
-}
-
-static void show_commit(struct commit *commit, void *data)
-{
-	mark_as_seen((struct object *)commit);
-}
-
-static int
-add_to_include_set(struct bitmap *base, struct commit *commit)
-{
-	khiter_t hash_pos;
-	uint32_t bitmap_pos = find_object_pos(&commit->object.oid);
-
-	if (bitmap_get(base, bitmap_pos))
-		return 0;
-
-	hash_pos = kh_get_oid_map(writer.bitmaps, commit->object.oid);
-	if (hash_pos < kh_end(writer.bitmaps)) {
-		struct bitmapped_commit *bc = kh_value(writer.bitmaps, hash_pos);
-		bitmap_or_ewah(base, bc->bitmap);
-		return 0;
-	}
-
-	bitmap_set(base, bitmap_pos);
-	return 1;
-}
-
-static int
-should_include(struct commit *commit, void *_data)
-{
-	struct bitmap *base = _data;
-
-	if (!add_to_include_set(base, commit)) {
-		struct commit_list *parent = commit->parents;
-
-		mark_as_seen((struct object *)commit);
-
-		while (parent) {
-			parent->item->object.flags |= SEEN;
-			mark_as_seen((struct object *)parent->item);
-			parent = parent->next;
-		}
-
-		return 0;
-	}
-
-	return 1;
-}
-
 static void compute_xor_offsets(void)
 {
 	static const int MAX_XOR_OFFSET_SEARCH = 10;
@@ -248,79 +177,185 @@ static void compute_xor_offsets(void)
 	}
 }
 
-void bitmap_writer_build(struct packing_data *to_pack)
+struct bb_commit {
+	struct commit_list *children;
+	struct bitmap *bitmap;
+	unsigned selected:1;
+	unsigned idx; /* within selected array */
+};
+
+define_commit_slab(bb_data, struct bb_commit);
+
+struct bitmap_builder {
+	struct bb_data data;
+	struct commit **commits;
+	size_t commits_nr, commits_alloc;
+};
+
+static void bitmap_builder_init(struct bitmap_builder *bb,
+				struct bitmap_writer *writer)
 {
-	static const double REUSE_BITMAP_THRESHOLD = 0.2;
-
-	int i, reuse_after, need_reset;
-	struct bitmap *base = bitmap_new();
 	struct rev_info revs;
+	struct commit *commit;
+	unsigned int i;
+
+	memset(bb, 0, sizeof(*bb));
+	init_bb_data(&bb->data);
+
+	reset_revision_walk();
+	repo_init_revisions(writer->to_pack->repo, &revs, NULL);
+	revs.topo_order = 1;
+
+	for (i = 0; i < writer->selected_nr; i++) {
+		struct commit *c = writer->selected[i].commit;
+		struct bb_commit *ent = bb_data_at(&bb->data, c);
+		ent->selected = 1;
+		ent->idx = i;
+		add_pending_object(&revs, &c->object, "");
+	}
+
+	if (prepare_revision_walk(&revs))
+		die("revision walk setup failed");
+
+	while ((commit = get_revision(&revs))) {
+		struct commit_list *p;
+
+		parse_commit_or_die(commit);
+
+		ALLOC_GROW(bb->commits, bb->commits_nr + 1, bb->commits_alloc);
+		bb->commits[bb->commits_nr++] = commit;
+
+		for (p = commit->parents; p; p = p->next) {
+			struct bb_commit *ent = bb_data_at(&bb->data, p->item);
+			commit_list_insert(commit, &ent->children);
+		}
+	}
+}
+
+static void bitmap_builder_clear(struct bitmap_builder *bb)
+{
+	clear_bb_data(&bb->data);
+	free(bb->commits);
+	bb->commits_nr = bb->commits_alloc = 0;
+}
+
+static void fill_bitmap_tree(struct bitmap *bitmap,
+			     struct tree *tree)
+{
+	uint32_t pos;
+	struct tree_desc desc;
+	struct name_entry entry;
+
+	/*
+	 * If our bit is already set, then there is nothing to do. Both this
+	 * tree and all of its children will be set.
+	 */
+	pos = find_object_pos(&tree->object.oid);
+	if (bitmap_get(bitmap, pos))
+		return;
+	bitmap_set(bitmap, pos);
+
+	if (parse_tree(tree) < 0)
+		die("unable to load tree object %s",
+		    oid_to_hex(&tree->object.oid));
+	init_tree_desc(&desc, tree->buffer, tree->size);
+
+	while (tree_entry(&desc, &entry)) {
+		switch (object_type(entry.mode)) {
+		case OBJ_TREE:
+			fill_bitmap_tree(bitmap,
+					 lookup_tree(the_repository, &entry.oid));
+			break;
+		case OBJ_BLOB:
+			bitmap_set(bitmap, find_object_pos(&entry.oid));
+			break;
+		default:
+			/* Gitlink, etc; not reachable */
+			break;
+		}
+	}
+
+	free_tree_buffer(tree);
+}
+
+static void fill_bitmap_commit(struct bb_commit *ent,
+			       struct commit *commit)
+{
+	if (!ent->bitmap)
+		ent->bitmap = bitmap_new();
+
+	/*
+	 * mark ourselves, but do not bother with parents; their values
+	 * will already have been propagated to us
+	 */
+	bitmap_set(ent->bitmap, find_object_pos(&commit->object.oid));
+	fill_bitmap_tree(ent->bitmap, get_commit_tree(commit));
+}
+
+static void store_selected(struct bb_commit *ent, struct commit *commit)
+{
+	struct bitmapped_commit *stored = &writer.selected[ent->idx];
+	khiter_t hash_pos;
+	int hash_ret;
+
+	/*
+	 * the "reuse bitmaps" phase may have stored something here, but
+	 * our new algorithm doesn't use it. Drop it.
+	 */
+	if (stored->bitmap)
+		ewah_free(stored->bitmap);
+
+	stored->bitmap = bitmap_to_ewah(ent->bitmap);
+
+	hash_pos = kh_put_oid_map(writer.bitmaps, commit->object.oid, &hash_ret);
+	if (hash_ret == 0)
+		die("Duplicate entry when writing index: %s",
+		    oid_to_hex(&commit->object.oid));
+	kh_value(writer.bitmaps, hash_pos) = stored;
+}
+
+void bitmap_writer_build(struct packing_data *to_pack)
+{
+	struct bitmap_builder bb;
+	size_t i;
+	int nr_stored = 0; /* for progress */
 
 	writer.bitmaps = kh_init_oid_map();
 	writer.to_pack = to_pack;
 
 	if (writer.show_progress)
 		writer.progress = start_progress("Building bitmaps", writer.selected_nr);
-
-	repo_init_revisions(to_pack->repo, &revs, NULL);
-	revs.tag_objects = 1;
-	revs.tree_objects = 1;
-	revs.blob_objects = 1;
-	revs.no_walk = 0;
-
-	revs.include_check = should_include;
-	reset_revision_walk();
-
-	reuse_after = writer.selected_nr * REUSE_BITMAP_THRESHOLD;
-	need_reset = 0;
-
-	for (i = writer.selected_nr - 1; i >= 0; --i) {
-		struct bitmapped_commit *stored;
-		struct object *object;
-
-		khiter_t hash_pos;
-		int hash_ret;
-
-		stored = &writer.selected[i];
-		object = (struct object *)stored->commit;
-
-		if (stored->bitmap == NULL) {
-			if (i < writer.selected_nr - 1 &&
-			    (need_reset ||
-			     !in_merge_bases(writer.selected[i + 1].commit,
-					     stored->commit))) {
-			    bitmap_reset(base);
-			    reset_all_seen();
-			}
-
-			add_pending_object(&revs, object, "");
-			revs.include_check_data = base;
-
-			if (prepare_revision_walk(&revs))
-				die("revision walk setup failed");
-
-			traverse_commit_list(&revs, show_commit, show_object, base);
-
-			object_array_clear(&revs.pending);
-
-			stored->bitmap = bitmap_to_ewah(base);
-			need_reset = 0;
-		} else
-			need_reset = 1;
-
-		if (i >= reuse_after)
-			stored->flags |= BITMAP_FLAG_REUSE;
-
-		hash_pos = kh_put_oid_map(writer.bitmaps, object->oid, &hash_ret);
-		if (hash_ret == 0)
-			die("Duplicate entry when writing index: %s",
-			    oid_to_hex(&object->oid));
-
-		kh_value(writer.bitmaps, hash_pos) = stored;
-		display_progress(writer.progress, writer.selected_nr - i);
+	trace2_region_enter("pack-bitmap-write", "building_bitmaps_total",
+		the_repository);
+
+	bitmap_builder_init(&bb, &writer);
+	for (i = bb.commits_nr; i > 0; i--) {
+		struct commit *commit = bb.commits[i-1];
+		struct bb_commit *ent = bb_data_at(&bb.data, commit);
+		struct commit *child;
+
+		fill_bitmap_commit(ent, commit);
+
+		if (ent->selected) {
+			store_selected(ent, commit);
+			nr_stored++;
+			display_progress(writer.progress, nr_stored);
+		}
+
+		while ((child = pop_commit(&ent->children))) {
+			struct bb_commit *child_ent =
+				bb_data_at(&bb.data, child);
+
+			if (child_ent->bitmap)
+				bitmap_or(child_ent->bitmap, ent->bitmap);
+			else
+				child_ent->bitmap = bitmap_dup(ent->bitmap);
+		}
+		bitmap_free(ent->bitmap);
+		ent->bitmap = NULL;
 	}
+	bitmap_builder_clear(&bb);
 
-	bitmap_free(base);
 	stop_progress(&writer.progress);
 
 	compute_xor_offsets();
-- 
2.29.2.156.gc03786897f

