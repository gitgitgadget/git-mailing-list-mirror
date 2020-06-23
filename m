Return-Path: <SRS0=IiYM=AE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40252C433DF
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 15:04:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B7BA20723
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 15:04:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VbIEvgO5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732991AbgFWPET (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Jun 2020 11:04:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732862AbgFWPES (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jun 2020 11:04:18 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46792C061573
        for <git@vger.kernel.org>; Tue, 23 Jun 2020 08:04:18 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id 17so3593611wmo.1
        for <git@vger.kernel.org>; Tue, 23 Jun 2020 08:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=yHW8OSMhFONcOKkpQb0sfVTs8W6Tkdh6TVDIOjtgAlc=;
        b=VbIEvgO5LSWflvNkivQ1MG6XmXDpcb7JarZ9jngj7Dah94qMalAIfeZPRd2Ztrtrng
         CbVyxMqjFyEgJw9RfdcNuIazrqpmzooCW8CnVj6QBWF0aTjqqRzVFRyibXLMdN0euV0b
         Bh6KwtUuoJhaJgIP+/Mzlcdg3mH7Ob4pDGeGBopzJJa4ISS3TPoEz5Y5RRQoc2ESbGMP
         +XT9lS2oREYPJpiJ+5RFLYCoB4eulyXOrW5Fx/GryFTRXQ8hCjuoQsN8e1/xHmxZ7H3H
         E77iI8WNwQDGqZm8caNdWKjOyPM7wZARH2jkm6UMIps0hbqT4rcb//s709ulXAohZL2E
         bqfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=yHW8OSMhFONcOKkpQb0sfVTs8W6Tkdh6TVDIOjtgAlc=;
        b=FUuTQtFdIIyMXXtGiVjrCkKKlyP0CIG4JM4aRSnaA7sR3hoC24JznGGIX/Qo+x3wNg
         hkNLOlEeAWC/dwEqJrChLZyKjwFwOwOa1N/v40XzKEtXNJLWZh3K4WAWoFvrwJZK9YWv
         nLQ+083eHeMjRjoS1gm1ayoI94c0MM3rEJ5ymqISK5z6d2qPlpw9bCb9pSer8iUKYEOO
         vLKcKXXD5fmr6uiQOutG9hUvXGSxYB4EC48IoB2obCCTGJAgZL4sy31tXBiQ+Z0wujrp
         6mOMPCi8OVoIcHCQ0SChtsB2p6aiSBoXQP1PrwSfZtSf6TX3cDZ7pcJgq6Ki9Bw2r66W
         jyuQ==
X-Gm-Message-State: AOAM531MijBUKdWsEFkYsyuqBgnmmzPrqt3sBo7sNVEID89sqnZ/pALQ
        B1gCsOxsbDZ30nSyQGBl46fu6Wau
X-Google-Smtp-Source: ABdhPJx9Lg6F7QZe24RkkQc+VNJ7x/nP+BUuxO1oOI5uO+/tx3Qpzj7mGIRRlF32SE+9t8AkAi3K8w==
X-Received: by 2002:a1c:b6c3:: with SMTP id g186mr8642620wmf.135.1592924656882;
        Tue, 23 Jun 2020 08:04:16 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q188sm464333wma.46.2020.06.23.08.04.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 08:04:16 -0700 (PDT)
Message-Id: <pull.668.git.1592924655.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 23 Jun 2020 15:04:12 +0000
Subject: [PATCH 0/3] Accommodate for pu having been renamed to seen
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series adjusts Git's own source code to reflect that change.

Please note that even with these patches, there are still a couple places
where pu is used:

 * In the translations. These are legitimate words in languages that are not
   English (as in "gpg n'a pas pu signer les données" where "pu" is French
   for the English "could").
 * In upload-pack.c, where a variable named pu is short form for
   "pack-objects updates".

Johannes Schindelin (3):
  docs: adjust for the recent rename of `pu` to `seen`
  docs: adjust the technical overview for the rename `pu` -> `seen`
  tests: reference `seen` wherever `pu` was referenced

 Documentation/MyFirstContribution.txt         |  4 +-
 Documentation/SubmittingPatches               | 10 ++--
 Documentation/git-fetch.txt                   |  8 +--
 Documentation/git-ls-remote.txt               |  4 +-
 Documentation/giteveryday.txt                 | 10 ++--
 Documentation/gitworkflows.txt                | 16 +++---
 Documentation/howto/maintain-git.txt          | 52 +++++++++----------
 .../howto/rebase-from-internal-branch.txt     | 32 ++++++------
 Documentation/howto/revert-branch-rebase.txt  | 32 ++++++------
 Documentation/howto/update-hook-example.txt   |  6 +--
 Documentation/user-manual.txt                 |  2 +-
 t/t5505-remote.sh                             |  8 +--
 t/t5516-fetch-push.sh                         | 16 +++---
 t/t9902-completion.sh                         |  4 +-
 14 files changed, 102 insertions(+), 102 deletions(-)


base-commit: 5c2bcdf952448837f110308efeea592e47ad0143
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-668%2Fdscho%2Faccommodate-for-pu-having-been-renamed-to-seen-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-668/dscho/accommodate-for-pu-having-been-renamed-to-seen-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/668
-- 
gitgitgadget
