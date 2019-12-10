Return-Path: <SRS0=g4/7=2A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6E90C04E30
	for <git@archiver.kernel.org>; Tue, 10 Dec 2019 02:33:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D34A20726
	for <git@archiver.kernel.org>; Tue, 10 Dec 2019 02:33:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MN4n6yDi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbfLJCdy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Dec 2019 21:33:54 -0500
Received: from mail-yb1-f202.google.com ([209.85.219.202]:50980 "EHLO
        mail-yb1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726509AbfLJCdy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Dec 2019 21:33:54 -0500
Received: by mail-yb1-f202.google.com with SMTP id d191so10303935ybc.17
        for <git@vger.kernel.org>; Mon, 09 Dec 2019 18:33:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Zg7COmVjgFoHl1E+QYjacBwUuAGzzhPi5DZOyD0SzJc=;
        b=MN4n6yDipLq9thdBqajPLVmML2YaSaDfFiRCAzJYYOW6rq2RbKcifzq189OEEFcNB0
         T5uymQ6oNcm+rHmZPSthoJyUCOOL6LcMJ6e0gQG0H1uv3YKiPZeIgdrnAD61aE5SO3/d
         L7CeGDGfPy46JURVbkkWUDMk5nelnomHydUgJbZx+82i/85rrRk6dRLAmeiCnX/ICIqW
         K7+admKSbgeiH++WRYtlHmAnSws0m4OrzXDprkaImFkbVb4j63sxBALgZ0H+ES7VKD8R
         nXtE6GzeKeguk4qg4kCLUYGpsvH8qC46OU/EsxzF+5FF0K2WORiVebcjosOnHtWlUK9u
         rg1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Zg7COmVjgFoHl1E+QYjacBwUuAGzzhPi5DZOyD0SzJc=;
        b=f4C5P11yD2+DTvbN6w6nRnkq5ZtrH1Ah+NUtSdeunwOZZx5PJHHXEqev+AZNPoC0/h
         +kyIq79JmWbcLEzCEfgYmXhkvhOIL3hADIUhI+CW7y013EEaW6BG6MhD3gR9CJS2x9Rp
         M80oEGyzbfuqmuEXyc7qFHVcu6cOaen+utdml6klLyY6XyECRc+bs3tbdCadt4GalwRH
         CCSKOTXrbFUo/MToyTb1hUYNvGRCs/tUauJUXx4g4Lh3gTY2rpSK1CyVRzX5QR4i7cCL
         2hGDE65YneusbpA/ULdKjBynlQKyjT8fwSojPgNYlwVCZ4U9I5t+S3xA3sC4N6ik4QkG
         GHBw==
X-Gm-Message-State: APjAAAX1Uk142DAxiR5HLiOwt0Y82mDLnPFNU+kUiNiWt5RrQiYBfq7n
        gSXzXSnbUW83h53W575/H38qpX3WVfkzhT6yl5EVUREqledYyPYIZTeq40y74R0D1ZP2RWWGKe9
        TkGTkU77YFEcNoaAInXMKaDD1RLYZgTuyRQetlVb/fu8jH12i4HB0XrFORfeTzZI6Q4ACtXrnzA
        ==
X-Google-Smtp-Source: APXvYqynrB+S62BB28crex/HXIEEr82/VapfqQNOaQgZtwNeMqtpDHZsCSnhDwnf5T6VhZfP3Y2lzZP9M5mJyYJ41p4=
X-Received: by 2002:a81:63c4:: with SMTP id x187mr23175389ywb.458.1575945233138;
 Mon, 09 Dec 2019 18:33:53 -0800 (PST)
Date:   Mon,  9 Dec 2019 18:33:30 -0800
In-Reply-To: <20191210023335.49987-1-emilyshaffer@google.com>
Message-Id: <20191210023335.49987-2-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20191210023335.49987-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.24.0.393.g34dc348eaf-goog
Subject: [PATCH 1/6] hook: scaffolding for git-hook subcommand
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
index 89b3b79c1a..9ef59b9baa 100644
--- a/.gitignore
+++ b/.gitignore
@@ -74,6 +74,7 @@
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
index 58b92af54b..83263505c0 100644
--- a/Makefile
+++ b/Makefile
@@ -1074,6 +1074,7 @@ BUILTIN_OBJS += builtin/get-tar-commit-id.o
 BUILTIN_OBJS += builtin/grep.o
 BUILTIN_OBJS += builtin/hash-object.o
 BUILTIN_OBJS += builtin/help.o
+BUILTIN_OBJS += builtin/hook.o
 BUILTIN_OBJS += builtin/index-pack.o
 BUILTIN_OBJS += builtin/init-db.o
 BUILTIN_OBJS += builtin/interpret-trailers.o
diff --git a/builtin.h b/builtin.h
index 5cf5df69f7..d4ca2ac9a5 100644
--- a/builtin.h
+++ b/builtin.h
@@ -173,6 +173,7 @@ int cmd_get_tar_commit_id(int argc, const char **argv, const char *prefix);
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
index ce6ab0ece2..c8344b9ab7 100644
--- a/git.c
+++ b/git.c
@@ -513,6 +513,7 @@ static struct cmd_struct commands[] = {
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
2.24.0.393.g34dc348eaf-goog

