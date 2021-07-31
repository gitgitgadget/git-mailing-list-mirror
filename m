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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89B8CC4338F
	for <git@archiver.kernel.org>; Sat, 31 Jul 2021 17:27:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F2AA61042
	for <git@archiver.kernel.org>; Sat, 31 Jul 2021 17:27:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231435AbhGaR2A (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 31 Jul 2021 13:28:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230515AbhGaR1y (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 31 Jul 2021 13:27:54 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C6ABC061799
        for <git@vger.kernel.org>; Sat, 31 Jul 2021 10:27:48 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id m20-20020a05600c4f54b029024e75a15716so8424048wmq.2
        for <git@vger.kernel.org>; Sat, 31 Jul 2021 10:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=I+3F03G+KYmxjI0L6JdxmvBn1HFd+nJBLZJ0YJyORGI=;
        b=X+D9uocKCZk7WZZdwmRg/10hUJpsx6nBMP6ULqjEr86oc+D1Bq0Ep+iQGMFwcMJzkO
         +wHwmjk6shLW7PoBvG4G3p3z8eK11sOSzwmtWZYWTtFMlqldyWN80ozI9w3Q2RlvlugS
         0mhAfY7S+K+L7nwg1h8r1g/NtEQhpQT2y6fQRGqSJL6KmHQ/LZftm1b72tlcAYsbTMzl
         CNTwFgZ2J73tQatjaoHvKaoQe1LWav1/ShR6Q2QvdTTCjtl/t9zoa0UaghWV81e62LfI
         ZDd5GGGZak2txBxXN+IGCvCZYVT5lKdc3WCzXT9La2nRtCdnCxMw+Daqgx6zACmLjkY/
         gRcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=I+3F03G+KYmxjI0L6JdxmvBn1HFd+nJBLZJ0YJyORGI=;
        b=qea0dzDnwO68gA6CJ4m+fJswStR3DQwhC9g3bs058egWEigO+cPAvlyHE1WnamzmRH
         kh8ZNS25CS4OMm11t6UwZab/AawtIqFb4TkFRyaX5+LKtbWvteCbW0h52esBMjDah1kT
         EzrVoKRd6ufSXAJk+eiUX8e2k94E2irrQtrhZYHWu99ZjBKNwreNB0hHADXxKdtGFxHh
         FBid4aBiu2HW37unF31FmfcGCzw3RY0pEGa5aUhIXkjjsItdPhpOciL7euKHaNoflVQG
         RRl+d+m7GCIgMTIlq5gV40SWmDtYIRhJ6PLBl3MsCoOWfw/oRUv9jzbjg7Kx0bWu05XP
         pGug==
X-Gm-Message-State: AOAM531jml8R8NzRtjMuIv4rj00rlz8v5ap5JXRiNVQ5e8X+lJVHzqB9
        V7LQm0YBjhvmLthT0c5HJEODThvuuoA=
X-Google-Smtp-Source: ABdhPJwjuMyCkiIpblv0hWEKCsmb10UPpsnS+8uwv0QvMweTD2uG3gLLO0k/bRKI7eL7t0pEDDWHPg==
X-Received: by 2002:a1c:7907:: with SMTP id l7mr8988313wme.87.1627752466872;
        Sat, 31 Jul 2021 10:27:46 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z12sm5114009wml.18.2021.07.31.10.27.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Jul 2021 10:27:46 -0700 (PDT)
Message-Id: <1556f0443c35a95fbdbc1cb1841f81f9c4615f4c.1627752458.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.990.v4.git.1627752458.gitgitgadget@gmail.com>
References: <pull.990.v3.git.1627645664.gitgitgadget@gmail.com>
        <pull.990.v4.git.1627752458.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 31 Jul 2021 17:27:37 +0000
Subject: [PATCH v4 8/9] merge-ort: reuse path strings in pool_alloc_filespec
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

pool_alloc_filespec() was written so that the code when pool != NULL
mimicked the code from alloc_filespec(), which including allocating
enough extra space for the path and then copying it.  However, the path
passed to pool_alloc_filespec() is always going to already be in the
same memory pool, so we may as well reuse it instead of copying it.

For the testcases mentioned in commit 557ac0350d ("merge-ort: begin
performance work; instrument with trace2_region_* calls", 2020-10-28),
this change improves the performance as follows:

                            Before                  After
    no-renames:       198.5 ms ±  3.4 ms     198.3 ms ±  2.9 ms
    mega-renames:     679.1 ms ±  5.6 ms     661.8 ms ±  5.9 ms
    just-one-mega:    271.9 ms ±  2.8 ms     264.6 ms ±  2.5 ms

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 29 ++++++++++++++++++++++-------
 1 file changed, 22 insertions(+), 7 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index f4f0a3d57f0..86ab8f60121 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -694,17 +694,13 @@ static struct diff_filespec *pool_alloc_filespec(struct mem_pool *pool,
 						 const char *path)
 {
 	struct diff_filespec *spec;
-	size_t len;
 
 	if (!pool)
 		return alloc_filespec(path);
 
-	/* Same code as alloc_filespec, except allocate from pool */
-	len = strlen(path);
-
-	spec = mem_pool_calloc(pool, 1, st_add3(sizeof(*spec), len, 1));
-	memcpy(spec+1, path, len);
-	spec->path = (void*)(spec+1);
+	/* Similar to alloc_filespec, but allocate from pool and reuse path */
+	spec = mem_pool_calloc(pool, 1, sizeof(*spec));
+	spec->path = (char*)path; /* spec won't modify it */
 
 	spec->count = 1;
 	spec->is_binary = -1;
@@ -2904,6 +2900,25 @@ static void use_cached_pairs(struct merge_options *opt,
 		const char *new_name = entry->value;
 		if (!new_name)
 			new_name = old_name;
+		if (pool) {
+			/*
+			 * cached_pairs has _copies* of old_name and new_name,
+			 * because it has to persist across merges.  When
+			 *   pool != NULL
+			 * pool_alloc_filespec() will just re-use the existing
+			 * filenames, which will also get re-used by
+			 * opt->priv->paths if they become renames, and then
+			 * get freed at the end of the merge, leaving the copy
+			 * in cached_pairs dangling.  Avoid this by making a
+			 * copy here.
+			 *
+			 * When pool == NULL, pool_alloc_filespec() calls
+			 * alloc_filespec(), which makes a copy; we don't want
+			 * to add another.
+			 */
+			old_name = mem_pool_strdup(pool, old_name);
+			new_name = mem_pool_strdup(pool, new_name);
+		}
 
 		/* We don't care about oid/mode, only filenames and status */
 		one = pool_alloc_filespec(pool, old_name);
-- 
gitgitgadget

