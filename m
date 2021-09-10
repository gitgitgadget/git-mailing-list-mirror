Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 780FEC433FE
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 15:38:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60193611EE
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 15:38:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234492AbhIJPj7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Sep 2021 11:39:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234460AbhIJPj6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Sep 2021 11:39:58 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BED3C061574
        for <git@vger.kernel.org>; Fri, 10 Sep 2021 08:38:47 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id n7-20020a05600c3b8700b002f8ca941d89so1683313wms.2
        for <git@vger.kernel.org>; Fri, 10 Sep 2021 08:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kDhwe1YX0ebevQCnZ3yLUGdX8s1+4DzEfGwM7imyfLQ=;
        b=EJC2js8SVRRKusgHbKrjC6q7ssLIqcr+LHtsSjGTrFDGo0lo512k1Cp3gPCjmhzfpR
         iqBX3BlWU2KxEwAAvMX1Q/C9xkjbmut3AkuofsWEa9l18VLTxESb8NKPlDXHEVrVi+Tz
         xHO5QAC/dj0CR+ToHBN7TSl8k35b0wjbf5S4uA4aUigwYtEluGxiGLN7ItfxZixDwuQF
         x1rsWTuuL5lSrBxW5kyb5seSJ7xYVgTc7uSgBtUPGH2c9ksLNT9lK3KSt33tams8IJho
         ZJ6RQtJAxemp4OSrIN7QKN5zxu7F1zOcoY3Det/gtorQOJYirTSHzDmM452qJCX+qYex
         H06A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kDhwe1YX0ebevQCnZ3yLUGdX8s1+4DzEfGwM7imyfLQ=;
        b=3WxYRqctOWWM6j0uvKWCBxdWXXMtVCobmbTmlOUXhYm+ELN2qjR9pK9F78EwRbcge+
         A7un7UA7MnwNcEiZ65Ly3uij+Al8ZkD0N3ip9jntG9J90UQixcU/Un+Wh9MA+tI+zjq4
         jxxYPM/hc0JZQY27vjK/48aUnwrlaPw4QJe1q6V/OoV8MnF7fngY5d/oY4sGKxiCbyhW
         x8HDkrei7FI8Pc6BbbvHw+orLxc6cGWO3c3imcuC1ChgFIKnEcRE2Giza2VSV05NgFqP
         nsGXsQwqvr5qwp4/ViJ0Ot/d0uK8w7U50Ebb9xyGA8WNypnw5UwNgVVplqverKTLCsix
         Kk1A==
X-Gm-Message-State: AOAM5336YheVq2NIaWzHlvkdyM2Gh3bqhWAHaAwPQ7uLav9Xw/0FkD0H
        bV1F3EtS/0UkDvYbtgAoR7zMKBvJVJ87Aw==
X-Google-Smtp-Source: ABdhPJy/XkcizityChwHJtSuX+93YwKw1Is9ypj4gbopEqvpJoi8mXKe6DRsNBUl1NSyZdaC+0aqKw==
X-Received: by 2002:a05:600c:298:: with SMTP id 24mr8894902wmk.172.1631288325869;
        Fri, 10 Sep 2021 08:38:45 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i5sm4181972wmq.17.2021.09.10.08.38.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 08:38:45 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Carlo Arenas <carenas@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 2/6] git.c: add a NEED_UNIX_SOCKETS option for built-ins
Date:   Fri, 10 Sep 2021 17:38:32 +0200
Message-Id: <patch-v2-2.6-d6c44402715-20210910T153147Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.876.g423ac861752
In-Reply-To: <cover-v2-0.6-00000000000-20210910T153146Z-avarab@gmail.com>
References: <cover-0.2-00000000000-20210901T110917Z-avarab@gmail.com> <cover-v2-0.6-00000000000-20210910T153146Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the implementation of b5dd96b70ac (make credential helpers
builtins, 2020-08-13) to declare in the "struct cmd_struct" that
NO_UNIX_SOCKETS can't be set.

This is one of two in-tree users for the empty lines in
parse_options() usage, getting rid of that is the main motivation for
this, but it also doesn't make sense to emit these sorts of usage
messages just to appease t0012-help.sh, which seemingly b5dd96b70ac
aimed to do.

I.e. these commands don't support "[options]", or "<action>" so
emitting that at the beginning is incorrect. We should just die right
away.

The existing code also had the edge case of not emitting the die()
message if a "-h" argument was given, since parse_options() will
handle the exit() itself in that case. We could feed it
PARSE_OPT_NO_INTERNAL_HELP, but this is better.

By moving this up to the "struct cmd_struct" we can also skip these in
--list-cmds=builtins instead, as noted above we shouldn't be exiting
with code 129 in these cases.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin.h                          |  6 ++++++
 builtin/credential-cache--daemon.c | 11 +----------
 builtin/credential-cache.c         | 11 +----------
 git.c                              | 15 ++++++++++++---
 t/t0012-help.sh                    | 10 ++++++++++
 5 files changed, 30 insertions(+), 23 deletions(-)

diff --git a/builtin.h b/builtin.h
index 16ecd5586f0..66713da6a02 100644
--- a/builtin.h
+++ b/builtin.h
@@ -63,6 +63,12 @@
  *	more informed decision, e.g., by ignoring `pager.<cmd>` for
  *	certain subcommands.
  *
+ * `NEED_UNIX_SOCKETS`:
+ *
+ *	This built-in will not work if NO_UNIX_SOCKETS is defined. It
+ *	will be recognized for emitting error messages, but won't be
+ *	listed in --list-cmds=builtins.
+ *
  * . Add `builtin/foo.o` to `BUILTIN_OBJS` in `Makefile`.
  *
  * Additionally, if `foo` is a new command, there are 4 more things to do:
