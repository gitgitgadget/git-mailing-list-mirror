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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD942C433DB
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 16:54:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A2FA64DFF
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 16:54:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233945AbhBRQwx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Feb 2021 11:52:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233213AbhBROKo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Feb 2021 09:10:44 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 978F2C06121F
        for <git@vger.kernel.org>; Thu, 18 Feb 2021 06:07:58 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id t15so3062453wrx.13
        for <git@vger.kernel.org>; Thu, 18 Feb 2021 06:07:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=yscnHumNb1Jj70TIpFXz3x1VXJQ6sM+kbPFEjpzuA5k=;
        b=UYg/1F5DauVyr0r0lVjTB58OqFj35k2QCm07WseMaXB1sFrhw08lJT+lJAfd05Z9hh
         NoArpIf79UlUtmkWW5c0PTvS2UPKVtx6A1XWv7d5sYgp9lo5wbOqIYbph4Iza/SdyL+L
         kWCnaz/J+y9eUMhuL1Vf8xOX1gheMM7uvO08Be1YOW5oU1rL+E7enWJY+HZZwFQ0DUPD
         hjY1jdh5b4P+g5Zek+8c0jNirGdXqdRG+ibnTEDOpUo5dG/kYm/2t7xOV3LPiDZ+wk4f
         nB3L/D/w07WLkggSpllVcDBz2GTXxRYZoEm5DLD/qh1mxyEu+IN6q0AGbKYvGY3sDx6L
         p8nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=yscnHumNb1Jj70TIpFXz3x1VXJQ6sM+kbPFEjpzuA5k=;
        b=IBhsKSBoGPsjFfdwhgVLCRG/RxJPiYjlbUMNoyq3UT61E66Uip9gaMd+nOBVCf1Pbm
         Kr3ymDVVhc+pko9VKvRb/L+7ZsiDt7/3mAMhJs1Y+yg4b6RrIUiCo82769wgcV51criH
         6DXF8HjeOSn0oMtH+ofUkTt34FP/MOUVvPLvdsG2CAaTs8IVbQKo9/WGNUsy2C6/+J41
         x7TroC7hdsHq28sT7DQtmPQzdqv9I+M+VoTxwb9L4y5CAfijqUnb/gzJCZYxGZjnakCw
         KCn55PzXZvmUMZVNx70mTb6aKpivcNwbDVpNgMTIFtYNGVzm0/YPPB4TGOATkrwK30D8
         KrXQ==
X-Gm-Message-State: AOAM531mLj696Hw8FMbm+aES7Is32pmK/X03xPveitIvGadyDmBmVeq0
        UnackcLlPb+dUn6fI9vBa1lmQF9J9Vs=
X-Google-Smtp-Source: ABdhPJxIqQcFzCugH6R8ukUiH40zF4KxwkykU8Vh3LR9J2C7bI6QJONTDtkw1cB/XvX805X/kuCGow==
X-Received: by 2002:adf:b749:: with SMTP id n9mr4462127wre.267.1613657277333;
        Thu, 18 Feb 2021 06:07:57 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f7sm10582879wrw.81.2021.02.18.06.07.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Feb 2021 06:07:56 -0800 (PST)
Message-Id: <16205d8f8c408ffe17da366812483e1575700d7d.1613657260.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.848.v4.git.1613657259.gitgitgadget@gmail.com>
References: <pull.848.v3.git.1612535452.gitgitgadget@gmail.com>
        <pull.848.v4.git.1613657259.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 18 Feb 2021 14:07:37 +0000
Subject: [PATCH v4 15/17] midx: use 64-bit multiplication for chunk sizes
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

When calculating the sizes of certain chunks, we should use 64-bit
multiplication always. This allows us to properly predict the chunk
sizes without risk of overflow.

Other possible overflows were discovered by evaluating each
multiplication in midx.c and ensuring that at least one side of the
operator was of type size_t or off_t.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 midx.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/midx.c b/midx.c
index d7ea0d1375fa..5c7f2ed23330 100644
--- a/midx.c
+++ b/midx.c
@@ -244,7 +244,7 @@ static off_t nth_midxed_offset(struct multi_pack_index *m, uint32_t pos)
 	const unsigned char *offset_data;
 	uint32_t offset32;
 
-	offset_data = m->chunk_object_offsets + pos * MIDX_CHUNK_OFFSET_WIDTH;
+	offset_data = m->chunk_object_offsets + (off_t)pos * MIDX_CHUNK_OFFSET_WIDTH;
 	offset32 = get_be32(offset_data + sizeof(uint32_t));
 
 	if (m->chunk_large_offsets && offset32 & MIDX_LARGE_OFFSET_NEEDED) {
@@ -260,7 +260,8 @@ static off_t nth_midxed_offset(struct multi_pack_index *m, uint32_t pos)
 
 static uint32_t nth_midxed_pack_int_id(struct multi_pack_index *m, uint32_t pos)
 {
-	return get_be32(m->chunk_object_offsets + pos * MIDX_CHUNK_OFFSET_WIDTH);
+	return get_be32(m->chunk_object_offsets +
+			(off_t)pos * MIDX_CHUNK_OFFSET_WIDTH);
 }
 
 static int nth_midxed_pack_entry(struct repository *r,
@@ -912,15 +913,15 @@ static int write_midx_internal(const char *object_dir, struct multi_pack_index *
 	add_chunk(cf, MIDX_CHUNKID_OIDFANOUT, MIDX_CHUNK_FANOUT_SIZE,
 		  write_midx_oid_fanout);
 	add_chunk(cf, MIDX_CHUNKID_OIDLOOKUP,
-		  ctx.entries_nr * the_hash_algo->rawsz,
+		  (size_t)ctx.entries_nr * the_hash_algo->rawsz,
 		  write_midx_oid_lookup);
 	add_chunk(cf, MIDX_CHUNKID_OBJECTOFFSETS,
-		  ctx.entries_nr * MIDX_CHUNK_OFFSET_WIDTH,
+		  (size_t)ctx.entries_nr * MIDX_CHUNK_OFFSET_WIDTH,
 		  write_midx_object_offsets);
 
 	if (ctx.large_offsets_needed)
 		add_chunk(cf, MIDX_CHUNKID_LARGEOFFSETS,
-			ctx.num_large_offsets * MIDX_CHUNK_LARGE_OFFSET_WIDTH,
+			(size_t)ctx.num_large_offsets * MIDX_CHUNK_LARGE_OFFSET_WIDTH,
 			write_midx_large_offsets);
 
 	write_midx_header(f, get_num_chunks(cf), ctx.nr - dropped_packs);
-- 
gitgitgadget

