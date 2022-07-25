Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1E70C433EF
	for <git@archiver.kernel.org>; Mon, 25 Jul 2022 12:39:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234808AbiGYMjr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Jul 2022 08:39:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235161AbiGYMjc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jul 2022 08:39:32 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E592B1AF39
        for <git@vger.kernel.org>; Mon, 25 Jul 2022 05:39:23 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id fy29so20237939ejc.12
        for <git@vger.kernel.org>; Mon, 25 Jul 2022 05:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VGAsu4UM1Fdn/rp0Sm4Lg2bqpZwlLhfxj7uJjelmba0=;
        b=jKEv5+aDrk/lqh865CupEQzT+oaOrSFOl4Rr8QmSPwRibCjLf4oE+TND92OecP7VeO
         6KQ7Zjccru13q5yaQtyVeiFYBvVgzqRI85XsDPVreQZMzqZTS4zh/PXCGMWcogT7w+rK
         +eS6tClPBGM/dF+PZsYlv6LP875KcifdndNmWbTNx8ZENvneEon7hIvmwRcj8wrH5T3s
         CzqW6T94zNcrEwKWY7B6pO7gylDcYsvabolho+TAejklbHAYEBcLLP7sM3iRIf22yhAP
         iHdItpyzUcEktYus6HaW2eW7+cpr4kqa5m+XqyPvC2ooy7YXbcv3xtyzOqD2BlK4luRc
         R+iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VGAsu4UM1Fdn/rp0Sm4Lg2bqpZwlLhfxj7uJjelmba0=;
        b=LLt5LfM2v4qDHS7aifyDx/hUdb9dWauyplcJsl4y8vQRlP9UwD3RxDaySz6rfP8mhI
         HXkX8spbqvQszWyN7BNU2nm8lLzJMPala164gWdChEN7lsfM2kJZXgfv8kDIaM5MpjnO
         zW6E4iYiwvQPmf3+TxxekaNNAUOvSZFHtHMNNKeDYbzF3CKt/0SH0IHdeFSwZ9qDFcQ5
         CiYTJowdBXizr2kPbdbepx64tPPljO5SntogxiE8UObEy1GHbpZlL2REp0opgcglDqqQ
         rCz+8W3DynKsTWJS0ztPv1g6xkIcGJDYeb3AF3ikndJNmERYmj01ENVnxvoQCUR01GzA
         yjwQ==
X-Gm-Message-State: AJIora/c2/dZaeU5vC9FzMLdYIlP4mF9+Sr/cYca1nw4KQFzV7XMTvlO
        cNKkC6cFe4I5srwa43LFqtgcRokWQC0=
X-Google-Smtp-Source: AGRyM1svnnOfuoq+Z2h5x329f08o8U0hGzBk77vDlADdrENN8KkqUx8oUX34i/sQWvLCgEnNmKHAvQ==
X-Received: by 2002:a17:907:2d08:b0:72f:1dff:edf5 with SMTP id gs8-20020a1709072d0800b0072f1dffedf5mr10056667ejc.391.1658752762076;
        Mon, 25 Jul 2022 05:39:22 -0700 (PDT)
Received: from localhost (94-21-23-94.pool.digikabel.hu. [94.21.23.94])
        by smtp.gmail.com with ESMTPSA id w4-20020a50fa84000000b0043586bee560sm7020723edr.68.2022.07.25.05.39.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 05:39:21 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 12/20] builtin/gc.c: let parse-options parse 'git maintenance's subcommands
Date:   Mon, 25 Jul 2022 14:38:49 +0200
Message-Id: <20220725123857.2773963-13-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.37.1.633.g6a0fa73e39
In-Reply-To: <20220725123857.2773963-1-szeder.dev@gmail.com>
References: <20220725123857.2773963-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

'git maintenanze' parses its subcommands with a couple of if
statements.  parse-options has just learned to parse subcommands, so
let's use that facility instead, with the benefits of shorter code,
handling missing or unknown subcommands, and listing subcommands for
Bash completion.

This change makes 'git maintenance' consistent with other commands in
that the help text shown for '-h' goes to standard output, not error,
in the exit code and error message on unknown subcommand, and the
error message on missing subcommand.  There is a test checking these,
which is now updated accordingly.

Note that some of the functions implementing each subcommand don't
accept any parameters, so add the (unused) 'argc', '**argv' and
'*prefix' parameters to make them match the type expected by
parse-options, and thus avoid casting function pointers.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 builtin/gc.c           | 42 +++++++++++++++++++++---------------------
 git.c                  |  2 +-
 t/t7900-maintenance.sh | 10 ++++++----
 3 files changed, 28 insertions(+), 26 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index eeff2b760e..19d6b3b558 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1465,7 +1465,7 @@ static char *get_maintpath(void)
 	return strbuf_detach(&sb, NULL);
 }
 
