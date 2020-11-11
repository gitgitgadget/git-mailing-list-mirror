Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E633C388F9
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 19:44:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3AFC2087D
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 19:44:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="UwVYZLxI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727864AbgKKToY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Nov 2020 14:44:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727660AbgKKToW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Nov 2020 14:44:22 -0500
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15EF8C0613D1
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 11:44:22 -0800 (PST)
Received: by mail-qt1-x842.google.com with SMTP id v11so2159729qtq.12
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 11:44:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kNXQEb//1qY33cnwzPvcqXO19GELsXVnKcuW9OgoooY=;
        b=UwVYZLxIrXwlEw/Qaq9/meNHjsq8fjNoh7KW6vjIcsbjGMqjW95m1xCAN0ME1zkIP1
         ZE4tJvabF6dp6oS2p0FzNERIc45JdXuj6+LRXNKzRCz3AE00fcmxqBm0o4XvHPGYiOze
         XU81UB9JJEV0rUgVsYpl0xkNFotYu3ncYDgQ0hsSXjtzj5m8e7Gnm2lPW0vPvX9Elo2g
         AazxGf5UzNyvKUM3Hh8Q6KJKuJ4c1SWcMHHVgQzWWJ/3hWoKAjgtW0FPDX/rVxbgCJFz
         8cz6AZMJemwQpD3TzKQCf5eQfWQue4CHvq07JD5sOGrfjZZV7cktFl/ll6B9qOO4u83A
         KiFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kNXQEb//1qY33cnwzPvcqXO19GELsXVnKcuW9OgoooY=;
        b=BY3OsHNn77SpOrjynvgJmulcYwGi2pNhpa1dO4AiRBHL17xW5tealEoIgLXnxGwIDB
         GGu7FQtSOodiRgZpBZHHL/N4l9Cvqnb0eSHd3Rm3eucf0z02Qk12PsvLSqAIKCh/VEy1
         nfWGJ8cIIk7Mqbaxd6ayIx1MBRPqNnDQieW9n43NGobY/3DYwa6DX7x5HDgiTXwWUk+6
         cpUIkLL+HcD5kmirqBpscSmspL6SNLSdq1BiukJKXlQzrfV4QaaByeKten2TVQxzRClB
         6mKkNdWc9inAJdSDi2IJalvfZxsIDrBAN+4x5yfDFIdoHcP6A0nLhM/r0sTzpd2++vgs
         Y03A==
X-Gm-Message-State: AOAM532jUSIJFapS+6/mfF/m4DLAGQjkxL5QM4KMpXFph3JDrgGvMEKj
        SBCNRnTanwAXrSMZ8hDgQlQ2cFXwb6BnSxmV
X-Google-Smtp-Source: ABdhPJwtkid05INFExQgi8iwruGIP882/zF6SKE7HAX6tshOUhJfSIJnbYw7FnSZsy1nRyfHc4KmZw==
X-Received: by 2002:ac8:578a:: with SMTP id v10mr24639126qta.277.1605123860997;
        Wed, 11 Nov 2020 11:44:20 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:7ccc:9a51:1ad:2057])
        by smtp.gmail.com with ESMTPSA id o9sm3215946qte.35.2020.11.11.11.44.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 11:44:20 -0800 (PST)
Date:   Wed, 11 Nov 2020 14:44:18 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, peff@peff.net
Subject: [PATCH 21/23] pack-bitmap-write: use existing bitmaps
Message-ID: <3f8235180636ea6735302c6e415d406676282090.1605123653.git.me@ttaylorr.com>
References: <cover.1605123652.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1605123652.git.me@ttaylorr.com>
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
2.29.2.156.gc03786897f

