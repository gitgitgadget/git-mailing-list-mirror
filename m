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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6303CC433DB
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 16:05:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B8AE2220B
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 16:05:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391403AbhAZQFW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Jan 2021 11:05:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404631AbhAZQC7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jan 2021 11:02:59 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB6EBC0698C5
        for <git@vger.kernel.org>; Tue, 26 Jan 2021 08:01:39 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id b5so17009326wrr.10
        for <git@vger.kernel.org>; Tue, 26 Jan 2021 08:01:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=fPA9Pt/h9TBeyQYflA9V7ZzZ1iz8PP16eANqeD9X+5E=;
        b=YWioCQX9FLdSdP85feDEr0ZAvzJCwQvAHlqrZy4M7WcBrejTne0l5NapI2qd9ivL1X
         ZietkkecbKUjOykzonUVzu2hIk8gThxCmzEP83EdaaH8PElHlnrX7Pu7f6wpjiPVWO+4
         4ge6Ocl+EpIdf6J4y4QlxsPk8hEL8y/UmHqLypxnXjWzFGiLhjSklJDhxlFVb+ojO1Ib
         ic4gox9dcHvCsCJymQEXb0NV+mxkkS36B0TSB6W1LX7i3LtyHmr7h03tenOL2KsK1JDo
         0g64yzls0fgsxE8mkuZhCKb+XmzBf7YvSUNJ5RWKtgSDKK76Hh5iMg3GF8ydLCQi7u/t
         WxLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=fPA9Pt/h9TBeyQYflA9V7ZzZ1iz8PP16eANqeD9X+5E=;
        b=T/KTD+b2zeneK3QucHbeGj5Pi49vsxQ0CIPJa7Zn3jjpMva6uJR13TTlkDmb2nW8Hj
         +N2Qnj2LkVjd81cK4BNrSgSid0P5lnZ7Fq9Frop0fXN9oXlR87hKOjnbVHHaeN65WXTG
         yasPeC+fqgNqUBFgV7PcHYDvvzxXKjaPIbnjk0bkhck/WVwP2NIV2oCv9pIcjaNfktRo
         XZtiwI6Zk5keZcAJCluonK/+ep3IV+kqyu4l/hnws5S7CukMpJXC9WH2ZYXe4F6KrLiv
         qoc7WZYgmVAJChQGrGfg6DuwNzS3GXElA6/l7SOLC5MTNRL5WbGVE+vFO3hpyyaPQ8wB
         LRvQ==
X-Gm-Message-State: AOAM5301PeYcUpcuPomBBnHkjGrrTGuitd2uPhcIrRgAROGJJEeFs2r4
        rOq4iRLo4udx/hNCVHyRmOa1FnJzEcM=
X-Google-Smtp-Source: ABdhPJz67AspyJ9vQ/8uQ6n/Dx8KV2s0IhKFMOfpnTvtZy9Zj77TFZ6EdpSOBn6dRAnNQTjYpUVD4Q==
X-Received: by 2002:a5d:6282:: with SMTP id k2mr6973561wru.159.1611676898508;
        Tue, 26 Jan 2021 08:01:38 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 15sm3693929wmk.3.2021.01.26.08.01.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 08:01:38 -0800 (PST)
Message-Id: <49cfb4f63e275ce70b20dd6d3f156971b33ddcec.1611676886.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.848.git.1611676886.gitgitgadget@gmail.com>
References: <pull.848.git.1611676886.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 26 Jan 2021 16:01:20 +0000
Subject: [PATCH 11/17] midx: use chunk-format API in write_midx_internal()
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

The chunk-format API allows writing the table of contents and all chunks
using the anonymous 'struct chunkfile' type. We only need to convert our
local chunk logic to this API for the multi-pack-index writes to share
that logic with the commit-graph file writes.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 midx.c | 104 +++++++++++----------------------------------------------
 1 file changed, 19 insertions(+), 85 deletions(-)

diff --git a/midx.c b/midx.c
index 145c6bd0913..0bfd2d802b6 100644
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

