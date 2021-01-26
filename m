Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B807BC433DB
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 16:06:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F06E2220B
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 16:06:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404355AbhAZQGC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Jan 2021 11:06:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404602AbhAZQC7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jan 2021 11:02:59 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4961EC0698C1
        for <git@vger.kernel.org>; Tue, 26 Jan 2021 08:01:36 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id v15so17006847wrx.4
        for <git@vger.kernel.org>; Tue, 26 Jan 2021 08:01:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=kAGVOi9Eji1v1ZSuzjXUMHK+pCNbc5PVfTo1bOBO/M0=;
        b=tZ8772shu5bI5wxfiEVYh+wLBgUhqlzYeQSaSAdNlzwDwPb/pNAFIs1CID45R6N+uo
         /mVLdYVCB/kHMwPISDBMrbqypwrnb3YLM1gQv4AuMcMCjjnjttSTHyLcELSMX7n1bvD+
         LGxhLG51YL3TqRZjK4TnlPHl03C4pxXr7FBPkYbu0TwQjIq1wTWZzEXDbRdzmwiOT1eg
         KCwL41m8P93dBDdUOJSxAI1+ksCiSrUWy8xzCR6E8/aLgFmOYBPJ4MAmIh4kTcmQZ8w2
         CfaxShegPSK7gzxKniF+Z4NepvQ3qrKeReRL4NUBmw3BlgqIc5A7FjP2ZkLGBAaV89zN
         dn4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=kAGVOi9Eji1v1ZSuzjXUMHK+pCNbc5PVfTo1bOBO/M0=;
        b=N6b9wLleumBkm3ahs7bvSUBKSmW+1mks7panZCI6u+iz4e1P0fORa1VEYyqvFF2apL
         WWRUlp9lXdAv6gg7OQBREApkzHNKIV1C53tGk/z26NAhsxKtU9ah+4l6GArj0iCiWtP5
         GaBTXT097zgnQo6b8bZZI0tu/LSDHwEgbqbzNDEkmnDCuPhweV5Kt4T3VNldayyWesVu
         +1hYmWtd7qbFXHKwO5yCnRZUuz1v6cRc+cnL7PRulroI7ekotH7mq46sV+yBJc6jN7f9
         lSBYySYtf2WQ6dEFt3Sai5/aoehEvL/e8iMr+MsbjnYROIrQ8UamFTLPhdofxtlaCsIN
         rgtw==
X-Gm-Message-State: AOAM5325Jjft8XAwUo6UVeU4HHHE2t8Nh9UtPM978q6mstx9k26eT5Lk
        DDoUXUJHbHlYNY59OjYPBzK04v65uSE=
X-Google-Smtp-Source: ABdhPJyqB8WnI7IcovXXBoAdZLbulf2f/bBnQYQzA+jFJ5LEq2rrQZ56nbrR+7Jsi4vnjKM8nMWp7w==
X-Received: by 2002:adf:8464:: with SMTP id 91mr6641404wrf.188.1611676894765;
        Tue, 26 Jan 2021 08:01:34 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o12sm6848197wrx.82.2021.01.26.08.01.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 08:01:34 -0800 (PST)
Message-Id: <0b4ce3f1732a6b7297473ac3bae035f555a9268a.1611676886.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.848.git.1611676886.gitgitgadget@gmail.com>
References: <pull.848.git.1611676886.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 26 Jan 2021 16:01:16 +0000
Subject: [PATCH 07/17] midx: add pack_perm to write_midx_context
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, gitster@pobox.com, l.s.r@web.de,
        szeder.dev@gmail.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

In an effort to align write_midx_internal() with the chunk-format API,
continue to group necessary data into "struct write_midx_context". This
change collects the "uint32_t *pack_perm" and large_offsets_needed bit
into the context.

Update write_midx_object_offsets() to match chunk_write_fn.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 midx.c | 40 +++++++++++++++++++++-------------------
 1 file changed, 21 insertions(+), 19 deletions(-)

