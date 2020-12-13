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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 972FEC4167B
	for <git@archiver.kernel.org>; Sun, 13 Dec 2020 08:05:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45C8F22D6F
	for <git@archiver.kernel.org>; Sun, 13 Dec 2020 08:05:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393147AbgLMIFp (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 13 Dec 2020 03:05:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725777AbgLMIFO (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Dec 2020 03:05:14 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA966C061793
        for <git@vger.kernel.org>; Sun, 13 Dec 2020 00:04:33 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id a6so11036085wmc.2
        for <git@vger.kernel.org>; Sun, 13 Dec 2020 00:04:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=HmYvvwe91lf2YCvD8rHvJQ8LBJ8qQf8gKQo72XVX0JI=;
        b=mlp7h9PoVVq1mCGH+ObfvyV7q6+e0aIy8CDPEGcPIB+z0xHu9SIKJXBqOKh+MZNvSU
         9ZAzPEvBuJEDs9/bw5tz9FQUd95vaHV9LAc7vmOqfvGldcXvZrbHhHw90MDjYX1Kb+An
         s8qZlhN7EZJsXRBnLHzeXw5ULeMbjRs+fuvgPRZtGigl2MbxDGE8LgWPy+dKt6BfDrb3
         URrnY+lje7M9pkt/0GJTYRTgxxtSflMI5jX9cEdX1BVivuUI8VglHciH9fgeztZgcTyH
         ihczHESYEuR/BY1uoEulpbNxvyTwzUJYu6JFE08+qXC9yDHAx48hqYG67NTmPUPjtOzB
         vkeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=HmYvvwe91lf2YCvD8rHvJQ8LBJ8qQf8gKQo72XVX0JI=;
        b=FOJib3fHnP6CD24yoc6PcN4KcCOhASdWxzs+4FQTSDylyNauY44NFLEOPWRqsLmXXy
         /1T5iTy+hrUnxueeWgVQyyG4R6NiEb9nbdgWCUsefute18dwXir2uqDXzr385BVVt8fC
         b0ENCxdX260dGvAR1m3hZiVHUsRBYEauRtW5TInLtK2cDnC6WLAOgMAV+Ur6hbed+FxK
         6qlYjlmbwowsFMdNiISKf73THeDiWlTVZhYFvrYr73nJE/m423GCJn26JNNO/z1kE89V
         qN2AB9lKOxkijUCLTa6hodAUV1AOc70WWACSi2YVh9mXfGpZFpG92mwGLMVrZ4WlF+JD
         HwMA==
X-Gm-Message-State: AOAM530OY62FrjrlGhDGMmM4tlznkHHiA1IvOTu4xEJEVHQfRrFgw5pf
        ITmkH6Aob4HXzK10QLBYNT82CuUFLJw=
X-Google-Smtp-Source: ABdhPJyDP1fCkh5k0IdXOEUz0bQFkOWwonygTMICAY1fpj0tMq7ezjNH7G+7Qlt0qP4IIgjaZD7O9Q==
X-Received: by 2002:a1c:4d0c:: with SMTP id o12mr22487978wmh.134.1607846672535;
        Sun, 13 Dec 2020 00:04:32 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s205sm25154328wmf.46.2020.12.13.00.04.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Dec 2020 00:04:31 -0800 (PST)
Message-Id: <38b4f9cf78c885e958158a3960dd74715dc22d97.1607846667.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.923.v3.git.git.1607846667.gitgitgadget@gmail.com>
References: <pull.923.v2.git.git.1607114890.gitgitgadget@gmail.com>
        <pull.923.v3.git.git.1607846667.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 13 Dec 2020 08:04:11 +0000
Subject: [PATCH v3 04/20] merge-ort: use histogram diff
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     jonathantanmy@google.com, dstolee@microsoft.com,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
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
index fb07c8f2b30..85942cfa7c7 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -21,6 +21,7 @@
 #include "diffcore.h"
 #include "strmap.h"
 #include "tree.h"
+#include "xdiff-interface.h"
 
 struct merge_options_internal {
 	/*
@@ -245,6 +246,9 @@ static void merge_start(struct merge_options *opt, struct merge_result *result)
 
 	assert(opt->priv == NULL);
 
+	/* Default to histogram diff.  Actually, just hardcode it...for now. */
+	opt->xdl_opts = DIFF_WITH_ALG(opt, HISTOGRAM_DIFF);
+
 	/* Initialization of opt->priv, our internal merge data */
 	opt->priv = xcalloc(1, sizeof(*opt->priv));
 
-- 
gitgitgadget

