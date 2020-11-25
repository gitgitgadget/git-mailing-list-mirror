Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDF0EC71155
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 22:13:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7027C20857
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 22:13:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IdJjFstb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732887AbgKYWNJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Nov 2020 17:13:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731475AbgKYWNC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Nov 2020 17:13:02 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 486D1C061A51
        for <git@vger.kernel.org>; Wed, 25 Nov 2020 14:13:02 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id 10so173376wml.2
        for <git@vger.kernel.org>; Wed, 25 Nov 2020 14:13:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=JNeuasjdJpTx03qlPCn2+QaPpT57HetwOjVQ9GfHlsM=;
        b=IdJjFstbTCVdk0uf8VhNzFq66o/cn58bAF2Wb3ubhQ9yovcbYEhDUMUsTr9FSa5IVY
         fIqtSBvDctLcpSXpYCZJkG8oGFNYNLpYZ3vTyzBabdKHwTDtiXc/kOo3dcNGO9PDVyNl
         1pCj0eKZx7SYljbADe3/ccp6v7ZFujtOGF4ENw3x+1EFL/7dDKHHVzwxvMSRFt2LfhSN
         G0SAYx9MY56CO8V79wFUt1cCPnNGABk9zhlSSzWiC1mg772J1/UHapt407MZqmmbfTz4
         /hJkpl9JTtjp+mQJFz6NDbyvjKOdUIYkbmN8lnoWEcpYKmoxAANQoh8i2kJiBOjKPF3D
         /PHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=JNeuasjdJpTx03qlPCn2+QaPpT57HetwOjVQ9GfHlsM=;
        b=LQuq47Doyq22Xgc8YMMv/PVVSgAc630Hlep8sZACodZmY9/OosIpNoSvYCg+cH65nn
         YMZwf1JUMV7DDSIWXAKC4nhrA6wnDkGSZpAdndzLYtb3CLGKF/4wVIIC52sSZeVHYVDv
         +FnEWY4/kOPVivm2LWiszKM3PcrNhiDppduZCrCvvR9C6WJwsJTgUmR3on0z0KDHGx1O
         x2f4V6x+23UrjFNPVEm+mWXUksID+Z0IVyP72TqbhO89aEdbr1YU2+NlYak46isT6qUZ
         Dhx+IPyfaM9Vxz40GIBcXvE9IyjXhRx4MrYV7BaRF+5y/tMrpNEP6uOHqphNo2O6y76/
         oDYg==
X-Gm-Message-State: AOAM530lKtsfSIjs1vtBOP5DL6kS1tJV60gfuLxkP967e0N9fxuEzz8U
        eyr3qXr24m5M+rDfd2ZtgVgiCYfvJTA=
X-Google-Smtp-Source: ABdhPJzBWZksFzEJ2h7sFPidGZmbmbVGUei9NKvhNcVxhSL8GI4+VR24+UNm4GnoVbDbO1atortcDQ==
X-Received: by 2002:a7b:c5c6:: with SMTP id n6mr6117576wmk.131.1606342380631;
        Wed, 25 Nov 2020 14:13:00 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d13sm7339443wrb.39.2020.11.25.14.12.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2020 14:13:00 -0800 (PST)
Message-Id: <f135b001ad911c079b0754c61e2179277ce37e0f.1606342377.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.796.v3.git.1606342376.gitgitgadget@gmail.com>
References: <pull.796.v2.git.1606147507.gitgitgadget@gmail.com>
        <pull.796.v3.git.1606342376.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 25 Nov 2020 22:12:50 +0000
Subject: [PATCH v3 2/8] config: replace 'value_regex' with 'value_pattern'
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Martin =?UTF-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Derrick Stolee <stolee@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The 'value_regex' argument in the 'git config' builtin is poorly named,
especially related to an upcoming change that allows exact string
matches instead of ERE pattern matches.

Perform a mostly mechanical change of every instance of 'value_regex' to
'value_pattern' in the codebase. This is only critical for documentation
and error messages, but it is best to be consistent inside the codebase,
too.

For documentation, use 'value-pattern' which is better punctuation. This
affects Documentation/git-config.txt and the usage in builtin/config.c,
which was already mixed between 'value_regex' and 'value-regex'.

