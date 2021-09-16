Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2916C433EF
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 19:54:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B853E61164
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 19:54:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235853AbhIPTz4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Sep 2021 15:55:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235746AbhIPTzu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Sep 2021 15:55:50 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A6F4C061574
        for <git@vger.kernel.org>; Thu, 16 Sep 2021 12:54:29 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id y132so5644487wmc.1
        for <git@vger.kernel.org>; Thu, 16 Sep 2021 12:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=rgNztFjSIfkFrumoWBCPgDcO19sT/SrE7dYPYozTBh8=;
        b=glTGV7L1uaAZ/YR1aGyrGERKPuJKZeKk1solSkr4fEiywE3BQYYczoNFd0SyVi0M0K
         xmRA3uS3Jft35i3pAPmhT0iwAz3Ci26vxepET3r3GH2QEXBS33To2SxTHUbgfycljDWO
         w+SaDzx0XY8EAarhgG2xWcM8gmYOA/+5uhARUw9RkkI8EE53uMDpFu2l81VnfuNs9It/
         qge/tmZLIG54BWWOYMHiyfgdWaB1TnGgq9qTTv9A61lhjH95ob70d0WS27X5WaJCpwb8
         UcvcF1t939yormSh9WnqIefvVCl9KVIfwAThSmyoAwMHgVJ6pkcD8vnUYuqfzWVzQvZq
         nTyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=rgNztFjSIfkFrumoWBCPgDcO19sT/SrE7dYPYozTBh8=;
        b=xUT647kGDEFjxe2hAa+Lqzfnzur4u+BhqQ5sTnJa0WSilsbi11BB40hnSr7KPp+6s/
         LiTC7XqpyQ27JzfoYNtt6K1yK8xPfl5jVYxdg9sDuLfXHzvlQ/qf5Qi3KR/HXsia2z3D
         wq2Tw7sivDGPEJYkH4tPImXWJQiTl3WkZJx5lwsMaWinF7hEFCV5qw4NZJLLwcMONyEn
         VcU62jOXOf6WiT+Cd4D7r2wOdiDzVsESq3lAyY+Vh8Mt7aa3GowI4776Mm5OArrr1MAR
         4WduUd/O9RL5WCvJeE7EXx203izB022HwBIhezxyDJgExn3kfB8cgn21IERMqO36BF8l
         vbEw==
X-Gm-Message-State: AOAM532Ya2hKie4rY+IE0jED+mAntkfaqBHasQbJQxNrmE1s4nJKhOWf
        y3VYXHO5PLv296MClWoKf8CVdyRtgfE=
X-Google-Smtp-Source: ABdhPJwTmw3QnpJ+OZZ9hlNXH+j3hCZTOq/5cQ/oA/n9ZgcqZoBypRzHpfkdz55TBWWm2yAmKiZiaQ==
X-Received: by 2002:a7b:cb97:: with SMTP id m23mr5698648wmi.70.1631822067747;
        Thu, 16 Sep 2021 12:54:27 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y6sm4247811wrp.46.2021.09.16.12.54.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 12:54:27 -0700 (PDT)
Message-Id: <fb5251e47ae6c8132d4a5a3c01bdfc33525f625d.1631822063.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1041.git.1631822063.gitgitgadget@gmail.com>
References: <pull.1041.git.1631822063.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 16 Sep 2021 19:54:23 +0000
Subject: [PATCH 5/5] fsmonitor: update fsmonitor config documentation
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

Update references to `core.fsmonitor` and `core.fsmonitorHookVersion` and
pointers to `Watchman` to mention the new `core.useBuiltinFSMonitor`
value.

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
