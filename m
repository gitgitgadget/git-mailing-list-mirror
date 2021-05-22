Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96D09C4707F
	for <git@archiver.kernel.org>; Sat, 22 May 2021 13:57:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6449961164
	for <git@archiver.kernel.org>; Sat, 22 May 2021 13:57:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231217AbhEVN6o (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 May 2021 09:58:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231145AbhEVN6k (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 May 2021 09:58:40 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7268FC06138A
        for <git@vger.kernel.org>; Sat, 22 May 2021 06:57:14 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id u5-20020a7bc0450000b02901480e40338bso8001762wmc.1
        for <git@vger.kernel.org>; Sat, 22 May 2021 06:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=nEno5dyXB2NW83I3J+lwqaUg3YFCubxEimgqNumKFIo=;
        b=FZSkLJRh52fhvd3nqNsej4v8oS/nLUJ8N4I3/Qm4EScg9A94uZbUgtoHV0OHDeYAYK
         X6HKetTOCQPJiOANBQCGeC/sFEceHR1OH3esZG4dzrJDLjqJygZ48dVnHmBX5auBQWiG
         kv5rmQ3OO9yTuAdOLlkAHtCt/RfJhcHgIsuoy/0a9s5PahDu90GPEu5vKC4qjLgpEFG9
         BNCNUES1/ieEvWZmg4IpyK1ZJkBDiYM/Rt3nf6WNgEsOPeRQdn6gJOQNSyLllNGtzy9Q
         hg75zO3iRbTYDIzlCG5Q+Wdf6sAcbAoiBYtdEzHiE3sLX1TJ4xTv/HxUQL0xT9yPo+mI
         iqjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=nEno5dyXB2NW83I3J+lwqaUg3YFCubxEimgqNumKFIo=;
        b=nMXPDuUZWfdhvx7npf4Uu11M7RR4zr8eHzYaAPA/d1awXu0Z3lpPofeg3DdZ8s9rqh
         pb5HqtcHM9Tcr+NQBIRGXkT5eX8YV1EuwOjsXUOOfsTzD7SlwWy9edTaqZ0+BGkFKoG5
         5RY3UX/u1rhYbSF0bfnL+clIADFDGbPVxpF4XSXUZzGgm2vqOuS62GTzhGPfjSVITQnG
         8AbNUtUffSTnR5UxtOj99TRYrDeQ+m52pu1RTd+Wbi4QOpO0brxeMjb1nzS3zHhSNphM
         L/EvfJNlWLo//Z82CoSx/lapHkKldG4Y7pyLF2sxIqmZh2lsLUG8fEfCzQ7BXthgDAZW
         C8hw==
X-Gm-Message-State: AOAM5339awrC+9DJ48FzalolsvnGpkNscjn9/eFD2WHVnepUeBQJHtwv
        rsT2i93trbhhhH+zTS6IiLmRI8JzPAE=
X-Google-Smtp-Source: ABdhPJy1NFAsN8kb5Y1aSSt8/O+AbRkntbtkGwYtt1frRVHlZMnsBjxHvAMuZ59J3EY1MwALkShsXA==
X-Received: by 2002:a05:600c:4ecb:: with SMTP id g11mr13295005wmq.172.1621691830687;
        Sat, 22 May 2021 06:57:10 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c7sm2603353wml.33.2021.05.22.06.57.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 May 2021 06:57:09 -0700 (PDT)
Message-Id: <pull.923.v2.git.1621691828.gitgitgadget@gmail.com>
In-Reply-To: <pull.923.git.1617291666.gitgitgadget@gmail.com>
References: <pull.923.git.1617291666.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 22 May 2021 13:56:39 +0000
Subject: [PATCH v2 00/28] Builtin FSMonitor Feature
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <stolee@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here is V2 of my patch series to add a builtin FSMonitor daemon to Git.

V2 includes addresses most of the review comments from the RFC and many of
the issues seen during out beta-testing with selected GVFS users. However,
there are still a few items that I need to address:

[ ] Revisit the how the client handles the IPC_STATE__NOT_LISTENING state
(where a daemon appears to be running, but is non-responsive) [ ] Revisit
use of global core_fsmonitor as both a pathname and a boolean. The existing
fsmonitor code uses it as the pathname to the fsmonitor hook and as a flag
to indicate that a hook is configured. [ ] Consider having daemon chdir()
out of the working directory to avoid directory handle issues on Windows. [
] Some documentation recommendations. [ ] Split up the commit containing the
tests and move some earlier in patch series. [ ] Move my FSMonitor PREREQ to
test-lib.sh instead of having it in my test scripts. [ ] Document
performance gains. [ ] On Windows, If the daemon is started as an elevated
process, then client commands might not have access to communicate with it.
[ ] Review if/how we decide to shutdown the FSMonitor daemon after and a
significant idle period. [ ] Investigate ways to temporarily shutdown
FSMonitor daemons processes so that the Git for Windows installer can
install an upgrade.

In this version, the first commit updates the Simple IPC API to make it
easier to pass binary data using {char *, size_t} rather than assuming that
the message is a null-terminated string. FSMonitor does not use binary
messages and doesn't really need this API change, but I thought it best to
fix the API now before we have other callers of IPC.

This V2 version will hopefully be previewed as an experimental feature in
Git for Windows v2.32.0.windows.*.

Jeff Hostetler (26):
  simple-ipc: preparations for supporting binary messages.
  fsmonitor--daemon: man page
  fsmonitor--daemon: update fsmonitor documentation
  fsmonitor-ipc: create client routines for git-fsmonitor--daemon
  help: include fsmonitor--daemon feature flag in version info
  fsmonitor--daemon: add a built-in fsmonitor daemon
  fsmonitor--daemon: implement client command options
  t/helper/fsmonitor-client: create IPC client to talk to FSMonitor
    Daemon
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
  fsmonitor--daemon: use a cookie file to sync with file system
  fsmonitor: enhance existing comments
  fsmonitor: force update index after large responses
  t7527: create test for fsmonitor--daemon
  p7519: add fsmonitor--daemon
  t7527: test status with untracked-cache and fsmonitor--daemon
  t/perf: avoid copying builtin fsmonitor files into test repo

Johannes Schindelin (2):
  config: FSMonitor is repository-specific
  fsmonitor: introduce `core.useBuiltinFSMonitor` to call the daemon via
    IPC

 .gitignore                                   |    1 +
 Documentation/config/core.txt                |   56 +-
 Documentation/git-fsmonitor--daemon.txt      |   75 +
 Documentation/git-update-index.txt           |   27 +-
 Documentation/githooks.txt                   |    3 +-
 Makefile                                     |   16 +
 builtin.h                                    |    1 +
 builtin/fsmonitor--daemon.c                  | 1511 ++++++++++++++++++
 builtin/update-index.c                       |    4 +-
 compat/fsmonitor/fsmonitor-fs-listen-macos.c |  497 ++++++
 compat/fsmonitor/fsmonitor-fs-listen-win32.c |  553 +++++++
 compat/fsmonitor/fsmonitor-fs-listen.h       |   49 +
 compat/simple-ipc/ipc-unix-socket.c          |   14 +-
 compat/simple-ipc/ipc-win32.c                |   14 +-
 config.c                                     |    9 +-
 config.h                                     |    2 +-
 config.mak.uname                             |    4 +
 contrib/buildsystems/CMakeLists.txt          |    8 +
 fsmonitor--daemon.h                          |  140 ++
 fsmonitor-ipc.c                              |  179 +++
 fsmonitor-ipc.h                              |   48 +
 fsmonitor.c                                  |  132 +-
 git.c                                        |    1 +
 help.c                                       |    4 +
 repo-settings.c                              |    3 +
 repository.h                                 |    2 +
 simple-ipc.h                                 |    7 +-
 t/helper/test-fsmonitor-client.c             |  125 ++
 t/helper/test-simple-ipc.c                   |   34 +-
 t/helper/test-tool.c                         |    1 +
 t/helper/test-tool.h                         |    1 +
 t/perf/p7519-fsmonitor.sh                    |   42 +-
 t/perf/perf-lib.sh                           |    2 +-
 t/t7527-builtin-fsmonitor.sh                 |  572 +++++++
 34 files changed, 4069 insertions(+), 68 deletions(-)
 create mode 100644 Documentation/git-fsmonitor--daemon.txt
 create mode 100644 builtin/fsmonitor--daemon.c
 create mode 100644 compat/fsmonitor/fsmonitor-fs-listen-macos.c
 create mode 100644 compat/fsmonitor/fsmonitor-fs-listen-win32.c
 create mode 100644 compat/fsmonitor/fsmonitor-fs-listen.h
 create mode 100644 fsmonitor--daemon.h
 create mode 100644 fsmonitor-ipc.c
 create mode 100644 fsmonitor-ipc.h
 create mode 100644 t/helper/test-fsmonitor-client.c
 create mode 100755 t/t7527-builtin-fsmonitor.sh


base-commit: b0c09ab8796fb736efa432b8e817334f3e5ee75a
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-923%2Fjeffhostetler%2Fbuiltin-fsmonitor-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-923/jeffhostetler/builtin-fsmonitor-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/923

Range-diff vs v1:

  -:  ------------ >  1:  763fa1ee7bb6 simple-ipc: preparations for supporting binary messages.
  -:  ------------ >  2:  fc180e8591bf fsmonitor--daemon: man page
  1:  074273330f8d !  3:  d56f3e91db9f fsmonitor--daemon: man page and documentation
     @@ Metadata
      Author: Jeff Hostetler <jeffhost@microsoft.com>
      
       ## Commit message ##
     -    fsmonitor--daemon: man page and documentation
     +    fsmonitor--daemon: update fsmonitor documentation
      
     -    Create a manual page describing the `git fsmonitor--daemon` feature.
     -
     -    Update references to `core.fsmonitor`, `core.fsmonitorHookVersion` and
     -    pointers to `watchman` to mention the built-in FSMonitor.
     +    Update references to `core.fsmonitor` and `core.fsmonitorHookVersion` and
     +    pointers to `Watchman` to mention the new built-in `fsmonitor--daemon`.
      
          Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
      
       ## Documentation/config/core.txt ##
     -@@ Documentation/config/core.txt: core.fsmonitor::
     - 	will identify all files that may have changed since the
     - 	requested date/time. This information is used to speed up git by
     - 	avoiding unnecessary processing of files that have not changed.
     +@@ Documentation/config/core.txt: core.protectNTFS::
     + 	Defaults to `true` on Windows, and `false` elsewhere.
     + 
     + core.fsmonitor::
     +-	If set, the value of this variable is used as a command which
     +-	will identify all files that may have changed since the
     +-	requested date/time. This information is used to speed up git by
     +-	avoiding unnecessary processing of files that have not changed.
      -	See the "fsmonitor-watchman" section of linkgit:githooks[5].
     ++	If set, this variable contains the pathname of the "fsmonitor"
     ++	hook command.
     +++
     ++This hook command is used to identify all files that may have changed
     ++since the requested date/time. This information is used to speed up
     ++git by avoiding unnecessary scanning of files that have not changed.
      ++
      +See the "fsmonitor-watchman" section of linkgit:githooks[5].
      ++
     -+Note: FSMonitor hooks (and this config setting) are ignored if the
     -+built-in FSMonitor is enabled (see `core.useBuiltinFSMonitor`).
     ++Note: The value of this config setting is ignored if the
     ++built-in file system monitor is enabled (see `core.useBuiltinFSMonitor`).
       
       core.fsmonitorHookVersion::
      -	Sets the version of hook that is to be used when calling fsmonitor.
     @@ Documentation/config/core.txt: core.fsmonitor::
      -	Version 2 uses an opaque string so that the monitor can return
      -	something that can be used to determine what files have changed
      -	without race conditions.
     -+	Sets the version of hook that is to be used when calling the
     -+	FSMonitor hook (as configured via `core.fsmonitor`).
     ++	Sets the protocol version to be used when invoking the
     ++	"fsmonitor" hook.
      ++
      +There are currently versions 1 and 2. When this is not set,
      +version 2 will be tried first and if it fails then version 1
      +will be tried. Version 1 uses a timestamp as input to determine
      +which files have changes since that time but some monitors
     -+like watchman have race conditions when used with a timestamp.
     ++like Watchman have race conditions when used with a timestamp.
      +Version 2 uses an opaque string so that the monitor can return
      +something that can be used to determine what files have changed
      +without race conditions.
      ++
     -+Note: FSMonitor hooks (and this config setting) are ignored if the
     -+built-in FSMonitor is enabled (see `core.useBuiltinFSMonitor`).
     ++Note: The value of this config setting is ignored if the
     ++built-in file system monitor is enabled (see `core.useBuiltinFSMonitor`).
      +
      +core.useBuiltinFSMonitor::
     -+	If set to true, enable the built-in filesystem event watcher (for
     -+	technical details, see linkgit:git-fsmonitor--daemon[1]).
     ++	If set to true, enable the built-in file system monitor
     ++	daemon for this working directory (linkgit:git-fsmonitor--daemon[1]).
      ++
     -+Like external (hook-based) FSMonitors, the built-in FSMonitor can speed up
     -+Git commands that need to refresh the Git index (e.g. `git status`) in a
     -+worktree with many files. The built-in FSMonitor facility eliminates the
     -+need to install and maintain an external third-party monitoring tool.
     ++Like hook-based file system monitors, the built-in file system monitor
     ++can speed up Git commands that need to refresh the Git index
     ++(e.g. `git status`) in a working directory with many files.  The
     ++built-in monitor eliminates the need to install and maintain an
     ++external third-party tool.
      ++
     -+The built-in FSMonitor is currently available only on a limited set of
     -+supported platforms.
     ++The built-in file system monitor is currently available only on a
     ++limited set of supported platforms.  Currently, this includes Windows
     ++and MacOS.
      ++
     -+Note: if this config setting is set to `true`, any FSMonitor hook
     -+configured via `core.fsmonitor` (and possibly `core.fsmonitorHookVersion`)
     -+is ignored.
     ++Note: if this config setting is set to `true`, the values of
     ++`core.fsmonitor` and `core.fsmonitorHookVersion` are ignored.
       
       core.trustctime::
       	If false, the ctime differences between the index and the
      
     - ## Documentation/git-fsmonitor--daemon.txt (new) ##
     -@@
     -+git-fsmonitor--daemon(1)
     -+========================
     -+
     -+NAME
     -+----
     -+git-fsmonitor--daemon - Builtin file system monitor daemon
     -+
     -+SYNOPSIS
     -+--------
     -+[verse]
     -+'git fsmonitor--daemon' --start
     -+'git fsmonitor--daemon' --run
     -+'git fsmonitor--daemon' --stop
     -+'git fsmonitor--daemon' --is-running
     -+'git fsmonitor--daemon' --is-supported
     -+'git fsmonitor--daemon' --query <token>
     -+'git fsmonitor--daemon' --query-index
     -+'git fsmonitor--daemon' --flush
     -+
     -+DESCRIPTION
     -+-----------
     -+
     -+Monitors files and directories in the working directory for changes using
     -+platform-specific file system notification facilities.
     -+
     -+It communicates directly with commands like `git status` using the
     -+link:technical/api-simple-ipc.html[simple IPC] interface instead of
     -+the slower linkgit:githooks[5] interface.
     -+
     -+OPTIONS
     -+-------
     -+
     -+--start::
     -+	Starts the fsmonitor daemon in the background.
     -+
     -+--run::
     -+	Runs the fsmonitor daemon in the foreground.
     -+
     -+--stop::
     -+	Stops the fsmonitor daemon running for the current working
     -+	directory, if present.
     -+
     -+--is-running::
     -+	Exits with zero status if the fsmonitor daemon is watching the
     -+	current working directory.
     -+
     -+--is-supported::
     -+	Exits with zero status if the fsmonitor daemon feature is supported
     -+	on this platform.
     -+
     -+--query <token>::
     -+	Connects to the fsmonitor daemon (starting it if necessary) and
     -+	requests the list of changed files and directories since the
     -+	given token.
     -+	This is intended for testing purposes.
     -+
     -+--query-index::
     -+	Read the current `<token>` from the File System Monitor index
     -+	extension (if present) and use it to query the fsmonitor daemon.
     -+	This is intended for testing purposes.
     -+
     -+--flush::
     -+	Force the fsmonitor daemon to flush its in-memory cache and
     -+	re-sync with the file system.
     -+	This is intended for testing purposes.
     -+
     -+REMARKS
     -+-------
     -+The fsmonitor daemon is a long running process that will watch a single
     -+working directory.  Commands, such as `git status`, should automatically
     -+start it (if necessary) when `core.useBuiltinFSMonitor` is set to `true`
     -+(see linkgit:git-config[1]).
     -+
     -+Configure the built-in FSMonitor via `core.useBuiltinFSMonitor` in each
     -+working directory separately, or globally via `git config --global
     -+core.useBuiltinFSMonitor true`.
     -+
     -+Tokens are opaque strings.  They are used by the fsmonitor daemon to
     -+mark a point in time and the associated internal state.  Callers should
     -+make no assumptions about the content of the token.  In particular,
     -+the should not assume that it is a timestamp.
     -+
     -+Query commands send a request-token to the daemon and it responds with
     -+a summary of the changes that have occurred since that token was
     -+created.  The daemon also returns a response-token that the client can
     -+use in a future query.
     -+
     -+For more information see the "File System Monitor" section in
     -+linkgit:git-update-index[1].
     -+
     -+CAVEATS
     -+-------
     -+
     -+The fsmonitor daemon does not currently know about submodules and does
     -+not know to filter out file system events that happen within a
     -+submodule.  If fsmonitor daemon is watching a super repo and a file is
     -+modified within the working directory of a submodule, it will report
     -+the change (as happening against the super repo).  However, the client
     -+should properly ignore these extra events, so performance may be affected
     -+but it should not cause an incorrect result.
     -+
     -+GIT
     -+---
     -+Part of the linkgit:git[1] suite
     -
       ## Documentation/git-update-index.txt ##
      @@ Documentation/git-update-index.txt: FILE SYSTEM MONITOR
       This feature is intended to speed up git operations for repos that have
     @@ Documentation/git-update-index.txt: FILE SYSTEM MONITOR
       "fsmonitor-watchman" section of linkgit:githooks[5]) that can
       inform it as to what files have been modified. This enables git to avoid
       having to lstat() every file to find modified files.
     +@@ Documentation/git-update-index.txt: performance by avoiding the cost of scanning the entire working directory
     + looking for new files.
     + 
     + If you want to enable (or disable) this feature, it is easier to use
     +-the `core.fsmonitor` configuration variable (see
     +-linkgit:git-config[1]) than using the `--fsmonitor` option to
     +-`git update-index` in each repository, especially if you want to do so
     +-across all repositories you use, because you can set the configuration
     +-variable in your `$HOME/.gitconfig` just once and have it affect all
     +-repositories you touch.
     +-
     +-When the `core.fsmonitor` configuration variable is changed, the
     +-file system monitor is added to or removed from the index the next time
     +-a command reads the index. When `--[no-]fsmonitor` are used, the file
     +-system monitor is immediately added to or removed from the index.
     ++the `core.fsmonitor` or `core.useBuiltinFSMonitor` configuration
     ++variable (see linkgit:git-config[1]) than using the `--fsmonitor`
     ++option to `git update-index` in each repository, especially if you
     ++want to do so across all repositories you use, because you can set the
     ++configuration variable in your `$HOME/.gitconfig` just once and have
     ++it affect all repositories you touch.
     ++
     ++When the `core.fsmonitor` or `core.useBuiltinFSMonitor` configuration
     ++variable is changed, the file system monitor is added to or removed
     ++from the index the next time a command reads the index. When
     ++`--[no-]fsmonitor` are used, the file system monitor is immediately
     ++added to or removed from the index.
     + 
     + CONFIGURATION
     + -------------
      
       ## Documentation/githooks.txt ##
      @@ Documentation/githooks.txt: fsmonitor-watchman
  2:  3dac63eae201 !  4:  e4a263728773 fsmonitor-ipc: create client routines for git-fsmonitor--daemon
     @@ Metadata
       ## Commit message ##
          fsmonitor-ipc: create client routines for git-fsmonitor--daemon
      
     -    Create client routines to spawn a fsmonitor daemon and send it an IPC
     -    request using `simple-ipc`.
     +    Create fsmonitor_ipc__*() client routines to spawn the built-in file
     +    system monitor daemon and send it an IPC request using the `Simple
     +    IPC` API.
     +
     +    Stub in empty fsmonitor_ipc__*() functions for unsupported platforms.
      
          Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
      
     @@ fsmonitor-ipc.c (new)
      @@
      +#include "cache.h"
      +#include "fsmonitor.h"
     ++#include "simple-ipc.h"
      +#include "fsmonitor-ipc.h"
      +#include "run-command.h"
      +#include "strbuf.h"
      +#include "trace2.h"
      +
      +#ifdef HAVE_FSMONITOR_DAEMON_BACKEND
     -+#define FSMONITOR_DAEMON_IS_SUPPORTED 1
     -+#else
     -+#define FSMONITOR_DAEMON_IS_SUPPORTED 0
     -+#endif
      +
     -+/*
     -+ * A trivial function so that this source file always defines at least
     -+ * one symbol even when the feature is not supported.  This quiets an
     -+ * annoying compiler error.
     -+ */
      +int fsmonitor_ipc__is_supported(void)
      +{
     -+	return FSMONITOR_DAEMON_IS_SUPPORTED;
     ++	return 1;
      +}
      +
     -+#ifdef HAVE_FSMONITOR_DAEMON_BACKEND
     -+
     -+GIT_PATH_FUNC(fsmonitor_ipc__get_path, "fsmonitor")
     ++GIT_PATH_FUNC(fsmonitor_ipc__get_path, "fsmonitor--daemon.ipc")
      +
      +enum ipc_active_state fsmonitor_ipc__get_state(void)
      +{
     @@ fsmonitor-ipc.c (new)
      +
      +static int spawn_daemon(void)
      +{
     -+	const char *args[] = { "fsmonitor--daemon", "--start", NULL };
     ++	const char *args[] = { "fsmonitor--daemon", "start", NULL };
      +
      +	return run_command_v_opt_tr2(args, RUN_COMMAND_NO_STDIN | RUN_GIT_CMD,
      +				    "fsmonitor");
     @@ fsmonitor-ipc.c (new)
      +	switch (state) {
      +	case IPC_STATE__LISTENING:
      +		ret = ipc_client_send_command_to_connection(
     -+			connection, since_token, answer);
     ++			connection, since_token, strlen(since_token), answer);
      +		ipc_client_close_connection(connection);
      +
      +		trace2_data_intmax("fsm_client", NULL,
     @@ fsmonitor-ipc.c (new)
      +		return -1;
      +	}
      +
     -+	ret = ipc_client_send_command_to_connection(connection, command, answer);
     ++	ret = ipc_client_send_command_to_connection(connection,
     ++						    command, strlen(command),
     ++						    answer);
      +	ipc_client_close_connection(connection);
      +
      +	if (ret == -1) {
     @@ fsmonitor-ipc.c (new)
      +	return 0;
      +}
      +
     ++#else
     ++
     ++/*
     ++ * A trivial implementation of the fsmonitor_ipc__ API for unsupported
     ++ * platforms.
     ++ */
     ++
     ++int fsmonitor_ipc__is_supported(void)
     ++{
     ++	return 0;
     ++}
     ++
     ++const char *fsmonitor_ipc__get_path(void)
     ++{
     ++	return NULL;
     ++}
     ++
     ++enum ipc_active_state fsmonitor_ipc__get_state(void)
     ++{
     ++	return IPC_STATE__OTHER_ERROR;
     ++}
     ++
     ++int fsmonitor_ipc__send_query(const char *since_token,
     ++			      struct strbuf *answer)
     ++{
     ++	return -1;
     ++}
     ++
     ++int fsmonitor_ipc__send_command(const char *command,
     ++				struct strbuf *answer)
     ++{
     ++	return -1;
     ++}
     ++
      +#endif
      
       ## fsmonitor-ipc.h (new) ##
     @@ fsmonitor-ipc.h (new)
      +#define FSMONITOR_IPC_H
      +
      +/*
     -+ * Returns true if a filesystem notification backend is defined
     -+ * for this platform.  This symbol must always be visible and
     -+ * outside of the HAVE_ ifdef.
     ++ * Returns true if built-in file system monitor daemon is defined
     ++ * for this platform.
      + */
      +int fsmonitor_ipc__is_supported(void);
      +
     -+#ifdef HAVE_FSMONITOR_DAEMON_BACKEND
     -+#include "run-command.h"
     -+#include "simple-ipc.h"
     -+
      +/*
      + * Returns the pathname to the IPC named pipe or Unix domain socket
      + * where a `git-fsmonitor--daemon` process will listen.  This is a
      + * per-worktree value.
     ++ *
     ++ * Returns NULL if the daemon is not supported on this platform.
      + */
      +const char *fsmonitor_ipc__get_path(void);
      +
     @@ fsmonitor-ipc.h (new)
      + * This DOES NOT use the hook interface.
      + *
      + * Spawn a daemon process in the background if necessary.
     ++ *
     ++ * Returns -1 on error; 0 on success.
      + */
      +int fsmonitor_ipc__send_query(const char *since_token,
      +			      struct strbuf *answer);
     @@ fsmonitor-ipc.h (new)
      + * Connect to a `git-fsmonitor--daemon` process via simple-ipc and
      + * send a command verb.  If no daemon is available, we DO NOT try to
      + * start one.
     ++ *
     ++ * Returns -1 on error; 0 on success.
      + */
      +int fsmonitor_ipc__send_command(const char *command,
      +				struct strbuf *answer);
      +
     -+#endif /* HAVE_FSMONITOR_DAEMON_BACKEND */
      +#endif /* FSMONITOR_IPC_H */
     -
     - ## help.c ##
     -@@
     - #include "version.h"
     - #include "refs.h"
     - #include "parse-options.h"
     -+#include "fsmonitor-ipc.h"
     - 
     - struct category_description {
     - 	uint32_t category;
     -@@ help.c: void get_version_info(struct strbuf *buf, int show_build_options)
     - 		strbuf_addf(buf, "sizeof-size_t: %d\n", (int)sizeof(size_t));
     - 		strbuf_addf(buf, "shell-path: %s\n", SHELL_PATH);
     - 		/* NEEDSWORK: also save and output GIT-BUILD_OPTIONS? */
     -+
     -+		if (fsmonitor_ipc__is_supported())
     -+			strbuf_addstr(buf, "feature: fsmonitor--daemon\n");
     - 	}
     - }
     - 
  -:  ------------ >  5:  d5d09eb1635b help: include fsmonitor--daemon feature flag in version info
  3:  18c125ec73dc !  6:  67bcf57f5948 config: FSMonitor is repository-specific
     @@ Commit message
          This commit refactors `git_config_get_fsmonitor()` into the `repo_*()`
          form that takes a parameter `struct repository *r`.
      
     -    That change prepares for the upcoming `core.useFSMonitorDaemon` flag which
     +    That change prepares for the upcoming `core.useBuiltinFSMonitor` flag which
          will be stored in the `repo_settings` struct.
      
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
  4:  7082528d8f7c !  7:  7e097cebc143 fsmonitor: introduce `core.useBuiltinFSMonitor` to call the daemon via IPC
     @@ Metadata
       ## Commit message ##
          fsmonitor: introduce `core.useBuiltinFSMonitor` to call the daemon via IPC
      
     -    The `core.fsmonitor` setting is supposed to be set to a path pointing
     -    to a script or executable that (via the Hook API) queries an fsmonitor
     -    process such as watchman.
     +    Use simple IPC to directly communicate with the new builtin file
     +    system monitor daemon.
      
     -    We are about to implement our own fsmonitor backend, and do not want
     -    to spawn hook processes just to query it.  Let's use `Simple IPC` to
     -    directly communicate with the daemon (and start it if necessary),
     -    guarded by the brand-new `core.useBuiltinFSMonitor` toggle.
     +    Define a new config setting `core.useBuiltinFSMonitor` to enable the
     +    builtin file system monitor.
     +
     +    The `core.fsmonitor` setting has already been defined as a HOOK
     +    pathname.  Historically, this has been set to a HOOK script that will
     +    talk with Watchman.  For compatibility reasons, we do not want to
     +    overload that definition (and cause problems if users have multiple
     +    versions of Git installed).
      
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
          Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
     @@ fsmonitor.c
       #include "run-command.h"
       #include "strbuf.h"
       
     -@@ fsmonitor.c: void write_fsmonitor_extension(struct strbuf *sb, struct index_state *istate)
     - /*
     -  * Call the query-fsmonitor hook passing the last update token of the saved results.
     -  */
     --static int query_fsmonitor(int version, const char *last_update, struct strbuf *query_result)
     -+static int query_fsmonitor(int version, struct index_state *istate, struct strbuf *query_result)
     +@@ fsmonitor.c: static void fsmonitor_refresh_callback(struct index_state *istate, char *name)
     + 
     + void refresh_fsmonitor(struct index_state *istate)
       {
      +	struct repository *r = istate->repo ? istate->repo : the_repository;
     -+	const char *last_update = istate->fsmonitor_last_update;
     - 	struct child_process cp = CHILD_PROCESS_INIT;
     - 	int result;
     - 
     - 	if (!core_fsmonitor)
     - 		return -1;
     + 	struct strbuf query_result = STRBUF_INIT;
     + 	int query_success = 0, hook_version = -1;
     + 	size_t bol = 0; /* beginning of line */
     +@@ fsmonitor.c: void refresh_fsmonitor(struct index_state *istate)
     + 	istate->fsmonitor_has_run_once = 1;
       
     + 	trace_printf_key(&trace_fsmonitor, "refresh fsmonitor");
     ++
      +	if (r->settings.use_builtin_fsmonitor > 0) {
     -+#ifdef HAVE_FSMONITOR_DAEMON_BACKEND
     -+		return fsmonitor_ipc__send_query(last_update, query_result);
     -+#else
     -+		/* Fake a trivial response. */
     -+		warning(_("fsmonitor--daemon unavailable; falling back"));
     -+		strbuf_add(query_result, "/", 2);
     -+		return 0;
     -+#endif
     ++		query_success = !fsmonitor_ipc__send_query(
     ++			istate->fsmonitor_last_update, &query_result);
     ++		if (query_success) {
     ++			/*
     ++			 * The response contains a series of nul terminated
     ++			 * strings.  The first is the new token.
     ++			 *
     ++			 * Use `char *buf` as an interlude to trick the CI
     ++			 * static analysis to let us use `strbuf_addstr()`
     ++			 * here (and only copy the token) rather than
     ++			 * `strbuf_addbuf()`.
     ++			 */
     ++			buf = query_result.buf;
     ++			strbuf_addstr(&last_update_token, buf);
     ++			bol = last_update_token.len + 1;
     ++		} else {
     ++			/*
     ++			 * The builtin daemon is not available on this
     ++			 * platform -OR- we failed to get a response.
     ++			 *
     ++			 * Generate a fake token (rather than a V1
     ++			 * timestamp) for the index extension.  (If
     ++			 * they switch back to the hook API, we don't
     ++			 * want ambiguous state.)
     ++			 */
     ++			strbuf_addstr(&last_update_token, "builtin:fake");
     ++		}
     ++
     ++		/*
     ++		 * Regardless of whether we successfully talked to a
     ++		 * fsmonitor daemon or not, we skip over and do not
     ++		 * try to use the hook.  The "core.useBuiltinFSMonitor"
     ++		 * config setting ALWAYS overrides the "core.fsmonitor"
     ++		 * hook setting.
     ++		 */
     ++		goto apply_results;
      +	}
      +
     - 	strvec_push(&cp.args, core_fsmonitor);
     - 	strvec_pushf(&cp.args, "%d", version);
     - 	strvec_pushf(&cp.args, "%s", last_update);
     + 	/*
     + 	 * This could be racy so save the date/time now and query_fsmonitor
     + 	 * should be inclusive to ensure we don't miss potential changes.
      @@ fsmonitor.c: void refresh_fsmonitor(struct index_state *istate)
     - 	if (istate->fsmonitor_last_update) {
     - 		if (hook_version == -1 || hook_version == HOOK_INTERFACE_VERSION2) {
     - 			query_success = !query_fsmonitor(HOOK_INTERFACE_VERSION2,
     --				istate->fsmonitor_last_update, &query_result);
     -+				istate, &query_result);
     + 			core_fsmonitor, query_success ? "success" : "failure");
     + 	}
       
     - 			if (query_success) {
     - 				if (hook_version < 0)
     -@@ fsmonitor.c: void refresh_fsmonitor(struct index_state *istate)
     - 
     - 		if (hook_version == HOOK_INTERFACE_VERSION1) {
     - 			query_success = !query_fsmonitor(HOOK_INTERFACE_VERSION1,
     --				istate->fsmonitor_last_update, &query_result);
     -+				istate, &query_result);
     - 		}
     - 
     - 		trace_performance_since(last_update, "fsmonitor process '%s'", core_fsmonitor);
     ++apply_results:
     + 	/* a fsmonitor process can return '/' to indicate all entries are invalid */
     + 	if (query_success && query_result.buf[bol] != '/') {
     + 		/* Mark all entries returned by the monitor as dirty */
      
       ## repo-settings.c ##
      @@ repo-settings.c: void prepare_repo_settings(struct repository *r)
     @@ repo-settings.c: void prepare_repo_settings(struct repository *r)
       		UPDATE_DEFAULT_BOOL(r->settings.core_untracked_cache, UNTRACKED_CACHE_WRITE);
      
       ## repository.h ##
     -@@ repository.h: struct repo_settings {
     - 	enum fetch_negotiation_setting fetch_negotiation_algorithm;
     +@@ repository.h: enum fetch_negotiation_setting {
     + struct repo_settings {
     + 	int initialized;
       
     - 	int core_multi_pack_index;
     -+
      +	int use_builtin_fsmonitor;
     - };
     - 
     - struct repository {
     ++
     + 	int core_commit_graph;
     + 	int commit_graph_read_changed_paths;
     + 	int gc_write_commit_graph;
  5:  95d511d83b12 !  8:  f362a88632e4 fsmonitor--daemon: add a built-in fsmonitor daemon
     @@ builtin/fsmonitor--daemon.c (new)
      +
      +int cmd_fsmonitor__daemon(int argc, const char **argv, const char *prefix)
      +{
     -+	enum daemon_mode {
     -+		UNDEFINED_MODE,
     -+	} mode = UNDEFINED_MODE;
     ++	const char *subcmd;
      +
      +	struct option options[] = {
      +		OPT_END()
      +	};
      +
     ++	if (argc < 2)
     ++		usage_with_options(builtin_fsmonitor__daemon_usage, options);
     ++
      +	if (argc == 2 && !strcmp(argv[1], "-h"))
      +		usage_with_options(builtin_fsmonitor__daemon_usage, options);
      +
      +	git_config(git_default_config, NULL);
      +
     ++	subcmd = argv[1];
     ++	argv--;
     ++	argc++;
     ++
      +	argc = parse_options(argc, argv, prefix, options,
      +			     builtin_fsmonitor__daemon_usage, 0);
      +
     -+	switch (mode) {
     -+	case UNDEFINED_MODE:
     -+	default:
     -+		die(_("Unhandled command mode %d"), mode);
     -+	}
     ++	die(_("Unhandled subcommand '%s'"), subcmd);
      +}
      +
      +#else
  6:  77170e521f67 !  9:  4f401310539e fsmonitor--daemon: implement client command options
     @@ Metadata
       ## Commit message ##
          fsmonitor--daemon: implement client command options
      
     -    Implement command options `--stop`, `--is-running`, `--query`,
     -    `--query-index`, and `--flush` to control and query the status of a
     -    `fsmonitor--daemon` server process (and implicitly start a server
     -    process if necessary).
     +    Implement `stop` and `status` client commands to control and query the
     +    status of a `fsmonitor--daemon` server process (and implicitly start a
     +    server process if necessary).
      
     -    Later commits will implement the actual server and monitor
     -    the file system.
     +    Later commits will implement the actual server and monitor the file
     +    system.
      
          Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
      
     @@ builtin/fsmonitor--daemon.c
       #include "khash.h"
       
       static const char * const builtin_fsmonitor__daemon_usage[] = {
     -+	N_("git fsmonitor--daemon --stop"),
     -+	N_("git fsmonitor--daemon --is-running"),
     -+	N_("git fsmonitor--daemon --query <token>"),
     -+	N_("git fsmonitor--daemon --query-index"),
     -+	N_("git fsmonitor--daemon --flush"),
     ++	N_("git fsmonitor--daemon stop"),
     ++	N_("git fsmonitor--daemon status"),
       	NULL
       };
       
     @@ builtin/fsmonitor--daemon.c
      +/*
      + * Acting as a CLIENT.
      + *
     -+ * Send an IPC query to a `git-fsmonitor--daemon` SERVER process and
     -+ * ask for the changes since the given token.  This will implicitly
     -+ * start a daemon process if necessary.  The daemon process will
     -+ * persist after we exit.
     -+ *
     -+ * This feature is primarily used by the test suite.
     -+ */
     -+static int do_as_client__query_token(const char *token)
     -+{
     -+	struct strbuf answer = STRBUF_INIT;
     -+	int ret;
     -+
     -+	ret = fsmonitor_ipc__send_query(token, &answer);
     -+	if (ret < 0)
     -+		die(_("could not query fsmonitor--daemon"));
     -+
     -+	write_in_full(1, answer.buf, answer.len);
     -+	strbuf_release(&answer);
     -+
     -+	return 0;
     -+}
     -+
     -+/*
     -+ * Acting as a CLIENT.
     -+ *
     -+ * Read the `.git/index` to get the last token written to the FSMonitor index
     -+ * extension and use that to make a query.
     -+ *
     -+ * This feature is primarily used by the test suite.
     -+ */
     -+static int do_as_client__query_from_index(void)
     -+{
     -+	struct index_state *istate = the_repository->index;
     -+
     -+	setup_git_directory();
     -+	if (do_read_index(istate, the_repository->index_file, 0) < 0)
     -+		die("unable to read index file");
     -+	if (!istate->fsmonitor_last_update)
     -+		die("index file does not have fsmonitor extension");
     -+
     -+	return do_as_client__query_token(istate->fsmonitor_last_update);
     -+}
     -+
     -+/*
     -+ * Acting as a CLIENT.
     -+ *
      + * Send a "quit" command to the `git-fsmonitor--daemon` (if running)
      + * and wait for it to shutdown.
      + */
     @@ builtin/fsmonitor--daemon.c
      +	return 0;
      +}
      +
     -+/*
     -+ * Acting as a CLIENT.
     -+ *
     -+ * Send a "flush" command to the `git-fsmonitor--daemon` (if running)
     -+ * and tell it to flush its cache.
     -+ *
     -+ * This feature is primarily used by the test suite to simulate a loss of
     -+ * sync with the filesystem where we miss kernel events.
     -+ */
     -+static int do_as_client__send_flush(void)
     ++static int do_as_client__status(void)
      +{
     -+	struct strbuf answer = STRBUF_INIT;
     -+	int ret;
     -+
     -+	ret = fsmonitor_ipc__send_command("flush", &answer);
     -+	if (ret)
     -+		return ret;
     -+
     -+	write_in_full(1, answer.buf, answer.len);
     -+	strbuf_release(&answer);
     ++	enum ipc_active_state state = fsmonitor_ipc__get_state();
      +
     -+	return 0;
     -+}
     ++	switch (state) {
     ++	case IPC_STATE__LISTENING:
     ++		printf(_("The built-in file system monitor is active\n"));
     ++		return 0;
      +
     -+static int is_ipc_daemon_listening(void)
     -+{
     -+	return fsmonitor_ipc__get_state() == IPC_STATE__LISTENING;
     ++	default:
     ++		printf(_("The built-in file system monitor is not active\n"));
     ++		return 1;
     ++	}
      +}
       
       int cmd_fsmonitor__daemon(int argc, const char **argv, const char *prefix)
       {
     - 	enum daemon_mode {
     - 		UNDEFINED_MODE,
     -+		STOP,
     -+		IS_RUNNING,
     -+		QUERY,
     -+		QUERY_INDEX,
     -+		FLUSH,
     - 	} mode = UNDEFINED_MODE;
     - 
     - 	struct option options[] = {
     -+		OPT_CMDMODE(0, "stop", &mode, N_("stop the running daemon"),
     -+			    STOP),
     -+
     -+		OPT_CMDMODE(0, "is-running", &mode,
     -+			    N_("test whether the daemon is running"),
     -+			    IS_RUNNING),
     -+
     -+		OPT_CMDMODE(0, "query", &mode,
     -+			    N_("query the daemon (starting if necessary)"),
     -+			    QUERY),
     -+		OPT_CMDMODE(0, "query-index", &mode,
     -+			    N_("query the daemon (starting if necessary) using token from index"),
     -+			    QUERY_INDEX),
     -+		OPT_CMDMODE(0, "flush", &mode, N_("flush cached filesystem events"),
     -+			    FLUSH),
     - 		OPT_END()
     - 	};
     - 
      @@ builtin/fsmonitor--daemon.c: int cmd_fsmonitor__daemon(int argc, const char **argv, const char *prefix)
     + 	argc = parse_options(argc, argv, prefix, options,
       			     builtin_fsmonitor__daemon_usage, 0);
       
     - 	switch (mode) {
     -+	case STOP:
     ++	if (!strcmp(subcmd, "stop"))
      +		return !!do_as_client__send_stop();
      +
     -+	case IS_RUNNING:
     -+		return !is_ipc_daemon_listening();
     -+
     -+	case QUERY:
     -+		if (argc != 1)
     -+			usage_with_options(builtin_fsmonitor__daemon_usage,
     -+					   options);
     -+		return !!do_as_client__query_token(argv[0]);
     ++	if (!strcmp(subcmd, "status"))
     ++		return !!do_as_client__status();
      +
     -+	case QUERY_INDEX:
     -+		return !!do_as_client__query_from_index();
     -+
     -+	case FLUSH:
     -+		return !!do_as_client__send_flush();
     -+
     - 	case UNDEFINED_MODE:
     - 	default:
     - 		die(_("Unhandled command mode %d"), mode);
     + 	die(_("Unhandled subcommand '%s'"), subcmd);
     + }
     + 
  -:  ------------ > 10:  d21af7ff842c t/helper/fsmonitor-client: create IPC client to talk to FSMonitor Daemon
  7:  27f47dfbd9cf ! 11:  49f9e2e3d49c fsmonitor-fs-listen-win32: stub in backend for Windows
     @@ Makefile: all::
       # directory, and the JSON compilation database 'compile_commands.json' will be
       # created at the root of the repository.
       #
     -+# If your platform supports an built-in fsmonitor backend, set
     -+# FSMONITOR_DAEMON_BACKEND to the name of the corresponding
     ++# If your platform supports a built-in fsmonitor backend, set
     ++# FSMONITOR_DAEMON_BACKEND to the "<name>" of the corresponding
      +# `compat/fsmonitor/fsmonitor-fs-listen-<name>.c` that implements the
      +# `fsmonitor_fs_listen__*()` routines.
      +#
  8:  a84dee24e13e = 12:  2aa85151f03c fsmonitor-fs-listen-macos: stub in backend for MacOS
  9:  2b291d805d59 ! 13:  2aa05ad5c67f fsmonitor--daemon: implement daemon command options
     @@ Metadata
       ## Commit message ##
          fsmonitor--daemon: implement daemon command options
      
     -    Implement command options `--run` and `--start` to try to
     +    Implement `run` and `start` commands to try to
          begin listening for file system events.
      
          This version defines the thread structure with a single
     @@ builtin/fsmonitor--daemon.c
       #include "khash.h"
       
       static const char * const builtin_fsmonitor__daemon_usage[] = {
     -+	N_("git fsmonitor--daemon --start [<options>]"),
     -+	N_("git fsmonitor--daemon --run [<options>]"),
     - 	N_("git fsmonitor--daemon --stop"),
     - 	N_("git fsmonitor--daemon --is-running"),
     - 	N_("git fsmonitor--daemon --query <token>"),
     -@@ builtin/fsmonitor--daemon.c: static const char * const builtin_fsmonitor__daemon_usage[] = {
     ++	N_("git fsmonitor--daemon start [<options>]"),
     ++	N_("git fsmonitor--daemon run [<options>]"),
     + 	N_("git fsmonitor--daemon stop"),
     + 	N_("git fsmonitor--daemon status"),
     + 	NULL
       };
       
       #ifdef HAVE_FSMONITOR_DAEMON_BACKEND
     @@ builtin/fsmonitor--daemon.c: static const char * const builtin_fsmonitor__daemon
       /*
        * Acting as a CLIENT.
        *
     -@@ builtin/fsmonitor--daemon.c: static int do_as_client__send_flush(void)
     - 	return 0;
     +@@ builtin/fsmonitor--daemon.c: static int do_as_client__status(void)
     + 	}
       }
       
      +static ipc_server_application_cb handle_client;
      +
     -+static int handle_client(void *data, const char *command,
     ++static int handle_client(void *data,
     ++			 const char *command, size_t command_len,
      +			 ipc_server_reply_cb *reply,
      +			 struct ipc_server_reply_data *reply_data)
      +{
      +	/* struct fsmonitor_daemon_state *state = data; */
      +	int result;
      +
     ++	/*
     ++	 * The Simple IPC API now supports {char*, len} arguments, but
     ++	 * FSMonitor always uses proper null-terminated strings, so
     ++	 * we can ignore the command_len argument.  (Trust, but verify.)
     ++	 */
     ++	if (command_len != strlen(command))
     ++		BUG("FSMonitor assumes text messages");
     ++
      +	trace2_region_enter("fsmonitor", "handle_client", the_repository);
      +	trace2_data_string("fsmonitor", the_repository, "request", command);
      +
     @@ builtin/fsmonitor--daemon.c: static int do_as_client__send_flush(void)
      +	pthread_mutex_init(&state.main_lock, NULL);
      +	state.error_code = 0;
      +	state.current_token_data = NULL;
     -+	state.test_client_delay_ms = 0;
      +
      +	/* Prepare to (recursively) watch the <worktree-root> directory. */
      +	strbuf_init(&state.path_worktree_watch, 0);
     @@ builtin/fsmonitor--daemon.c: static int do_as_client__send_flush(void)
      +	state.nr_paths_watching = 1;
      +
      +	/*
     -+	 * If ".git" is not a directory, then <gitdir> is not inside the
     -+	 * cone of <worktree-root>, so set up a second watch for it.
     ++	 * We create/delete cookie files inside the .git directory to
     ++	 * help us keep sync with the file system.  If ".git" is not a
     ++	 * directory, then <gitdir> is not inside the cone of
     ++	 * <worktree-root>, so set up a second watch for it.
      +	 */
      +	strbuf_init(&state.path_gitdir_watch, 0);
      +	strbuf_addbuf(&state.path_gitdir_watch, &state.path_worktree_watch);
     @@ builtin/fsmonitor--daemon.c: static int do_as_client__send_flush(void)
      +	return err;
      +}
      +
     - static int is_ipc_daemon_listening(void)
     - {
     - 	return fsmonitor_ipc__get_state() == IPC_STATE__LISTENING;
     - }
     - 
      +static int try_to_run_foreground_daemon(void)
      +{
      +	/*
     @@ builtin/fsmonitor--daemon.c: static int do_as_client__send_flush(void)
      +	 * However, this method gives us a nicer error message for a
      +	 * common error case.
      +	 */
     -+	if (is_ipc_daemon_listening())
     ++	if (fsmonitor_ipc__get_state() == IPC_STATE__LISTENING)
      +		die("fsmonitor--daemon is already running.");
      +
      +	return !!fsmonitor_run_daemon();
     @@ builtin/fsmonitor--daemon.c: static int do_as_client__send_flush(void)
      +
      +	strvec_push(&args, git_exe);
      +	strvec_push(&args, "fsmonitor--daemon");
     -+	strvec_push(&args, "--run");
     ++	strvec_push(&args, "run");
      +
      +	*pid = mingw_spawnvpe(args.v[0], args.v, NULL, NULL, in, out, out);
      +	close(in);
     @@ builtin/fsmonitor--daemon.c: static int do_as_client__send_flush(void)
      +
      +		if (pid_seen == -1)
      +			return error_errno(_("waitpid failed"));
     -+
      +		else if (pid_seen == 0) {
      +			/*
      +			 * The child is still running (this should be
     @@ builtin/fsmonitor--daemon.c: static int do_as_client__send_flush(void)
      +			time(&now);
      +			if (now > time_limit)
      +				return error(_("fsmonitor--daemon not online yet"));
     -+
     -+			continue;
     -+		}
     -+
     -+		else if (pid_seen == pid_child) {
     ++		} else if (pid_seen == pid_child) {
      +			/*
      +			 * The new child daemon process shutdown while
      +			 * it was starting up, so it is not listening
     @@ builtin/fsmonitor--daemon.c: static int do_as_client__send_flush(void)
      +			 * early shutdown as an error.
      +			 */
      +			return error(_("fsmonitor--daemon failed to start"));
     -+		}
     -+
     -+		else
     ++		} else
      +			return error(_("waitpid is confused"));
      +	}
      +}
     @@ builtin/fsmonitor--daemon.c: static int do_as_client__send_flush(void)
      +	 * of creating the background process (and not whether it
      +	 * immediately exited).
      +	 */
     -+	if (is_ipc_daemon_listening())
     ++	if (fsmonitor_ipc__get_state() == IPC_STATE__LISTENING)
      +		die("fsmonitor--daemon is already running.");
      +
      +	/*
     @@ builtin/fsmonitor--daemon.c: static int do_as_client__send_flush(void)
      +
       int cmd_fsmonitor__daemon(int argc, const char **argv, const char *prefix)
       {
     - 	enum daemon_mode {
     - 		UNDEFINED_MODE,
     -+		START,
     -+		RUN,
     - 		STOP,
     - 		IS_RUNNING,
     - 		QUERY,
     -@@ builtin/fsmonitor--daemon.c: int cmd_fsmonitor__daemon(int argc, const char **argv, const char *prefix)
     - 	} mode = UNDEFINED_MODE;
     + 	const char *subcmd;
       
       	struct option options[] = {
     -+		OPT_CMDMODE(0, "start", &mode,
     -+			    N_("run the daemon in the background"),
     -+			    START),
     -+		OPT_CMDMODE(0, "run", &mode,
     -+			    N_("run the daemon in the foreground"), RUN),
     - 		OPT_CMDMODE(0, "stop", &mode, N_("stop the running daemon"),
     - 			    STOP),
     - 
     -@@ builtin/fsmonitor--daemon.c: int cmd_fsmonitor__daemon(int argc, const char **argv, const char *prefix)
     - 			    QUERY_INDEX),
     - 		OPT_CMDMODE(0, "flush", &mode, N_("flush cached filesystem events"),
     - 			    FLUSH),
     -+
     -+		OPT_GROUP(N_("Daemon options")),
      +		OPT_INTEGER(0, "ipc-threads",
      +			    &fsmonitor__ipc_threads,
      +			    N_("use <n> ipc worker threads")),
      +		OPT_INTEGER(0, "start-timeout",
      +			    &fsmonitor__start_timeout_sec,
      +			    N_("Max seconds to wait for background daemon startup")),
     ++
       		OPT_END()
       	};
       
     +@@ builtin/fsmonitor--daemon.c: int cmd_fsmonitor__daemon(int argc, const char **argv, const char *prefix)
       	if (argc == 2 && !strcmp(argv[1], "-h"))
       		usage_with_options(builtin_fsmonitor__daemon_usage, options);
       
      -	git_config(git_default_config, NULL);
      +	git_config(fsmonitor_config, NULL);
       
     + 	subcmd = argv[1];
     + 	argv--;
     +@@ builtin/fsmonitor--daemon.c: int cmd_fsmonitor__daemon(int argc, const char **argv, const char *prefix)
     + 
       	argc = parse_options(argc, argv, prefix, options,
       			     builtin_fsmonitor__daemon_usage, 0);
      +	if (fsmonitor__ipc_threads < 1)
      +		die(_("invalid 'ipc-threads' value (%d)"),
      +		    fsmonitor__ipc_threads);
     - 
     - 	switch (mode) {
     -+	case START:
     ++
     ++	if (!strcmp(subcmd, "start"))
      +		return !!try_to_start_background_daemon();
      +
     -+	case RUN:
     ++	if (!strcmp(subcmd, "run"))
      +		return !!try_to_run_foreground_daemon();
     -+
     - 	case STOP:
     - 		return !!do_as_client__send_stop();
       
     + 	if (!strcmp(subcmd, "stop"))
     + 		return !!do_as_client__send_stop();
      
       ## fsmonitor--daemon.h (new) ##
      @@
     @@ fsmonitor--daemon.h (new)
      +	struct fsmonitor_daemon_backend_data *backend_data;
      +
      +	struct ipc_server_data *ipc_server_data;
     -+
     -+	int test_client_delay_ms;
      +};
      +
      +#endif /* HAVE_FSMONITOR_DAEMON_BACKEND */
 10:  451563314d84 ! 14:  d5ababfd03e9 fsmonitor--daemon: add pathname classification
     @@ Commit message
          Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
      
       ## builtin/fsmonitor--daemon.c ##
     -@@ builtin/fsmonitor--daemon.c: static int handle_client(void *data, const char *command,
     +@@ builtin/fsmonitor--daemon.c: static int handle_client(void *data,
       	return result;
       }
       
     @@ builtin/fsmonitor--daemon.c: static int handle_client(void *data, const char *co
      
       ## fsmonitor--daemon.h ##
      @@ fsmonitor--daemon.h: struct fsmonitor_daemon_state {
     - 	int test_client_delay_ms;
     + 	struct ipc_server_data *ipc_server_data;
       };
       
      +/*
 11:  304fe03034f8 ! 15:  c092cdf2c8b7 fsmonitor--daemon: define token-ids
     @@ Commit message
          Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
      
       ## builtin/fsmonitor--daemon.c ##
     -@@ builtin/fsmonitor--daemon.c: static int do_as_client__send_flush(void)
     - 	return 0;
     +@@ builtin/fsmonitor--daemon.c: static int do_as_client__status(void)
     + 	}
       }
       
      +/*
     @@ builtin/fsmonitor--daemon.c: static int do_as_client__send_flush(void)
      + *
      + *     "builtin" ":" <token_id> ":" <sequence_nr>
      + *
     ++ * The "builtin" prefix is used as a namespace to avoid conflicts
     ++ * with other providers (such as Watchman).
     ++ *
      + * The <token_id> is an arbitrary OPAQUE string, such as a GUID,
      + * UUID, or {timestamp,pid}.  It is used to group all filesystem
      + * events that happened while the daemon was monitoring (and in-sync
     @@ builtin/fsmonitor--daemon.c: static int do_as_client__send_flush(void)
      + *     (There are too many race conditions to rely on file system
      + *     event timestamps.)
      + *
     -+ * The <sequence_nr> is a simple integer incremented for each event
     -+ * received.  When a new <token_id> is created, the <sequence_nr> is
     -+ * reset to zero.
     ++ * The <sequence_nr> is a simple integer incremented whenever the
     ++ * daemon needs to make its state public.  For example, if 1000 file
     ++ * system events come in, but no clients have requested the data,
     ++ * the daemon can continue to accumulate file changes in the same
     ++ * bin and does not need to advance the sequence number.  However,
     ++ * as soon as a client does arrive, the daemon needs to start a new
     ++ * bin and increment the sequence number.
     ++ *
     ++ *     The sequence number serves as the boundary between 2 sets
     ++ *     of bins -- the older ones that the client has already seen
     ++ *     and the newer ones that it hasn't.
     ++ *
     ++ * When a new <token_id> is created, the <sequence_nr> is reset to
     ++ * zero.
      + *
      + *
      + * About Token Ids
     @@ builtin/fsmonitor--daemon.c: static int do_as_client__send_flush(void)
      + * [3] in response to a client "flush" command (for dropped event
      + *     testing).
      + *
     -+ * [4] MAYBE We might want to change the token_id after very complex
     -+ *     filesystem operations are performed, such as a directory move
     -+ *     sequence that affects many files within.  It might be simpler
     -+ *     to just give up and fake a re-sync (and let the client do a
     -+ *     full scan) than try to enumerate the effects of such a change.
     -+ *
      + * When a new token_id is created, the daemon is free to discard all
      + * cached filesystem events associated with any previous token_ids.
      + * Events associated with a non-current token_id will never be sent
     @@ builtin/fsmonitor--daemon.c: static int do_as_client__send_flush(void)
      +	static uint64_t flush_count = 0;
      +	struct fsmonitor_token_data *token;
      +
     -+	token = (struct fsmonitor_token_data *)xcalloc(1, sizeof(*token));
     ++	CALLOC_ARRAY(token, 1);
      +
      +	strbuf_init(&token->token_id, 0);
      +	token->batch_head = NULL;
     @@ builtin/fsmonitor--daemon.c: static int do_as_client__send_flush(void)
      +
       static ipc_server_application_cb handle_client;
       
     - static int handle_client(void *data, const char *command,
     + static int handle_client(void *data,
      @@ builtin/fsmonitor--daemon.c: static int fsmonitor_run_daemon(void)
       
       	pthread_mutex_init(&state.main_lock, NULL);
       	state.error_code = 0;
      -	state.current_token_data = NULL;
      +	state.current_token_data = fsmonitor_new_token_data();
     - 	state.test_client_delay_ms = 0;
       
       	/* Prepare to (recursively) watch the <worktree-root> directory. */
     + 	strbuf_init(&state.path_worktree_watch, 0);
 12:  f1fa803ebe9c ! 16:  2ed7bc3fae7a fsmonitor--daemon: create token-based changed path cache
     @@ Metadata
       ## Commit message ##
          fsmonitor--daemon: create token-based changed path cache
      
     -    Teach fsmonitor--daemon to build lists of changed paths and associate
     +    Teach fsmonitor--daemon to build a list of changed paths and associate
          them with a token-id.  This will be used by the platform-specific
          backends to accumulate changed paths in response to filesystem events.
      
     -    The platform-specific event loops receive batches containing one or
     -    more changed paths.  Their fs listener thread will accumulate them in
     -    a `fsmonitor_batch` (and without locking) and then "publish" them to
     -    associate them with the current token and to make them visible to the
     -    client worker threads.
     +    The platform-specific file system listener thread receives file system
     +    events containing one or more changed pathnames (with whatever bucketing
     +    or grouping that is convenient for the file system).  These paths are
     +    accumulated (without locking) by the file system layer into a `fsmonitor_batch`.
     +
     +    When the file system layer has drained the kernel event queue, it will
     +    "publish" them to our token queue and make them visible to concurrent
     +    client worker threads.  The token layer is free to combine and/or de-dup
     +    paths within these batches for efficient presentation to clients.
      
          Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
      
       ## builtin/fsmonitor--daemon.c ##
     -@@ builtin/fsmonitor--daemon.c: static struct fsmonitor_token_data *fsmonitor_new_token_data(void)
     - 	return token;
     - }
     +@@ builtin/fsmonitor--daemon.c: struct fsmonitor_token_data {
     + 	uint64_t client_ref_count;
     + };
       
      +struct fsmonitor_batch {
      +	struct fsmonitor_batch *next;
     @@ builtin/fsmonitor--daemon.c: static struct fsmonitor_token_data *fsmonitor_new_t
      +	time_t pinned_time;
      +};
      +
     + static struct fsmonitor_token_data *fsmonitor_new_token_data(void)
     + {
     + 	static int test_env_value = -1;
     + 	static uint64_t flush_count = 0;
     + 	struct fsmonitor_token_data *token;
     ++	struct fsmonitor_batch *batch;
     + 
     + 	CALLOC_ARRAY(token, 1);
     ++	batch = fsmonitor_batch__new();
     + 
     + 	strbuf_init(&token->token_id, 0);
     +-	token->batch_head = NULL;
     +-	token->batch_tail = NULL;
     ++	token->batch_head = batch;
     ++	token->batch_tail = batch;
     + 	token->client_ref_count = 0;
     + 
     + 	if (test_env_value < 0)
     +@@ builtin/fsmonitor--daemon.c: static struct fsmonitor_token_data *fsmonitor_new_token_data(void)
     + 		strbuf_addf(&token->token_id, "test_%08x", test_env_value++);
     + 	}
     + 
     ++	/*
     ++	 * We created a new <token_id> and are starting a new series
     ++	 * of tokens with a zero <seq_nr>.
     ++	 *
     ++	 * Since clients cannot guess our new (non test) <token_id>
     ++	 * they will always receive a trivial response (because of the
     ++	 * mismatch on the <token_id>).  The trivial response will
     ++	 * tell them our new <token_id> so that subsequent requests
     ++	 * will be relative to our new series.  (And when sending that
     ++	 * response, we pin the current head of the batch list.)
     ++	 *
     ++	 * Even if the client correctly guesses the <token_id>, their
     ++	 * request of "builtin:<token_id>:0" asks for all changes MORE
     ++	 * RECENT than batch/bin 0.
     ++	 *
     ++	 * This implies that it is a waste to accumulate paths in the
     ++	 * initial batch/bin (because they will never be transmitted).
     ++	 *
     ++	 * So the daemon could be running for days and watching the
     ++	 * file system, but doesn't need to actually accumulate any
     ++	 * paths UNTIL we need to set a reference point for a later
     ++	 * relative request.
     ++	 *
     ++	 * However, it is very useful for testing to always have a
     ++	 * reference point set.  Pin batch 0 to force early file system
     ++	 * events to accumulate.
     ++	 */
     ++	if (test_env_value)
     ++		batch->pinned_time = time(NULL);
     ++
     + 	return token;
     + }
     + 
      +struct fsmonitor_batch *fsmonitor_batch__new(void)
      +{
     -+	struct fsmonitor_batch *batch = xcalloc(1, sizeof(*batch));
     ++	struct fsmonitor_batch *batch;
     ++
     ++	CALLOC_ARRAY(batch, 1);
      +
      +	return batch;
      +}
      +
     -+struct fsmonitor_batch *fsmonitor_batch__free(struct fsmonitor_batch *batch)
     ++struct fsmonitor_batch *fsmonitor_batch__pop(struct fsmonitor_batch *batch)
      +{
      +	struct fsmonitor_batch *next;
      +
     @@ builtin/fsmonitor--daemon.c: static struct fsmonitor_token_data *fsmonitor_new_t
      +static void fsmonitor_batch__combine(struct fsmonitor_batch *batch_dest,
      +				     const struct fsmonitor_batch *batch_src)
      +{
     -+	/* assert state->main_lock */
     -+
      +	size_t k;
      +
      +	ALLOC_GROW(batch_dest->interned_paths,
     @@ builtin/fsmonitor--daemon.c: static struct fsmonitor_token_data *fsmonitor_new_t
      +
      +	strbuf_release(&token->token_id);
      +
     -+	for (p = token->batch_head; p; p = fsmonitor_batch__free(p))
     ++	for (p = token->batch_head; p; p = fsmonitor_batch__pop(p))
      +		;
      +
      +	free(token);
     @@ builtin/fsmonitor--daemon.c: static struct fsmonitor_token_data *fsmonitor_new_t
      + *     We should create a new token and start fresh (as if we just
      + *     booted up).
      + *
     -+ * If there are no readers of the the current token data series, we
     -+ * can free it now.  Otherwise, let the last reader free it.  Either
     -+ * way, the old token data series is no longer associated with our
     -+ * state data.
     ++ * If there are no concurrent threads readering the current token data
     ++ * series, we can free it now.  Otherwise, let the last reader free
     ++ * it.
     ++ *
     ++ * Either way, the old token data series is no longer associated with
     ++ * our state data.
      + */
     -+void fsmonitor_force_resync(struct fsmonitor_daemon_state *state)
     ++static void with_lock__do_force_resync(struct fsmonitor_daemon_state *state)
      +{
     ++	/* assert current thread holding state->main_lock */
     ++
      +	struct fsmonitor_token_data *free_me = NULL;
      +	struct fsmonitor_token_data *new_one = NULL;
      +
      +	new_one = fsmonitor_new_token_data();
      +
     -+	pthread_mutex_lock(&state->main_lock);
     -+
     -+	trace_printf_key(&trace_fsmonitor,
     -+			 "force resync [old '%s'][new '%s']",
     -+			 state->current_token_data->token_id.buf,
     -+			 new_one->token_id.buf);
     -+
      +	if (state->current_token_data->client_ref_count == 0)
      +		free_me = state->current_token_data;
      +	state->current_token_data = new_one;
      +
     -+	pthread_mutex_unlock(&state->main_lock);
     -+
      +	fsmonitor_free_token_data(free_me);
      +}
     ++
     ++void fsmonitor_force_resync(struct fsmonitor_daemon_state *state)
     ++{
     ++	pthread_mutex_lock(&state->main_lock);
     ++	with_lock__do_force_resync(state);
     ++	pthread_mutex_unlock(&state->main_lock);
     ++}
      +
       static ipc_server_application_cb handle_client;
       
     - static int handle_client(void *data, const char *command,
     + static int handle_client(void *data,
      @@ builtin/fsmonitor--daemon.c: enum fsmonitor_path_type fsmonitor_classify_path_absolute(
       	return fsmonitor_classify_path_gitdir_relative(rel);
       }
     @@ builtin/fsmonitor--daemon.c: enum fsmonitor_path_type fsmonitor_classify_path_ab
      +
      +		head = state->current_token_data->batch_head;
      +		if (!head) {
     -+			batch->batch_seq_nr = 0;
     -+			batch->next = NULL;
     -+			state->current_token_data->batch_head = batch;
     -+			state->current_token_data->batch_tail = batch;
     ++			BUG("token does not have batch");
      +		} else if (head->pinned_time) {
      +			/*
      +			 * We cannot alter the current batch list
     @@ builtin/fsmonitor--daemon.c: enum fsmonitor_path_type fsmonitor_classify_path_ab
      +			batch->batch_seq_nr = head->batch_seq_nr + 1;
      +			batch->next = head;
      +			state->current_token_data->batch_head = batch;
     ++		} else if (!head->batch_seq_nr) {
     ++			/*
     ++			 * Batch 0 is unpinned.  See the note in
     ++			 * `fsmonitor_new_token_data()` about why we
     ++			 * don't need to accumulate these paths.
     ++			 */
     ++			fsmonitor_batch__pop(batch);
      +		} else if (head->nr + batch->nr > MY_COMBINE_LIMIT) {
      +			/*
      +			 * The head batch in the list has never been
     @@ builtin/fsmonitor--daemon.c: enum fsmonitor_path_type fsmonitor_classify_path_ab
      +			 * batch onto the end of the current head batch.
      +			 */
      +			fsmonitor_batch__combine(head, batch);
     -+			fsmonitor_batch__free(batch);
     ++			fsmonitor_batch__pop(batch);
      +		}
      +	}
      +
     @@ fsmonitor--daemon.h
      +/*
      + * Free this batch and return the value of the batch->next field.
      + */
     -+struct fsmonitor_batch *fsmonitor_batch__free(struct fsmonitor_batch *batch);
     ++struct fsmonitor_batch *fsmonitor_batch__pop(struct fsmonitor_batch *batch);
      +
      +/*
      + * Add this path to this batch of modified files.
 13:  a57ddb3bc7cc ! 17:  9ea4b04b8215 fsmonitor-fs-listen-win32: implement FSMonitor backend on Windows
     @@ compat/fsmonitor/fsmonitor-fs-listen-win32.c
      +		return NULL;
      +	}
      +
     -+	watch = xcalloc(1, sizeof(*watch));
     ++	CALLOC_ARRAY(watch, 1);
      +
      +	watch->buf_len = sizeof(watch->buffer); /* assume full MAX_RDCW_BUF */
      +
     @@ compat/fsmonitor/fsmonitor-fs-listen-win32.c
      +	watch->overlapped.hEvent = watch->hEvent;
      +
      +start_watch:
     ++	/*
     ++	 * Queue an async call using Overlapped IO.  This returns immediately.
     ++	 * Our event handle will be signalled when the real result is available.
     ++	 *
     ++	 * The return value here just means that we successfully queued it.
     ++	 * We won't know if the Read...() actually produces data until later.
     ++	 */
      +	watch->is_active = ReadDirectoryChangesW(
      +		watch->hDir, watch->buffer, watch->buf_len, TRUE,
      +		dwNotifyFilter, &watch->count, &watch->overlapped, NULL);
      +
     ++	/*
     ++	 * The kernel throws an invalid parameter error when our buffer
     ++	 * is too big and we are pointed at a remote directory (and possibly
     ++	 * for other reasons).  Quietly set it down and try again.
     ++	 *
     ++	 * See note about MAX_RDCW_BUF at the top.
     ++	 */
      +	if (!watch->is_active &&
      +	    GetLastError() == ERROR_INVALID_PARAMETER &&
      +	    watch->buf_len > MAX_RDCW_BUF_FALLBACK) {
     @@ compat/fsmonitor/fsmonitor-fs-listen-win32.c
      +{
      +	watch->is_active = FALSE;
      +
     ++	/*
     ++	 * The overlapped result is ready.  If the Read...() was successful
     ++	 * we finally receive the actual result into our buffer.
     ++	 */
      +	if (GetOverlappedResult(watch->hDir, &watch->overlapped, &watch->count,
      +				TRUE))
      +		return 0;
      +
     -+	// TODO If an external <gitdir> is deleted, the above returns an error.
     -+	// TODO I'm not sure that there's anything that we can do here other
     -+	// TODO than failing -- the <worktree>/.git link file would be broken
     -+	// TODO anyway.  We might try to check for that and return a better
     -+	// TODO error message.
     ++	/*
     ++	 * NEEDSWORK: If an external <gitdir> is deleted, the above
     ++	 * returns an error.  I'm not sure that there's anything that
     ++	 * we can do here other than failing -- the <worktree>/.git
     ++	 * link file would be broken anyway.  We might try to check
     ++	 * for that and return a better error message, but I'm not
     ++	 * sure it is worth it.
     ++	 */
      +
      +	error("GetOverlappedResult failed on '%s' [GLE %ld]",
      +	      watch->path.buf, GetLastError());
     @@ compat/fsmonitor/fsmonitor-fs-listen-win32.c
      +	if (!watch || !watch->is_active)
      +		return;
      +
     ++	/*
     ++	 * The calls to ReadDirectoryChangesW() and GetOverlappedResult()
     ++	 * form a "pair" (my term) where we queue an IO and promise to
     ++	 * hang around and wait for the kernel to give us the result.
     ++	 *
     ++	 * If for some reason after we queue the IO, we have to quit
     ++	 * or otherwise not stick around for the second half, we must
     ++	 * tell the kernel to abort the IO.  This prevents the kernel
     ++	 * from writing to our buffer and/or signalling our event
     ++	 * after we free them.
     ++	 *
     ++	 * (Ask me how much fun it was to track that one down).
     ++	 */
      +	CancelIoEx(watch->hDir, &watch->overlapped);
      +	GetOverlappedResult(watch->hDir, &watch->overlapped, &count, TRUE);
      +	watch->is_active = FALSE;
     @@ compat/fsmonitor/fsmonitor-fs-listen-win32.c
      +	/*
      +	 * If the kernel gets more events than will fit in the kernel
      +	 * buffer associated with our RDCW handle, it drops them and
     -+	 * returns a count of zero.  (A successful call, but with
     -+	 * length zero.)
     ++	 * returns a count of zero.
     ++	 *
     ++	 * Yes, the call returns WITHOUT error and with length zero.
     ++	 *
     ++	 * (The "overflow" case is not ambiguous with the "no data" case
     ++	 * because we did an INFINITE wait.)
     ++	 *
     ++	 * This means we have a gap in coverage.  Tell the daemon layer
     ++	 * to resync.
      +	 */
      +	if (!watch->count) {
      +		trace2_data_string("fsmonitor", NULL, "fsm-listen/kernel",
     @@ compat/fsmonitor/fsmonitor-fs-listen-win32.c
      +		default:
      +			BUG("unexpected path classification '%d' for '%s'",
      +			    t, path.buf);
     -+			goto skip_this_path;
      +		}
      +
      +skip_this_path:
     @@ compat/fsmonitor/fsmonitor-fs-listen-win32.c
      +	return LISTENER_HAVE_DATA_WORKTREE;
      +
      +force_shutdown:
     -+	fsmonitor_batch__free(batch);
     ++	fsmonitor_batch__pop(batch);
      +	string_list_clear(&cookie_list, 0);
      +	strbuf_release(&path);
      +	return LISTENER_SHUTDOWN;
      +}
      +
      +/*
     -+ * Process filesystem events that happend anywhere (recursively) under the
     ++ * Process filesystem events that happened anywhere (recursively) under the
      + * external <gitdir> (such as non-primary worktrees or submodules).
      + * We only care about cookie files that our client threads created here.
      + *
     @@ compat/fsmonitor/fsmonitor-fs-listen-win32.c
      +		default:
      +			BUG("unexpected path classification '%d' for '%s'",
      +			    t, path.buf);
     -+			goto skip_this_path;
      +		}
      +
      +skip_this_path:
     @@ compat/fsmonitor/fsmonitor-fs-listen-win32.c
       {
      +	struct fsmonitor_daemon_backend_data *data;
      +
     -+	data = xcalloc(1, sizeof(*data));
     ++	CALLOC_ARRAY(data, 1);
      +
      +	data->hEventShutdown = CreateEvent(NULL, TRUE, FALSE, NULL);
      +
 14:  67fa7c7b8ac7 = 18:  21b2b4f941b2 fsmonitor-fs-listen-macos: add macos header files for FSEvent
 15:  d469d3f02e33 ! 19:  08474bad8303 fsmonitor-fs-listen-macos: implement FSEvent listener on MacOS
     @@ compat/fsmonitor/fsmonitor-fs-listen-macos.c: void FSEventStreamRelease(FSEventS
      +		ef & kFSEventStreamEventFlagItemRenamed);
      +}
      +
     ++static int ef_is_dropped(const FSEventStreamEventFlags ef)
     ++{
     ++	return (ef & kFSEventStreamEventFlagKernelDropped ||
     ++		ef & kFSEventStreamEventFlagUserDropped);
     ++}
     ++
      +static void fsevent_callback(ConstFSEventStreamRef streamRef,
      +			     void *ctx,
      +			     size_t num_of_events,
     @@ compat/fsmonitor/fsmonitor-fs-listen-macos.c: void FSEventStreamRelease(FSEventS
      +	const char *path_k;
      +	const char *slash;
      +	int k;
     ++	struct strbuf tmp = STRBUF_INIT;
      +
      +	/*
      +	 * Build a list of all filesystem changes into a private/local
     @@ compat/fsmonitor/fsmonitor-fs-listen-macos.c: void FSEventStreamRelease(FSEventS
      +		 * If you want to debug FSEvents, log them to GIT_TRACE_FSMONITOR.
      +		 * Please don't log them to Trace2.
      +		 *
     -+		 * trace_printf_key(&trace_fsmonitor, "XXX '%s'", path_k);
     ++		 * trace_printf_key(&trace_fsmonitor, "Path: '%s'", path_k);
      +		 */
      +
      +		/*
     @@ compat/fsmonitor/fsmonitor-fs-listen-macos.c: void FSEventStreamRelease(FSEventS
      +		 *     they are conceptually relative to the just flushed
      +		 *     token).
      +		 */
     -+		if ((event_flags[k] & kFSEventStreamEventFlagKernelDropped) ||
     -+		    (event_flags[k] & kFSEventStreamEventFlagUserDropped)) {
     ++		if (ef_is_dropped(event_flags[k])) {
      +			/*
      +			 * see also kFSEventStreamEventFlagMustScanSubDirs
      +			 */
     -+			trace2_data_string("fsmonitor", NULL,
     -+					   "fsm-listen/kernel", "dropped");
     ++			trace_printf_key(&trace_fsmonitor, "event: dropped");
      +
      +			fsmonitor_force_resync(state);
     -+
     -+			if (fsmonitor_batch__free(batch))
     -+				BUG("batch should not have a next");
     ++			fsmonitor_batch__pop(batch);
      +			string_list_clear(&cookie_list, 0);
      +
      +			/*
     @@ compat/fsmonitor/fsmonitor-fs-listen-macos.c: void FSEventStreamRelease(FSEventS
      +			 * we have to quit.
      +			 */
      +			if (ef_is_root_delete(event_flags[k])) {
     -+				trace2_data_string("fsmonitor", NULL,
     -+						   "fsm-listen/gitdir",
     -+						   "removed");
     ++				trace_printf_key(&trace_fsmonitor,
     ++						 "event: gitdir removed");
      +				goto force_shutdown;
      +			}
      +			if (ef_is_root_renamed(event_flags[k])) {
     -+				trace2_data_string("fsmonitor", NULL,
     -+						   "fsm-listen/gitdir",
     -+						   "renamed");
     ++				trace_printf_key(&trace_fsmonitor,
     ++						 "event: gitdir renamed");
      +				goto force_shutdown;
      +			}
      +			break;
     @@ compat/fsmonitor/fsmonitor-fs-listen-macos.c: void FSEventStreamRelease(FSEventS
      +			if (trace_pass_fl(&trace_fsmonitor))
      +				log_flags_set(path_k, event_flags[k]);
      +
     -+			/* fsevent could be marked as both a file and directory */
     ++			/*
     ++			 * Because of the implicit "binning" (the
     ++			 * kernel calls us at a given frequency) and
     ++			 * de-duping (the kernel is free to combine
     ++			 * multiple events for a given pathname), an
     ++			 * individual fsevent could be marked as both
     ++			 * a file and directory.  Add it to the queue
     ++			 * with both spellings so that the client will
     ++			 * know how much to invalidate/refresh.
     ++			 */
      +
      +			if (event_flags[k] & kFSEventStreamEventFlagItemIsFile) {
      +				const char *rel = path_k +
     @@ compat/fsmonitor/fsmonitor-fs-listen-macos.c: void FSEventStreamRelease(FSEventS
      +			if (event_flags[k] & kFSEventStreamEventFlagItemIsDir) {
      +				const char *rel = path_k +
      +					state->path_worktree_watch.len + 1;
     -+				char *p = xstrfmt("%s/", rel);
     ++
     ++				strbuf_reset(&tmp);
     ++				strbuf_addstr(&tmp, rel);
     ++				strbuf_addch(&tmp, '/');
      +
      +				if (!batch)
      +					batch = fsmonitor_batch__new();
     -+				fsmonitor_batch__add_path(batch, p);
     -+
     -+				free(p);
     ++				fsmonitor_batch__add_path(batch, tmp.buf);
      +			}
      +
      +			break;
     @@ compat/fsmonitor/fsmonitor-fs-listen-macos.c: void FSEventStreamRelease(FSEventS
      +
      +	fsmonitor_publish(state, batch, &cookie_list);
      +	string_list_clear(&cookie_list, 0);
     ++	strbuf_release(&tmp);
      +	return;
      +
      +force_shutdown:
     -+	if (fsmonitor_batch__free(batch))
     -+		BUG("batch should not have a next");
     ++	fsmonitor_batch__pop(batch);
      +	string_list_clear(&cookie_list, 0);
      +
      +	data->shutdown_style = FORCE_SHUTDOWN;
      +	CFRunLoopStop(data->rl);
     ++	strbuf_release(&tmp);
      +	return;
      +}
      +
      +/*
     -+ * TODO Investigate the proper value for the `latency` argument in the call
     -+ * TODO to `FSEventStreamCreate()`.  I'm not sure that this needs to be a
     -+ * TODO config setting or just something that we tune after some testing.
     -+ * TODO
     -+ * TODO With a latency of 0.1, I was seeing lots of dropped events during
     -+ * TODO the "touch 100000" files test within t/perf/p7519, but with a
     -+ * TODO latency of 0.001 I did not see any dropped events.  So the "correct"
     -+ * TODO value may be somewhere in between.
     -+ * TODO
     -+ * TODO https://developer.apple.com/documentation/coreservices/1443980-fseventstreamcreate
     ++ * NEEDSWORK: Investigate the proper value for the `latency` argument
     ++ * in the call to `FSEventStreamCreate()`.  I'm not sure that this
     ++ * needs to be a config setting or just something that we tune after
     ++ * some testing.
     ++ *
     ++ * With a latency of 0.1, I was seeing lots of dropped events during
     ++ * the "touch 100000" files test within t/perf/p7519, but with a
     ++ * latency of 0.001 I did not see any dropped events.  So the
     ++ * "correct" value may be somewhere in between.
     ++ *
     ++ * https://developer.apple.com/documentation/coreservices/1443980-fseventstreamcreate
      + */
       
       int fsmonitor_fs_listen__ctor(struct fsmonitor_daemon_state *state)
     @@ compat/fsmonitor/fsmonitor-fs-listen-macos.c: void FSEventStreamRelease(FSEventS
      +	struct fsmonitor_daemon_backend_data *data;
      +	const void *dir_array[2];
      +
     -+	data = xcalloc(1, sizeof(*data));
     ++	CALLOC_ARRAY(data, 1);
      +	state->backend_data = data;
      +
      +	data->cfsr_worktree_path = CFStringCreateWithCString(
 16:  2b4ae4fc3d62 ! 20:  cc4a596d17c7 fsmonitor--daemon: implement handle_client callback
     @@ builtin/fsmonitor--daemon.c
      +#include "pkt-line.h"
       
       static const char * const builtin_fsmonitor__daemon_usage[] = {
     - 	N_("git fsmonitor--daemon --start [<options>]"),
     + 	N_("git fsmonitor--daemon start [<options>]"),
      @@ builtin/fsmonitor--daemon.c: void fsmonitor_force_resync(struct fsmonitor_daemon_state *state)
     - 	fsmonitor_free_token_data(free_me);
     + 	pthread_mutex_unlock(&state->main_lock);
       }
       
      +/*
      + * Format an opaque token string to send to the client.
      + */
     -+static void fsmonitor_format_response_token(
     ++static void with_lock__format_response_token(
      +	struct strbuf *response_token,
      +	const struct strbuf *response_token_id,
      +	const struct fsmonitor_batch *batch)
      +{
     -+	uint64_t seq_nr = (batch) ? batch->batch_seq_nr + 1 : 0;
     ++	/* assert current thread holding state->main_lock */
      +
      +	strbuf_reset(response_token);
      +	strbuf_addf(response_token, "builtin:%s:%"PRIu64,
     -+		    response_token_id->buf, seq_nr);
     ++		    response_token_id->buf, batch->batch_seq_nr);
      +}
      +
      +/*
      + * Parse an opaque token from the client.
     ++ * Returns -1 on error.
      + */
      +static int fsmonitor_parse_client_token(const char *buf_token,
      +					struct strbuf *requested_token_id,
     @@ builtin/fsmonitor--daemon.c: void fsmonitor_force_resync(struct fsmonitor_daemon
      +	*seq_nr = 0;
      +
      +	if (!skip_prefix(buf_token, "builtin:", &p))
     -+		return 1;
     ++		return -1;
      +
      +	while (*p && *p != ':')
      +		strbuf_addch(requested_token_id, *p++);
      +	if (!*p++)
     -+		return 1;
     ++		return -1;
      +
      +	*seq_nr = (uint64_t)strtoumax(p, &p_end, 10);
      +	if (*p_end)
     -+		return 1;
     ++		return -1;
      +
      +	return 0;
      +}
     @@ builtin/fsmonitor--daemon.c: void fsmonitor_force_resync(struct fsmonitor_daemon
      +	intmax_t count = 0, duplicates = 0;
      +	kh_str_t *shown;
      +	int hash_ret;
     -+	int result;
     ++	int do_trivial = 0;
     ++	int do_flush = 0;
      +
      +	/*
      +	 * We expect `command` to be of the form:
     @@ builtin/fsmonitor--daemon.c: void fsmonitor_force_resync(struct fsmonitor_daemon
      +		 * There is no reply to the client.
      +		 */
      +		return SIMPLE_IPC_QUIT;
     -+	}
      +
     -+	if (!strcmp(command, "flush")) {
     ++	} else if (!strcmp(command, "flush")) {
      +		/*
      +		 * Flush all of our cached data and generate a new token
      +		 * just like if we lost sync with the filesystem.
      +		 *
      +		 * Then send a trivial response using the new token.
      +		 */
     -+		fsmonitor_force_resync(state);
     -+		result = 0;
     -+		goto send_trivial_response;
     -+	}
     ++		do_flush = 1;
     ++		do_trivial = 1;
      +
     -+	if (!skip_prefix(command, "builtin:", &p)) {
     ++	} else if (!skip_prefix(command, "builtin:", &p)) {
      +		/* assume V1 timestamp or garbage */
      +
      +		char *p_end;
     @@ builtin/fsmonitor--daemon.c: void fsmonitor_force_resync(struct fsmonitor_daemon
      +				  "fsmonitor: invalid command line '%s'" :
      +				  "fsmonitor: unsupported V1 protocol '%s'"),
      +				 command);
     -+		result = -1;
     -+		goto send_trivial_response;
     ++		do_trivial = 1;
     ++
     ++	} else {
     ++		/* We have "builtin:*" */
     ++		if (fsmonitor_parse_client_token(command, &requested_token_id,
     ++						 &requested_oldest_seq_nr)) {
     ++			trace_printf_key(&trace_fsmonitor,
     ++					 "fsmonitor: invalid V2 protocol token '%s'",
     ++					 command);
     ++			do_trivial = 1;
     ++
     ++		} else {
     ++			/*
     ++			 * We have a V2 valid token:
     ++			 *     "builtin:<token_id>:<seq_nr>"
     ++			 */
     ++		}
      +	}
      +
     -+	/* try V2 token */
     ++	pthread_mutex_lock(&state->main_lock);
      +
     -+	if (fsmonitor_parse_client_token(command, &requested_token_id,
     -+					 &requested_oldest_seq_nr)) {
     -+		trace_printf_key(&trace_fsmonitor,
     -+				 "fsmonitor: invalid V2 protocol token '%s'",
     -+				 command);
     -+		result = -1;
     -+		goto send_trivial_response;
     -+	}
     ++	if (!state->current_token_data)
     ++		BUG("fsmonitor state does not have a current token");
      +
     -+	pthread_mutex_lock(&state->main_lock);
     ++	if (do_flush)
     ++		with_lock__do_force_resync(state);
      +
     -+	if (!state->current_token_data) {
     -+		/*
     -+		 * We don't have a current token.  This may mean that
     -+		 * the listener thread has not yet started.
     -+		 */
     -+		pthread_mutex_unlock(&state->main_lock);
     -+		result = 0;
     -+		goto send_trivial_response;
     -+	}
     -+	if (strcmp(requested_token_id.buf,
     -+		   state->current_token_data->token_id.buf)) {
     -+		/*
     -+		 * The client last spoke to a different daemon
     -+		 * instance -OR- the daemon had to resync with
     -+		 * the filesystem (and lost events), so reject.
     -+		 */
     -+		pthread_mutex_unlock(&state->main_lock);
     -+		result = 0;
     -+		trace2_data_string("fsmonitor", the_repository,
     -+				   "response/token", "different");
     -+		goto send_trivial_response;
     -+	}
     -+	if (!state->current_token_data->batch_tail) {
     -+		/*
     -+		 * The listener has not received any filesystem
     -+		 * events yet since we created the current token.
     -+		 * We can respond with an empty list, since the
     -+		 * client has already seen the current token and
     -+		 * we have nothing new to report.  (This is
     -+		 * instead of sending a trivial response.)
     -+		 */
     -+		pthread_mutex_unlock(&state->main_lock);
     -+		result = 0;
     -+		goto send_empty_response;
     ++	/*
     ++	 * We mark the current head of the batch list as "pinned" so
     ++	 * that the listener thread will treat this item as read-only
     ++	 * (and prevent any more paths from being added to it) from
     ++	 * now on.
     ++	 */
     ++	token_data = state->current_token_data;
     ++	batch_head = token_data->batch_head;
     ++	((struct fsmonitor_batch *)batch_head)->pinned_time = time(NULL);
     ++
     ++	/*
     ++	 * FSMonitor Protocol V2 requires that we send a response header
     ++	 * with a "new current token" and then all of the paths that changed
     ++	 * since the "requested token".  We send the seq_nr of the just-pinned
     ++	 * head batch so that future requests from a client will be relative
     ++	 * to it.
     ++	 */
     ++	with_lock__format_response_token(&response_token,
     ++					 &token_data->token_id, batch_head);
     ++
     ++	reply(reply_data, response_token.buf, response_token.len + 1);
     ++	total_response_len += response_token.len + 1;
     ++
     ++	trace2_data_string("fsmonitor", the_repository, "response/token",
     ++			   response_token.buf);
     ++	trace_printf_key(&trace_fsmonitor, "response token: %s",
     ++			 response_token.buf);
     ++
     ++	if (!do_trivial) {
     ++		if (strcmp(requested_token_id.buf, token_data->token_id.buf)) {
     ++			/*
     ++			 * The client last spoke to a different daemon
     ++			 * instance -OR- the daemon had to resync with
     ++			 * the filesystem (and lost events), so reject.
     ++			 */
     ++			trace2_data_string("fsmonitor", the_repository,
     ++					   "response/token", "different");
     ++			do_trivial = 1;
     ++
     ++		} else if (requested_oldest_seq_nr <
     ++			   token_data->batch_tail->batch_seq_nr) {
     ++			/*
     ++			 * The client wants older events than we have for
     ++			 * this token_id.  This means that the end of our
     ++			 * batch list was truncated and we cannot give the
     ++			 * client a complete snapshot relative to their
     ++			 * request.
     ++			 */
     ++			trace_printf_key(&trace_fsmonitor,
     ++					 "client requested truncated data");
     ++			do_trivial = 1;
     ++		}
      +	}
     -+	if (requested_oldest_seq_nr <
     -+	    state->current_token_data->batch_tail->batch_seq_nr) {
     -+		/*
     -+		 * The client wants older events than we have for
     -+		 * this token_id.  This means that the end of our
     -+		 * batch list was truncated and we cannot give the
     -+		 * client a complete snapshot relative to their
     -+		 * request.
     -+		 */
     ++
     ++	if (do_trivial) {
      +		pthread_mutex_unlock(&state->main_lock);
      +
     -+		trace_printf_key(&trace_fsmonitor,
     -+				 "client requested truncated data");
     -+		result = 0;
     -+		goto send_trivial_response;
     ++		reply(reply_data, "/", 2);
     ++
     ++		trace2_data_intmax("fsmonitor", the_repository,
     ++				   "response/trivial", 1);
     ++
     ++		strbuf_release(&response_token);
     ++		strbuf_release(&requested_token_id);
     ++		return 0;
      +	}
      +
      +	/*
     @@ builtin/fsmonitor--daemon.c: void fsmonitor_force_resync(struct fsmonitor_daemon
      +	 *
      +	 * AND it allows the listener thread to do a token-reset
      +	 * (and install a new `current_token_data`).
     -+	 *
     -+	 * We mark the current head of the batch list as "pinned" so
     -+	 * that the listener thread will treat this item as read-only
     -+	 * (and prevent any more paths from being added to it) from
     -+	 * now on.
      +	 */
     -+	token_data = state->current_token_data;
      +	token_data->client_ref_count++;
      +
     -+	batch_head = token_data->batch_head;
     -+	((struct fsmonitor_batch *)batch_head)->pinned_time = time(NULL);
     -+
      +	pthread_mutex_unlock(&state->main_lock);
      +
      +	/*
     -+	 * FSMonitor Protocol V2 requires that we send a response header
     -+	 * with a "new current token" and then all of the paths that changed
     -+	 * since the "requested token".
     ++	 * The client request is relative to the token that they sent,
     ++	 * so walk the batch list backwards from the current head back
     ++	 * to the batch (sequence number) they named.
     ++	 *
     ++	 * We use khash to de-dup the list of pathnames.
     ++	 *
     ++	 * NEEDSWORK: each batch contains a list of interned strings,
     ++	 * so we only need to do pointer comparisons here to build the
     ++	 * hash table.  Currently, we're still comparing the string
     ++	 * values.
      +	 */
     -+	fsmonitor_format_response_token(&response_token,
     -+					&token_data->token_id,
     -+					batch_head);
     -+
     -+	reply(reply_data, response_token.buf, response_token.len + 1);
     -+	total_response_len += response_token.len + 1;
     -+
     -+	trace2_data_string("fsmonitor", the_repository, "response/token",
     -+			   response_token.buf);
     -+	trace_printf_key(&trace_fsmonitor, "response token: %s", response_token.buf);
     -+
      +	shown = kh_init_str();
      +	for (batch = batch_head;
     -+	     batch && batch->batch_seq_nr >= requested_oldest_seq_nr;
     ++	     batch && batch->batch_seq_nr > requested_oldest_seq_nr;
      +	     batch = batch->next) {
      +		size_t k;
      +
     @@ builtin/fsmonitor--daemon.c: void fsmonitor_force_resync(struct fsmonitor_daemon
      +	kh_release_str(shown);
      +
      +	pthread_mutex_lock(&state->main_lock);
     ++
      +	if (token_data->client_ref_count > 0)
      +		token_data->client_ref_count--;
      +
     @@ builtin/fsmonitor--daemon.c: void fsmonitor_force_resync(struct fsmonitor_daemon
      +	strbuf_release(&payload);
      +
      +	return 0;
     -+
     -+send_trivial_response:
     -+	pthread_mutex_lock(&state->main_lock);
     -+	fsmonitor_format_response_token(&response_token,
     -+					&state->current_token_data->token_id,
     -+					state->current_token_data->batch_head);
     -+	pthread_mutex_unlock(&state->main_lock);
     -+
     -+	reply(reply_data, response_token.buf, response_token.len + 1);
     -+	trace2_data_string("fsmonitor", the_repository, "response/token",
     -+			   response_token.buf);
     -+	reply(reply_data, "/", 2);
     -+	trace2_data_intmax("fsmonitor", the_repository, "response/trivial", 1);
     -+
     -+	strbuf_release(&response_token);
     -+	strbuf_release(&requested_token_id);
     -+
     -+	return result;
     -+
     -+send_empty_response:
     -+	pthread_mutex_lock(&state->main_lock);
     -+	fsmonitor_format_response_token(&response_token,
     -+					&state->current_token_data->token_id,
     -+					NULL);
     -+	pthread_mutex_unlock(&state->main_lock);
     -+
     -+	reply(reply_data, response_token.buf, response_token.len + 1);
     -+	trace2_data_string("fsmonitor", the_repository, "response/token",
     -+			   response_token.buf);
     -+	trace2_data_intmax("fsmonitor", the_repository, "response/empty", 1);
     -+
     -+	strbuf_release(&response_token);
     -+	strbuf_release(&requested_token_id);
     -+
     -+	return 0;
      +}
      +
       static ipc_server_application_cb handle_client;
       
     - static int handle_client(void *data, const char *command,
     + static int handle_client(void *data,
     +@@ builtin/fsmonitor--daemon.c: static int handle_client(void *data,
       			 ipc_server_reply_cb *reply,
       			 struct ipc_server_reply_data *reply_data)
       {
     @@ builtin/fsmonitor--daemon.c: void fsmonitor_force_resync(struct fsmonitor_daemon
      +	struct fsmonitor_daemon_state *state = data;
       	int result;
       
     + 	/*
     +@@ builtin/fsmonitor--daemon.c: static int handle_client(void *data,
     + 	if (command_len != strlen(command))
     + 		BUG("FSMonitor assumes text messages");
     + 
      +	trace_printf_key(&trace_fsmonitor, "requested token: %s", command);
      +
       	trace2_region_enter("fsmonitor", "handle_client", the_repository);
 17:  9f263e70c724 ! 21:  f0da90e9b050 fsmonitor--daemon: periodically truncate list of modified files
     @@ Commit message
          relative to this new token).
      
          Therefore, the daemon can gradually truncate the in-memory list of
     -    changed paths as they become obsolete (older that the previous token).
     +    changed paths as they become obsolete (older than the previous token).
          Since we may have multiple clients making concurrent requests with a
          skew of tokens and clients may be racing to the talk to the daemon,
          we lazily truncate the list.
     @@ builtin/fsmonitor--daemon.c: static void fsmonitor_batch__combine(struct fsmonit
      + * artificial (based on when we pinned the batch item) and not on any
      + * filesystem activity.
      + */
     -+#define MY_TIME_DELAY (5 * 60) /* seconds */
     ++#define MY_TIME_DELAY_SECONDS (5 * 60) /* seconds */
      +
     -+static void fsmonitor_batch__truncate(struct fsmonitor_daemon_state *state,
     -+				      const struct fsmonitor_batch *batch_marker)
     ++static void with_lock__truncate_old_batches(
     ++	struct fsmonitor_daemon_state *state,
     ++	const struct fsmonitor_batch *batch_marker)
      +{
     -+	/* assert state->main_lock */
     ++	/* assert current thread holding state->main_lock */
      +
      +	const struct fsmonitor_batch *batch;
      +	struct fsmonitor_batch *rest;
      +	struct fsmonitor_batch *p;
     -+	time_t t;
      +
      +	if (!batch_marker)
      +		return;
      +
     -+	trace_printf_key(&trace_fsmonitor, "TRNC mark (%"PRIu64",%"PRIu64")",
     ++	trace_printf_key(&trace_fsmonitor, "Truncate: mark (%"PRIu64",%"PRIu64")",
      +			 batch_marker->batch_seq_nr,
      +			 (uint64_t)batch_marker->pinned_time);
      +
      +	for (batch = batch_marker; batch; batch = batch->next) {
     ++		time_t t;
     ++
      +		if (!batch->pinned_time) /* an overflow batch */
      +			continue;
      +
     -+		t = batch->pinned_time + MY_TIME_DELAY;
     ++		t = batch->pinned_time + MY_TIME_DELAY_SECONDS;
      +		if (t > batch_marker->pinned_time) /* too close to marker */
      +			continue;
      +
     @@ builtin/fsmonitor--daemon.c: static void fsmonitor_batch__combine(struct fsmonit
      +	rest = ((struct fsmonitor_batch *)batch)->next;
      +	((struct fsmonitor_batch *)batch)->next = NULL;
      +
     -+	for (p = rest; p; p = fsmonitor_batch__free(p)) {
     ++	for (p = rest; p; p = fsmonitor_batch__pop(p)) {
      +		trace_printf_key(&trace_fsmonitor,
     -+				 "TRNC kill (%"PRIu64",%"PRIu64")",
     ++				 "Truncate: kill (%"PRIu64",%"PRIu64")",
      +				 p->batch_seq_nr, (uint64_t)p->pinned_time);
      +	}
      +}
     @@ builtin/fsmonitor--daemon.c: static int do_handle_client(struct fsmonitor_daemon
      +			 * obsolete.  See if we can truncate the list
      +			 * and save some memory.
      +			 */
     -+			fsmonitor_batch__truncate(state, batch);
     ++			with_lock__truncate_old_batches(state, batch);
       		}
       	}
       
 18:  c6d5f045fb56 <  -:  ------------ fsmonitor--daemon:: introduce client delay for testing
 19:  038b62dc6744 ! 22:  bb7b1912bb47 fsmonitor--daemon: use a cookie file to sync with file system
     @@ Commit message
          Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
      
       ## builtin/fsmonitor--daemon.c ##
     -@@ builtin/fsmonitor--daemon.c: static int do_as_client__send_flush(void)
     - 	return 0;
     +@@ builtin/fsmonitor--daemon.c: static int do_as_client__status(void)
     + 	}
       }
       
      +enum fsmonitor_cookie_item_result {
     @@ builtin/fsmonitor--daemon.c: static int do_as_client__send_flush(void)
      +	return strcmp(a->name, keydata ? keydata : b->name);
      +}
      +
     -+static enum fsmonitor_cookie_item_result fsmonitor_wait_for_cookie(
     ++static enum fsmonitor_cookie_item_result with_lock__wait_for_cookie(
      +	struct fsmonitor_daemon_state *state)
      +{
     ++	/* assert current thread holding state->main_lock */
     ++
      +	int fd;
     -+	struct fsmonitor_cookie_item cookie;
     ++	struct fsmonitor_cookie_item *cookie;
      +	struct strbuf cookie_pathname = STRBUF_INIT;
      +	struct strbuf cookie_filename = STRBUF_INIT;
     -+	const char *slash;
     ++	enum fsmonitor_cookie_item_result result;
      +	int my_cookie_seq;
      +
     -+	pthread_mutex_lock(&state->main_lock);
     ++	CALLOC_ARRAY(cookie, 1);
      +
      +	my_cookie_seq = state->cookie_seq++;
      +
     ++	strbuf_addf(&cookie_filename, "%i-%i", getpid(), my_cookie_seq);
     ++
      +	strbuf_addbuf(&cookie_pathname, &state->path_cookie_prefix);
     -+	strbuf_addf(&cookie_pathname, "%i-%i", getpid(), my_cookie_seq);
     -+
     -+	slash = find_last_dir_sep(cookie_pathname.buf);
     -+	if (slash)
     -+		strbuf_addstr(&cookie_filename, slash + 1);
     -+	else
     -+		strbuf_addbuf(&cookie_filename, &cookie_pathname);
     -+	cookie.name = strbuf_detach(&cookie_filename, NULL);
     -+	cookie.result = FCIR_INIT;
     -+	// TODO should we have case-insenstive hash (and in cookie_cmp()) ??
     -+	hashmap_entry_init(&cookie.entry, strhash(cookie.name));
     ++	strbuf_addbuf(&cookie_pathname, &cookie_filename);
      +
     -+	/*
     -+	 * Warning: we are putting the address of a stack variable into a
     -+	 * global hashmap.  This feels dodgy.  We must ensure that we remove
     -+	 * it before this thread and stack frame returns.
     -+	 */
     -+	hashmap_add(&state->cookies, &cookie.entry);
     ++	cookie->name = strbuf_detach(&cookie_filename, NULL);
     ++	cookie->result = FCIR_INIT;
     ++	hashmap_entry_init(&cookie->entry, strhash(cookie->name));
     ++
     ++	hashmap_add(&state->cookies, &cookie->entry);
      +
      +	trace_printf_key(&trace_fsmonitor, "cookie-wait: '%s' '%s'",
     -+			 cookie.name, cookie_pathname.buf);
     ++			 cookie->name, cookie_pathname.buf);
      +
      +	/*
      +	 * Create the cookie file on disk and then wait for a notification
     @@ builtin/fsmonitor--daemon.c: static int do_as_client__send_flush(void)
      +	fd = open(cookie_pathname.buf, O_WRONLY | O_CREAT | O_EXCL, 0600);
      +	if (fd >= 0) {
      +		close(fd);
     -+		unlink_or_warn(cookie_pathname.buf);
     ++		unlink(cookie_pathname.buf);
      +
     -+		while (cookie.result == FCIR_INIT)
     ++		/*
     ++		 * NEEDSWORK: This is an infinite wait (well, unless another
     ++		 * thread sends us an abort).  I'd like to change this to
     ++		 * use `pthread_cond_timedwait()` and return an error/timeout
     ++		 * and let the caller do the trivial response thing.
     ++		 */
     ++		while (cookie->result == FCIR_INIT)
      +			pthread_cond_wait(&state->cookies_cond,
      +					  &state->main_lock);
     -+
     -+		hashmap_remove(&state->cookies, &cookie.entry, NULL);
      +	} else {
      +		error_errno(_("could not create fsmonitor cookie '%s'"),
     -+			    cookie.name);
     ++			    cookie->name);
      +
     -+		cookie.result = FCIR_ERROR;
     -+		hashmap_remove(&state->cookies, &cookie.entry, NULL);
     ++		cookie->result = FCIR_ERROR;
      +	}
      +
     -+	pthread_mutex_unlock(&state->main_lock);
     ++	hashmap_remove(&state->cookies, &cookie->entry, NULL);
     ++
     ++	result = cookie->result;
      +
     -+	free((char*)cookie.name);
     ++	free((char*)cookie->name);
     ++	free(cookie);
      +	strbuf_release(&cookie_pathname);
     -+	return cookie.result;
     ++
     ++	return result;
      +}
      +
      +/*
      + * Mark these cookies as _SEEN and wake up the corresponding client threads.
      + */
     -+static void fsmonitor_cookie_mark_seen(struct fsmonitor_daemon_state *state,
     -+				       const struct string_list *cookie_names)
     ++static void with_lock__mark_cookies_seen(struct fsmonitor_daemon_state *state,
     ++					 const struct string_list *cookie_names)
      +{
     -+	/* assert state->main_lock */
     ++	/* assert current thread holding state->main_lock */
      +
      +	int k;
      +	int nr_seen = 0;
     @@ builtin/fsmonitor--daemon.c: static int do_as_client__send_flush(void)
      +/*
      + * Set _ABORT on all pending cookies and wake up all client threads.
      + */
     -+static void fsmonitor_cookie_abort_all(struct fsmonitor_daemon_state *state)
     ++static void with_lock__abort_all_cookies(struct fsmonitor_daemon_state *state)
      +{
     -+	/* assert state->main_lock */
     ++	/* assert current thread holding state->main_lock */
      +
      +	struct hashmap_iter iter;
      +	struct fsmonitor_cookie_item *cookie;
     @@ builtin/fsmonitor--daemon.c: static int do_as_client__send_flush(void)
      +		pthread_cond_broadcast(&state->cookies_cond);
      +}
      +
     - static int lookup_client_test_delay(void)
     - {
     - 	static int delay_ms = -1;
     + /*
     +  * Requests to and from a FSMonitor Protocol V2 provider use an opaque
     +  * "token" as a virtual timestamp.  Clients can request a summary of all
      @@ builtin/fsmonitor--daemon.c: static void fsmonitor_free_token_data(struct fsmonitor_token_data *token)
        *     We should create a new token and start fresh (as if we just
        *     booted up).
     @@ builtin/fsmonitor--daemon.c: static void fsmonitor_free_token_data(struct fsmoni
      + * [2] Some of those lost events may have been for cookie files.  We
      + *     should assume the worst and abort them rather letting them starve.
      + *
     -  * If there are no readers of the the current token data series, we
     -  * can free it now.  Otherwise, let the last reader free it.  Either
     -  * way, the old token data series is no longer associated with our
     -@@ builtin/fsmonitor--daemon.c: void fsmonitor_force_resync(struct fsmonitor_daemon_state *state)
     - 			 state->current_token_data->token_id.buf,
     - 			 new_one->token_id.buf);
     +  * If there are no concurrent threads readering the current token data
     +  * series, we can free it now.  Otherwise, let the last reader free
     +  * it.
     +@@ builtin/fsmonitor--daemon.c: static void with_lock__do_force_resync(struct fsmonitor_daemon_state *state)
     + 	state->current_token_data = new_one;
       
     -+	fsmonitor_cookie_abort_all(state);
     + 	fsmonitor_free_token_data(free_me);
      +
     - 	if (state->current_token_data->client_ref_count == 0)
     - 		free_me = state->current_token_data;
     - 	state->current_token_data = new_one;
     ++	with_lock__abort_all_cookies(state);
     + }
     + 
     + void fsmonitor_force_resync(struct fsmonitor_daemon_state *state)
      @@ builtin/fsmonitor--daemon.c: static int do_handle_client(struct fsmonitor_daemon_state *state,
     - 	kh_str_t *shown;
       	int hash_ret;
     - 	int result;
     + 	int do_trivial = 0;
     + 	int do_flush = 0;
     ++	int do_cookie = 0;
      +	enum fsmonitor_cookie_item_result cookie_result;
       
       	/*
       	 * We expect `command` to be of the form:
      @@ builtin/fsmonitor--daemon.c: static int do_handle_client(struct fsmonitor_daemon_state *state,
     - 		goto send_trivial_response;
     + 		 */
     + 		do_flush = 1;
     + 		do_trivial = 1;
     ++		do_cookie = 1;
     + 
     + 	} else if (!skip_prefix(command, "builtin:", &p)) {
     + 		/* assume V1 timestamp or garbage */
     +@@ builtin/fsmonitor--daemon.c: static int do_handle_client(struct fsmonitor_daemon_state *state,
     + 				  "fsmonitor: unsupported V1 protocol '%s'"),
     + 				 command);
     + 		do_trivial = 1;
     ++		do_cookie = 1;
     + 
     + 	} else {
     + 		/* We have "builtin:*" */
     +@@ builtin/fsmonitor--daemon.c: static int do_handle_client(struct fsmonitor_daemon_state *state,
     + 					 "fsmonitor: invalid V2 protocol token '%s'",
     + 					 command);
     + 			do_trivial = 1;
     ++			do_cookie = 1;
     + 
     + 		} else {
     + 			/*
     + 			 * We have a V2 valid token:
     + 			 *     "builtin:<token_id>:<seq_nr>"
     + 			 */
     ++			do_cookie = 1;
     + 		}
       	}
       
     -+	pthread_mutex_unlock(&state->main_lock);
     -+
     +@@ builtin/fsmonitor--daemon.c: static int do_handle_client(struct fsmonitor_daemon_state *state,
     + 	if (!state->current_token_data)
     + 		BUG("fsmonitor state does not have a current token");
     + 
      +	/*
     -+	 * Write a cookie file inside the directory being watched in an
     -+	 * effort to flush out existing filesystem events that we actually
     -+	 * care about.  Suspend this client thread until we see the filesystem
     -+	 * events for this cookie file.
     ++	 * Write a cookie file inside the directory being watched in
     ++	 * an effort to flush out existing filesystem events that we
     ++	 * actually care about.  Suspend this client thread until we
     ++	 * see the filesystem events for this cookie file.
     ++	 *
     ++	 * Creating the cookie lets us guarantee that our FS listener
     ++	 * thread has drained the kernel queue and we are caught up
     ++	 * with the kernel.
     ++	 *
     ++	 * If we cannot create the cookie (or otherwise guarantee that
     ++	 * we are caught up), we send a trivial response.  We have to
     ++	 * assume that there might be some very, very recent activity
     ++	 * on the FS still in flight.
      +	 */
     -+	cookie_result = fsmonitor_wait_for_cookie(state);
     -+	if (cookie_result != FCIR_SEEN) {
     -+		error(_("fsmonitor: cookie_result '%d' != SEEN"),
     -+		      cookie_result);
     -+		result = 0;
     -+		goto send_trivial_response;
     -+	}
     -+
     -+	pthread_mutex_lock(&state->main_lock);
     -+
     -+	if (strcmp(requested_token_id.buf,
     -+		   state->current_token_data->token_id.buf)) {
     -+		/*
     -+		 * Ack! The listener thread lost sync with the filesystem
     -+		 * and created a new token while we were waiting for the
     -+		 * cookie file to be created!  Just give up.
     -+		 */
     -+		pthread_mutex_unlock(&state->main_lock);
     -+
     -+		trace_printf_key(&trace_fsmonitor,
     -+				 "lost filesystem sync");
     -+		result = 0;
     -+		goto send_trivial_response;
     ++	if (do_cookie) {
     ++		cookie_result = with_lock__wait_for_cookie(state);
     ++		if (cookie_result != FCIR_SEEN) {
     ++			error(_("fsmonitor: cookie_result '%d' != SEEN"),
     ++			      cookie_result);
     ++			do_trivial = 1;
     ++		}
      +	}
      +
     - 	/*
     - 	 * We're going to hold onto a pointer to the current
     - 	 * token-data while we walk the list of batches of files.
     + 	if (do_flush)
     + 		with_lock__do_force_resync(state);
     + 
     +@@ builtin/fsmonitor--daemon.c: static int handle_client(void *data,
     + 	return result;
     + }
     + 
     +-#define FSMONITOR_COOKIE_PREFIX ".fsmonitor-daemon-"
     ++#define FSMONITOR_DIR           "fsmonitor--daemon"
     ++#define FSMONITOR_COOKIE_DIR    "cookies"
     ++#define FSMONITOR_COOKIE_PREFIX (FSMONITOR_DIR "/" FSMONITOR_COOKIE_DIR "/")
     + 
     + enum fsmonitor_path_type fsmonitor_classify_path_workdir_relative(
     + 	const char *rel)
      @@ builtin/fsmonitor--daemon.c: void fsmonitor_publish(struct fsmonitor_daemon_state *state,
       		}
       	}
       
      +	if (cookie_names->nr)
     -+		fsmonitor_cookie_mark_seen(state, cookie_names);
     ++		with_lock__mark_cookies_seen(state, cookie_names);
      +
       	pthread_mutex_unlock(&state->main_lock);
       }
     @@ builtin/fsmonitor--daemon.c: static int fsmonitor_run_daemon(void)
      +	pthread_cond_init(&state.cookies_cond, NULL);
       	state.error_code = 0;
       	state.current_token_data = fsmonitor_new_token_data();
     - 	state.test_client_delay_ms = lookup_client_test_delay();
     + 
      @@ builtin/fsmonitor--daemon.c: static int fsmonitor_run_daemon(void)
       		state.nr_paths_watching = 2;
       	}
       
      +	/*
      +	 * We will write filesystem syncing cookie files into
     -+	 * <gitdir>/<cookie-prefix><pid>-<seq>.
     ++	 * <gitdir>/<fsmonitor-dir>/<cookie-dir>/<pid>-<seq>.
      +	 */
      +	strbuf_init(&state.path_cookie_prefix, 0);
      +	strbuf_addbuf(&state.path_cookie_prefix, &state.path_gitdir_watch);
     ++
     ++	strbuf_addch(&state.path_cookie_prefix, '/');
     ++	strbuf_addstr(&state.path_cookie_prefix, FSMONITOR_DIR);
     ++	mkdir(state.path_cookie_prefix.buf, 0777);
     ++
     ++	strbuf_addch(&state.path_cookie_prefix, '/');
     ++	strbuf_addstr(&state.path_cookie_prefix, FSMONITOR_COOKIE_DIR);
     ++	mkdir(state.path_cookie_prefix.buf, 0777);
     ++
      +	strbuf_addch(&state.path_cookie_prefix, '/');
     -+	strbuf_addstr(&state.path_cookie_prefix, FSMONITOR_COOKIE_PREFIX);
      +
       	/*
       	 * Confirm that we can create platform-specific resources for the
     @@ builtin/fsmonitor--daemon.c: static int fsmonitor_run_daemon(void)
       	strbuf_release(&state.path_worktree_watch);
       	strbuf_release(&state.path_gitdir_watch);
      +	strbuf_release(&state.path_cookie_prefix);
     ++
     ++	/*
     ++	 * NEEDSWORK: Consider "rm -rf <gitdir>/<fsmonitor-dir>"
     ++	 */
       
       	return err;
       }
 20:  d699ad597d2c ! 23:  102e17cbc875 fsmonitor: force update index when fsmonitor token advances
     @@ Metadata
      Author: Jeff Hostetler <jeffhost@microsoft.com>
      
       ## Commit message ##
     -    fsmonitor: force update index when fsmonitor token advances
     -
     -    Set the `FSMONITOR_CHANGED` bit on `istate->cache_changed` when the
     -    fsmonitor response contains a different token to ensure that the index
     -    is written to disk.
     -
     -    Normally, when the fsmonitor response includes a tracked file, the
     -    index is always updated.  Similarly, the index might be updated when
     -    the response alters the untracked-cache (when enabled).  However, in
     -    cases where neither of those cause the index to be considered changed,
     -    the fsmonitor response is wasted.  And subsequent commands will
     -    continue to make requests with the same token and if there have not
     -    been any changes in the working directory, they will receive the same
     -    response.
     -
     -    This was observed on Windows after a large checkout.  On Windows, the
     -    kernel emits events for the files that are changed as they are
     -    changed.  However, it might delay events for the containing
     -    directories until the system is more idle (or someone scans the
     -    directory (so it seems)).  The first status following a checkout would
     -    get the list of files.  The subsequent status commands would get the
     -    list of directories as the events trickled out.  But they would never
     -    catch up because the token was not advanced because the index wasn't
     -    updated.
     -
     -    This list of directories caused `wt_status_collect_untracked()` to
     -    unnecessarily spend time actually scanning them during each command.
     +    fsmonitor: enhance existing comments
      
          Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
      
       ## fsmonitor.c ##
      @@ fsmonitor.c: void refresh_fsmonitor(struct index_state *istate)
       	}
     - 	strbuf_release(&query_result);
       
     + apply_results:
     +-	/* a fsmonitor process can return '/' to indicate all entries are invalid */
      +	/*
     -+	 * If the fsmonitor response and the subsequent scan of the disk
     -+	 * did not cause the in-memory index to be marked dirty, then force
     -+	 * it so that we advance the fsmonitor token in our extension, so
     -+	 * that future requests don't keep re-requesting the same range.
     ++	 * The response from FSMonitor (excluding the header token) is
     ++	 * either:
     ++	 *
     ++	 * [a] a (possibly empty) list of NUL delimited relative
     ++	 *     pathnames of changed paths.  This list can contain
     ++	 *     files and directories.  Directories have a trailing
     ++	 *     slash.
     ++	 *
     ++	 * [b] a single '/' to indicate the provider had no
     ++	 *     information and that we should consider everything
     ++	 *     invalid.  We call this a trivial response.
      +	 */
     -+	if (istate->fsmonitor_last_update &&
     -+	    strcmp(istate->fsmonitor_last_update, last_update_token.buf))
     -+		istate->cache_changed |= FSMONITOR_CHANGED;
     + 	if (query_success && query_result.buf[bol] != '/') {
     +-		/* Mark all entries returned by the monitor as dirty */
     ++		/*
     ++		 * Mark all pathnames returned by the monitor as dirty.
     ++		 *
     ++		 * This updates both the cache-entries and the untracked-cache.
     ++		 */
     + 		buf = query_result.buf;
     + 		for (i = bol; i < query_result.len; i++) {
     + 			if (buf[i] != '\0')
     +@@ fsmonitor.c: void refresh_fsmonitor(struct index_state *istate)
     + 		if (istate->untracked)
     + 			istate->untracked->use_fsmonitor = 1;
     + 	} else {
     +-
     +-		/* We only want to run the post index changed hook if we've actually changed entries, so keep track
     +-		 * if we actually changed entries or not */
     ++		/*
     ++		 * We received a trivial response, so invalidate everything.
     ++		 *
     ++		 * We only want to run the post index changed hook if
     ++		 * we've actually changed entries, so keep track if we
     ++		 * actually changed entries or not.
     ++		 */
     + 		int is_cache_changed = 0;
     +-		/* Mark all entries invalid */
      +
     - 	/* Now that we've updated istate, save the last_update_token */
     - 	FREE_AND_NULL(istate->fsmonitor_last_update);
     - 	istate->fsmonitor_last_update = strbuf_detach(&last_update_token, NULL);
     + 		for (i = 0; i < istate->cache_nr; i++) {
     + 			if (istate->cache[i]->ce_flags & CE_FSMONITOR_VALID) {
     + 				is_cache_changed = 1;
     +@@ fsmonitor.c: void refresh_fsmonitor(struct index_state *istate)
     + 			}
     + 		}
     + 
     +-		/* If we're going to check every file, ensure we save the results */
     ++		/*
     ++		 * If we're going to check every file, ensure we save
     ++		 * the results.
     ++		 */
     + 		if (is_cache_changed)
     + 			istate->cache_changed |= FSMONITOR_CHANGED;
     + 
  -:  ------------ > 24:  11ea2f97def6 fsmonitor: force update index after large responses
 21:  8b2280e5c4d2 ! 25:  c9159db718a7 t7527: create test for fsmonitor--daemon
     @@ t/t7527-builtin-fsmonitor.sh (new)
      +
      +. ./test-lib.sh
      +
     -+# Ask the fsmonitor daemon to insert a little delay before responding to
     -+# client commands like `git status` and `git fsmonitor--daemon --query` to
     -+# allow recent filesystem events to be received by the daemon.  This helps
     -+# the CI/PR builds be more stable.
     -+#
     -+# An arbitrary millisecond value.
     -+#
     -+GIT_TEST_FSMONITOR_CLIENT_DELAY=1000
     -+export GIT_TEST_FSMONITOR_CLIENT_DELAY
     -+
      +git version --build-options | grep "feature:" | grep "fsmonitor--daemon" || {
      +	skip_all="The built-in FSMonitor is not supported on this platform"
      +	test_done
     @@ t/t7527-builtin-fsmonitor.sh (new)
      +
      +kill_repo () {
      +	r=$1
     -+	git -C $r fsmonitor--daemon --stop >/dev/null 2>/dev/null
     ++	git -C $r fsmonitor--daemon stop >/dev/null 2>/dev/null
      +	rm -rf $1
      +	return 0
      +}
     @@ t/t7527-builtin-fsmonitor.sh (new)
      +		*) r="";
      +	esac
      +
     -+	git $r fsmonitor--daemon --start || return $?
     -+	git $r fsmonitor--daemon --is-running || return $?
     ++	git $r fsmonitor--daemon start || return $?
     ++	git $r fsmonitor--daemon status || return $?
      +
      +	return 0
      +}
     @@ t/t7527-builtin-fsmonitor.sh (new)
      +	git init test_explicit &&
      +	start_daemon test_explicit &&
      +
     -+	git -C test_explicit fsmonitor--daemon --stop &&
     -+	test_must_fail git -C test_explicit fsmonitor--daemon --is-running
     ++	git -C test_explicit fsmonitor--daemon stop &&
     ++	test_must_fail git -C test_explicit fsmonitor--daemon status
      +'
      +
      +test_expect_success 'implicit daemon start' '
      +	test_when_finished "kill_repo test_implicit" &&
      +
      +	git init test_implicit &&
     -+	test_must_fail git -C test_implicit fsmonitor--daemon --is-running &&
     ++	test_must_fail git -C test_implicit fsmonitor--daemon status &&
      +
      +	# query will implicitly start the daemon.
      +	#
     @@ t/t7527-builtin-fsmonitor.sh (new)
      +	# implicitly started.)
      +
      +	GIT_TRACE2_EVENT="$PWD/.git/trace" \
     -+		git -C test_implicit fsmonitor--daemon --query 0 >actual &&
     ++		test-tool -C test_implicit fsmonitor-client query --token 0 >actual &&
      +	nul_to_q <actual >actual.filtered &&
      +	grep "builtin:" actual.filtered &&
      +
     @@ t/t7527-builtin-fsmonitor.sh (new)
      +
      +	grep :\"query/response-length\" .git/trace &&
      +
     -+	git -C test_implicit fsmonitor--daemon --is-running &&
     -+	git -C test_implicit fsmonitor--daemon --stop &&
     -+	test_must_fail git -C test_implicit fsmonitor--daemon --is-running
     ++	git -C test_implicit fsmonitor--daemon status &&
     ++	git -C test_implicit fsmonitor--daemon stop &&
     ++	test_must_fail git -C test_implicit fsmonitor--daemon status
      +'
      +
      +test_expect_success 'implicit daemon stop (delete .git)' '
     @@ t/t7527-builtin-fsmonitor.sh (new)
      +	sleep 1 &&
      +	mkdir test_implicit_1/.git &&
      +
     -+	test_must_fail git -C test_implicit_1 fsmonitor--daemon --is-running
     ++	test_must_fail git -C test_implicit_1 fsmonitor--daemon status
      +'
      +
      +test_expect_success 'implicit daemon stop (rename .git)' '
     @@ t/t7527-builtin-fsmonitor.sh (new)
      +	sleep 1 &&
      +	mkdir test_implicit_2/.git &&
      +
     -+	test_must_fail git -C test_implicit_2 fsmonitor--daemon --is-running
     ++	test_must_fail git -C test_implicit_2 fsmonitor--daemon status
      +'
      +
      +test_expect_success 'cannot start multiple daemons' '
     @@ t/t7527-builtin-fsmonitor.sh (new)
      +
      +	start_daemon test_multiple &&
      +
     -+	test_must_fail git -C test_multiple fsmonitor--daemon --start 2>actual &&
     ++	test_must_fail git -C test_multiple fsmonitor--daemon start 2>actual &&
      +	grep "fsmonitor--daemon is already running" actual &&
      +
     -+	git -C test_multiple fsmonitor--daemon --stop &&
     -+	test_must_fail git -C test_multiple fsmonitor--daemon --is-running
     ++	git -C test_multiple fsmonitor--daemon stop &&
     ++	test_must_fail git -C test_multiple fsmonitor--daemon status
      +'
      +
      +test_expect_success 'setup' '
     @@ t/t7527-builtin-fsmonitor.sh (new)
      +'
      +
      +test_expect_success 'update-index implicitly starts daemon' '
     -+	test_must_fail git fsmonitor--daemon --is-running &&
     ++	test_must_fail git fsmonitor--daemon status &&
      +
      +	GIT_TRACE2_EVENT="$PWD/.git/trace_implicit_1" \
      +		git update-index --fsmonitor &&
      +
     -+	git fsmonitor--daemon --is-running &&
     -+	test_might_fail git fsmonitor--daemon --stop &&
     ++	git fsmonitor--daemon status &&
     ++	test_might_fail git fsmonitor--daemon stop &&
      +
      +	grep \"event\":\"start\".*\"fsmonitor--daemon\" .git/trace_implicit_1
      +'
      +
      +test_expect_success 'status implicitly starts daemon' '
     -+	test_must_fail git fsmonitor--daemon --is-running &&
     ++	test_must_fail git fsmonitor--daemon status &&
      +
      +	GIT_TRACE2_EVENT="$PWD/.git/trace_implicit_2" \
      +		git status >actual &&
      +
     -+	git fsmonitor--daemon --is-running &&
     -+	test_might_fail git fsmonitor--daemon --stop &&
     ++	git fsmonitor--daemon status &&
     ++	test_might_fail git fsmonitor--daemon stop &&
      +
      +	grep \"event\":\"start\".*\"fsmonitor--daemon\" .git/trace_implicit_2
      +'
     @@ t/t7527-builtin-fsmonitor.sh (new)
      +clean_up_repo_and_stop_daemon () {
      +	git reset --hard HEAD
      +	git clean -fd
     -+	git fsmonitor--daemon --stop
     ++	git fsmonitor--daemon stop
      +	rm -f .git/trace
      +}
      +
     @@ t/t7527-builtin-fsmonitor.sh (new)
      +
      +	edit_files &&
      +
     -+	git fsmonitor--daemon --query 0 >/dev/null 2>&1 &&
     ++	test-tool fsmonitor-client query --token 0 >/dev/null 2>&1 &&
      +
      +	grep "^event: dir1/modified$"  .git/trace &&
      +	grep "^event: dir2/modified$"  .git/trace &&
     @@ t/t7527-builtin-fsmonitor.sh (new)
      +
      +	create_files &&
      +
     -+	git fsmonitor--daemon --query 0 >/dev/null 2>&1 &&
     ++	test-tool fsmonitor-client query --token 0 >/dev/null 2>&1 &&
      +
      +	grep "^event: dir1/new$" .git/trace &&
      +	grep "^event: dir2/new$" .git/trace &&
     @@ t/t7527-builtin-fsmonitor.sh (new)
      +
      +	delete_files &&
      +
     -+	git fsmonitor--daemon --query 0 >/dev/null 2>&1 &&
     ++	test-tool fsmonitor-client query --token 0 >/dev/null 2>&1 &&
      +
      +	grep "^event: dir1/delete$" .git/trace &&
      +	grep "^event: dir2/delete$" .git/trace &&
     @@ t/t7527-builtin-fsmonitor.sh (new)
      +
      +	rename_files &&
      +
     -+	git fsmonitor--daemon --query 0 >/dev/null 2>&1 &&
     ++	test-tool fsmonitor-client query --token 0 >/dev/null 2>&1 &&
      +
      +	grep "^event: dir1/rename$"  .git/trace &&
      +	grep "^event: dir2/rename$"  .git/trace &&
     @@ t/t7527-builtin-fsmonitor.sh (new)
      +
      +	mv dirtorename dirrenamed &&
      +
     -+	git fsmonitor--daemon --query 0 >/dev/null 2>&1 &&
     ++	test-tool fsmonitor-client query --token 0 >/dev/null 2>&1 &&
      +
      +	grep "^event: dirtorename/*$" .git/trace &&
      +	grep "^event: dirrenamed/*$"  .git/trace
     @@ t/t7527-builtin-fsmonitor.sh (new)
      +
      +	file_to_directory &&
      +
     -+	git fsmonitor--daemon --query 0 >/dev/null 2>&1 &&
     ++	test-tool fsmonitor-client query --token 0 >/dev/null 2>&1 &&
      +
      +	grep "^event: delete$"     .git/trace &&
      +	grep "^event: delete/new$" .git/trace
     @@ t/t7527-builtin-fsmonitor.sh (new)
      +
      +	directory_to_file &&
      +
     -+	git fsmonitor--daemon --query 0 >/dev/null 2>&1 &&
     ++	test-tool fsmonitor-client query --token 0 >/dev/null 2>&1 &&
      +
      +	grep "^event: dir1$" .git/trace
      +'
     @@ t/t7527-builtin-fsmonitor.sh (new)
      +# polling fast enough), we need to discard the cached data (relative to the
      +# current token) and start collecting events under a new token.
      +#
     -+# the 'git fsmonitor--daemon --flush' command can be used to send a "flush"
     -+# message to a running daemon and ask it to do a flush/resync.
     ++# the 'test-tool fsmonitor-client flush' command can be used to send a
     ++# "flush" message to a running daemon and ask it to do a flush/resync.
      +
      +test_expect_success 'flush cached data' '
      +	test_when_finished "kill_repo test_flush" &&
     @@ t/t7527-builtin-fsmonitor.sh (new)
      +	# then a few (probably platform-specific number of) events in _1.
      +	# These should both have the same <token_id>.
      +
     -+	git -C test_flush fsmonitor--daemon --query "builtin:test_00000001:0" >actual_0 &&
     ++	test-tool -C test_flush fsmonitor-client query --token "builtin:test_00000001:0" >actual_0 &&
      +	nul_to_q <actual_0 >actual_q0 &&
      +
      +	touch test_flush/file_1 &&
      +	touch test_flush/file_2 &&
      +
     -+	git -C test_flush fsmonitor--daemon --query "builtin:test_00000001:0" >actual_1 &&
     ++	test-tool -C test_flush fsmonitor-client query --token "builtin:test_00000001:0" >actual_1 &&
      +	nul_to_q <actual_1 >actual_q1 &&
      +
      +	grep "file_1" actual_q1 &&
     @@ t/t7527-builtin-fsmonitor.sh (new)
      +	# flush the file data.  Then create some events and ensure that the file
      +	# again appears in the cache.  It should have the new <token_id>.
      +
     -+	git -C test_flush fsmonitor--daemon --flush >flush_0 &&
     ++	test-tool -C test_flush fsmonitor-client flush >flush_0 &&
      +	nul_to_q <flush_0 >flush_q0 &&
      +	grep "^builtin:test_00000002:0Q/Q$" flush_q0 &&
      +
     -+	git -C test_flush fsmonitor--daemon --query "builtin:test_00000002:0" >actual_2 &&
     ++	test-tool -C test_flush fsmonitor-client query --token "builtin:test_00000002:0" >actual_2 &&
      +	nul_to_q <actual_2 >actual_q2 &&
      +
      +	grep "^builtin:test_00000002:0Q$" actual_q2 &&
      +
      +	touch test_flush/file_3 &&
      +
     -+	git -C test_flush fsmonitor--daemon --query "builtin:test_00000002:0" >actual_3 &&
     ++	test-tool -C test_flush fsmonitor-client query --token "builtin:test_00000002:0" >actual_3 &&
      +	nul_to_q <actual_3 >actual_q3 &&
      +
      +	grep "file_3" actual_q3
     @@ t/t7527-builtin-fsmonitor.sh (new)
      +		start_daemon wt-secondary
      +	) &&
      +
     -+	git -C wt-secondary fsmonitor--daemon --stop &&
     -+	test_must_fail git -C wt-secondary fsmonitor--daemon --is-running
     ++	git -C wt-secondary fsmonitor--daemon stop &&
     ++	test_must_fail git -C wt-secondary fsmonitor--daemon status
      +'
      +
      +test_done
 22:  da5094e52032 ! 26:  5b035c6e0d60 p7519: add fsmonitor--daemon
     @@ t/perf/p7519-fsmonitor.sh: test_expect_success "one time repo setup" '
       		#
       		# Choose integration script based on existence of Watchman.
       		# Fall back to an empty integration script.
     +@@ t/perf/p7519-fsmonitor.sh: test_perf_w_drop_caches () {
     + }
     + 
     + test_fsmonitor_suite() {
     +-	if test -n "$INTEGRATION_SCRIPT"; then
     ++	if test -n "$USE_FSMONITOR_DAEMON"
     ++	then
     ++		DESC="builtin fsmonitor--daemon"
     ++	elif test -n "$INTEGRATION_SCRIPT"; then
     + 		DESC="fsmonitor=$(basename $INTEGRATION_SCRIPT)"
     + 	else
     + 		DESC="fsmonitor=disabled"
      @@ t/perf/p7519-fsmonitor.sh: test_expect_success "setup without fsmonitor" '
       test_fsmonitor_suite
       trace_stop
     @@ t/perf/p7519-fsmonitor.sh: test_expect_success "setup without fsmonitor" '
      +	USE_FSMONITOR_DAEMON=t
      +
      +	trace_start fsmonitor--daemon--server
     -+	git fsmonitor--daemon --start
     ++	git fsmonitor--daemon start
      +
      +	trace_start fsmonitor--daemon--client
      +	test_expect_success "setup for fsmonitor--daemon" 'setup_for_fsmonitor'
      +	test_fsmonitor_suite
      +
     -+	git fsmonitor--daemon --stop
     ++	git fsmonitor--daemon stop
      +	trace_stop
      +fi
      +
 23:  3eafd0b5cb09 ! 27:  1483c68855cb t7527: test status with untracked-cache and fsmonitor--daemon
     @@ t/t7527-builtin-fsmonitor.sh: test_expect_success 'setup' '
       
       	git -c core.useBuiltinFSMonitor= add . &&
      @@ t/t7527-builtin-fsmonitor.sh: test_expect_success 'worktree with .git file' '
     - 	test_must_fail git -C wt-secondary fsmonitor--daemon --is-running
     + 	test_must_fail git -C wt-secondary fsmonitor--daemon status
       '
       
      +# TODO Repeat one of the "edit" tests on wt-secondary and confirm that
     @@ t/t7527-builtin-fsmonitor.sh: test_expect_success 'worktree with .git file' '
      +test_expect_success 'Matrix: setup for untracked-cache,fsmonitor matrix' '
      +	test_might_fail git config --unset core.useBuiltinFSMonitor &&
      +	git update-index --no-fsmonitor &&
     -+	test_might_fail git fsmonitor--daemon --stop
     ++	test_might_fail git fsmonitor--daemon stop
      +'
      +
      +matrix_clean_up_repo () {
     @@ t/t7527-builtin-fsmonitor.sh: test_expect_success 'worktree with .git file' '
      +			test_expect_success "Matrix[uc:$uc_val][fsm:$fsm_val] disable fsmonitor" '
      +				test_might_fail git config --unset core.useBuiltinFSMonitor &&
      +				git update-index --no-fsmonitor &&
     -+				test_might_fail git fsmonitor--daemon --stop 2>/dev/null
     ++				test_might_fail git fsmonitor--daemon stop 2>/dev/null
      +			'
      +		else
      +			test_expect_success "Matrix[uc:$uc_val][fsm:$fsm_val] enable fsmonitor" '
      +				git config core.useBuiltinFSMonitor true &&
     -+				git fsmonitor--daemon --start &&
     ++				git fsmonitor--daemon start &&
      +				git update-index --fsmonitor
      +			'
      +		fi
  -:  ------------ > 28:  96a3eab819f4 t/perf: avoid copying builtin fsmonitor files into test repo

-- 
gitgitgadget