diff --git a/midx.c b/midx.c
index ee6f3504c6a..66feff096e8 100644
--- a/midx.c
+++ b/midx.c
@@ -461,6 +461,9 @@ struct write_midx_context {
 
 	struct pack_midx_entry *entries;
 	uint32_t entries_nr;
+
+	uint32_t *pack_perm;
+	unsigned large_offsets_needed:1;
 };
 
 static void add_pack_to_midx(const char *full_path, size_t full_path_len,
@@ -736,27 +739,27 @@ static size_t write_midx_oid_lookup(struct hashfile *f,
 	return written;
 }
 
-static size_t write_midx_object_offsets(struct hashfile *f, int large_offset_needed,
-					uint32_t *perm,
-					struct pack_midx_entry *objects, uint32_t nr_objects)
+static size_t write_midx_object_offsets(struct hashfile *f,
+					void *data)
 {
-	struct pack_midx_entry *list = objects;
+	struct write_midx_context *ctx = (struct write_midx_context *)data;
+	struct pack_midx_entry *list = ctx->entries;
 	uint32_t i, nr_large_offset = 0;
 	size_t written = 0;
 
-	for (i = 0; i < nr_objects; i++) {
+	for (i = 0; i < ctx->entries_nr; i++) {
 		struct pack_midx_entry *obj = list++;
 
-		if (perm[obj->pack_int_id] == PACK_EXPIRED)
+		if (ctx->pack_perm[obj->pack_int_id] == PACK_EXPIRED)
 			BUG("object %s is in an expired pack with int-id %d",
 			    oid_to_hex(&obj->oid),
 			    obj->pack_int_id);
 
-		hashwrite_be32(f, perm[obj->pack_int_id]);
+		hashwrite_be32(f, ctx->pack_perm[obj->pack_int_id]);
 
-		if (large_offset_needed && obj->offset >> 31)
+		if (ctx->large_offsets_needed && obj->offset >> 31)
 			hashwrite_be32(f, MIDX_LARGE_OFFSET_NEEDED | nr_large_offset++);
-		else if (!large_offset_needed && obj->offset >> 32)
+		else if (!ctx->large_offsets_needed && obj->offset >> 32)
 			BUG("object %s requires a large offset (%"PRIx64") but the MIDX is not writing large offsets!",
 			    oid_to_hex(&obj->oid),
 			    obj->offset);
@@ -805,13 +808,11 @@ static int write_midx_internal(const char *object_dir, struct multi_pack_index *
 	struct hashfile *f = NULL;
 	struct lock_file lk;
 	struct write_midx_context ctx = { 0 };
-	uint32_t *pack_perm = NULL;
 	uint64_t written = 0;
 	uint32_t chunk_ids[MIDX_MAX_CHUNKS + 1];
 	uint64_t chunk_offsets[MIDX_MAX_CHUNKS + 1];
 	uint32_t num_large_offsets = 0;
 	struct progress *progress = NULL;
-	int large_offsets_needed = 0;
 	int pack_name_concat_len = 0;
 	int dropped_packs = 0;
 	int result = 0;
@@ -857,11 +858,12 @@ static int write_midx_internal(const char *object_dir, struct multi_pack_index *
 
 	ctx.entries = get_sorted_entries(ctx.m, ctx.info, ctx.nr, &ctx.entries_nr);
 
+	ctx.large_offsets_needed = 0;
 	for (i = 0; i < ctx.entries_nr; i++) {
 		if (ctx.entries[i].offset > 0x7fffffff)
 			num_large_offsets++;
 		if (ctx.entries[i].offset > 0xffffffff)
-			large_offsets_needed = 1;
+			ctx.large_offsets_needed = 1;
 	}
 
 	QSORT(ctx.info, ctx.nr, pack_info_compare);
@@ -900,13 +902,13 @@ static int write_midx_internal(const char *object_dir, struct multi_pack_index *
 	 *
 	 * pack_perm[old_id] = new_id
 	 */
-	ALLOC_ARRAY(pack_perm, ctx.nr);
+	ALLOC_ARRAY(ctx.pack_perm, ctx.nr);
 	for (i = 0; i < ctx.nr; i++) {
 		if (ctx.info[i].expired) {
 			dropped_packs++;
-			pack_perm[ctx.info[i].orig_pack_int_id] = PACK_EXPIRED;
+			ctx.pack_perm[ctx.info[i].orig_pack_int_id] = PACK_EXPIRED;
 		} else {
-			pack_perm[ctx.info[i].orig_pack_int_id] = i - dropped_packs;
+			ctx.pack_perm[ctx.info[i].orig_pack_int_id] = i - dropped_packs;
 		}
 	}
 
@@ -927,7 +929,7 @@ static int write_midx_internal(const char *object_dir, struct multi_pack_index *
 		close_midx(ctx.m);
 
 	cur_chunk = 0;
-	num_chunks = large_offsets_needed ? 5 : 4;
+	num_chunks = ctx.large_offsets_needed ? 5 : 4;
 
 	if (ctx.nr - dropped_packs == 0) {
 		error(_("no pack files to index."));
@@ -954,7 +956,7 @@ static int write_midx_internal(const char *object_dir, struct multi_pack_index *
 
 	cur_chunk++;
 	chunk_offsets[cur_chunk] = chunk_offsets[cur_chunk - 1] + ctx.entries_nr * MIDX_CHUNK_OFFSET_WIDTH;
-	if (large_offsets_needed) {
+	if (ctx.large_offsets_needed) {
 		chunk_ids[cur_chunk] = MIDX_CHUNKID_LARGEOFFSETS;
 
 		cur_chunk++;
@@ -1004,7 +1006,7 @@ static int write_midx_internal(const char *object_dir, struct multi_pack_index *
 				break;
 
 			case MIDX_CHUNKID_OBJECTOFFSETS:
-				written += write_midx_object_offsets(f, large_offsets_needed, pack_perm, ctx.entries, ctx.entries_nr);
+				written += write_midx_object_offsets(f, &ctx);
 				break;
 
 			case MIDX_CHUNKID_LARGEOFFSETS:
@@ -1039,7 +1041,7 @@ static int write_midx_internal(const char *object_dir, struct multi_pack_index *
 
 	free(ctx.info);
 	free(ctx.entries);
-	free(pack_perm);
+	free(ctx.pack_perm);
 	free(midx_name);
 	return result;
 }
-- 
gitgitgadget

