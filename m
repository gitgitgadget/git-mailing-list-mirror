Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 870A0C433F5
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 02:05:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DD82610D1
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 02:05:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234849AbhJOCHq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Oct 2021 22:07:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232271AbhJOCHp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Oct 2021 22:07:45 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD318C061570
        for <git@vger.kernel.org>; Thu, 14 Oct 2021 19:05:39 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id r7so23681671wrc.10
        for <git@vger.kernel.org>; Thu, 14 Oct 2021 19:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KG9h6Ws1uHM6yB+oS83qYE80pyNs5hFdidj/pGF5MjY=;
        b=PNeyJgZczAkTCTRV7wmCasv9JAmZdJMLIZLVQ6ZuXs0KivAgW4lHpUKd0RI3zn3pY7
         uA+OnHYweO9WyRURN61l5iP68TIWI3jxpNgmK2+wVNvreoOKR8a0bhQmpRCkbXk576CI
         uD34NYYKekPYnXtflyEgz4F13Yg0bL+YaC1Aual+S3T2pY+ZREh2rGkTZ6AOAmfwKgf7
         nemLK5md79qVBDkHTzmOghezgnouwuiJ6WjLRw9WneWtVmktwtEVlBIfJ6RX9qmTa7lW
         Nhh7zRubpDDi83eNEDURs4m319KZkkhiVzwsl7YY6C1ZFqaELZg7Za/B8rYJ4O8oVc1P
         GcYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KG9h6Ws1uHM6yB+oS83qYE80pyNs5hFdidj/pGF5MjY=;
        b=qgwa6SVrMZ4MWlXmebBiFQDCZI+gejclUZwZrjbCa6cmxGuTzxeMFoyplWKrT3liay
         id0hGgJAUlV1wGCRhONrVQFCp6f5SPqN2IPM87tdR5gXNLt7ZdHwB//dChruJifNUWOd
         w82sFYr+kDViPB8Lf6G5mzizxgyC4/4xeYUpDb0msM1fMzq8Q1zJ71HhaZel+YdtJph3
         v0MToK7g4NcZmrD+Qhv49UevXXY8Sa/5N6qiCSQT+s/0xV5WE/kOKYJQrx5QeJ/EdinR
         mPDDQnXXlsEa4uWbS8EYiVuB7kpOMDmUzHmYkkZzmllaiqkqNzl+Nn5QYR6Z/KZ3LDlB
         X0qw==
X-Gm-Message-State: AOAM532WzymiWLu3ga/oQEq+cLhl6noQYFN88YaHVi8lcmc64v5N8u5h
        m3+Da98nCd9sg8MP79khH9yWAng4feotlw==
X-Google-Smtp-Source: ABdhPJzy/WsX+DCMoEYMsMCwAY4l26kuHLEEUyzZTwZQzXC7CBAoimqhr+u6JKgNf4RamU8L8ouewA==
X-Received: by 2002:adf:d1ea:: with SMTP id g10mr10834056wrd.205.1634263538030;
        Thu, 14 Oct 2021 19:05:38 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id p18sm3742990wrn.41.2021.10.14.19.05.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 19:05:37 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Todd Zullinger <tmz@pobox.com>, Eric Wong <e@80x24.org>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/2] git(1) docs: split "User-facing file formats" off from "Guides"
Date:   Fri, 15 Oct 2021 04:05:19 +0200
Message-Id: <patch-1.2-19a8be1fc73-20211015T020351Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1338.g20da966911a
In-Reply-To: <cover-0.2-00000000000-20211015T020351Z-avarab@gmail.com>
References: <cover-0.2-00000000000-20211015T020351Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Create a new "User-facing file formats" section in the main "git(1)"
manual page. The "Guides" section was added to the manual page in
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
 Documentation/git-help.txt | 11 ++++++++---
 Documentation/git.txt      |  7 +++++++
 Makefile                   |  1 +
 builtin/help.c             |  8 ++++++++
 command-list.txt           | 16 ++++++++++------
 help.c                     | 11 +++++++++++
 help.h                     |  1 +
 t/t0012-help.sh            | 16 +++++++++++++++-
 9 files changed, 62 insertions(+), 10 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 2021568cd5a..8efed2e23e1 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -311,6 +311,7 @@ cmds_txt = cmds-ancillaryinterrogators.txt \
 	cmds-synchingrepositories.txt \
 	cmds-synchelpers.txt \
 	cmds-guide.txt \