I gave some thought to leaving the value_regex variables inside config.c
that are regex_t pointers. However, it is probably best to keep the name
consistent with the rest of the variables.

This does not update the translations inside the po/ directory, as that
creates conflicts with ongoing work. The input strings should
automatically update through automation, and a few of the output strings
currently use "[value_regex]" directly.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/git-config.txt | 20 ++++++-------
 builtin/config.c             | 12 ++++----
 config.c                     | 54 ++++++++++++++++++------------------
 config.h                     |  2 +-
 4 files changed, 44 insertions(+), 44 deletions(-)

diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index 7573160f21..0be5499952 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -9,15 +9,15 @@ git-config - Get and set repository or global options
 SYNOPSIS
 --------
 [verse]
-'git config' [<file-option>] [--type=<type>] [--show-origin] [--show-scope] [-z|--null] name [value [value_regex]]
+'git config' [<file-option>] [--type=<type>] [--show-origin] [--show-scope] [-z|--null] name [value [value-pattern]]
 'git config' [<file-option>] [--type=<type>] --add name value
-'git config' [<file-option>] [--type=<type>] --replace-all name value [value_regex]
-'git config' [<file-option>] [--type=<type>] [--show-origin] [--show-scope] [-z|--null] --get name [value_regex]
-'git config' [<file-option>] [--type=<type>] [--show-origin] [--show-scope] [-z|--null] --get-all name [value_regex]
-'git config' [<file-option>] [--type=<type>] [--show-origin] [--show-scope] [-z|--null] [--name-only] --get-regexp name_regex [value_regex]
+'git config' [<file-option>] [--type=<type>] --replace-all name value [value-pattern]
+'git config' [<file-option>] [--type=<type>] [--show-origin] [--show-scope] [-z|--null] --get name [value-pattern]
+'git config' [<file-option>] [--type=<type>] [--show-origin] [--show-scope] [-z|--null] --get-all name [value-pattern]
+'git config' [<file-option>] [--type=<type>] [--show-origin] [--show-scope] [-z|--null] [--name-only] --get-regexp name_regex [value-pattern]
 'git config' [<file-option>] [--type=<type>] [-z|--null] --get-urlmatch name URL
-'git config' [<file-option>] --unset name [value_regex]
-'git config' [<file-option>] --unset-all name [value_regex]
+'git config' [<file-option>] --unset name [value-pattern]
+'git config' [<file-option>] --unset-all name [value-pattern]
 'git config' [<file-option>] --rename-section old_name new_name
 'git config' [<file-option>] --remove-section name
 'git config' [<file-option>] [--show-origin] [--show-scope] [-z|--null] [--name-only] -l | --list
@@ -33,7 +33,7 @@ escaped.
 
 Multiple lines can be added to an option by using the `--add` option.
 If you want to update or unset an option which can occur on multiple
-lines, a POSIX regexp `value_regex` needs to be given.  Only the
+lines, a POSIX regexp `value-pattern` needs to be given.  Only the
 existing values that match the regexp are updated or unset.  If
 you want to handle the lines that do *not* match the regex, just
 prepend a single exclamation mark in front (see also <<EXAMPLES>>).
@@ -73,11 +73,11 @@ OPTIONS
 
 --replace-all::
 	Default behavior is to replace at most one line. This replaces
-	all lines matching the key (and optionally the value_regex).
+	all lines matching the key (and optionally the `value-pattern`).
 
 --add::
 	Adds a new line to the option without altering any existing
-	values.  This is the same as providing '^$' as the value_regex
+	values.  This is the same as providing '^$' as the `value-pattern`
 	in `--replace-all`.
 
 --get::
