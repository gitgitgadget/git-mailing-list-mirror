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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AC4AC433F5
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 19:54:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31EA161108
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 19:54:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235640AbhIPTzs (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Sep 2021 15:55:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235582AbhIPTzr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Sep 2021 15:55:47 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46AB1C061766
        for <git@vger.kernel.org>; Thu, 16 Sep 2021 12:54:26 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id t8so4332553wri.1
        for <git@vger.kernel.org>; Thu, 16 Sep 2021 12:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=43+Eay0aOB1QH/WKO9hYLfPFIAj4NfseEL11uL+So5w=;
        b=gxYjDWcDK0+mkfc6TNlJ8wI833eJEq9ZjtOUsdS/CoeoNJNRmwvgLyZC6vjOzbBj4T
         Qz+hPhiFdg/6wG42UpW3OD8LLQbPkOLT51p03IDDi2l2cZRzQWD5Tkm+Bco3Ka5iu4E3
         0FF/Str/ji332yPcirp+QsQQpDin9hNP5yepXPJm/pRHpLFY2O0f0jNchTDoiv9B8zko
         c/Jd3hsW4pNslVCKIJF7Myr81pbOGyYucHLG3l0ywQ54qulHeUIotCaacj4sB4rDzr/v
         dv1UXcI06Icv0Rn0cbZWkJvVXlBAN63RL5oX90drPphbSZ6qkp9dIy1x6i/1X8gwm92v
         lO8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=43+Eay0aOB1QH/WKO9hYLfPFIAj4NfseEL11uL+So5w=;
        b=Dy84fWXGD/7PeSv4rhyzeW29m0VX1WtF4VNtXf90qxwCbAd6Y5qCX9sXeW0vFtoICI
         vN9IR/LPFRAkKqKZ6nyzvPtBUjCuau2p6UUwiYqOmFV6XqYLpvIcVk4f13mPU0Q4/pCE
         MzftMLISRB5PZhb+hts5VciNurf1AzVj4c7lMrOYCJrXjapWkxoVlvh7Jr4+5ak69QEd
         gr31mRvXTj1eHSzLaO9pCXFZWlZAdAOSUqzMykOQKTtnfhGoKB0vyn2SJ0MZQByCzp32
         +dnS05URvZA1HW90b5PpFB2r/zhCSHJC9kkwUV+SOykLlRM35ow+PAW/CuDlxaobBcwX
         bzLg==
X-Gm-Message-State: AOAM532+XKgxdgm1UEoJao8OTd3VBgmuXDFU9CzKK8X6yGI0RXZ/tFX2
        4adDNRIcppty5tZsZHyz93x/2ppdgEw=
X-Google-Smtp-Source: ABdhPJx2evevDhS/fPEFw+3LUyZ0bubC/9YK0N8/SyFz/rJted/7axrtjvUCRRuZVl1Mh4AflA+t8g==
X-Received: by 2002:adf:c10b:: with SMTP id r11mr8111664wre.336.1631822064962;
        Thu, 16 Sep 2021 12:54:24 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v185sm3126518wme.15.2021.09.16.12.54.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 12:54:24 -0700 (PDT)
Message-Id: <pull.1041.git.1631822063.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 16 Sep 2021 19:54:18 +0000
Subject: [PATCH 0/5] Builtin FSMonitor Part 2
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here is Part 2 of my Builtin FSMonitor series. Part 2 requires
jh/builtin-fsmonitor-part1 be present.

Part 2 contains:

 * Client-side code to connect to a (yet to be developed) FSMonitor daemon
   over simple IPC (using Named Pipes or Unix Domain Sockets).
 * Updated config settings to allow the client to decide whether to use
   Simple IPC or the existing FSMonitor Hook API.

The original FSMonitor feature "e05336bdda (Merge branch 'bp/fsmonitor',
2017-11-21)" consisted of two parts:

 1. Client code: 1.1. Called by commands like git status 1.2. Uses the Hook
    API to spawn and talk to a shell or perl script (usually) 1.3. Receives
    a list of recently modified files and/or directories 1.4. Updates flags
    and/or loops in various algorithms to avoid unnecessary lstat() calls on
    unchanged ones.

 2. Hook code: 2.1. A hook process, spawned by each client command, talks to
    a long-running FS monitoring process. 2.2. A long-running FS monitoring
    process, usually Watchman. 2.3. The hook process acts as a relay to
    translate requests responses from Watchman back to the client command.

The Builtin FSMonitor feature extends step 1.2 and allows clients to
communicate directly with a FS daemon process using Simple IPC. The daemon
response is then processed as before in step 1.3.

Part 2 contains these client-side changes for IPC. A builtin FSMonitor
daemon will be added in a later patch series.

Jeff Hostetler (5):
  fsmonitor: enhance existing comments
  fsmonitor-ipc: create client routines for git-fsmonitor--daemon
  fsmonitor: config settings are repository-specific
  fsmonitor: use IPC to query the builtin FSMonitor daemon
  fsmonitor: update fsmonitor config documentation

 Documentation/config/core.txt      |  56 ++++++---
 Documentation/git-update-index.txt |  27 +++--
 Documentation/githooks.txt         |   3 +-
 Makefile                           |   2 +
 builtin/update-index.c             |  19 +++-
 cache.h                            |   1 -
 config.c                           |  14 ---
 config.h                           |   1 -
 environment.c                      |   1 -
 fsmonitor-ipc.c                    | 176 +++++++++++++++++++++++++++++
 fsmonitor-ipc.h                    |  48 ++++++++
 fsmonitor-settings.c               |  97 ++++++++++++++++
 fsmonitor-settings.h               |  21 ++++
 fsmonitor.c                        | 130 +++++++++++++++------
 fsmonitor.h                        |  18 ++-
 repo-settings.c                    |   2 +
 repository.h                       |   3 +
 t/README                           |   4 +-
 18 files changed, 538 insertions(+), 85 deletions(-)
 create mode 100644 fsmonitor-ipc.c
 create mode 100644 fsmonitor-ipc.h
 create mode 100644 fsmonitor-settings.c
 create mode 100644 fsmonitor-settings.h


base-commit: 8b7c11b8668b4e774f81a9f0b4c30144b818f1d1
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1041%2Fjeffhostetler%2Fbuiltin-fsmonitor-part2-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1041/jeffhostetler/builtin-fsmonitor-part2-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1041
-- 
gitgitgadget
