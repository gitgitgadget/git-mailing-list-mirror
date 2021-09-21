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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16228C433EF
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 22:40:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0034661050
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 22:40:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233709AbhIUWmW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Sep 2021 18:42:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232822AbhIUWmV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Sep 2021 18:42:21 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0828EC061574
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 15:40:52 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id u18so1165125wrg.5
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 15:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eoSX23drEnzuRAiJhdPQszJul2wy20ZcVWXES9+yahw=;
        b=GAvTLeCcC9oUxLUFB0uAoPUy0shY7p31kR1sMiyulaYsia0QhvpDVeqm47gNm/ZEJd
         IWsTYhUvrnv8B6Psy81UrLC9QQVVMF2jlEznAjSTgfwMZa76RWqkX3mlza/Zp6Z3N7HU
         vpdia2HSGW6z6nobREp7+rQgkXNITof+xdtuOMdmVVw1KPBcE2I5NFyduWLOU77jdIsf
         PFHT+gnG4O5A3ZtGziOs6rGgYdaGRb9vQiHA21275H6UtNhFMNw+xJ1haPfJ0HNTX2Cc
         FvcEq6AGrHqyDQD6KNCn9jIPxBCYtI0PgKigJnFIYkC2tDYUh2jz1yCZ5MmQ5c2PrJCE
         cgeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eoSX23drEnzuRAiJhdPQszJul2wy20ZcVWXES9+yahw=;
        b=cIx3P2oBZ3FcmicQ67abqZXogBKce/ButSI3HkpcBsxJB/x/drWA3e5eidMNvpZokc
         oloJ0usonFtkhqgXFPT2ncm493DPIy3zEBUQ2L8N2922c+zobmC+UsNOI+YiNp8itzPC
         zi0v1zHItE/IQMWIsTVLxHHlIMCl3avK3sRB3rP7xuWdSCeZqwC4TJBPWv9B6nfCKEfC
         CU7rLfvnVT71iaN89ebfRmSEZiVsPiAfcFOwLXcDgc66SBaK0EOml4IqaogSKNEC/U6P
         0OZGnpjHPg8H2gIczjnawyP8mH7/4XL2vtuSYyEqUU+Itnev2IxYml/4MaKAmM75B4TF
         VmxQ==
X-Gm-Message-State: AOAM532GBw4283ehyO8JwqMTnu3qUEBXliiLEORfZdPaCYk8Ut4Lcg/5
        b/6Lq08KoXg38lZ3kRsYxahg0yGl9Bn3BQ==
X-Google-Smtp-Source: ABdhPJyQiMBDGGo3CY7k3SjxM6fqcqljzT4sb1rtU/wKLGNmJaWBZvxJAf44kIg4cLEndS5qCgXYVg==
X-Received: by 2002:a1c:1b48:: with SMTP id b69mr7112783wmb.14.1632264050263;
        Tue, 21 Sep 2021 15:40:50 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l7sm3846121wmp.48.2021.09.21.15.40.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 15:40:49 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.email>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 6/9] help: simplify by moving to OPT_CMDMODE()
Date:   Wed, 22 Sep 2021 00:40:36 +0200
Message-Id: <patch-v3-6.9-b52269eeab9-20210921T223223Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1098.gf02a64c1a2d
In-Reply-To: <cover-v3-0.9-00000000000-20210921T223223Z-avarab@gmail.com>
References: <cover-v2-0.5-00000000000-20210910T112545Z-avarab@gmail.com> <cover-v3-0.9-00000000000-20210921T223223Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As preceding commits have incrementally established all of the --all,
--guides, --config and hidden --config-for-completion options are
mutually exclusive. So let's use OPT_CMDMODE() to parse the
command-line instead, and take advantage of its conflicting options
detection.

This is the first command with a hidden CMDMODE, so let's introduce a
OPT_CMDMODE_F() macro to go along with OPT_CMDMODE().

I think this makes the usage information that we emit slightly worse,
e.g. before we'd emit:

    $ git help --all --config
    fatal: --config and --all cannot be combined

    usage: git help [-a|--all] [--[no-]verbose]]
             [[-i|--info] [-m|--man] [-w|--web]] [<command>]
       or: git help [-g|--guides]
       or: git help [-c|--config]
    [...]
    $

