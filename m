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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C84D1C432C3
	for <git@archiver.kernel.org>; Fri,  5 Feb 2021 22:18:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C65A61492
	for <git@archiver.kernel.org>; Fri,  5 Feb 2021 22:18:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233146AbhBEWRx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Feb 2021 17:17:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232654AbhBEOap (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Feb 2021 09:30:45 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEFD1C061356
        for <git@vger.kernel.org>; Fri,  5 Feb 2021 08:08:11 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id z22so9324930edb.9
        for <git@vger.kernel.org>; Fri, 05 Feb 2021 08:08:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=At4JRoTc29IW16Y+2nXz7iB3R7DOXkEhdA+z+7Y3wdk=;
        b=Zp4CjUxANaxxlf7BoraQvf7Ss4KR4rf0LJ6XbYVPiTcZBbhDnzlZWArEk/0mWVHA6M
         CVVPh2ufSvh6358zim38FtdalnizharqGjC8Adf/VXCbJ6GV85L+E/JfVMAKH1aLz0Sx
         B69+ayltN3eyJ91cSvzKTKp6N3cQVoiEOnrReodYNU3wCh+EboHLjCm40l52jRgjc9gP
         QJ/gUOsAwpbLeyANMCZn0+t+BI3Ycrhc+ZkhjpVEcZMfQS1jxy+uClIQnig5HSLxZIYC
         lfzkNv778/quUGKGv4jgGKn1XacSGpELb+dv5ksJCo6jldMZ4VjmujaKjONYpY9UW8sr
         l0Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=At4JRoTc29IW16Y+2nXz7iB3R7DOXkEhdA+z+7Y3wdk=;
        b=MOAn1jJUvoz0AyTVZGFzvAG9sXldxsJCwFL9ykqU0hkBY8EZRi8yNijhr6zMvmFPTt
         KQ9Ze+RMcyKQ3k6MuYc90qIBwJZZlcI2GYp4qolTXkwyPvI4Ia3uXNbnQr9t8imbltlq
         tTAiPhE0w5bKDnAletAzjE8t70C3N+0OgSPlTh3WUES2jg/mxAkiKBf+dEMVYQRApZy8
         EvGWqhVM8ndTndRc0oRdU7Z6a9nQKx7SPgogZm9TFooVXb2ElKPZY5/jfS+61JSAceGw
         lRzRJXW935Mmo3AiL1W0OEWqISPf/hCSOP33FmKHzWQxkGOUvuIPF3aOZ+P7niP2tAiC
         12KQ==
X-Gm-Message-State: AOAM531unaooDcglWv/iqPFBMw09HfGt2Bv2tK9JT7YXiFrKGJG9LZb/
        UW5OhjpfUXh9DJoUAPXlnlWy9n3Oh2E=
X-Google-Smtp-Source: ABdhPJxpmmpH5iHjs78+gKiwCp3Dy+ABdN1WD8+LcbOcrMed1w4EuK0MRqtORu4fSFNva4z5SnaD1w==
X-Received: by 2002:a5d:414f:: with SMTP id c15mr5427739wrq.42.1612535465874;
        Fri, 05 Feb 2021 06:31:05 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r15sm12592299wrj.61.2021.02.05.06.31.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 06:31:05 -0800 (PST)
Message-Id: <787cd7f18d2e47d975e10bf0f56188bc35589124.1612535453.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.848.v3.git.1612535452.gitgitgadget@gmail.com>
References: <pull.848.v2.git.1611759716.gitgitgadget@gmail.com>
        <pull.848.v3.git.1612535452.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 05 Feb 2021 14:30:46 +0000
Subject: [PATCH v3 11/17] midx: use chunk-format API in write_midx_internal()
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
 midx.c | 105 +++++++++++----------------------------------------------
 1 file changed, 20 insertions(+), 85 deletions(-)

diff --git a/midx.c b/midx.c
index 4f4aa351e60e..d9c7411b083b 100644
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
@@ -923,98 +921,35 @@ static int write_midx_internal(const char *object_dir, struct multi_pack_index *
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

