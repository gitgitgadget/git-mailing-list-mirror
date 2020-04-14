Return-Path: <SRS0=cd4n=56=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCB5AC2BA2B
	for <git@archiver.kernel.org>; Tue, 14 Apr 2020 00:55:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A23C92075E
	for <git@archiver.kernel.org>; Tue, 14 Apr 2020 00:55:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aA+UADZJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390676AbgDNAzL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Apr 2020 20:55:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390662AbgDNAzH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Apr 2020 20:55:07 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B3B3C0A3BE2
        for <git@vger.kernel.org>; Mon, 13 Apr 2020 17:55:07 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id x16so10107678pgi.0
        for <git@vger.kernel.org>; Mon, 13 Apr 2020 17:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=lzl9N1aBmMmhXyqNAsXSvFyUbzk6Sny0sHkIrrOE8UU=;
        b=aA+UADZJu38hcssiCBqdN7LXDnOx33BaiF5FkNLFRleaTx03AJW1we0EcfbttbVikT
         tlJi8ahksYITSWJPdyYkv9V9pMWx//UY6AifnvP7AjF3/O8MwfBsdQR3Cruii8ZROrWn
         UaIzVXac+ra0qmZ0ibQAnapsc+HDmSuOzNTH27D0rAqtf9DcgcD+MeWfb2LNY+yrpQHP
         UPetzQGjp3nQLdYS91hanbMygRPONcaq96kGmhrBz/+HkcZKhFAG73OlwXENWb4g/4hW
         ZOVQk0CW2LMgj65S8NiIPj5YlJiU5Kmm0rw2oVrQsZkUpUT+FJ5YRDbT2pE2eMIN1Hyn
         dBNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=lzl9N1aBmMmhXyqNAsXSvFyUbzk6Sny0sHkIrrOE8UU=;
        b=g1d5z1nbe/bYu0NGmzkXFd//X+WxSqFOzH4Lxl5LGHvrHln9feBGrWzViurm/u0fdb
         ddUGD0B2MmEm+izj8mDmDU1z6HEYFX7tKaDEUKbqfGaA8TWGEjy71/XWAeFkiO6QZU2m
         K2vkUoqBcnDd/SIAQLHONGZaNvxOQq9soAzRZCvSy06ZsN31XZkLDxfsqSpjyiCSosms
         OQR6cQEvoUfaCkQuADtyuJC2qEpok0eBIqyDjM7kI/n9B6V3D2NnVaqLkLJaRwI6EfqH
         LHPGAqOeil2794fRQD0oMnZwXQwC0BgLwzL5jNomK67/ezJxFZ+wH/9UO6YBt/JXBPIB
         QWOw==
X-Gm-Message-State: AGi0Puag0rniwVN1J8IT8aZf+LYdnU/6Y5sPkYkv4f7eiHjY+wP/DZ9r
        vYUDqD6T4GfF4OQKawHG15HWK4UStC+Gi1BIomX4zDNKjyCiBLSQ/5wI55qvsrthiOG854IDYQQ
        xRzCfFEQvo4Z1mMNgvH4vmv6Jax/KL+XQccmBwSEaRdxphDG+ImsZ370YZjGfSn+kXX3XrBlsaA
        ==
X-Google-Smtp-Source: APiQypKUyI2RC53/APZdzGVrlr8SYPwXDTfNqkAXmVHQ3DQ+fCbqWSf3baxNV/BOBL47nwQ9rIDbBR+NsW5YFRo/m9g=
X-Received: by 2002:a63:c101:: with SMTP id w1mr6165467pgf.126.1586825706765;
 Mon, 13 Apr 2020 17:55:06 -0700 (PDT)
Date:   Mon, 13 Apr 2020 17:54:56 -0700
In-Reply-To: <20200414005457.3505-1-emilyshaffer@google.com>
Message-Id: <20200414005457.3505-2-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20191210023335.49987-1-emilyshaffer@google.com> <20200414005457.3505-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.26.0.110.g2183baf09c-goog
Subject: [RFC PATCH v2 1/2] hook: scaffolding for git-hook subcommand
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
index 188bd1c3de..0f8b74f651 100644
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
index ef1ff2228f..7b9670c205 100644
--- a/Makefile
+++ b/Makefile
@@ -1079,6 +1079,7 @@ BUILTIN_OBJS += builtin/get-tar-commit-id.o
 BUILTIN_OBJS += builtin/grep.o
 BUILTIN_OBJS += builtin/hash-object.o
 BUILTIN_OBJS += builtin/help.o
+BUILTIN_OBJS += builtin/hook.o
 BUILTIN_OBJS += builtin/index-pack.o
 BUILTIN_OBJS += builtin/init-db.o
 BUILTIN_OBJS += builtin/interpret-trailers.o
diff --git a/builtin.h b/builtin.h
index 2b25a80cde..c4cd252f61 100644
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
index b07198fe03..c79a9192d6 100644
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
2.26.0.110.g2183baf09c-goog

