Return-Path: <SRS0=gF6X=CV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBA4CC43461
	for <git@archiver.kernel.org>; Sat, 12 Sep 2020 07:21:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9151420723
	for <git@archiver.kernel.org>; Sat, 12 Sep 2020 07:21:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oG119P12"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725865AbgILHVQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 12 Sep 2020 03:21:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbgILHVM (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Sep 2020 03:21:12 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1597C061573
        for <git@vger.kernel.org>; Sat, 12 Sep 2020 00:21:11 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id q9so6257700wmj.2
        for <git@vger.kernel.org>; Sat, 12 Sep 2020 00:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=kiN/pHODBUAQAxqcALdPmNthhueOD18a48KdKbLjn10=;
        b=oG119P12Egzh6LBHWTPZeqVq2Vx5NM/6G0/Yz8ghOkLHFV+vXHadd5qRWJlwQVbSTC
         TDOhi/U3oHhGLIp+ZjqiDM4voMbPCrJmFeuzUvjwiroxGOLrUedIG6j4EX3Rm0H9sGY+
         oqbtiGMuYnXgaHj6H5RF40cB9/JiDdORLHpuK5lkgbeDGtua/+kc8TCJ0+izLnfivLjw
         05Utyrxn814xGkFeU7RKjWnzw8Ykn13Ht26pNqR1r/LrL+lykRynUwZpty4E9GiW7PBb
         K4yV/PGikRQfILFCKMeMk+LVGrxkHWUmuZtvmv8kNAYaSXS0z04G1Toj5xjcMXT6XUlp
         ajDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=kiN/pHODBUAQAxqcALdPmNthhueOD18a48KdKbLjn10=;
        b=EOenjIQGg+9dELq2XxEOf22b18pPu/Jcag3/61RV58Nj72Us9UtZhNJ2UofU+ouhJE
         1EgmBttVmLXJyusTRpo/51ODw7WZiPBhjCQWqXT0UNnk1K3UiIGUQiVyWHZM+hJ60Wzu
         t7iC2/HKlvoXuMTm9iC+FbqbLYVzGnNlDiEFEJeFkJIqiDYworHYF5dL6i/cgT54UgMQ
         pXO9DAeG24WuDqGyldxSlBx0a2hDQQh/0hY70qMHE7o9KAIUOp86kqwwodEK6kuf+asQ
         sjNEvqqtnp9zzDf7WXrgiEm8o97PY6yRyYWL6MB6fnV8+i4KIf66Ovt5LCRkSV+h7Ncb
         REsg==
X-Gm-Message-State: AOAM532vixHM2Z42sGHXhSe5hKa/8xWhFnmVK3mILMkNptUcE6PX/zfg
        EfZGAh2ENbEmzUjVIWTuhN8OUOBEKR4=
X-Google-Smtp-Source: ABdhPJy0XFVYfjdGQYTvW/9llFUI0j7BvJi7OyTgWZZeDQ9yzOwMwEvaQtlQcGXEjrSytboPFX5E/A==
X-Received: by 2002:a1c:4d12:: with SMTP id o18mr6095415wmh.177.1599895269955;
        Sat, 12 Sep 2020 00:21:09 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i26sm8662253wmb.17.2020.09.12.00.21.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2020 00:21:09 -0700 (PDT)
Message-Id: <pull.781.v18.git.git.1599895268433.gitgitgadget@gmail.com>
In-Reply-To: <pull.781.v17.git.git.1594596738929.gitgitgadget@gmail.com>
References: <pull.781.v17.git.git.1594596738929.gitgitgadget@gmail.com>
From:   "sunlin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 12 Sep 2020 07:21:08 +0000
Subject: [PATCH v18] Support auto-merge for meld to follow the vim-diff
 behavior
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Lin Sun <lin.sun@zoom.us>, sunlin <sunlin7@yahoo.com>,
        Lin Sun <lin.sun@zoom.us>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lin Sun <lin.sun@zoom.us>

Make the mergetool used with "meld" backend behave similarly to "vimdiff" by
telling it to auto-merge non-conflicting parts and highlight the conflicting
parts when `mergetool.meld.useAutoMerge` is configured with `true`, or `auto`
for detecting the `--auto-merge` option automatically.

Helped-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
Helped-by: David Aguilar <davvid@gmail.com>
Signed-off-by: Lin Sun <lin.sun@zoom.us>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
    Enable auto-merge for meld to follow the vimdiff beharior
    
    Hi, the mergetool "meld" does NOT merge the no-conflict changes, while
    the mergetool "vimdiff" will merge the no-conflict changes and highlight
    the conflict parts. This patch will make the mergetool "meld" similar to
    "vimdiff", auto-merge the no-conflict changes, highlight conflict parts.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-781%2Fsunlin7%2Fmaster-v18
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-781/sunlin7/master-v18
Pull-Request: https://github.com/git/git/pull/781

