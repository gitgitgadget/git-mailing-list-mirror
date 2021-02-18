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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93CA6C433E0
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 16:51:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46A1D64EB4
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 16:51:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbhBRQtv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Feb 2021 11:49:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233580AbhBROIx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Feb 2021 09:08:53 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3514BC0617AB
        for <git@vger.kernel.org>; Thu, 18 Feb 2021 06:07:53 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id g6so3096243wrs.11
        for <git@vger.kernel.org>; Thu, 18 Feb 2021 06:07:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=u7s4MNAI8c5xo75w4IpgbLg/3f46uKnaaEAr+lPMDu4=;
        b=smNBRVlk1m7JLlQnKviszfDOAitWCMOFUjXSpVWZfpm+Pi8bfcdmAHXuMfkdiNbl3G
         qttOY8OW36qUwCUWPdSc5rjRYDg3AAVKJw06IV31BGwYGb8ilkN/oJWU03jrFF/EMOAL
         v41ysnqJZNWRVxFUS0h6mXB/+ljIKuPXfwlZUzvzTGFGW3WLBXT9SjwN7KLe6yQ/7uS4
         T1OlsKoKgez0xqAV1LxejogXCEwhml8sQqjp7XmV4q319Eh9sbowGPay+ziZWJrYI0yU
         wuw/SH6qRxo6LMPqgBzNLW8O7bqP92mNvP190Gm/GVVLtHfVH8anB8Gi3joHssL9Yd09
         +60g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=u7s4MNAI8c5xo75w4IpgbLg/3f46uKnaaEAr+lPMDu4=;
        b=AmjUp1/x19V7+GM97U/Ar/uIclsoJl4zfveMbZ/g+qn37DZPhk+MZP99s9IJ3d5154
         yYqb371sgkGYJkEiHworqniJmF/Yj16OufcymxTI+GV96i+G7lbS4mLOgenw0I/mdDFb
         6QCeXpI+wxTvsNCF1MtGBe2SB502UXx/OTvVi3FEKRGk/foxf7blODGYr1XeMKvR4nUd
         5CKhrYoObIJVvAZ8wU7T8INroy3mABSne/OwC57cZsej6H063VCKjCx4QH0rmo5ugnUR
         fuvazN1vpa4d21V1FtSr91Gvue7Mdy5EEksAFkhAgQj7klDWnrQsWy161bsNXOBxx90k
         vjRg==
X-Gm-Message-State: AOAM533Q14RrgSUJQDtx+dQ9eBGmEaoxYr82Jh97RBr+7FSokvA6bX29
        DaA8NZOVV4mLtYyzakmsBzsVQqh1Osk=
X-Google-Smtp-Source: ABdhPJy0KRre2SEbbE5qMg0M3ZNJqjvk8XoAlUkXG+sipw30Jq5ufa84TbNem++W6z0FEw1IwxALvg==
X-Received: by 2002:adf:aa08:: with SMTP id p8mr4442625wrd.232.1613657271919;
        Thu, 18 Feb 2021 06:07:51 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f14sm7705001wmc.32.2021.02.18.06.07.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Feb 2021 06:07:50 -0800 (PST)
Message-Id: <60e77e45180052cd859893cadc9dbe39ada5d06b.1613657259.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.848.v4.git.1613657259.gitgitgadget@gmail.com>
References: <pull.848.v3.git.1612535452.gitgitgadget@gmail.com>
        <pull.848.v4.git.1613657259.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 18 Feb 2021 14:07:32 +0000
Subject: [PATCH v4 10/17] midx: drop chunk progress during write
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

Most expensive operations in write_midx_internal() use the context
struct's progress member, and these indicate the process of the
expensive operations within the chunk writing methods. However, there is
a competing progress struct that counts the progress over all chunks.
This is not very helpful compared to the others, so drop it.

This also reduces our barriers to combining the chunk writing code with
chunk-format.c.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 midx.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/midx.c b/midx.c
index c92a6c47be01..4f4aa351e60e 100644
--- a/midx.c
+++ b/midx.c
@@ -808,7 +808,6 @@ static int write_midx_internal(const char *object_dir, struct multi_pack_index *
 	uint64_t header_size = 0;
 	uint32_t chunk_ids[MIDX_MAX_CHUNKS + 1];
 	uint64_t chunk_offsets[MIDX_MAX_CHUNKS + 1];
-	struct progress *progress = NULL;
 	int pack_name_concat_len = 0;
 	int dropped_packs = 0;
 	int result = 0;
@@ -976,9 +975,6 @@ static int write_midx_internal(const char *object_dir, struct multi_pack_index *
 		hashwrite_be64(f, chunk_offsets[i]);
 	}
 
-	if (flags & MIDX_PROGRESS)
-		progress = start_delayed_progress(_("Writing chunks to multi-pack-index"),
-					  num_chunks);
 	for (i = 0; i < num_chunks; i++) {
 		if (f->total + f->offset != chunk_offsets[i])
 			BUG("incorrect chunk offset (%"PRIu64" != %"PRIu64") for chunk id %"PRIx32,
@@ -1011,10 +1007,7 @@ static int write_midx_internal(const char *object_dir, struct multi_pack_index *
 				BUG("trying to write unknown chunk id %"PRIx32,
 				    chunk_ids[i]);
 		}
-
-		display_progress(progress, i + 1);
 	}
-	stop_progress(&progress);
 
 	if (hashfile_total(f) != chunk_offsets[num_chunks])
 		BUG("incorrect final offset %"PRIu64" != %"PRIu64,
-- 
gitgitgadget

