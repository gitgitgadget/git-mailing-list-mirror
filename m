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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E9E4C433B4
	for <git@archiver.kernel.org>; Thu, 20 May 2021 06:10:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 382B861186
	for <git@archiver.kernel.org>; Thu, 20 May 2021 06:10:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230471AbhETGLU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 May 2021 02:11:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230430AbhETGLN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 May 2021 02:11:13 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98A27C0613CE
        for <git@vger.kernel.org>; Wed, 19 May 2021 23:09:50 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id p7so12556297wru.10
        for <git@vger.kernel.org>; Wed, 19 May 2021 23:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=U+nI0aMs8UeAh3GQWMw34nqe2XIdn94sxTIWqQXECps=;
        b=uGqfjlbsn0r+KWF4NufVBqLfj3qkWZJMhkncf6V2yVtFxeHnFvAhVuAjhLsgHWEf5o
         N1b78JyjmInvXO7jkyxJH2OGLgxxNRM9IWvGDm8yuXK61oRE6dO/KBx9UsDEPWIToj9b
         QALIBlNJMWT5N1e6GnyAzaW3JyrAplK7LRvM8qy0FjIqDkl2gAYV6OUZWps2GqRcYVxJ
         8pGnJgIBtAZZ6ba+HTMm93rfJpFTl8ONcmoBBdmoTDRB5rtgRHY7gtRHyXUlu0VVZzx/
         y6mUtR63V7R5C0K9LO7sDnO3plqksyKyb0CM6DS99PijWEngYvq1jqssLWPqtx0ybNN3
         TX7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=U+nI0aMs8UeAh3GQWMw34nqe2XIdn94sxTIWqQXECps=;
        b=FdOdBbNNK+5z8U4yvhrQRPCYeKwi4/KoDtRD0OT+9rywe0E76IvutV2AxMapnkENhg
         gyrokBY33PkupYNDk56oYFNtM+maipjGWef5NE7VReqnyJOVZoYTd7gCBtzfCQwnnWzx
         NqIKLsrq3VvseeMN6QStO/m10gojtXOt6076MMVx2Ye3KOPLN00ZBAWyGuX+sL1c9pMg
         V53lROgyrLDjrJqVyeoBBS7Js9a3jkYFit5Be2l59hzSozbu1sk5LMO/4aOfICLaEjwG
         6BVmUSM4ITHuX0ndaFxZDG5ObAroNcbWQ2hhzbzkuTwKTHnYNj32MZabaT6Mz08ecJN5
         DY7g==
X-Gm-Message-State: AOAM531HtnK3zAxvLp6N6syGs9uhkxZIMq3nT0AdLG5PVqZsfmokXCDC
        NCrLGZC0lZm7diIQNDnwrpz2DJAE25Y=
X-Google-Smtp-Source: ABdhPJyPugTVOVFNhPLVSs8fxOBuv7AEE6Cd3MwyfiaC8xljhB/Mt83xk3mZk8KtCBgXS400uYrY8w==
X-Received: by 2002:adf:f647:: with SMTP id x7mr2323128wrp.107.1621490989310;
        Wed, 19 May 2021 23:09:49 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p10sm1715507wrr.58.2021.05.19.23.09.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 23:09:49 -0700 (PDT)
Message-Id: <441e66fb2d19af6330def8f233bc3776f6da4797.1621490982.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.859.v3.git.1621490982.gitgitgadget@gmail.com>
References: <pull.859.v2.git.1620094339.gitgitgadget@gmail.com>
        <pull.859.v3.git.1621490982.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 20 May 2021 06:09:37 +0000
Subject: [PATCH v3 09/13] merge-ort: avoid accidental API mis-use
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

Previously, callers of the merge-ort API could have passed an
uninitialized value for struct merge_result *result.  However, we want
to check result to see if it has cached renames from a previous merge
that we can reuse; such values would be found behind result->priv.
However, if result->priv is uninitialized, attempting to access behind
it will give a segfault.  So, we need result->priv to be NULL (which
will be the case if the caller does a memset(&result, 0)), or be written
by a previous call to the merge-ort machinery.  Documenting this
requirement may help, but despite being the person who introduced this
requirement, I still missed it once and it did not fail in a very clear
way and led to a long debugging session.

Add a _properly_initialized field to merge_result; that value will be
0 if the caller zero'ed the merge_result, it will be set to a very
specific value by a previous run by the merge-ort machinery, and if it's
uninitialized it will most likely either be 0 or some value that does
not match the specific one we'd expect allowing us to throw a much more
meaningful error.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 7 +++++++
 merge-ort.h | 2 ++
 2 files changed, 9 insertions(+)

diff --git a/merge-ort.c b/merge-ort.c
index e08b60a26d20..6d2b53a4943f 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -53,6 +53,8 @@ enum merge_side {
 	MERGE_SIDE2 = 2
 };
 
+static unsigned RESULT_INITIALIZED = 0x1abe11ed; /* unlikely accidental value */
+
 struct traversal_callback_data {
 	unsigned long mask;
 	unsigned long dirmask;
@@ -3760,6 +3762,10 @@ static void merge_start(struct merge_options *opt, struct merge_result *result)
 	assert(opt->obuf.len == 0);
 
 	assert(opt->priv == NULL);
+	if (result->_properly_initialized != 0 &&
+	    result->_properly_initialized != RESULT_INITIALIZED)
+		BUG("struct merge_result passed to merge_incore_*recursive() must be zeroed or filled with values from a previous run");
+	assert(!!result->priv == !!result->_properly_initialized);
 	if (result->priv) {
 		opt->priv = result->priv;
 		result->priv = NULL;
@@ -3919,6 +3925,7 @@ static void merge_ort_nonrecursive_internal(struct merge_options *opt,
 	result->clean &= strmap_empty(&opt->priv->conflicted);
 	if (!opt->priv->call_depth) {
 		result->priv = opt->priv;
+		result->_properly_initialized = RESULT_INITIALIZED;
 		opt->priv = NULL;
 	}
 }
diff --git a/merge-ort.h b/merge-ort.h
index d53a0a339f33..c011864ffeb1 100644
--- a/merge-ort.h
+++ b/merge-ort.h
@@ -29,6 +29,8 @@ struct merge_result {
 	 * !clean) and to print "CONFLICT" messages.  Not for external use.
 	 */
 	void *priv;
+	/* Also private */
+	unsigned _properly_initialized;
 };
 
 /*
-- 
gitgitgadget

