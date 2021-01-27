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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB9ADC433E0
	for <git@archiver.kernel.org>; Wed, 27 Jan 2021 15:35:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65EA5207D2
	for <git@archiver.kernel.org>; Wed, 27 Jan 2021 15:35:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236266AbhA0PfL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Jan 2021 10:35:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235671AbhA0PE2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jan 2021 10:04:28 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1E2EC061786
        for <git@vger.kernel.org>; Wed, 27 Jan 2021 07:02:15 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id z6so2192066wrq.10
        for <git@vger.kernel.org>; Wed, 27 Jan 2021 07:02:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=xNckMs8XzXWvH6kN0+MYbu3bWWVHwDNLRLn5SXuuQkw=;
        b=n46KnaP1x2HZrVcs/HdBXVAaXZX74BmRGtfz7M52CtEE1seyvI3SG6O3oL591XGRBw
         jT8Owsv6kUXXEswCu3gKvetlCyhJUjwpL3eguUaUc0aZzUeJdkQ8JVBe7aFsviho5/Ow
         St9d8kjSvdWNEE+OhujcdXvryb6g7r/9b/bmUSik5NLZqjo+DLyrGvjV09TzDx4p4OPT
         kr4L4K9E38my79eYTqdZWOSJYjFeEXAnZH3L2YVSCPBBNvd0EGujRZUQ7QXxXR5Kb/FR
         KstCVrZhoI6vcpTeuhhpBiPZqNprDSY3hP7eX8mSg71GT34uYlZfOMk74DXFrNqx5M5O
         2xGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=xNckMs8XzXWvH6kN0+MYbu3bWWVHwDNLRLn5SXuuQkw=;
        b=Bx+M6k51w3rG4wBi2UFoCTm+dfQk1aqrR737gV4upukwfnt4+kinGmg3c5DfjpdiKm
         OM0jUtoorjyjb33D82UzQPHbpCQnQQIrKwY+G55mJhgBFXkcLMQ2nmp4sy2zrVIFRU60
         1ws8GkY+vHlLo55Uze9CY2oT6BYkRgM0C1B+GJqSRVykZyfN0Mv/Nr/HYdZgdL4qhSXZ
         fBU7G/NLj8h+/vNMVRVHBF3+ruluE8+vW6VGy1SOq6u7qAM0dNBeYh7GDZeUsf7ou4h1
         J2UfKyH76zu1FqJLajQzGLi9fM4X/88qTIS7cNw5SK4b4FAI+wilVJXWzOubRzS341MJ
         RuUg==
X-Gm-Message-State: AOAM532SBVm001JJR0EtcCM/HuwxvKpUIaq6Fe9HO+ZCVzgcQAQJ1rLU
        TGTrjgU8C7fDzY6wwJbb+Xxi1M2on5Q=
X-Google-Smtp-Source: ABdhPJxFUu6U+dU2pPy2O2jdfTgeQ/PWjsXWipe027no53oTPKesjDkwSZGb2NaelvuymM+L9htzfg==
X-Received: by 2002:a05:6000:1565:: with SMTP id 5mr11849044wrz.109.1611759734383;
        Wed, 27 Jan 2021 07:02:14 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a184sm2939004wme.35.2021.01.27.07.02.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jan 2021 07:02:13 -0800 (PST)
Message-Id: <83d292532a0fa3f3a0ad343421be4a99a03471d0.1611759716.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.848.v2.git.1611759716.gitgitgadget@gmail.com>
References: <pull.848.git.1611676886.gitgitgadget@gmail.com>
        <pull.848.v2.git.1611759716.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 27 Jan 2021 15:01:54 +0000
Subject: [PATCH v2 15/17] midx: use 64-bit multiplication for chunk sizes
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

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 midx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/midx.c b/midx.c
index e94dcd34b7f..a365dac6bbc 100644
--- a/midx.c
+++ b/midx.c
@@ -913,7 +913,7 @@ static int write_midx_internal(const char *object_dir, struct multi_pack_index *
 	add_chunk(cf, MIDX_CHUNKID_OIDFANOUT,
 		  write_midx_oid_fanout, MIDX_CHUNK_FANOUT_SIZE);
 	add_chunk(cf, MIDX_CHUNKID_OIDLOOKUP,
-		  write_midx_oid_lookup, ctx.entries_nr * the_hash_algo->rawsz);
+		  write_midx_oid_lookup, (uint64_t)ctx.entries_nr * the_hash_algo->rawsz);
 	add_chunk(cf, MIDX_CHUNKID_OBJECTOFFSETS,
 		  write_midx_object_offsets,
 		  ctx.entries_nr * MIDX_CHUNK_OFFSET_WIDTH);
@@ -921,7 +921,7 @@ static int write_midx_internal(const char *object_dir, struct multi_pack_index *
 	if (ctx.large_offsets_needed)
 		add_chunk(cf, MIDX_CHUNKID_LARGEOFFSETS,
 			write_midx_large_offsets,
-			ctx.num_large_offsets * MIDX_CHUNK_LARGE_OFFSET_WIDTH);
+			(uint64_t)ctx.num_large_offsets * MIDX_CHUNK_LARGE_OFFSET_WIDTH);
 
 	write_midx_header(f, get_num_chunks(cf), ctx.nr - dropped_packs);
 	write_chunkfile(cf, &ctx);
-- 
gitgitgadget

