Return-Path: <SRS0=R7wA=DM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30CBDC4727D
	for <git@archiver.kernel.org>; Mon,  5 Oct 2020 08:56:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEAF22078E
	for <git@archiver.kernel.org>; Mon,  5 Oct 2020 08:56:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KMZKV9zq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726053AbgJEI4k (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Oct 2020 04:56:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725891AbgJEI4j (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Oct 2020 04:56:39 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43D84C0613CE
        for <git@vger.kernel.org>; Mon,  5 Oct 2020 01:56:39 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id e2so7922239wme.1
        for <git@vger.kernel.org>; Mon, 05 Oct 2020 01:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=qMmLOf2d+BsEjkY9eiQQ0ZOp58Ty4eBZoBduknAfbU8=;
        b=KMZKV9zqIitXjspGkbjSpMahwHHe9oihAJ7Njeo5M8lhMuWjGMzciB73BCutRG3uIY
         8PNYzR6luUETBxD727DABQu0d50hvqQtgvugL0q/RB5mitcH0ncawqSgisCjWK7i5wiW
         I4NNcaxTPehxbjVKjGCdNNdEn1F1CVWbNl0nX8kjHolZlKzf4p+0DBdj6JnXY38AEVJX
         DNQQUu3jGsgttlUcK6pMl+pHA/Y52hTX0+IjAWlGGcPXnVsGbDL6jou8ilEWx6G/UZKs
         j7h96uw2zf0PgIjIJHw9w0bcxgMAusltV7qJIu2VZLWJEP+oTwZE7c5aWjjp3Xy0EQfv
         xc0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=qMmLOf2d+BsEjkY9eiQQ0ZOp58Ty4eBZoBduknAfbU8=;
        b=bK4ASdvBMknt3Orv2cztVdZa1ojmdg6vZ2RGknocnR9rH7yeL040vTpk4TnGtOzqwS
         KGrfyVnKSfscWx65qokrONqq299DZV3eWu0wu1ESfknEYlCTAaO5rbq7qwal2/zBJfo/
         6nRPFllk2ZGpnMWnq5T3pfH3rJ6oKC5DnPBS22wcYAHH0MgkNnFx0+s4RJVBj/D+Q1iB
         1akkVtTmIz2iK4b8MpreJQIQUVNsPt7foRs2fN4tIMexORlksswwXracGPeDhF/SFcXa
         2kj6EvU9NvGvP5+HaH2hsfoznGW17G3YrEE0p+gOmz+x3pPP79UGEisc9uJOQzYGCATL
         68Yw==
X-Gm-Message-State: AOAM533ISRToVE6LwzTt9scW12RSH3SXXplxdLbGhkC9xlxa/bLrzKMf
        8EmQCeAiE2o6f2/BaHFK0myC2iXlD6w=
X-Google-Smtp-Source: ABdhPJy1Sc3E7AyNS3foOIHLhJCo4Tp8hgudjUlJHBWtOwBhMpkdxtYCZEfeJjtd8UULyKSvH6tY/A==
X-Received: by 2002:a05:600c:215:: with SMTP id 21mr15668567wmi.105.1601888197755;
        Mon, 05 Oct 2020 01:56:37 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a17sm5409288wra.29.2020.10.05.01.56.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2020 01:56:37 -0700 (PDT)
Message-Id: <pull.743.git.1601888196.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 05 Oct 2020 08:56:34 +0000
Subject: [PATCH 0/2] Avoid main as branch name in the test suite
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In preparation for changing the default branch name to main, let's stop
using it as non-default branch name in the test suite.

This is the last preparatory step before the patch series that intends to
change the default branch name to main. See 
https://github.com/gitgitgadget/git/pull/655 for the entire game plan.

Johannes Schindelin (2):
  t1415: avoid using `main` as ref name
  tests: avoid using the branch name `main`

 t/t1415-worktree-refs.sh     | 18 +++++++++---------
 t/t6012-rev-list-simplify.sh |  8 ++++----
 t/t6400-merge-df.sh          |  8 ++++----
 t/t6409-merge-subtree.sh     | 12 ++++++------
 t/t6430-merge-recursive.sh   |  4 ++--
 5 files changed, 25 insertions(+), 25 deletions(-)


base-commit: 306ee63a703ad67c54ba1209dc11dd9ea500dc1f
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-743%2Fdscho%2Favoid-main-as-branch-name-in-tests-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-743/dscho/avoid-main-as-branch-name-in-tests-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/743
-- 
gitgitgadget
