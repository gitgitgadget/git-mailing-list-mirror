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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92129C432BE
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 07:14:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7670960FC3
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 07:14:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238183AbhHQHP1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Aug 2021 03:15:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233688AbhHQHPY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Aug 2021 03:15:24 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25521C061764
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 00:14:52 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id w21-20020a7bc1150000b02902e69ba66ce6so1466514wmi.1
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 00:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=CfbdtjaqZ7uRZhfx+L/QP9luCRYElmgE3eeg9vAZcEY=;
        b=jvG/SxXOcuI6nQv2/2bwaxnlHDu1JyUPSAx80Pp58qmGt7PWTYXtaGR2Tz7c4SJqtI
         zRP/UNm2oKx7X3816r/jf4TME2w1gXn3mxY+ErKj0yhQEhJd0DZbShifu+Wa6spc3DVY
         epDV9PH9ACMqSmthjhkkuLys3r2GUvJUqWFpNBDHoIJv24RG0VaBRmYE9fs17fVJwFz/
         cIpEhdviY4+Ht2yG+PeU0jH4cdsvJHMiE8jAgwShV9XxBhqC6wN+e0VBatWOlKwxmIaT
         ot9BsSZhPfRCeZMDuwCudxAdTQ88U/ItWy37lhJ59/OfqzCcagc8wK7rdA503hywU1em
         jKmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=CfbdtjaqZ7uRZhfx+L/QP9luCRYElmgE3eeg9vAZcEY=;
        b=cVwSLIlcMOoacD64Olsy8zpQYEL5m/UhA6VdPi8Q+O53oPBCX/mjglGVWvsMRZ8PAs
         0V/ioqO2GOxtqkf587CYSDn0U3UZH9wTXGyMoIbGvTpaEckNBZEffkU5WSxbyGRbOcDr
         cvPE8h1HC/VjwLXY4tfes/qJZrpKbEo7QI+pJgXi3Mic6eO3K716SyZfW4YTYyoxaAub
         +RJ+BLMWNtrQGbP6pbj453vt6mvgG1Ozc8sJ2Bt7IH8uOhtDH51UBdummFdTjp6RkxJk
         U2Rwz2/vLQcm71aIxdVx5+ZSEu5PIwuOszgkByyDMQAb/PfAJRQrSXLZOp41kM6izqfs
         yYEw==
X-Gm-Message-State: AOAM533FJoWHYky996pcd5jYLSGkxBE3cxrS70TIR1ZV0KzU9sTUgY44
        XWQT0DYrguO52NOX7Jeh25VF8n1KlA4=
X-Google-Smtp-Source: ABdhPJyjjV5VPCDeAN2KlKyubUtdeJob5QSf/uI1zXhTvs/3CKm+cuy7e69CBTXHdLY7d1o3XWffjA==
X-Received: by 2002:a05:600c:4f85:: with SMTP id n5mr1804861wmq.146.1629184490656;
        Tue, 17 Aug 2021 00:14:50 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c6sm1244623wme.45.2021.08.17.00.14.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 00:14:50 -0700 (PDT)
Message-Id: <pull.1020.git.1629184489.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 17 Aug 2021 07:14:44 +0000
Subject: [PATCH 0/5] [GSOC] [RFC] ref-filter: performance optimization
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Philip Oakley <philipoakley@iee.email>,
        ZheNing Hu <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Last time I submitted a very long patch series:
https://lore.kernel.org/git/pull.1016.git.1628842990.gitgitgadget@gmail.com/
My mentor Christian suggested to split the performance optimization part
out, so this patch series used to optimize performance optimization in
ref-filter.

Changes in this patch series:

 1. Skip parse_object_buffer(), which can reduce object content parsing.
 2. Use linked list to record parsing results, which can reduce second
    format string parsing.
 3. Reuse final buffer, which can reduce memcpy();
 4. Add a need_get_object_info flag instead of compare two object_info,
    which can reduce memcmp();
 5. Use ALLOC_ARRAY() instead of CALLOC_ARRAY(), which can reduce memset();

Since the relevant part of git cat-file --batch has been deleted, the
execution time of git for-each-ref is very short, I haven’t added
performance tests yet for git for-each-ref.

ZheNing Hu (5):
  [GSOC] ref-filter: skip parse_object_buffer in some cases
  [GSOC] ref-filter: remove second parsing in format_ref_array_item
  [GSOC] ref-filter: reuse final buffer
  [GSOC] ref-filter: reduce unnecessary object_info comparisons
  [GSOC]: ref-filter: instead CALLOC_ARRAY to ALLOC_ARRAY

 builtin/branch.c       |   2 +
 builtin/for-each-ref.c |   3 +-
 builtin/tag.c          |   2 +
 builtin/verify-tag.c   |   2 +
 ref-filter.c           | 168 ++++++++++++++++++++++++++++++++---------
 ref-filter.h           |  17 ++++-
 6 files changed, 154 insertions(+), 40 deletions(-)


base-commit: f000ecbed922c727382651490e75014f003c89ca
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1020%2Fadlternative%2Fref-filter-opt-perf-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1020/adlternative/ref-filter-opt-perf-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1020
-- 
gitgitgadget
