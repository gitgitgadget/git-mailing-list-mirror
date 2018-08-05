Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 27442208E9
	for <e@80x24.org>; Sun,  5 Aug 2018 17:25:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726745AbeHETbM (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 Aug 2018 15:31:12 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:53519 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726540AbeHETbL (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Aug 2018 15:31:11 -0400
Received: by mail-wm0-f68.google.com with SMTP id s9-v6so11457394wmh.3
        for <git@vger.kernel.org>; Sun, 05 Aug 2018 10:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SVpRjZ1MqFouUmiFLZok4GXWA5xnpfy0yotiMJpXPxo=;
        b=VemzwkE39uxQCagt4wOncAM2trLjFlJ9I9U7SUoLkKChY+dFhTHaOJMTa+8nZyykzE
         BDbQSmUZta6uXdWHmwy8fAmLEKRKsu2amZoFnV2Fsonzwkvs8acy/iQvL0izLOe6tFr9
         SDJuWsPcu65Z5eaRTQxApn2gvy7EJqwy77wG3XKY3ckg9eGO38LwXUu8DHuGTHwLviQH
         T+gFfiEvvpCi8+jBKgUCpgOw6ubugyxZve+OPQceLQ41NaOdPIhWVcSXh+fOrPkuD3Hy
         2ZQSAz8iPuwElLGEakECUinv5dYZO1e4mLsvXqnEyi53hbbErAIeqDwT5VsS3O3blioz
         Bing==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SVpRjZ1MqFouUmiFLZok4GXWA5xnpfy0yotiMJpXPxo=;
        b=Al4FEJaHYVp2NDRQFDWUY1WdydrhPYyCukv+M3Q+OqWnM5afQIncx4P1LRNByQSLX6
         Wg28fsy+gsnQyNWOOL0ta8eXE+R9wjMpuEiYOpF5edQzACael1UB+40+e9BQfV0WA3Z0
         s+0xuiuyCR5oNoH4yxvE9NDNkezoQ7/8DCJCh8AtLZo73nzWHIMWO1kEOUZc3WvFp76Y
         dy9XPeYmBvBJj197cOyev+SE5mJIbBMH/XkSWU2SGVkQwwe4cc5Hy2IX+SVTN9iVKRix
         7EGFsXaZSWH5kZ4SJyNGOyf8QCVlawQ0d2NNYU0fd+nP5pJCGTg5DSzFv4IsE++yKc7o
         I/uQ==
X-Gm-Message-State: AOUpUlHsvqQSk6CRtelThCeejqjUD1YMb8oykYTxmXy1zxSXbe18+TCo
        FLZrdsO5vCoQIUSSOzzNDa0z8fXQ
X-Google-Smtp-Source: AAOMgpeWvzDz9nPMxFfMD/CTaQQW0RVmATPCXsRejjAcPMsKUmT0xvXcv9LWW7MHmLBCD7giYriI9Q==
X-Received: by 2002:a1c:3413:: with SMTP id b19-v6mr10276543wma.21.1533489952194;
        Sun, 05 Aug 2018 10:25:52 -0700 (PDT)
Received: from localhost.localdomain (89-95-107-230.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id x62-v6sm7523228wmg.1.2018.08.05.10.25.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 05 Aug 2018 10:25:51 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Stefan Beller <sbeller@google.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 6/6] pack-objects: move tree_depth into 'struct packing_data'
Date:   Sun,  5 Aug 2018 19:25:25 +0200
Message-Id: <20180805172525.15278-7-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.18.0.327.ga7d188ab43
In-Reply-To: <20180805172525.15278-1-chriscool@tuxfamily.org>
References: <20180805172525.15278-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This reduces the size of 'struct object_entry' and therefore
makes packing objects more efficient.

This also renames cmp_tree_depth() into tree_depth_compare(),
as it is more modern to have the name of the compare functions
end with "compare".

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/pack-objects.c | 20 ++++++++++++++++----
 delta-islands.c        | 27 ++++++++++++++++++---------
 pack-objects.h         |  4 +++-
 3 files changed, 37 insertions(+), 14 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 3d09742d91..da6dbb22d2 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -2707,14 +2707,26 @@ static void show_object(struct object *obj, const char *name, void *data)
 	if (use_delta_islands) {
 		const char *p;
 		unsigned depth = 0;
-		struct object_entry *ent;
+		uint32_t index_pos;
 
 		for (p = strchr(name, '/'); p; p = strchr(p + 1, '/'))
 			depth++;
 
-		ent = packlist_find(&to_pack, obj->oid.hash, NULL);
-		if (ent && depth > ent->tree_depth)
-			ent->tree_depth = depth;
+		if (!to_pack.tree_depth) {
+			to_pack.tree_depth = xcalloc(to_pack.nr_alloc, sizeof(*to_pack.tree_depth));
+			to_pack.tree_depth_size = to_pack.nr_alloc;
+		} else if (to_pack.nr_objects > to_pack.tree_depth_size) {
+			REALLOC_ARRAY(to_pack.tree_depth, to_pack.nr_alloc);
+			memset(to_pack.tree_depth + to_pack.tree_depth_size, 0,
+			       (to_pack.nr_alloc - to_pack.tree_depth_size) * sizeof(*to_pack.tree_depth));
+			to_pack.tree_depth_size = to_pack.nr_alloc;
+		}
+
+		if (packlist_find(&to_pack, obj->oid.hash, &index_pos)) {
+			uint32_t i = to_pack.index[index_pos] - 1;
+			if (depth > to_pack.tree_depth[i])
+				to_pack.tree_depth[i] = depth;
+		}
 	}
 }
 
diff --git a/delta-islands.c b/delta-islands.c
index f7902a64ad..e8e6ce3dc4 100644
--- a/delta-islands.c
+++ b/delta-islands.c
@@ -224,17 +224,23 @@ static void mark_remote_island_1(struct remote_island *rl, int is_core_island)
 	island_counter++;
 }
 
