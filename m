Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E03521F42D
	for <e@80x24.org>; Thu, 26 Apr 2018 04:25:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751405AbeDZEZ3 (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Apr 2018 00:25:29 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:44326 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751390AbeDZEZZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Apr 2018 00:25:25 -0400
Received: by mail-pf0-f194.google.com with SMTP id q22so2217618pff.11
        for <git@vger.kernel.org>; Wed, 25 Apr 2018 21:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=t/WOZAFRIP5c/YKjMKTi58sThhkd4RQ1fiGm4JpnC+I=;
        b=XDocXPLVYMJ4scbBW31GAZ2QrYnXIVG8Auir7JHskbuoOif+dfN0bIGM9SFowNJhEY
         3KpAkoogtOBPJfZbvEupjn8jecvmnwxPdrl3nGuspvIkrtRyubObOeta04ZuJKz3gmiH
         kkgmEKF4mZdGqUxKT7ilQw9ypVximVet+u8pMuHkDyPlvlZYjGs4+oP4icpw0HBFHGEg
         wjLDN5Bx2IpOR8Z1X9LMYmnNT7fhZIxDVzo9r0Si+vS7klM/t3hfBHAbi8+BNU4qbJyg
         iHKMDP0KUlhWbopFCjANMJiOc8Qojo5dQZSFHxFpfT/9GSuNHNvQhgyG+doqu4Xah/VV
         RJ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=t/WOZAFRIP5c/YKjMKTi58sThhkd4RQ1fiGm4JpnC+I=;
        b=nRwOMGJfz3kCIljje6iGbYIHNQh8OUXI6YAjOTZAz+sRYYubObquM9AsdKJ8u8tCiB
         hyuxbiXZL81GegQFs6MEB7nBXCgrHFb175ezqjAUEfMmRVlalMv2UI/BnLt7j5KFBSdG
         2LDyYbRUUdVAqH1AAiMfwF8oOVaaa32K6g4W0Ho3tHKpOsJ2r3ON2pCboKqhr9uE3lhX
         dFIz7S53L8i7DfarkmcTrVaFxZsbrZOXRyrP9nvs/YeCTQWflYPYHIr2PZrVYcArIGGu
         +s113aoEaqBaX/x00++WEoLl4WFm9iBw5b2yQ0oEvXzGUxJzv0ncvI5yGDuY3lyofiOy
         T8+A==
X-Gm-Message-State: ALQs6tDERVSUvFDfWAtLMJ63CZEHx/ICbA/P9QF8SZpfEkH3RlGHbwbf
        u6emcL+/qMHsCATdW6LgdXQ6E/jb/Wg=
X-Google-Smtp-Source: AIpwx49It6op8m1vVgxtl/TkH7zcy/NbwngAAhU5tuXTBcm1NSXbfkKAADJbBAIA63YxCGMSGkxaFw==
X-Received: by 2002:a17:902:8:: with SMTP id 8-v6mr31585211pla.287.1524716724570;
        Wed, 25 Apr 2018 21:25:24 -0700 (PDT)
Received: from localhost ([2601:602:9500:1120:b5ff:86d4:d359:c7bd])
        by smtp.gmail.com with ESMTPSA id t11sm31180802pgn.94.2018.04.25.21.25.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Apr 2018 21:25:23 -0700 (PDT)
Date:   Wed, 25 Apr 2018 21:25:22 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com
Subject: [PATCH 2/5] builtin/config.c: support `--type=<type>` as preferred
 alias for `--type`
Message-ID: <1bc42a611089a2552b1d8bc83ff229be0a5136ff.1524716420.git.me@ttaylorr.com>
References: <cover.1524716420.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1524716420.git.me@ttaylorr.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

`git config` has long allowed the ability for callers to provide a 'type
specifier', which instructs `git config` to (1) ensure that incoming
values can be interpreted as that type, and (2) that outgoing values are
canonicalized under that type.

In another series, we propose to extend this functionality with
`--type=color` and `--default` to replace `--get-color`.

However, we traditionally use `--color` to mean "colorize this output",
instead of "this value should be treated as a color".

Currently, `git config` does not support this kind of colorization, but
we should be careful to avoid squatting on this option too soon, so that
`git config` can support `--color` (in the traditional sense) in the
future, if that is desired.

In this patch, we support `--type=<int|bool|bool-or-int|...>` in
addition to `--int`, `--bool`, and etc. This allows the aforementioned
upcoming patch to support querying a color value with a default via
`--type=color --default=...`, without squandering `--color`.

We retain the historic behavior of complaining when multiple,
legacy-style `--<type>` flags are given, as well as extend this to
conflicting new-style `--type=<type>` flags. `--int --type=int` (and its
commutative pair) does not complain, but `--bool --type=int` (and its
commutative pair) does.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/git-config.txt | 71 ++++++++++++++++++++----------------
 builtin/config.c             | 66 ++++++++++++++++++++++++++++++---
 t/t1300-repo-config.sh       | 58 +++++++++++++++++++++++++++--
 3 files changed, 155 insertions(+), 40 deletions(-)

diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index e09ed5d7d5..b759009c75 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -9,13 +9,13 @@ git-config - Get and set repository or global options
 SYNOPSIS
 --------
 [verse]
-'git config' [<file-option>] [type] [--show-origin] [-z|--null] name [value [value_regex]]
-'git config' [<file-option>] [type] --add name value
-'git config' [<file-option>] [type] --replace-all name value [value_regex]
-'git config' [<file-option>] [type] [--show-origin] [-z|--null] --get name [value_regex]
-'git config' [<file-option>] [type] [--show-origin] [-z|--null] --get-all name [value_regex]
-'git config' [<file-option>] [type] [--show-origin] [-z|--null] [--name-only] --get-regexp name_regex [value_regex]
-'git config' [<file-option>] [type] [-z|--null] --get-urlmatch name URL
+'git config' [<file-option>] [--type=<type>] [--show-origin] [-z|--null] name [value [value_regex]]
+'git config' [<file-option>] [--type=<type>] --add name value
+'git config' [<file-option>] [--type=<type>] --replace-all name value [value_regex]
+'git config' [<file-option>] [--type=<type>] [--show-origin] [-z|--null] --get name [value_regex]
+'git config' [<file-option>] [--type=<type>] [--show-origin] [-z|--null] --get-all name [value_regex]
+'git config' [<file-option>] [--type=<type>] [--show-origin] [-z|--null] [--name-only] --get-regexp name_regex [value_regex]
+'git config' [<file-option>] [--type=<type>] [-z|--null] --get-urlmatch name URL
 'git config' [<file-option>] --unset name [value_regex]
 'git config' [<file-option>] --unset-all name [value_regex]
 'git config' [<file-option>] --rename-section old_name new_name
@@ -38,12 +38,10 @@ existing values that match the regexp are updated or unset.  If
 you want to handle the lines that do *not* match the regex, just
 prepend a single exclamation mark in front (see also <<EXAMPLES>>).
 
-The type specifier can be either `--int` or `--bool`, to make
-'git config' ensure that the variable(s) are of the given type and
-convert the value to the canonical form (simple decimal number for int,
-a "true" or "false" string for bool), or `--path`, which does some
-path expansion (see `--path` below).  If no type specifier is passed, no
-checks or transformations are performed on the value.
+The `--type=<type>` option instructs 'git config' to ensure that incoming and
+outgoing values are canonicalize-able under the given <type>.  If no
+`--type=<type>` is given, no canonicalization will be performed. Callers may
+unset an existing `--type` specifier with `--no-type`.
 
 When reading, the values are read from the system, global and
 repository local configuration files by default, and options
@@ -160,30 +158,39 @@ See also <<FILES>>.
 --list::
 	List all variables set in config file, along with their values.
 
---bool::
-	'git config' will ensure that the output is "true" or "false"
+--type <type>::
+  'git config' will ensure that any input or output is valid under the given
+  type constraint(s), and will canonicalize outgoing values in `<type>`'s
+  canonical form.
++
+Valid `<type>`'s include:
++
+- 'bool': canonicalize values as either "true" or "false".
+- 'int': canonicalize values as simple decimal numbers. An optional suffix of
+  'k', 'm', or 'g' will cause the value to be multiplied by 1024, 1048576, or
+  1073741824 upon input.
+- 'bool-or-int': canonicalize according to either 'bool' or 'int', as described
+  above.
+- 'path': canonicalize by adding a leading `~` to the value of `$HOME` and
+  `~user` to the home directory for the specified user. This specifier has no
+  effect when setting the value (but you can use `git config section.variable
+  ~/` from the command line to let your shell do the expansion.)
+- 'expiry-date': canonicalize by converting from a fixed or relative date-string
+  to a timestamp. This specifier has no effect when setting the value.
++
 
+--bool::
 --int::
-	'git config' will ensure that the output is a simple
-	decimal number.  An optional value suffix of 'k', 'm', or 'g'
-	in the config file will cause the value to be multiplied
-	by 1024, 1048576, or 1073741824 prior to output.
-
 --bool-or-int::
-	'git config' will ensure that the output matches the format of
-	either --bool or --int, as described above.
-
 --path::
-	`git config` will expand a leading `~` to the value of
-	`$HOME`, and `~user` to the home directory for the
-	specified user.  This option has no effect when setting the
-	value (but you can use `git config section.variable ~/`
-	from the command line to let your shell do the expansion).
-
 --expiry-date::
-	`git config` will ensure that the output is converted from
-	a fixed or relative date-string to a timestamp. This option
-	has no effect when setting the value.
+  Historical options for selecting a type specifier. Prefer instead `--type`,
+  (see: above).
+
+--no-type::
+  Un-sets the previously set type specifier (if one was previously set). This
+  option requests that 'git config' not canonicalize the retrieved variable.
+  `--no-type` has no effect without `--type=<type>` or `--<type>`.
 
 -z::
 --null::
diff --git a/builtin/config.c b/builtin/config.c
index 92fb8d56b1..2f91ef15a4 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -61,6 +61,61 @@ static int show_origin;
 #define TYPE_PATH		4
 #define TYPE_EXPIRY_DATE	5
 
+#define OPT_CALLBACK_VALUE(s, l, v, h, i) \
+	{ OPTION_CALLBACK, (s), (l), (v), NULL, (h), PARSE_OPT_NOARG | \
+	PARSE_OPT_NONEG, option_parse_type, (i) }
+
+static struct option builtin_config_options[];
+
+static int option_parse_type(const struct option *opt, const char *arg,
+			     int unset)
+{
+	int new_type;
+	int *to_type;
+
+	if (unset) {
+		*((int *) opt->value) = 0;
+		return 0;
+	}
+
+	/*
+	 * To support '--<type>' style flags, begin with new_type equal to
+	 * opt->defval.
+	 */
+	new_type = opt->defval;
+	if (!new_type) {
+		if (!strcmp(arg, "bool"))
+			new_type = TYPE_BOOL;
+		else if (!strcmp(arg, "int"))
+			new_type = TYPE_INT;
+		else if (!strcmp(arg, "bool-or-int"))
+			new_type = TYPE_BOOL_OR_INT;
+		else if (!strcmp(arg, "path"))
+			new_type = TYPE_PATH;
+		else if (!strcmp(arg, "expiry-date"))
+			new_type = TYPE_EXPIRY_DATE;
+		else
+			die(_("unrecognized --type argument, %s"), arg);
+	}
+
+	*to_type = opt->value;
+	if (*to_type && *to_type != new_type) {
+		/*
+		 * Complain when there is a new type not equal to the old type.
+		 * This allows for combinations like '--int --type=int' and
+		 * '--type=int --type=int', but disallows ones like '--type=bool
+		 * --int' and '--type=bool
+		 * --type=int'.
+		 */
+		error("only one type at a time.");
+		usage_with_options(builtin_config_usage,
+			builtin_config_options);
+	}
+	*to_type = new_type;
+
+	return 0;
+}
+
 static struct option builtin_config_options[] = {
 	OPT_GROUP(N_("Config file location")),
 	OPT_BOOL(0, "global", &use_global_config, N_("use global config file")),
@@ -84,11 +139,12 @@ static struct option builtin_config_options[] = {
 	OPT_BIT(0, "get-color", &actions, N_("find the color configured: slot [default]"), ACTION_GET_COLOR),
 	OPT_BIT(0, "get-colorbool", &actions, N_("find the color setting: slot [stdout-is-tty]"), ACTION_GET_COLORBOOL),
 	OPT_GROUP(N_("Type")),
-	OPT_SET_INT(0, "bool", &type, N_("value is \"true\" or \"false\""), TYPE_BOOL),
-	OPT_SET_INT(0, "int", &type, N_("value is decimal number"), TYPE_INT),
-	OPT_SET_INT(0, "bool-or-int", &type, N_("value is --bool or --int"), TYPE_BOOL_OR_INT),
-	OPT_SET_INT(0, "path", &type, N_("value is a path (file or directory name)"), TYPE_PATH),
-	OPT_SET_INT(0, "expiry-date", &type, N_("value is an expiry date"), TYPE_EXPIRY_DATE),
+	OPT_CALLBACK('t', "type", &type, "", N_("value is given this type"), option_parse_type),
+	OPT_CALLBACK_VALUE(0, "bool", &type, N_("value is \"true\" or \"false\""), TYPE_BOOL),
+	OPT_CALLBACK_VALUE(0, "int", &type, N_("value is decimal number"), TYPE_INT),
+	OPT_CALLBACK_VALUE(0, "bool-or-int", &type, N_("value is --bool or --int"), TYPE_BOOL_OR_INT),
+	OPT_CALLBACK_VALUE(0, "path", &type, N_("value is a path (file or directory name)"), TYPE_PATH),
+	OPT_CALLBACK_VALUE(0, "expiry-date", &type, N_("value is an expiry date"), TYPE_EXPIRY_DATE),
 	OPT_GROUP(N_("Other")),
 	OPT_BOOL('z', "null", &end_null, N_("terminate values with NUL byte")),
 	OPT_BOOL(0, "name-only", &omit_values, N_("show variable names only")),
diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index ed9b9cd344..1e3a1ace14 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -1613,13 +1613,65 @@ test_expect_success '--local requires a repo' '
 
 cat >.git/config <<-\EOF &&
 [core]
+foo = true
 number = 10
+big = 1M
 EOF
 
-test_expect_success 'later legacy specifiers are given precedence' '
-	git config --bool --int core.number >actual &&
-	echo 10 >expect &&
+test_expect_success 'identical modern --type specifiers are allowed' '
+	git config --type=int --type=int core.big >actual &&
+	echo 1048576 >expect &&
 	test_cmp expect actual
 '
 
+test_expect_success 'identical legacy --type specifiers are allowed' '
+	git config --int --int core.big >actual &&
+	echo 1048576 >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'identical mixed --type specifiers are allowed' '
+	git config --int --type=int core.big >actual &&
+	echo 1048576 >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'non-identical modern --type specifiers are not allowed' '
+	test_must_fail git config --type=int --type=bool core.big 2>error &&
+	test_i18ngrep "only one type at a time" error
+'
+
+test_expect_success 'non-identical legacy --type specifiers are not allowed' '
+	test_must_fail git config --int --bool core.big 2>error &&
+	test_i18ngrep "only one type at a time" error
+'
+
+test_expect_success 'non-identical mixed --type specifiers are not allowed' '
+	test_must_fail git config --type=int --bool core.big 2>error &&
+	test_i18ngrep "only one type at a time" error
+'
+
+test_expect_success '--type allows valid type specifiers' '
+	echo "true" >expect &&
+	git config --type=bool core.foo >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success '--no-type unsets type specifiers' '
+	echo "10" >expect &&
+	git config --type=bool --no-type core.number >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'unset type specifiers may be reset to conflicting ones' '
+	echo 1048576 >expect &&
+	git config --type=bool --no-type --type=int core.big >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success '--type rejects unknown specifiers' '
+	test_must_fail git config --type=nonsense core.foo 2>error &&
+	test_i18ngrep "unrecognized --type argument" error
+'
+
 test_done
-- 
2.17.0

