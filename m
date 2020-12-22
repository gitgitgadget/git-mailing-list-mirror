Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82121C433E6
	for <git@archiver.kernel.org>; Tue, 22 Dec 2020 00:03:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52E4322525
	for <git@archiver.kernel.org>; Tue, 22 Dec 2020 00:03:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726209AbgLVADJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Dec 2020 19:03:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbgLVADJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Dec 2020 19:03:09 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C995FC061793
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 16:02:28 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id a206so15773624ybg.0
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 16:02:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=isjX3r5+stGttIjq0LNRR8TugCAIuFE1YPQWpSzFGCw=;
        b=GbS+1WoVosn4KcK5M1WiRuSuqFxklMwj5JrJmK2TRXQTPB2Amh5X0fXVpUQwTMg3Sc
         /R9fcwufaAXXzaPW23adrRztLiEHNU9qMTtFOyf8z6cl/cSc0M4mh6rfLE6LR3L7kDZn
         Ac+N7fuqxB0fN7Ca0zcb8ngoA4Rdxdn0qCMQgnsipjPhHzTkvnqcflRCgmW7768ng8YQ
         AIfv8fNhdStxT+YMZhKu5PTibuvZK49nigmGfLjW2nhYO6ns5iew41YR5QQxwuMA8ieM
         vVlGhSqXyfPqZZTtARa0rYx6v0DavqT1iczElTVshR0WoW54EFDzE4eignkvLT6cEYM2
         7mEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=isjX3r5+stGttIjq0LNRR8TugCAIuFE1YPQWpSzFGCw=;
        b=AKELtkdL30GWX7UX2lw/XCdwGel4NXOqnlBLhMSWWYnTXw8TuXuTnCW4oHj1E61XQp
         zJmqsENK22vMOB7qdSw+5y0tY2FwuniLKvgdqKriB7GFCKtEpFk4md1UZz/qu5O5UQ1v
         DJCeypw6fvyRbi7eAGow1/LbnJo0TFOs3/o8tXMdV3DAxseXl3ns1/miR1sBXm+lZQ7A
         rL9r6Put6NW7rfIVHUP/gm9yto1WsZuSE1YT43PoN8uLSmT1RRj6+dedUp+/gcBzM1TC
         j37Go04cknnI7FoO5Lbfcct2Eom6b7f1IxP1OGwOu+J8nUCBgukNQ6wTii7PFEB5JxxW
         H5Sw==
X-Gm-Message-State: AOAM531YeNMH8MD6m7aD+UZtQ1WO96wVEwQbMvkn9zdIyJ3dUeZfOyGb
        LvI896JqAV+sm7TGkSSRqlI16o4+EdITrBGyfSuqG0Xbany2a5dLHYTYiPiIrubcaUW/K/nwx/v
        RX/hh3v2geahH496CmV3J0lGkgijj4SNP74hpnefqvoiXRKOSOpJk5q48YGycJ7PocOQo8cX6wA
        ==
X-Google-Smtp-Source: ABdhPJw5cY9sIIb7dVt9jYQNYboFNHwSzSoubdEC0NqI4n9qdsKmI3cf5O753D2JfhUPJ5Zg9E/jpk9iW0OKmkvXnt0=
Sender: "emilyshaffer via sendgmr" 
        <emilyshaffer@podkayne.svl.corp.google.com>
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:0:1ea0:b8ff:fe77:f690])
 (user=emilyshaffer job=sendgmr) by 2002:a25:ab74:: with SMTP id
 u107mr25186356ybi.44.1608595348002; Mon, 21 Dec 2020 16:02:28 -0800 (PST)
Date:   Mon, 21 Dec 2020 16:02:05 -0800
In-Reply-To: <20201222000220.1491091-1-emilyshaffer@google.com>
Message-Id: <20201222000220.1491091-3-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20201222000220.1491091-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.29.2.490.gc7ae633391
Subject: [PATCH v7 02/17] hook: scaffolding for git-hook subcommand
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
 command-list.txt              |  1 +
 git.c                         |  1 +
 t/t1360-config-based-hooks.sh | 11 +++++++++++
 8 files changed, 57 insertions(+)
 create mode 100644 Documentation/git-hook.txt
 create mode 100644 builtin/hook.c
 create mode 100755 t/t1360-config-based-hooks.sh

diff --git a/.gitignore b/.gitignore
index 3dcdb6bb5a..3608c35b73 100644
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
index 6fb86c5862..24cee44400 100644
--- a/Makefile
+++ b/Makefile
@@ -1101,6 +1101,7 @@ BUILTIN_OBJS += builtin/get-tar-commit-id.o
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
diff --git a/command-list.txt b/command-list.txt
index 9379b02e5e..75909bf602 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -103,6 +103,7 @@ git-grep                                mainporcelain           info
 git-gui                                 mainporcelain
 git-hash-object                         plumbingmanipulators
 git-help                                ancillaryinterrogators          complete
+git-hook                                mainporcelain
 git-http-backend                        synchingrepositories
 git-http-fetch                          synchelpers
 git-http-push                           synchelpers
diff --git a/git.c b/git.c
index a00a0a4d94..9d1768b8e8 100644
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

