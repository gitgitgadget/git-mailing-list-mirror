Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74A10C433E0
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 15:51:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3038A64ED4
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 15:51:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231414AbhBXPvM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Feb 2021 10:51:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238375AbhBXOv1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Feb 2021 09:51:27 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 335D8C061574
        for <git@vger.kernel.org>; Wed, 24 Feb 2021 06:32:00 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id u125so1992878wmg.4
        for <git@vger.kernel.org>; Wed, 24 Feb 2021 06:32:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=lPRyw7lc9ZygjxICrPkrRnBX1AhM3KqNkhctsaTD6M0=;
        b=LUxxjEZisMimNsV2U6gztzR7njTDZjE+GaJogKo4lpq0DCg9oRmpCZyr8Up9/BI4as
         5SPkUEuxl8z8iGfxnIJeiNjCDISVFtkkbCSjnRz5sjBxGc2f61/fz794qM9u2zRLWZPU
         eCvsKFLWmiGzGs1ErVZl43+yCg7cI1LleC+yyCP0KM4E4x3yr3qnBpoe0rjymGdeZXl/
         +5Rq0sWwY7/+nG9T0h6KGe+fpRGCMJGbrJ6XWmp2fXkFProCo7RDOu/qxj70uAVtZC16
         UVWga5frSjbGtitRp5QqK+6wYkgRk1XYX+AWurCjRTjLZimVX6v5H7hhEAxeXz0a/i/I
         tr1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=lPRyw7lc9ZygjxICrPkrRnBX1AhM3KqNkhctsaTD6M0=;
        b=DRxGeq5/FCUGX+dZcKnhA1t4TpeTN2ZehU4YShww/6Q8wG6Q5gDaVj+irbrXi/FSXd
         sws52ns8mBmcbUX+1lna8fcD6fVahynTswO/ZXE3mWg8rfwvaCn+cB2JqI8zBQATxZpa
         d7/7R2GF//JDIRXfVZtEf0cqZIcfEkXbv1yRMDpw0rWz5NpyX2lYPM+tOnytq1bvYU+Q
         FfBhUu/ftI/1LHNhqG/z/w+m1t5vtRMueY8LLJr03QtiEJH42ntF+749uNXzdFtSIQVa
         5wy3dM+s+dhIoj8UwQOzjurLmodx5ZYPJcUQC/eFt7nt0rb9FOELzwArUJoNzCHGyhGk
         Gf6Q==
X-Gm-Message-State: AOAM533FrKxOm2Dlk7Cg6EmbYj/tF7cdjj03OT00MYoyiZpVr+fzsd3C
        CKmIi3nkQUK7UTPVRBZt9o2dd731D/k=
X-Google-Smtp-Source: ABdhPJwshf4z2H+358w5NcIC5DBCRXKJg2h8MiaTWqBm7tbkg/8pftux1qdXU0iaty7gnPlzUua6fw==
X-Received: by 2002:a7b:cc84:: with SMTP id p4mr4098818wma.150.1614177118737;
        Wed, 24 Feb 2021 06:31:58 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j125sm3275134wmb.44.2021.02.24.06.31.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 06:31:58 -0800 (PST)
Message-Id: <pull.884.git.1614177117508.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 24 Feb 2021 14:31:57 +0000
Subject: [PATCH] dir: fix malloc of root untracked_cache_dir
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Use FLEX_ALLOC_STR() to allocate the `struct untracked_cache_dir`
for the root directory.  Get rid of unsafe code that might fail to
initialize the `name` field (if FLEX_ARRAY is not 1).  This will
make it clear that we intend to have a structure with an empty
string following it.

A problem was observed on Windows where the length of the memset() was
too short, so the first byte of the name field was not zeroed.  This
resulted in the name field having garbage from a previous use of that
area of memory.

The record for the root directory was then written to the untracked-cache
extension in the index.  This garbage would then be visible to future
commands when they reloaded the untracked-cache extension.

Since the directory record for the root directory had garbage in the
`name` field, the `t/helper/test-tool dump-untracked-cache` tool
printed this garbage as the path prefix (rather than '/') for each
directory in the untracked cache as it recursed.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
    dir: fix malloc of root untracked_cache_dir

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-884%2Fjeffhostetler%2Funtracked-cache-corruption-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-884/jeffhostetler/untracked-cache-corruption-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/884

 dir.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/dir.c b/dir.c
index d153a63bbd14..fd8aa7c40faa 100644
--- a/dir.c
+++ b/dir.c
@@ -2730,11 +2730,8 @@ static struct untracked_cache_dir *validate_untracked_cache(struct dir_struct *d
 		return NULL;
 	}
 
-	if (!dir->untracked->root) {
-		const int len = sizeof(*dir->untracked->root);
-		dir->untracked->root = xmalloc(len);
-		memset(dir->untracked->root, 0, len);
-	}
+	if (!dir->untracked->root)
+		FLEX_ALLOC_STR(dir->untracked->root, name, "");
 
 	/* Validate $GIT_DIR/info/exclude and core.excludesfile */
 	root = dir->untracked->root;

base-commit: 966e671106b2fd38301e7c344c754fd118d0bb07
-- 
gitgitgadget
