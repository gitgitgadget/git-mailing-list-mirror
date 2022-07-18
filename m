Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A2CAC43334
	for <git@archiver.kernel.org>; Mon, 18 Jul 2022 13:29:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233634AbiGRN3w (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Jul 2022 09:29:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233360AbiGRN3s (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jul 2022 09:29:48 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EA76C06
        for <git@vger.kernel.org>; Mon, 18 Jul 2022 06:29:44 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id b6so6606095wmq.5
        for <git@vger.kernel.org>; Mon, 18 Jul 2022 06:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mDMgFH3L/sNKi9IWgbx8mP1scbZWxEOoRW7DJ+GwyQ4=;
        b=Puv4UVe47wlj+CyRZYxyHl4PhcyqTQkiEq+TduMeXMXCFNNXnHDR79AHOvY8iBuxsP
         wW/Y+pYY1icVh6J9e+Zuf5b8N7Ht7PVqTbzeuC2QQFmYGlpxjh59f7d/4ixOOSULk52D
         4Y2EQsk7BUSFTshF5PqETv1/bmSNkeEsRG4mJC7PrXA4SnvFT8ZSshC5hdwKygIsrydi
         bsTM8quJz4vFQ+6dK3XlemMXvAcJr6kzPvHR4hS1N1Vxpdu2tJuGpqRuBUrWNs/Rzk/j
         M5jLmVq/6GwGAC/FLtOojqzmJR6Og2S5qY03egKQdlu3i91QgcUEc1yO7qEO5R/hsiRB
         T2mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mDMgFH3L/sNKi9IWgbx8mP1scbZWxEOoRW7DJ+GwyQ4=;
        b=bd6C+QP5HIRZan4x7H7k3P6P37ABQ+4cbTvCSzpAf9I1qTy5KeigO4I/6YerGqg10I
         tbvOwLmrBBwZjCM/XTa1EnAnIzUuL9A90m+jAv1Asf9qZMSVN9IgxhjAUaFNyUvVjSg9
         v02ZIdQ501esBRFeSyxnst2Ft6YGMeXyTwq19dOzFI1OtZkt6d5DD/m6M7Gah0NRQ6L5
         lgIOaIpVXd9CGKfkV7I82Hi/N/6lYPrIQXWa4ryFMWnEozkSfDaZX4ogxTb+l5dBC3xr
         6h0nlV95dwOGO7yaRNKWbJLUuzvfdtkOxqOj/X8umHXsVhHxkk2MeNtZW3M7MlMiQ/uc
         avmw==
X-Gm-Message-State: AJIora+oNNNiN1SpvhKL0tiKMfNTxP8zZNtAiGrSQnj785BHTdtrMzGs
        48c9Nyiy9VeQLDG63U7REfIoHbcme84RGA==
X-Google-Smtp-Source: AGRyM1tk1BEwkV7S0VHGBH4510fxU01Xj2dk135Mxa8V7qu0yoduJDIO/C793CrTWIuDMrC+S/AshA==
X-Received: by 2002:a1c:4c0f:0:b0:3a3:1401:7660 with SMTP id z15-20020a1c4c0f000000b003a314017660mr9871354wmf.8.1658150982038;
        Mon, 18 Jul 2022 06:29:42 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id p4-20020a1c5444000000b003a30572072esm14277296wmi.6.2022.07.18.06.29.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 06:29:41 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        Teng Long <dyroneteng@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 2/8] git docs: split "User-facing file formats" off from "Guides"
Date:   Mon, 18 Jul 2022 15:29:28 +0200
Message-Id: <patch-v4-2.8-883c483d4e7-20220718T132911Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1032.gb00b5447790
In-Reply-To: <cover-v4-0.8-00000000000-20220718T132911Z-avarab@gmail.com>
References: <cover-v3-0.7-00000000000-20220712T195419Z-avarab@gmail.com> <cover-v4-0.8-00000000000-20220718T132911Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Create a new "User-facing file formats" section in the main "git help
git" manual page. The "Guides" section was added to the manual page in
f442f28a81b (git.txt: add list of guides, 2020-08-05), it makes sense
to list all that documentation.

But placing e.g. "gitignore(5)" in it is stretching the meaning of
what a "guide" is, ideally that section should list things similar to
"giteveryday(7)" and "gitcore-tutorial(7)".

We take a wide view of what's considered a "user format", it's not
just a file format, but e.g. githooks(5) also belongs, since the
layout of the ".git/hooks/" and the placement of hooks in it is
something the user might be expected to interact with.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/Makefile     |  1 +
 Documentation/git-help.txt | 13 +++++++++----
 Documentation/git.txt      |  7 +++++++
 Makefile                   |  1 +
 builtin/help.c             | 10 +++++++++-
 command-list.txt           | 16 ++++++++++------
 help.c                     | 12 ++++++++++++
 help.h                     |  1 +
 t/t0012-help.sh            | 12 +++++++++++-
 9 files changed, 61 insertions(+), 12 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 4f801f4e4c9..08b896a3c4c 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -290,6 +290,7 @@ cmds_txt = cmds-ancillaryinterrogators.txt \
 	cmds-synchingrepositories.txt \
 	cmds-synchelpers.txt \
 	cmds-guide.txt \
+	cmds-userformats.txt \
 	cmds-purehelpers.txt \
 	cmds-foreignscminterface.txt
 
diff --git a/Documentation/git-help.txt b/Documentation/git-help.txt
index 239c68db457..6c285709040 100644
--- a/Documentation/git-help.txt
+++ b/Documentation/git-help.txt
@@ -9,14 +9,15 @@ SYNOPSIS
 --------
 [verse]
 'git help' [-a|--all] [--[no-]verbose] [--[no-]external-commands] [--[no-]aliases]
-'git help' [[-i|--info] [-m|--man] [-w|--web]] [<command>|<guide>]
+'git help' [[-i|--info] [-m|--man] [-w|--web]] [<command>|<guide>|<doc>]
 'git help' [-g|--guides]
 'git help' [-c|--config]
+'git help' [--user-formats]
 
 DESCRIPTION
 -----------
 
-With no options and no '<command>' or '<guide>' given, the synopsis of the 'git'
+With no options and no '<command>', '<guide>' or '<doc>' given, the synopsis of the 'git'
 command and a list of the most commonly used Git commands are printed
 on the standard output.
 
@@ -26,8 +27,8 @@ printed on the standard output.
 If the option `--guides` or `-g` is given, a list of the
 Git concept guides is also printed on the standard output.
 
-If a command, or a guide, is given, a manual page for that command or
-guide is brought up. The 'man' program is used by default for this
+If a command or other documentation is given, the relevant manual page
+will be brought up. The 'man' program is used by default for this
 purpose, but this can be overridden by other options or configuration
 variables.
 
@@ -69,6 +70,10 @@ OPTIONS
 --guides::
 	Prints a list of the Git concept guides on the standard output.
 
+--user-formats::
+	Prints a list of the Git user-facing format documentation on
+	the standard output.
+
 -i::
 --info::
 	Display manual page for the command in the 'info' format. The
diff --git a/Documentation/git.txt b/Documentation/git.txt
index 302607a4967..9b03bbc3851 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -339,6 +339,13 @@ The following documentation pages are guides about Git concepts.
 
 include::cmds-guide.txt[]
 
+User-facing file formats
+------------------------
+
+This documentation discusses file formats that users are expected to
+edit. These can also be listed with 'git help --user-formats'.
+
+include::cmds-userformats.txt[]
 
 Configuration Mechanism
 -----------------------
diff --git a/Makefile b/Makefile
index 04d0fd1fe60..e24db1d52e2 100644
--- a/Makefile
+++ b/Makefile
@@ -3489,6 +3489,7 @@ check-docs::
 		sed -e '1,/^### command list/d' \
 		    -e '/^#/d' \
 		    -e '/guide$$/d' \
+		    -e '/formats$$/d' \
 		    -e 's/[ 	].*//' \
 		    -e 's/^/listed /' command-list.txt; \
 		$(MAKE) -C Documentation print-man1 | \
diff --git a/builtin/help.c b/builtin/help.c
index 222f994f863..b0164b774c2 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -43,6 +43,7 @@ static enum help_action {
 	HELP_ACTION_ALL = 1,
 	HELP_ACTION_GUIDES,
 	HELP_ACTION_CONFIG,
+	HELP_ACTION_USER_FORMATS,
 	HELP_ACTION_CONFIG_FOR_COMPLETION,
 	HELP_ACTION_CONFIG_SECTIONS_FOR_COMPLETION,
 } cmd_mode;
@@ -69,6 +70,8 @@ static struct option builtin_help_options[] = {
 
 	OPT_CMDMODE('g', "guides", &cmd_mode, N_("print list of useful guides"),
 		    HELP_ACTION_GUIDES),
+	OPT_CMDMODE(0, "user-formats", &cmd_mode, N_("print list of user-facing file formats"),
+		    HELP_ACTION_USER_FORMATS),
 	OPT_CMDMODE('c', "config", &cmd_mode, N_("print all configuration variable names"),
 		    HELP_ACTION_CONFIG),
 	OPT_CMDMODE_F(0, "config-for-completion", &cmd_mode, "",
@@ -81,9 +84,10 @@ static struct option builtin_help_options[] = {
 
 static const char * const builtin_help_usage[] = {
 	"git help [-a|--all] [--[no-]verbose]] [--[no-]external-commands] [--[no-]aliases]",
-	N_("git help [[-i|--info] [-m|--man] [-w|--web]] [<command>]"),
+	N_("git help [[-i|--info] [-m|--man] [-w|--web]] [<command>|<doc>]"),
 	"git help [-g|--guides]",
 	"git help [-c|--config]",
+	"git help [--user-formats]",
 	NULL
 };
 
@@ -654,6 +658,10 @@ int cmd_help(int argc, const char **argv, const char *prefix)
 		opt_mode_usage(argc, "--config-for-completion", help_format);
 		list_config_help(SHOW_CONFIG_VARS);
 		return 0;
+	case HELP_ACTION_USER_FORMATS:
+		opt_mode_usage(argc, "--user-formats", help_format);
+		list_user_formats_help();
+		return 0;
 	case HELP_ACTION_CONFIG_SECTIONS_FOR_COMPLETION:
 		opt_mode_usage(argc, "--config-sections-for-completion",
 			       help_format);
diff --git a/command-list.txt b/command-list.txt
index 9bd6f3c48f4..c1eace8f7ad 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -43,6 +43,10 @@
 # specified here, which can only have "guide" attribute and nothing
 # else.
 #
+# User-facing file formats such as documentation for the .gitmodules,
+# .mailmap etc. files lives in man section 5. These entries can only
+# have the "userformats" attribute and nothing else.
+#
 ### command list (do not change this line)
 # command name                          category [category] [category]
 git-add                                 mainporcelain           worktree
@@ -192,7 +196,7 @@ git-verify-tag                          ancillaryinterrogators
 git-whatchanged                         ancillaryinterrogators          complete
 git-worktree                            mainporcelain
 git-write-tree                          plumbingmanipulators
-gitattributes                           guide
+gitattributes                           userformats
 gitcli                                  guide
 gitcore-tutorial                        guide
 gitcredentials                          guide
@@ -201,14 +205,14 @@ gitdiffcore                             guide
 giteveryday                             guide
 gitfaq                                  guide
 gitglossary                             guide
-githooks                                guide
-gitignore                               guide
+githooks                                userformats
+gitignore                               userformats
 gitk                                    mainporcelain
-gitmailmap                              guide
-gitmodules                              guide
+gitmailmap                              userformats
+gitmodules                              userformats
 gitnamespaces                           guide
 gitremote-helpers                       guide
-gitrepository-layout                    guide
+gitrepository-layout                    userformats
 gitrevisions                            guide
 gitsubmodules                           guide
 gittutorial                             guide
diff --git a/help.c b/help.c
index 24ac50f62fe..17ba210cf4e 100644
--- a/help.c
+++ b/help.c
@@ -38,6 +38,7 @@ static struct category_description main_categories[] = {
 	{ CAT_plumbinginterrogators, N_("Low-level Commands / Interrogators") },
 	{ CAT_synchingrepositories, N_("Low-level Commands / Syncing Repositories") },
 	{ CAT_purehelpers, N_("Low-level Commands / Internal Helpers") },
+	{ CAT_userformats, N_("Git user-facing file formats") },
 	{ 0, NULL }
 };
 
@@ -50,6 +51,7 @@ static const char *drop_prefix(const char *name, uint32_t category)
 	switch (category)
 	{
 	case CAT_guide:
+	case CAT_userformats:
 		if (!skip_prefix(name, "git", &new_name))
 			BUG("category #%d but no 'git' prefix?", category);
 		return new_name;
@@ -430,6 +432,16 @@ void list_guides_help(void)
 	putchar('\n');
 }
 
+void list_user_formats_help(void)
+{
+	struct category_description catdesc[] = {
+		{ CAT_userformats, N_("Git user-facing file formats:") },
+		{ 0, NULL }
+	};
+	print_cmd_by_category(catdesc, NULL);
+	putchar('\n');
+}
+
 static int get_alias(const char *var, const char *value, void *data)
 {
 	struct string_list *list = data;
diff --git a/help.h b/help.h
index 971a3ad855a..d8b744178ec 100644
--- a/help.h
+++ b/help.h
@@ -22,6 +22,7 @@ static inline void mput_char(char c, unsigned int num)
 void list_common_cmds_help(void);
 void list_all_cmds_help(int show_external_commands, int show_aliases);
 void list_guides_help(void);
+void list_user_formats_help(void);
 
 void list_all_main_cmds(struct string_list *list);
 void list_all_other_cmds(struct string_list *list);
diff --git a/t/t0012-help.sh b/t/t0012-help.sh
index 6c33a436901..91b5318aa32 100755
--- a/t/t0012-help.sh
+++ b/t/t0012-help.sh
@@ -44,6 +44,8 @@ test_expect_success 'invalid usage' '
 	test_expect_code 129 git help -g add &&
 	test_expect_code 129 git help -a -g &&
 
+	test_expect_code 129 git help --user-formats add &&
+
 	test_expect_code 129 git help -g -c &&
 	test_expect_code 129 git help --config-for-completion add &&
 	test_expect_code 129 git help --config-sections-for-completion add
@@ -104,9 +106,9 @@ test_expect_success 'git help' '
 	test_i18ngrep "^   commit " help.output &&
 	test_i18ngrep "^   fetch  " help.output
 '
+
 test_expect_success 'git help -g' '
 	git help -g >help.output &&
-	test_i18ngrep "^   attributes " help.output &&
 	test_i18ngrep "^   everyday   " help.output &&
 	test_i18ngrep "^   tutorial   " help.output
 '
@@ -127,6 +129,12 @@ test_expect_success 'git help succeeds without git.html' '
 	test_cmp expect test-browser.log
 '
 
+test_expect_success 'git help --user-formats' '
+	git help --user-formats >help.output &&
+	grep "^   attributes   " help.output &&
+	grep "^   mailmap   " help.output
+'
+
 test_expect_success 'git help -c' '
 	git help -c >help.output &&
 	cat >expect <<-\EOF &&
@@ -220,6 +228,8 @@ test_expect_success "'git help -a' section spacing" '
 	Low-level Commands / Syncing Repositories
 
 	Low-level Commands / Internal Helpers
+
+	Git user-facing file formats
 	EOF
 	test_cmp expect actual
 '
-- 
2.37.1.1032.gb00b5447790

