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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D1BEC4361B
	for <git@archiver.kernel.org>; Sun,  6 Dec 2020 04:14:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC951207DE
	for <git@archiver.kernel.org>; Sun,  6 Dec 2020 04:14:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727660AbgLFEO1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Dec 2020 23:14:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725986AbgLFEOZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Dec 2020 23:14:25 -0500
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E5D1C0613D1
        for <git@vger.kernel.org>; Sat,  5 Dec 2020 20:13:29 -0800 (PST)
Received: by mail-ed1-x543.google.com with SMTP id k4so10109229edl.0
        for <git@vger.kernel.org>; Sat, 05 Dec 2020 20:13:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=y9HYiViJMgRFGolNXHnXFxwjBwznSI2bWTmSIA8gERY=;
        b=bbwhKHajsxcVcqzm7xQETQ2iP+oh9bSu05pJDrII2yaLz23xxakJz5o0mJ05uE9Pco
         imZp6nVuGXb+wlpFKFGuhaKlKJX8SJEzY+kvya4bNxTm00hDWVq3bq3aZPI2oClFoCDo
         zwsi24yV12m14u+QjSD86d+ACPb0TrKRemjPj5GQazR5An+fq8k1esl44VuMnYnjVzbA
         1J1owSZVINaUzh/J2ELQhi3350SYEsVFD9QUBpfaFAS+LbCJdGJgqxpjCvBYTXOYEMPg
         RwrNN2c6lruyGxp2bVBnI3OLjEOsg1Ts/3Yw+ixlz58uJRZ6lt+d4QeydQOPTx/vU5DP
         ZNLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=y9HYiViJMgRFGolNXHnXFxwjBwznSI2bWTmSIA8gERY=;
        b=pYlVLyaOb7r9s4ot5tEIdvAeK3BoMY/BKNP8ZUWjyrYknj0j5LflsnMUdaeT4zuxZ2
         61n6Zxmr8rVab9ZP0zR0GlP62z3LyYk7w6kratpihnyPLQI+Z4gAiA77u8hBs5Iyv5MU
         AeIHzdWM+yIpyo+bNvwPV2vR2tv5AmoCRX/vGxuoOICCaay45pXukIWoGGuWiBrJCqyf
         WmNq6j/aHTt6s+xfuTUJ40yOY1iGEg/B5eZggFbkwmiohzbHNwb7uEb1KULbKtKn0XEn
         vWeRfH81GEXurrlbCFzGgbZ/P0J0VzMWgcEJqzeRbQBFu6b4Duv1z7lxikrV1rVOn9YU
         5Y0w==
X-Gm-Message-State: AOAM533IFVQeAPs5CQJcQORb9bV8z3rJh4bdI2N26HEnfKNItx75MdkZ
        WiuAhhpT0PwTc7SknpIijn4+JNpKUi0=
X-Google-Smtp-Source: ABdhPJx/VeTWYp6aD4ORVpL1uomhR9Tk5tnCZCyO+zknLawG8rLoIaHiEwXto6Sb8z4E0FfSn6EX/Q==
X-Received: by 2002:a5d:5689:: with SMTP id f9mr12728725wrv.181.1607223281408;
        Sat, 05 Dec 2020 18:54:41 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b18sm10031037wrt.54.2020.12.05.18.54.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Dec 2020 18:54:40 -0800 (PST)
Message-Id: <30381addc5ca9f2b5299835020716291c7fe8d68.1607223276.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.929.git.git.1607223276.gitgitgadget@gmail.com>
References: <pull.929.git.git.1607223276.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 06 Dec 2020 02:54:32 +0000
Subject: [PATCH 3/7] diffcore-rename: rename num_create to num_targets
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Files added since the base commit serve as targets for rename detection.
While it is true that added files can be thought of as being "created"
when they are added IF they have no pairing file that they were renamed
from, and it is true we start out not knowing what the pairings are, it
seems a little odd to think in terms of "file creation" when we are
looking for "file renames".  Rename the variable to avoid this minor
point of confusion.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 diffcore-rename.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/diffcore-rename.c b/diffcore-rename.c
index 0f8fce9293e..655a67759c8 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -502,7 +502,7 @@ void diffcore_rename(struct diff_options *options)
 	struct diff_queue_struct outq;
 	struct diff_score *mx;
 	int i, j, rename_count, skip_unmodified = 0;
-	int num_create, dst_cnt;
+	int num_targets, dst_cnt;
 	struct progress *progress = NULL;
 
 	if (!minimum_score)
@@ -567,13 +567,13 @@ void diffcore_rename(struct diff_options *options)
 	 * Calculate how many renames are left (but all the source
 	 * files still remain as options for rename/copies!)
 	 */
-	num_create = (rename_dst_nr - rename_count);
+	num_targets = (rename_dst_nr - rename_count);
 
 	/* All done? */
-	if (!num_create)
+	if (!num_targets)
 		goto cleanup;
 
-	switch (too_many_rename_candidates(num_create, rename_src_nr, options)) {
+	switch (too_many_rename_candidates(num_targets, rename_src_nr, options)) {
 	case 1:
 		goto cleanup;
 	case 2:
@@ -590,7 +590,7 @@ void diffcore_rename(struct diff_options *options)
 				(uint64_t)rename_dst_nr * (uint64_t)rename_src_nr);
 	}
 
-	mx = xcalloc(st_mult(NUM_CANDIDATE_PER_DST, num_create), sizeof(*mx));
+	mx = xcalloc(st_mult(NUM_CANDIDATE_PER_DST, num_targets), sizeof(*mx));
 	for (dst_cnt = i = 0; i < rename_dst_nr; i++) {
 		struct diff_filespec *two = rename_dst[i].two;
 		struct diff_score *m;
-- 
gitgitgadget

