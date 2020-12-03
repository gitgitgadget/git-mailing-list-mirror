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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B287C0018C
	for <git@archiver.kernel.org>; Thu,  3 Dec 2020 16:18:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D78E1207AA
	for <git@archiver.kernel.org>; Thu,  3 Dec 2020 16:18:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2501880AbgLCQST (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Dec 2020 11:18:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2501871AbgLCQSS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Dec 2020 11:18:18 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10716C08E860
        for <git@vger.kernel.org>; Thu,  3 Dec 2020 08:17:08 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id d3so3240395wmb.4
        for <git@vger.kernel.org>; Thu, 03 Dec 2020 08:17:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=N5NGjmYZjqgMn1IRM3P08gMwL8dLA+n1v9CQ6COUz6w=;
        b=gZpbfsctilW+KaPe6ARIoSCaMzS2FQCr2dF+tdrPw0zD6hTaSs2vBPY3cGy00dAZxk
         v9mQpr2/flaTKY2q0AMl2aaLzaekMWrrSvdkZbb+Zend3QGGJ7dbYAUmXD2OmnjRR/c/
         hKfY4zIFV+BCBBfvYn3mDBp7lmRmpkoh4IMQd/mWM3mX3tJGGeLNbz/GIegfYXxu+lYM
         8bVqddQmE2nB8GGDTMWxGq7h3FrLnAT6aiUakWGzGd/vDeJbDYqXxBfuMB9KrPZ4F9ZK
         x6Dro98eM84/c2Jwmc7WWjeQMIE/LQSJvRZhpmhllyCnlq4nesQxZ7K7Aa7GszgC+zB1
         mJTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=N5NGjmYZjqgMn1IRM3P08gMwL8dLA+n1v9CQ6COUz6w=;
        b=dSU8xq4uAu1X58x1mDddU0ix4uPEIyUEcmTxVrtumbJNmUORrwBCjvAAmVyOPjYUX3
         eUXBqxHqV7j+WRf24Ysm8+IKBQQiK1jaEtUoBGO3RmlW5TyN7K9JWC7t2X6nmngr7+Rq
         08toLItTtimS7nO878lPiGqZjxEGhyJBZr7/EGW+cP91KgeMyhm73B2Diqf3OfEXsDiz
         hZLgtR25xyxoJ50Z0GSELUAWWqZAXinTKRiDxU09sNJDG/5Iov4ZS2MOMfcC3SDhMOmJ
         JYqSHqe4vECo646+QOG4cNfdr0Ece+f06QbmQ+UgZtXp+JK0NNqINoBSuHBy9Y9BTHO4
         219Q==
X-Gm-Message-State: AOAM53269XUTblvGPuTLFGrBHyemdKBpRdbcOEYLwlagtv7TpIJiMjnt
        G3r3juxHQbAT2HUNYB8CnhHnu0IUycA=
X-Google-Smtp-Source: ABdhPJxTngH+ckIUjhUg0YqMYQbQ8gw2NNigJMmGGA6KAvquTwp0UQvriqjOl6J4u7OGYvNzd2K/xw==
X-Received: by 2002:a7b:cb0c:: with SMTP id u12mr4136576wmj.11.1607012226565;
        Thu, 03 Dec 2020 08:17:06 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 35sm2234367wro.71.2020.12.03.08.17.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 08:17:06 -0800 (PST)
Message-Id: <f2f78ee1054f64fe767335c4b0c77ba2fbec5fae.1607012215.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.804.git.1607012215.gitgitgadget@gmail.com>
References: <pull.804.git.1607012215.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 03 Dec 2020 16:16:49 +0000
Subject: [PATCH 10/15] midx: use chunk-format API in write_midx_internal()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     szeder.dev@gmail.com, me@ttaylorr.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The chunk-format API allows automatically writing the table of contents
for a chunk-based file format when using an array of "struct
chunk_info"s. Update write_midx_internal() to use this strategy, which
also simplifies the chunk writing loop. This loop will be replaced with
a chunk-format API call in an upcoming change.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 midx.c | 96 +++++++++++++---------------------------------------------
 1 file changed, 21 insertions(+), 75 deletions(-)

diff --git a/midx.c b/midx.c
index ce6d4339bd..0548266bea 100644
--- a/midx.c
+++ b/midx.c
@@ -11,6 +11,7 @@
 #include "trace2.h"
 #include "run-command.h"
 #include "repository.h"
+#include "chunk-format.h"
 
 #define MIDX_SIGNATURE 0x4d494458 /* "MIDX" */
 #define MIDX_VERSION 1
@@ -799,15 +800,14 @@ static int write_midx_large_offsets(struct hashfile *f,
 static int write_midx_internal(const char *object_dir, struct multi_pack_index *m,
 			       struct string_list *packs_to_drop, unsigned flags)
 {
-	unsigned char cur_chunk, num_chunks = 0;
+	unsigned char num_chunks = 0;
 	char *midx_name;
 	uint32_t i;
 	struct hashfile *f = NULL;
 	struct lock_file lk;
 	struct write_midx_context ctx = { 0 };
 	uint64_t header_size = 0;
-	uint32_t chunk_ids[MIDX_MAX_CHUNKS + 1];
-	uint64_t chunk_offsets[MIDX_MAX_CHUNKS + 1];
+	struct chunk_info chunks[MIDX_MAX_CHUNKS];
 	int pack_name_concat_len = 0;
 	int dropped_packs = 0;
 	int result = 0;
@@ -923,7 +923,6 @@ static int write_midx_internal(const char *object_dir, struct multi_pack_index *
 	if (ctx.m)
 		close_midx(ctx.m);
 
-	cur_chunk = 0;
 	num_chunks = ctx.large_offsets_needed ? 5 : 4;
 
 	if (ctx.nr - dropped_packs == 0) {
@@ -934,85 +933,32 @@ static int write_midx_internal(const char *object_dir, struct multi_pack_index *
 
 	header_size = write_midx_header(f, num_chunks, ctx.nr - dropped_packs);
 
-	chunk_ids[cur_chunk] = MIDX_CHUNKID_PACKNAMES;
-	chunk_offsets[cur_chunk] = header_size + (num_chunks + 1) * MIDX_CHUNKLOOKUP_WIDTH;
+	chunks[0].id = MIDX_CHUNKID_PACKNAMES;
+	chunks[0].size = pack_name_concat_len;
+	chunks[0].write_fn = write_midx_pack_names;
 
-	cur_chunk++;
-	chunk_ids[cur_chunk] = MIDX_CHUNKID_OIDFANOUT;
-	chunk_offsets[cur_chunk] = chunk_offsets[cur_chunk - 1] + pack_name_concat_len;
+	chunks[1].id = MIDX_CHUNKID_OIDFANOUT;
+	chunks[1].size = MIDX_CHUNK_FANOUT_SIZE;
+	chunks[1].write_fn = write_midx_oid_fanout;
 
-	cur_chunk++;
-	chunk_ids[cur_chunk] = MIDX_CHUNKID_OIDLOOKUP;
-	chunk_offsets[cur_chunk] = chunk_offsets[cur_chunk - 1] + MIDX_CHUNK_FANOUT_SIZE;
+	chunks[2].id = MIDX_CHUNKID_OIDLOOKUP;
+	chunks[2].size = ctx.entries_nr * the_hash_algo->rawsz;
+	chunks[2].write_fn = write_midx_oid_lookup;
 
-	cur_chunk++;
-	chunk_ids[cur_chunk] = MIDX_CHUNKID_OBJECTOFFSETS;
-	chunk_offsets[cur_chunk] = chunk_offsets[cur_chunk - 1] + ctx.entries_nr * the_hash_algo->rawsz;
+	chunks[3].id = MIDX_CHUNKID_OBJECTOFFSETS;
+	chunks[3].size = ctx.entries_nr * MIDX_CHUNK_OFFSET_WIDTH;
+	chunks[3].write_fn = write_midx_object_offsets;
 
-	cur_chunk++;
-	chunk_offsets[cur_chunk] = chunk_offsets[cur_chunk - 1] + ctx.entries_nr * MIDX_CHUNK_OFFSET_WIDTH;
 	if (ctx.large_offsets_needed) {
-		chunk_ids[cur_chunk] = MIDX_CHUNKID_LARGEOFFSETS;
-
-		cur_chunk++;
-		chunk_offsets[cur_chunk] = chunk_offsets[cur_chunk - 1] +
-					   ctx.num_large_offsets * MIDX_CHUNK_LARGE_OFFSET_WIDTH;
+		chunks[4].id = MIDX_CHUNKID_LARGEOFFSETS;
+		chunks[4].size = ctx.num_large_offsets * MIDX_CHUNK_LARGE_OFFSET_WIDTH;
+		chunks[4].write_fn = write_midx_large_offsets;
 	}
 
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
-
-		switch (chunk_ids[i]) {
-			case MIDX_CHUNKID_PACKNAMES:
-				write_midx_pack_names(f, &ctx);
-				break;
-
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
+	write_table_of_contents(f, header_size, chunks, num_chunks);
 
-	if (f->total + f->offset != chunk_offsets[num_chunks])
-		BUG("incorrect final offset %"PRIu64" != %"PRIu64,
-		    f->total + f->offset,
-		    chunk_offsets[num_chunks]);
+	for (i = 0; i < num_chunks; i++)
+		chunks[i].write_fn(f, &ctx);
 
 	finalize_hashfile(f, NULL, CSUM_FSYNC | CSUM_HASH_IN_STREAM);
 	commit_lock_file(&lk);
-- 
gitgitgadget

