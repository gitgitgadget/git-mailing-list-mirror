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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26ED9C47080
	for <git@archiver.kernel.org>; Tue,  1 Jun 2021 14:37:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E1A46124B
	for <git@archiver.kernel.org>; Tue,  1 Jun 2021 14:37:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234160AbhFAOjI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Jun 2021 10:39:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234038AbhFAOjH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Jun 2021 10:39:07 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 067A9C061574
        for <git@vger.kernel.org>; Tue,  1 Jun 2021 07:37:26 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id n17-20020a7bc5d10000b0290169edfadac9so1751106wmk.1
        for <git@vger.kernel.org>; Tue, 01 Jun 2021 07:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=oxSmTzCwyEAEwRFI3w1sHnaY3LVMGURSfqe+9AYhDr8=;
        b=eVMHKH1Os2gPzJEbDocYdeeeNFHG62iBA5wtr1j05mJjVHmThWWxSzQdGxQMO8JzxY
         J6G7m/nicLZUmIAlVpShdVSRAP3x2ndfAB9SdKUnnqfpzUaZG9TWcMTXen+Fq5VHswB3
         pMxEcrLg8BwnNOYzDeL6n1GPp/jgTsHLJEhA/wrXr6qSfP7KJaO2YJ8sRLkd2z/5vDSU
         BIGUbjvhHwPLLVuvbZLGepraieQIZ+ATiZbZ5oxKCmQG8HnanwkdZ3em/jOA+JoExvzs
         S9QJ04hH6cwJbzPShn+/xyWZa7lqW89z2H6Dog0zKUF5o6ancCM1H5EiyQB0okj82Dok
         HSig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=oxSmTzCwyEAEwRFI3w1sHnaY3LVMGURSfqe+9AYhDr8=;
        b=YSNCy5FZBsj1i7nPGKaQv3VsWu00ZpuW+2Vb1xsQOMYLRrjLi8efbK6wKS54IAQqoZ
         qWJyRPSRke7rJZDiq8L9nGdaAndowVD1657YM8NsMRSMFYCLbqGbj8OAi8TYFoX/JO4V
         Ic0815JE3J2D+Ko59JwVWuHouLxwh6a1ssj3cK2/Pk4NZe0JSgX7LqRhbOY2rwtNwpVm
         64Ra+64SgE2frKKwbnbbHK/5r7uzqC1neC/AOTKSC4AnSr9WcUhxBXDi/yIF2lbSjy1a
         5QOG/bT0BVwpibF+zF7rwov1hErrWeuWJicY8H0lffIjnVe/oDMxXm0Y4q8vpZWQuKkS
         kapg==
X-Gm-Message-State: AOAM5326ISeznx6hi0fnJRNbsyiLHMT7n2bwSMkj4dA9jMQz3RHb2ovq
        ghi8u9//bDwSV1Ro79RyOvuOMFW/jUA=
X-Google-Smtp-Source: ABdhPJzDpNwI5eovrrV/ePVJlNTf7w8hdJJbRhgC04ovQ1vz5KKT6cm+QlyJrBZypvfNW8YZ+KZLPw==
X-Received: by 2002:a05:600c:8a6:: with SMTP id l38mr13104397wmp.108.1622558244675;
        Tue, 01 Jun 2021 07:37:24 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v18sm3787297wrb.10.2021.06.01.07.37.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 07:37:24 -0700 (PDT)
Message-Id: <pull.966.git.1622558243.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 01 Jun 2021 14:37:21 +0000
Subject: [PATCH 0/2] [GSOC] ref-filter: add %(raw) atom
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Karthik Nayak <karthik.188@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood123@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In order to make git cat-file --batch use ref-filter logic, I add %(raw)
atom to ref-filter.

Change from last version:

 1. Change is_empty() logic.
 2. Simplify memcasecmp().
 3. rebase on zh/ref-filter-atom-type.

ZheNing Hu (2):
  [GSOC] ref-filter: add obj-type check in grab contents
  [GSOC] ref-filter: add %(raw) atom

 Documentation/git-for-each-ref.txt |   9 ++
 ref-filter.c                       | 164 +++++++++++++++++------
 t/t6300-for-each-ref.sh            | 207 +++++++++++++++++++++++++++++
 3 files changed, 343 insertions(+), 37 deletions(-)


base-commit: 1197f1a46360d3ae96bd9c15908a3a6f8e562207
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-966%2Fadlternative%2Fref-filter-raw-atom-v4-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-966/adlternative/ref-filter-raw-atom-v4-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/966
-- 
gitgitgadget
