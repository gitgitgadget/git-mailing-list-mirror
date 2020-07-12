Return-Path: <SRS0=l3cg=AX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5621C433E1
	for <git@archiver.kernel.org>; Sun, 12 Jul 2020 09:08:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71CBF20720
	for <git@archiver.kernel.org>; Sun, 12 Jul 2020 09:08:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CpUbStF1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728535AbgGLJI1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Jul 2020 05:08:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728070AbgGLJI0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Jul 2020 05:08:26 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83457C061794
        for <git@vger.kernel.org>; Sun, 12 Jul 2020 02:08:26 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id l2so10037295wmf.0
        for <git@vger.kernel.org>; Sun, 12 Jul 2020 02:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=CVIbTbCs0wKaPXEEGW2GoDtpv/+2sIuiUx1NloKWgW8=;
        b=CpUbStF1diK4OKsHDOHE/GBvH7Hlt7FR3WmmBmjlx1EUUL2HVh6EWXJLq/PVJqZt1z
         lxlX/Qto8H+fTvDVhLiqeXES4LfWTE6bTvmx4n9IdliEU6G9Y+VzvkQPFP02C51aMUQb
         F3xJZOH4xdBp/+TKYrXouarTAbt/eJ64tvTWNWRLP9O1f+8wwkFNsgOK8Wq77O/Xawt8
         uZ6r6D2nIG7aHcdFEqRS0mFlnPRfFl7i2k8pMVpo4uP18wWzuVWbg28qa+ynqpZ91q0D
         U4coTW6W9ub+1nb4TaaC/Lzyii/Tr/HS7zHV/G7pd5rTphL/5WZPp54sI3wu6PkcI6Ku
         IIeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=CVIbTbCs0wKaPXEEGW2GoDtpv/+2sIuiUx1NloKWgW8=;
        b=WuGIFlQTA217fcgYyAueh4Pmzyk56Mt+j9fD16AW/ClmmhrV8UTE7XQ8EM4V+GwsCR
         37LnTZvbXJxNwQ+Elv6vgmuGXQkacC9TSDt5HopVtXjWs+rOdJUWLnp7YPFOfw2te/Hk
         PGPPJQnxyU+TkyUsX+Nx1iSMtTFfD8IC5WMawRu5CZQsMLZoiqMO636WXdsGY0EaGbKs
         +iwfyYKak+wEDQtIfJEIr5jjlMph44O0a1dlzdsFfJ6cflC2UY4bP+JIQ6LR5SfFGH31
         oGHf+Im3hiPBbI/SB3QCVIJRYFKzcXzc6rdJC+RIJipIiIqt4si1eIPlTDfSYafsvop9
         ATtQ==
X-Gm-Message-State: AOAM532kRm7w80x423zXazgVHG8gIouN2vFTU0ZFPhnnE2DHShU+YZUl
        MpujZQINHuD8Q7GcLN+wGGW5NLQ3
X-Google-Smtp-Source: ABdhPJytgPz24eUr+M2tuLftqFT4Mj8IFYYu+3pQLI7h2uikTh7ksU34Q9tfJ7ZVE57NgOK2mkvtxQ==
X-Received: by 2002:a1c:de07:: with SMTP id v7mr13848319wmg.56.1594544904839;
        Sun, 12 Jul 2020 02:08:24 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r28sm17705392wrr.20.2020.07.12.02.08.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2020 02:08:24 -0700 (PDT)
Message-Id: <pull.781.v16.git.git.1594544903477.gitgitgadget@gmail.com>
In-Reply-To: <pull.781.v15.git.git.1594543148959.gitgitgadget@gmail.com>
References: <pull.781.v15.git.git.1594543148959.gitgitgadget@gmail.com>
From:   "sunlin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 12 Jul 2020 09:08:23 +0000
Subject: [PATCH v16] Support auto-merge for meld to follow the vim-diff
 behavior
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     sunlin <sunlin7@yahoo.com>, Lin Sun <lin.sun@zoom.us>
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

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-781%2Fsunlin7%2Fmaster-v16
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-781/sunlin7/master-v16
Pull-Request: https://github.com/git/git/pull/781

