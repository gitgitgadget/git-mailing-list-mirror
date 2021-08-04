Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8365DC4338F
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 05:38:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A5FD60E8D
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 05:38:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235354AbhHDFiS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Aug 2021 01:38:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234557AbhHDFiR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Aug 2021 01:38:17 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 967C4C0613D5
        for <git@vger.kernel.org>; Tue,  3 Aug 2021 22:38:04 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id o7-20020a05600c5107b0290257f956e02dso3084177wms.1
        for <git@vger.kernel.org>; Tue, 03 Aug 2021 22:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=yB/l/5PGW+8NDonup3WbJEGqvyHENPzdO/3JqYrqdFw=;
        b=pCvGf0vGjZMUGkGwAf00v3Q8oATeJt9/GAK7jV0Cv6IfJODqOitY7XnGuHsMTUa50A
         JirjLhkTkQxy9wBDkgkzQu4EhfDmz7dDAtnCs1bK4WHmrItAF+hV2kqZQJCmxFysGuOQ
         qQCP0/WM9s8u5NC/VM2boqJ3oCmdsU3MKTpxFBe9/hb1QJRSEpCkpxOAbok2B08hPHVh
         VqgiOr3u6PF7NkSs2CIl4TDqkSxuwPLckalFFc0Rra5+BNIZJWd0jtT3HJUfJ9EzGf34
         4XcP0nM2xOpSOHn69Blenn949Cu42pSjSpMQqlkE3e7pED3KNZ3AdT1G2kNzNZ0/mRec
         YfYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=yB/l/5PGW+8NDonup3WbJEGqvyHENPzdO/3JqYrqdFw=;
        b=aILNOSYHQ1Mfu3/IZ0T+pIfmBjXscK1sbgtNlPCY4p3lBLjI9uDZcE2YlaEAfKq3UI
         wY4a+l50FswXoKG3tznmGOd4ENoM+WMPrZiBjlePA8CEHS+NKu2cgNtIphONfId1QJOb
         SRjKOSBUGRaqGItO3DJRJqCfF+xkAyU08ffa9dkqmGhxRhwd4zsAsOwXTm+A9sXYfMwK
         /GYV6Fnickyre0fre668Bjy2rLX4aPsxA53k433jLNbuUnJoJ0KUA/LwFiHtD4dQ0Tck
         uI0CzVjXE1ogLmQKaJyScjPMhW/w4uzEWkwRnvLSm1Z+3hlR6TMZ9J2VRRA7GYqJ6rSP
         ed3A==
X-Gm-Message-State: AOAM530NXqwY2T9AYR6ovmT3CPuNpmRMObpG4kUKj69H+mG9EiL4SNco
        mbLDdV0Kd/b9w7iWV8xomWn/auEkBTY=
X-Google-Smtp-Source: ABdhPJyk7I3aYuzVnq91WFN+fdgl8MnEBPIrpN6rT/HxNfnGPvav3YwPevyH18nJnHDcdzgCzF/Ykw==
X-Received: by 2002:a7b:c390:: with SMTP id s16mr26218075wmj.148.1628055483229;
        Tue, 03 Aug 2021 22:38:03 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 19sm4608096wmj.48.2021.08.03.22.38.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 22:38:02 -0700 (PDT)
Message-Id: <pull.1011.git.1628055482.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 04 Aug 2021 05:38:00 +0000
Subject: [PATCH 0/2] Switch default merge backend from recursive to ort
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Christian Couder <chriscool@tuxfamily.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a reroll of my RFC series[1] to switch the default merge backend
from recursive to ort. The consensus seems to be that we should do this
immediately after the 2.33 release.

Note that folks who want to get the old merge backend after this series can
simply set pull.twohead=recursive. (And, similarly, before this series,
those who want to try out ort in Git 2.32 or Git 2.33 can set
pull.twohead=ort.)

Changes since the RFC version of this series:

 * Now depends on the reroll of en/merge-strategy-docs I just submitted[2].
 * Made tweaks to code and documentation suggested by Stolee, Dscho, and
   Ævar

[1]
https://lore.kernel.org/git/pull.1055.git.git.1627776461.gitgitgadget@gmail.com/
[2]
https://lore.kernel.org/git/pull.1059.git.git.1628004920.gitgitgadget@gmail.com/

Elijah Newren (2):
  Change default merge backend from recursive to ort
  Update docs for change of default merge backend

 Documentation/git-rebase.txt       | 28 ++++-----
 Documentation/gitfaq.txt           |  2 +-
 Documentation/merge-options.txt    |  2 +-
 Documentation/merge-strategies.txt | 93 ++++++++++++++++--------------
 Documentation/user-manual.txt      |  2 +-
 builtin/merge.c                    | 10 +++-
 builtin/rebase.c                   |  2 +-
 sequencer.c                        |  4 +-
 8 files changed, 78 insertions(+), 65 deletions(-)


base-commit: 4a78ac53424525d7099867d5a4377b8afb9bf18f
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1011%2Fnewren%2Fort-default-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1011/newren/ort-default-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1011
-- 
gitgitgadget
