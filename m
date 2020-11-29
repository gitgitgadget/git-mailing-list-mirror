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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 344E2C64E8A
	for <git@archiver.kernel.org>; Sun, 29 Nov 2020 07:44:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3CB2208D5
	for <git@archiver.kernel.org>; Sun, 29 Nov 2020 07:44:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mWbLzI3Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbgK2HoX (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 29 Nov 2020 02:44:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726477AbgK2HoK (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Nov 2020 02:44:10 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0094CC0617A7
        for <git@vger.kernel.org>; Sat, 28 Nov 2020 23:43:29 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id g185so7315156wmf.3
        for <git@vger.kernel.org>; Sat, 28 Nov 2020 23:43:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=u7xaiChqwYG+2Tum1Kh8oEQYlGlfDx8LGEVIJ0Q6ahU=;
        b=mWbLzI3Y5a3gckfUfsGvdFi9wGaduSgTluDZX7JPv7w/RweWMaKIgqcDwQHiIXVKj3
         RU8fKpA0miiILO2tPnMSgJnOaaNKubgQ13WbSpFX3iMH+0j3I9wOzR6bPoAGU/ltdYkV
         bnVESPcHzQ0eUDzXjXgVP5C1m2d6H9i9bSCmRgCl1QRxBEggV+8PH5DyEXjmfWkf+6d9
         K//uShlzeWqZyMGeJhIVsRT8y48PYLo+86cjEYH+LqL7cK30xHCjOdg/aCmqUOV4gFL0
         TjrZLHj7U8Gnd8CsrtacuL1bjN1do9Al/CCyTlRHMiZLrU4YEH4Lb60UGtSjN3nzHuB7
         tSSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=u7xaiChqwYG+2Tum1Kh8oEQYlGlfDx8LGEVIJ0Q6ahU=;
        b=pRVnYDdPsBGfQHacKXCzN7nMEIVn4p1G3kNMAGgHknFnyCVP2MZXT22hYVC3tmcfy0
         3Mdrq0VTq9NoYUEBd56UnUVnXclnqh/jDVIF5WYvmFFpT5XXv8XHa7xzytOysiMP+R7u
         CfgN3op2VRgSYoUQx20xG0d+LzqL6TQIcEpxzNkh5+0d/8wfwNNM38z25ODKeWbGamSb
         gB4ZpfpSOPFcdOSSuVP8qBfJ4ca6jRZCEOpn5D3fKXoZYt84P39VZSt/4mVwXISJHfJ4
         mA2jKZ11AdLxCew7e4Z8RKA9NbbmqDM/zPWJydsie68qr+23ltH1HiYA/Cwhc5yKBBIL
         RPSg==
X-Gm-Message-State: AOAM530Qp0BXWwdWMo9pVgy5qhcK0tQ3fawKeJumbeGoV044z4Q3Dpl4
        g1lb6f4cbx9CFNNFWHUKpn1nVZ4O2R4=
X-Google-Smtp-Source: ABdhPJwjMmHEElppjXGPfoyhWMGA2Zt0KODA2XR/UhiNdJjfmg0i/A/mXE1ahI6RM31DUz8ic40tdw==
X-Received: by 2002:a1c:dc82:: with SMTP id t124mr17095549wmg.94.1606635808585;
        Sat, 28 Nov 2020 23:43:28 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w11sm20088965wmg.36.2020.11.28.23.43.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Nov 2020 23:43:28 -0800 (PST)
Message-Id: <564b072ac105ee9c3ccb30c6046ce66270fbbf53.1606635803.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.923.git.git.1606635803.gitgitgadget@gmail.com>
References: <pull.923.git.git.1606635803.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 29 Nov 2020 07:43:07 +0000
Subject: [PATCH 04/20] merge-ort: use histogram diff
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

In my cursory investigation, histogram diffs are about 2% slower than
Myers diffs.  Others have probably done more detailed benchmarks.  But,
in short, histogram diffs have been around for years and in a number of
cases provide obviously better looking diffs where Myers diffs are
unintelligible but the performance hit has kept them from becoming the
default.

However, there are real merge bugs we know about that have triggered on
git.git and linux.git, which I don't have a clue how to address without
the additional information that I believe is provided by histogram
diffs.  See the following:

https://lore.kernel.org/git/20190816184051.GB13894@sigill.intra.peff.net/
https://lore.kernel.org/git/CABPp-BHvJHpSJT7sdFwfNcPn_sOXwJi3=o14qjZS3M8Rzcxe2A@mail.gmail.com/
https://lore.kernel.org/git/CABPp-BGtez4qjbtFT1hQoREfcJPmk9MzjhY5eEq1QhXT23tFOw@mail.gmail.com/

I don't like mismerges.  I really don't like silent mismerges.  While I
am sometimes willing to make performance and correctness tradeoff, I'm
much more interested in correctness in general.  I want to fix the above
bugs.  I have not yet started doing so, but I believe histogram diff at
least gives me an angle.  Unfortunately, I can't rely on using the
information from histogram diff unless it's in use.  And it hasn't been
used because of a few percentage performance hit.

In testcases I have looked at, merge-ort is _much_ faster than
merge-recursive for non-trivial merges/rebases/cherry-picks.  As such,
this is a golden opportunity to switch out the underlying diff algorithm
(at least the one used by the merge machinery; git-diff and git-log are
separate questions); doing so will allow me to get additional data and
improved diffs, and I believe it will help me fix the above bugs at some
point in the future.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/merge-ort.c b/merge-ort.c
index 3581a7d278..d737762700 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -21,6 +21,7 @@
 #include "diffcore.h"
 #include "strmap.h"
 #include "tree.h"
+#include "xdiff-interface.h"
 
 struct merge_options_internal {
 	/*
@@ -234,6 +235,9 @@ static void merge_start(struct merge_options *opt, struct merge_result *result)
 
 	assert(opt->priv == NULL);
 
+	/* Default to histogram diff.  Actually, just hardcode it...for now. */
+	opt->xdl_opts = DIFF_WITH_ALG(opt, HISTOGRAM_DIFF);
+
 	/* Initialization of opt->priv, our internal merge data */
 	opt->priv = xcalloc(1, sizeof(*opt->priv));
 
-- 
gitgitgadget

