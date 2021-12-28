Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CFCFC433EF
	for <git@archiver.kernel.org>; Tue, 28 Dec 2021 15:36:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235210AbhL1Pg3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Dec 2021 10:36:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235174AbhL1PgZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Dec 2021 10:36:25 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 635EBC061574
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 07:36:25 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id a9so38997325wrr.8
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 07:36:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rbq/RT86ae6gVVY1nk1rZMDRPYmnZ3I8VvQ3RCx5Ghk=;
        b=N66Ib80o9yNlru3wdQptMLokm2I9tDxLMkhc5TODEstpVAcJ8WswehS8sYcbt+W/4R
         6e737uUGbBeKkuwP1vmaYGkvPioisaoN9ONEBqsgBx6B/sP0FqZ9+gNCOIK6xQ4u7hXH
         +sasVRRDc5qvTO0K5x9xhp8FCtUbhGHuKuHMwM4HNeqBwqJkNltvSLiXgc6Md0gDB52u
         VZajzR9c0EA6Wz9giKfONcd8sBecsJarxljLNHC9xDxvuNU5Bwluk2j7aBYu+1GXct+Y
         BFTsUl1dQII+J6kBZz6KRXbdcJpHNceKBtPBO2h6udNhp5jGPdO3A4PSW2Y7hwXj3H3f
         Qj+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rbq/RT86ae6gVVY1nk1rZMDRPYmnZ3I8VvQ3RCx5Ghk=;
        b=1lka0MGHI7h5o1LdnzOXhzSvUdcOhg272vB2wwqxDKVRkAuMIANHsemU8v20IP/4MI
         sdilZBq191+xo2gAwcx1yoN+QdHpgBzZBv6DWY5ybJcDBdn6rXfSIrltWVQNiJwieLV1
         a4ZizpwL1fhbMk9UQqCCcb1bMqZtGBWHN83ah2vOiAnRMi87BjRublsBTlmfAgs/tzG1
         9hz6B4XbqtfsXTqUxaiQv6JLIlf+mHVMKiiByEi0qRMYKN+r8gU2SbeSk8aTVLJ4T3G7
         7MZ92zpEzr6cosIFA5MR8+Qc0NhZKhWj51dLl1VeCydcF2riMc0xaeOzn1egzxyrq5zG
         d0og==
X-Gm-Message-State: AOAM531DN3pa9QttQEkUy7yV0KwiDYaTSCiVONMfPk9n+wfTki9Z1CtT
        eoxWCJ7nSoyYE/qOOInWLvqsKlLa3PIMYqKW
X-Google-Smtp-Source: ABdhPJzhXRfCwm+StCNt3Nk8ypgKqWCPRD2Lnz98IjVlAzlzS6sZfQqeUElJcW1dmch7298lRrYNFw==
X-Received: by 2002:adf:d1cb:: with SMTP id b11mr16920827wrd.386.1640705783768;
        Tue, 28 Dec 2021 07:36:23 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id p23sm18403137wms.3.2021.12.28.07.36.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Dec 2021 07:36:23 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 6/7] help: add --no-[external-commands|aliases] for use with --all
Date:   Tue, 28 Dec 2021 16:35:11 +0100
Message-Id: <patch-6.7-a5ef9f69530-20211228T153456Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.1257.g2af47340c7b
In-Reply-To: <cover-0.7-00000000000-20211228T153456Z-avarab@gmail.com>
References: <cover-0.7-00000000000-20211228T153456Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add the ability to only emit git's own usage information under
--all. This also allows us to extend the "test_section_spacing" tests
added in a preceding commit to test "git help --all"
output.

Previously we could not do that, as the tests might find a git-*
command in the "$PATH", which would make the output differ from one
setup to another.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-help.txt | 10 +++++++++-
 builtin/help.c             | 16 ++++++++++++++--
 help.c                     |  8 +++++---
 help.h                     |  2 +-
 t/t0012-help.sh            | 37 +++++++++++++++++++++++++++++++++++++
 5 files changed, 66 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-help.txt b/Documentation/git-help.txt
index 61d52d30f6c..9307445c333 100644
--- a/Documentation/git-help.txt
+++ b/Documentation/git-help.txt
@@ -8,7 +8,7 @@ git-help - Display help information about Git
 SYNOPSIS
 --------
 [verse]
-'git help' [-a|--all] [--[no-]verbose]
+'git help' [-a|--all] [--[no-]verbose] [--[no-](external-commands|aliases)]
 'git help' [[-i|--info] [-m|--man] [-w|--web]] [<command>|<guide>]
 'git help' [-g|--guides]
 'git help' [-c|--config]
@@ -49,6 +49,14 @@ OPTIONS
 	Prints all the available commands on the standard output. This
 	option overrides any given command or guide name.
 
+--no-external-commands::
+	When used with `--all`, exclude the listing of external "git-*"
+	commands found in the `$PATH`.
+
+--no-aliases::
+	When used with `--all`, exclude the listing of configured
+	aliases.
+
 --verbose::
 	When used with `--all` print description for all recognized
 	commands. This is the default.
diff --git a/builtin/help.c b/builtin/help.c
index 125f50f1bb0..1131b437389 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -51,9 +51,14 @@ static const char *html_path;
 static int verbose = 1;
 static enum help_format help_format = HELP_FORMAT_NONE;
 static int exclude_guides;