Range-diff vs v17:

 1:  ce4e4cbfc0 ! 1:  1b931e610d Support auto-merge for meld to follow the vim-diff behavior
     @@ Documentation/config/mergetool.txt: mergetool.meld.hasOutput::
       	After performing a merge, the original file with conflict markers
       	can be saved as a file with a `.orig` extension.  If this variable
      
     + ## builtin/config.c ##
     +@@ builtin/config.c: static int show_scope;
     + #define TYPE_PATH		4
     + #define TYPE_EXPIRY_DATE	5
     + #define TYPE_COLOR		6
     ++#define TYPE_BOOL_OR_STR	7
     + 
     + #define OPT_CALLBACK_VALUE(s, l, v, h, i) \
     + 	{ OPTION_CALLBACK, (s), (l), (v), NULL, (h), PARSE_OPT_NOARG | \
     +@@ builtin/config.c: static int option_parse_type(const struct option *opt, const char *arg,
     + 			new_type = TYPE_INT;
     + 		else if (!strcmp(arg, "bool-or-int"))
     + 			new_type = TYPE_BOOL_OR_INT;
     ++		else if (!strcmp(arg, "bool-or-str"))
     ++			new_type = TYPE_BOOL_OR_STR;
     + 		else if (!strcmp(arg, "path"))
     + 			new_type = TYPE_PATH;
     + 		else if (!strcmp(arg, "expiry-date"))
     +@@ builtin/config.c: static struct option builtin_config_options[] = {
     + 	OPT_CALLBACK_VALUE(0, "bool", &type, N_("value is \"true\" or \"false\""), TYPE_BOOL),
     + 	OPT_CALLBACK_VALUE(0, "int", &type, N_("value is decimal number"), TYPE_INT),
     + 	OPT_CALLBACK_VALUE(0, "bool-or-int", &type, N_("value is --bool or --int"), TYPE_BOOL_OR_INT),
     ++	OPT_CALLBACK_VALUE(0, "bool-or-str", &type, N_("value is --bool or string"), TYPE_BOOL_OR_STR),
     + 	OPT_CALLBACK_VALUE(0, "path", &type, N_("value is a path (file or directory name)"), TYPE_PATH),
     + 	OPT_CALLBACK_VALUE(0, "expiry-date", &type, N_("value is an expiry date"), TYPE_EXPIRY_DATE),
     + 	OPT_GROUP(N_("Other")),
     +@@ builtin/config.c: static int format_config(struct strbuf *buf, const char *key_, const char *value
     + 				strbuf_addstr(buf, v ? "true" : "false");
     + 			else
     + 				strbuf_addf(buf, "%d", v);
     ++		} else if (type == TYPE_BOOL_OR_STR) {
     ++			int v = git_parse_maybe_bool(value_);
     ++			if (v < 0)
     ++				strbuf_addstr(buf, value_);
     ++			else
     ++				strbuf_addstr(buf, v ? "true" : "false");
     + 		} else if (type == TYPE_PATH) {
     + 			const char *v;
     + 			if (git_config_pathname(&v, key_, value_) < 0)
     +@@ builtin/config.c: static char *normalize_value(const char *key, const char *value)
     + 		else
     + 			return xstrdup(v ? "true" : "false");
     + 	}
     ++	if (type == TYPE_BOOL_OR_STR) {
     ++		int v = git_parse_maybe_bool(value);
     ++		if (v < 0)
     ++			return xstrdup(value);
     ++		else
     ++			return xstrdup(v ? "true" : "false");
     ++	}
     + 	if (type == TYPE_COLOR) {
     + 		char v[COLOR_MAXLEN];
     + 		if (git_config_color(v, key, value))
     +
       ## mergetools/meld ##
      @@ mergetools/meld: diff_cmd () {
       }
     @@ mergetools/meld: diff_cmd () {
      -		grep -e '--output=' -e '\[OPTION\.\.\.\]' >/dev/null
      +		meld_has_output_option=$(git config --bool mergetool.meld.hasOutput)
      +		case "$meld_has_output_option" in
     -+		true|false)
     ++		true | false)
      +			: use configured value
      +			;;
      +		*)
     @@ mergetools/meld: diff_cmd () {
      +			init_meld_help_msg
      +
      +			case "$meld_help_msg" in
     -+			*"--output="*|*'[OPTION...]'*)
     ++			*"--output="* | *'[OPTION...]'*)
      +				# All version that has [OPTION...] supports --output
      +				meld_has_output_option=true
      +				;;
     @@ mergetools/meld: diff_cmd () {
      -		meld_has_output_option=true
      -	else
      -		meld_has_output_option=false
     -+		meld_use_auto_merge_option=$(git config mergetool.meld.useAutoMerge)
     ++		meld_use_auto_merge_option=$(
     ++			git config --bool-or-str mergetool.meld.useAutoMerge
     ++		)
      +		case "$meld_use_auto_merge_option" in
     -+		true|false)
     ++		true | false)
      +			: use well formatted boolean value
      +			;;
      +		auto)
     @@ mergetools/meld: diff_cmd () {
      +			init_meld_help_msg
      +
      +			case "$meld_help_msg" in
     -+			*"--auto-merge"*|*'[OPTION...]'*)
     ++			*"--auto-merge"* | *'[OPTION...]'*)
      +				meld_use_auto_merge_option=true
      +				;;
      +			*)
     @@ mergetools/meld: diff_cmd () {
      +				;;
      +			esac
      +			;;
     ++		"")
     ++			meld_use_auto_merge_option=false
     ++			;;
      +		*)
     -+			# try other boolean value with git
     -+			if meld_use_auto_merge_option=$(
     -+				 git config --bool mergetool.meld.useAutoMerge)
     -+			then
     -+				: use normalized boolean value
     -+			else
     -+				meld_use_auto_merge_option=false
     -+			fi
     ++			die "unknown mergetool.meld.useAutoMerge: $meld_use_auto_merge_option"
      +			;;
      +		esac
       	fi


 Documentation/config/mergetool.txt | 10 ++++
 builtin/config.c                   | 17 ++++++
 mergetools/meld                    | 85 ++++++++++++++++++++++++------
 3 files changed, 96 insertions(+), 16 deletions(-)

