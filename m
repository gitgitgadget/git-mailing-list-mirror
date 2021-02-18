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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 336E7C433DB
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 16:49:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA3F764EB1
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 16:49:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233894AbhBRQtN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Feb 2021 11:49:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233581AbhBROIx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Feb 2021 09:08:53 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83C96C0617AA
        for <git@vger.kernel.org>; Thu, 18 Feb 2021 06:07:51 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id v14so3122178wro.7
        for <git@vger.kernel.org>; Thu, 18 Feb 2021 06:07:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=9rbRQ+4gSMEK2h+y1E/hg18dGvaKEJCIVpGJN9anMY4=;
        b=LdUnTSUSWpfbO+aUOF6oSZbwmImcMTL5/EJD5NUmTWgl2Vtnk1KKy7CtHPKib/GJIb
         bWt3MPOL2AMH/B3Yo8TqS2jlU9h4staUnNl5oxSxyORGjBztR7YaiGXqtEaNLLuzv1PJ
         ciJXNXzn5PgoSmzom48VU5vViY2CsIPr3qcrBcwQNh3hAK2B3ZWVhS9amYXjEKKgsmz7
         rOODlK+nrNfpAkUumniBBguZm+FtbuKV4WK3qKdHsuxJmUh2JTKeN/bXceA7IzyDpJIQ
         iH4s2hVBWrAD2K9kTG6NvzDYAGzA/pHYxS6q+dWhJVjuQjj4dZFF/PCL8jxw0TH5e3Lp
         faHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=9rbRQ+4gSMEK2h+y1E/hg18dGvaKEJCIVpGJN9anMY4=;
        b=tqYtj3Y/ZDyRhWOczAVsIIWf5FKcHAeZEpzRXp3eb/otXOxZho6Ai2jivox/xXfaUH
         HEuX5EWWy97yufdyWUFucBfSqlyPBv/PMfLNoBcyk8lJmE0skprdKc5t0kFuptXIpPAz
         yWIUlu6SMyKY4j5tPTXqBvu1bg3PTT2B9v7eR/v2JTVIs8Ohq3tBJls/RORdmWR/B6P1
         bscBz+Qyoecee/wUfHBq97uAPMZmIcp8tGy+b/Ogicj+Nly4zIB2ZbFXhGUnENXS76Es
         i1eUhkWRQC3FhwHlb9Bf1IL2A03xcGS34xVj+SgonoMpKZy65IrbLT9eWkq6ZnOJJaeL
         /Ayw==
X-Gm-Message-State: AOAM533xe9YXEM/+87U0GmKayRPkzcY5qb/SIKg+ABWhNMUGnpKZylQw
        KDpTGHP33x7+FKlU+shWRyYi8NrVxiI=
X-Google-Smtp-Source: ABdhPJyfRwzw/3zkMtHgRbvc3u2Z0EWVCMP360gOjVvfZ6Zt2wRePoGHaV674qC9NWzlIi3cNvuwZg==
X-Received: by 2002:a5d:6881:: with SMTP id h1mr4481976wru.384.1613657270206;
        Thu, 18 Feb 2021 06:07:50 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r7sm7582156wmh.38.2021.02.18.06.07.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Feb 2021 06:07:49 -0800 (PST)
Message-Id: <fd008449fc89602411ddd3d607b4e5e10608b7e4.1613657259.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.848.v4.git.1613657259.gitgitgadget@gmail.com>
References: <pull.848.v3.git.1612535452.gitgitgadget@gmail.com>
        <pull.848.v4.git.1613657259.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 18 Feb 2021 14:07:31 +0000
Subject: [PATCH v4 09/17] midx: return success/failure in chunk write methods
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

