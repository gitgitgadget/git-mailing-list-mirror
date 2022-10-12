Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9424CC433FE
	for <git@archiver.kernel.org>; Wed, 12 Oct 2022 19:43:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbiJLTnk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Oct 2022 15:43:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiJLTni (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2022 15:43:38 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B18678237
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 12:43:37 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id v130-20020a1cac88000000b003bcde03bd44so1796445wme.5
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 12:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6NhInPNZb+BXFIzGLw1qHMpBxAKg8iOP4fAewvtYhOo=;
        b=h3s5e046NBL6eLrYZ81ht1hQ62+p2VFLdlJ1deh6uyvFZ9QzegsD+ejRYyWOTISoGe
         OXEVr8uM5o/h6GQ9Ao06xbnDF2sbqnWQdhO9sD5MUd4Dyt3z/4kSOc67wCRbzAWYINq2
         Ub/6mCt1mRvRt5U4TOhhAkIsauK6ODMyffpXt7n3Bo7cqCEFipbmeax13B+Pyg/tUu3H
         VweTGElf4JqaS2HLyoXZ0eduJnL1DUm5ubmikxVmrDGzajrMwpGjPv+LWemqapnhIBZR
         l3Anz0oqBPTXi4E/HbA55QwHgvvzNv9EgXDWNdQFnU5FYKWgRT9fr1LtyjqIyn4Z7FdG
         V/XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6NhInPNZb+BXFIzGLw1qHMpBxAKg8iOP4fAewvtYhOo=;
        b=TRvsRMTxV2esI6OAX1Zt4LWoNX8R/5LRfNcd070/xBST19ROtnaAVBDCsHN6rRBv5N
         R2UmcQt9/nI5WwmFRfBchc7WtgPzVFUASgYe/xskVeGTZsB+/jpWGwuYhDVrTK8ERs90
         WgC7rT7kU25RTjHwtZhIZ2xxO9fnuCWhjHpEuhrDGfE5K7BffUB3+qFRqInXOptY4zBB
         yZXBgLWxT4INYR1Ni8OZuBfYswG575zCVFtohkzwlunVnel+ebtxGtU5x8wU235b+lxL
         l96UvbwkwV+OH0IbgFaq9uLB81a5A+EbHYgc84CPlnZdftHfgOhTU4oP3txly/r+NhX1
         NoEw==
X-Gm-Message-State: ACrzQf1IxljoeKBmjiHbfwjZMc3Lk57yWpj0FrdrJB7PvJ0xE5lqI0nc
        3jIcjMyf05B+clN5qYizvYckF4KJNFQ=
X-Google-Smtp-Source: AMsMyM7XC4XNg0Kt4eUiWnbvASTICkwhaz+tYID7HmK7/sfpheTdaQy5f+xhmYsfxNqt49lOp7fOlA==
X-Received: by 2002:a05:600c:4e51:b0:3c0:55e0:7719 with SMTP id e17-20020a05600c4e5100b003c055e07719mr3992882wmq.3.1665603815871;
        Wed, 12 Oct 2022 12:43:35 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c15-20020a05600c0acf00b003bfaba19a8fsm2420700wmr.35.2022.10.12.12.43.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 12:43:35 -0700 (PDT)
Message-Id: <pull.1360.git.git.1665603814.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 12 Oct 2022 19:43:32 +0000
Subject: [PATCH 0/2] [2.38 regression] config: respect includes in protected config
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here's a fix for the regression reported in [1]. I'm quite confident that
the test suite is extensive enough to catch any unintended behavioral
changes, but I'd appreciate a second opinion.

Cc: Derrick Stolee derrickstolee@github.com, Taylor Blau me@ttaylorr.com,
Johannes Schindelin Johannes.Schindelin@gmx.de, Junio C Hamano
gitster@pobox.com

[1]
https://lore.kernel.org/git/CAPWNY8W_Tr-WoD-GXBddD5Y8w5Y4w+gDNYQdOAJ1uBwVHuRrsQ@mail.gmail.com

Glen Choo (2):
  t0033, t0035: test for included config
  config: respect includes in protected config

 config.c                        | 30 ++++++++----------------------
 t/t0033-safe-directory.sh       |  9 +++++++++
 t/t0035-safe-bare-repository.sh |  9 +++++++++
 3 files changed, 26 insertions(+), 22 deletions(-)


base-commit: 3dcec76d9df911ed8321007b1d197c1a206dc164
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1360%2Fchooglen%2Fprotected-config%2Frespect-includes-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1360/chooglen/protected-config/respect-includes-v1
Pull-Request: https://github.com/git/git/pull/1360
-- 
gitgitgadget
