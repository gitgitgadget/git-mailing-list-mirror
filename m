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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3036EC4167B
	for <git@archiver.kernel.org>; Thu,  3 Dec 2020 16:17:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDC34207AC
	for <git@archiver.kernel.org>; Thu,  3 Dec 2020 16:17:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2501874AbgLCQRw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Dec 2020 11:17:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2501864AbgLCQRv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Dec 2020 11:17:51 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C016C061A4F
        for <git@vger.kernel.org>; Thu,  3 Dec 2020 08:17:06 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id f190so4530799wme.1
        for <git@vger.kernel.org>; Thu, 03 Dec 2020 08:17:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Pfqu9XMbjGTvOL3pjpfj+P8GC32X0HDYjERDMUqH4/I=;
        b=TXai4lDzpuWuB+NbKr5dq1h66IpDYBNILjNESSYzBkB2ltt+89OKDcaxUuwHKnb3sq
         t1yz3QUYyr0Ox6ZmSvRx1rujN+gConsxp3WHA104IK4w+kxHmlgLY/ur63wae0PDOiut
         P6yh11aL90/xQvPuqxpUBcOg6OkhJiNvKjriZzPH+RFI38Wq4bKweI6F/ASnQhYftC2B
         U1gxy2mVy4+IQlGZaYlkkNPlclsoBouJECjSymoLsQ05vTW5/Q/vtm4liDvJ/Um1hfip
         ffEGE4ISLOXENY/oAtEncDgjRiDeWwvsRT1hCdbfkdRss5UeX6SvPwrK3hBrFvejveuD
         bn2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Pfqu9XMbjGTvOL3pjpfj+P8GC32X0HDYjERDMUqH4/I=;
        b=FfNUNngJghEJCbYSQcM4AJS1QsPTi6YbQ4Qq/tq89TJklaF6OAxQyZdTqBJvK7bW2Q
         9P8oBQa+F07EczbLukDIIo4BPHFwxMPVBcnhazSAetBlmE+ezlOEO18W8uKnA8ZjjeJ7
         JcRssmv0t9O8PjMEHmi1m+bHaiaQF7GJx/Lp5cE4KQrJ8tfPzKiA3tgKkcjsxF0zMyFK
         ZCwPk5wsTsdJ6MMlShFBX2gl72V8R2nKAoV2EkuGIKxi3RbC0rT82uLZNHtv0apK5qU5
         E8MRaycfPZ/6PmAbBvr1W7mNyoniPF9T2f3VyzCD+jSOJkoaczXbyBXYlM7+KVSjx+4C
         fiJw==
X-Gm-Message-State: AOAM532Td3RDuXO07LDeNDGnNoiTReb5valydTcwIcjPm+WSUP7AzB52
        6Yl73OgKTT3gdes0l8yIL9fKUa9o83I=
X-Google-Smtp-Source: ABdhPJxOBJHNyEEyiZd3vRvlPelLOiD+3BL+JR0dfArSdfxbHNIaZfudMaFwDdX2rdOjEwWbhPL4Xg==
X-Received: by 2002:a7b:c2e8:: with SMTP id e8mr4094045wmk.103.1607012224534;
        Thu, 03 Dec 2020 08:17:04 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c2sm2227715wrv.41.2020.12.03.08.17.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 08:17:04 -0800 (PST)
Message-Id: <dbb637a7ac6d2cc6bb78428ef7bda67687095f88.1607012215.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.804.git.1607012215.gitgitgadget@gmail.com>
References: <pull.804.git.1607012215.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 03 Dec 2020 16:16:47 +0000
Subject: [PATCH 08/15] midx: convert chunk write methods to return int
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

Historically, the chunk-writing methods in midx.c have returned the
amount of data written so the writer method could compare this with the
table of contents. This presents with some interesting issues:

1. If a chunk writing method has a bug that miscalculates the written
   bytes, then we can satisfy the table of contents without actually
   writing the right amount of data to the hashfile. The commit-graph
   writing code checks the hashfile struct directly for a more robust
   verification.

2. There is no way for a chunk writing method to gracefully fail.
   Returning an int presents an opportunity to fail without a die().

