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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E21BC433DB
	for <git@archiver.kernel.org>; Fri,  5 Feb 2021 16:41:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0084764EE0
	for <git@archiver.kernel.org>; Fri,  5 Feb 2021 16:41:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233037AbhBEPB5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Feb 2021 10:01:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232983AbhBEO6g (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Feb 2021 09:58:36 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E7ACC061223
        for <git@vger.kernel.org>; Fri,  5 Feb 2021 08:28:55 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id s3so9443478edi.7
        for <git@vger.kernel.org>; Fri, 05 Feb 2021 08:28:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=9rbRQ+4gSMEK2h+y1E/hg18dGvaKEJCIVpGJN9anMY4=;
        b=nlG04GI+vgooir4Do+O/vtLMs1B8wOMSbxCsU37UwC75po/SXjdoNxWy1zUDTDONZq
         VtReksXt1VEfcNL7X/0Fx/YakFwyh8HCLBsvH41avybjwz1i/HXT73LBQfT8ScOz1ixh
         pmM4AGK+gmgSoziCUbM1RJUeMUXV2KwcHO2CgXzVj5WRYWJgH7lmrJ5nenKAyqbP8xKr
         C1P4F119RjUxg+HGlnq9sqjpHaThOHpYfHsFhOOrY67ZianBpTdKuuNFsqNdVqiZU0/F
         WHJ7e1/Zt+hZsgdR2sp95sLKt7Mdri9R0PTLFDa3oVR0f0+FwMAlz+DOWXLmA8r/iuvR
         /AAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=9rbRQ+4gSMEK2h+y1E/hg18dGvaKEJCIVpGJN9anMY4=;
        b=fMTUjpZXs/3V5lIz2K9vKNh/dl9HdDi3fSFnp3ZlKAwuZ7cJKu6wHrO8H6t4b5LTAy
         54pV5IPZY7vghUmU67quPSesCJds1vNk4JQOP2UrtJwrILHeC5JfQb2N59Yqo1ANwoMd
         HlvT6E2mSkmkdgG/ZLJB9VDswLuN+t12TGAWLV5vUXFfiHJkHfsPzGzFhJro9ZpYiYBW
         ehh2oiGHG2/CKUtI4LqMllCQn9BG+xywssHHBogy2BGU+SbfU7fzpmodz8qVbEAN5m5s
         zQ1JGDCypBObI7FVqwAG3epgglF1TxZ2un5eNLfsdrZmnGyzKLR5Atr8b01jsZv2SyZk
         KfHw==
X-Gm-Message-State: AOAM533+SPy63DM3t7Q4HNPbRh1IRsWWsxG5ZbeJ6uFg+2U4Tgh3eAjK
        sFSv8mxjppwv2A5ynT//lRRPdJXMvJU=
X-Google-Smtp-Source: ABdhPJxUi25h6Q/xkWSJjfs2LI4DXyhEGXoxZMiL05v/fVj+11MJ1wVRhui3Ihu6H+R+amOQBgufUg==
X-Received: by 2002:adf:e610:: with SMTP id p16mr5289561wrm.169.1612535463728;
        Fri, 05 Feb 2021 06:31:03 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u4sm11928802wrr.37.2021.02.05.06.31.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 06:31:03 -0800 (PST)
Message-Id: <7aa3242e15b7a0cca7b7d4394311697ed84bc05a.1612535453.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.848.v3.git.1612535452.gitgitgadget@gmail.com>
References: <pull.848.v2.git.1611759716.gitgitgadget@gmail.com>
        <pull.848.v3.git.1612535452.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 05 Feb 2021 14:30:44 +0000
Subject: [PATCH v3 09/17] midx: return success/failure in chunk write methods
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
index 5be081f229ad..c92a6c47be01 100644
--- a/midx.c
+++ b/midx.c
@@ -650,7 +650,7 @@ static struct pack_midx_entry *get_sorted_entries(struct multi_pack_index *m,
 	return deduplicated_entries;
 }
 
-static size_t write_midx_pack_names(struct hashfile *f, void *data)
+static int write_midx_pack_names(struct hashfile *f, void *data)
 {
 	struct write_midx_context *ctx = data;
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
 	struct write_midx_context *ctx = data;
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
 	struct write_midx_context *ctx = data;
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
 	struct write_midx_context *ctx = data;
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
 	struct write_midx_context *ctx = data;
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
+	if (hashfile_total(f) != chunk_offsets[num_chunks])
 		BUG("incorrect final offset %"PRIu64" != %"PRIu64,
-		    written,
+		    hashfile_total(f),
 		    chunk_offsets[num_chunks]);
 
 	finalize_hashfile(f, NULL, CSUM_FSYNC | CSUM_HASH_IN_STREAM);
-- 
gitgitgadget

