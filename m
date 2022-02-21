Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8A85C433EF
	for <git@archiver.kernel.org>; Mon, 21 Feb 2022 19:39:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233209AbiBUTkB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Feb 2022 14:40:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233151AbiBUTjp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Feb 2022 14:39:45 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C918223BD9
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 11:39:06 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id lw4so35812725ejb.12
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 11:39:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Dphhk2joWEC+XKurYVQifg6QTG0s/YyRZeu9K6lycs0=;
        b=KSRCxiA9ypo25QWJHpffQG0GZMzy9DY7L/Smtz21AMQ8XZ7HpNsc6ifIEynDMQ/Ygj
         5tgBxMPGjSkiVNxDELZtayRIRqJSC+xZoCaE5cto20OmHPIJYAD0zd4D7sdJ8Q83aIJF
         CrDidGhq7b58kOBiEwMENN6cJjAZPPmro+C/W5WMU3ffRTqHethDTpF4a8Kr+pwIpOzr
         +/aGQO1FWaDTQkkrQmNuj157nVpQ2iW2XRra41errtzc/GlJy/RAKV/4uPkpgyhfyTqs
         vjPgeOj3GwSs8qQsI45NbAeSLYFv7oK6kGg4TEQAYR3/iqrQUdqODb4j5Tu6p90yufMu
         sp9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Dphhk2joWEC+XKurYVQifg6QTG0s/YyRZeu9K6lycs0=;
        b=5SvbOWDEHtBcHJu61R7kFf6vDzOuDmd9AbweRCyhpj6ktqzn4LqvIOJMPa6Adwl11t
         wB0vtH9uNhH6odxq1gfRaPf6JUYHbd6M8AL3mOUMAF1VLsyVtLT8Z3M1i7oyQENjvBO/
         3En3TgIB0OBlKxMYQlJS/KAdd5hwx8z+fzUHZOeBzveotIn7uAx6i2nQMSejDrydaEIh
         uPAaKBmk6US+84RfCegg+rxiw6FfRb/jOYFFEV/uPbq9npK5LkFNKfKyEroOpiZBMWzC
         i+DuVhEHFxxj1oJmLWW9TwS9GakSW8zbiezLjDUpe4cQ1eqNvrTuBqBb2X/WpK0A4DUj
         9RiQ==
X-Gm-Message-State: AOAM533vtktbo1U4EeKuEFhhZaEn2EfK0yZ33MI9cm3tYRqJf7QOWfG0
        fD8UizZTEZ7IWWjaMmOjN6bb49uwQ+7Ayw==
X-Google-Smtp-Source: ABdhPJyXh58+LqQUdkLjDeea4xcI9Vsmv/504S11y6woy4aZCPIZuTRrYLM67a+aIWB4w+ynf4XUSw==
X-Received: by 2002:a17:906:b57:b0:6ce:29b3:404c with SMTP id v23-20020a1709060b5700b006ce29b3404cmr16855475ejg.140.1645472345081;
        Mon, 21 Feb 2022 11:39:05 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c25sm8718199edu.103.2022.02.21.11.39.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 11:39:04 -0800 (PST)
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
Subject: [PATCH v2 8/9] help: add --no-[external-commands|aliases] for use with --all
Date:   Mon, 21 Feb 2022 20:38:51 +0100
Message-Id: <patch-v2-8.9-c81c0cbbcdb-20220221T193708Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1132.ga1fe46f8690
In-Reply-To: <cover-v2-0.9-00000000000-20220221T193708Z-avarab@gmail.com>
References: <cover-0.7-00000000000-20211228T153456Z-avarab@gmail.com> <cover-v2-0.9-00000000000-20220221T193708Z-avarab@gmail.com>
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
index d07590c8ff7..239c68db457 100644
--- a/Documentation/git-help.txt
+++ b/Documentation/git-help.txt
@@ -8,7 +8,7 @@ git-help - Display help information about Git
 SYNOPSIS
 --------
 [verse]
-'git help' [-a|--all] [--[no-]verbose]
+'git help' [-a|--all] [--[no-]verbose] [--[no-]external-commands] [--[no-]aliases]
 'git help' [[-i|--info] [-m|--man] [-w|--web]] [<command>|<guide>]
 'git help' [-g|--guides]
 'git help' [-c|--config]
@@ -48,6 +48,14 @@ OPTIONS
 --all::
 	Prints all the available commands on the standard output.
 
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
index 1fc45adfcc7..01eda326c31 100644
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
+		 N_("show external commands in --all")),
+	OPT_BOOL(0, "aliases", &show_aliases, N_("show aliases in --all")),
 	OPT_HIDDEN_BOOL(0, "exclude-guides", &exclude_guides, N_("exclude guides")),
 	OPT_SET_INT('m', "man", &help_format, N_("show man page"), HELP_FORMAT_MAN),
 	OPT_SET_INT('w', "web", &help_format, N_("show manual in web browser"),
@@ -75,7 +80,7 @@ static struct option builtin_help_options[] = {
 };
 
 static const char * const builtin_help_usage[] = {
-	N_("git help [-a|--all] [--[no-]verbose]]"),
+	N_("git help [-a|--all] [--[no-]verbose]] [--[no-]external-commands] [--[no-]aliases]"),
 	N_("git help [[-i|--info] [-m|--man] [-w|--web]] [<command>]"),
 	N_("git help [-g|--guides]"),
 	N_("git help [-c|--config]"),
@@ -620,12 +625,19 @@ int cmd_help(int argc, const char **argv, const char *prefix)
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
 		opt_mode_usage(argc, "--all", help_format);
 		if (verbose) {
 			setup_pager();
-			list_all_cmds_help();
+			list_all_cmds_help(show_external_commands,
+					   show_aliases);
 			return 0;
 		}
 		printf(_("usage: %s%s"), _(git_usage_string), "\n\n");
diff --git a/help.c b/help.c
index 004117347ee..45a21e7e35c 100644
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
index f12783fd153..64321480c68 100755
--- a/t/t0012-help.sh
+++ b/t/t0012-help.sh
@@ -57,6 +57,19 @@ do
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
@@ -187,6 +200,30 @@ do
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
2.35.1.1132.ga1fe46f8690

