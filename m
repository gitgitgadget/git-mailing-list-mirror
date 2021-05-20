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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F4D3C433ED
	for <git@archiver.kernel.org>; Thu, 20 May 2021 06:10:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 106F2611BD
	for <git@archiver.kernel.org>; Thu, 20 May 2021 06:10:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230486AbhETGLX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 May 2021 02:11:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230440AbhETGLN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 May 2021 02:11:13 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82F17C06138D
        for <git@vger.kernel.org>; Wed, 19 May 2021 23:09:52 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id t206so8451469wmf.0
        for <git@vger.kernel.org>; Wed, 19 May 2021 23:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=QwEH6gJXv56Ut+wAlTKs18/ZFMLrtVFsYQQoVD2kgdw=;
        b=iSK7jdcK4VaxkQ+njsuGNfoyCm7GTy27PccTLkpHm69kqX+0P6VsNNq6mDvXwdkjCn
         y8WcuFLELSvHR+EUH80ioEkPM3DzolbpvtfTAaFyK09Hi6WG+FjP3JAQ+sWf1QM5iBZ0
         R2ONjRWOf89YRYSa+BAzitRxqZlhIQY5aiy81f4Y2PSHPa/YVz0uVgIE/819QTALcXCP
         BzV7A5JulI/HahuSkNPa8Pwuw2WosbWgfEWACbNha++1kwsO5aRhUBc+flmBPShlOdtb
         +NosEykVN7qPW3tBy+sLY/N+GjBgtmRMAsbWLK0VenZKEEufORHSB8Dg2oO8nkW+NWys
         DGoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=QwEH6gJXv56Ut+wAlTKs18/ZFMLrtVFsYQQoVD2kgdw=;
        b=K96S6hEjAPy8MYXB/sDF0FuTmXOxjUZbpDP0QsMO8z930u0p/1oiTxsk1LKlCs7Zhn
         66foxq2MtauR7U1rZdpg1mvYtpoyMawOG0RfWCaRAxMRD4OxddHXzAV+ROOXytwy5EWj
         WmZR9vyYu9KEW0zIBjlkt3QgPVnYEUtl0O4Ka8iIFiymnDwmAK9EGsGIsIWhFrKfn1js
         SHwTBYUuhu6hvY8wBGggaEFeJ3oAqTDxBWsU6FKM/u7y1+AmV9M5RxM8HggvaR+WMmLu
         1bp62n0upRdiEJnU3HwOLv5xlnZu/k9se3CfiE4sIaCpPZwu/h7ENaeWgVPvFRGLiAwp
         RBxg==
X-Gm-Message-State: AOAM533QSH4LG0IrlAW0L0PCtvxFuBE+5A0V0jNvcqKMxQGClt+KpMA2
        BUPTuh6vVsWPaWgZG/DmCsGCimL6WQc=
X-Google-Smtp-Source: ABdhPJwvHsu9cfr1t1a2o9lnNSw+dsvhFcHVFvcS5rlmjt8so+rTb9FB36GV39ZQI1TcnpzRMRlaiw==
X-Received: by 2002:a05:600c:2f88:: with SMTP id t8mr1946441wmn.82.1621490991131;
        Wed, 19 May 2021 23:09:51 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o8sm1010094wrs.60.2021.05.19.23.09.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 23:09:50 -0700 (PDT)
Message-Id: <886a17115f30b97fd8c021495f228a45b9f76636.1621490982.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.859.v3.git.1621490982.gitgitgadget@gmail.com>
References: <pull.859.v2.git.1620094339.gitgitgadget@gmail.com>
        <pull.859.v3.git.1621490982.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 20 May 2021 06:09:40 +0000
Subject: [PATCH v3 12/13] merge-ort: handle interactions of caching and
 rename/rename(1to1) cases
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

As documented in Documentation/technical/remembering-renames.txt, and as
tested for in the two testcases in t6429 with "rename same file
identically" in their description, there is one case where we need to
have renames in one commit NOT be cached for the next commit in our
rebase sequence -- namely, rename/rename(1to1) cases.  Rather than
specifically trying to uncache those and fix up dir_rename_counts() to
match (which would also be valid but more work), we simply disable the
optimization when this really rare type of rename occurs.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/merge-ort.c b/merge-ort.c
index 9a229128a9a0..2cdc57e75543 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -2111,6 +2111,9 @@ static int process_renames(struct merge_options *opt,
 			VERIFY_CI(side2);
 
 			if (!strcmp(pathnames[1], pathnames[2])) {
+				struct rename_info *ri = &opt->priv->renames;
+				int j;
+
 				/* Both sides renamed the same way */
 				assert(side1 == side2);
 				memcpy(&side1->stages[0], &base->stages[0],
@@ -2120,6 +2123,16 @@ static int process_renames(struct merge_options *opt,
 				base->merged.is_null = 1;
 				base->merged.clean = 1;
 
+				/*
+				 * Disable remembering renames optimization;
+				 * rename/rename(1to1) is incredibly rare, and
+				 * just disabling the optimization is easier
+				 * than purging cached_pairs,
+				 * cached_target_names, and dir_rename_counts.
+				 */
+				for (j = 0; j < 3; j++)
+					ri->merge_trees[j] = NULL;
+
 				/* We handled both renames, i.e. i+1 handled */
 				i++;
 				/* Move to next rename */
@@ -3910,7 +3923,22 @@ static void merge_check_renames_reusable(struct merge_options *opt,
 
 	renames = &opti->renames;
 	merge_trees = renames->merge_trees;
-	/* merge_trees[0..2] will only be NULL if opti is */
+
+	/*
+	 * Handle case where previous merge operation did not want cache to
+	 * take effect, e.g. because rename/rename(1to1) makes it invalid.
+	 */
+	if (!merge_trees[0]) {
+		assert(!merge_trees[0] && !merge_trees[1] && !merge_trees[2]);
+		renames->cached_pairs_valid_side = 0; /* neither side valid */
+		return;
+	}
+
+	/*
+	 * Handle other cases; note that merge_trees[0..2] will only
+	 * be NULL if opti is, or if all three were manually set to
+	 * NULL by e.g. rename/rename(1to1) handling.
+	 */
 	assert(merge_trees[0] && merge_trees[1] && merge_trees[2]);
 
 	/* Check if we meet a condition for re-using cached_pairs */
-- 
gitgitgadget

