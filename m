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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5694C433DB
	for <git@archiver.kernel.org>; Wed, 30 Dec 2020 19:28:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C4C122242
	for <git@archiver.kernel.org>; Wed, 30 Dec 2020 19:28:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbgL3T2S (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Dec 2020 14:28:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbgL3T2R (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Dec 2020 14:28:17 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93E8AC0617A1
        for <git@vger.kernel.org>; Wed, 30 Dec 2020 11:27:02 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id d13so18281497wrc.13
        for <git@vger.kernel.org>; Wed, 30 Dec 2020 11:27:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=yzUvAlkC6AezbURrZeXlgW53aCmu8K4Q6nyWEKnDQMs=;
        b=P+JxTJO4XolcNI4ee8WAIFKCg2NoZpXDdf9b5fVj6eWO/2KRT17L3uEnJCPfym6zNn
         790M7fTD0e1aUiCnNEz85sovpfJFCID43QT8WrMUKsOv54fySmVk7gWc2a2oM+B+eQD9
         QPfDZ/1B/uRBaxdLq4KBKNTDIZ84msAULB7G4EnOvoFT6PJWnB2xOFVKA0/hO7RvyXvo
         WywoX7wOsT2/0S3NRh6lfTT4FudGzU6dNwN14APB+RUdl/kC90O90I2L3ygNRE9IHIZw
         6kgZBvuuXr+g2nfGsQCaboCpdpZRoA0Q0MwZ37NDPn0Emm+S+OY8biqg+BuBgL9fjlrv
         LRPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=yzUvAlkC6AezbURrZeXlgW53aCmu8K4Q6nyWEKnDQMs=;
        b=mdH4EeE2Zyxy95N5UkRF7sgYUznIm40VIuFMsRvHjQmNfM/0x5RkVFAKnQzNByomax
         74kl+qNpnQJB5ddKFtSzBV6gEEfbqv2giWuuNoYkOZ00uDeNIm1A1qNbqEJ2ZvhJeTNM
         Fe0Gz/2SyoAFI3Z0DDBJnoom5SqmMh08VECMDhSDvoQaaYjpO/iJp7mZlwfaew0BjcrY
         yL2tkhzVduhEU9olKIpg33ZVWQldlNgR0zUdJsfb4WHbH8pONisRSiU7LEbCS0q4VlLY
         0ssbPEwiPx0H/kh23LaEmypaberKm3Cf8dthyhWoSoJ8ckEcVTDe57xjFNlXuN5oXKYg
         mrSA==
X-Gm-Message-State: AOAM533W2OIHCZQVKu52tUov6VUkx+uzTqNQkwSQlCqrqqbUxrpleKNp
        c+Z45lTwOZsfflPuovA4SW77KbziKEY=
X-Google-Smtp-Source: ABdhPJzF+qMjYr6F+w6S9n4Dlht+W13Z6mTA+xknub8wi62pMCZS4E4zQDLcyGVS0udHnGWBr6V9wg==
X-Received: by 2002:adf:df08:: with SMTP id y8mr60183574wrl.278.1609356421245;
        Wed, 30 Dec 2020 11:27:01 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y11sm8425685wmi.0.2020.12.30.11.27.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Dec 2020 11:27:00 -0800 (PST)
Message-Id: <20ea7050324cdd78b0966f54366b26224dfc7814.1609356414.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.829.git.1609356413.gitgitgadget@gmail.com>
References: <pull.829.git.1609356413.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 30 Dec 2020 19:26:53 +0000
Subject: [PATCH 8/8] cache-tree: avoid path comparison loop when silent
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The verify_cache() method is used both for debugging issues with the
cached tree extension but also to avoid using the extension when there
are unmerged entries. It also checks for cache entries out of order with
respect to file-versus-directory sorting.

In 996277c (Refactor cache_tree_update idiom from commit, 2011-12-06),
the silent option was added to remove the progress indicators from the
initial loop looking for unmerged entries. This was changed to be a flag
in e859c69 (cache-tree: update API to take abitrary flags, 2012-01-16).

In both cases, the silent option is ignored for the second loop that
checks for file-versus-directory sorting. It must be that this loop is
intended only for debugging purposes and is not actually helpful in
practice.

Since verify_cache() is called in cache_tree_update(), which is run
during 'git commit', we could speed up 'git commit' operations by not
iterating through this loop another time. Of course, noticing this loop
requires an incredibly large index.

To get a measurable difference, I needed to run this test on the
Microsoft Office monorepo, which has over three million entries in its
index. I used 'git commit --amend --no-edit' as my command and saw the
performance go from 752ms to 739ms with this change.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 cache-tree.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/cache-tree.c b/cache-tree.c
index f135bb77af5..c6c084463bd 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -175,10 +175,15 @@ static int verify_cache(struct cache_entry **cache,
 	if (funny)
 		return -1;
 
-	/* Also verify that the cache does not have path and path/file
+	/*
+	 * Also verify that the cache does not have path and path/file
 	 * at the same time.  At this point we know the cache has only
-	 * stage 0 entries.
+	 * stage 0 entries. In silent mode, we do not want these messages,
+	 * and they should not exist unless a bug was introduced along
+	 * the way.
 	 */
+	if (silent)
+		return 0;
 	funny = 0;
 	for (i = 0; i < entries - 1; i++) {
 		/* path/file always comes after path because of the way
-- 
gitgitgadget