diff --git a/Documentation/config/mergetool.txt b/Documentation/config/mergetool.txt
index 09ed31dbfa..16a27443a3 100644
--- a/Documentation/config/mergetool.txt
+++ b/Documentation/config/mergetool.txt
@@ -30,6 +30,16 @@ mergetool.meld.hasOutput::
 	to `true` tells Git to unconditionally use the `--output` option,
 	and `false` avoids using `--output`.
 
+mergetool.meld.useAutoMerge::
+	When the `--auto-merge` is given, meld will merge all non-conflicting
+	parts automatically, highlight the conflicting parts and wait for
+	user decision.  Setting `mergetool.meld.useAutoMerge` to `true` tells
+	Git to unconditionally use the `--auto-merge` option with `meld`.
+	Setting this value to `auto` makes git detect whether `--auto-merge`
+	is supported and will only use `--auto-merge` when available.  A
+	value of `false` avoids using `--auto-merge` altogether, and is the
+	default value.
+
 mergetool.keepBackup::
 	After performing a merge, the original file with conflict markers
 	can be saved as a file with a `.orig` extension.  If this variable
diff --git a/builtin/config.c b/builtin/config.c
index 5e39f61885..ae077c9f2f 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -65,6 +65,7 @@ static int show_scope;
 #define TYPE_PATH		4
 #define TYPE_EXPIRY_DATE	5
 #define TYPE_COLOR		6
