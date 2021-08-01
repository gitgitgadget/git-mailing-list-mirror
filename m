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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D45FDC4320E
	for <git@archiver.kernel.org>; Sun,  1 Aug 2021 00:07:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B71C761042
	for <git@archiver.kernel.org>; Sun,  1 Aug 2021 00:07:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbhHAAHx (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 31 Jul 2021 20:07:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229465AbhHAAHx (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 31 Jul 2021 20:07:53 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECF93C06175F
        for <git@vger.kernel.org>; Sat, 31 Jul 2021 17:07:44 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id d8so16598950wrm.4
        for <git@vger.kernel.org>; Sat, 31 Jul 2021 17:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=sYY9oOQA8LmHjf5RsofxwS0zRf/KFOLozjHIV890fuQ=;
        b=nexOaYCExMvegfhUwufj55aCcq4ANFlYkolJBEEs9ycTXJhtIfSMSZhrg87MIhIoFZ
         D5kauWR/Xoq1DCzi0MAA0dMqnJgxVmKTbLSeebraMKoeTMqmpT72exfACUyHv/YrsGhl
         x6bhKv7ZAxYdeNhoIZ5pcgDOaoZJhmeROgKWcDIvscNwrXEjCf1Q8N6oVXg5b4Y8Zs/s
         0CkMcoSuf8qEg9qqnNtqhIVXP6p0Uer/LA++OIHCyAvo52GUjusHs46BqXbINcgvXg45
         //vW7pSaT0MxA7dQ7phjnjrYDuqtJCUekTC9VtfUPbonHMLUf04ACvWm6Y/3g5YmbJBw
         zqJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=sYY9oOQA8LmHjf5RsofxwS0zRf/KFOLozjHIV890fuQ=;
        b=NxP5Ub0BRB7F+l4Ci0Z7E6POoVKFTRx5hL+cUsgJOHoCUbnHVhkosLa+H5e5rzrHnx
         phYdm2KAzYvkKVLgsEI1Bf+DtmRJxdUs7Aqxr+tMaAlLoB/YaGcZIcWz4CCW1w0POHme
         ofi57Y4CsYrmPDvXiMHzRhq6NsdHpejb4lcjpSqCxFBOpRWYr95CiRptiiaw9AuHZgvg
         lmATGF8HgZ6a8saCVFXh+uH0jfEgsJ05M+k3kYS1/uVt1ilaxOa4hsbye93Kx/Hl1UAs
         8EWNAuWwmyp2332WG+xwRzYMl1Dx7NlhcKXC+jJ37wIfAZBKLkKwmwfOZJsSETIUc/f8
         ciVw==
X-Gm-Message-State: AOAM530kMn9dAuQ4JrmzpOr+GsynE/1SGs+2I0bYgGw7qrJXGN8IHOEC
        MXWiB9nFQ79QFYPp7PUbAJBzZWgH+Uk=
X-Google-Smtp-Source: ABdhPJz/v2FWfbsAvC7+zaB/n0n/xs+jl8XYHsSJ1FVNcGKXNh4We1cJ/ATUC+tEMMRJ+/Am8Y6bbw==
X-Received: by 2002:adf:80e8:: with SMTP id 95mr10140021wrl.388.1627776463576;
        Sat, 31 Jul 2021 17:07:43 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l33sm5348951wms.12.2021.07.31.17.07.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Jul 2021 17:07:43 -0700 (PDT)
Message-Id: <pull.1055.git.git.1627776461.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 01 Aug 2021 00:07:39 +0000
Subject: [PATCH 0/2] [RFC] Switch default merge backend from recursive to ort
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

This is an RFC series designed to spur feedback about switching the default
merge backend (reviewing the patches is of secondary importance at this
point). Some questions:

 * Are there things others want before this series is considered for
   inclusion?
 * What kind of timeline do others think is reasonable?
 * Would it be beneficial to let this series sit in 'next' for an extended
   duration to gain more feedback?

Some potentially useful context in relation to the above:

 * I've personally used the ort backend for well over a year
 * I have ~50 testers using ort as the default merge backend since Nov.
   2020.
 * ort fixes known bugs in recursive, and there are no known regressions
   (more testers may change that)
 * ort is significantly faster than recursive
 * ort provides one new feature already, and enables more that are on the
   way
 * The commit message of patch 1 has more details about the last three items
   above

So...thoughts?

Elijah Newren (2):
  Change default merge backend from recursive to ort
  Update docs for change of default merge backend

 Documentation/git-rebase.txt                  | 17 ++--
 Documentation/gitfaq.txt                      |  2 +-
 Documentation/merge-options.txt               |  4 +-
 Documentation/merge-strategies.txt            | 98 +++++++++++--------
 .../technical/directory-rename-detection.txt  | 14 +--
 Documentation/user-manual.txt                 |  2 +-
 builtin/merge.c                               | 10 +-
 builtin/rebase.c                              |  2 +-
 sequencer.c                                   |  4 +-
 9 files changed, 89 insertions(+), 64 deletions(-)


base-commit: eb27b338a3e71c7c4079fbac8aeae3f8fbb5c687
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1055%2Fnewren%2Fort-default-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1055/newren/ort-default-v1
Pull-Request: https://github.com/git/git/pull/1055
-- 
gitgitgadget
