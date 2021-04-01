Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25958C433B4
	for <git@archiver.kernel.org>; Thu,  1 Apr 2021 18:33:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 009C260FD9
	for <git@archiver.kernel.org>; Thu,  1 Apr 2021 18:33:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237218AbhDASdC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Apr 2021 14:33:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235531AbhDASVK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Apr 2021 14:21:10 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2823C0225B7
        for <git@vger.kernel.org>; Thu,  1 Apr 2021 08:41:09 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id z2so2273685wrl.5
        for <git@vger.kernel.org>; Thu, 01 Apr 2021 08:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=XkpOGspoFjNNxmzEoEsBAlqtHAH0QW/MpCd/rP67Qng=;
        b=SgYwbTjShPntm0S6SejfPLVotaclpplcgKFEAmnBIzuiNTSy+Fcv+caVeGxtfkSJLI
         9nKqZtlGhxRmhcn4WOkgL5Fmetrox48Os7c0kKfGnRN70j90v4JwHW6f4QlxNjom0hyF
         5a3pmWQrZvLifvA2OUGv3bzEwU3PkDSBqrLsRIdzJpb52ue/38Deg+DgaPIP26YUL2tk
         Cdfq7FxMYniCNMaqP2PoLMm+CXrdDmzsq1TFoZQhy7zWRvhYSpfD+1aIhcv1vwtH/TXA
         NEj/hDDJ48nVEJCWeVFKAAxVuwXOHybwTSP1xm+pmhmCsGIR/yuDIovvaPcCR2u71YIT
         6mcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=XkpOGspoFjNNxmzEoEsBAlqtHAH0QW/MpCd/rP67Qng=;
        b=OqhYmQH2T5MHx6NCdKkTITdtMD65ZhCWQRndjFysJM2mlfgRosaICgGervXpMFPO9X
         xE5vSIR4mqHGdgsqngoVJKBkC81NKJal3Y43IgEME+KLLoA8XqJpR0U/i2XU3MXJFvVL
         qs7v4VAgFXyXM90qIgE71P+m5/9srmCXpfF8IMi4+EiY9x+tLwfZ4IHQnc001fn5mdXH
         yHQSzFzXgCNJux5V+4Lm03sHPxNdHhTh+awwXZCZ9hVrR1vGOqS5vOqB3f6iaPV18B/0
         CHHZj4CqDkn5vtGkXkg7lJSjhHiMG4UF46odaAwdJgi6sqsmA1mYNkucOprI0AtQnxQp
         D1Pw==
X-Gm-Message-State: AOAM531iq2fiiRTIfzBCNcwgYZzMJI8/DjWtUvVftCvPzUowYxVkWYZd
        cin4g6+5LYpZUE53sjOL0kln5uEuC6g=
X-Google-Smtp-Source: ABdhPJzD1/lVzVi+Bta1xcGNim+FoI4Avto6w/s81CKCODZH+NUzZ0GXAZv97MWfGVZjZk8RehvxtA==
X-Received: by 2002:a5d:4b06:: with SMTP id v6mr10706387wrq.41.1617291668673;
        Thu, 01 Apr 2021 08:41:08 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i4sm7976592wmq.12.2021.04.01.08.41.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 08:41:08 -0700 (PDT)
Message-Id: <074273330f8d6c656dfec7c8778fad20314c6ad1.1617291666.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.923.git.1617291666.gitgitgadget@gmail.com>
References: <pull.923.git.1617291666.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 01 Apr 2021 15:40:43 +0000
Subject: [PATCH 01/23] fsmonitor--daemon: man page and documentation
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Create a manual page describing the `git fsmonitor--daemon` feature.

Update references to `core.fsmonitor`, `core.fsmonitorHookVersion` and
pointers to `watchman` to mention the built-in FSMonitor.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 Documentation/config/core.txt           |  45 +++++++---
 Documentation/git-fsmonitor--daemon.txt | 104 ++++++++++++++++++++++++
 Documentation/git-update-index.txt      |   4 +-
 Documentation/githooks.txt              |   3 +-
 4 files changed, 144 insertions(+), 12 deletions(-)
 create mode 100644 Documentation/git-fsmonitor--daemon.txt