3. The current pattern doesn't match chunk_write_fn type exactly, so we
   cannot share code with commit-graph.c

For these reasons, convert the midx chunk writer methods to return an
'int'. Since none of them fail at the moment, they all return 0.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 midx.c | 63 +++++++++++++++++++++++++---------------------------------
 1 file changed, 27 insertions(+), 36 deletions(-)

diff --git a/midx.c b/midx.c
index d7da358a3f..5eb1b01946 100644
--- a/midx.c
+++ b/midx.c
@@ -650,7 +650,7 @@ static struct pack_midx_entry *get_sorted_entries(struct multi_pack_index *m,
 	return deduplicated_entries;
 }
 
-static size_t write_midx_pack_names(struct hashfile *f, void *data)
+static int write_midx_pack_names(struct hashfile *f, void *data)
 {
 	struct write_midx_context *ctx = (struct write_midx_context *)data;
 	uint32_t i;
@@ -678,14 +678,13 @@ static size_t write_midx_pack_names(struct hashfile *f, void *data)
 	if (i < MIDX_CHUNK_ALIGNMENT) {
 		memset(padding, 0, sizeof(padding));
 		hashwrite(f, padding, i);
-		written += i;
 	}
 
-	return written;
+	return 0;
 }
 
-static size_t write_midx_oid_fanout(struct hashfile *f,
-				    void *data)
+static int write_midx_oid_fanout(struct hashfile *f,
+				 void *data)
 {
 	struct write_midx_context *ctx = (struct write_midx_context *)data;
 	struct pack_midx_entry *list = ctx->entries;
@@ -710,17 +709,16 @@ static size_t write_midx_oid_fanout(struct hashfile *f,
 		list = next;
 	}
 
-	return MIDX_CHUNK_FANOUT_SIZE;
+	return 0;
 }
 
-static size_t write_midx_oid_lookup(struct hashfile *f,
-				    void *data)
+static int write_midx_oid_lookup(struct hashfile *f,
+				 void *data)
 {
 	struct write_midx_context *ctx = (struct write_midx_context *)data;
 	unsigned char hash_len = the_hash_algo->rawsz;
 	struct pack_midx_entry *list = ctx->entries;
 	uint32_t i;
-	size_t written = 0;
 
 	for (i = 0; i < ctx->entries_nr; i++) {
 		struct pack_midx_entry *obj = list++;
@@ -734,19 +732,17 @@ static size_t write_midx_oid_lookup(struct hashfile *f,
 		}
 
 		hashwrite(f, obj->oid.hash, (int)hash_len);
-		written += hash_len;
 	}
 
-	return written;
+	return 0;
 }
 
-static size_t write_midx_object_offsets(struct hashfile *f,
-					void *data)
+static int write_midx_object_offsets(struct hashfile *f,
+				     void *data)
 {
 	struct write_midx_context *ctx = (struct write_midx_context *)data;
 	struct pack_midx_entry *list = ctx->entries;
 	uint32_t i, nr_large_offset = 0;
-	size_t written = 0;
 
 	for (i = 0; i < ctx->entries_nr; i++) {
 		struct pack_midx_entry *obj = list++;
@@ -766,20 +762,17 @@ static size_t write_midx_object_offsets(struct hashfile *f,
 			    obj->offset);
 		else
 			hashwrite_be32(f, (uint32_t)obj->offset);
-
-		written += MIDX_CHUNK_OFFSET_WIDTH;
 	}
 
-	return written;
+	return 0;
 }
 
