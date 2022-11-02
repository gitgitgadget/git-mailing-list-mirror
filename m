Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA378C4332F
	for <git@archiver.kernel.org>; Wed,  2 Nov 2022 07:54:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbiKBHyf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Nov 2022 03:54:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230244AbiKBHyZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Nov 2022 03:54:25 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ADAA25C77
        for <git@vger.kernel.org>; Wed,  2 Nov 2022 00:54:17 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id d26so43024557eje.10
        for <git@vger.kernel.org>; Wed, 02 Nov 2022 00:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/CFS+sDKN0h2xdgGzHNpNjhXPY5fKNn5b/msmWClGWQ=;
        b=DXfgSa++FLGmRc4pS6p3jxeL8acf6wsga31O3QMVsSY/sxFPE8IikU6I7P5xKxjrwN
         cqLH/naNJrgTJACKjorAicfJ9SIDv8fdwfMLlhVTcD+4XijLKryAYen0ZibP4aqGvoFw
         FE34P0+2QvXPAizknXKm01tTNNT7pIhNgv+QgROetqF6kWie9hx1xuIU0ntpDXVkpcsO
         j/JoWfZIVq/Xa377feKy6BTi3kUMqiKt1uB4lITXk00TzMOEYpX5Ka8Re9zyejirD1SB
         lSQNIY7czdJwd5up5oFiJ/8dn2JTswA+u2XydsnOXLeSITiIp+LFyyd99D0Rn2zUtesh
         s4Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/CFS+sDKN0h2xdgGzHNpNjhXPY5fKNn5b/msmWClGWQ=;
        b=wXF4vlykYxMwUDEbktY6Q6dkITT6yZgPTIURbaX/Jc8pYbHrRIUvpqs1FiBIXx9ZXs
         4p+69XAPQjvWR/+ay2WDFiscvNZhzuU47UvaheZdnXbtb/doQjpjIFPwkoqqRpv2INYa
         JaExeGATupF0XSGm4eCAa3oNdegvTh8i567MV+L+UF93GeJ/Toj1C2XARxh6GxtViBmn
         QJWJQIm+KLMpTLTjhdTzfuqJ0Kkd/lTS/QEXL/wmsaICO/xqkNZMvOwkLcox6TBZC2Oy
         ZcpA0UgfZgjjYH6GnZOsKRG28C1obUet4RmqXIHEe+o9DNpSFTBgBVGNb1sSOObDldxU
         bD4A==
X-Gm-Message-State: ACrzQf35P9ErItrZBs0hvIJBc6KFd/pL7Jl/xrHrTh7dP0SG6DbVhcTX
        Rn7cYSQmqUfopFnGkIbc+Z1KNkdbkkMWnQ==
X-Google-Smtp-Source: AMsMyM5ytGkZQ3DD6nNABB22jE7N02jZLTn9rpxW2lFw655eyBrdXj//FhmvJNYmoWIiooY6AuCStA==
X-Received: by 2002:a17:906:4783:b0:780:5be5:c81b with SMTP id cw3-20020a170906478300b007805be5c81bmr22295005ejc.76.1667375655255;
        Wed, 02 Nov 2022 00:54:15 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id ku11-20020a170907788b00b0073d84a321c8sm5045466ejc.166.2022.11.02.00.54.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 00:54:14 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 8/8] submodule--helper: use OPT_SUBCOMMAND() API
Date:   Wed,  2 Nov 2022 08:54:05 +0100
Message-Id: <patch-8.8-105853cd358-20221102T074148Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1280.g8136eb6fab2
In-Reply-To: <cover-0.8-00000000000-20221102T074148Z-avarab@gmail.com>
References: <cover-0.8-00000000000-20221102T074148Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Have the cmd_submodule__helper() use the OPT_SUBCOMMAND() API
introduced in fa83cc834da (parse-options: add support for parsing
subcommands, 2022-08-19).

This is only a marginal reduction in line count, but once we start
unifying this with a yet-to-be-added "builtin/submodule.c" it'll be
much easier to reason about those changes, as they'll both use
OPT_SUBCOMMAND().

We don't need to worry about "argv[0]" being NULL in the die() because
we'd have errored out in parse_options() as we're not using
"PARSE_OPT_SUBCOMMAND_OPTIONAL".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c | 78 ++++++++++++++++++-------------------
 git.c                       |  2 +-
 2 files changed, 39 insertions(+), 41 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 2012ad31d7f..0bc25dcf5ae 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -3350,47 +3350,45 @@ static int module_add(int argc, const char **argv, const char *prefix)
 	return ret;
 }
 
