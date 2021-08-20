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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60929C4338F
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 15:40:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4309F60BD3
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 15:40:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241096AbhHTPlU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Aug 2021 11:41:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240952AbhHTPlT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Aug 2021 11:41:19 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CBECC061575
        for <git@vger.kernel.org>; Fri, 20 Aug 2021 08:40:41 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id q6so14876294wrv.6
        for <git@vger.kernel.org>; Fri, 20 Aug 2021 08:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=+A3gZXGEbgtLzQqFblnGbe250SZfMQZCNMCQ88TiVTg=;
        b=hOFvO+UPDTTv1/hToRyMekP5o6r6uZzk0AnwJ2Ot4hArYPexG+2+lEGl55A2f3tUTi
         d3UvTibYX5XIK6MBAdslF6fTFnUPUkrJcYTgTaxmRrPwTbs/+m8OQPJi5x2oj4w1eGIY
         E+VPqdQzHaKjFKLqx2ilEHCTuwbddnuWcYPB32ZjmBcjSzfx3T5vk3QTEEOkV8vss6TA
         wCxAgcTgJHEhZGsJ35Ru9hu5/1cSMBzW+72SyI3vGRu3kWCKFzVUmx6eByq2y7LszLfg
         cxMe2AAB04tbCgGAjSPLtWNaDZR5pouRJyKs6XDnd2ivhZBhNGnbwDNSavJscs1uDGXc
         9dVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=+A3gZXGEbgtLzQqFblnGbe250SZfMQZCNMCQ88TiVTg=;
        b=eIagupBtLG6zIGoPUDZQQN5RSYloVo9lBcwCBFdgG+AV4sPKz6JvKYXqhKzlGtO4uU
         vk4ntvi9iJRCtEotfd9VN/TmwTdSduio5LmDJHi1Jb6vTNLSorKEbvdEMvsO64MEBM/O
         HEOH+QN4/qV2nPuPFytB4Hr9Y1GO5I10f4baSsOHykwE+bMxeJ1j++S5YRm6MGwuGiXx
         wHP3OziMVlOTxgd5wBxOyLr9cGcAvUpV7NaAnKWN2VgS5TnZz/mmx/ZDj4CdTbqmGmw8
         n4/reDa3n8wfNRdOKNPTXc4cncCSedetcj9O5sMNJSP4j5FZPadoq7IJdRwOvFDOairA
         qdQA==
X-Gm-Message-State: AOAM533N10NGaEI4GCqQ+AEK3JlEEy3vi1zck6vhNgk9TQ2ssIBFmv4U
        rgz0ykgiUmFrb8680jNOC0u71Gq9wBk=
X-Google-Smtp-Source: ABdhPJwKt6pEDLIG2o1mZJOyhfqR9iSOaEd88XDEk+UojzhNpbJveLVkALaQUihYUjjAKsXJUy3zYQ==
X-Received: by 2002:a5d:4586:: with SMTP id p6mr11001401wrq.55.1629474040002;
        Fri, 20 Aug 2021 08:40:40 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b10sm2291672wrt.43.2021.08.20.08.40.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Aug 2021 08:40:39 -0700 (PDT)
Message-Id: <pull.1015.v2.git.1629474038.gitgitgadget@gmail.com>
In-Reply-To: <pull.1015.git.1628860053.gitgitgadget@gmail.com>
References: <pull.1015.git.1628860053.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 20 Aug 2021 15:40:34 +0000
Subject: [PATCH v2 0/4] rebase -r: some merge related fixes
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for the feedback on V1. I have added a sentence to the commit message
of the third patch to make it clear that the fast-forward code is just
moved, not changed

Cover letter from V1: This is a collection of merge related fixes for rebase
-r

 * Make merge -c behave like reword.
 * When fast-forwarding a merge don't leave .git/MERGE_MSG around (reported
   by Gábor)
 * Make merge -c work when with --strategy

Phillip Wood (4):
  rebase -r: make 'merge -c' behave like reword
  rebase -i: Add another reword test
  rebase -r: don't write .git/MERGE_MSG when fast-forwarding
  rebase -r: fix merge -c with a merge strategy

 sequencer.c                   | 106 ++++++++++++++++++----------------
 t/lib-rebase.sh               |  56 ++++++++++++++++++
 t/t3404-rebase-interactive.sh |  13 +++++
 t/t3430-rebase-merges.sh      |  38 +++++++++---
 4 files changed, 155 insertions(+), 58 deletions(-)


base-commit: 66262451ec94d30ac4b80eb3123549cf7a788afd
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1015%2Fphillipwood%2Fwip%2Fsequencer-merge-c-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1015/phillipwood/wip/sequencer-merge-c-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1015

Range-diff vs v1:

 1:  b514dbdf928 = 1:  b514dbdf928 rebase -r: make 'merge -c' behave like reword
 2:  511cf9204ad = 2:  511cf9204ad rebase -i: Add another reword test
 3:  01d5ed4cba0 ! 3:  080e580e11c rebase -r: don't write .git/MERGE_MSG when fast-forwarding
     @@ Commit message
          is not removed and can end up seeding the message of a commit made
          after the rebase has finished. Avoid writing .git/MERGE_MSG when we
          are fast-forwarding by writing the file after the fast-forward
     -    checks.
     +    checks. Note that there are no changes to the fast-forward code, it is
     +    simply moved.
      
          Note that the way this change is implemented means we no longer write
          the author script when fast-forwarding either. I believe this is safe
 4:  f2a2e3531a1 = 4:  b6981ea5439 rebase -r: fix merge -c with a merge strategy

-- 
gitgitgadget
