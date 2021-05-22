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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C021FC47081
	for <git@archiver.kernel.org>; Sat, 22 May 2021 13:57:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A55946115C
	for <git@archiver.kernel.org>; Sat, 22 May 2021 13:57:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231255AbhEVN6r (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 May 2021 09:58:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231191AbhEVN6n (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 May 2021 09:58:43 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AA4BC06138E
        for <git@vger.kernel.org>; Sat, 22 May 2021 06:57:17 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id o127so12549111wmo.4
        for <git@vger.kernel.org>; Sat, 22 May 2021 06:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=3VEHOZIwLhszB9Oy3JOIWLbqD59nCCtj2Y7uYExjmVA=;
        b=mAQrcwtml7PhIBEc/bCPLmrhrSBQY9utRJU5KYvrcMdn6JMJTvh+VylWZ+hUiqUy1u
         JDc0l0+En7L05QgMiVvzhthnmIEUGDxNxw5zXIkKy4gn/R3noD5+aXnZr8Tz2VKMDdzk
         DJbWt9rNqlwsZouQVnJpzavYvRalGeU9mZWWIMZND4+79UkFroSE3xjBTFc3koF+Zfjh
         b8dC0Th9NMoESOdnpNNfOiG74RJ/pHip8RiH37S6ar58n+sH5lWC3yxU4SJoAbSRgv6I
         AVfRMwe3fo2C4jdDlPYfdhNt94vRdaush4snluOZm6NCjTGVUOBIDwJqjmXPWeBnv6Cv
         RAXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=3VEHOZIwLhszB9Oy3JOIWLbqD59nCCtj2Y7uYExjmVA=;
        b=g5gHHlgI9R2G+dhY0fYNJAbq4zsJ2DPR86gRig+PDerN6nCpaA6Ou9P2xNZaP/Hw57
         AgjUFEdXe6rmE90S9xAoFUepdF6bLSCIsxcysPsBL296KkV4VAN7/toUApfwE+TPT8SO
         pOhsfl0Z6xhB5iZA5DHIbQ2GSFYauNJgyhp1+JVPHNnP7FCl3Xl+cV1kkcER0isXxf6L
         3T95QQxMM/QO89jp3SdfQNIGNrvsNMJ4aNt7ucwrCVsVocDtp3XKwmZoZhQyUlsh17z2
         HXDZIFILgnCy40Dtotok6kFwRiCF9t5zBuFDxcTtp/PvYxKIBUQU1qZMwMhhjp/436Zl
         PqsQ==
X-Gm-Message-State: AOAM532ykeq16LpGV6k7AtqUJRUXuZMBnzhXywUQEvdJ5d/8X7SLPnPH
        l164yHBapa1MwWmc1E8Ooxa7rvwZGtk=
X-Google-Smtp-Source: ABdhPJwae0HugdH2+YpeaXvJdo9mZYkj3tnDIThBS3GxN3xMVpuKLGXG2huUWdZ0CgGjriPbFiuUbQ==
X-Received: by 2002:a05:600c:1551:: with SMTP id f17mr10750872wmg.17.1621691835691;
        Sat, 22 May 2021 06:57:15 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v11sm6677184wrs.9.2021.05.22.06.57.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 May 2021 06:57:15 -0700 (PDT)
Message-Id: <f362a88632e47267f67f5d805b899485eda46eb6.1621691828.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.923.v2.git.1621691828.gitgitgadget@gmail.com>
References: <pull.923.git.1617291666.gitgitgadget@gmail.com>
        <pull.923.v2.git.1621691828.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 22 May 2021 13:56:47 +0000
Subject: [PATCH v2 08/28] fsmonitor--daemon: add a built-in fsmonitor daemon
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

Create a built-in file system monitoring daemon that can be used by
the existing `fsmonitor` feature (protocol API and index extension)
to improve the performance of various Git commands, such as `status`.

The `fsmonitor--daemon` feature builds upon the `Simple IPC` API and
provides an alternative to hook access to existing fsmonitors such
as `watchman`.

This commit merely adds the new command without any functionality.

Co-authored-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 .gitignore                  |  1 +
 Makefile                    |  1 +
 builtin.h                   |  1 +
 builtin/fsmonitor--daemon.c | 53 +++++++++++++++++++++++++++++++++++++
 git.c                       |  1 +
 5 files changed, 57 insertions(+)
 create mode 100644 builtin/fsmonitor--daemon.c

diff --git a/.gitignore b/.gitignore
index 3dcdb6bb5ab8..beccf34abe9e 100644
--- a/.gitignore
+++ b/.gitignore
@@ -71,6 +71,7 @@
 /git-format-patch
 /git-fsck
 /git-fsck-objects
+/git-fsmonitor--daemon
 /git-gc
 /git-get-tar-commit-id
 /git-grep
diff --git a/Makefile b/Makefile
index 23f3b9890acd..74673acc9833 100644
--- a/Makefile
+++ b/Makefile
@@ -1092,6 +1092,7 @@ BUILTIN_OBJS += builtin/fmt-merge-msg.o
 BUILTIN_OBJS += builtin/for-each-ref.o
 BUILTIN_OBJS += builtin/for-each-repo.o
 BUILTIN_OBJS += builtin/fsck.o
+BUILTIN_OBJS += builtin/fsmonitor--daemon.o
 BUILTIN_OBJS += builtin/gc.o
 BUILTIN_OBJS += builtin/get-tar-commit-id.o
 BUILTIN_OBJS += builtin/grep.o
diff --git a/builtin.h b/builtin.h
index b6ce981b7377..7554476f90a4 100644
--- a/builtin.h
+++ b/builtin.h
@@ -158,6 +158,7 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix);
 int cmd_for_each_repo(int argc, const char **argv, const char *prefix);
 int cmd_format_patch(int argc, const char **argv, const char *prefix);
 int cmd_fsck(int argc, const char **argv, const char *prefix);
+int cmd_fsmonitor__daemon(int argc, const char **argv, const char *prefix);
 int cmd_gc(int argc, const char **argv, const char *prefix);
 int cmd_get_tar_commit_id(int argc, const char **argv, const char *prefix);
 int cmd_grep(int argc, const char **argv, const char *prefix);
diff --git a/builtin/fsmonitor--daemon.c b/builtin/fsmonitor--daemon.c
new file mode 100644
index 000000000000..df2bad531118
--- /dev/null
+++ b/builtin/fsmonitor--daemon.c
@@ -0,0 +1,53 @@
+#include "builtin.h"
+#include "config.h"
+#include "parse-options.h"
+#include "fsmonitor.h"
+#include "fsmonitor-ipc.h"
+#include "simple-ipc.h"
+#include "khash.h"
+
+static const char * const builtin_fsmonitor__daemon_usage[] = {
+	NULL
+};
+
+#ifdef HAVE_FSMONITOR_DAEMON_BACKEND
+
+int cmd_fsmonitor__daemon(int argc, const char **argv, const char *prefix)
+{
+	const char *subcmd;
+
+	struct option options[] = {
+		OPT_END()
+	};
+
+	if (argc < 2)
+		usage_with_options(builtin_fsmonitor__daemon_usage, options);
+
+	if (argc == 2 && !strcmp(argv[1], "-h"))
+		usage_with_options(builtin_fsmonitor__daemon_usage, options);
+
+	git_config(git_default_config, NULL);
+
+	subcmd = argv[1];
+	argv--;
+	argc++;
+
+	argc = parse_options(argc, argv, prefix, options,
+			     builtin_fsmonitor__daemon_usage, 0);
+
+	die(_("Unhandled subcommand '%s'"), subcmd);
+}
+
+#else
+int cmd_fsmonitor__daemon(int argc, const char **argv, const char *prefix)
+{
+	struct option options[] = {
+		OPT_END()
+	};
+
+	if (argc == 2 && !strcmp(argv[1], "-h"))
+		usage_with_options(builtin_fsmonitor__daemon_usage, options);
+
+	die(_("fsmonitor--daemon not supported on this platform"));
+}
+#endif
diff --git a/git.c b/git.c
index b53e66567138..41980c897964 100644
--- a/git.c
+++ b/git.c
@@ -523,6 +523,7 @@ static struct cmd_struct commands[] = {
 	{ "format-patch", cmd_format_patch, RUN_SETUP },
 	{ "fsck", cmd_fsck, RUN_SETUP },
 	{ "fsck-objects", cmd_fsck, RUN_SETUP },
+	{ "fsmonitor--daemon", cmd_fsmonitor__daemon, RUN_SETUP },
 	{ "gc", cmd_gc, RUN_SETUP },
 	{ "get-tar-commit-id", cmd_get_tar_commit_id, NO_PARSEOPT },
 	{ "grep", cmd_grep, RUN_SETUP_GENTLY },
-- 
gitgitgadget