diff --git a/builtin/credential-cache--daemon.c b/builtin/credential-cache--daemon.c
index 4c6c89ab0de..d9863287a4d 100644
--- a/builtin/credential-cache--daemon.c
+++ b/builtin/credential-cache--daemon.c
@@ -304,16 +304,7 @@ int cmd_credential_cache_daemon(int argc, const char **argv, const char *prefix)
 
 int cmd_credential_cache_daemon(int argc, const char **argv, const char *prefix)
 {
-	const char * const usage[] = {
-		"git credential-cache--daemon [options] <action>",
-		"",
-		"credential-cache--daemon is disabled in this build of Git",
-		NULL
-	};
-	struct option options[] = { OPT_END() };
-
-	argc = parse_options(argc, argv, prefix, options, usage, 0);
-	die(_("credential-cache--daemon unavailable; no unix socket support"));
+	BUG("should not be called under NO_UNIX_SOCKETS");
 }
 
 #endif /* NO_UNIX_SOCKET */
diff --git a/builtin/credential-cache.c b/builtin/credential-cache.c
index e8a74157471..22b49b265bf 100644
--- a/builtin/credential-cache.c
+++ b/builtin/credential-cache.c
@@ -142,16 +142,7 @@ int cmd_credential_cache(int argc, const char **argv, const char *prefix)
 
 int cmd_credential_cache(int argc, const char **argv, const char *prefix)
 {
-	const char * const usage[] = {
-		"git credential-cache [options] <action>",
-		"",
-		"credential-cache is disabled in this build of Git",
-		NULL
-	};
-	struct option options[] = { OPT_END() };
-
-	argc = parse_options(argc, argv, prefix, options, usage, 0);
-	die(_("credential-cache unavailable; no unix socket support"));
+	BUG("should not be called under NO_UNIX_SOCKETS");
 }
 
 #endif /* NO_UNIX_SOCKETS */
diff --git a/git.c b/git.c
index 18bed9a9964..6b0248841db 100644
--- a/git.c
+++ b/git.c
@@ -17,6 +17,7 @@
 #define SUPPORT_SUPER_PREFIX	(1<<4)
 #define DELAY_PAGER_CONFIG	(1<<5)
 #define NO_PARSEOPT		(1<<6) /* parse-options is not used */
+#define NEED_UNIX_SOCKETS	(1<<7) /* Works unless -DNO_UNIX_SOCKETS */
 
 struct cmd_struct {
 	const char *cmd;
@@ -66,6 +67,10 @@ static int list_cmds(const char *spec)
 	struct string_list list = STRING_LIST_INIT_DUP;
 	int i;
 	int nongit;
+	unsigned int exclude_option = 0;
+#ifdef NO_UNIX_SOCKETS
+	exclude_option |= NEED_UNIX_SOCKETS;
+#endif
 
 	/*
 	* Set up the repository so we can pick up any repo-level config (like
@@ -78,7 +83,7 @@ static int list_cmds(const char *spec)
 		int len = sep - spec;
 
 		if (match_token(spec, len, "builtins"))
-			list_builtins(&list, 0);
+			list_builtins(&list, exclude_option);
 		else if (match_token(spec, len, "main"))
 			list_all_main_cmds(&list);
 		else if (match_token(spec, len, "others"))
@@ -423,6 +428,10 @@ static int run_builtin(struct cmd_struct *p, int argc, const char **argv)
 	const char *prefix;
 
 	prefix = NULL;
+#ifdef NO_UNIX_SOCKETS
+	if (p->option & NEED_UNIX_SOCKETS)
+		die(_("%s is unavailable; there is no UNIX socket support in this build of Git"), p->cmd);
+#endif
 	help = argc == 2 && !strcmp(argv[1], "-h");
 	if (!help) {
 		if (p->option & RUN_SETUP)
@@ -513,8 +522,8 @@ static struct cmd_struct commands[] = {
 	{ "config", cmd_config, RUN_SETUP_GENTLY | DELAY_PAGER_CONFIG },
 	{ "count-objects", cmd_count_objects, RUN_SETUP },
 	{ "credential", cmd_credential, RUN_SETUP_GENTLY | NO_PARSEOPT },
-	{ "credential-cache", cmd_credential_cache },
-	{ "credential-cache--daemon", cmd_credential_cache_daemon },
+	{ "credential-cache", cmd_credential_cache, NEED_UNIX_SOCKETS },
+	{ "credential-cache--daemon", cmd_credential_cache_daemon, NEED_UNIX_SOCKETS },
 	{ "credential-store", cmd_credential_store },
 	{ "describe", cmd_describe, RUN_SETUP },
 	{ "diff", cmd_diff, NO_PARSEOPT },
diff --git a/t/t0012-help.sh b/t/t0012-help.sh
index 5679e29c624..2d05dde4b90 100755
--- a/t/t0012-help.sh
+++ b/t/t0012-help.sh
@@ -85,4 +85,14 @@ do
 	'
 done <builtins
 
+test_expect_success UNIX_SOCKETS 'builtin list includes NEED_UNIX_SOCKETS under UNIX_SOCKETS' '
+	grep ^credential-cache$ builtins &&
+	grep ^credential-cache--daemon$ builtins
+'
+
+test_expect_success !UNIX_SOCKETS 'builtin list excludes NEED_UNIX_SOCKETS under !UNIX_SOCKETS' '
+	! grep ^credential-cache$ builtins &&
+	! grep ^credential-cache--daemon$ builtins
+'
+
 test_done
-- 
2.33.0.876.g423ac861752

