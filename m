Return-Path: <SRS0=Ny9l=7D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 243A4C433E2
	for <git@archiver.kernel.org>; Thu, 21 May 2020 18:54:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09183208C9
	for <git@archiver.kernel.org>; Thu, 21 May 2020 18:54:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aZEgH0a8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730035AbgEUSya (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 May 2020 14:54:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729940AbgEUSy2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 May 2020 14:54:28 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3505C061A0E
        for <git@vger.kernel.org>; Thu, 21 May 2020 11:54:27 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id z5so2022751ybg.11
        for <git@vger.kernel.org>; Thu, 21 May 2020 11:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=u2kvFFY9oVhlLIkyIXbtq9xt/mBrcL0FUluvBhTftHM=;
        b=aZEgH0a8OIXJtyG/424RcpZr6TI4WJ2gL6njip1NUiGV0sK24rsRVZGbSPAkgnaAi7
         +7WOD4mLBsnhOZ5SIFd8XpOBxStyWKhMcr6xK2YRNMfCgxDSo/8Wjct+AQdserHnkBvO
         6PRhH76pIpCR9/XzqhOttxBHcO2nQuZ7qzC3L6AOcg75GPV/QWd4Rg4i+5aMd89DPISc
         e8iZNFYK1305lq5e4TdWh3sLKxbBLGVu7lJskHhTOzfWa97ydXYIjRNjTU0pOUu9fEC2
         G68WeWm4/nXWuZMY3w8QRspmPIFDRSX7zu4+x2WgUbDMKfQ1Kx/RbeDI/Ksg65gNoI1W
         EB+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=u2kvFFY9oVhlLIkyIXbtq9xt/mBrcL0FUluvBhTftHM=;
        b=uZTWYWBnlhaafZPJyqYeM5f9jhGKSN5osXnORZ4VdswF4yoxJFpPqWpsDFekwG3JZd
         UX9DSCyWmxVWF2PxyukUHl118RNuiXUMk69DzAq2cVEpXuMtyQ+woWEt2vx35vhFrPyT
         j9xj6R8ZVaO/aCErO3YG0A4czzSmkkhknz6YD0GfdNFh9eJMVbzqL7o/3se9UYVYdsvS
         oaLHbm/sOGmODMwB7hz/iqj20P8JiNR4pJMv6GpIH9ZyBz/phuqB5H5ecEryHIJzulWk
         BzLKD4wlMewR010cy0ADtdu3p+hF0UedYlsYKLG37HuLag+cf1y9bkKo6GUcpfpmeiL/
         D4Hg==
X-Gm-Message-State: AOAM532AipXsqsK5zSJTHY6JOP8jn2qkvCyVg9B9Qk1Lm9VJQm9fpe5h
        Ry5/B3ov4MOJjn2tSgWtTKxfMsAbrpwS/VcHci/VTLazrSPkurFdT3HI6R3FCmu9ZbtBtP/sQal
        x38wavKvUgrwSQjfJ7TR6d4Kq3N0HMC4wpy4cqwDMon2x5kfqta/1/DkTwuuO/w+n3rXgeH/aPQ
        ==
X-Google-Smtp-Source: ABdhPJxaD9qsftWG+poMSIk4TFCxpu9JglFuVrr02Sw4f0hQ9jtqMcucuEVnKV8M8b3+IJ2VzT+IaIhaWlbJD1Kfzvw=
X-Received: by 2002:a25:e655:: with SMTP id d82mr7521984ybh.419.1590087266837;
 Thu, 21 May 2020 11:54:26 -0700 (PDT)
Date:   Thu, 21 May 2020 11:54:12 -0700
In-Reply-To: <20200521185414.43760-1-emilyshaffer@google.com>
Message-Id: <20200521185414.43760-3-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20200521185414.43760-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.27.0.rc0.183.gde8f92d652-goog
Subject: [PATCH v2 2/4] hook: scaffolding for git-hook subcommand
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Introduce infrastructure for a new subcommand, git-hook, which will be
used to ease config-based hook management. This command will handle
parsing configs to compose a list of hooks to run for a given event, as
well as adding or modifying hook configs in an interactive fashion.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
 .gitignore                    |  1 +
 Documentation/git-hook.txt    | 19 +++++++++++++++++++
 Makefile                      |  1 +
 builtin.h                     |  1 +
 builtin/hook.c                | 21 +++++++++++++++++++++
 git.c                         |  1 +
 t/t1360-config-based-hooks.sh | 11 +++++++++++
 7 files changed, 55 insertions(+)
 create mode 100644 Documentation/git-hook.txt
 create mode 100644 builtin/hook.c
 create mode 100755 t/t1360-config-based-hooks.sh

diff --git a/.gitignore b/.gitignore
index ee509a2ad2..0694a34884 100644
--- a/.gitignore
+++ b/.gitignore
@@ -75,6 +75,7 @@
 /git-grep
 /git-hash-object
 /git-help
+/git-hook
 /git-http-backend
 /git-http-fetch
 /git-http-push
diff --git a/Documentation/git-hook.txt b/Documentation/git-hook.txt
new file mode 100644
index 0000000000..2d50c414cc
--- /dev/null
+++ b/Documentation/git-hook.txt
@@ -0,0 +1,19 @@
+git-hook(1)
+===========
+
+NAME
+----
+git-hook - Manage configured hooks
+
+SYNOPSIS
+--------
+[verse]
+'git hook'
+
+DESCRIPTION
+-----------
+You can list, add, and modify hooks with this command.
+
+GIT
+---
+Part of the linkgit:git[1] suite
diff --git a/Makefile b/Makefile
index 3d3a39fc19..fce6ee154e 100644
--- a/Makefile
+++ b/Makefile
@@ -1080,6 +1080,7 @@ BUILTIN_OBJS += builtin/get-tar-commit-id.o
 BUILTIN_OBJS += builtin/grep.o
 BUILTIN_OBJS += builtin/hash-object.o
 BUILTIN_OBJS += builtin/help.o
+BUILTIN_OBJS += builtin/hook.o
 BUILTIN_OBJS += builtin/index-pack.o
 BUILTIN_OBJS += builtin/init-db.o
 BUILTIN_OBJS += builtin/interpret-trailers.o
diff --git a/builtin.h b/builtin.h
index a5ae15bfe5..4e736499c0 100644
--- a/builtin.h
+++ b/builtin.h
@@ -157,6 +157,7 @@ int cmd_get_tar_commit_id(int argc, const char **argv, const char *prefix);
 int cmd_grep(int argc, const char **argv, const char *prefix);
 int cmd_hash_object(int argc, const char **argv, const char *prefix);
 int cmd_help(int argc, const char **argv, const char *prefix);
+int cmd_hook(int argc, const char **argv, const char *prefix);
 int cmd_index_pack(int argc, const char **argv, const char *prefix);
 int cmd_init_db(int argc, const char **argv, const char *prefix);
 int cmd_interpret_trailers(int argc, const char **argv, const char *prefix);
diff --git a/builtin/hook.c b/builtin/hook.c
new file mode 100644
index 0000000000..b2bbc84d4d
--- /dev/null
+++ b/builtin/hook.c
@@ -0,0 +1,21 @@
+#include "cache.h"
+
+#include "builtin.h"
+#include "parse-options.h"
+
+static const char * const builtin_hook_usage[] = {
+	N_("git hook"),
+	NULL
+};
+
+int cmd_hook(int argc, const char **argv, const char *prefix)
+{
+	struct option builtin_hook_options[] = {
+		OPT_END(),
+	};
+
+	argc = parse_options(argc, argv, prefix, builtin_hook_options,
+			     builtin_hook_usage, 0);
+
+	return 0;
+}
diff --git a/git.c b/git.c
index a2d337eed7..99372529a2 100644
--- a/git.c
+++ b/git.c
@@ -517,6 +517,7 @@ static struct cmd_struct commands[] = {
 	{ "grep", cmd_grep, RUN_SETUP_GENTLY },
 	{ "hash-object", cmd_hash_object },
 	{ "help", cmd_help },
+	{ "hook", cmd_hook, RUN_SETUP },
 	{ "index-pack", cmd_index_pack, RUN_SETUP_GENTLY | NO_PARSEOPT },
 	{ "init", cmd_init_db },
 	{ "init-db", cmd_init_db },
diff --git a/t/t1360-config-based-hooks.sh b/t/t1360-config-based-hooks.sh
new file mode 100755
index 0000000000..34b0df5216
--- /dev/null
+++ b/t/t1360-config-based-hooks.sh
@@ -0,0 +1,11 @@
+#!/bin/bash
+
+test_description='config-managed multihooks, including git-hook command'
+
+. ./test-lib.sh
+
+test_expect_success 'git hook command does not crash' '
+	git hook
+'
+
+test_done
-- 
2.27.0.rc0.183.gde8f92d652-goog

