Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29A27C433F5
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 22:42:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06B1661050
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 22:42:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232476AbhIUWoP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Sep 2021 18:44:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234107AbhIUWmY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Sep 2021 18:42:24 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D278CC061767
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 15:40:54 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id u18so1165328wrg.5
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 15:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZvFFpNy1tHfbYNQEtmtpgxpae+O50v7T4EA8vkF5QYU=;
        b=fmFhbfQKGINXseBxykDrXlxTFTE9DBncgPEjnXg4A3aGbZ0jCyJuLdI8nhZaB/xhxM
         aIxj9BTqIw1LHJ4nRzJnwHJA9RumlGXZ6alsNN9K5RyosBRDZL6IBWnd6UVygzKKt0Av
         +mp80E47wPJ0sKfUfBTm9YdixmAWxz8rniD4OaSQEL1ATlGd6T7womZNSvPNiBSSVqRm
         byH7pEnSIB8yG9LkXihoUWQxqQljaRisldLxfR9WiJT0DjRLV8NG2v/EC2HYoosPLbRw
         jAW0QrpN/iVtFnhKkmCVgvXzfxJmBsFXzaW8R2N0KW4jLA2qpexgykpxoWI4+b5eDtH7
         vzDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZvFFpNy1tHfbYNQEtmtpgxpae+O50v7T4EA8vkF5QYU=;
        b=UNjsxfWB7owuxw0Y+qfFIElyzW4efEBOh28wEAU5HJcK4dv82ATi0EHiuFoxKEsoDm
         tWOzBxIIa68pIgLn48dSC//zQ/qEgHkHHG6tWb8xFTreng3DxXyf1qdSBKnx0QturzWU
         BoZSqV1EtWTpBLsEzT256jTltVyD5SHaKobX7IUXC/apMWl2qMdQvQZFpOIoMROonXAV
         RuuK8OhsfnjUZnyG7pM0Jc92Sn4tX1OlV4M8nuPGRCN0haUz/t6ZnRdJX9zMyWjtkvuo
         bLtSLJspoJg1Aj6ahossq/Q9J3XMPTxgCN6GpWQgFeq7kRbJQ3qIHQLGKFWMz0iiDR9a
         Rcwg==
X-Gm-Message-State: AOAM530tledObaN2r5hZSOkJ71CR4wj6jniqWV+1KOXg20zB/Rni/fnX
        3H9u2J+ozACemsFcbzHlUHeFBoXr8+y6+A==
X-Google-Smtp-Source: ABdhPJxNJYNbWgmXmRpKMNJECqTKodLIxgzMretbWRGyEloq6npAqOasH+cXbTww6nnjxGFmnN4oQw==
X-Received: by 2002:a5d:60c8:: with SMTP id x8mr37377843wrt.293.1632264053068;
        Tue, 21 Sep 2021 15:40:53 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l7sm3846121wmp.48.2021.09.21.15.40.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 15:40:52 -0700 (PDT)
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
Subject: [PATCH v3 8/9] help / completion: make "git help" do the hard work
Date:   Wed, 22 Sep 2021 00:40:38 +0200
Message-Id: <patch-v3-8.9-836e19f8612-20210921T223223Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1098.gf02a64c1a2d
In-Reply-To: <cover-v3-0.9-00000000000-20210921T223223Z-avarab@gmail.com>
References: <cover-v2-0.5-00000000000-20210910T112545Z-avarab@gmail.com> <cover-v3-0.9-00000000000-20210921T223223Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The "help" builtin has been able to emit configuration variables since
e17ca926371 (completion: drop the hard coded list of config vars,
2018-05-26), but it hasn't produced exactly the format the completion
script wanted. Let's do that.

We got partway there in 2675ea1cc0f (completion: use 'sort -u' to
deduplicate config variable names, 2019-08-13) and
d9438873c4d (completion: deduplicate configuration sections,
2019-08-13), but after both we still needed some sorting,
de-duplicating and awk post-processing of the list.

We can instead simply do the relevant parsing ourselves (we were doing
most of it already), and call string_list_remove_duplicates() after
already sorting the list, so the caller doesn't need to invoke "sort
-u". The "--config-for-completion" output is the same as before after
being passed through "sort -u".

