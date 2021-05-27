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
	by smtp.lore.kernel.org (Postfix) with ESMTP id F047FC4708B
	for <git@archiver.kernel.org>; Thu, 27 May 2021 08:37:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB8E0613C9
	for <git@archiver.kernel.org>; Thu, 27 May 2021 08:37:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235513AbhE0IjB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 May 2021 04:39:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235410AbhE0Ii7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 May 2021 04:38:59 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E3EDC061763
        for <git@vger.kernel.org>; Thu, 27 May 2021 01:37:25 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id x7so3798718wrt.12
        for <git@vger.kernel.org>; Thu, 27 May 2021 01:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:mime-version:content-transfer-encoding
         :fcc:to:cc;
        bh=3B+39qE+Bz+xehHMvuA2E8tvcGC7Kgni3w3w9aWES0A=;
        b=ugpLJfmxNfAEEgSrrTE9yVzRP4dygkutR2K37hxVgOUueWdbH8SjYOg4D6H+OffSGM
         GmIDMiU1SJQ0DDeBTn78+UHsYULGGEvTCx7MspBjFf7AgsbEfLj0U+oOQSZTjB0FSGtu
         tKhYHzyhj2/IFNbG2K+AnkCG+OQbmQoFsFaGNhb0cjTw640v8NsPoLVzn5qdzQa//MI7
         i02+bP7Pn9sCUMFddhnWL52xF1yqV5YVu2y4fkU4vj+ffJoB1vdTvnjal4kV4QUeDDMO
         WjBHGnaG1Sr3A3Zy5/ETTlkkCcej4ae2DsBhPPTTRqPnleabRnKGTirsW/h/8LSidMEZ
         c1pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=3B+39qE+Bz+xehHMvuA2E8tvcGC7Kgni3w3w9aWES0A=;
        b=IlxwPCRw9uG+0H6TP6jxL2Wq+KS++b1S79N1NO6H8N3jJjZXsw6U9l1fbUxNvuVR1+
         JTGAOasHcajcfLoeErGqM/4qLPpeOmKYfJZewct93sApza/PxcRS82ew+hHNk7wyAWVR
         nhmaKXdsnY4xddzqG1bYi5iC3fYyV8wV2v3WtJSQSUu55tG+bAiOC247H5NX8tqN7q5H
         LT+vvZNkYt66gDpSPw+xodJb4w8zuv/CTm/d3DJQCidoZWRjpwzXvvF7YVnXpmHmHg4y
         RMkjJfIApO0DLa09r7nrNS/fmTrBpkdZ9OJJ7HoBzYd3v5eRLEOfgSrCuMsNn8zpA7nt
         Od3Q==
X-Gm-Message-State: AOAM5306kuvXqNeQ17GxqOlc7TQb2ahNhQQ24/OnE0SSaU2plUDVGJny
        1GYuMM3ujamDHIEk8P+OB5ulXZfJH+0=
X-Google-Smtp-Source: ABdhPJwpQ3F+vA0/RnCsS4LeU+p0S49mKX6kjVCAWL39LLLKv8fy402A0plYJ7T53mLdivmutSDtGA==
X-Received: by 2002:a5d:6c61:: with SMTP id r1mr2091412wrz.309.1622104643877;
        Thu, 27 May 2021 01:37:23 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c12sm2384280wrr.90.2021.05.27.01.37.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 01:37:23 -0700 (PDT)
Message-Id: <pull.962.git.1622104642.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 27 May 2021 08:37:16 +0000
Subject: [PATCH 0/5] Optimization batch 12: miscellaneous unthemed stuff
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>, Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series depends on en/ort-perf-batch-11 textually, but is semantically
independent of it.

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


Elijah Newren (5):
  merge-ort: replace string_list_df_name_compare with faster alternative
  diffcore-rename: avoid unnecessary strdup'ing in break_idx
  diffcore-rename: enable limiting rename detection to relevant
    destinations
  Fix various issues found in comments
  merge-ort: miscellaneous touch-ups

 diffcore-rename.c                   | 52 ++++++++++++++++---
 diffcore.h                          |  2 +
 merge-ort.c                         | 78 +++++++++++++++++++----------
 t/t6423-merge-rename-directories.sh |  2 +-
 4 files changed, 99 insertions(+), 35 deletions(-)


base-commit: 76e253793c9a1d7fdd1836d5e4db26dabd3d713a
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-962%2Fnewren%2Fort-perf-batch-12-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-962/newren/ort-perf-batch-12-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/962
-- 
gitgitgadget
