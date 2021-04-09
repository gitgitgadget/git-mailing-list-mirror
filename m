Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEDC5C43460
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 18:10:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A992061007
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 18:10:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234512AbhDISLD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Apr 2021 14:11:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234499AbhDISLC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Apr 2021 14:11:02 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6084CC061764
        for <git@vger.kernel.org>; Fri,  9 Apr 2021 11:10:48 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id q26so6725174qkm.6
        for <git@vger.kernel.org>; Fri, 09 Apr 2021 11:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=R0zebXQCWK+dh07tKQkqnIsSb1QbSNRZWJ8lqTQRcPU=;
        b=l8IeaBXsKNP08/jY9NaN/c4hEp9V7vOHeorOhVXZMmihGK4Qbnkk1/wWh2RECHz+Qb
         14zstD6cKBR9PZM2ZVMLizKCsE0UdC6h81gNDkfQsnyutx/rVyZi/2DoX0iZFZOQhmhc
         +CiUwx7kVLyXymioiLCRbu73nupjbpVeT7S/RNVhAe8675YWyckRUMKbJ46bpl9jj3ht
         baSXz+MvMyGYKRhXRuNoqgB1Xr9mfAnd8CA4vmUSTzclzldSOn87G3sonue6iXyqC+jE
         mt7yZOq51nWAXEnLO1ADxl6HVkVU9b/6bVKwWSZzlDkOM2C4PzBMKw+TXuqhLnB7nMm/
         p1XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=R0zebXQCWK+dh07tKQkqnIsSb1QbSNRZWJ8lqTQRcPU=;
        b=lO0b95LeZELGUekMrta35DqHXAL6ruA0AY8uhGdr40qdk+qATvU7rP4DOQOO2yMd/D
         0Ihg7VVWPUJwa/JoirzQ1CRtE8HyhtxwI/Aq0jbhuv6CnbrO2CQZ2bU9lEPzNNUlVR1Y
         fdWh/vlE1YnNZ7up8dtvDjdapikY5QCz+/WgKUQL3QFr3csHyI1QAsLnCyJ+RAzfNox9
         JhCToHZwqfrKqD+pFu9lNlwlIEMpGzrIJwjEV4ocKBoBMoMzMK7jjFYmcG4TZPByilnV
         HrSHkHVOufGbYgfMtrFiI1WeElOQcCs2iO29+HRdc3Nv8OdAMSDTnZLA+MwMMRlH7CIW
         QNqw==
X-Gm-Message-State: AOAM530IEuE2Hd7mM59gBnp9g3v0w4RTF2yrxvQINyWan5Flu3QtgHjW
        7SWqSEOKY8hlCkkCZ1vW3O4Pt4H+Z7ThwD10
X-Google-Smtp-Source: ABdhPJzMDCiPBiwecReZn7xblvshOZAb2Go41AVYkaIPDXvYmTfUB+Aw2vQVAvHIsILBUNA2YC/IOw==
X-Received: by 2002:a37:43c2:: with SMTP id q185mr9085997qka.224.1617991847109;
        Fri, 09 Apr 2021 11:10:47 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:64f1:fbc0:31eb:386a])
        by smtp.gmail.com with ESMTPSA id 1sm2529863qtu.96.2021.04.09.11.10.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 11:10:46 -0700 (PDT)
Date:   Fri, 9 Apr 2021 14:10:44 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com
Subject: [PATCH 02/22] pack-bitmap-write.c: gracefully fail to write
 non-closed bitmaps
Message-ID: <d199954ef2246165f32a4f703d1e0ebf43847152.1617991824.git.me@ttaylorr.com>
References: <cover.1617991824.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1617991824.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The set of objects covered by a bitmap must be closed under
reachability, since it must be the case that there is a valid bit
position assigned for every possible reachable object (otherwise the
bitmaps would be incomplete).

Pack bitmaps are never written from 'git repack' unless repacking
all-into-one, and so we never write non-closed bitmaps.

But multi-pack bitmaps change this, since it isn't known whether the
set of objects in the MIDX is closed under reachability until walking
them. Plumb through a bit that is set when a reachable object isn't
found.

As soon as a reachable object isn't found in the set of objects to
include in the bitmap, bitmap_writer_build() knows that the set is not
closed, and so it now fails gracefully.