And now:

    $ git help --all --config
    error: option `config' is incompatible with --all
    $

But improving that is a general topic for parse-options.c improvement,
i.e. we should probably emit the full usage in that case.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/help.c  | 81 ++++++++++++++++++++++---------------------------
 parse-options.h |  6 ++--
 2 files changed, 40 insertions(+), 47 deletions(-)

diff --git a/builtin/help.c b/builtin/help.c
index 30f160a4669..6a022d9803e 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -34,27 +34,36 @@ enum help_format {
 	HELP_FORMAT_WEB
 };
 
-static const char *html_path;
+static enum help_action {
+	HELP_ACTION_ALL = 1,
+	HELP_ACTION_GUIDES,
+	HELP_ACTION_CONFIG,
+	HELP_ACTION_CONFIG_FOR_COMPLETION,
+} cmd_mode;
 
-static int show_all = 0;
-static int show_guides = 0;
-static int show_config;
+static const char *html_path;
 static int verbose = 1;
 static unsigned int colopts;
 static enum help_format help_format = HELP_FORMAT_NONE;
 static int exclude_guides;
 static struct option builtin_help_options[] = {
-	OPT_BOOL('a', "all", &show_all, N_("print all available commands")),
+	OPT_CMDMODE('a', "all", &cmd_mode, N_("print all available commands"),
+		    HELP_ACTION_ALL),
 	OPT_HIDDEN_BOOL(0, "exclude-guides", &exclude_guides, N_("exclude guides")),
-	OPT_BOOL('g', "guides", &show_guides, N_("print list of useful guides")),
-	OPT_BOOL('c', "config", &show_config, N_("print all configuration variable names")),
-	OPT_SET_INT_F(0, "config-for-completion", &show_config, "", 2, PARSE_OPT_HIDDEN),
 	OPT_SET_INT('m', "man", &help_format, N_("show man page"), HELP_FORMAT_MAN),
 	OPT_SET_INT('w', "web", &help_format, N_("show manual in web browser"),
 			HELP_FORMAT_WEB),
 	OPT_SET_INT('i', "info", &help_format, N_("show info page"),
 			HELP_FORMAT_INFO),
 	OPT__VERBOSE(&verbose, N_("print command description")),
+
+	OPT_CMDMODE('g', "guides", &cmd_mode, N_("print list of useful guides"),
+		    HELP_ACTION_GUIDES),
+	OPT_CMDMODE('c', "config", &cmd_mode, N_("print all configuration variable names"),
+		    HELP_ACTION_CONFIG),
+	OPT_CMDMODE_F(0, "config-for-completion", &cmd_mode, "",
+		    HELP_ACTION_CONFIG_FOR_COMPLETION, PARSE_OPT_HIDDEN),
+
 	OPT_END(),
 };
 
@@ -544,6 +553,13 @@ static const char *check_git_cmd(const char* cmd)
 	return cmd;
 }
 
+static void no_extra_argc(int argc)
+{
+	if (argc)
+		usage_msg_opt(_("this option doesn't take any other arguments"),
+			      builtin_help_usage, builtin_help_options);
+}
+
 int cmd_help(int argc, const char **argv, const char *prefix)
 {
 	int nongit;
@@ -554,28 +570,8 @@ int cmd_help(int argc, const char **argv, const char *prefix)
 			builtin_help_usage, 0);
 	parsed_help_format = help_format;
 
-	/* Incompatible options */
-	if (show_all && show_config)
-		usage_msg_opt(_("--config and --all cannot be combined"),
-			      builtin_help_usage, builtin_help_options);
-
-	if (show_all && show_guides)
-		usage_msg_opt(_("--config and --guides cannot be combined"),
-			      builtin_help_usage, builtin_help_options);
-
-	if (show_config && show_guides)
-		usage_msg_opt(_("--config and --guides cannot be combined"),
-			      builtin_help_usage, builtin_help_options);
-
-	/* Options that take no further arguments */
-	if (argc && show_config)
-		usage_msg_opt(_("--config cannot be combined with command or guide names"),
-			      builtin_help_usage, builtin_help_options);
-	if (argc && show_guides)
-		usage_msg_opt(_("--guides cannot be combined with command or guide names"),
-			      builtin_help_usage, builtin_help_options);
-
-	if (show_all) {
+	switch (cmd_mode) {
+	case HELP_ACTION_ALL:
 		git_config(git_help_config, NULL);
 		if (verbose) {
 			setup_pager();
@@ -585,25 +581,20 @@ int cmd_help(int argc, const char **argv, const char *prefix)
 		printf(_("usage: %s%s"), _(git_usage_string), "\n\n");
 		load_command_list("git-", &main_cmds, &other_cmds);
 		list_commands(colopts, &main_cmds, &other_cmds);
-	}
-
-	if (show_guides)
+		printf("%s\n", _(git_more_info_string));
+		break;
+	case HELP_ACTION_GUIDES:
+		no_extra_argc(argc);
 		list_guides_help();
-
-	if (show_all || show_guides) {
 		printf("%s\n", _(git_more_info_string));
 		return 0;
-	}
-
-	if (show_config) {
-		int for_human = show_config == 1;
-
-		if (!for_human) {
-			list_config_help(for_human);
-			return 0;
-		}
+	case HELP_ACTION_CONFIG_FOR_COMPLETION:
+		list_config_help(0);
+		return 0;
+	case HELP_ACTION_CONFIG:
+		no_extra_argc(argc);
 		setup_pager();
-		list_config_help(for_human);
+		list_config_help(1);
 		printf("\n%s\n", _("'git help config' for more information"));
 		return 0;
 	}
diff --git a/parse-options.h b/parse-options.h
index a845a9d9527..0e9271dde5c 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -169,8 +169,10 @@ struct option {
 #define OPT_BOOL(s, l, v, h)        OPT_BOOL_F(s, l, v, h, 0)
 #define OPT_HIDDEN_BOOL(s, l, v, h) { OPTION_SET_INT, (s), (l), (v), NULL, \
 				      (h), PARSE_OPT_NOARG | PARSE_OPT_HIDDEN, NULL, 1}
-#define OPT_CMDMODE(s, l, v, h, i)  { OPTION_SET_INT, (s), (l), (v), NULL, \
-				      (h), PARSE_OPT_CMDMODE|PARSE_OPT_NOARG|PARSE_OPT_NONEG, NULL, (i) }
+#define OPT_CMDMODE_F(s, l, v, h, i, f)  { OPTION_SET_INT, (s), (l), (v), NULL, \
+				      (h), PARSE_OPT_CMDMODE|PARSE_OPT_NOARG|PARSE_OPT_NONEG | (f), NULL, (i) }
+#define OPT_CMDMODE(s, l, v, h, i)  OPT_CMDMODE_F(s, l, v, h, i, 0)
+
 #define OPT_INTEGER(s, l, v, h)     OPT_INTEGER_F(s, l, v, h, 0)
 #define OPT_MAGNITUDE(s, l, v, h)   { OPTION_MAGNITUDE, (s), (l), (v), \
 				      N_("n"), (h), PARSE_OPT_NONEG }
-- 
2.33.0.1098.gf02a64c1a2d

