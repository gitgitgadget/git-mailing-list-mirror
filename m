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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1325C433ED
	for <git@archiver.kernel.org>; Tue,  4 May 2021 02:12:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81EC161090
	for <git@archiver.kernel.org>; Tue,  4 May 2021 02:12:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbhEDCNc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 May 2021 22:13:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbhEDCN1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 May 2021 22:13:27 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D89A8C06174A
        for <git@vger.kernel.org>; Mon,  3 May 2021 19:12:29 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id i128so2415054wma.5
        for <git@vger.kernel.org>; Mon, 03 May 2021 19:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ztc3ZjtU9cT/TBaH9V9aKolleMMZadYpb0AXUv6dt0I=;
        b=HRs8QFG1v64aUKDmXRxc8Y+tTw/PD//yUo7vdNEDbZBGDM+NmC01VgJY93RKLbaTKM
         gNS9vCEIoeKlu18tTYpZdRWW60b80vebup97j+Kt4Np+ng/o5bhbr+d53Tu/H247q9uH
         p1qNUOjURsSQzuNMbjCWqarBMh6J66/CGCBZFxg6+ZE+cM3+qu/LttRl4RyXAJpO2jIM
         gRrUa3OKCv8Pmlf3Cex/xNq57MvnNgXq95lj46m83vduoAlulwtpbu31YU8GHQG3ynwL
         h8p+ad7Uhu609VVmheqAfAz2I7Eb5/d913WWtDtQrV2RfIeYkKO0jtoLtvbr0lF67tG2
         TLoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ztc3ZjtU9cT/TBaH9V9aKolleMMZadYpb0AXUv6dt0I=;
        b=mT4sszPOjEH5qQLKqQ0ycTQjho8R/1IUjZGvhmdpSP7qR5KzzhvBpo34TYTLbW31ZB
         8aY0JuPbr+zMr3JjsetHCtUwj4Q/J/ocjl/B/L1OYEWu8OZ0GsPSgWJJ+ReU0Sjcafhk
         peamm7U6LarVwmuAfjVcwPOfqyb0s4UlUfF6QxG85Xq9ppp4e237BnLEwAgnw7cC2LW9
         VeBqEjvDuNW4Sz6+z2rNec+0cx04Ed1KZJZQLYvzkmYqTe5g5g22pBTqPPJE13VOAA//
         miKU/Tf4lpU2ScV/Ddk0S8pfFMYpjQW9wvQIJP9wlbm8ccWBHYf8/1rBVtL/z5On43pU
         kTXA==
X-Gm-Message-State: AOAM531TJlx88QhKyHxWSCIccN2ftymzwdfpD0nUCSJPzwCp0vbXPohz
        pBZA4+YlwcuGp3OBjgwa+q+IudYwqnA=
X-Google-Smtp-Source: ABdhPJy+/JkaxP/F7nig5MNpfQCLSPF+qj2B8867zNxS5LtmkmUaJO94fWF7s7CraYVEod/o3NiwFw==
X-Received: by 2002:a05:600c:19cc:: with SMTP id u12mr1393232wmq.171.1620094348659;
        Mon, 03 May 2021 19:12:28 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b7sm6191599wri.83.2021.05.03.19.12.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 May 2021 19:12:28 -0700 (PDT)
Message-Id: <becd451030183e6271646a4bf006c2466822326e.1620094339.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.859.v2.git.1620094339.gitgitgadget@gmail.com>
References: <pull.859.git.1616621553.gitgitgadget@gmail.com>
        <pull.859.v2.git.1620094339.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 04 May 2021 02:12:15 +0000
Subject: [PATCH v2 09/13] merge-ort: avoid accidental API mis-use
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
index a342cc6344fd..e6a02fa928f5 100644
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
@@ -3746,6 +3748,10 @@ static void merge_start(struct merge_options *opt, struct merge_result *result)
 	assert(opt->obuf.len == 0);
 
 	assert(opt->priv == NULL);
+	if (result->_properly_initialized != 0 &&
+	    result->_properly_initialized != RESULT_INITIALIZED)
+		BUG("struct merge_result passed to merge_incore_*recursive() must be zeroed or filled with values from a previous run");
+	assert(!!result->priv == !!result->_properly_initialized);
 	if (result->priv) {
 		opt->priv = result->priv;
 		result->priv = NULL;
@@ -3905,6 +3911,7 @@ static void merge_ort_nonrecursive_internal(struct merge_options *opt,
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