-#define SUPPORT_SUPER_PREFIX (1<<0)
-
-struct cmd_struct {
-	const char *cmd;
-	int (*fn)(int, const char **, const char *);
-	unsigned option;
-};
-
-static struct cmd_struct commands[] = {
-	{"clone", module_clone, SUPPORT_SUPER_PREFIX},
-	{"add", module_add, 0},
-	{"update", module_update, SUPPORT_SUPER_PREFIX},
-	{"foreach", module_foreach, SUPPORT_SUPER_PREFIX},
-	{"init", module_init, 0},
-	{"status", module_status, SUPPORT_SUPER_PREFIX},
-	{"sync", module_sync, SUPPORT_SUPER_PREFIX},
-	{"deinit", module_deinit, 0},
-	{"summary", module_summary, 0},
-	{"push-check", push_check, 0},
-	{"absorbgitdirs", absorb_git_dirs, SUPPORT_SUPER_PREFIX},
-	{"set-url", module_set_url, 0},
-	{"set-branch", module_set_branch, 0},
-	{"create-branch", module_create_branch, 0},
-};
-
 int cmd_submodule__helper(int argc, const char **argv, const char *prefix)
 {
-	int i;
-	if (argc < 2 || !strcmp(argv[1], "-h"))
-		usage("git submodule--helper <command>");
-
-	for (i = 0; i < ARRAY_SIZE(commands); i++) {
-		if (!strcmp(argv[1], commands[i].cmd)) {
-			if (get_super_prefix() &&
-			    !(commands[i].option & SUPPORT_SUPER_PREFIX))
-				die(_("%s doesn't support --super-prefix"),
-				    commands[i].cmd);
-			return commands[i].fn(argc - 1, argv + 1, prefix);
-		}
-	}
+	const char *cmd = argv[0];
+	const char *subcmd;
+	parse_opt_subcommand_fn *fn = NULL;
+	const char *const usage[] = {
+		N_("git submodule--helper <command>"),
+		NULL
+	};
+	struct option options[] = {
+		OPT_SUBCOMMAND("clone", &fn, module_clone),
+		OPT_SUBCOMMAND("add", &fn, module_add),
+		OPT_SUBCOMMAND("update", &fn, module_update),
+		OPT_SUBCOMMAND("foreach", &fn, module_foreach),
+		OPT_SUBCOMMAND("init", &fn, module_init),
+		OPT_SUBCOMMAND("status", &fn, module_status),
+		OPT_SUBCOMMAND("sync", &fn, module_sync),
+		OPT_SUBCOMMAND("deinit", &fn, module_deinit),
+		OPT_SUBCOMMAND("summary", &fn, module_summary),
+		OPT_SUBCOMMAND("push-check", &fn, push_check),
+		OPT_SUBCOMMAND("absorbgitdirs", &fn, absorb_git_dirs),
+		OPT_SUBCOMMAND("set-url", &fn, module_set_url),
+		OPT_SUBCOMMAND("set-branch", &fn, module_set_branch),
+		OPT_SUBCOMMAND("create-branch", &fn, module_create_branch),
+		OPT_END()
+	};
+	argc = parse_options(argc, argv, prefix, options, usage, 0);
+	subcmd = argv[0];
+
+	if (strcmp(subcmd, "clone") && strcmp(subcmd, "update") &&
+	    strcmp(subcmd, "foreach") && strcmp(subcmd, "status") &&
+	    strcmp(subcmd, "sync") && strcmp(subcmd, "absorbgitdirs") &&
+	    get_super_prefix())
+		/*
+		 * xstrfmt() rather than "%s %s" to keep the translated
+		 * string identical to git.c's.
+		 */
+		die(_("%s doesn't support --super-prefix"),
+		    xstrfmt("'%s %s'", cmd, subcmd));
 
-	die(_("'%s' is not a valid submodule--helper "
-	      "subcommand"), argv[1]);
+	return fn(argc, argv, prefix);
 }
diff --git a/git.c b/git.c
index ee7758dcb0e..fb69e605912 100644
--- a/git.c
+++ b/git.c
@@ -610,7 +610,7 @@ static struct cmd_struct commands[] = {
 	{ "stash", cmd_stash, RUN_SETUP | NEED_WORK_TREE },
 	{ "status", cmd_status, RUN_SETUP | NEED_WORK_TREE },
 	{ "stripspace", cmd_stripspace },
-	{ "submodule--helper", cmd_submodule__helper, RUN_SETUP | SUPPORT_SUPER_PREFIX | NO_PARSEOPT },
+	{ "submodule--helper", cmd_submodule__helper, RUN_SETUP | SUPPORT_SUPER_PREFIX },
 	{ "switch", cmd_switch, RUN_SETUP | NEED_WORK_TREE },
 	{ "symbolic-ref", cmd_symbolic_ref, RUN_SETUP },
 	{ "tag", cmd_tag, RUN_SETUP | DELAY_PAGER_CONFIG },
-- 
2.38.0.1280.g8136eb6fab2

