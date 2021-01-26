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
	by smtp.lore.kernel.org (Postfix) with ESMTP id F38F7C433E9
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 16:06:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BACD32229C
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 16:06:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404633AbhAZQGQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Jan 2021 11:06:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404626AbhAZQC7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jan 2021 11:02:59 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3FEBC0698C4
        for <git@vger.kernel.org>; Tue, 26 Jan 2021 08:01:38 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id 6so17019518wri.3
        for <git@vger.kernel.org>; Tue, 26 Jan 2021 08:01:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=K4ZTH2mLu/dyy12r/5xQIKPI71QJPC6RYXCaS+e8/EQ=;
        b=rXgUGnBhw3765Up8gtwAx7APSHm8Ie/1NGZUoGyAqFtM6gC4XmJR9UGWK/VTmXJQ93
         kgusDOyueuRhuHLDB/brUP7lyyNVBbOJ+w2jUb5RCrbdIK3jW+0zvs9FgCDuoltvKtjx
         DvmzR5jIjKeqKA5oBz5MS3BerqHXNk+SvJAXK+A5i/eOZH3IpInwcfQyqKEeYh6VbcYS
         SBAw2EmJK3QMyVirxtQp3ZqGtGcHEAFLTt5+GtQY0e/rE4bIVQhHhT+Is6FA3dd6iPqk
         geNp/RjPvRP2VRp5NlJapdHm30LwiE/xNm16wycFWmN9J+DjvmT4f/fXcqVYCyl9fs2I
         GMWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=K4ZTH2mLu/dyy12r/5xQIKPI71QJPC6RYXCaS+e8/EQ=;
        b=fSu5fpmQfLEtjOIkjOUmONpYLV+/MNpoG4gTilWiynKWK6PXiZ1WZVvT+K4B+ElRRM
         enyZAQXbvkcNNczfvE+K3Tl1Tyga/QVizn0yqj3hy8sdqb1rD3vD5xc3VLhFdm0XAYHb
         ag9X6xMiHoi35fyAejWeLSb9HSlH6z8XAw942xuu0wQuhRDN+Tcym+3F1/En1CO4p209
         wGLKM/lIZn44vonV3S6ujLDqymoJzclHJKOpEVc/95LZf+FL1pre84p+1ELZ9Bj1asaD
         jekooQNndTmCiV1upWzWft1vRPhv/DBlX1EYqA++VDHADEEr6+EuQho822CFPuGX+XvE
         uRoA==
X-Gm-Message-State: AOAM533wr1mdtKZXVHB/SkC6TwZxe9QHBnQF4OtMhFk3hLBgEalcTASZ
        kj++ZgUK308DbfBm0AwLbSokjovhoJM=
X-Google-Smtp-Source: ABdhPJxC314SVajJ7YkPkqHPOBf1df5v4+u7mGJmvo7DmDuUS+06uabIC29oWKLTSjXp6H0m2PdOOw==
X-Received: by 2002:adf:efc2:: with SMTP id i2mr6621398wrp.422.1611676897635;
        Tue, 26 Jan 2021 08:01:37 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m184sm3518530wmf.12.2021.01.26.08.01.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 08:01:37 -0800 (PST)
Message-Id: <e613ffa9ac639664c37989019bdc6b749dc00e4f.1611676886.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.848.git.1611676886.gitgitgadget@gmail.com>
References: <pull.848.git.1611676886.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 26 Jan 2021 16:01:19 +0000
Subject: [PATCH 10/17] midx: drop chunk progress during write
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
index 852dd5b776e..145c6bd0913 100644
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
 
 	if (f->total + f->offset != chunk_offsets[num_chunks])
 		BUG("incorrect final offset %"PRIu64" != %"PRIu64,
-- 
gitgitgadget

