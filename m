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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D61BAC433E0
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 16:49:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D7E864EAF
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 16:49:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233829AbhBRQs2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Feb 2021 11:48:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233582AbhBROIx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Feb 2021 09:08:53 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AE86C0617A9
        for <git@vger.kernel.org>; Thu, 18 Feb 2021 06:07:50 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id r21so3106696wrr.9
        for <git@vger.kernel.org>; Thu, 18 Feb 2021 06:07:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=NkNbJX5oDO/3vy/Iuipy5TUY0HICiEs4cK5g77JnPHI=;
        b=gubnnsDeIjJjBLPNdK3BnyajDqspJUygtce8Lb6Dzomrt9A7cuoYJ4aiHEkwb4DHJB
         ao0hOkKjnsD14TmPmuJb0zfRwTQOJMwoJJm0RgxbtB5pxIURaPVrbx9tFudWdm3Vud8V
         5qW3PcR64PtEJcoSXgZhE1AIdZ6P/yUvQQt2uKqJOBDw3BhYEY2T9R4W3asCbF7eB7RU
         CKzwLbsDdmiGHfhv4UR7AuRHQ1aI1m0680HKPQ6JJeJAXiN0osDqr5heFwuMlbkIhnzo
         v6dH007uzkuEC6iRlZsmGym6f+uPpum7NnQAQsENcZ13Jl6oGmo+ebdGaFUNW7nfzxAN
         VKPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=NkNbJX5oDO/3vy/Iuipy5TUY0HICiEs4cK5g77JnPHI=;
        b=iiSNC6P2JXWdcSekXCml7ej2N+fLd+XfB3LhFJ0K6japjlRRZ4zWar7PfMmwjn7uKN
         HCzwv7PHCIeHAW3PbUJuecHVatdiC1nFUMBJmLKYi47eInFClytDscP+aH91Ne7ICuJ2
         FGqKEAdlF8U2yRKNrzddfr3ENIzx11s3S91s+HYnJVbSbPKtSw9u/Rfz7tmw/zplyQdw
         q6tmrgd5oaMNsvXp0TLRuwzNpOr7WwJDLoQGgFTJQlcvDD492/jjkL1sTfpxyeezRro4
         cQLabfN7K0lAd5hxOrHHV01bGmlLtoRQCCFy2zSHkknir+d5gGiLgbee+/P3uoVNzb55
         E8ug==
X-Gm-Message-State: AOAM531Y0awyQm7bssInRw7xPrB33HWcGMxQCgnclX5CbqHiU5XrO/m2
        M4eI9JS5UEeWjkvIu4EoroRdiESGoFU=
X-Google-Smtp-Source: ABdhPJxxK8BDDyxACEZgMaQqTzEBW+BI6oJLCa9zxTRU/PsxmYfZdz3RIexeF2SReI8zHG5Pq/631w==
X-Received: by 2002:a5d:6b45:: with SMTP id x5mr4363763wrw.415.1613657269100;
        Thu, 18 Feb 2021 06:07:49 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a21sm9459489wmb.5.2021.02.18.06.07.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Feb 2021 06:07:48 -0800 (PST)
Message-Id: <f5baadf276ff08549530f0cadc1658705fa46a51.1613657259.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.848.v4.git.1613657259.gitgitgadget@gmail.com>
References: <pull.848.v3.git.1612535452.gitgitgadget@gmail.com>
        <pull.848.v4.git.1613657259.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 18 Feb 2021 14:07:30 +0000
Subject: [PATCH v4 08/17] midx: add num_large_offsets to write_midx_context
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