-static int cmp_tree_depth(const void *va, const void *vb)
+struct tree_islands_todo {
+	struct object_entry *entry;
+	unsigned int depth;
+};
+
+static int tree_depth_compare(const void *a, const void *b)
 {
-	struct object_entry *a = *(struct object_entry **)va;
-	struct object_entry *b = *(struct object_entry **)vb;
-	return a->tree_depth - b->tree_depth;
+	const struct tree_islands_todo *todo_a = a;
+	const struct tree_islands_todo *todo_b = b;
+
+	return todo_a->depth - todo_b->depth;
 }
 
 void resolve_tree_islands(int progress, struct packing_data *to_pack)
 {
 	struct progress *progress_state = NULL;
-	struct object_entry **todo;
+	struct tree_islands_todo *todo;
 	int nr = 0;
 	int i;
 
@@ -250,16 +256,19 @@ void resolve_tree_islands(int progress, struct packing_data *to_pack)
 	 */
 	ALLOC_ARRAY(todo, to_pack->nr_objects);
 	for (i = 0; i < to_pack->nr_objects; i++) {
-		if (oe_type(&to_pack->objects[i]) == OBJ_TREE)
-			todo[nr++] = &to_pack->objects[i];
+		if (oe_type(&to_pack->objects[i]) == OBJ_TREE) {
+			todo[nr].entry = &to_pack->objects[i];
+			todo[nr].depth = to_pack->tree_depth[i];
+			nr++;
+		}
 	}
-	QSORT(todo, nr, cmp_tree_depth);
+	QSORT(todo, nr, tree_depth_compare);
 
 	if (progress)
 		progress_state = start_progress(_("Propagating island marks"), nr);
 
 	for (i = 0; i < nr; i++) {
-		struct object_entry *ent = todo[i];
+		struct object_entry *ent = todo[i].entry;
 		struct island_bitmap *root_marks;
 		struct tree *tree;
 		struct tree_desc desc;
diff --git a/pack-objects.h b/pack-objects.h
index 8eecd67991..522b09a31e 100644
--- a/pack-objects.h
+++ b/pack-objects.h
@@ -101,7 +101,6 @@ struct object_entry {
 	unsigned no_try_delta:1;
 	unsigned in_pack_type:TYPE_BITS; /* could be delta */
 
-	unsigned int tree_depth; /* should be repositioned for packing? */
 	unsigned char layer;
 
 	unsigned preferred_base:1; /*
@@ -145,6 +144,9 @@ struct packing_data {
 	struct packed_git **in_pack;
 
 	uintmax_t oe_size_limit;
+
+	unsigned int *tree_depth;
+	uint32_t tree_depth_size;
 };
 
 void prepare_packing_data(struct packing_data *pdata);
-- 
2.18.0.327.ga7d188ab43

