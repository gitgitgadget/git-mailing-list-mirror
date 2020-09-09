Return-Path: <SRS0=gV3S=CS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DC61C433E2
	for <git@archiver.kernel.org>; Wed,  9 Sep 2020 00:50:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3428B2177B
	for <git@archiver.kernel.org>; Wed,  9 Sep 2020 00:50:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="WYLmF6O1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729767AbgIIAuH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Sep 2020 20:50:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728443AbgIIAtx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Sep 2020 20:49:53 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD005C061573
        for <git@vger.kernel.org>; Tue,  8 Sep 2020 17:49:52 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id k13so739756pfh.4
        for <git@vger.kernel.org>; Tue, 08 Sep 2020 17:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=r6qnFQQAQ0pBsTJaIgLEW50yMm9fukbofv9T2JJc0g8=;
        b=WYLmF6O1kdA/ZgvFUtFXUIrQRkavA9oo2Op4WxQkwo7rcutHF8s0bN1eD3yklrEezg
         YnI0YlPTXtS0/iS37A2wOSUlEOWNrfh5oVtxOHGqfc5f0T9W0mbxXtq2Qbr96QW/Dmxm
         qZzc7IAnJchRG6t2VV6YkGL90UL94nONG5so/1gkRIK299i7Je4hOj6PD/g6TPV2SEqB
         7QgFewD7BpRBpA5qePfMwdvbkzbBsgGYT/R7RUcFzwDEHMxPUt9TlSeXGVRwJZgvGPpQ
         TQKPw224CRFhD8J3WYN8f7MGXwZOIGaySlTcs/uzVdpsodfaoiAsOtRjtAf71Zq0crnI
         SKoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=r6qnFQQAQ0pBsTJaIgLEW50yMm9fukbofv9T2JJc0g8=;
        b=T+FbtTV9G2iyRO593FEjBCJEVY21h3TCONQsHH84AcJim6V3lH/9UImGkw9V2R+rSH
         fCeQSChdcP4zStnEIinT/oCH0S9YX6qJfpM1XaDJYPCZo8xKgEWfNk5cWd4TkceHgodF
         eQJu3SsxSjs/2UJw2wcdVIkcXLPqvRAk0ftJ7tb5HoyZrs59y/vD3f2j7SzEO9HD0nvP
         R/xAQF+vn+653G1zxRcDB/mcSQ4MLUKyV4rfxUnzB17k8O6Oxg2Rlr7zUlq8QBMIPXAH
         c2q9Ep4EPdtYxvgrZhHkEKv20CNaAS9PnTEwjhwuBmtllM27ZMyyFbXVnkWC9lT4ePix
         jlLg==
X-Gm-Message-State: AOAM531AbPcCDMWcvl4iF2fWGY1V+l4qWSLN74LDVt0048PdZdY6bz0B
        t/ziwMJl0KTyC+TkleakeSSs0HzU52OyA/fbf7nyJr2cfk5HibA+Abz8n+Xifg8ghsekCAWgdq2
        ooBgPawQb8ItcLK4Y1OU/egvtd09PWiqrtti7RrvMTLzDkcM056B/s7vAKYXka58ZPsbWWLyTug
        ==
X-Google-Smtp-Source: ABdhPJxI0alYjj2G7pOE5aQko4r+7ImHJnCYA2qq7AghOeQl2WDWgrmPw5+700+/vEmxYccItvoJ3f1Y0lpwOK9L6mg=
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:0:1ea0:b8ff:fe77:f690])
 (user=emilyshaffer job=sendgmr) by 2002:a63:374d:: with SMTP id
 g13mr1028930pgn.383.1599612592110; Tue, 08 Sep 2020 17:49:52 -0700 (PDT)
Date:   Tue,  8 Sep 2020 17:49:32 -0700
In-Reply-To: <20200909004939.1942347-1-emilyshaffer@google.com>
Message-Id: <20200909004939.1942347-3-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20200909004939.1942347-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.28.0.rc0.142.g3c755180ce-goog
Subject: [PATCH v4 2/9] hook: scaffolding for git-hook subcommand
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
index 65f8cfb236..6eee75555e 100644
--- a/Makefile
+++ b/Makefile
@@ -1077,6 +1077,7 @@ BUILTIN_OBJS += builtin/get-tar-commit-id.o
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
index 8bd1d7551d..1cdb3221a5 100644
--- a/git.c
+++ b/git.c
@@ -519,6 +519,7 @@ static struct cmd_struct commands[] = {
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
2.28.0.rc0.142.g3c755180ce-goog

