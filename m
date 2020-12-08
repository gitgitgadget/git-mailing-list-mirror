Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 997E5C433FE
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 22:05:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66DFE23A7C
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 22:05:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730707AbgLHWEs (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Dec 2020 17:04:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730688AbgLHWEr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Dec 2020 17:04:47 -0500
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80BEFC0613CF
        for <git@vger.kernel.org>; Tue,  8 Dec 2020 14:04:07 -0800 (PST)
Received: by mail-ot1-x342.google.com with SMTP id j12so239297ota.7
        for <git@vger.kernel.org>; Tue, 08 Dec 2020 14:04:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=69NZYdya+y3fH6tvgWnX9Me1m2KxucJctZMIwxwOhUo=;
        b=Gbesx6Ne5RqUvPgXiK628oaB1N58cLluN+o668vf+L1zbAxdWHgMPy4JpNwolchzD2
         TF+8ixbIQ9+GxI+BboWFsb4Sav6mC4vbLxdrZEEBg2Z1rp8svyIBLYP2k9sdB4reI1Nr
         KWrAXpjA3jgYjN/vBXxUCKvbJNzJ+vx6nOv6i9h1zmMrlkPinBu3kR7Vn+aUwlI2k2ki
         88HxRarPj/hiQ3q92LlPdlS8yy9hnsKKAnTLMBGB2mgNKhPrHM2AZFt3a3kNh7U3UK9W
         hQ0PBUgvWCU7Tx45bcQGq/zJa/Urj/OinOOa+m/KO2qWYb+ueskphGd14MojozPcT9pb
         SIfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=69NZYdya+y3fH6tvgWnX9Me1m2KxucJctZMIwxwOhUo=;
        b=NH/om0x1pBIlsGnBe6+Efddg7WdPjKMOV/PmPMdpc7K61jrx+kQCqNq0olRF/StHtw
         Vc4Ea0jEHhNekLJiYQV6BwgnEKyGQO8Lddj1X2u13S7ZRIM4xwAqs8x4SmtCEfKfrhUX
         iYiAnXBtewb82JGoLF5EaxZ/COAJi5oTlNZrFzBaRV8KvVy0LiLh7eAXb6VyICCpyPhg
         qMusQ62z2XEtK6kXGwt2SaPIM1lkAbvJKfi7J4Q7cDbIQIjO6s4dmcEVpqMTa1rtD8Ux
         04+5ui9TqKW232LNipq+0iDOnMGOx0fGYZ8hBrYczJ3XON3EASR2J2Ga3efaJYyte3gj
         wBuw==
X-Gm-Message-State: AOAM530gJ4DhV4u8NgYdkaFhOi8clzSZPbt1Q89/ONPlk2KAsYErPds8
        uKYSA1KEXAG6sARcKeisBs9pmpaMg58qeHna
X-Google-Smtp-Source: ABdhPJx4fgZU/34EVAGXE8eTXYXbgwhNiqvvYCS8n6Zzfbo4TvadT0XQ6BSCmCZ8FjYlxKPKqCsfbQ==
X-Received: by 2002:a05:6830:1aec:: with SMTP id c12mr99930otd.337.1607465046660;
        Tue, 08 Dec 2020 14:04:06 -0800 (PST)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id p3sm22242otf.3.2020.12.08.14.04.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 14:04:06 -0800 (PST)
Date:   Tue, 8 Dec 2020 17:04:03 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, jonathantanmy@google.com, dstolee@microsoft.com,
        gitster@pobox.com
Subject: [PATCH v4 12/24] pack-bitmap-write: fill bitmap with commit history
Message-ID: <c466dda57646b636dd7c6071d9dfad9ea876022f.1607464775.git.me@ttaylorr.com>
References: <cover.1605123652.git.me@ttaylorr.com>
 <cover.1607464775.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1607464775.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The current implementation of bitmap_writer_build() creates a
reachability bitmap for every walked commit. After computing a bitmap
for a commit, those bits are pushed to an in-progress bitmap for its
children.

fill_bitmap_commit() assumes the bits corresponding to objects
reachable from the parents of a commit are already set. This means that
when visiting a new commit, we only have to walk the objects reachable
between it and any of its parents.

A future change to bitmap_writer_build() will relax this condition so
not all parents have their bits set. Prepare for that by having
'fill_bitmap_commit()' walk parents until reaching commits whose bits
are already set. Then, walk the trees for these commits as well.

This has no functional change with the current implementation of
bitmap_writer_build().

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-bitmap-write.c | 30 +++++++++++++++++++++++-------
 1 file changed, 23 insertions(+), 7 deletions(-)

diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index 1eb9615df8..957639241e 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -12,6 +12,7 @@
 #include "sha1-lookup.h"
 #include "pack-objects.h"
 #include "commit-reach.h"
+#include "prio-queue.h"
 
 struct bitmapped_commit {
 	struct commit *commit;
@@ -279,17 +280,30 @@ static void fill_bitmap_tree(struct bitmap *bitmap,
 }
 
 static void fill_bitmap_commit(struct bb_commit *ent,
-			       struct commit *commit)
+			       struct commit *commit,
+			       struct prio_queue *queue)
 {
 	if (!ent->bitmap)
 		ent->bitmap = bitmap_new();
 
-	/*
-	 * mark ourselves, but do not bother with parents; their values
-	 * will already have been propagated to us
-	 */
 	bitmap_set(ent->bitmap, find_object_pos(&commit->object.oid));
-	fill_bitmap_tree(ent->bitmap, get_commit_tree(commit));
+	prio_queue_put(queue, commit);
+
+	while (queue->nr) {
+		struct commit_list *p;
+		struct commit *c = prio_queue_get(queue);
+
+		bitmap_set(ent->bitmap, find_object_pos(&c->object.oid));
+		fill_bitmap_tree(ent->bitmap, get_commit_tree(c));
+
+		for (p = c->parents; p; p = p->next) {
+			int pos = find_object_pos(&p->item->object.oid);
+			if (!bitmap_get(ent->bitmap, pos)) {
+				bitmap_set(ent->bitmap, pos);
+				prio_queue_put(queue, p->item);
+			}
+		}
+	}
 }
 
 static void store_selected(struct bb_commit *ent, struct commit *commit)
@@ -319,6 +333,7 @@ void bitmap_writer_build(struct packing_data *to_pack)
 	struct bitmap_builder bb;
 	size_t i;
 	int nr_stored = 0; /* for progress */
+	struct prio_queue queue = { compare_commits_by_gen_then_commit_date };
 
 	writer.bitmaps = kh_init_oid_map();
 	writer.to_pack = to_pack;
@@ -335,7 +350,7 @@ void bitmap_writer_build(struct packing_data *to_pack)
 		struct commit *child;
 		int reused = 0;
 
-		fill_bitmap_commit(ent, commit);
+		fill_bitmap_commit(ent, commit, &queue);
 
 		if (ent->selected) {
 			store_selected(ent, commit);
@@ -360,6 +375,7 @@ void bitmap_writer_build(struct packing_data *to_pack)
 			bitmap_free(ent->bitmap);
 		ent->bitmap = NULL;
 	}
+	clear_prio_queue(&queue);
 	bitmap_builder_clear(&bb);
 
 	trace2_region_leave("pack-bitmap-write", "building_bitmaps_total",
-- 
2.29.2.533.g07db1f5344

