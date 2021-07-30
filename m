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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 002F4C4320E
	for <git@archiver.kernel.org>; Fri, 30 Jul 2021 11:48:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E05F560EE6
	for <git@archiver.kernel.org>; Fri, 30 Jul 2021 11:48:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238686AbhG3LsG (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Jul 2021 07:48:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238739AbhG3Lr6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jul 2021 07:47:58 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71ED1C0613D5
        for <git@vger.kernel.org>; Fri, 30 Jul 2021 04:47:53 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id n12so10981282wrr.2
        for <git@vger.kernel.org>; Fri, 30 Jul 2021 04:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=I+3F03G+KYmxjI0L6JdxmvBn1HFd+nJBLZJ0YJyORGI=;
        b=GbUg9MLz40g27+tFPzQkHYInFS7B4VHIJjzvQd0pn6GgARrwii+3ZWhj+i4XDiFKaQ
         m421gUUC4n5PCeNXSgLVWR6xTiLCearcWIaP9X8tP66tEP2xneQl1YRCXl2PGjvkMF/6
         JJnMmV2BsH6oKMdtV/jnZgyGmHZQYtIje+YRRHKN0GnXT0+Duj7lh2gAXWrdLwU2WIaJ
         Lq6hV3aZD38XgQK4enpjpJBfGycHOTuN/gAqFnJ/j9kYnAWyjsbitvnjLOlVfK0ntNUZ
         x4C7GO4jcsaHKq0R5MUe2g4AvTmxsh8dekWpr9ePWFKuoZ/kZM1x2+RM1ZS08dN4W1xC
         qrig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=I+3F03G+KYmxjI0L6JdxmvBn1HFd+nJBLZJ0YJyORGI=;
        b=hfGPEx9ORlzJSDgeZBeUcdddjLhjZBmdz1XX8SVCglEpXpdG1ucriXjjGfxY5PK30D
         KjH5dTJfFYsceegGCPQ6pSRxuYHAZi1FR4gT19lapAlzjEhi2XIQ3UqBLLCigJAcwfU7
         Hd9Yj6qtXUuirgPSbKDzjZ5bG1Oh/XrfnBvD0vlb9fIajRqbrkDoTG87XzYE2T4wpOQx
         zy2smClDqJojyK8/DBnPgbsRLSjmdvY25kv6dNbsFtmzawCV0j6WJoxi0srrJ1ctqor4
         mwJocXznCgxNLT3fGIGhIBTWq6+OP3j4CGJ9FfHH2iw4ZtWei+Ieqt/dn9u2ldIYd05C
         i/DA==
X-Gm-Message-State: AOAM531SpuyNtBHK4Q9wX0m2jvfBjSQUOxt8PfCoZ8ROeZv/dGha2uvl
        /MXr1FXwcEzg4FrZ5y2GahQZ3+l+mo0=
X-Google-Smtp-Source: ABdhPJzG6PaiBOAm+mM4uPALo5CDBtkG7vXjebaD+NEqGH/SWRTHV1m+Wpq3j+PSoJPws8NyH7JdYg==
X-Received: by 2002:adf:d22f:: with SMTP id k15mr2606258wrh.335.1627645672097;
        Fri, 30 Jul 2021 04:47:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j1sm1545204wrm.86.2021.07.30.04.47.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 04:47:51 -0700 (PDT)
Message-Id: <1556f0443c35a95fbdbc1cb1841f81f9c4615f4c.1627645665.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.990.v3.git.1627645664.gitgitgadget@gmail.com>
References: <pull.990.v2.git.1627531121.gitgitgadget@gmail.com>
        <pull.990.v3.git.1627645664.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 30 Jul 2021 11:47:43 +0000
Subject: [PATCH v3 8/9] merge-ort: reuse path strings in pool_alloc_filespec
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>,
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

