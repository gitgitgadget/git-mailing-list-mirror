Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0498CC433FE
	for <git@archiver.kernel.org>; Sat,  5 Dec 2020 01:47:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD51B22DBF
	for <git@archiver.kernel.org>; Sat,  5 Dec 2020 01:47:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728117AbgLEBrA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Dec 2020 20:47:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbgLEBq7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Dec 2020 20:46:59 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B161C061A51
        for <git@vger.kernel.org>; Fri,  4 Dec 2020 17:46:19 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id z83so9291919ybz.2
        for <git@vger.kernel.org>; Fri, 04 Dec 2020 17:46:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=m859VmDX9tXDBkLVYCddTqjZNXiDWAKFJHTOT8Y5YGs=;
        b=ngLgiFlzF+qqIVArT0x51oNYns0yTygBkbzUa5YArn8N7TLKnTyc36SZM0mjpY8pr9
         6aLjMnfAXzRQQPSptRS5Az03st1WUfeu68InEr0SQXhRD8dpbIgl8L0y61uENU+Mfc48
         61qx84Al7XQCsB+O6Eje9AMHOMbh+JuHUOT/TxgD7bYxYQI+5fG1lYH4UK9wsFwbD1P4
         g5FR3NX7zFcptcPcK6r3wi2n+bxllhBqoDR5YKWCUkJMYnv+yGlqEWIfpSkJYpvgb/xy
         3iSnU1IYJWnoICjopgAdRtHmGtCAAGtff9hiU/sjgNI00CWmqpLam8YrQP+5Y53BSu9u
         r6Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=m859VmDX9tXDBkLVYCddTqjZNXiDWAKFJHTOT8Y5YGs=;
        b=IkKaVpBg42GNn2bBlpA2mKMVSFCPVMT9RiQaS/smr6Ph7Rl5tQyfFID4R99BYayM89
         o6WnXoJUUk/MjkeuDqPsg1PCCS5xNbuIztXLLbjeyFa1yeqflH2VRw/D3MnJL02s46hF
         CIAnAoNHY9KDCDQMLPRV67lW00jQD4ThSR37/7VwMP7daHv805GnOK/C7XceWIZkbCoC
         GciKkkIPSXvsmUrAqHdMJ7KhtvkbBN0/aoWzZXKBFxDgarI/GhfwYO5amy/aNZr+aIDt
         CFQfWyklzoxbft9h8++/0iXsPupTIu+ormCWZM+cFu1UcJMKWfYzVwjpHqWsdrqesSfR
         g65w==
X-Gm-Message-State: AOAM532hj7qrJt+AbAiqI+kpOo7wCKesSaUXn6lP7U6nVCZYYz6jS4nB
        50rAeuEkU92zg1O/gJL3yucruz0QoFZNVxXQqLxD7inYA1xkJHNlHQ1dMDm26x30/SUJ/c9TGLi
        7ybApF2sBRI8sC6lVSeLEuaHZlAQTFINwoqPYjo8+jlhsSkZFcaOGWcMoOTdseoVK7WUJORQepg
        ==
X-Google-Smtp-Source: ABdhPJxkzMRX4VcjLKTrjM6z7U0lsvV1EVByHcErbjOD2bRY136/JAs79d1QRJmdgE4z+hsLreL1GRp7cxLaVqViUeA=
Sender: "emilyshaffer via sendgmr" 
        <emilyshaffer@podkayne.svl.corp.google.com>
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:0:1ea0:b8ff:fe77:f690])
 (user=emilyshaffer job=sendgmr) by 2002:a5b:9cf:: with SMTP id
 y15mr2246691ybq.463.1607132778552; Fri, 04 Dec 2020 17:46:18 -0800 (PST)
Date:   Fri,  4 Dec 2020 17:45:52 -0800
In-Reply-To: <20201205014607.1464119-1-emilyshaffer@google.com>
Message-Id: <20201205014607.1464119-3-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20201205014607.1464119-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.28.0.226.g0268cb6820
Subject: [PATCH 02/17] hook: scaffolding for git-hook subcommand
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Introduce infrastructure for a new subcommand, git-hook, which will be
used to ease config-based hook management. This command will handle
parsing configs to compose a list of hooks to run for a given event, as
well as adding or modifying hook configs in an interactive fashion.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---

Notes:
    Since v4, mainly changed to RUN_SETUP_GENTLY so that 'git hook list' can
    be executed outside of a repo.

 .gitignore                    |  1 +
 Documentation/git-hook.txt    | 20 ++++++++++++++++++++
 Makefile                      |  1 +
 builtin.h                     |  1 +
 builtin/hook.c                | 21 +++++++++++++++++++++
 git.c                         |  1 +
 t/t1360-config-based-hooks.sh | 11 +++++++++++
 7 files changed, 56 insertions(+)
 create mode 100644 Documentation/git-hook.txt
 create mode 100644 builtin/hook.c
 create mode 100755 t/t1360-config-based-hooks.sh

diff --git a/.gitignore b/.gitignore
index f22b7a4cf1..094f58a175 100644
--- a/.gitignore
+++ b/.gitignore
@@ -76,6 +76,7 @@
 /git-grep
 /git-hash-object
 /git-help
+/git-hook
 /git-http-backend
 /git-http-fetch
 /git-http-push
diff --git a/Documentation/git-hook.txt b/Documentation/git-hook.txt
new file mode 100644
index 0000000000..9eeab0009d
--- /dev/null
+++ b/Documentation/git-hook.txt
@@ -0,0 +1,20 @@
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
+A placeholder command. Later, you will be able to list, add, and modify hooks
+with this command.
+
+GIT
+---
+Part of the linkgit:git[1] suite
diff --git a/Makefile b/Makefile
index 45bce31016..6ef9c0ee4e 100644
--- a/Makefile
+++ b/Makefile
@@ -1100,6 +1100,7 @@ BUILTIN_OBJS += builtin/get-tar-commit-id.o
 BUILTIN_OBJS += builtin/grep.o
 BUILTIN_OBJS += builtin/hash-object.o
 BUILTIN_OBJS += builtin/help.o
+BUILTIN_OBJS += builtin/hook.o
 BUILTIN_OBJS += builtin/index-pack.o
 BUILTIN_OBJS += builtin/init-db.o
 BUILTIN_OBJS += builtin/interpret-trailers.o
diff --git a/builtin.h b/builtin.h
index b6ce981b73..8df1d36a7a 100644
--- a/builtin.h
+++ b/builtin.h
@@ -163,6 +163,7 @@ int cmd_get_tar_commit_id(int argc, const char **argv, const char *prefix);
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
index 4b7bd77b80..8e92b5d3f6 100644
--- a/git.c
+++ b/git.c
@@ -525,6 +525,7 @@ static struct cmd_struct commands[] = {
 	{ "grep", cmd_grep, RUN_SETUP_GENTLY },
 	{ "hash-object", cmd_hash_object },
 	{ "help", cmd_help },
+	{ "hook", cmd_hook, RUN_SETUP_GENTLY },
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
2.28.0.rc0.142.g3c755180ce-goog

