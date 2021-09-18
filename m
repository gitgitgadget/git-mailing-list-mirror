Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D1AAC433EF
	for <git@archiver.kernel.org>; Sat, 18 Sep 2021 13:49:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD24361041
	for <git@archiver.kernel.org>; Sat, 18 Sep 2021 13:49:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237601AbhIRNvF (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Sep 2021 09:51:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbhIRNvE (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Sep 2021 09:51:04 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDABCC061574
        for <git@vger.kernel.org>; Sat, 18 Sep 2021 06:49:40 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id t8so19923857wrq.4
        for <git@vger.kernel.org>; Sat, 18 Sep 2021 06:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=ZcpJffXDEd594mDTAIi+lQoZW0qqYFgww1X2mLRJXX0=;
        b=OmkZWwQ2u6thV45lPVjYXpKugY8L6CiPXZl+HnP+rObPOMQYXBg9zRck2/iYmCe+C4
         AOsSBqi5Os7MbosAFwGtyKKhbSLKbUeiKsdzItstnwR9qk6YTgissDounX4ReQLTXakl
         fWCQU3QLmkO9H5O2sdc2JDFivzkzlvLNA7Jr10JuIpjFbXz+9wdKi0oJo1epjZZ2TX1U
         xk6AAgvjpOu09mY0qHXWUmeRDMhe9VPu06dHYn0gxwUQz+W9TG6l+5ljnCoMGpZf4aPW
         PRFsQi+j4oYAyKO+K5EyZK7Sw9Dtlisx3IL4RU6X4STL7T04sUgXZQ+OHuoNZn21JPfv
         LRFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ZcpJffXDEd594mDTAIi+lQoZW0qqYFgww1X2mLRJXX0=;
        b=Xxk3Q5uT5Snr4oJqoemJ4qpxTawlWo7X8ouJNoUhZUkaMDLbNokoWfajwLoTur9KPm
         /7pP1tVP+UXtxqd3+FAcAscz11AhJENeevrNBcFNL4qIa8JUIDibZajvjQHN7fVghKHk
         gX6G2OeW0Z8wW4z9ElBfAjSS0t6F4EaUnJapsaoAUNNHauMQjFlNp6zBUJJB6kwXFhlh
         D9yFrBEGQsOLMsvbviPH7rmxKh/KUZNbk6erKjFM8uw7vH8l5H4Bt/cZgDI1zJlSqOYN
         mh2xVm+3CzxQA2rq9yU9vBDbDG32OIhxFDdMnx5v4SJKChdXkqL32VU6n41PKL/g3Awn
         GMpQ==
X-Gm-Message-State: AOAM531NQCjLxcmLDMu4GnLbMOyiGMM7bq5nXESSvLsAq1pVaVNRZYu/
        rUdVxoksncNDjeV5ZohoROvZt49r8t0=
X-Google-Smtp-Source: ABdhPJz/iLP3eQiN7PEnPtQMBej/6XWvFbCbhcLtp+7tG0O8pbXUj9dqqqujqJ0mXJntY/9cZEgJtw==
X-Received: by 2002:adf:d1b2:: with SMTP id w18mr18464324wrc.6.1631972979472;
        Sat, 18 Sep 2021 06:49:39 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o1sm9712120wru.91.2021.09.18.06.49.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Sep 2021 06:49:39 -0700 (PDT)
Message-Id: <pull.1092.git.git.1631972978.gitgitgadget@gmail.com>
From:   "Andrzej Hunt via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 18 Sep 2021 13:49:36 +0000
Subject: [PATCH 0/2] Squash leaks in t0000
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Carlo Arenas <carenas@gmail.com>, Andrzej Hunt <andrzej@ahunt.org>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo points out that t0000 currently doesn't pass with leak-checking
enabled in:
https://public-inbox.org/git/CAPUEsphMUNYRACmK-nksotP1RrMn09mNGFdEHLLuNEWH4AcU7Q@mail.gmail.com/T/#m7e40220195d98aee4be7e8593d30094b88a6ee71

Here's a series that I've sat on for a while, which adds some UNLEAK's to
"fix" this situation - see the individual patches for a justification of why
an UNLEAK seems appropriate.

ATB, Andrzej

Andrzej Hunt (2):
  log: UNLEAK rev to silence a large number of leaks
  log: UNLEAK original pending objects

 builtin/log.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)


base-commit: 186eaaae567db501179c0af0bf89b34cbea02c26
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1092%2Fahunt%2Fleaks-t0000-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1092/ahunt/leaks-t0000-v1
Pull-Request: https://github.com/git/git/pull/1092
-- 
gitgitgadget
