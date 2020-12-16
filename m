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
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0286C2BBCA
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 17:18:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C532923382
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 17:18:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727089AbgLPRSB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Dec 2020 12:18:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726934AbgLPRR7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Dec 2020 12:17:59 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BBD3C0617A6
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 09:17:19 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id v14so3095193wml.1
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 09:17:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=blnPZRf9svROrs+qNuR+fBHyvJr8SF3u351Y7xxSTlI=;
        b=FXcTRQR1hV0+yNaZSStnTtQHOd9j+IBooXXi74xQkIFJhUW9+4Q5OzwdSHW9Aua9Ms
         adyGPO/Tv1GOH/T52vFe7dHMih6CjpzfarP1RDntFPP8wxpygPY5U1BxHIeWwP8c/UpF
         1DYytU2F/OzJeG3XgRw8V2yYUuzwwJdt5CvV3TJrxTkUduE7BRmeASn6yZGVZge6X9op
         w3OxRCZi56dlqBJtvVKipPYZpOz1yZtMxfqkaUx4Z9OlMG4uYIfQN5EwDM8rnqhLlRnx
         AS3rI7GYdOmTaRb1Fx6T2ncFj3qGPXawLXdM8C/BM8BITZWq6fmUEnsorRFn6I88OBH5
         x1jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=blnPZRf9svROrs+qNuR+fBHyvJr8SF3u351Y7xxSTlI=;
        b=BidFMahiI5a9ZZLpC65apXG/KD1Kiz6Qoih/EvisL34SagtfE/bXSjNogUNgOiRgeH
         AH6+/LjShDuEIYTvzvV3K/BPSVma4ZC7GIltWX0cqKj97Plplrb++aSQLhgfhs0qwmWH
         8pcechwd92G0SFr6+l6/NPbJlTp47zgOmO5iPDykTN56J0Ge+eBJ87JHrA7J2SDX4GR+
         5pnXWv9FpRtpCCmZJNM58/cgKqIKBq2xBIHUgShP/YplAw40jCaz0EtmjYrLsz5WxRQM
         nu43hlJ7n2/FwvNCJBQIj02wWPkpki/UGVAtM5wcJnQKjGeRm6/h2mUyGRJWcjLhS4y2
         pxZQ==
X-Gm-Message-State: AOAM5309bS+g4+Mvbyp+piEHlIKFnxJ7mIQTGmXsT8u9CBFObZ1Z8Hwc
        BpuqzoH1UQLxVEc8oNGxjPGcnJd7F1A=
X-Google-Smtp-Source: ABdhPJwCLHLVDdkVRRDCHYbi6gw5kpwLcj0koVApLFryCw0/2qfOXvdZsIA3xrGReT22PgQYuAupUg==
X-Received: by 2002:a05:600c:210e:: with SMTP id u14mr4468090wml.48.1608139037700;
        Wed, 16 Dec 2020 09:17:17 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b14sm3936306wrx.77.2020.12.16.09.17.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 09:17:17 -0800 (PST)
Message-Id: <bffc45c6570774dcf4a74fe20b0aef3780ea8cde.1608139034.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.814.v3.git.1608139034.gitgitgadget@gmail.com>
References: <pull.814.v2.git.1608097965.gitgitgadget@gmail.com>
        <pull.814.v3.git.1608139034.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 16 Dec 2020 17:17:13 +0000
Subject: [PATCH v3 2/3] merge-ort: make clear_internal_opts() aware of partial
 clearing
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

In order to handle recursive merges, after merging merge-bases we need
to clear away most of the data we had built up but some of it needs to
be kept -- in particular the "output" field.  Rename the function to
reflect its future change in use.

Further, since "reinitialize" means we'll be reusing the fields
immediately, take advantage of this to only partially clear maps,
leaving the hashtable allocated and pre-sized.  (This may be slightly
out-of-order since the speedups aren't realized until there are far
more strmaps in use, but the patch submission process already went out
of order because of various questions and requests for strmap.  Anyway,
see commit 6ccdfc2a20 ("strmap: enable faster clearing and reusing of
strmaps", 2020-11-05), for performance details about the use of
strmap_partial_clear().)

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index b66f8a6f100..7679c1d08e2 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -253,10 +253,11 @@ static void free_strmap_strings(struct strmap *map)
 	}
 }
 
-static void clear_internal_opts(struct merge_options_internal *opti,
-				int reinitialize)
+static void clear_or_reinit_internal_opts(struct merge_options_internal *opti,
+					  int reinitialize)
 {
-	assert(!reinitialize);
+	void (*strmap_func)(struct strmap *, int) =
+		reinitialize ? strmap_partial_clear : strmap_clear;
 
 	/*
 	 * We marked opti->paths with strdup_strings = 0, so that we
@@ -266,14 +267,14 @@ static void clear_internal_opts(struct merge_options_internal *opti,
 	 * to deallocate them.
 	 */
 	free_strmap_strings(&opti->paths);
-	strmap_clear(&opti->paths, 1);
+	strmap_func(&opti->paths, 1);
 
 	/*
 	 * All keys and values in opti->conflicted are a subset of those in
 	 * opti->paths.  We don't want to deallocate anything twice, so we
 	 * don't free the keys and we pass 0 for free_values.
 	 */
-	strmap_clear(&opti->conflicted, 0);
+	strmap_func(&opti->conflicted, 0);
 
 	/*
 	 * opti->paths_to_free is similar to opti->paths; we created it with
@@ -1344,7 +1345,7 @@ void merge_finalize(struct merge_options *opt,
 
 	assert(opt->priv == NULL);
 
-	clear_internal_opts(opti, 0);
+	clear_or_reinit_internal_opts(opti, 0);
 	FREE_AND_NULL(opti);
 }
 
-- 
gitgitgadget