-static int maintenance_register(void)
+static int maintenance_register(int argc, const char **argv, const char *prefix)
 {
 	int rc;
 	char *config_value;
@@ -1509,7 +1509,7 @@ static int maintenance_register(void)
 	return rc;
 }
 
-static int maintenance_unregister(void)
+static int maintenance_unregister(int argc, const char **argv, const char *prefix)
 {
 	int rc;
 	struct child_process config_unset = CHILD_PROCESS_INIT;
@@ -2505,34 +2505,34 @@ static int maintenance_start(int argc, const char **argv, const char *prefix)
 	opts.scheduler = resolve_scheduler(opts.scheduler);
 	validate_scheduler(opts.scheduler);
 
-	if (maintenance_register())
+	if (maintenance_register(0, NULL, NULL)) /* It doesn't take any args */
 		warning(_("failed to add repo to global config"));
 	return update_background_schedule(&opts, 1);
 }
 
-static int maintenance_stop(void)
+static int maintenance_stop(int argc, const char **argv, const char *prefix)
 {
 	return update_background_schedule(NULL, 0);
 }
 
-static const char builtin_maintenance_usage[] =	N_("git maintenance <subcommand> [<options>]");
+static const char * const builtin_maintenance_usage[] = {
+	N_("git maintenance <subcommand> [<options>]"),
+	NULL,
+};
 
 int cmd_maintenance(int argc, const char **argv, const char *prefix)
 {
-	if (argc < 2 ||
-	    (argc == 2 && !strcmp(argv[1], "-h")))
-		usage(builtin_maintenance_usage);
-
-	if (!strcmp(argv[1], "run"))
-		return maintenance_run(argc - 1, argv + 1, prefix);
-	if (!strcmp(argv[1], "start"))
-		return maintenance_start(argc - 1, argv + 1, prefix);
-	if (!strcmp(argv[1], "stop"))
-		return maintenance_stop();
-	if (!strcmp(argv[1], "register"))
-		return maintenance_register();
-	if (!strcmp(argv[1], "unregister"))
-		return maintenance_unregister();
-
-	die(_("invalid subcommand: %s"), argv[1]);
+	parse_opt_subcommand_fn *fn = NULL;
+	struct option builtin_maintenance_options[] = {
+		OPT_SUBCOMMAND("run", &fn, maintenance_run),
+		OPT_SUBCOMMAND("start", &fn, maintenance_start),
+		OPT_SUBCOMMAND("stop", &fn, maintenance_stop),
+		OPT_SUBCOMMAND("register", &fn, maintenance_register),
+		OPT_SUBCOMMAND("unregister", &fn, maintenance_unregister),
+		OPT_END(),
+	};
+
+	argc = parse_options(argc, argv, prefix, builtin_maintenance_options,
+			     builtin_maintenance_usage, 0);
+	return fn(argc, argv, prefix);
 }
diff --git a/git.c b/git.c
index c4282f194a..f52a955410 100644
--- a/git.c
+++ b/git.c
@@ -555,7 +555,7 @@ static struct cmd_struct commands[] = {
 	{ "ls-tree", cmd_ls_tree, RUN_SETUP },
 	{ "mailinfo", cmd_mailinfo, RUN_SETUP_GENTLY },
 	{ "mailsplit", cmd_mailsplit, NO_PARSEOPT },
-	{ "maintenance", cmd_maintenance, RUN_SETUP | NO_PARSEOPT },
+	{ "maintenance", cmd_maintenance, RUN_SETUP },
 	{ "merge", cmd_merge, RUN_SETUP | NEED_WORK_TREE },
 	{ "merge-base", cmd_merge_base, RUN_SETUP },
 	{ "merge-file", cmd_merge_file, RUN_SETUP_GENTLY },
diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index 74aa638475..1030a36c8d 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -32,11 +32,13 @@ test_systemd_analyze_verify () {
 }
 
 test_expect_success 'help text' '
-	test_expect_code 129 git maintenance -h 2>err &&
-	test_i18ngrep "usage: git maintenance <subcommand>" err &&
-	test_expect_code 128 git maintenance barf 2>err &&
-	test_i18ngrep "invalid subcommand: barf" err &&
+	test_expect_code 129 git maintenance -h >actual &&
+	test_i18ngrep "usage: git maintenance <subcommand>" actual &&
+	test_expect_code 129 git maintenance barf 2>err &&
+	test_i18ngrep "unknown subcommand: barf" err &&
+	test_i18ngrep "usage: git maintenance" err &&
 	test_expect_code 129 git maintenance 2>err &&
+	test_i18ngrep "error: need a subcommand" err &&
 	test_i18ngrep "usage: git maintenance" err
 '
 
-- 
2.37.1.633.g6a0fa73e39

