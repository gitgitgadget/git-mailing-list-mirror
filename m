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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51763C43333
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 00:10:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CD5B64FFD
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 00:10:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231730AbhCIAKa (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Mar 2021 19:10:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231877AbhCIAKG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Mar 2021 19:10:06 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08CC3C06174A
        for <git@vger.kernel.org>; Mon,  8 Mar 2021 16:10:06 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id a18so13266107wrc.13
        for <git@vger.kernel.org>; Mon, 08 Mar 2021 16:10:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=KWaxSZgzerRR2+AOXRgojJoGF8Bm1+wLklgOoYKNF54=;
        b=tAJKjKe0k9V//oV/KLyW8OvJCdaMvmhfI5PSbGZhA2DFeRhTN2gQ+kXOdmX0202Y15
         Vcji2RGNp6OzaWDJJ8/Gx7g6UqR5hVwjRkm9HCNjWdKBCI06zueVe6taMs7Q/x/YIYdb
         tUVvym9Xkh6CKikCeRWfQwrcwKE8Ds/FGOEZgmIbF1DwINoOhKqJb3mwHpwcNfhheqII
         sDRBklmQ8fI7k+xbEKzUhaQvzgilW/fcjMJA0wO7yr0NH3Sh/OdJRFx8m+zJSIay/8wm
         7XExeBr0Vr6l/3UTIx33nRNJNtd8hrvewSznFrY9proeUEeFUjFAFkz8w9ELHXtNVA0Z
         5xzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=KWaxSZgzerRR2+AOXRgojJoGF8Bm1+wLklgOoYKNF54=;
        b=UK91jZpnEdn0rfFTJmdfnZvMOg/z+g6T/h0S+/XeE+dBm0GKDEkdJupJHVhHA/PlJD
         dWTPN8HaufiKnuaNiF0AP0CIl61BFXflEU0oToc6dFpSnlns52RFOfgDj+0M4sGUCQLE
         4GC+EY3TMLR5Ppa0IEjAhCbEVLdoSRhylTmNOEtFy4fl22VwYi7uUB3u+XkaW5sz0Nq9
         V6KhnyrnZEQQMO2R5a+c8s+wpTN6kNnIS3apgLb8x3rtXYozdVSEC1wlFXd5PmqCyxUL
         JyYu3ZYWJ9VasCKxMGXGzfmqKaOMnhB7rdq6IlZmOIed9eVm9wj3ocdyLi8B7oyVxugj
         TRyw==
X-Gm-Message-State: AOAM533pSXmqEqKDve4an856BzlWVna1hm01WkREoiv7xgpJ5bCSbq5n
        XhbmReOI26EytAojP06q7icHVl7wp9E=
X-Google-Smtp-Source: ABdhPJwhb5sUUAxLzKkR06UOC9V33gytCqmc4Ox4t3Mw4UcA826tPcWk1GlZ6+I4Du4uDOn00GvkJw==
X-Received: by 2002:a5d:410b:: with SMTP id l11mr24480813wrp.16.1615248604865;
        Mon, 08 Mar 2021 16:10:04 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f22sm1205378wmc.33.2021.03.08.16.10.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 16:10:04 -0800 (PST)
Message-Id: <cd931286f24d66efbf6b0f0a1f520b58ac468f88.1615248599.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.845.v2.git.1615248599.gitgitgadget@gmail.com>
References: <pull.845.git.1614484707.gitgitgadget@gmail.com>
        <pull.845.v2.git.1615248599.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 09 Mar 2021 00:09:58 +0000
Subject: [PATCH v2 7/8] merge-ort: skip rename detection entirely if possible
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
 merge-ort.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/merge-ort.c b/merge-ort.c
index 66892c63cee2..8602c7b8936f 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -2158,6 +2158,19 @@ static int process_renames(struct merge_options *opt,
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
@@ -2194,6 +2207,16 @@ static void detect_regular_renames(struct merge_options *opt,
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
@@ -2311,6 +2334,8 @@ static int detect_and_process_renames(struct merge_options *opt,
 	int need_dir_renames, s, clean = 1;
 
 	memset(&combined, 0, sizeof(combined));
+	if (!possible_renames(renames))
+		goto cleanup;
 
 	trace2_region_enter("merge", "regular renames", opt->repo);
 	detect_regular_renames(opt, MERGE_SIDE1);
@@ -2345,6 +2370,26 @@ static int detect_and_process_renames(struct merge_options *opt,
 	clean &= process_renames(opt, &combined);
 	trace2_region_leave("merge", "process renames", opt->repo);
 
+	goto simple_cleanup; /* collect_renames() handles some of cleanup */
+
+cleanup:
+	/*
+	 * Free now unneeded filepairs, which would have been handled
+	 * in collect_renames() normally but we're about to skip that
+	 * code...
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

