Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F305C63697
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 21:48:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2A38241A7
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 21:48:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="mOWzHUGw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728579AbgKQVsb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Nov 2020 16:48:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727386AbgKQVsa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Nov 2020 16:48:30 -0500
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A866FC0613CF
        for <git@vger.kernel.org>; Tue, 17 Nov 2020 13:48:30 -0800 (PST)
Received: by mail-qt1-x843.google.com with SMTP id g15so17077641qtq.13
        for <git@vger.kernel.org>; Tue, 17 Nov 2020 13:48:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gualvIaBaGBiJTzE/Bia/VmJUrpSkpUb+YalyQUJ8XY=;
        b=mOWzHUGwE4CFJoBCQzj0qJ4lh1SsfLIcqyao9XWFkrN8m5aAyI2gCo5XIF7wpdCF5q
         5Ne+ToBPC08ygEXJxASTVmI2ostx9qSxw3iT6Rw9w4NhaKsweymNiDRAZPpJXLu0Y0dg
         r9zagL5AiHFzUmhPuv4oMaq9Hvg8AHFd1laZ3a8Ptsu0ZmP816Uk1rAum65HO42nbCQ0
         AhUzFVtMf3bBen9nRZYrV8R+m5Ybjy+bxWo3Vyy8U1Z/aeZaGe9s/BwXGC0BU85a6zuG
         /6w9yn8r6ZA9gBwvIketngZWbmaO0gILome6AEajpQhmArtZBwUNxAbA6KAg+MNES0Wf
         TDYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gualvIaBaGBiJTzE/Bia/VmJUrpSkpUb+YalyQUJ8XY=;
        b=t4A6jP2AupWRsCVP7t6qO2ZOiTse7RGtgGowIv0RnJXxwK51RPxJy3k3jupDsdMM0R
         rExXlKa9hgNC3bSoDUWEphBkBf92UW6T7+VDs/jcBJ2JcRtA4UHTRzCIaxxWKhh2cBNQ
         gMuqxcCU9FTcuPMQ0Wmg85+byhKgXg1G9CtP41bYTxUFJZMI3RskVtE08iCPPi/xeuPC
         oc5wSoPLSr95OL3lbCotuy7Tht/118K04FUbvZERsgIeewgX25/jn/nwmIBCuKxmfNCC
         Wt927fpvxuZ1T+qDxlW4SDz1Yt4sqRZnk3NjdJCWOWqonlkSpSzein0PCs11fCD0NlSC
         ls8Q==
X-Gm-Message-State: AOAM5323VJvXWhtwTG80WDvxAa2Ac4ZMdCXcZX7qbMMYwAvv+FKjC5SE
        VT1Ptrf5eCt2CiLDIWzXFtzYzgF0VNjIr7rL
X-Google-Smtp-Source: ABdhPJzEYnhzLMCavzfD/oBgFsm/B2MtNlussKHnNVdCSv/zHD7YgH32lN5ZsW/ak0165g1PPsKy0A==
X-Received: by 2002:ac8:4247:: with SMTP id r7mr1817306qtm.291.1605649709539;
        Tue, 17 Nov 2020 13:48:29 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:7fe5:c4d6:f587:dc1f])
        by smtp.gmail.com with ESMTPSA id d19sm4853014qtd.32.2020.11.17.13.48.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 13:48:28 -0800 (PST)
Date:   Tue, 17 Nov 2020 16:48:26 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, peff@peff.net,
        martin.agren@gmail.com, szeder.dev@gmail.com
Subject: [PATCH v2 22/24] pack-bitmap-write: use existing bitmaps
Message-ID: <4bf5e78a54dfdcbe13dd66ba4c5955a159ea181d.1605649533.git.me@ttaylorr.com>
References: <cover.1605123652.git.me@ttaylorr.com>
 <cover.1605649533.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1605649533.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

When constructing new bitmaps, we perform a commit and tree walk in
fill_bitmap_commit() and fill_bitmap_tree(). This walk would benefit
from using existing bitmaps when available. We must track the existing
bitmaps and translate them into the new object order, but this is
generally faster than parsing trees.

In fill_bitmap_commit(), we must reorder thing somewhat. The priority
queue walks commits from newest-to-oldest, which means we correctly stop
walking when reaching a commit with a bitmap. However, if we walk trees
from top to bottom, then we might be parsing trees that are actually
part of a re-used bitmap. To avoid over-walking trees, add them to a
LIFO queue and walk them from bottom-to-top after exploring commits
completely.

