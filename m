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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF52EC2B9F2
	for <git@archiver.kernel.org>; Sat, 22 May 2021 13:57:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92DFE6115C
	for <git@archiver.kernel.org>; Sat, 22 May 2021 13:57:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231174AbhEVN6m (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 May 2021 09:58:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230295AbhEVN6k (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 May 2021 09:58:40 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E023C06174A
        for <git@vger.kernel.org>; Sat, 22 May 2021 06:57:14 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id b7so11957155wmh.5
        for <git@vger.kernel.org>; Sat, 22 May 2021 06:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=V/9CxnpqDwArhVx2MQERVzriRRP+9XRB4pNi0Oe7LQI=;
        b=IMdGdW8NiaJjjNlS64UyXF8eOSYoqq2yxfG4BX067Bh89OxMybvfXcO1Pye2KSRRu6
         jZgtUuLEzu98ZKOI+5dOoT9V3mql5npGQdQMoQWBQRviPvCvjZiyLDNwCmi5FrVf6ghw
         Tl942tgKxaHCtsbHAS7dUjbU4hUIq8u02vdm/ENVDtBRwOn2VcsJkHOQw4TYcPdksw4q
         ZHRinwHmO+mfhZky0H4aHvdN5IEnsjmzp9DgJxu7o22vLqq805ZbsQTZFvNR3B3qhAaR
         vyWJPHOxsNEaJDbKv4TvPYeKCTsKVxCP9gnvTiCCQZKGhlVzvkwEIKupXJAWy10HiXfp
         P5QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=V/9CxnpqDwArhVx2MQERVzriRRP+9XRB4pNi0Oe7LQI=;
        b=XqyuQCPjcoc4thk0smu6JlLjg6EoYukLeCNQFc8PlS9EtllqytDJrG4RIqlduXiwDb
         SShwfAosdc3WKO3TuGVZysaiJeQLYYXk11eBoONRItUim7LKVv+IwKbMtMQu4oxm0v4s
         /N/3ZB/uQvpi7GKoyCa6+vrGCbOcXs7MysvV5Cr7+yYfubbIWWInhtw/kzFa8ULM5sWY
         zP4DquDcuhbm/dacbUVXmM6JS0rGExuo/hIAxPU+wQTE/ehsP4YomlAbyJ1nTmxGYx2A
         mcDvBdb6MDZPIbG+AFVE6b8oChSmStwsnzB8ENKkp/+dM232s/Knagub6PEmpjocTfMK
         uSTg==
X-Gm-Message-State: AOAM532MtcjwC3r/qdUfGfVJVzvaoya8odMINZ0AZbTbAdhb8kF17n11
        I4dWJZSFNQeRLtJbq7qxrz7n9jqUBvk=
X-Google-Smtp-Source: ABdhPJzZ4tcBnDAgkG5b20oV0dy2TWO4LBNF1zJhM3qr++tx5xhaHr8QztcI2iWTkYV10djZZsuoBA==
X-Received: by 2002:a7b:c85a:: with SMTP id c26mr13638524wml.131.1621691832735;
        Sat, 22 May 2021 06:57:12 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c15sm5848155wrd.49.2021.05.22.06.57.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 May 2021 06:57:12 -0700 (PDT)
Message-Id: <d56f3e91db9f02eee60ae904a16176d98f656534.1621691828.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.923.v2.git.1621691828.gitgitgadget@gmail.com>
References: <pull.923.git.1617291666.gitgitgadget@gmail.com>
        <pull.923.v2.git.1621691828.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 22 May 2021 13:56:42 +0000
Subject: [PATCH v2 03/28] fsmonitor--daemon: update fsmonitor documentation
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
index c04f62a54a15..4f6e519bc025 100644
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
index 2853f168d976..c7c31b3fcf9c 100644
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

