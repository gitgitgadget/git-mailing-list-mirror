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
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADEFBC432BE
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 17:08:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9304460FD9
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 17:08:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231702AbhHQRJW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Aug 2021 13:09:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbhHQRJV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Aug 2021 13:09:21 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85734C061764
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 10:08:47 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id u15so14163290wmj.1
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 10:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=7ZrN0iJuOk9dEu2SGonTeXjjCQ1khfUo/WCaGmiQP/8=;
        b=T2/hR8agc5BNSR2gsnrThvpNU3M7QTLAOIuJrvW+jrwftm50bmLrIkH+pjCO0YV61H
         J/Oe3r5bLN+wkbbtEIy3lrj1idU+kJx84CbSHZlwtIaBYVr0vu03hE3eYDdYiHX98m/9
         SNbh/nhmQGJYIBtDRjRIZoEQlPEkjzv+rXFD8Va5SqD5RteOWJ+Xz5/zT7lHUT1YPBnr
         XwsprhkGS3yRFYkQmwwzvQMxuiwhtwycWYqM7CCEJ+uZZox7mxtxVGA1955kFcQuCRPT
         ouVqIuabW9+JHwpkwZCPIrWk38zkGW7Jl+sufrnqMBzjzDuw+Zk/H5a05Tx+s4gYNjUz
         MoBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=7ZrN0iJuOk9dEu2SGonTeXjjCQ1khfUo/WCaGmiQP/8=;
        b=c4Zzt7hOB/TcmkZjcZoer8GY75aHU8xVVtyoBF8g2avvZ96Z2PsVcqeb83SBgvv/jt
         /zfJ4SdNEVgl8Zotp0apZ8wtW5tmORPcu5wANE9T8jf2YLEfczPkSVSyWLJYtzX5X/Ku
         bRuHoTVEKhzuX4wa3d0C3zowfLtbfQzL0poHLhJKzMGwl9VaCT+dHIZ6vV8bnaNpkvY9
         kAuFLkJrsmq5wHp9zEznzvsepenD96l3yb72CnBB10YE+YpvrYz2rTH/BO1nZvbRLF1Q
         4OHBVEJq3E74Z7NePr0C8ZnAUQHhZmnDR/yvismKHCxrbEdQRuHuAQKcc4/Ye2mJb31E
         Rs/A==
X-Gm-Message-State: AOAM5332oSwC9jxm3NHW4oZ6GDn+dXK/zhtRucmIkNb3VoSWFGFPzoNh
        HPllaUzZ/8j2ovMHCtw5B2gz8bL8g00=
X-Google-Smtp-Source: ABdhPJwB9ehERH9GmCtRrSV39lqFiiml1F6EDNW2F3mzTHJkLokkF3g8P+Bu1mB/HafmJSTX0tL4fQ==
X-Received: by 2002:a1c:3c8b:: with SMTP id j133mr4482208wma.9.1629220125745;
        Tue, 17 Aug 2021 10:08:45 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a9sm3179507wrv.37.2021.08.17.10.08.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 10:08:45 -0700 (PDT)
Message-Id: <pull.1019.git.1629220124.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 17 Aug 2021 17:08:38 +0000
Subject: [PATCH 0/6] Sparse Index: Integrate with merge, cherry-pick, rebase, and revert
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, stolee@gmail.com, gitster@pobox.com,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series integrates the sparse index with commands that perform merges
such as 'git merge', 'git cherry-pick', 'git revert' (free with
cherry-pick), and 'git rebase'.

When the ORT merge strategy is enabled, this allows most merges to succeed
without expanding the sparse index, leading to significant performance
gains. I tested these changes against an internal monorepo with over 2
million paths at HEAD but with a sparse-checkout that only has ~60,000 files
within the sparse-checkout cone. 'git merge' commands went from 5-6 seconds
to 0.750-1.250s.

In the case of the recursive merge strategy, the sparse index is expanded
before the recursive algorithm proceeds. We expect that this is as good as
we can get with that strategy. When the strategy shifts to ORT as the
default, then this will not be a problem except for users who decide to
change the behavior.

Most of the hard work was done by previous series, such as
ds/sparse-index-ignored-files (which this series is based on).

Thanks, -Stolee

Derrick Stolee (6):
  t1092: use ORT merge strategy
  diff: ignore sparse paths in diffstat
  merge: make sparse-aware with ORT
  merge-ort: expand only for out-of-cone conflicts
  t1092: add cherry-pick, rebase tests
  sparse-index: integrate with cherry-pick and rebase

 builtin/merge.c                          |  3 +
 builtin/rebase.c                         |  6 ++
 builtin/revert.c                         |  3 +
 diff.c                                   |  8 ++
 merge-ort.c                              | 16 ++++
 merge-recursive.c                        |  3 +
 t/t1092-sparse-checkout-compatibility.sh | 97 +++++++++++++++++++++---
 7 files changed, 124 insertions(+), 12 deletions(-)


base-commit: febef675f051eb08896751bb5661b6deb5579ead
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1019%2Fderrickstolee%2Fsparse-index%2Fmerge-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1019/derrickstolee/sparse-index/merge-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1019
-- 
gitgitgadget