On git.git, this reduces a second immediate bitmap computation from 2.0s
to 1.0s. On linux.git, we go from 32s to 22s. On chromium's fork
network, we go from 227s to 198s.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-bitmap-write.c | 42 ++++++++++++++++++++++++++++++++++++++----
 1 file changed, 38 insertions(+), 4 deletions(-)

diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index 1995f75818..37204b691c 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -340,20 +340,39 @@ static void fill_bitmap_tree(struct bitmap *bitmap,
 
 static void fill_bitmap_commit(struct bb_commit *ent,
 			       struct commit *commit,
-			       struct prio_queue *queue)
+			       struct prio_queue *queue,
+			       struct prio_queue *tree_queue,
+			       struct bitmap_index *old_bitmap,
+			       const uint32_t *mapping)
 {
 	if (!ent->bitmap)
 		ent->bitmap = bitmap_new();
 
-	bitmap_set(ent->bitmap, find_object_pos(&commit->object.oid));
 	prio_queue_put(queue, commit);
 
 	while (queue->nr) {
 		struct commit_list *p;
 		struct commit *c = prio_queue_get(queue);
 
+		/*
+		 * If this commit has an old bitmap, then translate that
+		 * bitmap and add its bits to this one. No need to walk
+		 * parents or the tree for this commit.
+		 */
+		if (old_bitmap && mapping) {
+			struct ewah_bitmap *old;
+
+			old = bitmap_for_commit(old_bitmap, c);
+			if (old && !rebuild_bitmap(mapping, old, ent->bitmap))
+				continue;
+		}
+
+		/*
+		 * Mark ourselves and queue our tree. The commit
+		 * walk ensures we cover all parents.
+		 */
 		bitmap_set(ent->bitmap, find_object_pos(&c->object.oid));
-		fill_bitmap_tree(ent->bitmap, get_commit_tree(c));
+		prio_queue_put(tree_queue, get_commit_tree(c));
 
 		for (p = c->parents; p; p = p->next) {
 			int pos = find_object_pos(&p->item->object.oid);
@@ -363,6 +382,9 @@ static void fill_bitmap_commit(struct bb_commit *ent,
 			}
 		}
 	}
+
+	while (tree_queue->nr)
+		fill_bitmap_tree(ent->bitmap, prio_queue_get(tree_queue));
 }
 
 static void store_selected(struct bb_commit *ent, struct commit *commit)
@@ -386,6 +408,9 @@ void bitmap_writer_build(struct packing_data *to_pack)
 	size_t i;
 	int nr_stored = 0; /* for progress */
 	struct prio_queue queue = { compare_commits_by_gen_then_commit_date };
+	struct prio_queue tree_queue = { NULL };
+	struct bitmap_index *old_bitmap;
+	uint32_t *mapping;
 
 	writer.bitmaps = kh_init_oid_map();
 	writer.to_pack = to_pack;
@@ -395,6 +420,12 @@ void bitmap_writer_build(struct packing_data *to_pack)
 	trace2_region_enter("pack-bitmap-write", "building_bitmaps_total",
 		the_repository);
 
+	old_bitmap = prepare_bitmap_git(to_pack->repo);
+	if (old_bitmap)
+		mapping = create_bitmap_mapping(old_bitmap, to_pack);
+	else
+		mapping = NULL;
+
 	bitmap_builder_init(&bb, &writer);
 	for (i = bb.commits_nr; i > 0; i--) {
 		struct commit *commit = bb.commits[i-1];
@@ -402,7 +433,8 @@ void bitmap_writer_build(struct packing_data *to_pack)
 		struct commit *child;
 		int reused = 0;
 
-		fill_bitmap_commit(ent, commit, &queue);
+		fill_bitmap_commit(ent, commit, &queue, &tree_queue,
+				   old_bitmap, mapping);
 
 		if (ent->selected) {
 			store_selected(ent, commit);
@@ -428,7 +460,9 @@ void bitmap_writer_build(struct packing_data *to_pack)
 		ent->bitmap = NULL;
 	}
 	clear_prio_queue(&queue);
+	clear_prio_queue(&tree_queue);
 	bitmap_builder_clear(&bb);
+	free(mapping);
 
 	stop_progress(&writer.progress);
 
-- 
2.29.2.312.gabc4d358d8

