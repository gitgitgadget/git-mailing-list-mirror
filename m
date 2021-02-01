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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1B8CC43381
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 22:03:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B3F064EE3
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 22:03:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbhBAWDI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Feb 2021 17:03:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbhBAWDF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Feb 2021 17:03:05 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE953C061573
        for <git@vger.kernel.org>; Mon,  1 Feb 2021 14:02:24 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id u14so613036wml.4
        for <git@vger.kernel.org>; Mon, 01 Feb 2021 14:02:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=gkuB0zQryIUpMJt2SnR2SHEHgXNtA/ntIXdn9BxB5Jk=;
        b=Zy4Tg7LvytIyVSmLImdBF/pyLi9lDYfmBL9JNIW7OBMa4cP1dZWMt4fpMr1ACVY97J
         RYk2YWbKaPgceumaQJ7/QXrR6Bn/+nozemVhYfQRylPenGNnwKnhZa1yt0eTR+TfDWJW
         UJ8Xfpped2X9c45fGCFQyYlHitHKRvxkU/FaGkJsbvl8Ppiq4Y9YJMLRdMbBeR4XT9x7
         Z5mmdVa9ol18ZPPOqiql1qCsHS/8mX5tIb0vw4tOVgWOzbr63H/b9k2GgmVL7Ftqdzrb
         pE4B5BWeYOB5g6CFRRXwHAKD/nyLLnLAs1DRdzXz7FiF/J/3My/mROESqFZb6Yhe9oA8
         MvYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=gkuB0zQryIUpMJt2SnR2SHEHgXNtA/ntIXdn9BxB5Jk=;
        b=U58OXHp9QahyBE7fUtZG+DhDqntAwzcySwj0z1/oQ9/OSoX18m6g6cZc1+Ony0WaLe
         4lBBa4hmkS+DbZAI3wAuk+yF5SlyGqf/m/L929UVDulFk695Toqy3qQWn1Otkcf4TmJ3
         MEWLwG1irC6W8l/7Zp8cdoJ8LBTV7hOgVyecFGooBKEZxfikUzEO8S8UiBWgjvVjB7zf
         7Yhy5n4TRU3Y58FTFSApAf5lPNMw4DUT3It92JV1B00hZPOEU2XVRd9vB36tmG5WDvhn
         hB9ksm2fquJmweVW0I76xYjZlAkcl6j3WYI5jwXUerpXmN2IAxjOWEDb4dWibxFVDlwg
         nmzQ==
X-Gm-Message-State: AOAM530B5HCAdEpQMYyI3wkLiHwzR5b8sFDC/ttfCHmMOXlUKMbBaCiE
        NTZEGqcjAH7p9N9baEJLGjnusJ/3+uc=
X-Google-Smtp-Source: ABdhPJynESQu3SGWMrJ7Yl/629FscgHgBSGbU3MHcrFEXyLzv53iuPfaWqrRE1ib1YjkVLw2a7JN0g==
X-Received: by 2002:a1c:9dcb:: with SMTP id g194mr782842wme.59.1612216943065;
        Mon, 01 Feb 2021 14:02:23 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u4sm4129402wrr.37.2021.02.01.14.02.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 14:02:22 -0800 (PST)
Message-Id: <pull.860.git.1612216941.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 01 Feb 2021 22:02:09 +0000
Subject: [PATCH 00/11] FSMonitor Preliminary Commits
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series fixes runtime errors in t/perf/p7519 on Windows and MacOS.
It adds Trace2 logging to p7519 to make it easier to compare results when
Watchman is enabled and disabled. And finally, it adds some Trace2 regions
and data events around our usage of Watchman and the existing FSMonitor
framework.

This series is independent of the "Simple IPC" series.

A future series to add a builtin FSMonitor daemon will build upon both of
these series.

Jeff Hostetler (10):
  p7519: use xargs -0 rather than -d in test
  p7519: fix watchman watch-list test on Windows
  p7519: move watchman cleanup earlier in the test
  p7519: add trace logging during perf test
  preload-index: log the number of lstat calls to trace2
  read-cache: log the number of lstat calls to trace2
  read-cache: log the number of scanned files to trace2
  fsmonitor: log invocation of FSMonitor hook to trace2
  fsmonitor: log FSMN token when reading and writing the index
  fsmonitor: refactor initialization of fsmonitor_last_update token

Kevin Willford (1):
  fsmonitor: allow all entries for a folder to be invalidated

 fsmonitor.c               | 107 ++++++++++++++++++++++++++++++++++----
 fsmonitor.h               |   5 ++
 preload-index.c           |  10 ++++
 read-cache.c              |  24 +++++++--
 t/perf/.gitignore         |   1 +
 t/perf/Makefile           |   4 +-
 t/perf/p7519-fsmonitor.sh |  61 ++++++++++++++++++----
 7 files changed, 186 insertions(+), 26 deletions(-)


base-commit: 71ca53e8125e36efbda17293c50027d31681a41f
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-860%2Fjeffhostetler%2Ffsmonitor-prework-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-860/jeffhostetler/fsmonitor-prework-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/860
-- 
gitgitgadget
