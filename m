Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62456C28B2B
	for <git@archiver.kernel.org>; Fri, 19 Aug 2022 16:32:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353039AbiHSQcw (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Aug 2022 12:32:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353112AbiHSQai (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2022 12:30:38 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98E7D11C966
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 09:04:58 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id dc19so9596160ejb.12
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 09:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=GxWvP1ZuJRcQJIPObadti00y4k9dzjLA4u6Evan+7mQ=;
        b=IqQz6OHTUee8N4LEHO2xqdJPXsXqBGW2YLaf87Y86GMKO1Z0+tJRM69l3ghbNpw0lp
         byMVlipWqoLcmzfOTmwiu6wyZpn5vVDnLPy82j5tVBUXm9jE6/WgPTcaqwyGwObV3YB4
         hOIkkmtyBen185q2d2XuiJotoVTyIDYrwrk8gmSVwEpS2unAd4IO3c1KsHGvevZlyY2D
         WYJyl4LaYzDiP5dB6olNlt3DT1842CVwq+pqQSxAJcjYrZNsz3ewsyTWrjVq1qRHK1c8
         khZvHGJjUQaWnYl6ldk1CAZn3F2Y9+qoCXvZnuZtqmKC0F3Y0ayRoOYh0O9bsHjxq+ak
         vP0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=GxWvP1ZuJRcQJIPObadti00y4k9dzjLA4u6Evan+7mQ=;
        b=GNQKvx4g0EaI3G1H5uC5tnu679TTIlaqea/e56sFlk/9Tid+vErDA8T2A56Z8l3aq6
         UGOvzx+bA7zM/cn56gl81TtEMQnP5OZ7jUXQwsGEk9KzTrOhr9NFFzfGz3J7vM/gsUHc
         4dlfNQpFa1KoEhcb7QjoFjFiF87rV7v9Zx8IidnSPY3SDcCzIjB5p6BYBPMIYSNf2auy
         0+5KUUWpJALCQivS+Rd60tex1MXiA7oYyqF5J66pG77bRy4TXtgST5f9/BJ+S2Sv4Rah
         de00EIH67nAu/fnIEyxPrr3ErK8IXIhw+aRbb+VlCPGOQ0XIeTFdyfn2zyBH25HiP6IR
         op9Q==
X-Gm-Message-State: ACgBeo1w9609LUcG+HbktDQjGepcQQVA4UGsELefIJJJU4zrsqhzw15c
        v0CF4LLJxdtJ4BLUmoXAn6iC8qBaFyk=
X-Google-Smtp-Source: AA6agR5+uP28x7ncee5p01WzRR2DPj67Vgt1RxagYjhNVV3ITF4ws8l+SLEzOhnzP8QzUG2gX3QAYQ==
X-Received: by 2002:a17:907:3fa8:b0:730:a2d0:3a56 with SMTP id hr40-20020a1709073fa800b00730a2d03a56mr5353943ejc.460.1660925094577;
        Fri, 19 Aug 2022 09:04:54 -0700 (PDT)
Received: from localhost (84-236-78-250.pool.digikabel.hu. [84.236.78.250])
        by smtp.gmail.com with ESMTPSA id j2-20020a17090623e200b0073d58d73ce1sm518663ejg.156.2022.08.19.09.04.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 09:04:54 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 12/20] builtin/gc.c: let parse-options parse 'git maintenance's subcommands
Date:   Fri, 19 Aug 2022 18:04:03 +0200
Message-Id: <20220819160411.1791200-13-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.37.2.817.g36f84ce71d
In-Reply-To: <20220819160411.1791200-1-szeder.dev@gmail.com>
References: <20220725123857.2773963-1-szeder.dev@gmail.com>
 <20220819160411.1791200-1-szeder.dev@gmail.com>
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
index 09c126c33d..73ddf0f452 100644
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
index 74aa638475..852498ff06 100755
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
+	test_i18ngrep "unknown subcommand: \`barf'\''" err &&
+	test_i18ngrep "usage: git maintenance" err &&
 	test_expect_code 129 git maintenance 2>err &&
+	test_i18ngrep "error: need a subcommand" err &&
 	test_i18ngrep "usage: git maintenance" err
 '
 
-- 
2.37.2.817.g36f84ce71d

