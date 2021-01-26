Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72FB0C433E0
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 16:07:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 382E7207B3
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 16:07:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404868AbhAZQGa (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Jan 2021 11:06:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404616AbhAZQC7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jan 2021 11:02:59 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51204C0698C2
        for <git@vger.kernel.org>; Tue, 26 Jan 2021 08:01:37 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id u14so3219430wmq.4
        for <git@vger.kernel.org>; Tue, 26 Jan 2021 08:01:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=SDf53TnuEVi5SZUAg22vP1yHKIDBDQSZUZC6stgTJ+Q=;
        b=tTW+CqggnwgJAdrQajTqsDwBdefKmh8XqfyQhmfRZMvBUgvEvxUT0OyIdrz2rbjnIV
         klC9NP+gH7LOBKnNgGf0dqaEbeOFRIbqHra8Byxfcev2S3GFc8noyn++2mA+EnIXQrmj
         3/+8xMWD3VTmz+pbsP6yEKSTX8xSm3TwTmtEkpZDi6kPY6cOOOBMc7Ps1pTdtYTzpYFV
         hVhF1u8GMwzoh8kKhFhyMTY9fuGIQTjz3B27hiMBlVLfqJFHj2sD/HXEhwziTHWuXmHP
         FjtPhAGg3EClL+pvJZkVlxB8wxVxpGoXVYC5Cq5W35lrBYJJ05tW+/IS/UP4xsSDFDSY
         3cRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=SDf53TnuEVi5SZUAg22vP1yHKIDBDQSZUZC6stgTJ+Q=;
        b=D5hcZz4exyLqsOrLMbKqas19ZFainwYvLP7P8iaHRZzIZDHy41qii4No9MUv36agDb
         L6F0wL0n7v1WrQ81wdqWyDGD70smzbhHfUwifkm8fjx88KoISkOtdzGxN5GIR5MRBKMD
         qOej481i/lNN+SR+ON5+2qhMgR9Ppu3AiqTDVtxLN5VlA4cnjJHC0kOIBrTQVEd87Ue+
         04nv3BR5kaStcW5ZzSKtcaGPAh8jX5J4Od/khBr6bbEcApKksVYaTbsryeo8jj5ZwIxf
         tsn6y/ovI9dpv7U226k/o4PFIj/fKSAHs+S+RUc1qQl4K3EIdWLhoh3z1ypt9HiteGcN
         JBWA==
X-Gm-Message-State: AOAM533FupJqiu4/WPmPsV8stve/iAWKFabT0yPz7jr09ByfVAzm6UQz
        /bpGAwZn82Y7LWnrkmuFUs2/2PVFDEA=
X-Google-Smtp-Source: ABdhPJzixmcOQxHRP15QSeqAIMot9ZVbCMP6svp6a3V9IlUZoJ1VYcWyVJlITX50fSr/IAppL1dNWQ==
X-Received: by 2002:a1c:7c06:: with SMTP id x6mr374018wmc.67.1611676895887;
        Tue, 26 Jan 2021 08:01:35 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j4sm18253603wru.20.2021.01.26.08.01.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 08:01:35 -0800 (PST)
Message-Id: <eabc7b736478e68c6e7d0af73df8e3e73e17bc34.1611676886.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.848.git.1611676886.gitgitgadget@gmail.com>
References: <pull.848.git.1611676886.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 26 Jan 2021 16:01:17 +0000
Subject: [PATCH 08/17] midx: add num_large_offsets to write_midx_context
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
change collects the "uint32_t num_large_offsets" into the context. With
this new data, write_midx_large_offsets() now matches the
chunk_write_fn type.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 midx.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/midx.c b/midx.c
index 66feff096e8..40b815f8877 100644
--- a/midx.c
+++ b/midx.c
@@ -464,6 +464,7 @@ struct write_midx_context {
 
 	uint32_t *pack_perm;
 	unsigned large_offsets_needed:1;
+	uint32_t num_large_offsets;
 };
 
 static void add_pack_to_midx(const char *full_path, size_t full_path_len,
@@ -772,11 +773,14 @@ static size_t write_midx_object_offsets(struct hashfile *f,
 	return written;
 }
 
-static size_t write_midx_large_offsets(struct hashfile *f, uint32_t nr_large_offset,
-				       struct pack_midx_entry *objects, uint32_t nr_objects)
+static size_t write_midx_large_offsets(struct hashfile *f,
+				       void *data)
 {
-	struct pack_midx_entry *list = objects, *end = objects + nr_objects;
+	struct write_midx_context *ctx = (struct write_midx_context *)data;
+	struct pack_midx_entry *list = ctx->entries;
+	struct pack_midx_entry *end = ctx->entries + ctx->entries_nr;
 	size_t written = 0;
+	uint32_t nr_large_offset = ctx->num_large_offsets;
 
 	while (nr_large_offset) {
 		struct pack_midx_entry *obj;
@@ -811,7 +815,6 @@ static int write_midx_internal(const char *object_dir, struct multi_pack_index *
 	uint64_t written = 0;
 	uint32_t chunk_ids[MIDX_MAX_CHUNKS + 1];
 	uint64_t chunk_offsets[MIDX_MAX_CHUNKS + 1];
-	uint32_t num_large_offsets = 0;
 	struct progress *progress = NULL;
 	int pack_name_concat_len = 0;
 	int dropped_packs = 0;
@@ -861,7 +864,7 @@ static int write_midx_internal(const char *object_dir, struct multi_pack_index *
 	ctx.large_offsets_needed = 0;
 	for (i = 0; i < ctx.entries_nr; i++) {
 		if (ctx.entries[i].offset > 0x7fffffff)
-			num_large_offsets++;
+			ctx.num_large_offsets++;
 		if (ctx.entries[i].offset > 0xffffffff)
 			ctx.large_offsets_needed = 1;
 	}
@@ -961,7 +964,7 @@ static int write_midx_internal(const char *object_dir, struct multi_pack_index *
 
 		cur_chunk++;
 		chunk_offsets[cur_chunk] = chunk_offsets[cur_chunk - 1] +
-					   num_large_offsets * MIDX_CHUNK_LARGE_OFFSET_WIDTH;
+					   ctx.num_large_offsets * MIDX_CHUNK_LARGE_OFFSET_WIDTH;
 	}
 
 	chunk_ids[cur_chunk] = 0;
@@ -1010,7 +1013,7 @@ static int write_midx_internal(const char *object_dir, struct multi_pack_index *
 				break;
 
 			case MIDX_CHUNKID_LARGEOFFSETS:
-				written += write_midx_large_offsets(f, num_large_offsets, ctx.entries, ctx.entries_nr);
+				written += write_midx_large_offsets(f, &ctx);
 				break;
 
 			default:
-- 
gitgitgadget