diff --git a/Documentation/config/core.txt b/Documentation/config/core.txt
index c04f62a54a15..d6e2f01966cb 100644
--- a/Documentation/config/core.txt
+++ b/Documentation/config/core.txt
@@ -66,18 +66,43 @@ core.fsmonitor::
 	will identify all files that may have changed since the
 	requested date/time. This information is used to speed up git by
 	avoiding unnecessary processing of files that have not changed.
-	See the "fsmonitor-watchman" section of linkgit:githooks[5].
++
+See the "fsmonitor-watchman" section of linkgit:githooks[5].
++
+Note: FSMonitor hooks (and this config setting) are ignored if the
+built-in FSMonitor is enabled (see `core.useBuiltinFSMonitor`).
 
 core.fsmonitorHookVersion::
-	Sets the version of hook that is to be used when calling fsmonitor.
-	There are currently versions 1 and 2. When this is not set,
-	version 2 will be tried first and if it fails then version 1
-	will be tried. Version 1 uses a timestamp as input to determine
-	which files have changes since that time but some monitors
-	like watchman have race conditions when used with a timestamp.
-	Version 2 uses an opaque string so that the monitor can return
-	something that can be used to determine what files have changed
-	without race conditions.
+	Sets the version of hook that is to be used when calling the
+	FSMonitor hook (as configured via `core.fsmonitor`).
++
+There are currently versions 1 and 2. When this is not set,
+version 2 will be tried first and if it fails then version 1
+will be tried. Version 1 uses a timestamp as input to determine
+which files have changes since that time but some monitors
+like watchman have race conditions when used with a timestamp.
+Version 2 uses an opaque string so that the monitor can return
+something that can be used to determine what files have changed
+without race conditions.
++
+Note: FSMonitor hooks (and this config setting) are ignored if the
+built-in FSMonitor is enabled (see `core.useBuiltinFSMonitor`).
+
+core.useBuiltinFSMonitor::
+	If set to true, enable the built-in filesystem event watcher (for
+	technical details, see linkgit:git-fsmonitor--daemon[1]).
++
+Like external (hook-based) FSMonitors, the built-in FSMonitor can speed up
+Git commands that need to refresh the Git index (e.g. `git status`) in a
+worktree with many files. The built-in FSMonitor facility eliminates the
+need to install and maintain an external third-party monitoring tool.
++
+The built-in FSMonitor is currently available only on a limited set of
+supported platforms.
++
+Note: if this config setting is set to `true`, any FSMonitor hook
+configured via `core.fsmonitor` (and possibly `core.fsmonitorHookVersion`)
+is ignored.
 
 core.trustctime::
 	If false, the ctime differences between the index and the
