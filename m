Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F3C0F1F461
	for <e@80x24.org>; Wed, 28 Aug 2019 01:43:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726234AbfH1Bnc (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Aug 2019 21:43:32 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38267 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726092AbfH1Bnb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Aug 2019 21:43:31 -0400
Received: by mail-wr1-f67.google.com with SMTP id e16so712526wro.5
        for <git@vger.kernel.org>; Tue, 27 Aug 2019 18:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=/xQ5hiveEufrsTOzPnIELRd5BAxDh0feAgspf3J9rW4=;
        b=ZjcIrA9pp369a8h4o2Yu6QYRK0EVc+iZqZuiwXW2yl/18/ZPZ894gs0P+ZokOyFPkh
         ZCum6/U7exEb/3OkPStPwYD1+gPmJV2SDxNOCgoxK2pEV8lOJePy9XNL7fP0b2JN+xz4
         AhmSwBCguHyRnJGG6yppUG51AjJm24tFmCqI+wzPfdjCCGVBGrC42CGVMqt/wUixD+cq
         kU3r9eQWso9uTAylitA1MWXGAAWGCvGCV9Zas+FIrq3xONL9Qe4qlys9R9fYnH0yNM2O
         UM9rv3O1YcwgFGzYDgbPoTB9/rD8wF0NFzc60sJ3HH0HAQLwwIlfNgdmXmmrQwtWnl/v
         wwhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=/xQ5hiveEufrsTOzPnIELRd5BAxDh0feAgspf3J9rW4=;
        b=nnz/qTxdOUME7VirRcO0EVQK+SzrMZSmC3bQp67K9d1LooHcvrkLZ0swChbmeZJPyA
         BRuf35qNnnqShIm2/tJcpJDekwT8eij7SLXw8RCvge31SQ5EZEl11VNkHtxJnXeleg/W
         AWSb+XmiXRccBqCo7wMfuUlBildy4Qng8pCcYHS7dh/vjLeDPdyRWppYe85AhOJ0eVrq
         FdnVgKmbQxG9+mZYkZrCQDOvsrCHyKQ/s2hsApt6Nj2WYvrKMGAaeiQoldfuwiW2YZS+
         lqpc7FcXwS6V3Ua6vW0V0Bx1aSy+A5zOfAT/dofLAAgoaNpTD47oDG+RGoF0bVFvQaFT
         E2cQ==
X-Gm-Message-State: APjAAAXR6T+S5kaJSr386DWhU0ueMGd81UvRD0kXlnedST4ndIITPEIO
        07urKtNFgG1H3EST+Xnc7y3e9mTI
X-Google-Smtp-Source: APXvYqwFm0VGRod+FPUmI/Clz6GXMeb4j7BdwWI1W+UX9hPY5h1N+bAp6IfhkkGZ5EzWO+wCpyr1oQ==
X-Received: by 2002:a05:6000:4d:: with SMTP id k13mr606971wrx.196.1566956609517;
        Tue, 27 Aug 2019 18:43:29 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s192sm739504wme.17.2019.08.27.18.43.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Aug 2019 18:43:29 -0700 (PDT)
Date:   Tue, 27 Aug 2019 18:43:29 -0700 (PDT)
X-Google-Original-Date: Wed, 28 Aug 2019 01:43:27 GMT
Message-Id: <pull.324.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/1] upload-pack: fix race condition in t5516
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch fixes a strange race condition that was hitting our PR builds on
microsoft/git rather frequently. See [1] for an example.

It was only happening on the MSVC builds, so somehow that compiler/platform
combination was leading to this race condition happening more often than
other platforms. See the commit message for the race condition.

The thing I am worried about is that I replaced a die() statement with an
error() and exit() pair. Is that OK? Or is there a preferred option?

Thanks, -Stolee

[1] https://gvfs.visualstudio.com/ci/_build/results?buildId=16068

Derrick Stolee (1):
  upload-pack: fix race condition in error messages

 upload-pack.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)


base-commit: 5fa0f5238b0cd46cfe7f6fa76c3f526ea98148d9
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-324%2Fderrickstolee%2Ft5516-fix-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-324/derrickstolee/t5516-fix-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/324
-- 
gitgitgadget
