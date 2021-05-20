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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6B23C43460
	for <git@archiver.kernel.org>; Thu, 20 May 2021 06:10:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BA3360D07
	for <git@archiver.kernel.org>; Thu, 20 May 2021 06:10:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230483AbhETGLW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 May 2021 02:11:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230431AbhETGLN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 May 2021 02:11:13 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51119C06138B
        for <git@vger.kernel.org>; Wed, 19 May 2021 23:09:51 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id h4so16253512wrt.12
        for <git@vger.kernel.org>; Wed, 19 May 2021 23:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=X5utbe7IosNATLn0tkPS6v41oIqGS6ELWV+P3YPsezA=;
        b=nL2CC4ogYPY2YtoAX9HAIaorpZhGg+ygB2GrbHAeyqJN1SaGFC9+LNSo4ujQNz4XYl
         X79PM1xCzfDM/AwH6XCn8ZexR3i4GwVqDGqhowyvdGDSl0sr8drkshUbybW+aeOPaxim
         dzYuLJ87w2iaB52US2k1qc42LGPH9K7NM6wBVE5k5mGu1iZTsoCGE3BonC6tjTyy9qXK
         rDYjj6oMSfHp8w7z5x+TT++ra08XlSv/y+0uxBWVGJlSLURYdrwBGaWdOW2u7iYBM+l8
         fe2+/8DG49PT/uCTtyNf9TW3PtMAll7EfaCefOWgwddsxz/mQ7xleT2QU2K+JJnh7O1E
         M9ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=X5utbe7IosNATLn0tkPS6v41oIqGS6ELWV+P3YPsezA=;
        b=GDhVJZxZI8LPld/dwmjp7PAlvfs+CC88+v1/AudX8TTyVFBuRQVmPvCUVWBUVJTfNv
         dZ2BnVj3b3m8xVp3HNVd7EyVJcd5zVdEalkPYp1/dKTZXl+FXTmW+Reakmk2jCPDvh6B
         L348HyLKtPgCtchqTRIVvG5xEOsqrNPRPoPxKdbXoTNTigAWPFD+uliWK4b4jRj80JC1
         uY14f0Yz74ybReE4fyM5F4AXKWSUmRiLo2cIpXsmTRSbB0cH3MySOzI+yqa/03lrIk0L
         HIn8GBEm/4xnjZSlWU3CLaJjiXGc1AKOMHY7aQgUGflwgiZU076tR1mS/kYTf52qPE26
         WN/A==
X-Gm-Message-State: AOAM531HvJ8Cjd+27JpieHEBhUkM47TdXeclN3nhZ7YqxRWD7FwQjvfD
        OMfI/5lcY+NPD8HsRShQyCc5VPHcNW8=
X-Google-Smtp-Source: ABdhPJzjxOX1gQpnCosv4r2EnJJE+zjyBC58Q6ZoQIvWJo2I8pANwP+TgA3Irh8pihs5trtk2eCgnw==
X-Received: by 2002:a5d:58f2:: with SMTP id f18mr2406850wrd.249.1621490990028;
        Wed, 19 May 2021 23:09:50 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f1sm2043708wrr.63.2021.05.19.23.09.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 23:09:49 -0700 (PDT)
Message-Id: <472a539d1809a39c0cc9dcb840288829c6df727a.1621490982.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.859.v3.git.1621490982.gitgitgadget@gmail.com>
References: <pull.859.v2.git.1620094339.gitgitgadget@gmail.com>
        <pull.859.v3.git.1621490982.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 20 May 2021 06:09:38 +0000
Subject: [PATCH v3 10/13] merge-ort: preserve cached renames for the
 appropriate side
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Previous commits created an in-memory cache of the results of rename
detection, and added logic to detect when that cache could appropriately
be used in a subsequent merge operation -- but we were still
unconditionally clearing the cache with each new merge operation anyway.
If it is valid to reuse the cache from one of the two sides of history,
preserve that side.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index 6d2b53a4943f..8d4b2ec40e3d 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -487,17 +487,18 @@ static void clear_or_reinit_internal_opts(struct merge_options_internal *opti,
 	/* Free memory used by various renames maps */
 	for (i = MERGE_SIDE1; i <= MERGE_SIDE2; ++i) {
 		strintmap_func(&renames->dirs_removed[i]);
-
-		partial_clear_dir_rename_count(&renames->dir_rename_count[i]);
-		if (!reinitialize)
-			strmap_clear(&renames->dir_rename_count[i], 1);
-
 		strmap_func(&renames->dir_renames[i], 0);
-
 		strintmap_func(&renames->relevant_sources[i]);
-		strset_func(&renames->cached_target_names[i]);
-		strmap_func(&renames->cached_pairs[i], 1);
-		strset_func(&renames->cached_irrelevant[i]);
+		if (!reinitialize)
+			assert(renames->cached_pairs_valid_side == 0);
+		if (i != renames->cached_pairs_valid_side) {
+			strset_func(&renames->cached_target_names[i]);
+			strmap_func(&renames->cached_pairs[i], 1);
+			strset_func(&renames->cached_irrelevant[i]);
+			partial_clear_dir_rename_count(&renames->dir_rename_count[i]);
+			if (!reinitialize)
+				strmap_clear(&renames->dir_rename_count[i], 1);
+		}
 	}
 	renames->cached_pairs_valid_side = 0;
 	renames->dir_rename_mask = 0;
@@ -2456,6 +2457,7 @@ static void detect_regular_renames(struct merge_options *opt,
 		return;
 	}
 
+	partial_clear_dir_rename_count(&renames->dir_rename_count[side_index]);
 	repo_diff_setup(opt->repo, &diff_opts);
 	diff_opts.flags.recursive = 1;
 	diff_opts.flags.rename_empty = 0;
-- 
gitgitgadget

