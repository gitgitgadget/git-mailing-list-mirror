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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A668C11F69
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 14:47:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4114561403
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 14:47:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232884AbhGAOu1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Jul 2021 10:50:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232817AbhGAOuW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jul 2021 10:50:22 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0F92C061762
        for <git@vger.kernel.org>; Thu,  1 Jul 2021 07:47:51 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id i94so8602446wri.4
        for <git@vger.kernel.org>; Thu, 01 Jul 2021 07:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ZoO136qbmKSNeu7dMlW5FdUmzzXdWr4uk4/pcU4Tq1I=;
        b=AQsOQ0Y3vIZJkdPKtaGBZgxTm6CY9aqCEFD45pO2IXAyl/PB2z7MtA0sOJ6N4VNe6S
         7Leg1srYVaOMAElMIVYGnii/4l4FCU/5qqK4WZOlg/yMx+Ozi4s037AxM3p2LTTYPjHE
         JO3htjkmDrrsg79RhTNswI+fFGbO5Jh7bo+/jKOaeecTIsBgUMZZMnQSsf5dFuTvOA26
         DVpIcUUJqG5ZtrClDS0khFmebq/4jdVBHL0kohlUu82stD3+Xf+U5mALCetadTgOEpSB
         dzGQpkcsA9BZOP+UEDQGmif8awbujY7WQihYI23KEpTRV3asnMqcjYXT5BIHsKzVZ1fo
         /MtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ZoO136qbmKSNeu7dMlW5FdUmzzXdWr4uk4/pcU4Tq1I=;
        b=ejRRyiXkPN135SjXlpRr0IumFMF9DZLS89Ey611La1g6aJbtinbHIEbnwzu2y5SJY1
         aa2xOMu70jI/oiEzPbjFOVIU6jcStdUPVof06hjMeKqBVfHR/N9B+l0ow7u/TZut8KAD
         wxSOUuncyQS0QgL4/URtCcFsqBtUawGinIqEviCTKqHL/IRHc3nV0ZKNam+Xx92DVXub
         PHBQynw4xmyvQQqtFUX06WyxBAyCOUVADZ6KIMehGP5orP+iHX2yG0RYvZopSo0qr4EE
         ncBQu/A/o/+YoiaPlU8JRdsJDjofKg0vezWZXKf0RtxLcuUUWi0D0babju18NgpQebxX
         +ruw==
X-Gm-Message-State: AOAM53282spMxz18CHQLAsMYp9sXKCyE1YgB6xNoKbI0ZvE8wzrOBdtK
        QDzQCuzvCGpjNtGdF6tctMhPpTNoxj0=
X-Google-Smtp-Source: ABdhPJwro/flhiVj5aWWr+VSMXak0HctkFnpTRotqd+kwLjxzB87hA3fQR/QZDp6VasrbjA9cjX08A==
X-Received: by 2002:a5d:5742:: with SMTP id q2mr22260wrw.256.1625150870428;
        Thu, 01 Jul 2021 07:47:50 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d3sm156462wrx.28.2021.07.01.07.47.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 07:47:50 -0700 (PDT)
Message-Id: <f88db92d4259d1c29827e97e957daf6eda39c551.1625150864.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.923.v3.git.1625150864.gitgitgadget@gmail.com>
References: <pull.923.v2.git.1621691828.gitgitgadget@gmail.com>
        <pull.923.v3.git.1625150864.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 01 Jul 2021 14:47:18 +0000
Subject: [PATCH v3 08/34] fsmonitor--daemon: add a built-in fsmonitor daemon
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
index 311841f9bed..4baba472aa8 100644
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
index 209c97aa22d..8fe1e42a435 100644
--- a/Makefile
+++ b/Makefile
@@ -1097,6 +1097,7 @@ BUILTIN_OBJS += builtin/fmt-merge-msg.o
 BUILTIN_OBJS += builtin/for-each-ref.o
 BUILTIN_OBJS += builtin/for-each-repo.o
 BUILTIN_OBJS += builtin/fsck.o
+BUILTIN_OBJS += builtin/fsmonitor--daemon.o
 BUILTIN_OBJS += builtin/gc.o
 BUILTIN_OBJS += builtin/get-tar-commit-id.o
 BUILTIN_OBJS += builtin/grep.o
diff --git a/builtin.h b/builtin.h
index 16ecd5586f0..2470d1cd3a2 100644
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
index 00000000000..df2bad53111
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
index 18bed9a9964..c6160f4a886 100644
--- a/git.c
+++ b/git.c
@@ -533,6 +533,7 @@ static struct cmd_struct commands[] = {
 	{ "format-patch", cmd_format_patch, RUN_SETUP },
 	{ "fsck", cmd_fsck, RUN_SETUP },
 	{ "fsck-objects", cmd_fsck, RUN_SETUP },
+	{ "fsmonitor--daemon", cmd_fsmonitor__daemon, RUN_SETUP },
 	{ "gc", cmd_gc, RUN_SETUP },
 	{ "get-tar-commit-id", cmd_get_tar_commit_id, NO_PARSEOPT },
 	{ "grep", cmd_grep, RUN_SETUP_GENTLY },
-- 
gitgitgadget

