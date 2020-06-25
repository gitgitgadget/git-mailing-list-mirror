Return-Path: <SRS0=4a08=AG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C44BBC433DF
	for <git@archiver.kernel.org>; Thu, 25 Jun 2020 12:19:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E5FF20707
	for <git@archiver.kernel.org>; Thu, 25 Jun 2020 12:19:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FJhPY4HV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404641AbgFYMTD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Jun 2020 08:19:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404343AbgFYMTC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jun 2020 08:19:02 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5943DC061573
        for <git@vger.kernel.org>; Thu, 25 Jun 2020 05:19:02 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id t194so5695186wmt.4
        for <git@vger.kernel.org>; Thu, 25 Jun 2020 05:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=MFeXwMggMANRpAi97SZ47hBi2ET2RT3S4E1mYo3qrK8=;
        b=FJhPY4HV67TjZsu9TijJGuQ/VNN+Cdb8POqkDdn2N5fDxSdPU1xMtRH0eXH0bhbIOm
         JaCNqqQ1QzHPbzrkAWJO0txGEWdOy4q8JVLgxXGOqOnEJLy8C+eOPHR5QNnHi8mJRY5l
         fkYYcnRdHQbuRTh6XeNduCQhBxkWUZ2orz9VLTamHEw3MmldC6S8+bvjtEIWfUlKiWMZ
         SbgAJwgQjovTPEEnVxTTCEzStNYnosnd2/nSCJRCWkD9aPy/hy0XzK4MviSzWKFDcDHp
         w0JG7FBBaiWuv5z6QwxTxUMntaFU1Rx4uaFmWEVbV1zoI+S6etzO8QafWXKJKaAKKGa3
         O+SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=MFeXwMggMANRpAi97SZ47hBi2ET2RT3S4E1mYo3qrK8=;
        b=nKTYu8+3eUOaKc0JSGPpRI32plhykw/QNB4IkrZauj3YbNCFfxJyu6I49gUu0oWqqQ
         FgGhw0iIJKeC2t100qVWGPYe6SsMVpmlpFi4IHTVT3yOZz5B3OzXwju/+dviS82YlOyM
         DuFKGMzsAqwWRzeMCxGxXy4CA983OLJJulzrLcK+rowq5heG4byTnt1E5ScjD/avFc59
         dVvKcKrnKi//l9ry+JWnDt2r2cjRQjz40yoXsaZfiub1eY3haXddd0YW9Ts4EclqGbN5
         xbVavHhJSx6L4MsjtSKi5K4fVAjaIwBOyRu3Z3KBDKE0ffgWXRpPVL0Iq0/dsIjaybA0
         XapA==
X-Gm-Message-State: AOAM533yJOFW7d6LKKtIroRraFs3VM/oYg1pAbh4pG3tFiOZ/8gljGhy
        H4lFtew1HmUa/w/aqYGFg+osL7bY
X-Google-Smtp-Source: ABdhPJwrLD8mt5xvaeR+EshCnRQ6RnbOKicqgsR62pR3OxkavcMQfvvpwOHcrxg4MSH/pFyeIy/grg==
X-Received: by 2002:a1c:99c5:: with SMTP id b188mr2965243wme.76.1593087540894;
        Thu, 25 Jun 2020 05:19:00 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w17sm32434407wra.42.2020.06.25.05.19.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 05:19:00 -0700 (PDT)
Message-Id: <pull.668.v3.git.1593087539.gitgitgadget@gmail.com>
In-Reply-To: <pull.668.v2.git.1593010120.gitgitgadget@gmail.com>
References: <pull.668.v2.git.1593010120.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 25 Jun 2020 12:18:56 +0000
Subject: [PATCH v3 0/3] Accommodate for pu having been renamed to seen
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Denton Liu <liu.denton@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
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

Changes since v2:

 * One accidental quoting change in v1 was reverted.
   
   
 * Rebased onto maint (no merge conflicts, so it does not actually change
   anything).
   
   

Changes since v1:

 * Rebased onto master (no conflicts, so it is safe, and it is more robust
   than basing the patches on seen which already contains v1 of these
   patches).
   
   
 * Adjusted the quoting to match 
   https://lore.kernel.org/git/e250f1bb100aca94c914f1b2d38a3849c2566aea.1592909867.git.liu.denton@gmail.com/
   .

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


base-commit: af6b65d45ef179ed52087e80cb089f6b2349f4ec
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-668%2Fdscho%2Faccommodate-for-pu-having-been-renamed-to-seen-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-668/dscho/accommodate-for-pu-having-been-renamed-to-seen-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/668

Range-diff vs v2:

 1:  35e3dafd6a ! 1:  13e03e0e65 docs: adjust for the recent rename of `pu` to `seen`
     @@ Documentation/gitworkflows.txt: As a given feature goes from experimental to sta
      -* 'pu' (proposed updates) is an integration branch for things that are
      -  not quite ready for inclusion yet (see "Integration Branches"
      -  below).
     -+* `seen` (patches seen by the maintainer) is an integration branch for
     ++* 'seen' (patches seen by the maintainer) is an integration branch for
      +  things that are not quite ready for inclusion yet (see "Integration
      +  Branches" below).
       
 2:  c2bcfdcb5b = 2:  13f3501c84 docs: adjust the technical overview for the rename `pu` -> `seen`
 3:  c8e356c02f = 3:  e38ade2ee0 tests: reference `seen` wherever `pu` was referenced

-- 
gitgitgadget
