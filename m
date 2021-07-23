Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B6B9C4338F
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 12:14:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CC3260EB4
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 12:14:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234730AbhGWLeA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Jul 2021 07:34:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234670AbhGWLd7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jul 2021 07:33:59 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36B94C061575
        for <git@vger.kernel.org>; Fri, 23 Jul 2021 05:14:33 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id o5-20020a1c4d050000b02901fc3a62af78so3372764wmh.3
        for <git@vger.kernel.org>; Fri, 23 Jul 2021 05:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=pSF7sbGGclKwgbNokW7NoFk5dxSvssYafDvM+8nwsPU=;
        b=Bf9SyH5ICCZo8fxEsrEt8JSv8UZ4XAJ5OMgj3PAvuFwDAKpiZpqeC7bh9OgZuo8hXE
         ZNDqj/wwuhx1lyy3BFFQh4islpi2+7cvT4pTx8b/UwaBnZlwKHhyr3nyGjCBROSfFjwX
         C7MJ9S0r4UX+YwqU6h9SdEcSSGC9vu1EM6D/PRjzHCPriAassLL7j41Fd43rf8wEB9Yx
         l6PpOt8pGl8Au7CqvGjao2b9BqnXDyNHd49TSKdmjA0lzG56ceGMxGhTh4yeZp3aDKNV
         LcQkYqq/7Yx9/lU0mUdoqDckEe50vrMlKQDMP9o0Bo6boCyaxhxJIAr6PJzujgnwXTWa
         xAzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=pSF7sbGGclKwgbNokW7NoFk5dxSvssYafDvM+8nwsPU=;
        b=Q9UgxcsVqUzfN4zFAIInfYdWE9Zbly1bThTKoMEJQr8Cg/Ccz4ylr+o3TN16s3AxQS
         aooZaQwiYwbv8IUJfeLTwjm1iUiU1BAanAXKm6RmvlSKvAOXMMBLykyQCJHZrIkVoI0U
         B42Xr5Bth1P+XDaJm5KNfYuzF6psc3+H4jHME7SbTZT8kUxdkBiB9E9az7HjIHsH5E91
         A1MIvxF9d+MQ6AKlfBScN4uh4Lu5P4InmgAMdgvb/paNGmoHryAJYG5NkuUYnl8oyeKa
         TmDf9rik3Li5Ki7J6UHke6YipCelpjduVZpH+90UNnAlJ3F0JgoMSx08ef8Gq8lHskRG
         0vMw==
X-Gm-Message-State: AOAM530zbqeURiiic1ZOKQXWV5zr8VOZlvREWRa3tE+hnrHZOqEZcBAj
        AK/YOjP5/Icf7HbHnSXwYAK5SVh3gT0=
X-Google-Smtp-Source: ABdhPJzlNreL5G2qjc8wrIRg9YedRpBIZSaVtI8GpVI2lrI6fvT6xga69gWO0ZazdvK2gGBxyV/G3w==
X-Received: by 2002:a05:600c:2319:: with SMTP id 25mr13708092wmo.91.1627042471817;
        Fri, 23 Jul 2021 05:14:31 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a9sm32698707wrv.37.2021.07.23.05.14.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jul 2021 05:14:31 -0700 (PDT)
Message-Id: <pull.1002.git.1627042470.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 23 Jul 2021 12:14:26 +0000
Subject: [PATCH 0/4] [RFC] merge --autostash: apply autostash in more cases
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Denton Liu <liu.denton@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series aims to apply the stash created by 'git merge --autostash' in 2
situations that were not covered by the code:

 1. If the merge is fast-forward but the fast-forward operation fails -
    PATCH 3/4
 2. If the merge strategy completely fails to handle the merge (exit code 2)
    - PATCH 4/4

The first 2 commits are small improvements that I noticed while implementing
the other two.

I'm marking it [RFC] because I'm not 100% sure that trying to apply the
autostash in 3/4 and 4/4 is actually the best course of action (or if it
would be better to call 'save_autostash' instead). That's because:

For 3/4 (fast-forward fails): I'm not sure if 'unpack_trees' (called by
'checkout_fast_forward') is guaranteed to fail atomically, or it might fail
mid-way and leave the worktree unclean, in which case it might be better not
to apply the autostash, but just save it instead (and tell the user). In the
test case I'm adding, it does fail before starting to update the working
tree, but I'm not sure if it's always the case.

For 4/4 (merge strategy fails): Same reasoning: I'm not sure if all
strategies (and even less user-supplied ones, which are not documented but
kind of supported) are guaranteed to 'exit 2' before messing up the working
tree.

Philippe Blain (4):
  merge: add missing word "strategy" to a message
  Documentation: define 'MERGE_AUTOSTASH'
  merge: apply autostash if fast-forward fails
  merge: apply autostash if merge strategy fails

 Documentation/merge-options.txt |  3 ++-
 builtin/merge.c                 |  4 +++-
 t/t7600-merge.sh                | 19 +++++++++++++++++++
 3 files changed, 24 insertions(+), 2 deletions(-)


base-commit: d486ca60a51c9cb1fe068803c3f540724e95e83a
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1002%2Fphil-blain%2Fmerge-autostash-ff-fails-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1002/phil-blain/merge-autostash-ff-fails-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1002
-- 
gitgitgadget