Then add a new "--config-sections-for-completion" option. Under that
output we'll emit config sections like "alias" (instead of "alias." in
the --config-for-completion output).

We need to be careful to leave the "--config-for-completion" option
compatible with users git, but are still running a shell with an older
git-completion.bash. If we e.g. changed the option name they'd see
messages about git-completion.bash being unable to find the
"--config-for-completion" option.

Such backwards compatibility isn't something we should bend over
backwards for, it's only helping users who:

 * Upgrade git
 * Are in an old shell
 * The git-completion.bash in that shell hasn't cached the old
   "--config-for-completion" output already.

But since it's easy in this case to retain compatibility, let's do it,
the older versions of git-completion.bash won't care that the input
they get doesn't change after a "sort -u".

While we're at it let's make "--config-for-completion" die if there's
anything left over in "argc", and do the same in the new
"--config-sections-for-completion" option.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/help.c                         | 54 +++++++++++++++++++-------
 contrib/completion/git-completion.bash | 21 +++++-----
 t/t0012-help.sh                        | 17 ++++++--
 3 files changed, 65 insertions(+), 27 deletions(-)

diff --git a/builtin/help.c b/builtin/help.c
index 6a022d9803e..9a255a9aee6 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -34,11 +34,18 @@ enum help_format {
 	HELP_FORMAT_WEB
 };
 
+enum show_config_type {
+	SHOW_CONFIG_HUMAN,
+	SHOW_CONFIG_VARS,
+	SHOW_CONFIG_SECTIONS,
+};
+
 static enum help_action {
 	HELP_ACTION_ALL = 1,
 	HELP_ACTION_GUIDES,
 	HELP_ACTION_CONFIG,
 	HELP_ACTION_CONFIG_FOR_COMPLETION,
+	HELP_ACTION_CONFIG_SECTIONS_FOR_COMPLETION,
 } cmd_mode;
 
 static const char *html_path;
@@ -63,6 +70,8 @@ static struct option builtin_help_options[] = {
 		    HELP_ACTION_CONFIG),
 	OPT_CMDMODE_F(0, "config-for-completion", &cmd_mode, "",
 		    HELP_ACTION_CONFIG_FOR_COMPLETION, PARSE_OPT_HIDDEN),
+	OPT_CMDMODE_F(0, "config-sections-for-completion", &cmd_mode, "",
+		    HELP_ACTION_CONFIG_SECTIONS_FOR_COMPLETION, PARSE_OPT_HIDDEN),
 
 	OPT_END(),
 };
@@ -82,7 +91,7 @@ struct slot_expansion {
 	int found;
 };
 
