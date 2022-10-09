Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8A6CC433F5
	for <git@archiver.kernel.org>; Sun,  9 Oct 2022 14:37:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbiJIOhn (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 9 Oct 2022 10:37:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbiJIOhm (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Oct 2022 10:37:42 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82A572716B
        for <git@vger.kernel.org>; Sun,  9 Oct 2022 07:37:41 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id b4so13681022wrs.1
        for <git@vger.kernel.org>; Sun, 09 Oct 2022 07:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=l7sUcHORGqhabqM6hj2LApuOb7zS90PHfh19mLitghI=;
        b=Jmt4LRikCvrUCaJFR0FRPWeT06rJVf10OH8o9G1aHnfxyiJ1CLp6DP2vw9GsYsLuXb
         gl8UuPoHaf85EclnTzuF89kKloI0vjdyahKdok7CQD3zaOVTFXsJNAtoI4ZEPx1AX2y5
         p1UtLc4AgWDtcIu8YiRyRy2fAtF8h4QGaYb5Yo/uNQtVffKbfeNuMz0Vf/i8TPjCra0E
         33STyU9Knad7r2SR97e06ywJFmY/7pxrHzfiZXr2YH+7QHc7xa1pzK8SXkS6Zlq49gH9
         EW2pYP8vmq56AwrV+vLHoLpJlJ51+Cti3B/wsR520EFwlK5NPnm3rdbj0escnaKWkByv
         7v1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l7sUcHORGqhabqM6hj2LApuOb7zS90PHfh19mLitghI=;
        b=oGWa7YqTl6xJgkfylwpCF0pv8ZeQ0paaM4XYsoa5bMVdYRjjbXlyAUviXyfTM8SHjg
         WsddgflepwJkV7JZwQ7dRNhxmd649EPVuCID0yLW90iMQ9iqGFc+oaSBHbECfn44klco
         7bbmSa4AbGl2KrwCvBM0S/GD5RHUEApxgSzz+LiszXLnRs3eNb9lqH2EuodZqpLoCI0Y
         cpi1+5/xUdu9wnCmETUOarajRlELXDNsWgVUVvY0VeL6gWGaDieLbBgF/cxE5AMSZtwf
         WK/Y7Rqx2+wSz5Djpf0ss5lp4yk/wdlcV+lj8ZoYCjvtoQHnRabG4xpnqtJvKVTHZLoa
         dJxg==
X-Gm-Message-State: ACrzQf1117CAD5UhSbxTR1GxIX9cfDgtfgM433X3So6gl7VcDwb2HVRE
        IoCJ/PQv3iHnJaVCFZw9mpQlSk3FRXc=
X-Google-Smtp-Source: AMsMyM70hWzKB7qyQdJHC1a3e2gelqeRyY77tdudZDz7ZlWkmDQoz5g2s933a3fU4dmnWp4y2VEBag==
X-Received: by 2002:a05:6000:1845:b0:22f:bfca:6439 with SMTP id c5-20020a056000184500b0022fbfca6439mr3334521wri.298.1665326259764;
        Sun, 09 Oct 2022 07:37:39 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z12-20020a05600c0a0c00b003b497138093sm7952360wmp.47.2022.10.09.07.37.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Oct 2022 07:37:39 -0700 (PDT)
Message-Id: <pull.1352.git.git.1665326258.gitgitgadget@gmail.com>
From:   "Eric DeCosta via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 09 Oct 2022 14:37:26 +0000
Subject: [PATCH 00/12] fsmonitor: Implement fsmonitor for Linux
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric DeCosta <edecosta@mathworks.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Goal is to deliver fsmonitor for Linux that is on par with fsmonitor for
Windows and Mac OS.

This patch set builds upon previous work for done for Windows and Mac OS
(first 6 patches) to implement a fsmonitor back-end for Linux based on the
Linux inotify API. inotify differs significantly from the equivalent Windows
and Mac OS APIs in that a watch must be registered for every directory of
interest (rather than a singular watch at the root of the directory tree)
and special care must be taken to handle directory renames correctly.

More information about inotify:
https://man7.org/linux/man-pages/man7/inotify.7.html

Eric DeCosta (12):
  fsmonitor: refactor filesystem checks to common interface
  fsmonitor: relocate socket file if .git directory is remote
  fsmonitor: avoid socket location check if using hook
  fsmonitor: deal with synthetic firmlinks on macOS
  fsmonitor: check for compatability before communicating with fsmonitor
  fsmonitor: add documentation for allowRemote and socketDir options
  fsmonitor: prepare to share code between Mac OS and Linux
  fsmonitor: determine if filesystem is local or remote
  fsmonitor: implement filesystem change listener for Linux
  fsmonitor: enable fsmonitor for Linux
  fsmonitor: test updates
  fsmonitor: update doc for Linux

 Documentation/config.txt                      |   2 +
 Documentation/config/fsmonitor--daemon.txt    |  11 +
 Documentation/git-fsmonitor--daemon.txt       |  45 +-
 Makefile                                      |   6 +-
 builtin/fsmonitor--daemon.c                   |  11 +-
 ...{fsm-health-darwin.c => fsm-health-unix.c} |   0
 compat/fsmonitor/fsm-ipc-unix.c               |  52 ++
 compat/fsmonitor/fsm-ipc-win32.c              |   9 +
 compat/fsmonitor/fsm-listen-darwin.c          |  14 +-
 compat/fsmonitor/fsm-listen-linux.c           | 664 ++++++++++++++++++
 compat/fsmonitor/fsm-path-utils-darwin.c      | 135 ++++
 compat/fsmonitor/fsm-path-utils-linux.c       | 163 +++++
 compat/fsmonitor/fsm-path-utils-win32.c       | 145 ++++
 compat/fsmonitor/fsm-settings-darwin.c        |  89 ---
 compat/fsmonitor/fsm-settings-unix.c          |  62 ++
 compat/fsmonitor/fsm-settings-win32.c         | 174 +----
 config.mak.uname                              |  13 +
 contrib/buildsystems/CMakeLists.txt           |  19 +-
 fsmonitor--daemon.h                           |   3 +
 fsmonitor-ipc.c                               |  18 +-
 fsmonitor-ipc.h                               |   4 +-
 fsmonitor-path-utils.h                        |  60 ++
 fsmonitor-settings.c                          |  68 +-
 fsmonitor-settings.h                          |   4 +-
 fsmonitor.c                                   |   7 +
 t/t7527-builtin-fsmonitor.sh                  |  58 +-
 26 files changed, 1531 insertions(+), 305 deletions(-)
 create mode 100644 Documentation/config/fsmonitor--daemon.txt
 rename compat/fsmonitor/{fsm-health-darwin.c => fsm-health-unix.c} (100%)
 create mode 100644 compat/fsmonitor/fsm-ipc-unix.c
 create mode 100644 compat/fsmonitor/fsm-ipc-win32.c
 create mode 100644 compat/fsmonitor/fsm-listen-linux.c
 create mode 100644 compat/fsmonitor/fsm-path-utils-darwin.c
 create mode 100644 compat/fsmonitor/fsm-path-utils-linux.c
 create mode 100644 compat/fsmonitor/fsm-path-utils-win32.c
 delete mode 100644 compat/fsmonitor/fsm-settings-darwin.c
 create mode 100644 compat/fsmonitor/fsm-settings-unix.c
 create mode 100644 fsmonitor-path-utils.h


base-commit: 3dcec76d9df911ed8321007b1d197c1a206dc164
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1352%2Fedecosta-mw%2Ffsmonitor_linux-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1352/edecosta-mw/fsmonitor_linux-v1
Pull-Request: https://github.com/git/git/pull/1352
-- 
gitgitgadget
