Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DC58C47082
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 16:12:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 668206120F
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 16:12:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231675AbhFHQOD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Jun 2021 12:14:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231663AbhFHQNx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jun 2021 12:13:53 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13DFEC061787
        for <git@vger.kernel.org>; Tue,  8 Jun 2021 09:11:46 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id u5-20020a7bc0450000b02901480e40338bso1831008wmc.1
        for <git@vger.kernel.org>; Tue, 08 Jun 2021 09:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=9bxMc7OKO0g2yNjP1yRqKu44l2F2/5zZazld7jBk/mg=;
        b=QuPeU1Wbt72XpGxgOBdOD/OAAvm889X4/hL8OmcuLW5VodqjBSZ1wdpscmVHd40Pmw
         Dhm2mdFveNAAGlo8Ez8MSgyVrxokfYAEcPgNM3UWGwcOm0aGsRLhqRwEricNbRKI82sR
         W6NQJtnMvNFbFdWYaLRUiqMKxrSUl5sHojx/RLzrcMjcAa8/cfMxo3ApM9A1ffbEBHh8
         XsK/1EH41YGx3M14LUqnMh1NV6YO8FgpG7HWoLu8VBQRYHmESXJ2f1TqMXIHNsyHF0Ld
         gTjKQGPOgtVHbPiK0gcQLuCAw8LXWvVRIY22504PTPmz7ah3Gx4itNCBIw4NyeF9EiwU
         tXow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=9bxMc7OKO0g2yNjP1yRqKu44l2F2/5zZazld7jBk/mg=;
        b=XufIiH9iVbufa8jJMyXvKbOW9koNYE5maKYUToujOkM5DCB6zn10Yzoj+3uqN9iNZM
         XCZGkIxaSLHblMLclvzffBbxzSFI0fHhQ2ALTPTDHcenrg0Ie0Mma+vYdwR894b65RYt
         x7YYIUJNm8jA+V4m2He+jTFZ2hzwZRLbEOP3RlMdgFPoLM6W8ql8Y/IATOvsdl3eGTQz
         Vim5I9tVcr85cgiitWFHlHJoCgxuuWm7v1UgyJwop8oWxhw4J0SCDQFRW6xan4iNnIuK
         2BtdsTMTt1AGheqk5NHYBFhe0SW02Fpdg823u6YEmBAdq6vBw4M7473d7qWalbxSk55Y
         r8Dw==
X-Gm-Message-State: AOAM533vUk5ma1TqMzQpTfjepMo12mcegn01+wMFEiNT0+MwjOG72l2h
        +Jrwf9oqJVdWU5gWWielqyl0/LaZ/dU=
X-Google-Smtp-Source: ABdhPJxYHhBL05+1zkoe8333cB3JOVtcnLiEoJyDA3dCyxiU+Q6c77ow/H2ssAfvCYTQ1yyKSGD6Rg==
X-Received: by 2002:a05:600c:21cf:: with SMTP id x15mr5005943wmj.174.1623168704682;
        Tue, 08 Jun 2021 09:11:44 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k8sm17700320wrp.3.2021.06.08.09.11.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 09:11:44 -0700 (PDT)
Message-Id: <pull.962.v4.git.1623168703.gitgitgadget@gmail.com>
In-Reply-To: <pull.962.v3.git.1622781578.gitgitgadget@gmail.com>
References: <pull.962.v3.git.1622781578.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 08 Jun 2021 16:11:38 +0000
Subject: [PATCH v4 0/4] Optimization batch 12: miscellaneous unthemed stuff
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series depends on en/ort-perf-batch-11 textually, but is semantically
independent of it.

Changes since v3:

 * Changed Acked-by from Stolee to Reviewed-by.

Changes since v2:

 * Made suggested minor tweaks from Stolee on Patch 1
 * Dropped patch 3, for now
 * Added Stolee's Acked-by

Changes since v1 (all for the first patch):

 * Add more comments explaining the sorting function, its purpose, and how
   its expected to be called
 * Small style fixup
 * Switch back to using string_list_sort() instead of direct QSORT()

