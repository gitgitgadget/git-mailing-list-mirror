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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 439D7C2BBCA
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 05:53:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02F1D2313C
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 05:53:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725824AbgLPFxf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Dec 2020 00:53:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725274AbgLPFxa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Dec 2020 00:53:30 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBEDEC061794
        for <git@vger.kernel.org>; Tue, 15 Dec 2020 21:52:49 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id q75so1229018wme.2
        for <git@vger.kernel.org>; Tue, 15 Dec 2020 21:52:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=oGniVBwEFHKszGc3iJr/1jBXdjZM5vgMkG10Ypha1l8=;
        b=Y4XPf95mZF9eQdIcN5mfWotIIxtLRwyeR8ZJVVw6OcuEky70pev5Q3qOrL45BZr2go
         nYAPm8fZMC+E55MMBcHXBVhdVb5PpoTZRCSnka2b9/A6yYl2iMNCOHJ/N9TsRSgn21Yb
         iEhKJagAA+1XFfX/YsZULALNhmeaSIiNXoL9jPXjLKWPB8WF3z/6RI6mvNAurSfF0btN
         dObLeFHTqmz7lSIPvxm7X54XnQKOU36CyUDOUVJ/UscOC47/XxE/jS/1ZMPq2VSJHwK9
         dLcEFNOeDCe6oWmEbXNslx0OYZhh72gR/Zd+0Yllv4p2L/uEEH3vl1bjviaKOygup9uj
         tF+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=oGniVBwEFHKszGc3iJr/1jBXdjZM5vgMkG10Ypha1l8=;
        b=uCnMqxOJyOiuNehkxX9cgJkdSmCY+bsIn6L12hO2XZXgyaaPPjNT9YGNDELLskS82V
         74j2q5mTvgR6xT45HyTUCFo5fl0e7LwGwhnKfUEzWltfCSrHnTiu9uN/ixiWzTg7gPDs
         wOgmcy3C2ShN6pr9tmcF5jnhUwJ2NtdoTFQcvjBaeQiGXiK6EAhD7XwgwtledZBZBGMF
         YoJmO43576DA1lB9h+q7yYUF8Btz3sSTLHHGuOEzJHQ+wdIdTEPs+g5yFmCe+/aZYbmW
         sYlYonWHiXzQorKb0FZRRNiYsOb8sCV6bNkktvPeVZKk3y0r60rekuGNByGdAQz85cR2
         tsQQ==
X-Gm-Message-State: AOAM533N1kfgVYCTnVbUtWl+fm0JSRsaiMzeozV4aLxpGu+w7qI4ZQye
        3zBeN1eHpPw4ZU06k9T9Xm8C+o9KdUQ=
X-Google-Smtp-Source: ABdhPJwi9GsMbQRXmUVgJv+hs4R+EH3wgYlAq9XVaZjlb4DyJK5ODGGTPBztO79MvNJJCQ7MOAr7GA==
X-Received: by 2002:a1c:24c4:: with SMTP id k187mr1667105wmk.14.1608097968480;
        Tue, 15 Dec 2020 21:52:48 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v125sm1024108wme.42.2020.12.15.21.52.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Dec 2020 21:52:47 -0800 (PST)
Message-Id: <fc26c1a11db76843b0a439d2c69567fcd7ad9ac2.1608097965.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.814.v2.git.1608097965.gitgitgadget@gmail.com>
References: <pull.814.git.1608054807.gitgitgadget@gmail.com>
        <pull.814.v2.git.1608097965.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 16 Dec 2020 05:52:43 +0000
Subject: [PATCH v2 2/3] merge-ort: make clear_internal_opts() aware of partial
 clearing
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>,
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

