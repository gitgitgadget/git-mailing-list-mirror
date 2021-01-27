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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 127B5C433E0
	for <git@archiver.kernel.org>; Wed, 27 Jan 2021 15:36:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF719207D0
	for <git@archiver.kernel.org>; Wed, 27 Jan 2021 15:36:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236333AbhA0Pfy (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Jan 2021 10:35:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235659AbhA0PEJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jan 2021 10:04:09 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 776BAC06121E
        for <git@vger.kernel.org>; Wed, 27 Jan 2021 07:02:11 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id d16so2209880wro.11
        for <git@vger.kernel.org>; Wed, 27 Jan 2021 07:02:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=1ac7aq3Rq9lLGFvGJOTpKlrnF07cuk7BfPOPt8yCS/Q=;
        b=Y0ZL/9MlTcRk3DfmocSNMaS+rCq5fDaN8V7XW5yLIMeGBV09mV9plp+e2gHtjlLL+s
         pVlgO7kQxHvTNj9ZljQcM5d30zzk6zYsJobZ70sNB6oQJAxIzgFKb7W/K83IXE1Ijfih
         /3JFpx4cCYFucem8Z870ImUlG1g3qncw8JpO0+bcVsDceVxV9TjMrrtGm24D/zpiX/KV
         KlDEVOxSlc9iva4m4nBcq+1OGqWQPNEhQVeVJURiMluqWwHdWj4TqhTi506pVwGCfS4L
         +K+8kiHOVx89YpQpGLuTewextdpO8HDC7IsiFyy2XYeAWYDPG1GEb4eHIL7fHN/YuAgY
         jD6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=1ac7aq3Rq9lLGFvGJOTpKlrnF07cuk7BfPOPt8yCS/Q=;
        b=DNhKOjFbbL9yJpr4Ep8AsAHLUIqBqfn88C9SD1hwatrI1KvyEDAmu/961yupRzViRT
         AprdbVfORZw80xMdaiB2GFjeTqPTrjfPIFR9kIJMtifWX51tEFlxKaKxZqUnnIJIIqU8
         LsYDVKsHxR+kBgMeKnycsboGeCtr6dyJ87tEmhUPZVNO3MJwwJxT1xTaqEIs2qUMdXBi
         TRwk1cKlsWOgc6TYTQWV6t6HM0hdoKcfp8ulaWo5pgD6H/TAgx5x+U1JAB87V1mVDHGx
         EpokvGzb8mDD6QYMGBMstwjXm0dct689al7O8mxrZCPZ3tiDKy0ZYRTqVx9kjMvrb4Vu
         ekcg==
X-Gm-Message-State: AOAM531akcLRW7dl1NJiHCrY5FxMDx9PKxNoJhjM8bcwpyJL19/86aFe
        iyqx7GNzde1jf1fO+l74EmrBsRj4j4M=
X-Google-Smtp-Source: ABdhPJyVV27g69FwEuMYM1f/Uh7bykXwr2sHRLg8eLVBpMx70WrrSTcIlGMZal9cyhA2Sy8h74lW3A==
X-Received: by 2002:a5d:6842:: with SMTP id o2mr11851285wrw.310.1611759730005;
        Wed, 27 Jan 2021 07:02:10 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a184sm2938830wme.35.2021.01.27.07.02.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jan 2021 07:02:09 -0800 (PST)
Message-Id: <07dc0cf8c683676d304ac16fde2338f49e5cc483.1611759716.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.848.v2.git.1611759716.gitgitgadget@gmail.com>
References: <pull.848.git.1611676886.gitgitgadget@gmail.com>
        <pull.848.v2.git.1611759716.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 27 Jan 2021 15:01:50 +0000
Subject: [PATCH v2 11/17] midx: use chunk-format API in write_midx_internal()
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

The chunk-format API allows writing the table of contents and all chunks
using the anonymous 'struct chunkfile' type. We only need to convert our
local chunk logic to this API for the multi-pack-index writes to share
that logic with the commit-graph file writes.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 midx.c | 104 +++++++++++----------------------------------------------
 1 file changed, 19 insertions(+), 85 deletions(-)

diff --git a/midx.c b/midx.c
index 6ee262aab79..3585e04a706 100644
--- a/midx.c
+++ b/midx.c
@@ -11,6 +11,7 @@
 #include "trace2.h"
 #include "run-command.h"
 #include "repository.h"
+#include "chunk-format.h"
 
 #define MIDX_SIGNATURE 0x4d494458 /* "MIDX" */
 #define MIDX_VERSION 1
@@ -799,18 +800,15 @@ static int write_midx_large_offsets(struct hashfile *f,
 static int write_midx_internal(const char *object_dir, struct multi_pack_index *m,
 			       struct string_list *packs_to_drop, unsigned flags)
 {
-	unsigned char cur_chunk, num_chunks = 0;
 	char *midx_name;
 	uint32_t i;
 	struct hashfile *f = NULL;
 	struct lock_file lk;
 	struct write_midx_context ctx = { 0 };
-	uint64_t header_size = 0;
-	uint32_t chunk_ids[MIDX_MAX_CHUNKS + 1];
-	uint64_t chunk_offsets[MIDX_MAX_CHUNKS + 1];
 	int pack_name_concat_len = 0;
 	int dropped_packs = 0;
 	int result = 0;
+	struct chunkfile *cf;
 
 	midx_name = get_midx_filename(object_dir);
 	if (safe_create_leading_directories(midx_name))
@@ -923,98 +921,34 @@ static int write_midx_internal(const char *object_dir, struct multi_pack_index *
 	if (ctx.m)
 		close_midx(ctx.m);
 
-	cur_chunk = 0;
-	num_chunks = ctx.large_offsets_needed ? 5 : 4;
-
 	if (ctx.nr - dropped_packs == 0) {
 		error(_("no pack files to index."));
 		result = 1;
 		goto cleanup;
 	}
 
-	header_size = write_midx_header(f, num_chunks, ctx.nr - dropped_packs);
-
-	chunk_ids[cur_chunk] = MIDX_CHUNKID_PACKNAMES;
-	chunk_offsets[cur_chunk] = header_size + (num_chunks + 1) * MIDX_CHUNKLOOKUP_WIDTH;
-
-	cur_chunk++;
-	chunk_ids[cur_chunk] = MIDX_CHUNKID_OIDFANOUT;
-	chunk_offsets[cur_chunk] = chunk_offsets[cur_chunk - 1] + pack_name_concat_len;
-
-	cur_chunk++;
-	chunk_ids[cur_chunk] = MIDX_CHUNKID_OIDLOOKUP;
-	chunk_offsets[cur_chunk] = chunk_offsets[cur_chunk - 1] + MIDX_CHUNK_FANOUT_SIZE;
-
-	cur_chunk++;
-	chunk_ids[cur_chunk] = MIDX_CHUNKID_OBJECTOFFSETS;
-	chunk_offsets[cur_chunk] = chunk_offsets[cur_chunk - 1] + ctx.entries_nr * the_hash_algo->rawsz;
-
-	cur_chunk++;
-	chunk_offsets[cur_chunk] = chunk_offsets[cur_chunk - 1] + ctx.entries_nr * MIDX_CHUNK_OFFSET_WIDTH;
-	if (ctx.large_offsets_needed) {
-		chunk_ids[cur_chunk] = MIDX_CHUNKID_LARGEOFFSETS;
-
-		cur_chunk++;
-		chunk_offsets[cur_chunk] = chunk_offsets[cur_chunk - 1] +
-					   ctx.num_large_offsets * MIDX_CHUNK_LARGE_OFFSET_WIDTH;
-	}
-
-	chunk_ids[cur_chunk] = 0;
-
-	for (i = 0; i <= num_chunks; i++) {
-		if (i && chunk_offsets[i] < chunk_offsets[i - 1])
-			BUG("incorrect chunk offsets: %"PRIu64" before %"PRIu64,
-			    chunk_offsets[i - 1],
-			    chunk_offsets[i]);
-
-		if (chunk_offsets[i] % MIDX_CHUNK_ALIGNMENT)
-			BUG("chunk offset %"PRIu64" is not properly aligned",
-			    chunk_offsets[i]);
-
-		hashwrite_be32(f, chunk_ids[i]);
-		hashwrite_be64(f, chunk_offsets[i]);
-	}
-
-	for (i = 0; i < num_chunks; i++) {
-		if (f->total + f->offset != chunk_offsets[i])
-			BUG("incorrect chunk offset (%"PRIu64" != %"PRIu64") for chunk id %"PRIx32,
-			    chunk_offsets[i],
-			    f->total + f->offset,
-			    chunk_ids[i]);
+	cf = init_chunkfile(f);
 
-		switch (chunk_ids[i]) {
-			case MIDX_CHUNKID_PACKNAMES:
-				write_midx_pack_names(f, &ctx);
-				break;
+	add_chunk(cf, MIDX_CHUNKID_PACKNAMES,
+		  write_midx_pack_names, pack_name_concat_len);
+	add_chunk(cf, MIDX_CHUNKID_OIDFANOUT,
+		  write_midx_oid_fanout, MIDX_CHUNK_FANOUT_SIZE);
+	add_chunk(cf, MIDX_CHUNKID_OIDLOOKUP,
+		  write_midx_oid_lookup, ctx.entries_nr * the_hash_algo->rawsz);
+	add_chunk(cf, MIDX_CHUNKID_OBJECTOFFSETS,
+		  write_midx_object_offsets,
+		  ctx.entries_nr * MIDX_CHUNK_OFFSET_WIDTH);
 
-			case MIDX_CHUNKID_OIDFANOUT:
-				write_midx_oid_fanout(f, &ctx);
-				break;
-
-			case MIDX_CHUNKID_OIDLOOKUP:
-				write_midx_oid_lookup(f, &ctx);
-				break;
-
-			case MIDX_CHUNKID_OBJECTOFFSETS:
-				write_midx_object_offsets(f, &ctx);
-				break;
-
-			case MIDX_CHUNKID_LARGEOFFSETS:
-				write_midx_large_offsets(f, &ctx);
-				break;
-
-			default:
-				BUG("trying to write unknown chunk id %"PRIx32,
-				    chunk_ids[i]);
-		}
-	}
+	if (ctx.large_offsets_needed)
+		add_chunk(cf, MIDX_CHUNKID_LARGEOFFSETS,
+			write_midx_large_offsets,
+			ctx.num_large_offsets * MIDX_CHUNK_LARGE_OFFSET_WIDTH);
 
-	if (f->total + f->offset != chunk_offsets[num_chunks])
-		BUG("incorrect final offset %"PRIu64" != %"PRIu64,
-		    f->total + f->offset,
-		    chunk_offsets[num_chunks]);
+	write_midx_header(f, get_num_chunks(cf), ctx.nr - dropped_packs);
+	write_chunkfile(cf, &ctx);
 
 	finalize_hashfile(f, NULL, CSUM_FSYNC | CSUM_HASH_IN_STREAM);
+	free_chunkfile(cf);
 	commit_lock_file(&lk);
 
 cleanup:
-- 
gitgitgadget