(The new conditional in builtin/pack-objects.c:bitmap_writer_build()
guards against other failure modes, but is never triggered here, because
of the all-into-one detail above. This return value will be important to
check from the multi-pack index caller.)

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/pack-objects.c |  3 +-
 pack-bitmap-write.c    | 76 +++++++++++++++++++++++++++++-------------
 pack-bitmap.h          |  2 +-
 3 files changed, 56 insertions(+), 25 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index a1e33d7507..5205dde2e1 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1116,7 +1116,8 @@ static void write_pack_file(void)
 
 				bitmap_writer_show_progress(progress);
 				bitmap_writer_select_commits(indexed_commits, indexed_commits_nr, -1);
-				bitmap_writer_build(&to_pack);
+				if (bitmap_writer_build(&to_pack) < 0)
+					die(_("failed to write bitmap index"));
 				bitmap_writer_finish(written_list, nr_written,
 						     tmpname.buf, write_bitmap_options);
 				write_bitmap_index = 0;
diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index 88d9e696a5..e829c46649 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -125,15 +125,20 @@ static inline void push_bitmapped_commit(struct commit *commit)
 	writer.selected_nr++;
 }
 
-static uint32_t find_object_pos(const struct object_id *oid)
+static uint32_t find_object_pos(const struct object_id *oid, int *found)
 {
 	struct object_entry *entry = packlist_find(writer.to_pack, oid);
 
 	if (!entry) {
-		die("Failed to write bitmap index. Packfile doesn't have full closure "
+		if (found)
+			*found = 0;
+		warning("Failed to write bitmap index. Packfile doesn't have full closure "
 			"(object %s is missing)", oid_to_hex(oid));
+		return 0;
 	}
 
+	if (found)
+		*found = 1;
 	return oe_in_pack_pos(writer.to_pack, entry);
 }
 
@@ -331,9 +336,10 @@ static void bitmap_builder_clear(struct bitmap_builder *bb)
 	bb->commits_nr = bb->commits_alloc = 0;
 }
 