Range-diff vs v15:

 1:  02d849784f ! 1:  d235a576b4 Support auto-merge for meld to follow the vim-diff behavior
     @@ mergetools/meld: diff_cmd () {
      -	else
      -		meld_has_output_option=false
      +		meld_use_auto_merge_option=$(
     -+			git --bool-or-str config mergetool.meld.useAutoMerge)
     ++			git config --bool-or-str mergetool.meld.useAutoMerge)
      +		case "$meld_use_auto_merge_option" in
      +		true|false)
      +			: use well formatted boolean value


 Documentation/config/mergetool.txt | 10 ++++
 builtin/config.c                   | 19 +++++++
 config.c                           | 14 ++++++
 config.h                           |  7 +++
 mergetools/meld                    | 81 ++++++++++++++++++++++++------
 5 files changed, 115 insertions(+), 16 deletions(-)

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
index ee4aef6a35..6f2ddadc80 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -65,6 +65,7 @@ static int show_scope;
 #define TYPE_PATH		4
 #define TYPE_EXPIRY_DATE	5
 #define TYPE_COLOR		6
+#define TYPE_BOOL_OR_STR        7
 
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
@@ -250,6 +254,13 @@ static int format_config(struct strbuf *buf, const char *key_, const char *value
 				strbuf_addstr(buf, v ? "true" : "false");
 			else
 				strbuf_addf(buf, "%d", v);
+		} else if (type == TYPE_BOOL_OR_STR) {
+			int is_bool, v;
+			v = git_config_bool_or_str(NULL, key_, value_, &is_bool);
+			if (is_bool)
+				strbuf_addstr(buf, v ? "true" : "false");
+			else
+				strbuf_addstr(buf, value_);
 		} else if (type == TYPE_PATH) {
 			const char *v;
 			if (git_config_pathname(&v, key_, value_) < 0)
@@ -411,6 +422,14 @@ static char *normalize_value(const char *key, const char *value)
 		else
 			return xstrdup(v ? "true" : "false");
 	}
+	if (type == TYPE_BOOL_OR_STR) {
+		int is_bool, v;
+		v = git_config_bool_or_str(NULL, key, value, &is_bool);
+		if (!is_bool)
+			return xstrdup(value);
+		else
+			return xstrdup(v ? "true" : "false");
+	}
 	if (type == TYPE_COLOR) {
 		char v[COLOR_MAXLEN];
 		if (git_config_color(v, key, value))
diff --git a/config.c b/config.c
index 8db9c77098..4c6c06d10b 100644
--- a/config.c
+++ b/config.c
@@ -1100,6 +1100,20 @@ int git_config_bool_or_int(const char *name, const char *value, int *is_bool)
 	return git_config_int(name, value);
 }
 
+int git_config_bool_or_str(const char **dest, const char *name, const char *value, int *is_bool)
+{
+	int v = git_parse_maybe_bool_text(value);
+	if (0 <= v) {
+		*is_bool = 1;
+		return v;
+	}
+	*is_bool = 0;
+	if (dest != NULL)
+	  return git_config_string(dest, name, value);
+	else
+	  return 0;
+}
+
 int git_config_bool(const char *name, const char *value)
 {
 	int discard;
diff --git a/config.h b/config.h
index 060874488f..175b88d9c5 100644
--- a/config.h
+++ b/config.h
@@ -217,6 +217,13 @@ ssize_t git_config_ssize_t(const char *, const char *);
  */
 int git_config_bool_or_int(const char *, const char *, int *);
 
+/**
+ * Same as `git_config_bool`, except that `is_bool` flag is unset, then if
+ * `dest` parameter is non-NULL, it allocates and copies the value string
+ * into the `dest`, if `dest` is NULL and `is_bool` flag is unset it return 0.
+ */
+int git_config_bool_or_str(const char **, const char *, const char *, int *);
+
 /**
  * Parse a string into a boolean value, respecting keywords like "true" and
  * "false". Integer values are converted into true/false values (when they
diff --git a/mergetools/meld b/mergetools/meld
index 7a08470f88..bc2ea894d7 100644
--- a/mergetools/meld
+++ b/mergetools/meld
@@ -3,34 +3,83 @@ diff_cmd () {
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
+		true|false)
+			: use configured value
+			;;
+		*)
+			: empty or invalid configured value, detecting "--output" automatically
+			init_meld_help_msg
+
+			case "$meld_help_msg" in
+			*"--output="*|*'[OPTION...]'*)
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
+			git config --bool-or-str mergetool.meld.useAutoMerge)
+		case "$meld_use_auto_merge_option" in
+		true|false)
+			: use well formatted boolean value
+			;;
+		auto)
+			# testing the "--auto-merge" option only if config is "auto"
+			init_meld_help_msg
+
+			case "$meld_help_msg" in
+			*"--auto-merge"*|*'[OPTION...]'*)
+				meld_use_auto_merge_option=true
+				;;
+			*)
+				meld_use_auto_merge_option=false
+				;;
+			esac
+			;;
+		*)
+			meld_use_auto_merge_option=false
+			;;
+		esac
 	fi
 }

base-commit: 07d8ea56f2ecb64b75b92264770c0a664231ce17
-- 
gitgitgadget
