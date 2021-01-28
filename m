Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7461EC433E6
	for <git@archiver.kernel.org>; Thu, 28 Jan 2021 04:08:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30AC964D9F
	for <git@archiver.kernel.org>; Thu, 28 Jan 2021 04:08:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231426AbhA1EIi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Jan 2021 23:08:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231352AbhA1EGy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jan 2021 23:06:54 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0DC5C061354
        for <git@vger.kernel.org>; Wed, 27 Jan 2021 20:06:11 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id 7so4054891wrz.0
        for <git@vger.kernel.org>; Wed, 27 Jan 2021 20:06:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=VOoP6Xt5ci91qfq1z+Gg+rwGksCQOl9Zzp8IjduY7XM=;
        b=cZ6huepJNMkfOLYD67U65Rpbz2+8Nkh9SRGJ2JrmzbA7X/Psz35PHbN9HWJG1sE0I7
         edyvTVYbFeql6Wo21MOnwctjI508VO3TocyT24R7r7XwS7STBVePnH7srrX0MfznWUDN
         pu1LhsNeJ9tsxpaK2Fx6RhaA+kVW/ZHhx3CUidqfJHKpHoUb9otgeh4evVnO5C+TEH52
         zA0p86ycaQH2jzcRaNxyukbJSDM958SOZxzjP8uctc1WRXfJdLCsX569zMLUtasNvndx
         ubrmffm2JaF2fnprCHOt11kkMCu5mrq7bYZcSW5UbqBXMJe2ywmt2YkddmHqz9zY8vjF
         Xl3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=VOoP6Xt5ci91qfq1z+Gg+rwGksCQOl9Zzp8IjduY7XM=;
        b=Z5gRc5AJXsH4oPX2pMtI7gglrcK46kgLkNv8/zVHiMRVyabLIGPE0ipKkAInENhDwN
         9bVP1bETmC0D5yBWBQ1/6y/eTv7I/2OUcIJ/nSjJcMEUp/XlphCYgcoKYFxWkllyGXYd
         7cjtpXK+LkytAFPUGR1IQdsaHbhm7rkdw2xcfKrBemMpHGxL5qOdLCWBNG2LQLweMsHQ
         TNgRw6a7av71W5KtfhCA+DT3C90sPx+yDuG2DXPiDkaeoUuxphdqUu0rSYcgWdHFpV9b
         5Q8wXa2suRN9Z+7/729LD3/KAlZFvOvL7dnX5acMY7p/UNfRW97mYS93lgCehQod8K9v
         fGiw==
X-Gm-Message-State: AOAM530qW5R3UDt4ZPbAxaFVCLKm+FoM0agshwc/IllSPTijwhegulXR
        UNOab5XmMmO28HqOyBdOILxMNr8UdV4=
X-Google-Smtp-Source: ABdhPJyfF2jWPwQttwmWAEl5Cv7b3cOeD5d5eX0OHIXU9/eagcNQgUmTuCWX+hh3VELU1Xw5OP9pZA==
X-Received: by 2002:adf:e404:: with SMTP id g4mr14008994wrm.416.1611806770535;
        Wed, 27 Jan 2021 20:06:10 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q18sm5332624wrr.55.2021.01.27.20.06.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jan 2021 20:06:09 -0800 (PST)
Message-Id: <pull.851.git.1611806768911.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 28 Jan 2021 04:06:08 +0000
Subject: [PATCH] ci: do not cancel all jobs of a matrix if one fails
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     johannes.schindelin@gmx.de, Taylor Blau <me@ttaylorr.com>,
        Jeff King <peff@peff.net>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philippe Blain <levraiphilippeblain@gmail.com>

The CI/PR GitHub Actions workflow uses the 'matrix' strategy for the
"windows-test", "vs-test", "regular" and "dockerized" jobs. The default
behaviour of GitHub Actions is to cancel all in-progress jobs in a
matrix if one of the job of the matrix fails [1].

This is not ideal as a failure early in a job, like during installation of
the build/test dependencies on a specific platform, leads to the
cancellation of all other jobs in the matrix.

Set the 'fail-fast' variable to 'false' for all four matrix jobs in the
workflow.

[1] https://docs.github.com/en/actions/reference/workflow-syntax-for-github-actions#jobsjob_idstrategyfail-fast

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
    ci: do not cancel all jobs of a matrix if one fails

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-851%2Fphil-blain%2Fgh-actions-dont-fail-fast-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-851/phil-blain/gh-actions-dont-fail-fast-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/851

 .github/workflows/main.yml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index aef66436484..f6885e88ee6 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -123,6 +123,7 @@ jobs:
     runs-on: windows-latest
     needs: [windows-build]
     strategy:
+      fail-fast: false
       matrix:
         nr: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
     steps:
@@ -227,6 +228,7 @@ jobs:
     runs-on: windows-latest
     needs: [vs-build, windows-build]
     strategy:
+      fail-fast: false
       matrix:
         nr: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
     steps:
@@ -272,6 +274,7 @@ jobs:
     needs: ci-config
     if: needs.ci-config.outputs.enabled == 'yes'
     strategy:
+      fail-fast: false
       matrix:
         vector:
           - jobname: linux-clang
@@ -309,6 +312,7 @@ jobs:
     needs: ci-config
     if: needs.ci-config.outputs.enabled == 'yes'
     strategy:
+      fail-fast: false
       matrix:
         vector:
         - jobname: linux-musl

base-commit: e6362826a0409539642a5738db61827e5978e2e4
-- 
gitgitgadget
