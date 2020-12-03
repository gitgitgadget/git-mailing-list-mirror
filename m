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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B94CC4361A
	for <git@archiver.kernel.org>; Thu,  3 Dec 2020 16:18:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F515207AA
	for <git@archiver.kernel.org>; Thu,  3 Dec 2020 16:18:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2501882AbgLCQST (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Dec 2020 11:18:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2501877AbgLCQSS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Dec 2020 11:18:18 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14DFCC08E861
        for <git@vger.kernel.org>; Thu,  3 Dec 2020 08:17:09 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id d3so3240434wmb.4
        for <git@vger.kernel.org>; Thu, 03 Dec 2020 08:17:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=SVA62Nk456Js/i6ZOJlkZkWfZOO+qx1nt7RrTq98D+U=;
        b=RtxrXWcf6Ll2uxab2BjA1Ql7MeTGNbcatqt5JJBfkJcbT9wbo8lEiTFIoEfYfO2zzj
         1mPQVcFyF88H2ocRAjf7036JU7lKgsjeOAzcrIUYfZHdIMNTUpJPJf7LPyTi3Na3JE3A
         A0A8LR59r2xjIuJbqatAX6tdiBQlZjZvAtaHIY+/3e/+juk+ZXCxXQLRR4d7EWuaVWmC
         ZRvPMlC54HOTV7Z9nDbqzcLxRF9tGUDGDifHDIaRkNVKn7XH5douX+ExpSzKUDiN7qhf
         mV0Bdrq70xzxflyp8DAPFsNCAaYYA3HLsl8lj/0esIdoFPTlu9Wj5EL2onOznNEHUYL0
         PxHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=SVA62Nk456Js/i6ZOJlkZkWfZOO+qx1nt7RrTq98D+U=;
        b=NciqVWSXdyxlk3fYJ+tTmqVu3o0q3HSCpOd+faGAzl06Ah/MB1jpC5+Y6sXk39rX84
         Z+s+YzgCtr9qbys3x7XrCBlZbnX9MA9ii1ZL/OniGpYX8ahODrMwNPngFYfKLpCjN5Fb
         hyY66sxqiLKu5yzaUB+IS9Ux+g+GN/W9mwpeSU4P4+6/LM5K9LYEhoK+4hOeCf9lqCgB
         UGrh3VAhZwwHlwkl1GtXpjWU9jWMcUVWwalzb9KE9Yf6ZsdwisNXAHLlWYBQdWuwnq6F
         vR6gjIwEAnyO3rRot7x/SasaQ4dgNCh3jp3b7r/U5rYuLX+B2EznsHE+WIp0aHyMncD2
         z5Kw==
X-Gm-Message-State: AOAM5317UWhT2JL9f2LJ+JVhZM2qtm4jvR3vPejpWnTCPjsVess1/33E
        pka1fSb8mdJdSm/goMgUvWP27E2frxk=
X-Google-Smtp-Source: ABdhPJywonG47Hig8O/uLKQD2ZmF3LtJRnNzcAQ+Yroa6jpoYPV2CjcclpeoalGxKxLquhGDaLhnVg==
X-Received: by 2002:a1c:4184:: with SMTP id o126mr4152963wma.107.1607012227636;
        Thu, 03 Dec 2020 08:17:07 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v64sm2234569wme.25.2020.12.03.08.17.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 08:17:07 -0800 (PST)
Message-Id: <c6a433efba3214e83a7265e53c24cb4001345f14.1607012215.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.804.git.1607012215.gitgitgadget@gmail.com>
References: <pull.804.git.1607012215.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 03 Dec 2020 16:16:50 +0000
Subject: [PATCH 11/15] midx: use 64-bit multiplication for chunk sizes
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     szeder.dev@gmail.com, me@ttaylorr.com,
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
index 0548266bea..47f5f60fcd 100644
--- a/midx.c
+++ b/midx.c
@@ -946,12 +946,12 @@ static int write_midx_internal(const char *object_dir, struct multi_pack_index *
 	chunks[2].write_fn = write_midx_oid_lookup;
 
 	chunks[3].id = MIDX_CHUNKID_OBJECTOFFSETS;
-	chunks[3].size = ctx.entries_nr * MIDX_CHUNK_OFFSET_WIDTH;
+	chunks[3].size = (uint64_t)ctx.entries_nr * MIDX_CHUNK_OFFSET_WIDTH;
 	chunks[3].write_fn = write_midx_object_offsets;
 
 	if (ctx.large_offsets_needed) {
 		chunks[4].id = MIDX_CHUNKID_LARGEOFFSETS;
-		chunks[4].size = ctx.num_large_offsets * MIDX_CHUNK_LARGE_OFFSET_WIDTH;
+		chunks[4].size = (uint64_t)ctx.num_large_offsets * MIDX_CHUNK_LARGE_OFFSET_WIDTH;
 		chunks[4].write_fn = write_midx_large_offsets;
 	}
 
-- 
gitgitgadget

