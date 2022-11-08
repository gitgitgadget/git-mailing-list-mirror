Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD26AC433FE
	for <git@archiver.kernel.org>; Tue,  8 Nov 2022 14:11:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235156AbiKHOLb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Nov 2022 09:11:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235268AbiKHOLN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2022 09:11:13 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92E957723A
        for <git@vger.kernel.org>; Tue,  8 Nov 2022 06:10:58 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id b2so38917846eja.6
        for <git@vger.kernel.org>; Tue, 08 Nov 2022 06:10:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Op6C/A0YQd2jGTxGoKts8lCYdbNQzGwBkzaSO7yuYaU=;
        b=hRN6rU21ViIJtZ07JJK7r8Hk8gq4c2UODxCk9yObpeuq745phnsj4eFeNcPSA/18Oi
         fb6QsjVEUSPlZEk8lx519BtDz08xYOEpsQDi37Hl2UB8An2pmhnWSHUcc1xYpGScuyvB
         8I5jRlTCa0tjjSmZSH6UF1jPOBnt/xUXywI+FmhpUAnLhOeKfyhCFGe9+qRoqvvqsm/6
         jfw1UdNZiNaI5UX4jRg3ZvETSOxESBlK1ILpDLZ6W0T1ScOwYv2asslBRWxu+g6bDvOu
         BFvXxfl7eJjO3SZozddn2TnMZUZSFAreGoIOSjlYC93CJtxTcso7V0LExkTEe1BQAzz9
         6Qjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Op6C/A0YQd2jGTxGoKts8lCYdbNQzGwBkzaSO7yuYaU=;
        b=Hz3c/9SKvv20k+m175anIIzGVoT4LKs7mNjjVWGCPn3GanOgIKWIN8PHNGFSCDIQ8C
         mNfqMNxq6BYMKjzw88JLd7wmGRH7jWYGmx2uEH1vEnCNalgXcq3jUGDrUJkt/PUfIJlC
         V8nb8Q7YIYB9BNGw5eK4uquPZbjBhxZ7UjaGdxebBc8r/muJnE8fJM3XMOZmPTA159h8
         WwriAwcPRTBpKfdoOHfCuUVFeQH16kPUs/jv3ROxIl5Mpbf0logbBhCR+FBKSFrD3Olx
         MPniumIvlPABP9R2WGGe4ZX978y1JckdGM4ghnhR9PdIKHe60vhsQxuXbxywNYklgMwU
         oIEA==
X-Gm-Message-State: ACrzQf2mpwLUgqZ3Mptf6b/HjA2GSr3gF782k+l+yHdrmt2aO1988tmV
        xW/kreM4iavTgTSAjeyuQwXG7adXIiEpZA==
X-Google-Smtp-Source: AMsMyM78OV7wYzLY8P0aXMCpHNei3trh7+fNmZmbRFIWwyRxdSoqFtmx9QxgPvNQdPgt86p89NzwDg==
X-Received: by 2002:a17:906:dc8f:b0:7a5:8160:1995 with SMTP id cs15-20020a170906dc8f00b007a581601995mr53217287ejc.500.1667916657511;
        Tue, 08 Nov 2022 06:10:57 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id a16-20020a170906369000b0078d9c2c8250sm4683666ejc.84.2022.11.08.06.10.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 06:10:56 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 9/9] submodule--helper: use OPT_SUBCOMMAND() API
Date:   Tue,  8 Nov 2022 15:10:40 +0100
Message-Id: <patch-v2-9.9-cccd92a829c-20221108T140501Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1464.gea6794aacbc
In-Reply-To: <cover-v2-0.9-00000000000-20221108T140501Z-avarab@gmail.com>
References: <cover-0.8-00000000000-20221102T074148Z-avarab@gmail.com> <cover-v2-0.9-00000000000-20221108T140501Z-avarab@gmail.com>
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
index 03d1b58acaa..c75e9e86b06 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -3351,47 +3351,45 @@ static int module_add(int argc, const char **argv, const char *prefix)
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
2.38.0.1464.gea6794aacbc

