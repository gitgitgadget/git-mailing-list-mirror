Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F108EC433F5
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 20:36:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF95A61131
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 20:36:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231842AbhIOUhp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Sep 2021 16:37:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231562AbhIOUho (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Sep 2021 16:37:44 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54AEEC061574
        for <git@vger.kernel.org>; Wed, 15 Sep 2021 13:36:20 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id d207-20020a1c1dd8000000b00307e2d1ec1aso2936502wmd.5
        for <git@vger.kernel.org>; Wed, 15 Sep 2021 13:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:mime-version:content-transfer-encoding
         :fcc:to:cc;
        bh=aIZd/EWbk5XcXSptfi98CxE9YH0lT+DV+1vf9DvBDM0=;
        b=elctAtR+Rm/V+cp6IKhWEqfEwcL5+nCG3Wd2niUzuE5eWBq1jjEN7CbfaVpYfFXsFe
         uD64cEb/PfLezorpwCdt0x6YrYy6C7wCCZd4tllxQe1/aFvn1cB90OfrldzMImJP7Q77
         kOzqfFzxYe+vr6RcYSCQxZFa2GUVBhPRjamuek+xKL71BWD3STNFWmUsaeBNuZ7cUZy2
         2na+G/fbfVajdhv8lc55S5oCHn6E8iQX6lF3qgH6rcJhITBNh9UoowLN+OPfRdkQGPC/
         DUlaHaERJ51NFqa7LZFZuhIKShQl3wKK5fFdoxYztlKn14DYUnd3+FzhjN4guRirCawo
         a+Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=aIZd/EWbk5XcXSptfi98CxE9YH0lT+DV+1vf9DvBDM0=;
        b=lPzzrm3oMWBgI99gXAbpVEvj+CxwsQ8A/3gPvw9pomZVpEp7qleDHxRqX3Z1cad9uL
         5t4SMrgPQrBXmhkDvH7wgftXU2xopVwa4yUBFpZ2RvEzSlaq6dCZsGiSeEjd1d/DLY5L
         tQPQ3b8B682tPpdsCxsyf7t5REgKaWBhX5o9k2IXHbG4cda+qDijqpoEgdWMjTG6mdKR
         7LUs/ySlVGEnTBJZInKnndvK8LVtfTzrsQlNL45LQZcoIeacCFNEHMUM3L5L3kYgpgMW
         uLwvlVCQe3xNXGGKF8IkqGXisZ7DU0cM3Z/0D0GGboVr3Mo+0Gjeeps7Az78HdqK58CP
         E7iA==
X-Gm-Message-State: AOAM530Apv1LGdYbnVpYES63/McLWZRJpg5aUw4/xe68VnaidPFJgqRU
        VT5zbFY+g/iyNeXnc/5tpsC60fvMc9o=
X-Google-Smtp-Source: ABdhPJz+8FrDoye6w5wHkGGQrJQC6X8LYfu7AQ8nTHDGZBqdz7bIFQDdbewAynnMxBYy8zYarQIAmQ==
X-Received: by 2002:a05:600c:2259:: with SMTP id a25mr1587336wmm.133.1631738178943;
        Wed, 15 Sep 2021 13:36:18 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v10sm1054142wrg.15.2021.09.15.13.36.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 13:36:18 -0700 (PDT)
Message-Id: <pull.1040.git.1631738177.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 15 Sep 2021 20:36:10 +0000
Subject: [PATCH 0/7] Builtin FSMonitor Part 1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In July I sent the V3 version [3] of my Builtin FSMonitor series [1,2,3].
This has been in "seen" as branch jh/builtin-fsmonitor. At 34 commits, it
was already a little too big to easily review. With the feed back on [3] and
from people using the experimental version that we shipped with
git-for-windows v2.32 and v2.33, I've prepared a new V4 version. This can be
seen in [4].

However, this new version currently contains 58 commits and is way too big
to be submitted as is. So I would like to close or discard the original V3
branch and submit V4 in pieces to make it easier to review.

Here is Part 1 of (what would be V4 of) my Builtin FSMonitor series.

Part 1 contains:

 * A fix for a memory leak in the Trace2 code. (This was independently
   reported in last week in "ab/tr2-leaks-and-fixes".)
 * Various cleanups in the simple-ipc layer.
 * A new start_bg_command() function to launch a command into the background
   and wait for it to start. And a refactored consumer of it in
   test-simple-ipc. There was a large discussion on commit 14/34 in V3 [5
   thru 6] about the large ifdef'd blocks of platform specific code to spawn
   background commands, trace2 handling, and duplicated code in
   fsmonitor--daemon.c and in test-simple-ipc. That has all been addressed
   here.

[1]
https://lore.kernel.org/git/pull.923.git.1617291666.gitgitgadget@gmail.com/
[2]
https://lore.kernel.org/git/pull.923.v2.git.1621691828.gitgitgadget@gmail.com/
[3]
https://lore.kernel.org/git/pull.923.v3.git.1625150864.gitgitgadget@gmail.com/
[4] https://github.com/gitgitgadget/git/pull/923 [5]
https://lore.kernel.org/git/9fe902aad87f1192705fb69ea212a2d066d0286d.1625150864.git.gitgitgadget@gmail.com/
[6] https://lore.kernel.org/git/87tukovidd.fsf@evledraar.gmail.com/

Jeff Hostetler (7):
  trace2: fix memory leak of thread name
  simple-ipc: preparations for supporting binary messages.
  simple-ipc: move definition of ipc_active_state outside of ifdef
  simple-ipc/ipc-win32: add trace2 debugging
  simple-ipc/ipc-win32: add Windows ACL to named pipe
  run-command: create start_bg_command
  t/helper/simple-ipc: convert test-simple-ipc to use start_bg_command

 compat/simple-ipc/ipc-unix-socket.c |  14 +-
 compat/simple-ipc/ipc-win32.c       | 176 +++++++++++++++++++--
 run-command.c                       | 123 +++++++++++++++
 run-command.h                       |  48 ++++++
 simple-ipc.h                        |  21 +--
 t/helper/test-simple-ipc.c          | 227 ++++++++--------------------
 trace2/tr2_tls.c                    |   1 +
 7 files changed, 416 insertions(+), 194 deletions(-)


base-commit: 8b7c11b8668b4e774f81a9f0b4c30144b818f1d1
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1040%2Fjeffhostetler%2Fbuiltin-fsmonitor-part1-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1040/jeffhostetler/builtin-fsmonitor-part1-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1040
-- 
gitgitgadget
