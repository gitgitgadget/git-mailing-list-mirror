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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D3DAC433DB
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 16:52:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F48864EAF
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 16:52:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233924AbhBRQv1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Feb 2021 11:51:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233116AbhBROJd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Feb 2021 09:09:33 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35A18C061356
        for <git@vger.kernel.org>; Thu, 18 Feb 2021 06:07:54 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id u14so3136676wri.3
        for <git@vger.kernel.org>; Thu, 18 Feb 2021 06:07:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=bw5kYP5uPIt0cxb9pH4WJLJrsVSKjkp+3wz43GO4kqw=;
        b=sVLeEkxrkuUiB6MqH7WI/XBilhAs4Ck0i6hl919BwyV4JI5nkElQyPsbA+R0Eu5UtF
         VKfJNP+kY01+Pck/BMZCJh7IM1gQVYBS6q/6q750i4BdWJJTdnzQJF32ujfN9WrSMCj6
         pLhyWZUqSt3RN3iszQhPm6Ndz9BmXcvEfaidtPlg2TVtFD/avGH5BNe16ProE5DGPiAE
         elnDhP4144uMyivv8FjbIOPJyu4S8OGOH1nWurtW5DXO9MIhnrqw5ydXWT2HJMm+4xi2
         oS7d2L1WKrjp+yY6MB6ecQd9e4S/Z8DgApVRmHectyhC6xBotQJPrKl76OSFebciDUZa
         NyPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=bw5kYP5uPIt0cxb9pH4WJLJrsVSKjkp+3wz43GO4kqw=;
        b=mzVwPDmwMbo5+hcA7diJQxW6GLSqPNa9BZJ1l6CaVA60WR47C0FMnTOUOz8OloEcSA
         tBCKJLmzTLAxL3Lmb/ghMOFeHdY/3CK+1udBP+u8Eu0qTBY5fKaCK1Ev0VDgCslMcqoO
         v6JIfuUWPUMQArfNJXFhSLswJoNAidgUYlMFjCCHgeushlfnB75+mII29RYM9gzYXRZM
         2Ahm28RVAeveghtfuBWA4ZL8bgNeJ8Zc3VV61fEYJEhohsPeQBElbmZrU924QAP9gIDc
         VOnt1xuqZmTZcTiLys4Rla78GcCk9Ot0nHXON3huyAE1swDXvx+R/XrZvL1tOlOTn0db
         KUdg==
X-Gm-Message-State: AOAM531okV6gbagxer/AoBQUqbTYI2uFimQid2m6FneyOvO1JV4p1Ccw
        ZxXNpjqNLtO6CefZoT+wDmjb1Smxzfo=
X-Google-Smtp-Source: ABdhPJzn7H9Z0fZMzzDhPbqdWP9FsetPrlhFu2jUE8sfhB20lUv5w54E7QNJswVCyfpZEVM74DYLsA==
X-Received: by 2002:adf:fb91:: with SMTP id a17mr4445785wrr.93.1613657272962;
        Thu, 18 Feb 2021 06:07:52 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y16sm8761850wrw.46.2021.02.18.06.07.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Feb 2021 06:07:52 -0800 (PST)
Message-Id: <0b95aa7e152f01b4c33c79858d8979ffcc4eb420.1613657259.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.848.v4.git.1613657259.gitgitgadget@gmail.com>
References: <pull.848.v3.git.1612535452.gitgitgadget@gmail.com>
        <pull.848.v4.git.1613657259.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 18 Feb 2021 14:07:33 +0000
Subject: [PATCH v4 11/17] midx: use chunk-format API in write_midx_internal()
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
 midx.c | 106 +++++++++++----------------------------------------------
 1 file changed, 20 insertions(+), 86 deletions(-)

diff --git a/midx.c b/midx.c
index 4f4aa351e60e..d2fd9c10feea 100644
--- a/midx.c
+++ b/midx.c
@@ -11,6 +11,7 @@
 #include "trace2.h"
 #include "run-command.h"
 #include "repository.h"
+#include "chunk-format.h"
 
 #define MIDX_SIGNATURE 0x4d494458 /* "MIDX" */
 #define MIDX_VERSION 1
@@ -21,7 +22,6 @@
 #define MIDX_HEADER_SIZE 12
 #define MIDX_MIN_SIZE (MIDX_HEADER_SIZE + the_hash_algo->rawsz)
 
-#define MIDX_MAX_CHUNKS 5
 #define MIDX_CHUNK_ALIGNMENT 4
 #define MIDX_CHUNKID_PACKNAMES 0x504e414d /* "PNAM" */
 #define MIDX_CHUNKID_OIDFANOUT 0x4f494446 /* "OIDF" */
@@ -799,18 +799,15 @@ static int write_midx_large_offsets(struct hashfile *f,
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
@@ -923,98 +920,35 @@ static int write_midx_internal(const char *object_dir, struct multi_pack_index *
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
+	add_chunk(cf, MIDX_CHUNKID_PACKNAMES, pack_name_concat_len,
+		  write_midx_pack_names);
+	add_chunk(cf, MIDX_CHUNKID_OIDFANOUT, MIDX_CHUNK_FANOUT_SIZE,
+		  write_midx_oid_fanout);
+	add_chunk(cf, MIDX_CHUNKID_OIDLOOKUP,
+		  ctx.entries_nr * the_hash_algo->rawsz,
+		  write_midx_oid_lookup);
+	add_chunk(cf, MIDX_CHUNKID_OBJECTOFFSETS,
+		  ctx.entries_nr * MIDX_CHUNK_OFFSET_WIDTH,
+		  write_midx_object_offsets);
 
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
+			ctx.num_large_offsets * MIDX_CHUNK_LARGE_OFFSET_WIDTH,
+			write_midx_large_offsets);
 
-	if (hashfile_total(f) != chunk_offsets[num_chunks])
-		BUG("incorrect final offset %"PRIu64" != %"PRIu64,
-		    hashfile_total(f),
-		    chunk_offsets[num_chunks]);
+	write_midx_header(f, get_num_chunks(cf), ctx.nr - dropped_packs);
+	write_chunkfile(cf, &ctx);
 
 	finalize_hashfile(f, NULL, CSUM_FSYNC | CSUM_HASH_IN_STREAM);
+	free_chunkfile(cf);
 	commit_lock_file(&lk);
 
 cleanup:
-- 
gitgitgadget