diff --git a/builtin/config.c b/builtin/config.c
index e7c7f3d455..9d97091561 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -130,14 +130,14 @@ static struct option builtin_config_options[] = {
 	OPT_STRING('f', "file", &given_config_source.file, N_("file"), N_("use given config file")),
 	OPT_STRING(0, "blob", &given_config_source.blob, N_("blob-id"), N_("read config from given blob object")),
 	OPT_GROUP(N_("Action")),
-	OPT_BIT(0, "get", &actions, N_("get value: name [value-regex]"), ACTION_GET),
-	OPT_BIT(0, "get-all", &actions, N_("get all values: key [value-regex]"), ACTION_GET_ALL),
-	OPT_BIT(0, "get-regexp", &actions, N_("get values for regexp: name-regex [value-regex]"), ACTION_GET_REGEXP),
+	OPT_BIT(0, "get", &actions, N_("get value: name [value-pattern]"), ACTION_GET),
+	OPT_BIT(0, "get-all", &actions, N_("get all values: key [value-pattern]"), ACTION_GET_ALL),
+	OPT_BIT(0, "get-regexp", &actions, N_("get values for regexp: name-regex [value-pattern]"), ACTION_GET_REGEXP),
 	OPT_BIT(0, "get-urlmatch", &actions, N_("get value specific for the URL: section[.var] URL"), ACTION_GET_URLMATCH),
-	OPT_BIT(0, "replace-all", &actions, N_("replace all matching variables: name value [value_regex]"), ACTION_REPLACE_ALL),
+	OPT_BIT(0, "replace-all", &actions, N_("replace all matching variables: name value [value-pattern]"), ACTION_REPLACE_ALL),
 	OPT_BIT(0, "add", &actions, N_("add a new variable: name value"), ACTION_ADD),
-	OPT_BIT(0, "unset", &actions, N_("remove a variable: name [value-regex]"), ACTION_UNSET),
-	OPT_BIT(0, "unset-all", &actions, N_("remove all matches: name [value-regex]"), ACTION_UNSET_ALL),
+	OPT_BIT(0, "unset", &actions, N_("remove a variable: name [value-pattern]"), ACTION_UNSET),
+	OPT_BIT(0, "unset-all", &actions, N_("remove all matches: name [value-pattern]"), ACTION_UNSET_ALL),
 	OPT_BIT(0, "rename-section", &actions, N_("rename section: old-name new-name"), ACTION_RENAME_SECTION),
 	OPT_BIT(0, "remove-section", &actions, N_("remove a section: name"), ACTION_REMOVE_SECTION),
 	OPT_BIT('l', "list", &actions, N_("list all"), ACTION_LIST),
diff --git a/config.c b/config.c
index f34a11d94b..ac6aace166 100644
--- a/config.c
+++ b/config.c
@@ -2402,7 +2402,7 @@ struct config_store_data {
 	size_t baselen;
 	char *key;
 	int do_not_match;
-	regex_t *value_regex;
+	regex_t *value_pattern;
 	int multi_replace;
 	struct {
 		size_t begin, end;
@@ -2416,10 +2416,10 @@ struct config_store_data {
 static void config_store_data_clear(struct config_store_data *store)
 {
 	free(store->key);
-	if (store->value_regex != NULL &&
-	    store->value_regex != CONFIG_REGEX_NONE) {
-		regfree(store->value_regex);
-		free(store->value_regex);
+	if (store->value_pattern != NULL &&
+	    store->value_pattern != CONFIG_REGEX_NONE) {
+		regfree(store->value_pattern);
+		free(store->value_pattern);
 	}
 	free(store->parsed);
 	free(store->seen);
@@ -2431,13 +2431,13 @@ static int matches(const char *key, const char *value,
 {
 	if (strcmp(key, store->key))
 		return 0; /* not ours */
-	if (!store->value_regex)
+	if (!store->value_pattern)
 		return 1; /* always matches */
-	if (store->value_regex == CONFIG_REGEX_NONE)
+	if (store->value_pattern == CONFIG_REGEX_NONE)
 		return 0; /* never matches */
 
 	return store->do_not_match ^
-		(value && !regexec(store->value_regex, value, 0, NULL, 0));
+		(value && !regexec(store->value_pattern, value, 0, NULL, 0));
 }
 
 static int store_aux_event(enum config_event_t type,
@@ -2713,8 +2713,8 @@ void git_config_set(const char *key, const char *value)
 
 /*
  * If value==NULL, unset in (remove from) config,
- * if value_regex!=NULL, disregard key/value pairs where value does not match.
- * if value_regex==CONFIG_REGEX_NONE, do not match any existing values
+ * if value_pattern!=NULL, disregard key/value pairs where value does not match.
+ * if value_pattern==CONFIG_REGEX_NONE, do not match any existing values
  *     (only add a new one)
  * if flags contains the CONFIG_FLAGS_MULTI_REPLACE flag, all matching
  *     key/values are removed before a single new pair is written. If the
@@ -2738,7 +2738,7 @@ void git_config_set(const char *key, const char *value)
  */
 int git_config_set_multivar_in_file_gently(const char *config_filename,
 					   const char *key, const char *value,
-					   const char *value_regex,
+					   const char *value_pattern,
 					   unsigned flags)
 {
 	int fd = -1, in_fd = -1;
@@ -2799,22 +2799,22 @@ int git_config_set_multivar_in_file_gently(const char *config_filename,
 		int i, new_line = 0;
 		struct config_options opts;
 
-		if (value_regex == NULL)
-			store.value_regex = NULL;
-		else if (value_regex == CONFIG_REGEX_NONE)
-			store.value_regex = CONFIG_REGEX_NONE;
+		if (value_pattern == NULL)
+			store.value_pattern = NULL;
+		else if (value_pattern == CONFIG_REGEX_NONE)
+			store.value_pattern = CONFIG_REGEX_NONE;
 		else {
-			if (value_regex[0] == '!') {
+			if (value_pattern[0] == '!') {
 				store.do_not_match = 1;
-				value_regex++;
+				value_pattern++;
 			} else
 				store.do_not_match = 0;
 
-			store.value_regex = (regex_t*)xmalloc(sizeof(regex_t));
-			if (regcomp(store.value_regex, value_regex,
+			store.value_pattern = (regex_t*)xmalloc(sizeof(regex_t));
+			if (regcomp(store.value_pattern, value_pattern,
 					REG_EXTENDED)) {
-				error(_("invalid pattern: %s"), value_regex);
-				FREE_AND_NULL(store.value_regex);
+				error(_("invalid pattern: %s"), value_pattern);
+				FREE_AND_NULL(store.value_pattern);
 				ret = CONFIG_INVALID_PATTERN;
 				goto out_free;
 			}
@@ -2984,10 +2984,10 @@ int git_config_set_multivar_in_file_gently(const char *config_filename,
 
 void git_config_set_multivar_in_file(const char *config_filename,
 				     const char *key, const char *value,
-				     const char *value_regex, unsigned flags)
+				     const char *value_pattern, unsigned flags)
 {
 	if (!git_config_set_multivar_in_file_gently(config_filename, key, value,
-						    value_regex, flags))
+						    value_pattern, flags))
 		return;
 	if (value)
 		die(_("could not set '%s' to '%s'"), key, value);
@@ -2996,16 +2996,16 @@ void git_config_set_multivar_in_file(const char *config_filename,
 }
 
 int git_config_set_multivar_gently(const char *key, const char *value,
-				   const char *value_regex, unsigned flags)
+				   const char *value_pattern, unsigned flags)
 {
-	return git_config_set_multivar_in_file_gently(NULL, key, value, value_regex,
+	return git_config_set_multivar_in_file_gently(NULL, key, value, value_pattern,
 						      flags);
 }
 
 void git_config_set_multivar(const char *key, const char *value,
-			     const char *value_regex, unsigned flags)
+			     const char *value_pattern, unsigned flags)
 {
-	git_config_set_multivar_in_file(NULL, key, value, value_regex,
+	git_config_set_multivar_in_file(NULL, key, value, value_pattern,
 					flags);
 }
 
diff --git a/config.h b/config.h
index 58726c34d6..8ad1085b74 100644
--- a/config.h
+++ b/config.h
@@ -296,7 +296,7 @@ int git_config_set_multivar_in_file_gently(const char *, const char *, const cha
 void git_config_set_multivar_in_file(const char *config_filename,
 				     const char *key,
 				     const char *value,
-				     const char *value_regex,
+				     const char *value_pattern,
 				     unsigned flags);
 
 /**
-- 
gitgitgadget

