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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4170C11F64
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 14:47:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FC366140C
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 14:47:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232629AbhGAOuZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Jul 2021 10:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232549AbhGAOuV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jul 2021 10:50:21 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00681C061765
        for <git@vger.kernel.org>; Thu,  1 Jul 2021 07:47:48 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id o22so4731040wms.0
        for <git@vger.kernel.org>; Thu, 01 Jul 2021 07:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=3XmhVkrJ3wLF1aw9bykaW4kn1GzQb5tVCihnsJrD+2g=;
        b=css+3PtrUhHJVMHlE/QGWh/kbkR/BiLazi0QvSywMn2jgSCD5xzWySuE+RkJFkYIiV
         mRHCDolx+RBsWV403gWpIgi+P5WU8P/ETxITvG3zvZcIxgRfgpTLAlZnS3mLo7KyEMUP
         q4wLwpRgTrHwUZm8+xlXAuvf/BH9WZ5teMuBCbPEJ6nUZ3BzBZcARWQTuL0uix5Yk/B9
         lLpr8wyr0FWINfwhBLUx4pTuhGAPeQfjF7MWCkQ9589pBTD5sS5sqZn+exMCY/Rklrc8
         2OyDzt80C6IHqWxyqawpnzH5j6aekqWB7KXmCGCE9rwTZAwZjhrdm9aMLyPDl9SrvYXz
         XgfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=3XmhVkrJ3wLF1aw9bykaW4kn1GzQb5tVCihnsJrD+2g=;
        b=NcjXonCuU1rs4moMFcOV7vIPUIVar53yvQtLh4O1CR/qhqsfs3YpcDxs5egJkK3B5v
         Ol5X7ng+eQtqB5xq5XRcxszw/biqbbXTgcJdCezpZOeCe781DfSslHNOovYiOkgeodVr
         ql4JK3cxaS2Tr/3jk9xbAkLHX0F/ZpYNOBb+Ve+Ls+RbpN3WBAsPkTHvRZdIz0DD86wG
         1ODuzqlfdCFbBKODK07onXm+6czYpZWPMU392vYqFZXVVex1sAMsBXSe3oydz4wLW8FL
         MhXfRB97eSPG1aA/b+6Ll8Z3JiRdrGXL7yA7H7bHRhqX4xXMbVpdHl8bHqDLTY+7ay2u
         abhQ==
X-Gm-Message-State: AOAM530EUZSL9KCwkJT+SX4+59oSiveWehTrH8fvNHqdkFG8xFQv6oJQ
        WTe01RFr9mH/c+SHdS9CSiyKTEVeNyA=
X-Google-Smtp-Source: ABdhPJz5Kduz/brY/xwzG7zaP/tnaYQsE6XeY9tNjLl0pLP+lDkGtt6XrPXxdmcUT+n7XLcf3yNQzg==
X-Received: by 2002:a05:600c:3ba9:: with SMTP id n41mr132727wms.28.1625150867494;
        Thu, 01 Jul 2021 07:47:47 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w8sm126712wre.70.2021.07.01.07.47.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 07:47:47 -0700 (PDT)
Message-Id: <86413bfe34722dcd5c846cf7326340473471773c.1625150864.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.923.v3.git.1625150864.gitgitgadget@gmail.com>
References: <pull.923.v2.git.1621691828.gitgitgadget@gmail.com>
        <pull.923.v3.git.1625150864.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 01 Jul 2021 14:47:13 +0000
Subject: [PATCH v3 03/34] fsmonitor--daemon: update fsmonitor documentation
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <stolee@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Update references to `core.fsmonitor` and `core.fsmonitorHookVersion` and
pointers to `Watchman` to mention the new built-in `fsmonitor--daemon`.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 Documentation/config/core.txt      | 56 ++++++++++++++++++++++--------
 Documentation/git-update-index.txt | 27 +++++++-------
 Documentation/githooks.txt         |  3 +-
 3 files changed, 59 insertions(+), 27 deletions(-)

