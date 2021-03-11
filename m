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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E86F5C4332E
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 00:39:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C69BE64FC4
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 00:39:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbhCKAiv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Mar 2021 19:38:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbhCKAii (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Mar 2021 19:38:38 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A43EC061574
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 16:38:38 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id d139-20020a1c1d910000b029010b895cb6f2so11779283wmd.5
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 16:38:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=dMhr+Gv2VLBJYwJz6UREAFs9FMhAGm7N3yrGCW/kKxQ=;
        b=K25FXreiM1dNTe+1qjAOSrBGkoUo/NaOJ+/LYhpjft2SyDvUyyaD3H5bqs6Uk3Dd19
         U7pVyXl4J6Vux8f1Wn1C4+H5jkI7PDsZABLDPh3kzqwfrWvHyZ19VZlqRbnEz0xmCWbO
         GkBRRl8zKdOe95PzJa7tXRCBtupeHBLYOx3qb5AEpYjW9V72aKe7XsM7PQ/ZOLwGTJXy
         qaYpSscORpyxbUPiLnSLt0QLbpP9E3gyvGpF7erBhNwgqJjd0+Kc3rlBVT06fBdgciCg
         9B8VLssGsa/tBMRFhToNGJS7FphG1FyFI5HppURbqqLd9MjoD1Z6z0+ht9Y3U8O7kuWY
         By9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=dMhr+Gv2VLBJYwJz6UREAFs9FMhAGm7N3yrGCW/kKxQ=;
        b=iTxrSvG9gn9vaAqSYZ5vPoxDmah8HImldApkhVb5RP6A4ZvlRbKsEQmByqm3W90YZD
         ppBAJC/pc6S+lIi9iOO2eRB745ZHZAyZX0zumgad34HmE0DeSuX+xxhKT4zJjq63J4SC
         qnYJvh8zdifSH/2LVTW+ZgUu8+u2QldFCfxcl+ip1djvTw1DlwWsmBXFvm5YolV5EW7Q
         8mqkldBf6tY6uSql86SS8lIvHxpfygkzH2IpXgmYzF3UzgQefolXKpC7buOijdMl5SjY
         a5iQGDh3sCCFjeFWLPh7HfmMK9GkransK7nSIZIIQtaTAqM/wKXZYZ65Vp0DRoIzun/O
         Nm/Q==
X-Gm-Message-State: AOAM5313DGBIpKdocyy8lgce/GM0s8lDzI2LWoFQKkV6xGSwJnAdNvZp
        wLg2p9hf3E3SGBwoM1Ppn+3ym1sDopw=
X-Google-Smtp-Source: ABdhPJykR2VOMFkJofUQJMnuriU7ieUm87aea6H//uLdCxa73Vs0NXhnDd3VJqOcmPAOxwa02whQCA==
X-Received: by 2002:a05:600c:214d:: with SMTP id v13mr5728557wml.7.1615423116915;
        Wed, 10 Mar 2021 16:38:36 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j12sm1012625wrx.59.2021.03.10.16.38.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 16:38:36 -0800 (PST)
Message-Id: <80a0c27a74ad0314a84e956acf233f6de3b16252.1615423112.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.845.v3.git.1615423111.gitgitgadget@gmail.com>
References: <pull.845.v2.git.1615248599.gitgitgadget@gmail.com>
        <pull.845.v3.git.1615423111.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 11 Mar 2021 00:38:30 +0000
Subject: [PATCH v3 7/8] merge-ort: skip rename detection entirely if possible
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

diffcore_rename_extended() will do a bunch of setup, then check for
exact renames, then abort before inexact rename detection if there are
no more sources or destinations that need to be matched.  It will
sometimes be the case, however, that either
  * we start with neither any sources or destinations
  * we start with no *relevant* sources
In the first of these two cases, the setup and exact rename detection
will be very cheap since there are 0 files to operate on.  In the second
case, it is quite possible to have thousands of files with none of the
source ones being relevant.  Avoid calling diffcore_rename_extended() or
even some of the setup before diffcore_rename_extended() when we can
determine that rename detection is unnecessary.

For the testcases mentioned in commit 557ac0350d ("merge-ort: begin
performance work; instrument with trace2_region_* calls", 2020-10-28),
this change improves the performance as follows:

                            Before                  After
    no-renames:        6.003 s ±  0.048 s     5.708 s ±  0.111 s
    mega-renames:    114.009 s ±  0.236 s   102.171 s ±  0.440 s
    just-one-mega:     3.489 s ±  0.017 s     3.471 s ±  0.015 s

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/merge-ort.c b/merge-ort.c
index eea14024c657..bd089cb9a76f 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -2157,6 +2157,19 @@ static int process_renames(struct merge_options *opt,
 	return clean_merge;
 }
 
+static inline int possible_side_renames(struct rename_info *renames,
+					unsigned side_index)
+{
+	return renames->pairs[side_index].nr > 0 &&
+	       !strset_empty(&renames->relevant_sources[side_index]);
+}
+
+static inline int possible_renames(struct rename_info *renames)
+{
+	return possible_side_renames(renames, 1) ||
+	       possible_side_renames(renames, 2);
+}
+
 static void resolve_diffpair_statuses(struct diff_queue_struct *q)
 {
 	/*
@@ -2193,6 +2206,16 @@ static void detect_regular_renames(struct merge_options *opt,
 	struct diff_options diff_opts;
 	struct rename_info *renames = &opt->priv->renames;
 
+	if (!possible_side_renames(renames, side_index)) {
+		/*
+		 * No rename detection needed for this side, but we still need
+		 * to make sure 'adds' are marked correctly in case the other
+		 * side had directory renames.
+		 */
+		resolve_diffpair_statuses(&renames->pairs[side_index]);
+		return;
+	}
+
 	repo_diff_setup(opt->repo, &diff_opts);
 	diff_opts.flags.recursive = 1;
 	diff_opts.flags.rename_empty = 0;
@@ -2310,6 +2333,8 @@ static int detect_and_process_renames(struct merge_options *opt,
 	int need_dir_renames, s, clean = 1;
 
 	memset(&combined, 0, sizeof(combined));
+	if (!possible_renames(renames))
+		goto cleanup;
 
 	trace2_region_enter("merge", "regular renames", opt->repo);
 	detect_regular_renames(opt, MERGE_SIDE1);
@@ -2344,6 +2369,25 @@ static int detect_and_process_renames(struct merge_options *opt,
 	clean &= process_renames(opt, &combined);
 	trace2_region_leave("merge", "process renames", opt->repo);
 
+	goto simple_cleanup; /* collect_renames() handles some of cleanup */
+
+cleanup:
+	/*
+	 * Free now unneeded filepairs, which would have been handled
+	 * in collect_renames() normally but we skipped that code.
+	 */
+	for (s = MERGE_SIDE1; s <= MERGE_SIDE2; s++) {
+		struct diff_queue_struct *side_pairs;
+		int i;
+
+		side_pairs = &renames->pairs[s];
+		for (i = 0; i < side_pairs->nr; ++i) {
+			struct diff_filepair *p = side_pairs->queue[i];
+			diff_free_filepair(p);
+		}
+	}
+
+simple_cleanup:
 	/* Free memory for renames->pairs[] and combined */
 	for (s = MERGE_SIDE1; s <= MERGE_SIDE2; s++) {
 		free(renames->pairs[s].queue);
-- 
gitgitgadget

