Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F3C2C4338F
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 07:19:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D5FE60F94
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 07:19:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238075AbhHEHTw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Aug 2021 03:19:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230471AbhHEHTv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Aug 2021 03:19:51 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8305C0613C1
        for <git@vger.kernel.org>; Thu,  5 Aug 2021 00:19:37 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id a8so6700443pjk.4
        for <git@vger.kernel.org>; Thu, 05 Aug 2021 00:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ER73iHENnPCXqOtd0CwvVC3QFr7g+0PpdWEccvOGrak=;
        b=J7VH4tD0y4YT5J69sTnSge9p5HPtbmyoYtGnGCoDRRTZClcJdYucA7Y7ZKdQUAXu8b
         97uLYPbIR4hb9hmCSgxtgBZ7bBJHpYQiXl5SxCSE3VD7mM+JIVUwm7h4hvewtyt0OzbT
         2CMe5kH42VHvzVTMHRE4LxMDVmSLzCfA08WrX3qf0IUyP2wMakG7n0M1DapA5PuHKFnV
         PR3549MOHkspHhYh1r1f4UkRzgekibKJez3DhXVyUbjH516gCKRV2zaqZmz/cbWK9Odi
         6PBOUGbGqrInJi+LsiIGzTWCz1DPro3NWeHlkaWEC2bbfOFLsPwuP7tQ+3Cglrhm4wVK
         uhDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ER73iHENnPCXqOtd0CwvVC3QFr7g+0PpdWEccvOGrak=;
        b=i2mhXWGvLhejKelsR/toUw7PmrOITZxs5ib1VA6lHo9EwW5tmNNWcwyNKcQR8ie7mM
         yzQTthIJMCz3/hTI4YkwYpvlznp9sSAsj+c6Bp8Rz8NZF9rdiv6QSyAj66J3olP8X6mK
         PvfSk3357FXorslHnq8qq+Ta2Dw1Ab4NE8rNUv8oK3DilxnCFI19wDhmS1yC9LgaMBpW
         5Qyv0Mp/7FjjUaR08CPlGRcnyhYEC30UPim8JRKyje++nDGLRwrfm1xYH1NXBUWcQcDf
         HrdhDlQcjW3sLm9QU/iiL7lKa2avO2iM76SAxB1/bSDWQL5B/irbPCUo+CCa5dQHUGb/
         K4Gg==
X-Gm-Message-State: AOAM530l13LteaKoa149tgruq89eLCOEvHLC03MjOUc7AYsnkOrbOM6m
        U0Bn2WkZSDpR9hWZsdbyPGDvKzun2JYKAMZB
X-Google-Smtp-Source: ABdhPJwvX7adG6LkyPjCM1p45QA4ETGF4L0psL4vc0T3/sunwYv40uyA7u88YrMpVo01BOTm1YqfQA==
X-Received: by 2002:a17:90b:3905:: with SMTP id ob5mr3317610pjb.211.1628147977160;
        Thu, 05 Aug 2021 00:19:37 -0700 (PDT)
Received: from atharva-on-air.Dlink ([119.82.121.47])
        by smtp.gmail.com with ESMTPSA id p17sm8569603pjg.54.2021.08.05.00.19.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Aug 2021 00:19:36 -0700 (PDT)
From:   Atharva Raykar <raykar.ath@gmail.com>
To:     git@vger.kernel.org
Cc:     Atharva Raykar <raykar.ath@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, "Emily Shaffer" <emilyshaffer@google.com>,
        "Jonathan Nieder" <jrnieder@gmail.com>,
        "Junio C Hamano" <gitster@pobox.com>,
        "Christian Couder" <christian.couder@gmail.com>,
        "Shourya Shukla" <periperidip@gmail.com>,
        "Kaartic Sivaraam" <kaartic.sivaraam@gmail.com>,
        "Eric Sunshine" <sunshine@sunshineco.com>,
        "Prathamesh Chavan" <pc44800@gmail.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>,
        "Rafael Silva" <rafaeloliveira.cs@gmail.com>
Subject: [GSoC] [PATCH 0/8] submodule: convert the rest of 'add' to C
Date:   Thu,  5 Aug 2021 12:49:09 +0530
Message-Id: <20210805071917.29500-1-raykar.ath@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

NOTE: This series uses the change introduced by 'ar/submodule-add-config'[1]

This series completes the conversion of all the important shell logic in
'submodule add' to C, by wrapping it in a submodule--helper builtin subcommand
called 'add'.

The first 4 patches are preparatory patches. The refactors mostly involve
exposing interfaces to C that were only previously usable as shell subcommands.

Then we have a patch that translates the shell code to C, faithfully reproducing
the behaviour before the conversion.

The last 3 patches are cleanup patches. Our conversions have introduced a lot of
dead code, all of them being 'submodule--helper' subcommands that have no
further use, as we have C interfaces for these already. We remove these
subcommands.

A question about the cache API used in [PATCH 5/8]:
  What is the difference between 'read_cache()' and 'read_cache_preload()'? [2]
  Which one is more appropriate for use in 'die_on_index_match()'?

Fetch-it-Via:
git fetch https://github.com/tfidfwastaken/git submodule-helper-add-list-1

Footnotes
=========

[1] https://lore.kernel.org/git/20210801063352.50813-1-raykar.ath@gmail.com/
[2] More about this question has been detailed in this section of my blog:
http://atharvaraykar.me/gitnotes/week5#some-challenges-with-the-changes-that-are-cooking

I'll quote it here for convenience:

> Before iterating through the cache entries of the index, you need to populate
> it.
>
> There’s two functions for this: read_cache() and read_cache_preload(). I have
> used the latter in my code. The thing is, when I swap it with the former, I
> could not find any change in the behaviour of my code. They appear to function
> equivalently.
>
> I understand that the *_preload() variant takes a pathspec which preloads index
> contents that match the pathspec in parallel. I don’t know what passing NULL to
> it does. Moreover, does this imply that read_cache() loads the cache on-demand,
> ie, it does no preloading?
>
> I am not sure about what exactly are their differences, and when is one variant
> preferred over the other.

Atharva Raykar (8):
  submodule--helper: refactor resolve_relative_url() helper
  submodule--helper: remove repeated code in sync_submodule()
  dir: libify and export helper functions from clone.c
  submodule--helper: remove constness of sm_path
  submodule--helper: convert the bulk of cmd_add() to C
  submodule--helper: remove add-clone subcommand
  submodule--helper: remove add-config subcommand
  submodule--helper: remove resolve-relative-url subcommand

 builtin/clone.c             | 118 +-------------
 builtin/submodule--helper.c | 304 +++++++++++++++++++-----------------
 dir.c                       | 114 ++++++++++++++
 dir.h                       |   3 +
 git-submodule.sh            |  96 +-----------
 5 files changed, 278 insertions(+), 357 deletions(-)

-- 
2.32.0