This short series has a few optimizations, but only one of which affects the
testcases of interest (namely, reducing our time spent on sorting an array).
It also fixes a few comments.

For the testcases mentioned in commit 557ac0350d ("merge-ort: begin
performance work; instrument with trace2_region_* calls", 2020-10-28), the
changes in just this series improves the performance as follows:

                     Before Series           After Series
no-renames:        5.622 s ±  0.059 s     5.235 s ±  0.042 s
mega-renames:     10.127 s ±  0.073 s     9.419 s ±  0.107 s
just-one-mega:   500.3  ms ±  3.8  ms   480.1  ms ±  3.9  ms


As a reminder, before any merge-ort/diffcore-rename performance work, the
performance results we started with were:

no-renames-am:      6.940 s ±  0.485 s
no-renames:        18.912 s ±  0.174 s
mega-renames:    5964.031 s ± 10.459 s
just-one-mega:    149.583 s ±  0.751 s


Elijah Newren (4):
  merge-ort: replace string_list_df_name_compare with faster alternative
  diffcore-rename: avoid unnecessary strdup'ing in break_idx
  Fix various issues found in comments
  merge-ort: miscellaneous touch-ups

 diffcore-rename.c                   |  4 +-
 merge-ort.c                         | 80 ++++++++++++++++++++---------
 t/t6423-merge-rename-directories.sh |  2 +-
 3 files changed, 60 insertions(+), 26 deletions(-)


base-commit: 76e253793c9a1d7fdd1836d5e4db26dabd3d713a
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-962%2Fnewren%2Fort-perf-batch-12-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-962/newren/ort-perf-batch-12-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/962

Range-diff vs v3:

 1:  f63ffc2a7c22 ! 1:  140c1e89e0ec merge-ort: replace string_list_df_name_compare with faster alternative
     @@ Commit message
              just-one-mega:   500.3  ms ±  3.8  ms   480.1  ms ±  3.9  ms
      
          Signed-off-by: Elijah Newren <newren@gmail.com>
     -    Acked-by: Derrick Stolee <dstolee@microsoft.com>
     +    Reviewed-by: Derrick Stolee <dstolee@microsoft.com>
      
       ## merge-ort.c ##
      @@ merge-ort.c: static int detect_and_process_renames(struct merge_options *opt,
 2:  cd13499a6ff5 ! 2:  be858c46cfe7 diffcore-rename: avoid unnecessary strdup'ing in break_idx
     @@ Commit message
          unrelated optimization noted in passing while looking at the code.
      
          Signed-off-by: Elijah Newren <newren@gmail.com>
     -    Acked-by: Derrick Stolee <dstolee@microsoft.com>
     +    Reviewed-by: Derrick Stolee <dstolee@microsoft.com>
      
       ## diffcore-rename.c ##
      @@ diffcore-rename.c: static void register_rename_src(struct diff_filepair *p)
 3:  91c0962a7d75 ! 3:  55c0f2c4560a Fix various issues found in comments
     @@ Commit message
              function.  Update the comment now.
      
          Signed-off-by: Elijah Newren <newren@gmail.com>
     -    Acked-by: Derrick Stolee <dstolee@microsoft.com>
     +    Reviewed-by: Derrick Stolee <dstolee@microsoft.com>
      
       ## diffcore-rename.c ##
      @@ diffcore-rename.c: void diffcore_rename_extended(struct diff_options *options,
 4:  01352fcdf3a9 ! 4:  6de569e6ac49 merge-ort: miscellaneous touch-ups
     @@ Commit message
          of pushing these changes upstream.
      
          Signed-off-by: Elijah Newren <newren@gmail.com>
     -    Acked-by: Derrick Stolee <dstolee@microsoft.com>
     +    Reviewed-by: Derrick Stolee <dstolee@microsoft.com>
      
       ## merge-ort.c ##
      @@ merge-ort.c: static void add_pair(struct merge_options *opt,

-- 
gitgitgadget
