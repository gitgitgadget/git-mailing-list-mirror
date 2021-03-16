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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36BCCC4332E
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 21:18:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14ABE64F94
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 21:18:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232996AbhCPVSB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Mar 2021 17:18:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233158AbhCPVRW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Mar 2021 17:17:22 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A43FC06174A
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 14:17:22 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id w203-20020a1c49d40000b029010c706d0642so4487224wma.0
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 14:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=F2gqO0l9O9MrKBoUmYo1FuGCXsHs4lBM//hToPyCl/8=;
        b=uq0hfo9pY8so8blZ4IuPRA4EQdpFX6v7KvxJxtjy01Huw+nYlsrS3WOHU9ns1VWAq/
         Ub2OyRHKZI6gRT1RgJZl+bLK+///MvvCxq6uDX265aEpFmMefhrZ+CQbLSmleGJyIxOb
         9NtijcY3HEmvJ1T/C4YCMcU+Z9WukKtpEKY9lAp3+3g7RKOPqC+I9pnu0N/h+7lmKarZ
         NZ+P5q9X4lrSuUiEP9M5/uFsUv1LGPi4GYg9nfjAnHB2azUXnDEkEyv9n+8qrcOOAHO8
         8t4Tvc9Q+nDQKbbldJF2C8lNyQoxOD+aPWtva4cgPulKQz0l9BIxlTDOsIEAipd9ziyj
         3GUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=F2gqO0l9O9MrKBoUmYo1FuGCXsHs4lBM//hToPyCl/8=;
        b=EEx6l+oKgo893MCzFWvtwwdq04UrZDONAP7DpVA6qSxnMaImEmjQJWX9miK+Y1TcEF
         zVwQh+puWQJ/AgZ0b30yHv3uwzs6lKehKRjbsZjb5DiZz7SRxpiyYdGSPGuwcxsVsmJr
         a1I5XLkQI7YPMNwq3P1eyL1QO8WfKbMosQ1XDErZx5wLikMtIupdIeJO7B5n5B6uJSgf
         X8UEow3tWKtU+asxdaDrLjaeMhlLtsn/O6egCryHrYIJ0+8SicrJiLUIux398REEWisM
         1whETc0lBbTvXs+JfeOmn3Vs6C1vNqJqdw7GS2VMCab6rF3wHjg5kEHfpfvP52tPtqtw
         Mxcg==
X-Gm-Message-State: AOAM532/+oHrf8haWDmX9dPwj9YSuHyCg//6N/xoUuHoMEuKBsrsbJq9
        kkaKqoBvRMTRt6AZm6E7BzhdS2ISKQg=
X-Google-Smtp-Source: ABdhPJyPfz35i7AulvOYsEQgCtNYov5tLBKCId4zM0EluHnbsAx4opbkRMcNpdXSG9ENNluDhld2WA==
X-Received: by 2002:a1c:e341:: with SMTP id a62mr696197wmh.152.1615929441146;
        Tue, 16 Mar 2021 14:17:21 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i11sm22992998wro.53.2021.03.16.14.17.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 14:17:20 -0700 (PDT)
Message-Id: <142df1ab8e3e8ea5e213f2477e271e60e5b62f84.1615929436.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.906.git.1615929435.gitgitgadget@gmail.com>
References: <pull.906.git.1615929435.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 16 Mar 2021 21:16:53 +0000
Subject: [PATCH 05/27] add: ensure full index
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, gitster@pobox.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Before iterating over all cache entries, ensure that a sparse index is
expanded to a full index to avoid unexpected behavior.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/add.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/builtin/add.c b/builtin/add.c
index ea762a41e3a2..ab2ef4a63530 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -141,6 +141,7 @@ static int renormalize_tracked_files(const struct pathspec *pathspec, int flags)
 {
 	int i, retval = 0;
 
+	ensure_full_index(&the_index);
 	for (i = 0; i < active_nr; i++) {
 		struct cache_entry *ce = active_cache[i];
 
-- 
gitgitgadget

