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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A060C433FE
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 15:24:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F0B961100
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 15:24:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352068AbhIHPZr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Sep 2021 11:25:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348081AbhIHPZl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Sep 2021 11:25:41 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5A61C061757
        for <git@vger.kernel.org>; Wed,  8 Sep 2021 08:24:33 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id n14-20020a05600c3b8e00b002f8bd2f8ab6so1915899wms.5
        for <git@vger.kernel.org>; Wed, 08 Sep 2021 08:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SmQ+EeoJ9K1n74LHFORCMMUvelmeWz1cD+PpeeiUIvM=;
        b=SwOfaHAeUO0AOpcJEHJ1zZljm3YjScI4SDNRks186+St+NcbJ2vsIZzZp/vdPfKaaP
         GvrrNV0QkmeKrugu+kFj+E0waiVKivelX4iEe+TlqPBaMT1Xa1ypoobBMB3QZm52EdaW
         uneZCpONwYEcTtbIildiR3GVg7ON55YZTG6Js8yl4U3Ntsm8IYo93dNUeO0D7C30Fvsa
         tgeY8WGgJbIUgnEMoBqTxgQ9pN18eDTqGVZSD7mfa6+x6EEiuA01NUH2vYGxJFpFICrv
         hQPtaMmmEAfj5EAwE8wKu718A1miTcVnop3ecgX/9Xg9hMCEx9FADDnay4ITJoO6NDnv
         p1NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SmQ+EeoJ9K1n74LHFORCMMUvelmeWz1cD+PpeeiUIvM=;
        b=zX1TyTk9V9gJz93ZKy9clHk1yh8AHeZVgm++Nt3MNkMJccJLifbbgbMXDRKPbmvyRV
         jPmGddlWJaLIXRzDK/HFSEHfWFURI8pdE3XSOJ6JKLHwRC26dgCpPVmVlIZi74qX3Ejn
         ygvtg2+ktkCTjavgKhABmfg3Xewut7SaNs2+c3ABFJsqiYqnjQDXeiXRJlygFRm87njm
         BW4DCa6sk4kfZv3Kf6flnBiLl8nKsLigrKyWVG/IDVB3XbY/T9Y5pjg7/LLnkwgZnCWo
         GRJ+Jz9ZmFA0A+BwBydSkin+d/F32MjHc9R0ed2/SiNd/e8l1K6q1Naoj+2SXLGq7Pyl
         ZhxA==
X-Gm-Message-State: AOAM531xZovQkUiHjqxeRdtRleFMBoxiVA/d42FwBjOexGinnBWVG23E
        DreZWSDKbCiFtrBwjqKjIkI+Isb2oRzzNA==
X-Google-Smtp-Source: ABdhPJwD2e1DkbCHbzdCSmU//GKeuv2h1EMqh96GCmeJvKuOL9wFTGi4SvFOWr0tnRhAkwoQgXpKNQ==
X-Received: by 2002:a1c:2705:: with SMTP id n5mr4168967wmn.176.1631114672013;
        Wed, 08 Sep 2021 08:24:32 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id x21sm2365240wmi.15.2021.09.08.08.24.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 08:24:31 -0700 (PDT)
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
Subject: [PATCH 6/6] help / completion: make "git help" do the hard work
Date:   Wed,  8 Sep 2021 17:24:22 +0200
Message-Id: <patch-6.6-940061e84d1-20210908T151949Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.825.g2bf60429931
In-Reply-To: <cover-0.6-00000000000-20210908T151949Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20210908T151949Z-avarab@gmail.com>
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
-u".

This changes the output of the section list to emit lines like "alias"
instead of "alias.". The dot suffix is better done as an argument to
__gitcomp().

This means that we'll have the list_config_help() function do a bit
more work, let's switch its "for_human" to passing a full
"show_config", but as an enum type so we can have the compiler check
what values we're expecting to get.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/help.c                         | 67 ++++++++++++++++++--------
 contrib/completion/git-completion.bash | 21 ++++----
 t/t0012-help.sh                        | 24 +++++++++
 3 files changed, 81 insertions(+), 31 deletions(-)

diff --git a/builtin/help.c b/builtin/help.c
index 83f71d6765e..b33ef27ac79 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -38,7 +38,12 @@ static const char *html_path;
 
 static int show_all = 0;
 static int show_guides = 0;
-static int show_config;
+enum show_config_type {
+	SHOW_CONFIG_UNSET = 0,
+	SHOW_CONFIG_HUMAN,
+	SHOW_CONFIG_VARS,
+	SHOW_CONFIG_SECTIONS,
+} show_config;
 static int verbose = 1;
 static unsigned int colopts;
 static enum help_format help_format = HELP_FORMAT_NONE;
