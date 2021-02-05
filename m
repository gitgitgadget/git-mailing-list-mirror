Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2969C43381
	for <git@archiver.kernel.org>; Fri,  5 Feb 2021 22:02:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF9F064F92
	for <git@archiver.kernel.org>; Fri,  5 Feb 2021 22:02:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231274AbhBEWB3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Feb 2021 17:01:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232901AbhBEO4S (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Feb 2021 09:56:18 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F44FC06174A
        for <git@vger.kernel.org>; Fri,  5 Feb 2021 08:33:48 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id h12so10695019lfp.9
        for <git@vger.kernel.org>; Fri, 05 Feb 2021 08:33:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=NkNbJX5oDO/3vy/Iuipy5TUY0HICiEs4cK5g77JnPHI=;
        b=gJXTbB76gyUOT7evytkclMOdSMZkV68OiyizaRHclyJX4r3EJD72RsXerrbXMbjGIg
         JvqvftiKrVvyYVcAn0Vcqjrov5gLMjUbxlSvVk6SgPf8ohRKmCNYip12e4AsCwEKUxU6
         18ysmBanZjk113Faw+KeI7KmjoPO7OEqXtmyoGjAVbqn9lxYR4ELYCD4ix6WXCf/3Bng
         DkTTD6NfDo9cGvShNhMYpp7Yjf/LUAn08x4y4MllJweT+zy5z6GFGZV6PnrWL9SOocZ+
         ujQMoqVgqFvcFjPgSEh+Suw0zBQY8roTatmQxpL41XSoFr0VmwtIbHrBEg9szYGDCUOF
         T15A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=NkNbJX5oDO/3vy/Iuipy5TUY0HICiEs4cK5g77JnPHI=;
        b=rq4/hsNGom34D1ez0lF7xpqbfGLpdqFAtYytO7bIG0JcyBthBCQ/7AhgkmzrsHcJQu
         Lb05oixh4b9nsfE4GoacWblxYUSklDt4MYhM+FnZ2gwfT20F+FCYCzpg9VYnZegejEuF
         4OVFh8oq2/UvLRgwTZ5DYe2PcRYMUCzzeoG75wDR0bm8N3DcjKQljOnj2A4MA1DJQeuC
         O5XT0hHq7HZAnA83iQte+YV/dazfQuY5dsQAbgNliOYIsyWweUYqpd3XXeJHZIqdjG7a
         ZymTZB51M0UbKtz3jUXbOpM0Z9pBM2TBfeeFWlOtC+pxLrP3bNT+A2qEtSFm/abHSf7b
         9zeA==
X-Gm-Message-State: AOAM531MKHpn9LFd+IXFHOQC+ifFwZTYwPnWp9Cf8pag7HLPdjKt+/O9
        of7QtpepaN3kfzTqZDBEnX+7g36+2sQ=
X-Google-Smtp-Source: ABdhPJwknqFr5O5T+91Ig6VUQstcZf3Z2oNWshHIm7jKnNJUJmYwLkgDngqy+cStomYP6KAley7XPA==
X-Received: by 2002:a5d:6a8f:: with SMTP id s15mr5400245wru.252.1612535462753;
        Fri, 05 Feb 2021 06:31:02 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t197sm18934186wmt.3.2021.02.05.06.31.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 06:31:02 -0800 (PST)
Message-Id: <e7064512ab7fe8abda200a98fee26346076bfb21.1612535453.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.848.v3.git.1612535452.gitgitgadget@gmail.com>
References: <pull.848.v2.git.1611759716.gitgitgadget@gmail.com>
        <pull.848.v3.git.1612535452.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 05 Feb 2021 14:30:43 +0000
Subject: [PATCH v3 08/17] midx: add num_large_offsets to write_midx_context
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
change collects the "uint32_t num_large_offsets" into the context. With
this new data, write_midx_large_offsets() now matches the
chunk_write_fn type.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 midx.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/midx.c b/midx.c
index cd994e333ecb..5be081f229ad 100644
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
+	struct write_midx_context *ctx = data;
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

