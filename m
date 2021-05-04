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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1EDAC433B4
	for <git@archiver.kernel.org>; Tue,  4 May 2021 02:12:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52A17611CB
	for <git@archiver.kernel.org>; Tue,  4 May 2021 02:12:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbhEDCN2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 May 2021 22:13:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbhEDCNY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 May 2021 22:13:24 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 867F7C061574
        for <git@vger.kernel.org>; Mon,  3 May 2021 19:12:30 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id x7so7580808wrw.10
        for <git@vger.kernel.org>; Mon, 03 May 2021 19:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=r3cDq5vY4YQZr9QUMEa8RHAdsPDS6ptvqm6tEkstoD4=;
        b=mqfiH0pOU8Fv/J0571Bw6vVRiDEWYWLM69Om8FhnyMAx4g3GV9D8mpOe8CC5BgwLDE
         5agzuGZLZkJu1oG20XZLxtUgB1ROhNY7HKxhgeghi9QyvEGTRmk8kLV7Ts+hwnnCFeu/
         254f6CZlWMpilH8N7GxejcMeNI2d6ZHWWJ3V7XmhZsB9wOpcYuivpCdBpuznvsYOfJDW
         IPKIzsjkzAScIaLViYNFjzb7/xq6d8ew9Vdr9limz5w2T23/rlwHNhemtjOkR72FJgkm
         DLnRUSkrK5GlBpOqi+6cDq5G0UTezFiyBSKMdwjoVuULsCyeeSgis/6ov0NVLfTUA3DL
         ZOVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=r3cDq5vY4YQZr9QUMEa8RHAdsPDS6ptvqm6tEkstoD4=;
        b=P25O5YWVtqPqo7KoQJXsBfOBUGMrpP7/nxUwPiWlJlnZpHv/KFZt3BVq9EZ5jleXEa
         JN+NcUsfCdQU7utgJfZlPup12s1F6vb/hoXJPcJ9xGtPCRL/Y0JbJrTzubcSHV/xK+Cs
         mdHBujFCD5MF+/nPgvcSxAsOEbNSYkdbll2Apx8P+DjuUYaSv53T+MjUvoNp0fNgbPsU
         S+1BRfQ0DNouG+3KKHlFmVDwYAbN/U9/zU2r3X2sQO6HDkDRPw6EXjefBVE51Ir20cGl
         PTxu/9/pPPnrhg582X6vx0UdlF7zs2XJ++dmk4TmghjLkpneagI20l5edSpILdPnVtI8
         t7UA==
X-Gm-Message-State: AOAM532mNMwDs9KeZBz+vD3SDlmvKPIUx8UMTlIbGFwCZHh4+tknRVlr
        PEpTxdOwXaiFLvxbT/T3G4IS+xtGnwg=
X-Google-Smtp-Source: ABdhPJzPP+k0jZSCxs2CH4tkRfICfmI4/UmY1Bx3rjK2CxjZJ+4HoqA+dInmLISt50PrEEd2/1ZF9Q==
X-Received: by 2002:a5d:6648:: with SMTP id f8mr29759240wrw.396.1620094349365;
        Mon, 03 May 2021 19:12:29 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k16sm1146442wmi.44.2021.05.03.19.12.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 May 2021 19:12:29 -0700 (PDT)
Message-Id: <2163dded5798e8cfd0d8a19d77475cd31286c34b.1620094339.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.859.v2.git.1620094339.gitgitgadget@gmail.com>
References: <pull.859.git.1616621553.gitgitgadget@gmail.com>
        <pull.859.v2.git.1620094339.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 04 May 2021 02:12:16 +0000
Subject: [PATCH v2 10/13] merge-ort: preserve cached renames for the
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
index e6a02fa928f5..b524a2db2769 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -476,17 +476,18 @@ static void clear_or_reinit_internal_opts(struct merge_options_internal *opti,
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
@@ -2443,6 +2444,7 @@ static void detect_regular_renames(struct merge_options *opt,
 		return;
 	}
 
+	partial_clear_dir_rename_count(&renames->dir_rename_count[side_index]);
 	repo_diff_setup(opt->repo, &diff_opts);
 	diff_opts.flags.recursive = 1;
 	diff_opts.flags.rename_empty = 0;
-- 
gitgitgadget