@@ -48,7 +53,10 @@ static struct option builtin_help_options[] = {
 	OPT_HIDDEN_BOOL(0, "exclude-guides", &exclude_guides, N_("exclude guides")),
 	OPT_BOOL('g', "guides", &show_guides, N_("print list of useful guides")),
 	OPT_BOOL('c', "config", &show_config, N_("print all configuration variable names")),
-	OPT_SET_INT_F(0, "config-for-completion", &show_config, "", 2, PARSE_OPT_HIDDEN),
+	OPT_SET_INT_F(0, "config-for-completion-vars", &show_config, "",
+		      SHOW_CONFIG_VARS, PARSE_OPT_HIDDEN),
+	OPT_SET_INT_F(0, "config-for-completion-sections", &show_config, "",
+		      SHOW_CONFIG_SECTIONS, PARSE_OPT_HIDDEN),
 	OPT_SET_INT('m', "man", &help_format, N_("show man page"), HELP_FORMAT_MAN),
 	OPT_SET_INT('w', "web", &help_format, N_("show manual in web browser"),
 			HELP_FORMAT_WEB),
@@ -73,7 +81,7 @@ struct slot_expansion {
 	int found;
 };
 
-static void list_config_help(int for_human)
+static void list_config_help(enum show_config_type type)
 {
 	struct slot_expansion slot_expansions[] = {
 		{ "advice", "*", list_config_advices },
@@ -91,6 +99,8 @@ static void list_config_help(int for_human)
 	const char **p;
 	struct slot_expansion *e;
 	struct string_list keys = STRING_LIST_INIT_DUP;
+	struct string_list keys_uniq = STRING_LIST_INIT_DUP;
+	struct string_list_item *item;
 	int i;
 
 	for (p = config_name_list; *p; p++) {
@@ -121,34 +131,48 @@ static void list_config_help(int for_human)
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
+		case SHOW_CONFIG_UNSET:
+			BUG("should not get SHOW_CONFIG_UNSET here");
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
@@ -588,13 +612,16 @@ int cmd_help(int argc, const char **argv, const char *prefix)
 		return 0;
 	}
 
-	if (show_config) {
-		int for_human = show_config == 1;
-
-		if (for_human)
-			setup_pager();
-		list_config_help(for_human);
-		if (for_human)
+	switch (show_config) {
+	case SHOW_CONFIG_UNSET:
+		break;
+	case SHOW_CONFIG_HUMAN:
+		setup_pager();
+		/* fallthrough */
+	case SHOW_CONFIG_VARS:
+	case SHOW_CONFIG_SECTIONS:
+		list_config_help(show_config);
+		if (show_config == SHOW_CONFIG_HUMAN)
 			printf("\n%s\n", _("'git help config' for more information"));
 
 		return 0;
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 8108eda1e86..19b8a172878 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2503,7 +2503,14 @@ __git_config_vars=
 __git_compute_config_vars ()
 {
 	test -n "$__git_config_vars" ||
-	__git_config_vars="$(git help --config-for-completion | sort -u)"
+	__git_config_vars="$(git help --config-for-completion-vars)"
+}
+
+__git_config_sections=
+__git_compute_config_sections ()
+{
+	test -n "$__git_config_sections" ||
+	__git_config_sections="$(git help --config-for-completion-sections)"
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
index 68e7f57470e..6d169ae3cbd 100755
--- a/t/t0012-help.sh
+++ b/t/t0012-help.sh
@@ -94,6 +94,30 @@ test_expect_success 'git help -c' '
 	test_cmp expect actual
 '
 
+test_expect_success 'git help --config-for-completion-vars' '
+	git help -c >human &&
+	grep -E \
+	     -e "^[^.]+\.[^.]+$" \
+	     -e "^[^.]+\.[^.]+\.[^.]+$" human |
+	     sed -e "s/\*.*//" -e "s/<.*//" |
+	     sort -u >human.munged &&
+
+	git help --config-for-completion-vars >vars &&
+	test_cmp human.munged vars
+'
+
+test_expect_success 'git help --config-for-completion-sections' '
+	git help -c >human &&
+	grep -E \
+	     -e "^[^.]+\.[^.]+$" \
+	     -e "^[^.]+\.[^.]+\.[^.]+$" human |
+	     sed -e "s/\..*//" |
+	     sort -u >human.munged &&
+
+	git help --config-for-completion-sections >sections &&
+	test_cmp human.munged sections
+'
+
 test_expect_success 'generate builtin list' '
 	git --list-cmds=builtins >builtins
 '
-- 
2.33.0.825.g2bf60429931

