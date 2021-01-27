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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 908E6C433E0
	for <git@archiver.kernel.org>; Wed, 27 Jan 2021 15:07:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DF822074D
	for <git@archiver.kernel.org>; Wed, 27 Jan 2021 15:07:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235582AbhA0PHH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Jan 2021 10:07:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235473AbhA0PDC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jan 2021 10:03:02 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9398BC061356
        for <git@vger.kernel.org>; Wed, 27 Jan 2021 07:02:07 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id u14so1944750wmq.4
        for <git@vger.kernel.org>; Wed, 27 Jan 2021 07:02:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=AneWd0085FrvtuS+ErolP0xonuFSYCHl+u0lEosnw9Y=;
        b=i7ziFPOiNEzvUQM3Q0SSTGRTItbLq8Fesb7iMnyT35j9ifC8FmQI8t6sxGafGe0Fi9
         bnHSIbo9I4DAKibFpUxD3kBpNVkd3ytkf9zk4wJW+rMak2HJUdqI7jBWyFAlzI/XoFnz
         65bmcVJDF5BNob19So9nrnGifHjx2gaxkXcA1hfO0h9PXi/2iNoixGPyaSgU5uET+H4Y
         LpvaIPc0Otdrrv5DZQBbFPkGf0evk/kpxJi6gHocDqhDHkf9aZN8lRX54QyFatFXRH+L
         wM6oA9zpmrWg9aJvSDcX7ZkXv3E4pIC4OoptWlYFul/AArV6+Ks/Pf73oHPE9UqqGFdu
         xJag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=AneWd0085FrvtuS+ErolP0xonuFSYCHl+u0lEosnw9Y=;
        b=i/5jadgXWxU4lMo8k8qNRLhMVQ04HoYShEoZdSGm/tC50iWSpePR7FS2HCfikCfjoI
         S4ReRPFU40MQ8/A9AwQ6p+oSy6KZw4m/+pho07RWUl8u4ZKx/aR3VvTzus++7ViUNDo3
         HLcfOVHGCaaT6NEMST7dEkDj3vpTRq1bKcyUvy5b6KUIhXAFHsg6DjHtNVR8jYA2oPMg
         dgnQNCpodOGRxhbDNR+ZII3L0nVnDeUrO8FdviIokuBt368B3CzdeMEhgEqld/5WJWBN
         bbTUAiHHacif25sSgNK2iMXseq3qC9P+0Gvm+kV8JtLGUnYUzybhfHedt96+WeEAV5kb
         mE+w==
X-Gm-Message-State: AOAM533mX7R1RZR1pPNvVZGcoABdbRHrIVBRSYM7JBc4FeSyTQZNCtzb
        k4mcQX0P+AqpsHBY/fnXxSEyo5ahYjo=
X-Google-Smtp-Source: ABdhPJyGPOYbNpXl6VgPN/8gv7JmCvaQt3vltCFGCc69N9GGXFKtgwbfOpWxYMT1Xc53RcbdCumfRQ==
X-Received: by 2002:a1c:4e:: with SMTP id 75mr4635957wma.150.1611759726138;
        Wed, 27 Jan 2021 07:02:06 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h16sm3258985wrq.29.2021.01.27.07.02.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jan 2021 07:02:05 -0800 (PST)
Message-Id: <2f1c496f3ab537820861fb8563b65f2c2fe15136.1611759716.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.848.v2.git.1611759716.gitgitgadget@gmail.com>
References: <pull.848.git.1611676886.gitgitgadget@gmail.com>
        <pull.848.v2.git.1611759716.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 27 Jan 2021 15:01:46 +0000
Subject: [PATCH v2 07/17] midx: add pack_perm to write_midx_context
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
index 4520ef82b91..cd994e333ec 100644
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

