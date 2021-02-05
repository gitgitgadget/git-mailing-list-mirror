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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A81FC433E9
	for <git@archiver.kernel.org>; Fri,  5 Feb 2021 22:12:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DC6864FB4
	for <git@archiver.kernel.org>; Fri,  5 Feb 2021 22:12:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232756AbhBEWMA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Feb 2021 17:12:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232788AbhBEOkc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Feb 2021 09:40:32 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88DF2C06178C
        for <git@vger.kernel.org>; Fri,  5 Feb 2021 08:18:57 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id c127so6333313wmf.5
        for <git@vger.kernel.org>; Fri, 05 Feb 2021 08:18:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Cur1jwyThUvHjWQICFEilcRtaj5W7he6jefrT/ISo+0=;
        b=Pel3msMWP5GDa0bMitz9xo2ps/GwKw7TAnTk5Siea19XNWa4MvYxhiAfj9FlvjZUzc
         OSFSJuW8sjBrxrFDFG1iXFcKyZT0TqBKSS0jAGNkxGN1caUN0twinb7lhKgLErDz2eSN
         dF9vknvQgTuZHqLmDbnj5u4CM+M5kn2RKLcMvgjYrWjhRWazo8UX6emUh7CAxynQtv5r
         5GSoa3DVO3yMklKwd75Xogdwp78y1AiBJKMo1/B7mPV6x99B1M31+q/x9GmUkyU5tSqE
         PKMoVQwRoVD7A4X5zicfQtsv5x4YNuymufI+Q5NXKpZR/iCx9NNGJ+ePtYqHPeut2PYV
         IElA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Cur1jwyThUvHjWQICFEilcRtaj5W7he6jefrT/ISo+0=;
        b=G9/VcmZ7qNu9yjNkKTg69oOzMeqQOzCtzKJIhUtJgnbLal7qYaqsH2I71xB9XJX7As
         jvTjU936QHxd9EhUQfci3RNRT23YllBhOZ5VeYoiPBaWna+77IXlfVW7COvSAiW+z3JV
         vrrns3bZT4c6hNrEJw6L5yT2/A041NuYdrpxEEIclbBTOSpj2kw0CeGyz1OdfPpVS+xm
         Kh3qj9f/PsY4DUO2YdmoZXuEhGZCprSKVp0C9dahyWo72d0tYTrivZ8d1T08zscVpQZO
         bqsWjT8fut0EFZEonah8S6H+wS0mSJ0vDHe9gxLgdrb1A/rGdzb2Af43bU6ZEI78tUV6
         S8Sw==
X-Gm-Message-State: AOAM533kT/7Q/qdt4uxYt7TstfVfpxdbvf6pcHCmrlMLzMGY9gmgA6VP
        K6+lIdcJ+4IbZuEZD1eclH9OI76YSsU=
X-Google-Smtp-Source: ABdhPJxuj8MD3EBOl8QnUDRC1VUBiNx7wdoM3I5Pkp/x8wsrKExXVJD5+cwVdjUNKrYJm29npHpRKg==
X-Received: by 2002:a05:600c:1986:: with SMTP id t6mr3865559wmq.92.1612535461624;
        Fri, 05 Feb 2021 06:31:01 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c5sm12306702wrn.77.2021.02.05.06.31.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 06:31:01 -0800 (PST)
Message-Id: <b283a38fb775614280cb1330029aafcd8ae8dfe8.1612535453.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.848.v3.git.1612535452.gitgitgadget@gmail.com>
References: <pull.848.v2.git.1611759716.gitgitgadget@gmail.com>
        <pull.848.v3.git.1612535452.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 05 Feb 2021 14:30:42 +0000
Subject: [PATCH v3 07/17] midx: add pack_perm to write_midx_context
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, gitster@pobox.com, l.s.r@web.de,
        szeder.dev@gmail.com, Chris Torek <chris.torek@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
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
index 4520ef82b91b..cd994e333ecb 100644
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
+	struct write_midx_context *ctx = data;
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