diff --git a/Documentation/git-fsmonitor--daemon.txt b/Documentation/git-fsmonitor--daemon.txt
new file mode 100644
index 000000000000..b94f57c97fe4
--- /dev/null
+++ b/Documentation/git-fsmonitor--daemon.txt
@@ -0,0 +1,104 @@
+git-fsmonitor--daemon(1)
+========================
+
+NAME
+----
+git-fsmonitor--daemon - Builtin file system monitor daemon
+
+SYNOPSIS
+--------
+[verse]
+'git fsmonitor--daemon' --start
+'git fsmonitor--daemon' --run
+'git fsmonitor--daemon' --stop
+'git fsmonitor--daemon' --is-running
+'git fsmonitor--daemon' --is-supported
+'git fsmonitor--daemon' --query <token>
+'git fsmonitor--daemon' --query-index
+'git fsmonitor--daemon' --flush
+
+DESCRIPTION
+-----------
+
+Monitors files and directories in the working directory for changes using
+platform-specific file system notification facilities.
+
+It communicates directly with commands like `git status` using the
+link:technical/api-simple-ipc.html[simple IPC] interface instead of
+the slower linkgit:githooks[5] interface.
+
+OPTIONS
+-------
+
+--start::
+	Starts the fsmonitor daemon in the background.
+
+--run::
+	Runs the fsmonitor daemon in the foreground.
+
+--stop::
+	Stops the fsmonitor daemon running for the current working
+	directory, if present.
+
+--is-running::
+	Exits with zero status if the fsmonitor daemon is watching the
+	current working directory.
+
+--is-supported::
+	Exits with zero status if the fsmonitor daemon feature is supported
+	on this platform.
+
+--query <token>::
+	Connects to the fsmonitor daemon (starting it if necessary) and
+	requests the list of changed files and directories since the
+	given token.
+	This is intended for testing purposes.
+
+--query-index::
+	Read the current `<token>` from the File System Monitor index
+	extension (if present) and use it to query the fsmonitor daemon.
+	This is intended for testing purposes.
+
+--flush::
+	Force the fsmonitor daemon to flush its in-memory cache and
+	re-sync with the file system.
+	This is intended for testing purposes.
+
+REMARKS
+-------
+The fsmonitor daemon is a long running process that will watch a single
+working directory.  Commands, such as `git status`, should automatically
+start it (if necessary) when `core.useBuiltinFSMonitor` is set to `true`
+(see linkgit:git-config[1]).
+
+Configure the built-in FSMonitor via `core.useBuiltinFSMonitor` in each
+working directory separately, or globally via `git config --global
+core.useBuiltinFSMonitor true`.
+
+Tokens are opaque strings.  They are used by the fsmonitor daemon to
+mark a point in time and the associated internal state.  Callers should
+make no assumptions about the content of the token.  In particular,
+the should not assume that it is a timestamp.
+
+Query commands send a request-token to the daemon and it responds with
+a summary of the changes that have occurred since that token was
+created.  The daemon also returns a response-token that the client can
+use in a future query.
+
+For more information see the "File System Monitor" section in
+linkgit:git-update-index[1].
+
+CAVEATS
+-------
+
+The fsmonitor daemon does not currently know about submodules and does
+not know to filter out file system events that happen within a
+submodule.  If fsmonitor daemon is watching a super repo and a file is
+modified within the working directory of a submodule, it will report
+the change (as happening against the super repo).  However, the client
+should properly ignore these extra events, so performance may be affected
+but it should not cause an incorrect result.
+
+GIT
+---
+Part of the linkgit:git[1] suite
diff --git a/Documentation/git-update-index.txt b/Documentation/git-update-index.txt
index 2853f168d976..8169aad7ee9f 100644
--- a/Documentation/git-update-index.txt
+++ b/Documentation/git-update-index.txt
@@ -498,7 +498,9 @@ FILE SYSTEM MONITOR
 This feature is intended to speed up git operations for repos that have
 large working directories.
 
-It enables git to work together with a file system monitor (see the
+It enables git to work together with a file system monitor (see
+linkgit:git-fsmonitor--daemon[1]
+and the
 "fsmonitor-watchman" section of linkgit:githooks[5]) that can
 inform it as to what files have been modified. This enables git to avoid
 having to lstat() every file to find modified files.
diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index b51959ff9418..b7d5e926f7b0 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -593,7 +593,8 @@ fsmonitor-watchman
 
 This hook is invoked when the configuration option `core.fsmonitor` is
 set to `.git/hooks/fsmonitor-watchman` or `.git/hooks/fsmonitor-watchmanv2`
-depending on the version of the hook to use.
+depending on the version of the hook to use, unless overridden via
+`core.useBuiltinFSMonitor` (see linkgit:git-config[1]).
 
 Version 1 takes two arguments, a version (1) and the time in elapsed
 nanoseconds since midnight, January 1, 1970.
-- 
gitgitgadget

