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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FFADC4708F
	for <git@archiver.kernel.org>; Tue,  1 Jun 2021 14:58:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B983613A9
	for <git@archiver.kernel.org>; Tue,  1 Jun 2021 14:58:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234343AbhFAPAZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Jun 2021 11:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234238AbhFAPAW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Jun 2021 11:00:22 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 121D4C061756
        for <git@vger.kernel.org>; Tue,  1 Jun 2021 07:58:40 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id c5so3500432wrq.9
        for <git@vger.kernel.org>; Tue, 01 Jun 2021 07:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=wMVXDPLGBMLYT6OBJ2rWFehw8Rz0HAUKh3+HU5yscHk=;
        b=Pkf213Lvk1aVJjQkS/96ika+FK2ZXakm6Yt2yyohBdzYbg8GZB1E7lytg6hbsGtjP/
         LkGgI56Jx2DDPR50SN6gRnyJyEeX9zfNuQhAUFaAhi8mkTUa2D/GIk0r2+ZIf7Jhi02L
         YKvrSc+mjf3WP43R4lzxqGNyj7AVcokIKEc0pdpUBiNZzoNOeojLqwLKYNe+l9/LaNhd
         8CuOdxyaQkuCTUiyNNQBnccy3mAc/WGBt7UELb+zvaG9aygU/PrQOmtxxZVKE7Qe5zps
         06/QPNeRtfJ/jZVd7r4GfHir1UZI1tUqpg7NxjS053yy8YfdMI2OEmkdUY1qARWL9qMR
         4uRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=wMVXDPLGBMLYT6OBJ2rWFehw8Rz0HAUKh3+HU5yscHk=;
        b=CX/KF6gSgCEBRWwoV554juWjXQ84sI+JsecrHMGLalPeSkrEur6xgT4pnyFBSkFpfO
         +FS4KEVAFuw92OL9t0GC6ebOcecCZH9GDAOGWOfHOcWManlKngMPECSHEK1htzicZm+g
         uMjOIoMj2hrsegTEkiCE+ISuOAC/ZkA61QOoDdreuiB9rhH9Tp9qFoDihakVNKocycS/
         aOYVWvbtsbTGsryP+fGPHkJWjwLnIGKymoROc0zlHDK4uYW3TwOkn2nn+qn5q8z7RnmD
         972shF9KDGgnxZEGF9PRoWQwgqaipzWdGEPK9CxvIE7ivI72v1msFi5Ih4VEivTD6gBq
         SMvQ==
X-Gm-Message-State: AOAM530xeO6/8FLOto5CulkDQpJ8MzMROYaSjAM2zYFW2Y8QhOiPTD3P
        ttL+KRgSY3L7Jh4K0T3MwDm6L13Xv3s=
X-Google-Smtp-Source: ABdhPJygjIcnYpUV6FoudJbfOAcHWBw3nLyQASnlw+TLtXBpe1VThNZDrJJpSkfREO7whzLD3qZ+zg==
X-Received: by 2002:adf:9385:: with SMTP id 5mr20250426wrp.53.1622559518708;
        Tue, 01 Jun 2021 07:58:38 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n6sm17616861wmq.34.2021.06.01.07.58.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 07:58:38 -0700 (PDT)
Message-Id: <38713ed482736af8d1dea4d180651fd919837109.1622559516.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.962.v2.git.1622559516.gitgitgadget@gmail.com>
References: <pull.962.git.1622104642.gitgitgadget@gmail.com>
        <pull.962.v2.git.1622559516.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 01 Jun 2021 14:58:32 +0000
Subject: [PATCH v2 2/5] diffcore-rename: avoid unnecessary strdup'ing in
 break_idx
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

The keys of break_idx are strings from the diff_filepairs of
diff_queued_diff.  break_idx is only used in location_rename_dst(), and
that usage is always before any free'ing of the pairs (and thus the
strings in the pairs).  As such, there is no need to strdup these keys;
we can just reuse the existing strings as-is.

The merge logic doesn't make use of break detection, so this does not
affect the performance of any of my testcases.  It was just a minor
unrelated optimization noted in passing while looking at the code.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 diffcore-rename.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/diffcore-rename.c b/diffcore-rename.c
index 3375e24659ea..e333a6d64791 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -54,7 +54,7 @@ static void register_rename_src(struct diff_filepair *p)
 	if (p->broken_pair) {
 		if (!break_idx) {
 			break_idx = xmalloc(sizeof(*break_idx));
-			strintmap_init(break_idx, -1);
+			strintmap_init_with_options(break_idx, -1, NULL, 0);
 		}
 		strintmap_set(break_idx, p->one->path, rename_dst_nr);
 	}
-- 
gitgitgadget