-static size_t write_midx_large_offsets(struct hashfile *f,
-				       void *data)
+static int write_midx_large_offsets(struct hashfile *f,
+				    void *data)
 {
 	struct write_midx_context *ctx = (struct write_midx_context *)data;
 	struct pack_midx_entry *list = ctx->entries;
 	struct pack_midx_entry *end = ctx->entries + ctx->entries_nr;
-	size_t written = 0;
 	uint32_t nr_large_offset = ctx->num_large_offsets;
 
 	while (nr_large_offset) {
@@ -795,12 +788,12 @@ static size_t write_midx_large_offsets(struct hashfile *f,
 		if (!(offset >> 31))
 			continue;
 
-		written += hashwrite_be64(f, offset);
+		hashwrite_be64(f, offset);
 
 		nr_large_offset--;
 	}
 
-	return written;
+	return 0;
 }
 
 static int write_midx_internal(const char *object_dir, struct multi_pack_index *m,
@@ -812,7 +805,7 @@ static int write_midx_internal(const char *object_dir, struct multi_pack_index *
 	struct hashfile *f = NULL;
 	struct lock_file lk;
 	struct write_midx_context ctx = { 0 };
-	uint64_t written = 0;
+	uint64_t header_size = 0;
 	uint32_t chunk_ids[MIDX_MAX_CHUNKS + 1];
 	uint64_t chunk_offsets[MIDX_MAX_CHUNKS + 1];
 	struct progress *progress = NULL;
@@ -940,10 +933,10 @@ static int write_midx_internal(const char *object_dir, struct multi_pack_index *
 		goto cleanup;
 	}
 
-	written = write_midx_header(f, num_chunks, ctx.nr - dropped_packs);
+	header_size = write_midx_header(f, num_chunks, ctx.nr - dropped_packs);
 
 	chunk_ids[cur_chunk] = MIDX_CHUNKID_PACKNAMES;
-	chunk_offsets[cur_chunk] = written + (num_chunks + 1) * MIDX_CHUNKLOOKUP_WIDTH;
+	chunk_offsets[cur_chunk] = header_size + (num_chunks + 1) * MIDX_CHUNKLOOKUP_WIDTH;
 
 	cur_chunk++;
 	chunk_ids[cur_chunk] = MIDX_CHUNKID_OIDFANOUT;
@@ -981,39 +974,37 @@ static int write_midx_internal(const char *object_dir, struct multi_pack_index *
 
 		hashwrite_be32(f, chunk_ids[i]);
 		hashwrite_be64(f, chunk_offsets[i]);
-
-		written += MIDX_CHUNKLOOKUP_WIDTH;
 	}
 
 	if (flags & MIDX_PROGRESS)
 		progress = start_delayed_progress(_("Writing chunks to multi-pack-index"),
 					  num_chunks);
 	for (i = 0; i < num_chunks; i++) {
-		if (written != chunk_offsets[i])
+		if (f->total + f->offset != chunk_offsets[i])
 			BUG("incorrect chunk offset (%"PRIu64" != %"PRIu64") for chunk id %"PRIx32,
 			    chunk_offsets[i],
-			    written,
+			    f->total + f->offset,
 			    chunk_ids[i]);
 
 		switch (chunk_ids[i]) {
 			case MIDX_CHUNKID_PACKNAMES:
-				written += write_midx_pack_names(f, &ctx);
+				write_midx_pack_names(f, &ctx);
 				break;
 
 			case MIDX_CHUNKID_OIDFANOUT:
-				written += write_midx_oid_fanout(f, &ctx);
+				write_midx_oid_fanout(f, &ctx);
 				break;
 
 			case MIDX_CHUNKID_OIDLOOKUP:
-				written += write_midx_oid_lookup(f, &ctx);
+				write_midx_oid_lookup(f, &ctx);
 				break;
 
 			case MIDX_CHUNKID_OBJECTOFFSETS:
-				written += write_midx_object_offsets(f, &ctx);
+				write_midx_object_offsets(f, &ctx);
 				break;
 
 			case MIDX_CHUNKID_LARGEOFFSETS:
-				written += write_midx_large_offsets(f, &ctx);
+				write_midx_large_offsets(f, &ctx);
 				break;
 
 			default:
@@ -1025,9 +1016,9 @@ static int write_midx_internal(const char *object_dir, struct multi_pack_index *
 	}
 	stop_progress(&progress);
 
-	if (written != chunk_offsets[num_chunks])
+	if (f->total + f->offset != chunk_offsets[num_chunks])
 		BUG("incorrect final offset %"PRIu64" != %"PRIu64,
-		    written,
+		    f->total + f->offset,
 		    chunk_offsets[num_chunks]);
 
 	finalize_hashfile(f, NULL, CSUM_FSYNC | CSUM_HASH_IN_STREAM);
-- 
gitgitgadget

