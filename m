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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1692C433E0
	for <git@archiver.kernel.org>; Fri,  5 Feb 2021 21:44:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95D4264E33
	for <git@archiver.kernel.org>; Fri,  5 Feb 2021 21:44:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231430AbhBEVnl (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Feb 2021 16:43:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233015AbhBEO76 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Feb 2021 09:59:58 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5422C061574
        for <git@vger.kernel.org>; Fri,  5 Feb 2021 08:37:01 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id f2so8441631ljp.11
        for <git@vger.kernel.org>; Fri, 05 Feb 2021 08:37:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=852UmEtFFsQyc5cH8Yvo3zgvKqaSAOmNSIfxoBcHgA0=;
        b=YycI25X2fj09ZTuRsnoMy3Mm01yPJJkPv0pHfLGYDNt/VWHUGkvPc69DnqbZwV7Ug7
         o/O2UDWn8njuPNQQdOpxEGTZuvRTuYt2fEkPUohK2HppDSc3aKqCxPMjMDTcBaqN6wUz
         LyMWB50f5SndRMZi6k97x29L6RHAm1mgeG4qa8cwY4LNHU9P/tJyjZUJ94twee6Heomz
         4Vr+TT+t/dM8rcX6HsIv0nok0rhjZHTW1q2cSFJQgcmQ34bxfUxyp1PGejmQi5ZtpXHS
         F6h9l6VyjvAIIJ54X4ScBGgaY7uBzgw0rVYLH11qPqvTNPQgK5fHSif4Q5PXnARm9Atl
         +QOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=852UmEtFFsQyc5cH8Yvo3zgvKqaSAOmNSIfxoBcHgA0=;
        b=J1iveZbxPKUkcdn1YzbKoKquYCxxESVbsaXiFzgGr3uIwaGNxYMj2rkaNfc0eDjMN8
         nfyDrBXWQZrFcBkDv9T5tfut0b1iA5tgt68R7WYesqOCp3bl82X4p2wieMDJ2JfmMCYt
         7kmS3ewvWKjf5TsRw917YBd65MjH4aZJoVmkn4ujciLhp3RPu+6BCY20fbz2IBY5L3p2
         Jali/XxFg6e87GRikjZy8iQcSnKZ63Omn2DW+MpGgv7ToWJR1tFKrFJX8OMOJGkjQb2w
         BF8nVJ3w/fgrS4KgdTUvTRask+3AYBCP/ng+yiyRfamjFVh2PxlNnv++LT2CG7mpr1Gp
         bqqQ==
X-Gm-Message-State: AOAM532kHxiD/mz+L5Y2jlbs2eelMJ/E40rhABXwrR5EHAAEk9aO1Byu
        fgQhI/4lsRkEHJv9c2QCRTRXIFP/kck=
X-Google-Smtp-Source: ABdhPJwZWebbwB2nEfKGVX0Q3bqi007jvm6gZroKfJ8v6ck4n6Mm92ccLD7dqj8y/bJ7kTWhLWsB8A==
X-Received: by 2002:adf:e384:: with SMTP id e4mr5413921wrm.13.1612535470128;
        Fri, 05 Feb 2021 06:31:10 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s23sm8815310wmc.35.2021.02.05.06.31.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 06:31:09 -0800 (PST)
Message-Id: <3cd97f389f1f59566a85e4496321ee8486ac894c.1612535453.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.848.v3.git.1612535452.gitgitgadget@gmail.com>
References: <pull.848.v2.git.1611759716.gitgitgadget@gmail.com>
        <pull.848.v3.git.1612535452.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 05 Feb 2021 14:30:50 +0000
Subject: [PATCH v3 15/17] midx: use 64-bit multiplication for chunk sizes
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
index aee9ed832d52..95648a1f368f 100644
--- a/midx.c
+++ b/midx.c
@@ -246,7 +246,7 @@ static off_t nth_midxed_offset(struct multi_pack_index *m, uint32_t pos)
 	const unsigned char *offset_data;
 	uint32_t offset32;
 
-	offset_data = m->chunk_object_offsets + pos * MIDX_CHUNK_OFFSET_WIDTH;
+	offset_data = m->chunk_object_offsets + (off_t)pos * MIDX_CHUNK_OFFSET_WIDTH;
 	offset32 = get_be32(offset_data + sizeof(uint32_t));
 
 	if (m->chunk_large_offsets && offset32 & MIDX_LARGE_OFFSET_NEEDED) {
@@ -262,7 +262,8 @@ static off_t nth_midxed_offset(struct multi_pack_index *m, uint32_t pos)
 
 static uint32_t nth_midxed_pack_int_id(struct multi_pack_index *m, uint32_t pos)
 {
-	return get_be32(m->chunk_object_offsets + pos * MIDX_CHUNK_OFFSET_WIDTH);
+	return get_be32(m->chunk_object_offsets +
+			(off_t)pos * MIDX_CHUNK_OFFSET_WIDTH);
 }
 
 static int nth_midxed_pack_entry(struct repository *r,
@@ -914,15 +915,15 @@ static int write_midx_internal(const char *object_dir, struct multi_pack_index *
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

