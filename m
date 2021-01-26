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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 920BDC433E0
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 16:06:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 605B8207B3
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 16:06:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404545AbhAZQFs (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Jan 2021 11:05:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404657AbhAZQDO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jan 2021 11:03:14 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2EE3C0698C9
        for <git@vger.kernel.org>; Tue, 26 Jan 2021 08:01:43 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id f16so2881958wmq.5
        for <git@vger.kernel.org>; Tue, 26 Jan 2021 08:01:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=tScQM6HseLjvMkUwY+RsUDvgpbJ4oohiYQmpQI2/Y2A=;
        b=A939UeWUDuo4T1RZs5hgdyiqBVf9YWpYWsw2BCcsvPtT1065UZBfILdL8GuSfYSreW
         WDyBvwpsKOWsQfloz/40V5FfHbS2MinSP7+PCPDRFeKsaU+nFfIps/jU+dExgQipA5Pe
         QtakY80R5YeOwYmPw+jWJyRqh7U8MMW9xos0+CV3ig5kgeB1edeyYpByVp3zZF+kADbg
         6NkYnH6gMDxH6U82rNlqJuI+D6HlFD5fGKyhOxPfAhlo9aWU9jzuD3ZupXdQiYWoM8gT
         f6v7EQB2lv7+i0ElibBvmHgtDlPro7ylAnCwe84TQBurgT51D2YjrrCmzOX+toK95B3F
         gTPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=tScQM6HseLjvMkUwY+RsUDvgpbJ4oohiYQmpQI2/Y2A=;
        b=FzZUzSpOmdQlMf1ImVumn28imj3yjneecVm1UaKWLjedBQ9t7c2OHnw08vlaVIYMjS
         4v6BFq/ATSJVRDLC7fWYnijaKsjmoev/QWpIulRGP8NqnUgfMsY4P6JbQS3grgYZtuwi
         bpGjGFCAxwucUJ/7OhV5NsWcMdd62A7gNexwxI71FeJQYV4+ObAwyGSFwnCw2WyF6bwz
         9+mODaxjP48VL1gqGQEwXv7+ZOD42OAymF7aCbO2fuMNUQ0Q6rtlnldVUBlDOsysTDXR
         IcDxSk66nnYHkuj3g6x4SWoX6p2cC3+XCz1Wa8O9HkZqQdY7sNpYfpzr9iiwAfyYQ6Pw
         2KOQ==
X-Gm-Message-State: AOAM531XAJPhmq/n5VHbEqy/ZpD3oJpBJKfaa3uzMLgfGwDhx+/CkyUT
        f2PB+pKdksWVMHN14FmMRtKOBJ5Urns=
X-Google-Smtp-Source: ABdhPJzL98u3z9d5sj3noZZUZZzaBDXNJQPOhNtorTEdufC/kiLMdqSGzwzEbO84DzDuNTgw3cL45Q==
X-Received: by 2002:a1c:b657:: with SMTP id g84mr400903wmf.52.1611676902373;
        Tue, 26 Jan 2021 08:01:42 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f17sm21054288wrv.0.2021.01.26.08.01.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 08:01:41 -0800 (PST)
Message-Id: <f6c58ff72d24ec166d5d9b661c433bcb13377fd2.1611676886.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.848.git.1611676886.gitgitgadget@gmail.com>
References: <pull.848.git.1611676886.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 26 Jan 2021 16:01:24 +0000
Subject: [PATCH 15/17] midx: use 64-bit multiplication for chunk sizes
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, gitster@pobox.com, l.s.r@web.de,
        szeder.dev@gmail.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

When calculating the sizes of certain chunks, we should use 64-bit
multiplication always. This allows us to properly predict the chunk
sizes without risk of overflow.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 midx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/midx.c b/midx.c
index dd019c00795..47aaeb804b8 100644
--- a/midx.c
+++ b/midx.c
@@ -945,7 +945,7 @@ static int write_midx_internal(const char *object_dir, struct multi_pack_index *
 	add_chunk(cf, MIDX_CHUNKID_OIDFANOUT,
 		  write_midx_oid_fanout, MIDX_CHUNK_FANOUT_SIZE);
 	add_chunk(cf, MIDX_CHUNKID_OIDLOOKUP,
-		  write_midx_oid_lookup, ctx.entries_nr * the_hash_algo->rawsz);
+		  write_midx_oid_lookup, (uint64_t)ctx.entries_nr * the_hash_algo->rawsz);
 	add_chunk(cf, MIDX_CHUNKID_OBJECTOFFSETS,
 		  write_midx_object_offsets,
 		  ctx.entries_nr * MIDX_CHUNK_OFFSET_WIDTH);
@@ -953,7 +953,7 @@ static int write_midx_internal(const char *object_dir, struct multi_pack_index *
 	if (ctx.large_offsets_needed)
 		add_chunk(cf, MIDX_CHUNKID_LARGEOFFSETS,
 			write_midx_large_offsets,
-			ctx.num_large_offsets * MIDX_CHUNK_LARGE_OFFSET_WIDTH);
+			(uint64_t)ctx.num_large_offsets * MIDX_CHUNK_LARGE_OFFSET_WIDTH);
 
 	write_midx_header(f, get_num_chunks(cf), ctx.nr - dropped_packs);
 	write_chunkfile(cf, &ctx);
-- 
gitgitgadget

