Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90CE9C433ED
	for <git@archiver.kernel.org>; Thu,  1 Apr 2021 18:03:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 545996112E
	for <git@archiver.kernel.org>; Thu,  1 Apr 2021 18:03:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234768AbhDASDu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Apr 2021 14:03:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237013AbhDAR7U (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Apr 2021 13:59:20 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 749FFC0225BB
        for <git@vger.kernel.org>; Thu,  1 Apr 2021 08:41:12 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id g20so1264704wmk.3
        for <git@vger.kernel.org>; Thu, 01 Apr 2021 08:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=L6cQcSSTtAe/Y0CatYDGYID+YGP5BAtSb7fqSpCmaC4=;
        b=SOsk5unzQOWZK+bNvQuxJEQP6FeGq/G1uufzJwLK83s5Y0AuhDoV0PU0xkuIefhI/X
         t3CbBJKXpCTgv8UnxV4ZnMmPkBwmhUo43H76WXA4snOwaMYr6mgv2Fhtwar8MlH24nhc
         9G5ip4Mh2FbmqxIE59YEiXttar/kd+hM24rBOeSa/MwKUQo4hgtHyjF1qpCTmmO2l5Zc
         PFOWbZEp0sJJwOBXqHZ3SQmgFdVS6Z/g9g0oZ7xRX4t4cVgU6KBHmH2OWXvWYRy1ccB/
         mUdMK5Aq5+nyrOvK/Iwr13LMSXNEHpqxGnMt2f54p9R4zSzTyTochsD8j1va8WEvXvcX
         I2oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=L6cQcSSTtAe/Y0CatYDGYID+YGP5BAtSb7fqSpCmaC4=;
        b=kNwzba4i9wQNJU6bwhUPL5f51p/wU08YT1ZQ3CdTVmmLQlD5x7V+TzIcqGt/AC1uIY
         XG3Gxln5I/Zs1mD2Tq1ednGrv7EcH6aNI0aQNb/qw7s55K9BGqp5bEhuHpRNVu50quHh
         rcxr/w9TfB2bG8IDylllRH/mAHgqLryry71QxQa7n+Uh5RguZ3a6QhYFZ02WY2XbuMtg
         KwiYQUsgnju05D6cCmciI3b/lG4t3uSM5Rvck9+/cvEX+BGH3K1rB7cqF5/oMyYVhF02
         f6zN8VeAu6ZPWnpl0vEKFcZCvDSKHy7uk1vCtrSfQhjCzlloOrMF2fFN0B4Sho3r02vV
         XsOg==
X-Gm-Message-State: AOAM531szMq7uGzVMdprmxUV5T94vcULksNsZyJ7Ll9CtiCBmyqpEq1a
        AwR45P4Q+xqlER/W2cyBHc8V2cIAnl0=
X-Google-Smtp-Source: ABdhPJwUDo6c6LR/73irWyQcKd/QMRX4QnDrxFYlNLFt+dGZltU5jUH366ARQiWAGVB3n7uf4rjf+Q==
X-Received: by 2002:a7b:cdf7:: with SMTP id p23mr8728391wmj.26.1617291671235;
        Thu, 01 Apr 2021 08:41:11 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m14sm8675560wmi.27.2021.04.01.08.41.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 08:41:10 -0700 (PDT)
Message-Id: <95d511d83b1211f24aeb17edbd4918750f406ece.1617291666.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.923.git.1617291666.gitgitgadget@gmail.com>
References: <pull.923.git.1617291666.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 01 Apr 2021 15:40:47 +0000
Subject: [PATCH 05/23] fsmonitor--daemon: add a built-in fsmonitor daemon
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
 builtin/fsmonitor--daemon.c | 52 +++++++++++++++++++++++++++++++++++++
 git.c                       |  1 +
 5 files changed, 56 insertions(+)
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
index 50977911d41a..d792631d4250 100644
--- a/Makefile
+++ b/Makefile
@@ -1091,6 +1091,7 @@ BUILTIN_OBJS += builtin/fmt-merge-msg.o
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
index 000000000000..6700bac92c7d
--- /dev/null
+++ b/builtin/fsmonitor--daemon.c
@@ -0,0 +1,52 @@
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
+	enum daemon_mode {
+		UNDEFINED_MODE,
+	} mode = UNDEFINED_MODE;
+
+	struct option options[] = {
+		OPT_END()
+	};
+
+	if (argc == 2 && !strcmp(argv[1], "-h"))
+		usage_with_options(builtin_fsmonitor__daemon_usage, options);
+
+	git_config(git_default_config, NULL);
+
+	argc = parse_options(argc, argv, prefix, options,
+			     builtin_fsmonitor__daemon_usage, 0);
+
+	switch (mode) {
+	case UNDEFINED_MODE:
+	default:
+		die(_("Unhandled command mode %d"), mode);
+	}
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
index 9bc077a025cb..239deb9823fc 100644
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

