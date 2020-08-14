Return-Path: <SRS0=xyTh=BY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 272A0C433E1
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 03:02:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFD5E20716
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 03:02:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZJMp68tv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbgHNDCS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Aug 2020 23:02:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbgHNDCS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Aug 2020 23:02:18 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F024C061757
        for <git@vger.kernel.org>; Thu, 13 Aug 2020 20:02:18 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id qc22so8410006ejb.4
        for <git@vger.kernel.org>; Thu, 13 Aug 2020 20:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=6ne5BS1kuhSoJtWA1xKgCvNskSFBZsY/tWrTtr5/fds=;
        b=ZJMp68tvKejGGFmBbwnLhlYoNv0vw2FlwwDk/qvtyiZ3NYYXEAM49q3hLvGVU1H27k
         fAnlI3usrNaJWdpFO17mSTPLT1HrolbXLsbrNXo2/p4kMqSx074hpyymrqn96GO6OJSN
         oJ3r2BsNH3F1phSNo/txlViyyLi5p8bH8lVtigPurBpEqUMxjPH51WUOPKsco9kX4YO7
         FEiZ9AZKORdKWJj4zh3pillPzLYxJ+UXtp5DgjjhpaJrEgLmeFcGsGEau4EnujddAWSn
         LdPhK2o3XNtlkikl8Vuk8tWHQ3MejppuUCOM6l7ErQYpPDPQf7GHjqca41w5sGg2znVw
         sofw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=6ne5BS1kuhSoJtWA1xKgCvNskSFBZsY/tWrTtr5/fds=;
        b=GOn6Eplegx7fSLP3ostnlyIDhK8FmmdrsE45Q084JoePmnGeaLPPkl3c5ebBTckGob
         CqFUbDjIpeqWn729uoxmkEVih+CKb0hUHcuo5QbhdqoykGLJxZ8QSJpb9/Xn92pZyncV
         sEJcQvlGQzZV+7pfL5g0TXgiPDmAKdeCwk6vp8yY58sfDu/btvr29KwFqjeNKWAdEZo8
         lnfNJJZu5+vXOX57y/GFVgahghcxL44cTLlO8rGRA8EZjVzXsDr/WK74U249e0+I/SLq
         gD48S9mUqP9BrM2sFdKSowm9Q60+a1Y0U8W3lHmFzGc3FnuWQADGENke7WHhCuNsC5pa
         wGtQ==
X-Gm-Message-State: AOAM5329YCkjkiyXgF91xscfnXNn+xwp2pPtdxOd0mXRsgscWNMyIZL5
        byEsYtL6pFoibi9hl5BFgQFSxWEV
X-Google-Smtp-Source: ABdhPJyCwlI1u18Bics0weJw+rJMpcrQiHGbb9djywBHzi2Nd8vdh8qyiRA3NJGQnmj2x5+iGQpC3Q==
X-Received: by 2002:a17:906:5452:: with SMTP id d18mr485697ejp.163.1597374136942;
        Thu, 13 Aug 2020 20:02:16 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a11sm5667997ejk.77.2020.08.13.20.02.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2020 20:02:16 -0700 (PDT)
Message-Id: <pull.830.git.git.1597374135.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 14 Aug 2020 03:02:12 +0000
Subject: [PATCH 0/3] Extend and add a little more generalization to the mem_pool API
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Matheus Tavares <matheus.bernardino@usp.br>,
        Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In my new merge algorithm, I made use of the mem_pool API in a few
places...but I also needed to add a few more functions. More importantly,
though, I couldn't reuse the existing API as-is since I want to be able to
discard the memory (after each recursive merge) and then continue adding to
the pool, something the existing API was not amenable to. Instead of writing
another competing API, since there is only one other user, I just modified
the existing callsites to use the more generic calling structure that I
needed.

Unfortunately, Matheus' parallel-checkout RFC series (not yet in next or
seen as far as I can tell) adds a few more mem_pool callers, so this series
conflicts with his (semantically). I can rebuild mine on top of his, or,
since his is longer and would probably advance more slowly, it may make
sense to have his series be based on this one. If so, I'm happy to help him
update his to depend on this series. Let me know preferences.

Elijah Newren (3):
  mem-pool: add convenience functions for xstrdup and xstrndup
  mem-pool: use more standard initialization and finalization
  mem-pool: use consistent pool variable name

 fast-import.c | 12 ++-------
 mem-pool.c    | 75 ++++++++++++++++++++++++++++++++-------------------
 mem-pool.h    | 14 +++++++---
 read-cache.c  | 21 +++++++++------
 split-index.c |  6 +++--
 5 files changed, 76 insertions(+), 52 deletions(-)


base-commit: 7814e8a05a59c0cf5fb186661d1551c75d1299b5
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-830%2Fnewren%2Fmem_pool_api-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-830/newren/mem_pool_api-v1
Pull-Request: https://github.com/git/git/pull/830
-- 
gitgitgadget
