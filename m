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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C9A7C433E0
	for <git@archiver.kernel.org>; Sun, 14 Mar 2021 22:18:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0221464E7A
	for <git@archiver.kernel.org>; Sun, 14 Mar 2021 22:18:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbhCNWRr (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Mar 2021 18:17:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbhCNWRl (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Mar 2021 18:17:41 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3CBDC061574
        for <git@vger.kernel.org>; Sun, 14 Mar 2021 15:17:40 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id x13so4761153wrs.9
        for <git@vger.kernel.org>; Sun, 14 Mar 2021 15:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=eZPsKfLX0AeKZmE6ksG7UArc1HpEP8976UrGPbQ12i8=;
        b=BEKbWmfqo+fm0PLyGZc6u/WQvaFtBe0GXt+EH6eMmXL20bI8Nq9iSXJfNoMKQ3LWTz
         uMtAY7gjKLo97eD+2qjS7p8Yn8vopGQXRS3a7hmCzrV3saKD0XY89Xw4ZczJRqiDxkKa
         KIHKvXPKx34pI5nvyxrQNVISSDRm71t5oLERT1at8qKoNHLWDc8LPzNTcN4MdW2gHCXH
         jo4hvmzgNBjznEGSJX3GuzvTK5LffjPiGdhES2itXdMQwg4ujm+KgfsB/XrniUnATVBb
         ey9lPJMVVIgAK6RJUNMVauKqONcgZd8cU5ckStzX/fL0R08rOTGusB2we4maC9uhCzfr
         QtiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=eZPsKfLX0AeKZmE6ksG7UArc1HpEP8976UrGPbQ12i8=;
        b=nzY2hpSavgNvUPefunaLI28179fMucVtKmveIKVq4I1kgX7rRDUvWqcPUocfHwJBlW
         hlftqn6uYfahFps7uArqg6XO9gWenwcPISQifeHhYWln3mWW44KedOCOmnrompphgoau
         xvmDMVOM1OQ7qqSg6FDgCDe+PmLtN7BgK5VXq018B3yi+os4H2wVBPzJZ98sAJFcj78I
         g0K2onB9Q32rDMJZn+h9/lY9UH/RtOYNhd06CMuUO6e3xEULoA2aImT9Jp3IPNQK7mJf
         5FV/78sJ+uzB11UtJGKlBH6Zzs8MGRY1nBjyGRKOVnmyjLbAY/8w8iRtL4ynWS5kSghP
         +h8w==
X-Gm-Message-State: AOAM5328Q8SGX0iWH8PPVnoUM6WBMv6BTlIpjZgcnHi+kkkVHHWK5Gl1
        a/dMGnmSDywr8+HzWuNfFz8zj1RmXmA=
X-Google-Smtp-Source: ABdhPJxPmZh3zVnKnyMNEZXUrEA7HM+B5IrllwZ6i7/Zp4k25pCQGCpEB3xbF0zpPmBXfS9exREa7Q==
X-Received: by 2002:adf:f78f:: with SMTP id q15mr23972950wrp.383.1615760259417;
        Sun, 14 Mar 2021 15:17:39 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m132sm10070867wmf.45.2021.03.14.15.17.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Mar 2021 15:17:38 -0700 (PDT)
Message-Id: <pull.903.git.1615760258.gitgitgadget@gmail.com>
From:   "Nipunn Koorapati via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 14 Mar 2021 22:17:34 +0000
Subject: [PATCH 0/3] teach git to respect fsmonitor in diff-index
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Nipunn Koorapati <nipunn1313@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Skip lstat deletion check during git diff-index (similar to how it already
does so in git diff-files). Add perf benchmark for this case. Add assert for
guaranteeing that fsmonitor is refreshed in this case.

Nipunn Koorapati (3):
  fsmonitor: skip lstat deletion check during git diff-index
  fsmonitor: add assertion that fsmonitor is valid to check_removed
  fsmonitor: add perf test for git diff HEAD

 diff-lib.c                | 23 +++++++++++++++--------
 fsmonitor.h               | 11 +++++++++++
 t/helper/test-chmtime.c   |  3 ++-
 t/perf/p7519-fsmonitor.sh |  4 ++++
 4 files changed, 32 insertions(+), 9 deletions(-)


base-commit: 13d7ab6b5d7929825b626f050b62a11241ea4945
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-903%2Fnipunn1313%2Fnk%2Ffsmonitor-in-diff-index-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-903/nipunn1313/nk/fsmonitor-in-diff-index-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/903
-- 
gitgitgadget
