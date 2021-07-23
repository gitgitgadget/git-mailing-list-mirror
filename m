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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 992E3C4320E
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 12:55:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84E8860EE6
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 12:55:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235276AbhGWMOh (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Jul 2021 08:14:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235272AbhGWMOc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jul 2021 08:14:32 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C08CC061760
        for <git@vger.kernel.org>; Fri, 23 Jul 2021 05:55:04 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id q3so2333012wrx.0
        for <git@vger.kernel.org>; Fri, 23 Jul 2021 05:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=eo6YS9RKiDdSQvh4S6rlw0RqN1dCIpvmEFt84BKWq34=;
        b=iCLFvylmqgUU2ToOBV8wfLcnFLySXcRHSaCS+hLPNgrZPRQcZGa+un0OAHTOcgn0KC
         0tfFI9ILuBDTGXIFqpunmanIXkyVw0rbe38FpIpFi/2gBrCDwEYSPETmlwdLhlfO3aBR
         Uxw+POP7hgsPO6907K9WVihqFqNCEu/masvZG2yUKFZsPcKMNHHKAz4j61Sr1ofg97j/
         qDfRm91YR3EiSs+Td6dhxs3vDfVVpGosSma8TpViDEGRwTgzPRcWtGBYnDWqkJiTdhZx
         d/YZZ9E03r9Dkfr72y2hqNVrjSgrPkvq1kwrWIty5O8WWJdGIVQZfHr2WRO0VjdLS1rF
         kJTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=eo6YS9RKiDdSQvh4S6rlw0RqN1dCIpvmEFt84BKWq34=;
        b=qc59sBBwP8AjUuLvuaY60DMcNhQDfDh6iIcd7ODAFT1OUsQg24p85hQVaaUusP/vaD
         /Z6p43FyUkAMJ6dDroFaPM2+EkDGurM2+HSysOT/H+k/qJyxew0Z53nU6RgyMIhkMs7F
         7fqHBTEF6aM23XCTzzEyFFqio6mytsmZ6caKLqQsd22uT3KgiB2EQAlWM3hoe2Fs5bAd
         KrdTL5eESLTHYGaL7Nv4Zi8BbZAFgP3hpyIBqG2MENvs+Amfvn8q6CgUQ/7wO7BHhMwX
         JD9KeUEKxN9yXmo6mOgX8YoMgnj5Tp7ofz7h5GYQC+mZUNNLXneXImhLJxduI1GP3S2h
         0P4g==
X-Gm-Message-State: AOAM53111IzE4AcSi40dOfwreb8gnu+cEIjeKedxfl7ccyf8mBGKd4Jn
        DGCrvznqHasfRFRMHirlJyf3FYodaQI=
X-Google-Smtp-Source: ABdhPJwCge+mAI0n35sg9OPi0wYz/pj6e/ODqlPAVaUi2pIiKBMNCn3skH5FppegZkR16PMl0sffXw==
X-Received: by 2002:a5d:456d:: with SMTP id a13mr5207476wrc.255.1627044903186;
        Fri, 23 Jul 2021 05:55:03 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z25sm28052535wmf.9.2021.07.23.05.55.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jul 2021 05:55:02 -0700 (PDT)
Message-Id: <17aa0a748494e72df1e0e2303ed650917e59a101.1627044898.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.990.git.1627044897.gitgitgadget@gmail.com>
References: <pull.990.git.1627044897.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 23 Jul 2021 12:54:57 +0000
Subject: [PATCH 7/7] merge-ort: reuse path strings in pool_alloc_filespec
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
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