+	cmds-userformats.txt \
 	cmds-purehelpers.txt \
 	cmds-foreignscminterface.txt
 
diff --git a/Documentation/git-help.txt b/Documentation/git-help.txt
index 96d5f598b4b..d47feca0d29 100644
--- a/Documentation/git-help.txt
+++ b/Documentation/git-help.txt
@@ -12,11 +12,12 @@ SYNOPSIS
 	   [[-i|--info] [-m|--man] [-w|--web]] [COMMAND|GUIDE]
 'git help' [-g|--guides]
 'git help' [-c|--config]
+'git help' [--user-formats]
 
 DESCRIPTION
 -----------
 
-With no options and no COMMAND or GUIDE given, the synopsis of the 'git'
+With no options and no COMMAND or DOC given, the synopsis of the 'git'
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
 
@@ -62,6 +63,10 @@ OPTIONS
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
index d63c65e67d8..823977595c5 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -337,6 +337,13 @@ The following documentation pages are guides about Git concepts.
 
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
index 060a8c46475..3956ed4b291 100644
--- a/Makefile
+++ b/Makefile
@@ -3312,6 +3312,7 @@ check-docs::
 		sed -e '1,/^### command list/d' \
 		    -e '/^#/d' \
 		    -e '/guide$$/d' \
+		    -e '/formats$$/d' \
 		    -e 's/[ 	].*//' \
 		    -e 's/^/listed /' command-list.txt; \
 		$(MAKE) -C Documentation print-man1 | \
diff --git a/builtin/help.c b/builtin/help.c
index 75cd2fb407f..5e842ea5a26 100644
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
@@ -64,6 +65,8 @@ static struct option builtin_help_options[] = {
 
 	OPT_CMDMODE('g', "guides", &cmd_mode, N_("print list of useful guides"),
 		    HELP_ACTION_GUIDES),
+	OPT_CMDMODE(0, "user-formats", &cmd_mode, N_("print list of user-facing file formats"),
+		    HELP_ACTION_USER_FORMATS),
 	OPT_CMDMODE('c', "config", &cmd_mode, N_("print all configuration variable names"),
 		    HELP_ACTION_CONFIG),
 	OPT_CMDMODE_F(0, "config-for-completion", &cmd_mode, "",
@@ -79,6 +82,7 @@ static const char * const builtin_help_usage[] = {
 	   "         [[-i|--info] [-m|--man] [-w|--web]] [<command>]"),
 	N_("git help [-g|--guides]"),
 	N_("git help [-c|--config]"),
+	N_("git help [--user-formats]"),
 	NULL
 };
 
@@ -613,6 +617,10 @@ int cmd_help(int argc, const char **argv, const char *prefix)
 		no_extra_argc(argc);
 		list_config_help(SHOW_CONFIG_VARS);
 		return 0;
+	case HELP_ACTION_USER_FORMATS:
+		no_extra_argc(argc);
+		list_user_formats_help();
+		return 0;
 	case HELP_ACTION_CONFIG_SECTIONS_FOR_COMPLETION:
 		no_extra_argc(argc);
 		list_config_help(SHOW_CONFIG_SECTIONS);
diff --git a/command-list.txt b/command-list.txt
index a289f09ed6f..5732ea437a8 100644
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
 ### command list (do not change this line, also do not change alignment)
 # command name                          category [category] [category]
 git-add                                 mainporcelain           worktree
@@ -193,7 +197,7 @@ gitweb                                  ancillaryinterrogators
 git-whatchanged                         ancillaryinterrogators          complete
 git-worktree                            mainporcelain
 git-write-tree                          plumbingmanipulators
-gitattributes                           guide
+gitattributes                           userformats
 gitcli                                  guide
 gitcore-tutorial                        guide
 gitcredentials                          guide
@@ -202,13 +206,13 @@ gitdiffcore                             guide
 giteveryday                             guide
 gitfaq                                  guide
 gitglossary                             guide
-githooks                                guide
-gitignore                               guide
-gitmailmap                              guide
-gitmodules                              guide
+githooks                                userformats
+gitignore                               userformats
+gitmailmap                              userformats
+gitmodules                              userformats
 gitnamespaces                           guide
 gitremote-helpers                       guide
-gitrepository-layout                    guide
+gitrepository-layout                    userformats
 gitrevisions                            guide
 gitsubmodules                           guide
 gittutorial-2                           guide
diff --git a/help.c b/help.c
index 973e47cdc30..a7b5c909056 100644
--- a/help.c
+++ b/help.c
@@ -37,6 +37,7 @@ static struct category_description main_categories[] = {
 	{ CAT_plumbinginterrogators, N_("Low-level Commands / Interrogators") },
 	{ CAT_synchingrepositories, N_("Low-level Commands / Syncing Repositories") },
 	{ CAT_purehelpers, N_("Low-level Commands / Internal Helpers") },
+	{ CAT_userformats, N_("User-facing file formats") },
 	{ 0, NULL }
 };
 
@@ -422,6 +423,16 @@ void list_guides_help(void)
 	putchar('\n');
 }
 
