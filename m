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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC936C433E6
	for <git@archiver.kernel.org>; Wed, 27 Jan 2021 15:58:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63445207D0
	for <git@archiver.kernel.org>; Wed, 27 Jan 2021 15:58:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236843AbhA0P5m (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Jan 2021 10:57:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235315AbhA0PDH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jan 2021 10:03:07 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96AF0C0612F2
        for <git@vger.kernel.org>; Wed, 27 Jan 2021 07:02:08 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id m187so1806148wme.2
        for <git@vger.kernel.org>; Wed, 27 Jan 2021 07:02:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=CiliLAMun0gIKzobYrydAgAbTcUC3B/7iQngvKucSDE=;
        b=judR14PePSF11al1UrFhuObgrWEqAzI8GG4sn+4dFGs+PSS4dRPFrp7JAcFC/WQDxE
         9gtb3b7uo5XVp3kcJLT0IoKy0yTUu8MBmXu+t0PlGoc9tOy1gHmY36whRW758eQSrqJI
         6ZEXYPW3bQiOsj0CR2WGkk7yGEsjTeM82s0ZU3L2h6G/72uY+GL9NNecz//54IyVzdhi
         JsB7nchzNIb/bcHxyODhqu/+D7HjgOWM767osUGRER+sGxyRTf/W2QAXK55ho76ir6+C
         m3U47tMO0nx1NfLrCbiuY0v1FCO8T96Fo5HN7atc+f0q2GfTUJzlTEDVb4Ib6PSzP2bX
         WPWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=CiliLAMun0gIKzobYrydAgAbTcUC3B/7iQngvKucSDE=;
        b=CVfSX9bdm0EdAuTUiTRnIS6+XTwVEgcCQ2SV2PZpjj+b/MmN5tjXoxPKqzlh3WY81Y
         r+OfIKBm6b526JH04WhY4XQggf4291a73+upcrZoFCJiOZZhiXIdracIgXHaLZ9jzdAe
         LB5YVSzAMrOKLBp6ACCm4wjZTis7GPiC/PADm1B+R4bzSKZbN4a25p3wPRycGQEjJh4R
         MWhHH8HFbPhFFzQiUhQ5BmjRT5M7MZvedO8WebfbBCoDXK79zBe84Ra1LzcW/GjAshU+
         TZqZLTIvKG4aVcv4wfmx0UuZ+mmQhg+hZoWGmacm7m3v+o14P40nogHqtQP4UiOY1PcV
         7yhQ==
X-Gm-Message-State: AOAM530XhSGARthESTB3M+47vW5NqTDlUmBLQW0LLkgTnzRtzFcRZc2Z
        hiLMgsElLjEZ1h3E2omefVKdBbqIXOM=
X-Google-Smtp-Source: ABdhPJx9i+1YEuWxUnP6bHm+T4ARxLSxAImMouUiUiomHuk1PL/pSXiZuDJ7u6l0LFWaW37gvVR1Jg==
X-Received: by 2002:a1c:2003:: with SMTP id g3mr4493728wmg.90.1611759727137;
        Wed, 27 Jan 2021 07:02:07 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u16sm3077255wrn.68.2021.01.27.07.02.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jan 2021 07:02:06 -0800 (PST)
Message-Id: <c4939548e51cd22fdf32609224deecd57d49b690.1611759716.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.848.v2.git.1611759716.gitgitgadget@gmail.com>
References: <pull.848.git.1611676886.gitgitgadget@gmail.com>
        <pull.848.v2.git.1611759716.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 27 Jan 2021 15:01:47 +0000
Subject: [PATCH v2 08/17] midx: add num_large_offsets to write_midx_context
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
index cd994e333ec..5be081f229a 100644
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

