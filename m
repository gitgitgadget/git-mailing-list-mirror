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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 586F1C2BB9A
	for <git@archiver.kernel.org>; Tue, 15 Dec 2020 17:54:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 220FE2255F
	for <git@archiver.kernel.org>; Tue, 15 Dec 2020 17:54:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730942AbgLORyc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Dec 2020 12:54:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730813AbgLORyM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Dec 2020 12:54:12 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AAA3C0617B0
        for <git@vger.kernel.org>; Tue, 15 Dec 2020 09:53:31 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id k10so49267wmi.3
        for <git@vger.kernel.org>; Tue, 15 Dec 2020 09:53:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=oGniVBwEFHKszGc3iJr/1jBXdjZM5vgMkG10Ypha1l8=;
        b=JOBR0SRUHBCPsWaHlKGzD4dMROg/5lcw/DE8F/wrlR5Pm/cAnN0wsq69k2x0V+Zh9A
         HdLIlL3iPTRwXYnvB33pgJSqT8pwIQ2bGyE6vzNsBHRv5aEjjGQdheQv52fiNkc6AWZK
         JLQbFC70X+yW/k9QsaQl9BiYKoq5L0wMHcle8QQQ3lsMq9RMsYDDXNW3hX8oOZC0Z3hw
         +viKBTD+VXDX3Tltj8UWllxX/cyEFfKbLWgYFQGhi0otJ9syf//nExeIeepJU01dHZAK
         RT1x5PDIVLHiWHzCUMoZroEr9HUlFGPjWMTkZnBVk9d9vDcvz2TPxyF5haSYfUQu6xvQ
         Ljzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=oGniVBwEFHKszGc3iJr/1jBXdjZM5vgMkG10Ypha1l8=;
        b=NhWSZKDAfM7PTUe1oE+0jAuOQnidCG5W+wCNCtwBVekK7YQXC5rmdi7UX+rktsoZ3s
         yTiU+IBzMbYrb//C7qd0P4FhwkNCFv0ZPfFk2O5+0PpEneSMHdYoiA9/MT6U0d7SlrLm
         uiqBuDRZBN1cyPaWZ89NSSRxerIkr3c/qv3Pf93ROdtqbuqa/yTD6084J8jClVZBPMTE
         GML9p98LGx/s8Tty4LxXHsd+GMngsmTgbJjIO5JT3KvQqWsWiPlH8W29ci57t5uj6vTT
         gHlGvgRrdMZcP3e+/rIty8OEerovKeEL6+JVwTQVeYL979N/F70xl5Q9cZ9cb3Nn1X1m
         b+Eg==
X-Gm-Message-State: AOAM531ohmrw9zcgO46GUarTEcKyp0p8FVd/vKZgcWReQ6XDimgIbvU1
        y9X5oSxi4Y2Y9W5zxzineLcNggA3734=
X-Google-Smtp-Source: ABdhPJyr9E1nzEa8dVkNmPlpXhKP5NFMYDP0CmNHAUnf46kXVPQYsX+8EMJV1QAOo788fQ1H3zL4Og==
X-Received: by 2002:a1c:630b:: with SMTP id x11mr42930wmb.138.1608054810186;
        Tue, 15 Dec 2020 09:53:30 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f9sm40595039wrw.81.2020.12.15.09.53.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Dec 2020 09:53:29 -0800 (PST)
Message-Id: <fc26c1a11db76843b0a439d2c69567fcd7ad9ac2.1608054807.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.814.git.1608054807.gitgitgadget@gmail.com>
References: <pull.814.git.1608054807.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 15 Dec 2020 17:53:26 +0000
Subject: [PATCH 2/3] merge-ort: make clear_internal_opts() aware of partial
 clearing
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
index 05ba92c91a6..10a97e944c4 100644
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

