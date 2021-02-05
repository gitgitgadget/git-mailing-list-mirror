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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86DB5C433DB
	for <git@archiver.kernel.org>; Fri,  5 Feb 2021 16:26:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A78464DB2
	for <git@archiver.kernel.org>; Fri,  5 Feb 2021 16:26:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232819AbhBEOqq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Feb 2021 09:46:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232072AbhBEOje (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Feb 2021 09:39:34 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 432F9C0613D6
        for <git@vger.kernel.org>; Fri,  5 Feb 2021 08:17:38 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id f14so12762836ejc.8
        for <git@vger.kernel.org>; Fri, 05 Feb 2021 08:17:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=u7s4MNAI8c5xo75w4IpgbLg/3f46uKnaaEAr+lPMDu4=;
        b=Jgh46hPt3J+ykBRb/PDCNFRwzlWg/PnkVMoCscsXERfhJ6hfM5NFU+RYOR8s7odHl/
         B9GZ2Yb/qmIx8c3EHWiIkt91TNmWNdU/W1YiyndsBIV5sApm4NAKZFiS0qUjN9wI4l0N
         p6drSdv28HgCT4Bgah1mTj7vGXJMTP4txJjsURXsruDFsjJAxXUcQMru9zgFBKMrpWpH
         PiYaNd2UsZKJosRuaczh9nNdMHe91ZXRHejeaji39ZsKVe+mMwm3cir9zMpNXyOnbbzp
         8v7Y9gZLYlk/WAFwTW3rRM4JPQ8H59jAOT6LpTWEyrYHkpjH5Z4itHP/x1K7El162H9b
         950A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=u7s4MNAI8c5xo75w4IpgbLg/3f46uKnaaEAr+lPMDu4=;
        b=b/GN136EgL5J+m4jEm4vA6Cny1bwcuUpO79AbXcWjmLaUU3UAKkrz6Vzz6rtcU9XwE
         lTL/TC6xDWM70CB+YKLpwFyKdrIfIpRqlYF39i5Kh+fje0NUakVb1jTp3v8tKPrj9hCb
         nWTmhbxVHRfn1KHXM2NXRiVI359u+c9jkNQ7Ae5yabI/8kw5TiWhuU2RKITQ/+9Bd0b+
         hYbke/NOmjU57LZsmZRDyrOthxMShOMZByuOMgxKVHSIqcgTpgtqngC0yL8WrAP0bcpv
         RLTFWIeRf6QDMv/MfVdRiyJzS1YUARLMpWDzV4ZkYVQN6O9WO3oGU7gs4R11/O68Zajs
         clOQ==
X-Gm-Message-State: AOAM531Xz8oywK9FU2AN7rV5NnRCgOvhXLdgArovzZhNsiNMn5BsW2Nj
        QzU1Gu4oQ1eUIKXrDwVec9t5oVXCG78=
X-Google-Smtp-Source: ABdhPJwVfuDnbVKeFdvnjhYTSuRw9xQW/3WZxq0/doKcrbws5L6zGHa8VO3cERtCsCT+GReArDPQ2A==
X-Received: by 2002:adf:e48f:: with SMTP id i15mr5183549wrm.135.1612535464867;
        Fri, 05 Feb 2021 06:31:04 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c62sm9114100wmd.43.2021.02.05.06.31.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 06:31:04 -0800 (PST)
Message-Id: <70f68c95e479b9d6476e070922514a4a1f05fd3b.1612535453.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.848.v3.git.1612535452.gitgitgadget@gmail.com>
References: <pull.848.v2.git.1611759716.gitgitgadget@gmail.com>
        <pull.848.v3.git.1612535452.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 05 Feb 2021 14:30:45 +0000
Subject: [PATCH v3 10/17] midx: drop chunk progress during write
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

