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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B260CC43461
	for <git@archiver.kernel.org>; Thu,  1 Apr 2021 17:53:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89D4F60FE7
	for <git@archiver.kernel.org>; Thu,  1 Apr 2021 17:53:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235992AbhDARxj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Apr 2021 13:53:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237115AbhDARu3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Apr 2021 13:50:29 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AD69C0225B6
        for <git@vger.kernel.org>; Thu,  1 Apr 2021 08:41:09 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id r10-20020a05600c35cab029010c946c95easo1125120wmq.4
        for <git@vger.kernel.org>; Thu, 01 Apr 2021 08:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=3Kk8P0xGmYMSICptG08X1DReL3mgWDP7cL7nRL1Yphk=;
        b=QqG8IIrFAwCI/Z7Ioi9DczwnOwSznyZWyo3bjTblVjMFbSIgcH7dAVIbO6pLvBoPEg
         wzmy392DQ/t6We7w2sylfhQSJQaS/Z5HoV3yu765UJAPZjonTB9xKriee/mC+Wo5TDVc
         65+XFoyIE/REP1JAq8ep0BHu8NvuIickuB/vvjRL9/CxalLdirjUp7baQbZHfgdiU9j3
         mytRWboP62gvDoEhU+GMSOrrAHjBdFlPZFH9vlOVj8DLZyQRwlIEv8wfNA75xayxFkVV
         9TJSNtw8wDr8Ka5PibefoSHRCODQEaou8hH+sF9TA8CN6tBiZQhVxE3f3RE0nHaYWRsW
         Yspg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=3Kk8P0xGmYMSICptG08X1DReL3mgWDP7cL7nRL1Yphk=;
        b=fr0hflKTDhoh98u3cs+XXA7P8udTY2m832UNHz7bkzcNG0pxumAgNoFab6tDZbLJQQ
         dJvRbseBWv9glnnP/o5MG3aqCWwaafYjTzmfWJ3aVKqcv8Vn2HB4IoGYdB+6Z5cnXpaO
         y03viQJdDCBbPKqbSZ1Nei9a6E8U4RpPmDzssllcpFG64fWEDr77VjkALlyq/AwmW2D3
         ISnV3NFtg6WXb9KxnGWPVLHfbXGsy/OT7jyFrLu5hdlPScvFzHuJTFJq+dUoJpGRJM4O
         troz3vjILk966e05d55s2bVhsTWpBJrAjspsoKQeZZTPO+l1124cqBltdNESUCf5fKsg
         pqJg==
X-Gm-Message-State: AOAM530eGYyACPdko39R2AObmzKiaKGZUHWocNIVDEg7OFlFw41SO0FW
        i3lWg4N8PM5Xfgu5fzSOwQ6KSBTiod4=
X-Google-Smtp-Source: ABdhPJziMMBJw9NgUjZR/nVPodl1PHFI4dyxfWeRPqkvjKiNnPzbiNxiLTEG8/COLCHVuDMcXEcmJQ==
X-Received: by 2002:a1c:544f:: with SMTP id p15mr8574728wmi.158.1617291667971;
        Thu, 01 Apr 2021 08:41:07 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t1sm12266847wry.90.2021.04.01.08.41.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 08:41:07 -0700 (PDT)
Message-Id: <pull.923.git.1617291666.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 01 Apr 2021 15:40:42 +0000
Subject: [PATCH 00/23] [RFC] Builtin FSMonitor Feature
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series adds a builtin FSMonitor daemon to Git.

This daemon uses platform-specific filesystem notifications to keep track of
changes to a working directory. It also listens over the "Simple IPC"
facility for client requests and responds with a list of files/directories
that have been recently modified.

Client commands, such as git status, already know how to request a list of
modified files via the FSMonitor Hook. This patch series teaches client
commands to talk directly to the daemon via IPC and avoid the overhead of
the hook API. (Hook process creation can be expensive on Windows.)

Since the daemon is a feature of Git, rather than a generic third-party tool
like Watchman, the daemon can format its response to be exactly what the
client needs, so there is no need for a hook process to proxy and reformat
the data. For example, when Watchman is used, Watchman responds in JSON and
the hook process (typically a PERL script) must parse it and convert it into
a simple NUL-delimited list. FSMonitor daemon responses are already in this
NUL-delimited format, so no processing is required.