+#define TYPE_BOOL_OR_STR	7
 
 #define OPT_CALLBACK_VALUE(s, l, v, h, i) \
 	{ OPTION_CALLBACK, (s), (l), (v), NULL, (h), PARSE_OPT_NOARG | \
@@ -94,6 +95,8 @@ static int option_parse_type(const struct option *opt, const char *arg,
 			new_type = TYPE_INT;
 		else if (!strcmp(arg, "bool-or-int"))
 			new_type = TYPE_BOOL_OR_INT;
+		else if (!strcmp(arg, "bool-or-str"))
+			new_type = TYPE_BOOL_OR_STR;
 		else if (!strcmp(arg, "path"))
 			new_type = TYPE_PATH;
 		else if (!strcmp(arg, "expiry-date"))
@@ -149,6 +152,7 @@ static struct option builtin_config_options[] = {
 	OPT_CALLBACK_VALUE(0, "bool", &type, N_("value is \"true\" or \"false\""), TYPE_BOOL),
 	OPT_CALLBACK_VALUE(0, "int", &type, N_("value is decimal number"), TYPE_INT),
 	OPT_CALLBACK_VALUE(0, "bool-or-int", &type, N_("value is --bool or --int"), TYPE_BOOL_OR_INT),
+	OPT_CALLBACK_VALUE(0, "bool-or-str", &type, N_("value is --bool or string"), TYPE_BOOL_OR_STR),
 	OPT_CALLBACK_VALUE(0, "path", &type, N_("value is a path (file or directory name)"), TYPE_PATH),
 	OPT_CALLBACK_VALUE(0, "expiry-date", &type, N_("value is an expiry date"), TYPE_EXPIRY_DATE),
 	OPT_GROUP(N_("Other")),
@@ -250,6 +254,12 @@ static int format_config(struct strbuf *buf, const char *key_, const char *value
 				strbuf_addstr(buf, v ? "true" : "false");
 			else
 				strbuf_addf(buf, "%d", v);
+		} else if (type == TYPE_BOOL_OR_STR) {
+			int v = git_parse_maybe_bool(value_);
+			if (v < 0)
+				strbuf_addstr(buf, value_);
+			else
+				strbuf_addstr(buf, v ? "true" : "false");
 		} else if (type == TYPE_PATH) {
 			const char *v;
 			if (git_config_pathname(&v, key_, value_) < 0)
@@ -411,6 +421,13 @@ static char *normalize_value(const char *key, const char *value)
 		else
 			return xstrdup(v ? "true" : "false");
 	}
+	if (type == TYPE_BOOL_OR_STR) {
+		int v = git_parse_maybe_bool(value);
+		if (v < 0)
+			return xstrdup(value);
+		else
+			return xstrdup(v ? "true" : "false");
+	}
 	if (type == TYPE_COLOR) {
 		char v[COLOR_MAXLEN];
 		if (git_config_color(v, key, value))
diff --git a/mergetools/meld b/mergetools/meld
index 7a08470f88..aab4ebb935 100644
--- a/mergetools/meld
+++ b/mergetools/meld
@@ -3,34 +3,87 @@ diff_cmd () {
 }
 
 merge_cmd () {
-	if test -z "${meld_has_output_option:+set}"
+	check_meld_for_features
+
+	option_auto_merge=
+	if test "$meld_use_auto_merge_option" = true
 	then
-		check_meld_for_output_version
+		option_auto_merge="--auto-merge"
 	fi
 
 	if test "$meld_has_output_option" = true
 	then
-		"$merge_tool_path" --output="$MERGED" \
+		"$merge_tool_path" $option_auto_merge --output="$MERGED" \
 			"$LOCAL" "$BASE" "$REMOTE"
 	else
-		"$merge_tool_path" "$LOCAL" "$MERGED" "$REMOTE"
+		"$merge_tool_path" $option_auto_merge "$LOCAL" "$MERGED" "$REMOTE"
 	fi
 }
 
-# Check whether we should use 'meld --output <file>'
-check_meld_for_output_version () {
-	meld_path="$(git config mergetool.meld.path)"
-	meld_path="${meld_path:-meld}"
+# Get meld help message
+init_meld_help_msg () {
+	if test -z "$meld_help_msg"
+	then
+		meld_path="$(git config mergetool.meld.path || echo meld)"
+		meld_help_msg=$("$meld_path" --help 2>&1)
+	fi
+}
 
-	if meld_has_output_option=$(git config --bool mergetool.meld.hasOutput)
+# Check the features and set flags
+check_meld_for_features () {
+	# Check whether we should use 'meld --output <file>'
+	if test -z "$meld_has_output_option"
 	then
-		: use configured value
-	elif "$meld_path" --help 2>&1 |
-		grep -e '--output=' -e '\[OPTION\.\.\.\]' >/dev/null
+		meld_has_output_option=$(git config --bool mergetool.meld.hasOutput)
+		case "$meld_has_output_option" in
+		true | false)
+			: use configured value
+			;;
+		*)
+			: empty or invalid configured value, detecting "--output" automatically
+			init_meld_help_msg
+
+			case "$meld_help_msg" in
+			*"--output="* | *'[OPTION...]'*)
+				# All version that has [OPTION...] supports --output
+				meld_has_output_option=true
+				;;
+			*)
+				meld_has_output_option=false
+				;;
+			esac
+			;;
+		esac
+	fi
+	# Check whether we should use 'meld --auto-merge ...'
+	if test -z "$meld_use_auto_merge_option"
 	then
-		: old ones mention --output and new ones just say OPTION...
-		meld_has_output_option=true
-	else
-		meld_has_output_option=false
+		meld_use_auto_merge_option=$(
+			git config --bool-or-str mergetool.meld.useAutoMerge
+		)
+		case "$meld_use_auto_merge_option" in
+		true | false)
+			: use well formatted boolean value
+			;;
+		auto)
+			# testing the "--auto-merge" option only if config is "auto"
+			init_meld_help_msg
+
+			case "$meld_help_msg" in
+			*"--auto-merge"* | *'[OPTION...]'*)
+				meld_use_auto_merge_option=true
+				;;
+			*)
+				meld_use_auto_merge_option=false
+				;;
+			esac
+			;;
+		"")
+			meld_use_auto_merge_option=false
+			;;
+		*)
+			die "unknown mergetool.meld.useAutoMerge: $meld_use_auto_merge_option"
+			;;
+		esac
 	fi
 }

base-commit: 3a238e539bcdfe3f9eb5010fd218640c1b499f7a
-- 
gitgitgadget