+void list_user_formats_help(void)
+{
+	struct category_description catdesc[] = {
+		{ CAT_userformats, N_("The user-facing file formats are:") },
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
index 9d383f1a0b2..d01908078dc 100644
--- a/help.h
+++ b/help.h
@@ -22,6 +22,7 @@ static inline void mput_char(char c, unsigned int num)
 void list_common_cmds_help(void);
 void list_all_cmds_help(void);
 void list_guides_help(void);
+void list_user_formats_help(void);
 
 void list_all_main_cmds(struct string_list *list);
 void list_all_other_cmds(struct string_list *list);
diff --git a/t/t0012-help.sh b/t/t0012-help.sh
index 91b68c74a15..6a20a7303f8 100755
--- a/t/t0012-help.sh
+++ b/t/t0012-help.sh
@@ -41,6 +41,8 @@ test_expect_success 'invalid usage' '
 	test_expect_code 129 git help -g add &&
 	test_expect_code 129 git help -a -g &&
 
+	test_expect_code 129 git help --user-formats add &&
+
 	test_expect_code 129 git help -g -c &&
 	test_expect_code 129 git help --config-for-completion add &&
 	test_expect_code 129 git help --config-sections-for-completion add
@@ -78,9 +80,15 @@ test_expect_success 'git help' '
 	test_i18ngrep "^   commit " help.output &&
 	test_i18ngrep "^   fetch  " help.output
 '
+
+test_expect_success 'git help -a' '
+	git help -a >help.output &&
+	grep "^Main Porcelain Commands" help.output &&
+	grep "^User-facing file formats" help.output
+'
+
 test_expect_success 'git help -g' '
 	git help -g >help.output &&
-	test_i18ngrep "^   attributes " help.output &&
 	test_i18ngrep "^   everyday   " help.output &&
 	test_i18ngrep "^   tutorial   " help.output
 '
@@ -101,6 +109,12 @@ test_expect_success 'git help succeeds without git.html' '
 	test_cmp expect test-browser.log
 '
 
+test_expect_success 'git help --formats' '
+	git help --user-formats >help.output &&
+	grep "^   gitattributes   " help.output &&
+	grep "^   gitmailmap   " help.output
+'
+
 test_expect_success 'git help -c' '
 	git help -c >help.output &&
 	cat >expect <<-\EOF &&
-- 
2.33.1.1338.g20da966911a

