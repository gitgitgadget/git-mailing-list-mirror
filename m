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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F31DC4338F
	for <git@archiver.kernel.org>; Thu, 29 Jul 2021 03:59:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5483760F6B
	for <git@archiver.kernel.org>; Thu, 29 Jul 2021 03:59:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233694AbhG2D7B (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Jul 2021 23:59:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233639AbhG2D6w (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Jul 2021 23:58:52 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D7F7C0613C1
        for <git@vger.kernel.org>; Wed, 28 Jul 2021 20:58:48 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id n28-20020a05600c3b9cb02902552e60df56so3009032wms.0
        for <git@vger.kernel.org>; Wed, 28 Jul 2021 20:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=eo6YS9RKiDdSQvh4S6rlw0RqN1dCIpvmEFt84BKWq34=;
        b=eidhVCj1zFC5e+zTigOMyrC/gtlrq47Mm+qSoxPnIHHrHNmQ3ziEip/nDRCav2UrKF
         kzbqp+JYeGSXGMuzpMkcavHLlW2gc0HQouD1bWA8L1HD1zIXYgPqx0hV31rac72rtkvY
         CdKKeVlHC/0yIBLrGjqIgPBdaDHTyMPHumOwOUKyAdhcwTivrRkQiLe33MAc71QPlU7k
         Z6DmAP08/lGc74zm1aOVWAXGwv9PAcd4BW7lo9tfOdM5vqiMivB049r1xWmuSAxXnw5x
         +Dn4qgKKfoSZDEBKBImQeTyDTswG4lzTGpsl1FDBU2n5t6UVVOX7TgWRm1kZsIzBmMwq
         nrTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=eo6YS9RKiDdSQvh4S6rlw0RqN1dCIpvmEFt84BKWq34=;
        b=IVyQJzMHfPmhxyWFgCWs7oxRqnYO30HIOZG5isAz6Y0QkXw35v1BbBIqtPvfTMfoXo
         KgZyQVTW7WkLdjdyGdlQgmn1dfCYkeZNdRSnuepdK+GIBX2gTY71++fH1Cv9kQ3PPear
         K1rMHs2cUFd9XhTZO6XfwaBHemnp867QbQhPox4b6Qp60SZ1F2KSMFr7DP1DxfZJ/Xbx
         QCQ92y0rVnm8ENgW76vqw4ICEN7W1JBieUfElnBLQPrHbzuUkAdJrdQOrPW/CnYrvAP2
         zZJBRjfz8OI4soQD2zDQkbBWm3jox/MKVBDL7BUC7ORAOVi0LhN39Y2XNEe0TXqNg80d
         UMlg==
X-Gm-Message-State: AOAM532syetYzPz1hXXYM2OEyE1yTrqTVzA6Xak2pJ8TGzkZG4r73tN8
        1uYspWRoQvr0CwBnUAUsmJ3LkXKyCng=
X-Google-Smtp-Source: ABdhPJzavRA87XjUsL+YOMf4HoBOtQd8eHwtCnhZYCxlRoR7Fa14jkcfHt/PSknoH4L48sDkONSH2Q==
X-Received: by 2002:a1c:7314:: with SMTP id d20mr2457228wmb.167.1627531126885;
        Wed, 28 Jul 2021 20:58:46 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c204sm379485wme.15.2021.07.28.20.58.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jul 2021 20:58:46 -0700 (PDT)
Message-Id: <fda885dabe654b09822c5d7697abceda8b3e65d5.1627531121.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.990.v2.git.1627531121.gitgitgadget@gmail.com>
References: <pull.990.git.1627044897.gitgitgadget@gmail.com>
        <pull.990.v2.git.1627531121.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 29 Jul 2021 03:58:41 +0000
Subject: [PATCH v2 7/7] merge-ort: reuse path strings in pool_alloc_filespec
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
index d29c7fe8a30..0fb942692a7 100644
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
