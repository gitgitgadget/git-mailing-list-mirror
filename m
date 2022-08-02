Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AED05C00140
	for <git@archiver.kernel.org>; Tue,  2 Aug 2022 12:58:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237072AbiHBM60 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Aug 2022 08:58:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236922AbiHBM6G (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Aug 2022 08:58:06 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80B4713F7E
        for <git@vger.kernel.org>; Tue,  2 Aug 2022 05:58:04 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id v131-20020a1cac89000000b003a4bb3f786bso3093906wme.0
        for <git@vger.kernel.org>; Tue, 02 Aug 2022 05:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=pn4Kkw/YXRvm5telW43jXewUlFnRC0QP86Q/TkA6zhY=;
        b=FqvBkBfL+LXkDyn9yHaSfR/OkFvFvXpF6ye8c5LlwZKFTdYxAkC1FqJlfLdPSwLux3
         JPDpL/bHKeAACid2sqTQbqo8T3VdShFS6Rq52iwHHGSPiR0U60ubvoF3HhYjKBclJgGP
         G/qN2yd2+8mOMxFesTb0ancBcI1tPBpTP9FhQ91VlJtMxwc7UsLPXiDK55C7MIiS5F3t
         xZwL4o4lScfs19d6z91Lsl/I5CbAmCb45/lHJ2hgd9lVgKNOjqD7GqzEu/u6LDWgUbol
         MIVI1ZZ3lK+T7zMsBbQjJ+HZb/EZS+eq1FYj7SI7Mn7RJO1OnS48o2dkqKqea6+9uLTj
         KUrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=pn4Kkw/YXRvm5telW43jXewUlFnRC0QP86Q/TkA6zhY=;
        b=jNpgw0Po+eNjgwVF9FdPB1cch/M+u5f+2imCpI5mZvoH7gluLfWizKVYGfqpE1deTh
         K1D7PLVqM26Mt6OnhBPM0MWnEmIOMSsY1ksQbPvUhZE4eoq0CoVosZ43FrZyM31gSWut
         k01xwB9XWD5LtFf8Cw/N4ZEJy9NGBFCH2hNf37ehgls4mZ43x99FmZLMO+42TOjdMOXV
         UjhbrQNL4OQD6bdJu5g4EtqoK7bIH3mnbCgbUD7e+PA4rxFA8B+ze0l9ZXzmszNDbHfP
         rivZX/ThWGrV9TKHzpZN8KoXmkLch6Jvf6mCtI4On6cgpGCxnOOkRqIjJDvS+0aBZ5/l
         /NwA==
X-Gm-Message-State: AJIora/wqvFxB1NGTc2mcnrNHcxCv9TS/h8rwctqk9T4xfNTkCcF/pl1
        kk7mD3SQJcSh9jgH+JdB0x4x1/Xf/lzc5w==
X-Google-Smtp-Source: AGRyM1stIV/Tg5ZkcHtLA4wrK56o5C2fDlDtEvBA8d/x4MRpppTuGdjfhT0H9nYb0buATehBqJq7Kg==
X-Received: by 2002:a05:600c:1987:b0:3a3:2db1:d35b with SMTP id t7-20020a05600c198700b003a32db1d35bmr13271445wmq.14.1659445082711;
        Tue, 02 Aug 2022 05:58:02 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id t4-20020adfeb84000000b0021e45afa7b0sm15056145wrn.109.2022.08.02.05.58.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 05:58:02 -0700 (PDT)
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
Subject: [PATCH v7 04/10] git docs: add a category for user-facing file, repo and command UX
Date:   Tue,  2 Aug 2022 14:56:53 +0200
Message-Id: <patch-v7-04.10-8e9384a92f2-20220802T125258Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1232.gc0cde427aa7
In-Reply-To: <cover-v7-00.10-00000000000-20220802T125258Z-avarab@gmail.com>
References: <cover-v6-0.9-00000000000-20220728T164243Z-avarab@gmail.com> <cover-v7-00.10-00000000000-20220802T125258Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Create a new "Repository, command and file interfaces" section in the
main "git help git" manual page. Move things that belong under this
new criteria from the generic "Guides" section.

The "Guides" section was added in f442f28a81b (git.txt: add list of
guides, 2020-08-05). It makes sense to have e.g. "giteveryday(7)" and
"gitfaq(7)" listed under "Guides".

But placing e.g. "gitignore(5)" in it is stretching the meaning of
what a "guide" is, ideally that section should list things similar to
"giteveryday(7)" and "gitcore-tutorial(7)".

An alternate name that was considered for this new section was "User
formats", for consistency with the nomenclature used for man section 5
in general. My man(1) lists it as "File formats and conventions,
e.g. /etc/passwd".

So calling this "git help --formats" or "git help --user-formats"
would make sense for e.g. gitignore(5), but would be stretching it
somewhat for githooks(5), and would seem really suspect for the likes
of gitcli(7).

Let's instead pick a name that's closer to the generic term "User
interface", which is really what this documentation discusses: General
user-interface documentation that doesn't obviously belong elsewhere.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/Makefile     |  1 +
 Documentation/git-help.txt | 14 ++++++++++++++
 Documentation/git.txt      |  8 ++++++++
 Makefile                   |  1 +
 builtin/help.c             |  9 +++++++++
 command-list.txt           | 21 +++++++++++++--------
 help.c                     | 12 ++++++++++++
 help.h                     |  1 +
 t/t0012-help.sh            | 12 +++++++++++-
 9 files changed, 70 insertions(+), 9 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 4f801f4e4c9..28eb940a9b8 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -290,6 +290,7 @@ cmds_txt = cmds-ancillaryinterrogators.txt \
 	cmds-synchingrepositories.txt \
 	cmds-synchelpers.txt \
 	cmds-guide.txt \
+	cmds-userinterfaces.txt \
 	cmds-purehelpers.txt \
 	cmds-foreignscminterface.txt
 
diff --git a/Documentation/git-help.txt b/Documentation/git-help.txt
index bead763fd29..4eb03bd6c38 100644
--- a/Documentation/git-help.txt
+++ b/Documentation/git-help.txt
@@ -12,6 +12,7 @@ SYNOPSIS
 'git help' [[-i|--info] [-m|--man] [-w|--web]] [<command>|<doc>]
 'git help' [-g|--guides]
 'git help' [-c|--config]
+'git help' [--user-interfaces]
 
 DESCRIPTION
 -----------
@@ -69,6 +70,19 @@ OPTIONS
 --guides::
 	Prints a list of the Git concept guides on the standard output.
 
+--user-interfaces::
+	Prints a list of the repository, command and file interfaces
+	documentation on the standard output.
++
+In-repository file interfaces such as `.git/info/exclude` are
+documented here (see linkgit:gitrepository-layout[5]), as well as
+in-tree configuration such as `.mailmap` (see linkgit:gitmailmap[5]).
++
+This section of the documentation also covers general or widespread
+user-interface conventions (e.g. linkgit:gitcli[7]), and
+pseudo-configuration such as the file-based `.git/hooks/*` interface
+described in linkgit:githooks[5].
+
 -i::
 --info::
 	Display manual page for the command in the 'info' format. The
diff --git a/Documentation/git.txt b/Documentation/git.txt
index 47a6095ff40..945a1ebd3b1 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -339,6 +339,14 @@ The following documentation pages are guides about Git concepts.
 
 include::cmds-guide.txt[]
 
+Repository, command and file interfaces
+---------------------------------------
+
+This documentation discusses repository and command interfaces which
+users are expected to interact with directly. See `--user-formats` in
+linkgit:git-help[1] for more details on the critera.
+
+include::cmds-userinterfaces.txt[]
 
 Configuration Mechanism
 -----------------------
diff --git a/Makefile b/Makefile
index 1624471badc..ea0ef7df734 100644
--- a/Makefile
+++ b/Makefile
@@ -3532,6 +3532,7 @@ check-docs::
 		sed -e '1,/^### command list/d' \
 		    -e '/^#/d' \
 		    -e '/guide$$/d' \
+		    -e '/interfaces$$/d' \
 		    -e 's/[ 	].*//' \
 		    -e 's/^/listed /' command-list.txt; \
 		$(MAKE) -C Documentation print-man1 | \
diff --git a/builtin/help.c b/builtin/help.c
index dec82d1be27..1ab1c8a0dd7 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -43,6 +43,7 @@ static enum help_action {
 	HELP_ACTION_ALL = 1,
 	HELP_ACTION_GUIDES,
 	HELP_ACTION_CONFIG,
+	HELP_ACTION_USER_INTERFACES,
 	HELP_ACTION_CONFIG_FOR_COMPLETION,
 	HELP_ACTION_CONFIG_SECTIONS_FOR_COMPLETION,
 } cmd_mode;
@@ -69,6 +70,9 @@ static struct option builtin_help_options[] = {
 
 	OPT_CMDMODE('g', "guides", &cmd_mode, N_("print list of useful guides"),
 		    HELP_ACTION_GUIDES),
+	OPT_CMDMODE(0, "user-interfaces", &cmd_mode,
+		    N_("print list of user-facing repository, command and file interfaces"),
+		    HELP_ACTION_USER_INTERFACES),
 	OPT_CMDMODE('c', "config", &cmd_mode, N_("print all configuration variable names"),
 		    HELP_ACTION_CONFIG),
 	OPT_CMDMODE_F(0, "config-for-completion", &cmd_mode, "",
@@ -84,6 +88,7 @@ static const char * const builtin_help_usage[] = {
 	N_("git help [[-i|--info] [-m|--man] [-w|--web]] [<command>|<doc>]"),
 	"git help [-g|--guides]",
 	"git help [-c|--config]",
+	"git help [--user-interfaces]",
 	NULL
 };
 
@@ -654,6 +659,10 @@ int cmd_help(int argc, const char **argv, const char *prefix)
 		opt_mode_usage(argc, "--config-for-completion", help_format);
 		list_config_help(SHOW_CONFIG_VARS);
 		return 0;
+	case HELP_ACTION_USER_INTERFACES:
+		opt_mode_usage(argc, "--user-interfaces", help_format);
+		list_user_interfaces_help();
+		return 0;
 	case HELP_ACTION_CONFIG_SECTIONS_FOR_COMPLETION:
 		opt_mode_usage(argc, "--config-sections-for-completion",
 			       help_format);
diff --git a/command-list.txt b/command-list.txt
index 9bd6f3c48f4..1d45303e14c 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -43,6 +43,11 @@
 # specified here, which can only have "guide" attribute and nothing
 # else.
 #
+# User-facing repository, command and file interfaces such as
+# documentation for the .gitmodules, .mailmap etc. files lives in man
+# sections 5 and 7. These entries can only have the "userinterfaces"
+# attribute and nothing else.
+#
 ### command list (do not change this line)
 # command name                          category [category] [category]
 git-add                                 mainporcelain           worktree
@@ -192,8 +197,8 @@ git-verify-tag                          ancillaryinterrogators
 git-whatchanged                         ancillaryinterrogators          complete
 git-worktree                            mainporcelain
 git-write-tree                          plumbingmanipulators
-gitattributes                           guide
-gitcli                                  guide
+gitattributes                           userinterfaces
+gitcli                                  userinterfaces
 gitcore-tutorial                        guide
 gitcredentials                          guide
 gitcvs-migration                        guide
@@ -201,15 +206,15 @@ gitdiffcore                             guide
 giteveryday                             guide
 gitfaq                                  guide
 gitglossary                             guide
-githooks                                guide
-gitignore                               guide
+githooks                                userinterfaces
+gitignore                               userinterfaces
 gitk                                    mainporcelain
-gitmailmap                              guide
-gitmodules                              guide
+gitmailmap                              userinterfaces
+gitmodules                              userinterfaces
 gitnamespaces                           guide
 gitremote-helpers                       guide
-gitrepository-layout                    guide
-gitrevisions                            guide
+gitrepository-layout                    userinterfaces
+gitrevisions                            userinterfaces
 gitsubmodules                           guide
 gittutorial                             guide
 gittutorial-2                           guide
diff --git a/help.c b/help.c
index 8a09f18a3d9..3e2a78863b7 100644
--- a/help.c
+++ b/help.c
@@ -38,6 +38,7 @@ static struct category_description main_categories[] = {
 	{ CAT_plumbinginterrogators, N_("Low-level Commands / Interrogators") },
 	{ CAT_synchingrepositories, N_("Low-level Commands / Syncing Repositories") },
 	{ CAT_purehelpers, N_("Low-level Commands / Internal Helpers") },
+	{ CAT_userinterfaces, N_("User-facing repository, command and file interfaces") },
 	{ 0, NULL }
 };
 
@@ -48,6 +49,7 @@ static const char *drop_prefix(const char *name, uint32_t category)
 
 	switch (category) {
 	case CAT_guide:
+	case CAT_userinterfaces:
 		prefix = "git";
 		break;
 	default:
@@ -433,6 +435,16 @@ void list_guides_help(void)
 	putchar('\n');
 }
 
+void list_user_interfaces_help(void)
+{
+	struct category_description catdesc[] = {
+		{ CAT_userinterfaces, N_("User-facing repository, command and file interfaces:") },
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
index 971a3ad855a..243104c27a7 100644
--- a/help.h
+++ b/help.h
@@ -22,6 +22,7 @@ static inline void mput_char(char c, unsigned int num)
 void list_common_cmds_help(void);
 void list_all_cmds_help(int show_external_commands, int show_aliases);
 void list_guides_help(void);
+void list_user_interfaces_help(void);
 
 void list_all_main_cmds(struct string_list *list);
 void list_all_other_cmds(struct string_list *list);
diff --git a/t/t0012-help.sh b/t/t0012-help.sh
index 6c33a436901..bee5ed12203 100755
--- a/t/t0012-help.sh
+++ b/t/t0012-help.sh
@@ -44,6 +44,8 @@ test_expect_success 'invalid usage' '
 	test_expect_code 129 git help -g add &&
 	test_expect_code 129 git help -a -g &&
 
+	test_expect_code 129 git help --user-interfaces add &&
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
 
+test_expect_success 'git help --user-interfaces' '
+	git help --user-interfaces >help.output &&
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
+	User-facing repository, command and file interfaces
 	EOF
 	test_cmp expect actual
 '
-- 
2.37.1.1232.gc0cde427aa7