diff --git a/Documentation/config/core.txt b/Documentation/config/core.txt
index c04f62a54a1..4f6e519bc02 100644
--- a/Documentation/config/core.txt
+++ b/Documentation/config/core.txt
@@ -62,22 +62,50 @@ core.protectNTFS::
 	Defaults to `true` on Windows, and `false` elsewhere.
 
 core.fsmonitor::
-	If set, the value of this variable is used as a command which
-	will identify all files that may have changed since the
-	requested date/time. This information is used to speed up git by
-	avoiding unnecessary processing of files that have not changed.
-	See the "fsmonitor-watchman" section of linkgit:githooks[5].
+	If set, this variable contains the pathname of the "fsmonitor"
+	hook command.
++
+This hook command is used to identify all files that may have changed
+since the requested date/time. This information is used to speed up
+git by avoiding unnecessary scanning of files that have not changed.
++
+See the "fsmonitor-watchman" section of linkgit:githooks[5].
++
+Note: The value of this config setting is ignored if the
+built-in file system monitor is enabled (see `core.useBuiltinFSMonitor`).
 
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
+	Sets the protocol version to be used when invoking the
+	"fsmonitor" hook.
++
+There are currently versions 1 and 2. When this is not set,
+version 2 will be tried first and if it fails then version 1
+will be tried. Version 1 uses a timestamp as input to determine
+which files have changes since that time but some monitors
+like Watchman have race conditions when used with a timestamp.
+Version 2 uses an opaque string so that the monitor can return
+something that can be used to determine what files have changed
+without race conditions.
++
+Note: The value of this config setting is ignored if the
+built-in file system monitor is enabled (see `core.useBuiltinFSMonitor`).
+
+core.useBuiltinFSMonitor::
+	If set to true, enable the built-in file system monitor
+	daemon for this working directory (linkgit:git-fsmonitor--daemon[1]).
++
+Like hook-based file system monitors, the built-in file system monitor
+can speed up Git commands that need to refresh the Git index
+(e.g. `git status`) in a working directory with many files.  The
+built-in monitor eliminates the need to install and maintain an
+external third-party tool.
++
+The built-in file system monitor is currently available only on a
+limited set of supported platforms.  Currently, this includes Windows
+and MacOS.
++
+Note: if this config setting is set to `true`, the values of
+`core.fsmonitor` and `core.fsmonitorHookVersion` are ignored.
 
 core.trustctime::
 	If false, the ctime differences between the index and the
diff --git a/Documentation/git-update-index.txt b/Documentation/git-update-index.txt
index 2853f168d97..c7c31b3fcf9 100644
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
@@ -508,17 +510,18 @@ performance by avoiding the cost of scanning the entire working directory
 looking for new files.
 
 If you want to enable (or disable) this feature, it is easier to use
-the `core.fsmonitor` configuration variable (see
-linkgit:git-config[1]) than using the `--fsmonitor` option to
-`git update-index` in each repository, especially if you want to do so
-across all repositories you use, because you can set the configuration
-variable in your `$HOME/.gitconfig` just once and have it affect all
-repositories you touch.
-
-When the `core.fsmonitor` configuration variable is changed, the
-file system monitor is added to or removed from the index the next time
-a command reads the index. When `--[no-]fsmonitor` are used, the file
-system monitor is immediately added to or removed from the index.
+the `core.fsmonitor` or `core.useBuiltinFSMonitor` configuration
+variable (see linkgit:git-config[1]) than using the `--fsmonitor`
+option to `git update-index` in each repository, especially if you
+want to do so across all repositories you use, because you can set the
+configuration variable in your `$HOME/.gitconfig` just once and have
+it affect all repositories you touch.
+
+When the `core.fsmonitor` or `core.useBuiltinFSMonitor` configuration
+variable is changed, the file system monitor is added to or removed
+from the index the next time a command reads the index. When
+`--[no-]fsmonitor` are used, the file system monitor is immediately
+added to or removed from the index.
 
 CONFIGURATION
 -------------
diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index b51959ff941..b7d5e926f7b 100644
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