-static void fill_bitmap_tree(struct bitmap *bitmap,
-			     struct tree *tree)
+static int fill_bitmap_tree(struct bitmap *bitmap,
+			    struct tree *tree)
 {
+	int found;
 	uint32_t pos;
 	struct tree_desc desc;
 	struct name_entry entry;
@@ -342,9 +348,11 @@ static void fill_bitmap_tree(struct bitmap *bitmap,
 	 * If our bit is already set, then there is nothing to do. Both this
 	 * tree and all of its children will be set.
 	 */
-	pos = find_object_pos(&tree->object.oid);
+	pos = find_object_pos(&tree->object.oid, &found);
+	if (!found)
+		return -1;
 	if (bitmap_get(bitmap, pos))
-		return;
+		return 0;
 	bitmap_set(bitmap, pos);
 
 	if (parse_tree(tree) < 0)
@@ -355,11 +363,15 @@ static void fill_bitmap_tree(struct bitmap *bitmap,
 	while (tree_entry(&desc, &entry)) {
 		switch (object_type(entry.mode)) {
 		case OBJ_TREE:
-			fill_bitmap_tree(bitmap,
-					 lookup_tree(the_repository, &entry.oid));
+			if (fill_bitmap_tree(bitmap,
+					     lookup_tree(the_repository, &entry.oid)) < 0)
+				return -1;
 			break;
 		case OBJ_BLOB:
-			bitmap_set(bitmap, find_object_pos(&entry.oid));
+			pos = find_object_pos(&entry.oid, &found);
+			if (!found)
+				return -1;
+			bitmap_set(bitmap, pos);
 			break;
 		default:
 			/* Gitlink, etc; not reachable */
@@ -368,15 +380,18 @@ static void fill_bitmap_tree(struct bitmap *bitmap,
 	}
 
 	free_tree_buffer(tree);
+	return 0;
 }
 
-static void fill_bitmap_commit(struct bb_commit *ent,
-			       struct commit *commit,
-			       struct prio_queue *queue,
-			       struct prio_queue *tree_queue,
-			       struct bitmap_index *old_bitmap,
-			       const uint32_t *mapping)
+static int fill_bitmap_commit(struct bb_commit *ent,
+			      struct commit *commit,
+			      struct prio_queue *queue,
+			      struct prio_queue *tree_queue,
+			      struct bitmap_index *old_bitmap,
+			      const uint32_t *mapping)
 {
+	int found;
+	uint32_t pos;
 	if (!ent->bitmap)
 		ent->bitmap = bitmap_new();
 
@@ -401,11 +416,16 @@ static void fill_bitmap_commit(struct bb_commit *ent,
 		 * Mark ourselves and queue our tree. The commit
 		 * walk ensures we cover all parents.
 		 */
-		bitmap_set(ent->bitmap, find_object_pos(&c->object.oid));
+		pos = find_object_pos(&c->object.oid, &found);
+		if (!found)
+			return -1;
+		bitmap_set(ent->bitmap, pos);
 		prio_queue_put(tree_queue, get_commit_tree(c));
 
 		for (p = c->parents; p; p = p->next) {
-			int pos = find_object_pos(&p->item->object.oid);
+			pos = find_object_pos(&p->item->object.oid, &found);
+			if (!found)
+				return -1;
 			if (!bitmap_get(ent->bitmap, pos)) {
 				bitmap_set(ent->bitmap, pos);
 				prio_queue_put(queue, p->item);
@@ -413,8 +433,12 @@ static void fill_bitmap_commit(struct bb_commit *ent,
 		}
 	}
 
-	while (tree_queue->nr)
-		fill_bitmap_tree(ent->bitmap, prio_queue_get(tree_queue));
+	while (tree_queue->nr) {
+		if (fill_bitmap_tree(ent->bitmap,
+				     prio_queue_get(tree_queue)) < 0)
+			return -1;
+	}
+	return 0;
 }
 
 static void store_selected(struct bb_commit *ent, struct commit *commit)
@@ -432,7 +456,7 @@ static void store_selected(struct bb_commit *ent, struct commit *commit)
 	kh_value(writer.bitmaps, hash_pos) = stored;
 }
 
-void bitmap_writer_build(struct packing_data *to_pack)
+int bitmap_writer_build(struct packing_data *to_pack)
 {
 	struct bitmap_builder bb;
 	size_t i;
@@ -441,6 +465,7 @@ void bitmap_writer_build(struct packing_data *to_pack)
 	struct prio_queue tree_queue = { NULL };
 	struct bitmap_index *old_bitmap;
 	uint32_t *mapping;
+	int closed = 1; /* until proven otherwise */
 
 	writer.bitmaps = kh_init_oid_map();
 	writer.to_pack = to_pack;
@@ -463,8 +488,11 @@ void bitmap_writer_build(struct packing_data *to_pack)
 		struct commit *child;
 		int reused = 0;
 
-		fill_bitmap_commit(ent, commit, &queue, &tree_queue,
-				   old_bitmap, mapping);
+		if (fill_bitmap_commit(ent, commit, &queue, &tree_queue,
+				       old_bitmap, mapping) < 0) {
+			closed = 0;
+			break;
+		}
 
 		if (ent->selected) {
 			store_selected(ent, commit);
@@ -499,7 +527,9 @@ void bitmap_writer_build(struct packing_data *to_pack)
 
 	stop_progress(&writer.progress);
 
-	compute_xor_offsets();
+	if (closed)
+		compute_xor_offsets();
+	return closed;
 }
 
 /**
diff --git a/pack-bitmap.h b/pack-bitmap.h
index 78f2b3ff79..988ed3a30d 100644
--- a/pack-bitmap.h
+++ b/pack-bitmap.h
@@ -86,7 +86,7 @@ struct ewah_bitmap *bitmap_for_commit(struct bitmap_index *bitmap_git,
 				      struct commit *commit);
 void bitmap_writer_select_commits(struct commit **indexed_commits,
 		unsigned int indexed_commits_nr, int max_bitmaps);
-void bitmap_writer_build(struct packing_data *to_pack);
+int bitmap_writer_build(struct packing_data *to_pack);
 void bitmap_writer_finish(struct pack_idx_entry **index,
 			  uint32_t index_nr,
 			  const char *filename,
-- 
2.31.1.163.ga65ce7f831