+static int show_external_commands = -1;
+static int show_aliases = -1;
 static struct option builtin_help_options[] = {
 	OPT_CMDMODE('a', "all", &cmd_mode, N_("print all available commands"),
 		    HELP_ACTION_ALL),
+	OPT_BOOL(0, "external-commands", &show_external_commands,
+		 N_("show external commands in --all?")),
+	OPT_BOOL(0, "aliases", &show_aliases, N_("show aliases in --all?")),
 	OPT_HIDDEN_BOOL(0, "exclude-guides", &exclude_guides, N_("exclude guides")),
 	OPT_SET_INT('m', "man", &help_format, N_("show man page"), HELP_FORMAT_MAN),
 	OPT_SET_INT('w', "web", &help_format, N_("show manual in web browser"),
@@ -75,7 +80,7 @@ static struct option builtin_help_options[] = {
 };
 
 static const char * const builtin_help_usage[] = {
-	N_("git help [-a|--all] [--[no-]verbose]]"),
+	N_("git help [-a|--all] [--[no-]verbose]] [--[no-](external-commands|aliases)]"),
 	N_("git help [[-i|--info] [-m|--man] [-w|--web]] [<command>]"),
 	N_("git help [-g|--guides]"),
 	N_("git help [-c|--config]"),
@@ -598,12 +603,19 @@ int cmd_help(int argc, const char **argv, const char *prefix)
 			builtin_help_usage, 0);
 	parsed_help_format = help_format;
 
+	if (cmd_mode != HELP_ACTION_ALL &&
+	    (show_external_commands >= 0 ||
+	     show_aliases >= 0))
+		usage_msg_opt(_("the '--no-[external-commands|aliases]' options can only be used with '--all'"),
+			      builtin_help_usage, builtin_help_options);
+
 	switch (cmd_mode) {
 	case HELP_ACTION_ALL:
 		no_format();
 		if (verbose) {
 			setup_pager();
-			list_all_cmds_help();
+			list_all_cmds_help(show_external_commands,
+					   show_aliases);
 			return 0;
 		}
 		printf(_("usage: %s%s"), _(git_usage_string), "\n\n");
diff --git a/help.c b/help.c
index ef1aa26efa6..2296f06ad9f 100644
--- a/help.c
+++ b/help.c
@@ -476,15 +476,17 @@ static void list_all_cmds_help_aliases(int longest)
 	string_list_clear(&alias_list, 1);
 }
 
-void list_all_cmds_help(void)
+void list_all_cmds_help(int show_external_commands, int show_aliases)
 {
 	int longest;
 
 	puts(_("See 'git help <command>' to read about a specific subcommand"));
 	print_cmd_by_category(main_categories, &longest);
 
-	list_all_cmds_help_external_commands();
-	list_all_cmds_help_aliases(longest);
+	if (show_external_commands)
+		list_all_cmds_help_external_commands();
+	if (show_aliases)
+		list_all_cmds_help_aliases(longest);
 }
 
 int is_in_cmdlist(struct cmdnames *c, const char *s)
diff --git a/help.h b/help.h
index 9d383f1a0b2..971a3ad855a 100644
--- a/help.h
+++ b/help.h
@@ -20,7 +20,7 @@ static inline void mput_char(char c, unsigned int num)
 }
 
 void list_common_cmds_help(void);
-void list_all_cmds_help(void);
+void list_all_cmds_help(int show_external_commands, int show_aliases);
 void list_guides_help(void);
 
 void list_all_main_cmds(struct string_list *list);
diff --git a/t/t0012-help.sh b/t/t0012-help.sh
index a8c603abd44..c41b412e34a 100755
--- a/t/t0012-help.sh
+++ b/t/t0012-help.sh
@@ -54,6 +54,19 @@ do
 		test_expect_code 129 git help $opt -m &&
 		test_expect_code 129 git help $opt -w
 	'
+
+	if test "$opt" = "-a"
+	then
+		continue
+	fi
+
+	test_expect_success "invalid usage of '$opt' with --no-external-commands" '
+		test_expect_code 129 git help $opt --no-external-commands
+	'
+
+	test_expect_success "invalid usage of '$opt' with --no-aliases" '
+		test_expect_code 129 git help $opt --no-external-commands
+	'
 done
 
 test_expect_success "works for commands and guides by default" '
@@ -184,6 +197,30 @@ do
 	'
 done
 
+test_expect_success "'git help -a' section spacing" '
+	test_section_spacing \
+		git help -a --no-external-commands --no-aliases <<-\EOF &&
+	See '\''git help <command>'\'' to read about a specific subcommand
+
+	Main Porcelain Commands
+
+	Ancillary Commands / Manipulators
+
+	Ancillary Commands / Interrogators
+
+	Interacting with Others
+
+	Low-level Commands / Manipulators
+
+	Low-level Commands / Interrogators
+
+	Low-level Commands / Syncing Repositories
+
+	Low-level Commands / Internal Helpers
+	EOF
+	test_cmp expect actual
+'
+
 test_expect_success "'git help -g' section spacing" '
 	test_section_spacing_trailer git help -g <<-\EOF &&
 
-- 
2.34.1.1257.g2af47340c7b

