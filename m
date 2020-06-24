Return-Path: <SRS0=BxWL=AF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25A74C433E0
	for <git@archiver.kernel.org>; Wed, 24 Jun 2020 14:48:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 050B220724
	for <git@archiver.kernel.org>; Wed, 24 Jun 2020 14:48:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n+ylcYLq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390412AbgFXOso (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Jun 2020 10:48:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389818AbgFXOsn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jun 2020 10:48:43 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB3E4C061573
        for <git@vger.kernel.org>; Wed, 24 Jun 2020 07:48:42 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id g75so2583592wme.5
        for <git@vger.kernel.org>; Wed, 24 Jun 2020 07:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=IbNu5NNAJ+KA4mB0SnH31deihuoYgjJ3WaxV/aIePog=;
        b=n+ylcYLqLgEpwYhCYEd+XS1TNbO2JTk7liDwt8cQ/BU+J2qZnqgKeMHsH3yaaEVn1u
         np9d8JY1iIERNpM+Fg7oR6p32vOetrDlPD+EVYDDWWJ/MVUUQe7kgfeioGvVO1gKPk9I
         6PqNN2xj38lreLjbHRR00/FJm0bRrahLJeeQC6HLYUMzsoF3qRXVz3Nv6xYEThFlU8vg
         AYQsvCaNFlTmWY3PhFkA2R85bFNuGohauQrVcMdM6z/KRi0OzOjdh3YvVc5YnaF20UD9
         W66i5oXFrzljD9FYkrQe/ke4mDpUKXG5R22RX+kT8k+IfcA2zbMttG5fdf/axRTtMIK6
         B4sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=IbNu5NNAJ+KA4mB0SnH31deihuoYgjJ3WaxV/aIePog=;
        b=HMudgMdFRAn703nLEI3Wls7ghr37sOrwcvA1uWAcM/DkfCWfDf4R66jRt5nP7PsTrY
         ryIasTq2BNO9W31XfjZ7bxVNCAfacI50RjxZmjqyyCq4oNx7NztC5nfHrBg5nDT/0oIH
         rORjlpMprM53+qk75Hpbo9+omqgcwOmwonupxvEmjH/ii/69001m56EyfTPjMDqPqOYp
         OIDAwX98El/vYX6WIYU1IZ5FjnBPC2g3uw2emklbJ/rUP9Ns1T64PnlhFZ/ueD9siiXr
         eQjclEqgGrAeks44CV7yfrKBta7BWD8Br21yPDaLI7Gu0a/o9FaRApDFTpi1xVr7QICM
         vt3Q==
X-Gm-Message-State: AOAM530UTiuLFf49h+OCyCaWQCYh1oPAYpUxOThjGzLJHJBSA8pMEQ6O
        wqi05KMinvG2HUSPxQQvNnokhboHc6I=
X-Google-Smtp-Source: ABdhPJyyMIl+ugJVrnqy4p74earUtuDsxQgVxEgAZ0aM4IeKek5fF1Ga4l0Pj/IvJOs8Akf/K66Z8w==
X-Received: by 2002:a05:600c:2187:: with SMTP id e7mr1469415wme.171.1593010121267;
        Wed, 24 Jun 2020 07:48:41 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f12sm14383203wrw.53.2020.06.24.07.48.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 07:48:40 -0700 (PDT)
Message-Id: <pull.668.v2.git.1593010120.gitgitgadget@gmail.com>
In-Reply-To: <pull.668.git.1592924655.gitgitgadget@gmail.com>
References: <pull.668.git.1592924655.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 24 Jun 2020 14:48:37 +0000
Subject: [PATCH v2 0/3] Accommodate for pu having been renamed to seen
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


base-commit: c9c318d6bf26bcecdca5b6f31683b9d5887a83ee
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-668%2Fdscho%2Faccommodate-for-pu-having-been-renamed-to-seen-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-668/dscho/accommodate-for-pu-having-been-renamed-to-seen-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/668

Range-diff vs v1:

 1:  dc6f971290 ! 1:  35e3dafd6a docs: adjust for the recent rename of `pu` to `seen`
     @@ Documentation/SubmittingPatches: their trees themselves.
         patches, and will let you know. This works only if you rebase on top
         of the branch in which your patch has been merged (i.e. it will not
      -  tell you if your patch is merged in pu if you rebase on top of
     -+  tell you if your patch is merged in 'seen' if you rebase on top of
     ++  tell you if your patch is merged in `seen` if you rebase on top of
         master).
       
       * Read the Git mailing list, the maintainer regularly posts messages
     @@ Documentation/giteveryday.txt: $ git push --follow-tags ko <13>
       <2> see which branches haven't been merged into `master` yet.
       Likewise for any other integration branches e.g. `maint`, `next`
      -and `pu` (potential updates).
     -+and `seen` (patches seen by the maintainer).
     ++and `seen`.
       <3> read mails, save ones that are applicable, and save others
       that are not quite ready (other mail readers are available).
       <4> apply them, interactively, with your sign-offs.
     @@ Documentation/gitworkflows.txt: As a given feature goes from experimental to sta
      -* 'pu' (proposed updates) is an integration branch for things that are
      -  not quite ready for inclusion yet (see "Integration Branches"
      -  below).
     -+* 'seen' (patches seen by the maintainer) is an integration branch for
     ++* `seen` (patches seen by the maintainer) is an integration branch for
      +  things that are not quite ready for inclusion yet (see "Integration
      +  Branches" below).
       
 2:  b792cb036c = 2:  c2bcfdcb5b docs: adjust the technical overview for the rename `pu` -> `seen`
 3:  17adbd5639 = 3:  c8e356c02f tests: reference `seen` wherever `pu` was referenced

-- 
gitgitgadget
