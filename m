Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58137C433FE
	for <git@archiver.kernel.org>; Fri, 11 Feb 2022 20:56:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353556AbiBKU4g (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Feb 2022 15:56:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353504AbiBKU43 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Feb 2022 15:56:29 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 958BFD51
        for <git@vger.kernel.org>; Fri, 11 Feb 2022 12:56:27 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id s10so3657073wrb.1
        for <git@vger.kernel.org>; Fri, 11 Feb 2022 12:56:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=uVL77nex7ZAYO78i2Z6kxcoK9uBUnTAgdQguIHAiFEE=;
        b=g8xzP2J3spn52Q9KdYBIfbm2mkn+5oAHLfA2JslKj1iEs0dXkGn4lMM4LdsnKVA8eg
         7kkkcFvZPicCj+vKwznZQCJyDc3IPYKmmgDF9v6mgNXE01P5Tsmf9yPnpSxiciUzeH1V
         8PwlMcnABYjC2pKR5PEwg7GZ5rDVC1RvlVlPeL6KKeySE6GfVacZCQqwwDANl7lEnTsd
         i97HNBUOzxmdgrxEEzRIaTu4hPKO2uZ11V4Wwvjp+1nhJI8H5vDOLtkAAVRzHLhSL+HL
         57qY5ahPs6MXIRQJj7HhxoFKo+tL8hglHAQmTem4NAyvJkVBGlHus8o1aGQg4C9s7alO
         Sy6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=uVL77nex7ZAYO78i2Z6kxcoK9uBUnTAgdQguIHAiFEE=;
        b=YAsvQ8uV+4vWegmbloOn1kF7MRBRxkHuQu9mIdEyuJUm/hPUEa7/dhQqxvKeIl/Hpq
         5mQBA5Xwy+pQjMgvR3p2fYG/v1oU6fjHF0jjm+yUiyniPvC0IgUH6IR4B/z9ZZc2OIYY
         EtoUq6pUQDFGOHDzojSSZ4ugpH6INtPLWXca5RdJLSFNj0H/SlQA9mvU7DwjqX/uKAqE
         3rpm9SMrYkWAYi65cIomV0K9P6VBb3aTNwV8jsMOxp//PucT/r4JE0992xCfmPAqO53w
         lM5CIs0vvR97fU0YZyVildmCm78bayFjhcGOOWDSvQMkuMWOzIn/2d6Ug1wiqsKHOHJ/
         FLsw==
X-Gm-Message-State: AOAM530yipDosr7VXJx4fdBP/IcWmuERbrVDRluZeq27QScp+tKZag5D
        qTsMbHFn9AQjpsf4hpA0lvAjbgOlLgs=
X-Google-Smtp-Source: ABdhPJwanMpSIgY0JfK3VBFkTZ3VnSsRDhYBgy0EQdTQET06vFPN/TmJDUKwG0673HO/9QQZX1Qx3A==
X-Received: by 2002:a05:6000:2aa:: with SMTP id l10mr719910wry.14.1644612986066;
        Fri, 11 Feb 2022 12:56:26 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b7sm11533192wrp.23.2022.02.11.12.56.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 12:56:25 -0800 (PST)
Message-Id: <bdd7334da3162ce77c216d61ce9d979f12637ac5.1644612979.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1041.v5.git.1644612979.gitgitgadget@gmail.com>
References: <pull.1041.v4.git.1634826309.gitgitgadget@gmail.com>
        <pull.1041.v5.git.1644612979.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 11 Feb 2022 20:55:55 +0000
Subject: [PATCH v5 06/30] fsmonitor--daemon: add a built-in fsmonitor daemon
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Jeff Hostetler <git@jeffhostetler.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
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
 builtin/fsmonitor--daemon.c | 46 +++++++++++++++++++++++++++++++++++++
 git.c                       |  1 +
 5 files changed, 50 insertions(+)
 create mode 100644 builtin/fsmonitor--daemon.c

diff --git a/.gitignore b/.gitignore
index f817c509ec0..e81de1063a4 100644
--- a/.gitignore
+++ b/.gitignore
@@ -72,6 +72,7 @@
 /git-format-patch
 /git-fsck
 /git-fsck-objects
+/git-fsmonitor--daemon
 /git-gc
 /git-get-tar-commit-id
 /git-grep
diff --git a/Makefile b/Makefile
index 9943f0f7c11..3b7a3f88b50 100644
--- a/Makefile
+++ b/Makefile
@@ -1106,6 +1106,7 @@ BUILTIN_OBJS += builtin/fmt-merge-msg.o
 BUILTIN_OBJS += builtin/for-each-ref.o
 BUILTIN_OBJS += builtin/for-each-repo.o
 BUILTIN_OBJS += builtin/fsck.o
+BUILTIN_OBJS += builtin/fsmonitor--daemon.o
 BUILTIN_OBJS += builtin/gc.o
 BUILTIN_OBJS += builtin/get-tar-commit-id.o
 BUILTIN_OBJS += builtin/grep.o
diff --git a/builtin.h b/builtin.h
index 83379f3832c..40e9ecc8485 100644
--- a/builtin.h
+++ b/builtin.h
@@ -159,6 +159,7 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix);
 int cmd_for_each_repo(int argc, const char **argv, const char *prefix);
 int cmd_format_patch(int argc, const char **argv, const char *prefix);
 int cmd_fsck(int argc, const char **argv, const char *prefix);
+int cmd_fsmonitor__daemon(int argc, const char **argv, const char *prefix);
 int cmd_gc(int argc, const char **argv, const char *prefix);
 int cmd_get_tar_commit_id(int argc, const char **argv, const char *prefix);
 int cmd_grep(int argc, const char **argv, const char *prefix);
diff --git a/builtin/fsmonitor--daemon.c b/builtin/fsmonitor--daemon.c
new file mode 100644
index 00000000000..f0498793379
--- /dev/null
+++ b/builtin/fsmonitor--daemon.c
@@ -0,0 +1,46 @@
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
+	git_config(git_default_config, NULL);
+
+	argc = parse_options(argc, argv, prefix, options,
+			     builtin_fsmonitor__daemon_usage, 0);
+	if (argc != 1)
+		usage_with_options(builtin_fsmonitor__daemon_usage, options);
+	subcmd = argv[0];
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
index 340665d4a04..a8b44d9b587 100644
--- a/git.c
+++ b/git.c
@@ -536,6 +536,7 @@ static struct cmd_struct commands[] = {
 	{ "format-patch", cmd_format_patch, RUN_SETUP },
 	{ "fsck", cmd_fsck, RUN_SETUP },
 	{ "fsck-objects", cmd_fsck, RUN_SETUP },
+	{ "fsmonitor--daemon", cmd_fsmonitor__daemon, RUN_SETUP },
 	{ "gc", cmd_gc, RUN_SETUP },
 	{ "get-tar-commit-id", cmd_get_tar_commit_id, NO_PARSEOPT },
 	{ "grep", cmd_grep, RUN_SETUP_GENTLY },
-- 
gitgitgadget