-static void list_config_help(int for_human)
+static void list_config_help(enum show_config_type type)
 {
 	struct slot_expansion slot_expansions[] = {
 		{ "advice", "*", list_config_advices },
@@ -100,6 +109,8 @@ static void list_config_help(int for_human)
 	const char **p;
 	struct slot_expansion *e;
 	struct string_list keys = STRING_LIST_INIT_DUP;
+	struct string_list keys_uniq = STRING_LIST_INIT_DUP;
+	struct string_list_item *item;
 	int i;
 
 	for (p = config_name_list; *p; p++) {
@@ -130,34 +141,46 @@ static void list_config_help(int for_human)
 	for (i = 0; i < keys.nr; i++) {
 		const char *var = keys.items[i].string;
 		const char *wildcard, *tag, *cut;
+		const char *dot = NULL;
+		struct strbuf sb = STRBUF_INIT;
 
-		if (for_human) {
+		switch (type) {
+		case SHOW_CONFIG_HUMAN:
 			puts(var);
 			continue;
+		case SHOW_CONFIG_SECTIONS:
+			dot = strchr(var, '.');
+			break;
+		case SHOW_CONFIG_VARS:
+			break;
 		}
-
 		wildcard = strchr(var, '*');
 		tag = strchr(var, '<');
 
-		if (!wildcard && !tag) {
-			puts(var);
+		if (!dot && !wildcard && !tag) {
+			string_list_append(&keys_uniq, var);
 			continue;
 		}
 
-		if (wildcard && !tag)
+		if (dot)
+			cut = dot;
+		else if (wildcard && !tag)
 			cut = wildcard;
 		else if (!wildcard && tag)
 			cut = tag;
 		else
 			cut = wildcard < tag ? wildcard : tag;
 
-		/*
-		 * We may produce duplicates, but that's up to
-		 * git-completion.bash to handle
-		 */
-		printf("%.*s\n", (int)(cut - var), var);
+		strbuf_add(&sb, var, cut - var);
+		string_list_append(&keys_uniq, sb.buf);
+		strbuf_release(&sb);
+
 	}
 	string_list_clear(&keys, 0);
+	string_list_remove_duplicates(&keys_uniq, 0);
+	for_each_string_list_item(item, &keys_uniq)
+		puts(item->string);
+	string_list_clear(&keys_uniq, 0);
 }
 
 static enum help_format parse_help_format(const char *format)
@@ -589,12 +612,17 @@ int cmd_help(int argc, const char **argv, const char *prefix)
 		printf("%s\n", _(git_more_info_string));
 		return 0;
 	case HELP_ACTION_CONFIG_FOR_COMPLETION:
-		list_config_help(0);
+		no_extra_argc(argc);
+		list_config_help(SHOW_CONFIG_VARS);
+		return 0;
+	case HELP_ACTION_CONFIG_SECTIONS_FOR_COMPLETION:
+		no_extra_argc(argc);
+		list_config_help(SHOW_CONFIG_SECTIONS);
 		return 0;
 	case HELP_ACTION_CONFIG:
 		no_extra_argc(argc);
 		setup_pager();
-		list_config_help(1);
+		list_config_help(SHOW_CONFIG_HUMAN);
 		printf("\n%s\n", _("'git help config' for more information"));
 		return 0;
 	}
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 8108eda1e86..b9f63701930 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2503,7 +2503,14 @@ __git_config_vars=
 __git_compute_config_vars ()
 {
 	test -n "$__git_config_vars" ||
-	__git_config_vars="$(git help --config-for-completion | sort -u)"
+	__git_config_vars="$(git help --config-for-completion)"
+}
+
+__git_config_sections=
+__git_compute_config_sections ()
+{
+	test -n "$__git_config_sections" ||
+	__git_config_sections="$(git help --config-sections-for-completion)"
 }
 
 # Completes possible values of various configuration variables.
@@ -2717,16 +2724,8 @@ __git_complete_config_variable_name ()
 		__gitcomp "$__git_config_vars" "" "$cur_" "$sfx"
 		;;
 	*)
-		__git_compute_config_vars
-		__gitcomp "$(echo "$__git_config_vars" |
-				awk -F . '{
-					sections[$1] = 1
-				}
-				END {
-					for (s in sections)
-						print s "."
-				}
-				')" "" "$cur_"
+		__git_compute_config_sections
+		__gitcomp "$__git_config_sections" "" "$cur_" "."
 		;;
 	esac
 }
diff --git a/t/t0012-help.sh b/t/t0012-help.sh
index 25bbaf0d586..60d713021f9 100755
--- a/t/t0012-help.sh
+++ b/t/t0012-help.sh
@@ -42,7 +42,8 @@ test_expect_success 'invalid usage' '
 	test_expect_code 129 git help -a -g &&
 
 	test_expect_code 129 git help -g -c &&
-	test_expect_code 0 git help --config-for-completion add
+	test_expect_code 129 git help --config-for-completion add &&
+	test_expect_code 129 git help --config-sections-for-completion add
 '
 
 test_expect_success "works for commands and guides by default" '
@@ -106,11 +107,21 @@ test_expect_success 'git help --config-for-completion' '
 	     sort -u >human.munged &&
 
 	git help --config-for-completion >vars &&
-	sort -u <vars >vars.new &&
-	mv vars.new vars &&
 	test_cmp human.munged vars
 '
 
+test_expect_success 'git help --config-sections-for-completion' '
+	git help -c >human &&
+	grep -E \
+	     -e "^[^.]+\.[^.]+$" \
+	     -e "^[^.]+\.[^.]+\.[^.]+$" human |
+	     sed -e "s/\..*//" |
+	     sort -u >human.munged &&
+
+	git help --config-sections-for-completion >sections &&
+	test_cmp human.munged sections
+'
+
 test_expect_success 'generate builtin list' '
 	git --list-cmds=builtins >builtins
 '
-- 
2.33.0.1098.gf02a64c1a2d

