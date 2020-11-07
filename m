Return-Path: <SRS0=euRE=EN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50110C2D0A3
	for <git@archiver.kernel.org>; Sat,  7 Nov 2020 01:21:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D648820704
	for <git@archiver.kernel.org>; Sat,  7 Nov 2020 01:21:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eWjsswKg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727264AbgKGBVs (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Nov 2020 20:21:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726447AbgKGBVs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Nov 2020 20:21:48 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64DEFC0613CF
        for <git@vger.kernel.org>; Fri,  6 Nov 2020 17:21:48 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id c17so3086859wrc.11
        for <git@vger.kernel.org>; Fri, 06 Nov 2020 17:21:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=J/d/s77CA/YgiBC86krNHBmN43FOk4uyvgKJoE6tvek=;
        b=eWjsswKgwlBOLMVmnYG26aQQ1I7LrI9f6u63lKc1aaJCa8csTK3XLLcrEEymX7VY1S
         XbHZLsSbSRxWnxovpUEbqJL3yDuawUTPJi2iboRGigHfl7OaPz/zNFAD3V7nQogb4WU8
         w0hMdOkCIZZHQmBZddEeQWhCGH4fBYv5+I1XrPNeSSrf42G04rOKvZ3slSML0JSA0auz
         8Ld2FwecIu1KqkEKG4OfY4lmMu/0Jw7iDkR8MYvC9q0bKB0sqL6KJGCaaQaflNFB3R5o
         vwpnDiubL8YNmqxnltjC0F4HFqLO8UI3jGRgu3TfZZ9Jcysaoh1y2UDatHrpTUzCcqmB
         fbSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=J/d/s77CA/YgiBC86krNHBmN43FOk4uyvgKJoE6tvek=;
        b=q4+3wKtZg1kwpYntamZik+dw1dAvk9FJ1HRsiLy3mBlWFl9ORl6wNfArJQhHbgErHy
         FoR5HFBCOXC5WeAMbNzVwNGs3UuBk0AEU/PnMtWCubuB/dWPcG1NK2u3no6eda/+eeId
         n+fYFF8ITcH6K41vPX2i3aHughFGr7oVqvHDxgWdvNu4CNiM382Uk74dk4wojr7XnrTM
         SIsmBwDBKkM6QKNCNJg1EI/7NpkRRn/VieA2u4Nu7TYzfgsFsWrBm69Q6SadlH8ewzW4
         tJUpIrGCzHrH2UGt74DfIG2JAyAgAkKHUB91uY/LsZM68eOwghPtvwi8oyi+BoWMaLmJ
         +Pew==
X-Gm-Message-State: AOAM531eeG4WdR9F2C2VXu26ebXt7v1mh9Y4NJEmyiC4h9pwfYMIHIlL
        6H0XbzaPv/sGQFREylJXsolZLZtWs+8=
X-Google-Smtp-Source: ABdhPJxkKOhtmrroGKS2XQiB9WGNqfKaxTsppb+aPK/bmcumCA0vBiiwO0Q5Rb9MfMe42HdTQ+AYdg==
X-Received: by 2002:a05:6000:1088:: with SMTP id y8mr1071581wrw.207.1604712107053;
        Fri, 06 Nov 2020 17:21:47 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 18sm4183888wmo.3.2020.11.06.17.21.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 17:21:46 -0800 (PST)
Message-Id: <pull.781.git.1604712106219.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 07 Nov 2020 01:21:45 +0000
Subject: [PATCH] ci: avoid using the deprecated `set-env` construct
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     "Chris. Webster" <chris@webstech.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The `set-env` construct was deprecated as of the announcement in
https://github.blog/changelog/2020-10-01-github-actions-deprecating-set-env-and-add-path-commands/

Let's use the recommended alternative instead.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    ci: avoid using the deprecated set-env construct
    
    This avoids an ugly warning (see e.g. this run
    [https://github.com/gitgitgadget/git/actions/runs/350443139]).

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-781%2Fdscho%2Fno-set-env-in-github-workflows-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-781/dscho/no-set-env-in-github-workflows-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/781

 .github/workflows/check-whitespace.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.github/workflows/check-whitespace.yml b/.github/workflows/check-whitespace.yml
index 9d070b9cdf..c74b47de9e 100644
--- a/.github/workflows/check-whitespace.yml
+++ b/.github/workflows/check-whitespace.yml
@@ -14,7 +14,7 @@ jobs:
     steps:
     - name: Set commit count
       shell: bash
-      run: echo "::set-env name=COMMIT_DEPTH::$((1+$COMMITS))"
+      run: echo "COMMIT_DEPTH=$((1+$COMMITS))" >>$GITHUB_ENV
       env:
         COMMITS: ${{ github.event.pull_request.commits }}
 

base-commit: 7f7ebe054af6d831b999d6c2241b9227c4e4e08d
-- 
gitgitgadget
