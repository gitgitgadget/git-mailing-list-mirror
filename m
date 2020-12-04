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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 122ADC4361B
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 20:49:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D65E222CF6
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 20:49:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729391AbgLDUtL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Dec 2020 15:49:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727517AbgLDUtK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Dec 2020 15:49:10 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3859C061A54
        for <git@vger.kernel.org>; Fri,  4 Dec 2020 12:48:18 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id 3so8152330wmg.4
        for <git@vger.kernel.org>; Fri, 04 Dec 2020 12:48:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=WYOD5AtdxVLH1YV7SPTrpljjr50F7ig+c9RRQqMMot0=;
        b=U6gJQlNAOfBo44axlUuz4yDCmCJbiSKUJywicHqjZvSU5BxKvR2svJjE/BlIDgoVB3
         omKqLckrg+g5KXMyjAhTxaUy/D39nZwGYP0I5H1XUg3cU5ZqECfgHQLsMy4TUYLKTyxW
         2rBemZRd+IJVXfE31YYuiIgbDzVXkfBfbIhXT46oNhf31utHa/B52fqD5mr7+54UdIXd
         LkncIyKgaRg2zW77j6W57oqz0nfxsbZ2jWDEnK/t4ejiWUkc53UzHxJxTG2BlVq5+jeq
         JsyF1NgUGR3XS4DJfZuZM3QYloYzAkxmJuYUetj1jiFWG43p/++CJJpGWnA/lhbsu02B
         8THA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=WYOD5AtdxVLH1YV7SPTrpljjr50F7ig+c9RRQqMMot0=;
        b=bixYaD5zFECCBZoOfihnUr/lMG+Tza0m9hXiiKDeVIIdhqhTRu592IPyrxfA1W7prp
         YlmMgM1t0yKxlr0dYlAhk86cKXv3eUAmNzF43i4PGn/ENM0dY8e1L6pKUu4RnLOtRChp
         Wu8gsHZfTNhLN7Q++7mPFHMJzM1Aiq8GB577iU1fgBDW5PppOgabc2hfhNkfMvXA0HUc
         CrA8NxYiVaieDOvfqChLm4umncPvkr1gw4hRiDkU6JZbPaujkucAowxHJ3yMBeHfjFGp
         CfdVoyUCahpJA7RZQBZKtF0g7R7GdlZpfOah2KaRv6v1zELqurEJePJxrgxVdRDQG/ZN
         kOdQ==
X-Gm-Message-State: AOAM532W31qevd3UopLpzbC5lPolVwMIg0sTqLpFH+33w/8lDtFjuPKn
        +EtswEdZg1qsxI5KNBwKd3eA42dJACk=
X-Google-Smtp-Source: ABdhPJw1yESpL5FAkaC7pNItBxAzmlrl+JjNP+MLYWUrajDva2tgBAOSrnn0AYDGuAdG8yvRCsdN8A==
X-Received: by 2002:a7b:c2e8:: with SMTP id e8mr6010611wmk.103.1607114897237;
        Fri, 04 Dec 2020 12:48:17 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n14sm4471123wmi.1.2020.12.04.12.48.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 12:48:16 -0800 (PST)
Message-Id: <22fecf6ccd1e1eb80bb8391975b482b3d6233540.1607114890.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.923.v2.git.git.1607114890.gitgitgadget@gmail.com>
References: <pull.923.git.git.1606635803.gitgitgadget@gmail.com>
        <pull.923.v2.git.git.1607114890.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 04 Dec 2020 20:47:54 +0000
Subject: [PATCH v2 04/20] merge-ort: use histogram diff
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
index f8ac721aa3..ff305bcbe4 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -21,6 +21,7 @@
 #include "diffcore.h"
 #include "strmap.h"
 #include "tree.h"
+#include "xdiff-interface.h"
 
 struct merge_options_internal {
 	/*
@@ -235,6 +236,9 @@ static void merge_start(struct merge_options *opt, struct merge_result *result)
 
 	assert(opt->priv == NULL);
 
+	/* Default to histogram diff.  Actually, just hardcode it...for now. */
+	opt->xdl_opts = DIFF_WITH_ALG(opt, HISTOGRAM_DIFF);
+
 	/* Initialization of opt->priv, our internal merge data */
 	opt->priv = xcalloc(1, sizeof(*opt->priv));
 
-- 
gitgitgadget