The current daemon implementation is rather simple in that it just records
the set of files/directories that have changed. For example, it is not aware
of specific Git features, such as .gitignore and doesn't attempt to filter
out ignored files. Having a Git-specific daemon lets us explore such things
in the future.

Finally, having a builtin daemon eliminates the need for user to download
and install a third-party tool. This makes enterprise deployments simpler
since there are fewer parts to install, maintain, and updates to track.

This RFC version includes support for Windows and MacOS file system events.
A Linux version will be submitted in a later patch series.

This patch series is being previewed as an experimental feature in Git for
Windows v2.31.0.windows.1.

This patch series requires the jh/simple-ipc and jh/fsmonitor-prework patch
series.

Jeff Hostetler (21):
  fsmonitor--daemon: man page and documentation
  fsmonitor-ipc: create client routines for git-fsmonitor--daemon
  fsmonitor--daemon: add a built-in fsmonitor daemon
  fsmonitor--daemon: implement client command options
  fsmonitor-fs-listen-win32: stub in backend for Windows
  fsmonitor-fs-listen-macos: stub in backend for MacOS
  fsmonitor--daemon: implement daemon command options
  fsmonitor--daemon: add pathname classification
  fsmonitor--daemon: define token-ids
  fsmonitor--daemon: create token-based changed path cache
  fsmonitor-fs-listen-win32: implement FSMonitor backend on Windows
  fsmonitor-fs-listen-macos: add macos header files for FSEvent
  fsmonitor-fs-listen-macos: implement FSEvent listener on MacOS
  fsmonitor--daemon: implement handle_client callback
  fsmonitor--daemon: periodically truncate list of modified files
  fsmonitor--daemon:: introduce client delay for testing
  fsmonitor--daemon: use a cookie file to sync with file system
  fsmonitor: force update index when fsmonitor token advances
  t7527: create test for fsmonitor--daemon
  p7519: add fsmonitor--daemon
  t7527: test status with untracked-cache and fsmonitor--daemon

Johannes Schindelin (2):
  config: FSMonitor is repository-specific
  fsmonitor: introduce `core.useBuiltinFSMonitor` to call the daemon via
    IPC

 .gitignore                                   |    1 +
 Documentation/config/core.txt                |   45 +-
 Documentation/git-fsmonitor--daemon.txt      |  104 ++
 Documentation/git-update-index.txt           |    4 +-
 Documentation/githooks.txt                   |    3 +-
 Makefile                                     |   15 +
 builtin.h                                    |    1 +
 builtin/fsmonitor--daemon.c                  | 1611 ++++++++++++++++++
 builtin/update-index.c                       |    4 +-
 compat/fsmonitor/fsmonitor-fs-listen-macos.c |  484 ++++++
 compat/fsmonitor/fsmonitor-fs-listen-win32.c |  514 ++++++
 compat/fsmonitor/fsmonitor-fs-listen.h       |   49 +
 config.c                                     |    9 +-
 config.h                                     |    2 +-
 config.mak.uname                             |    4 +
 contrib/buildsystems/CMakeLists.txt          |    8 +
 fsmonitor--daemon.h                          |  142 ++
 fsmonitor-ipc.c                              |  153 ++
 fsmonitor-ipc.h                              |   48 +
 fsmonitor.c                                  |   32 +-
 git.c                                        |    1 +
 help.c                                       |    4 +
 repo-settings.c                              |    3 +
 repository.h                                 |    2 +
 t/perf/p7519-fsmonitor.sh                    |   37 +-
 t/t7527-builtin-fsmonitor.sh                 |  582 +++++++
 26 files changed, 3839 insertions(+), 23 deletions(-)
 create mode 100644 Documentation/git-fsmonitor--daemon.txt
 create mode 100644 builtin/fsmonitor--daemon.c
 create mode 100644 compat/fsmonitor/fsmonitor-fs-listen-macos.c
 create mode 100644 compat/fsmonitor/fsmonitor-fs-listen-win32.c
 create mode 100644 compat/fsmonitor/fsmonitor-fs-listen.h
 create mode 100644 fsmonitor--daemon.h
 create mode 100644 fsmonitor-ipc.c
 create mode 100644 fsmonitor-ipc.h
 create mode 100755 t/t7527-builtin-fsmonitor.sh


base-commit: f1725819714fbcd96c47ae5f14e00cc01045272f
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-923%2Fjeffhostetler%2Fbuiltin-fsmonitor-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-923/jeffhostetler/builtin-fsmonitor-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/923
-- 
gitgitgadget
