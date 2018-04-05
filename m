Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 628DF1F404
	for <e@80x24.org>; Thu,  5 Apr 2018 02:02:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752745AbeDECCm (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Apr 2018 22:02:42 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:35683 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752677AbeDECCl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Apr 2018 22:02:41 -0400
Received: by mail-pl0-f67.google.com with SMTP id 61-v6so14961175plb.2
        for <git@vger.kernel.org>; Wed, 04 Apr 2018 19:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OReXN/taI2a61vyADs9MgKH6/jxvXGI8fISj08/sXAs=;
        b=T9uKEV97bQy5wilehmc6Q53Nf5QRgFjTg5mKFdY7ByH/FFuM+lU8VzGJSDWf6Dj2YX
         dYqAAfx7Tl/W2mCCmAdWH1Zha0mYm8fVrokvNKP1nwq3VXJ61ZC7UeH3jyGL4B/olS0b
         Nfx+uSh8i8tKT7GUJ94oDAN8pvOyMJ0i1pI6eZfcxUtc6uW7yxPoxL/rRSp7W0svhEUk
         ISWYDPmE/vXqU4CZarNBeIAxqg7rbMm50SiauzsViXcMGMYhZ3KgY/qor2i6u+qBxsMn
         UT/oJn92zjvTBot+ozUwC9B+lh667iZfWqbnzNi9nKuXiIMKd4Lt26ew3X9CSE1oB2ft
         veGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OReXN/taI2a61vyADs9MgKH6/jxvXGI8fISj08/sXAs=;
        b=B1kvEMePC5fmY5esJmBy1azt6hp7ilsKL9Z0L45bj811G/FFwXSVsaKHoIQGrDku2l
         q2vbXjuFZ/RHn/d5GxaPR0CLh3E9o6FUjcxh257NXV8wuhtD5QjGOe/jhs5GJdONsJHT
         cgPoVy1vsxdcczz0nJRjkpe8SIj054m3N7FfVvqXsmYw1QCxDK0kq3Q9mR5wNoC48Oqz
         PkDsuDypAvLRAEl6uq3qPHtD6xrMu++n7p8PE6kcmiJOYbDFBqUW2u7Rdy5XCkDUqGhc
         OqqefyEm7l7jH1FmFpwZ27+s4JLckdOZvL0HWEzpGhXBGnvmgk2yFqRRJHxNzovgxeak
         XWkQ==
X-Gm-Message-State: AElRT7FlgTaddz+aAEs6u4WgFYEVeAFGHxa2ZP+tRVLMQ3ExLN8X4wy/
        WWnIYjEi0SQ30yVCpfCM3xF/3s8ugWdZgQ==
X-Google-Smtp-Source: AIpwx48bBRk/Ygpfkx80ht3Ydllugz/ev540+xvXwuTuscvxE0oHPwl0YCCkAYm4fXg2IfH0ryA4Gw==
X-Received: by 2002:a17:902:1e5:: with SMTP id b92-v6mr20709553plb.78.1522893760124;
        Wed, 04 Apr 2018 19:02:40 -0700 (PDT)
Received: from localhost ([2601:602:9500:3a4f:dc75:c2ae:e99:b3d1])
        by smtp.gmail.com with ESMTPSA id a65sm13382639pfg.170.2018.04.04.19.02.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Apr 2018 19:02:38 -0700 (PDT)
Date:   Wed, 4 Apr 2018 19:02:38 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, sunshine@sunshineco.com, gitster@pobox.com,
        me@ttaylorr.com
Subject: [PATCH v4 2/2] builtin/config.c: prefer `--type=bool` over `--bool`,
 etc.
Message-ID: <20180405020238.GD8879@syl.local>
References: <20180328234719.595-1-me@ttaylorr.com>
 <cover.1522893363.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1522893363.git.me@ttaylorr.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

`git config` has long allowed the ability for callers to provide a 'type
specifier', which instructs `git config` to (1) ensure that incoming
values are satisfiable under that type, and (2) that outgoing values are
canonicalized under that type.

In another series, we propose to add extend this functionality with
`--color` and `--default` to replace `--get-color`.

However, we traditionally use `--color` to mean "colorize this output",
instead of "this value should be treated as a color".

Currently, `git config` does not support this kind of colorization, but
we should be careful to avoid inhabiting this option too soon, so that
`git config` can support `--color` (in the traditional sense) in the
future, if that is desired.

In this patch, we prefer `--type=[int|bool|bool-or-int|...]` over
`--int`, `--bool`, and etc. This allows the aforementioned upcoming
patch to support querying a color value with a default via `--type=color
--default=....`

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/git-config.txt | 66 +++++++++++++++++++-----------------
 builtin/config.c             | 28 +++++++++++++++
 t/t1300-repo-config.sh       | 18 ++++++++++
 3 files changed, 80 insertions(+), 32 deletions(-)

diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index e09ed5d7d..c7e56e3fd 100644
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
+'git config' [<file-option>] [--type] [--show-origin] [-z|--null] name [value [value_regex]]
+'git config' [<file-option>] [--type] --add name value
+'git config' [<file-option>] [--type] --replace-all name value [value_regex]
+'git config' [<file-option>] [--type] [--show-origin] [-z|--null] --get name [value_regex]
+'git config' [<file-option>] [--type] [--show-origin] [-z|--null] --get-all name [value_regex]
+'git config' [<file-option>] [--type] [--show-origin] [-z|--null] [--name-only] --get-regexp name_regex [value_regex]
+'git config' [<file-option>] [--type] [-z|--null] --get-urlmatch name URL
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
+A type specifier may be given as an argument to `--type` to make 'git config'
+ensure that the variable(s) are of the given type and convert the value to the
+canonical form. If no type specifier is passed, no checks or transformations are
+performed on the value.
 
 When reading, the values are read from the system, global and
 repository local configuration files by default, and options
@@ -160,30 +158,34 @@ See also <<FILES>>.
 --list::
 	List all variables set in config file, along with their values.
 
---bool::
-	'git config' will ensure that the output is "true" or "false"
+--type <type>::
+  'git config' will ensure that any input output is valid under the given type
+  constraint(s), and will canonicalize outgoing values in `<type>`'s canonical
+  form.
++
+Valid `<type>`'s include:
++
+- 'bool': canonicalize values as either "true" or "false".
+- 'int': canonicalize values as simple decimal numbers. An optional suffix of
+  'k', 'm', or 'g' will cause the value to be multiplied by 1024, 1048576, or
+  1073741824 prior to output.
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
 
 -z::
 --null::
diff --git a/builtin/config.c b/builtin/config.c
index 92fb8d56b..6e1495eac 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -61,6 +61,33 @@ static int show_origin;
 #define TYPE_PATH		4
 #define TYPE_EXPIRY_DATE	5
 
+static int option_parse_type(const struct option *opt, const char *arg,
+			     int unset)
+{
+	int *type = opt->value;
+
+	if (unset) {
+		*type = 0;
+		return 0;
+	}
+
+	if (!strcmp(arg, "bool"))
+		*type = TYPE_BOOL;
+	else if (!strcmp(arg, "int"))
+		*type = TYPE_INT;
+	else if (!strcmp(arg, "bool-or-int"))
+		*type = TYPE_BOOL_OR_INT;
+	else if (!strcmp(arg, "path"))
+		*type = TYPE_PATH;
+	else if (!strcmp(arg, "expiry-date"))
+		*type = TYPE_EXPIRY_DATE;
+	else {
+		die(_("unrecognized --type argument, %s"), arg);
+		return 1;
+	}
+	return 0;
+}
+
 static struct option builtin_config_options[] = {
 	OPT_GROUP(N_("Config file location")),
 	OPT_BOOL(0, "global", &use_global_config, N_("use global config file")),
@@ -84,6 +111,7 @@ static struct option builtin_config_options[] = {
 	OPT_BIT(0, "get-color", &actions, N_("find the color configured: slot [default]"), ACTION_GET_COLOR),
 	OPT_BIT(0, "get-colorbool", &actions, N_("find the color setting: slot [stdout-is-tty]"), ACTION_GET_COLORBOOL),
 	OPT_GROUP(N_("Type")),
+	OPT_CALLBACK('t', "type", &type, N_("type"), N_("value is given this type"), option_parse_type),
 	OPT_SET_INT(0, "bool", &type, N_("value is \"true\" or \"false\""), TYPE_BOOL),
 	OPT_SET_INT(0, "int", &type, N_("value is decimal number"), TYPE_INT),
 	OPT_SET_INT(0, "bool-or-int", &type, N_("value is --bool or --int"), TYPE_BOOL_OR_INT),
diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index 24de37d54..b25ab7b9e 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -1613,6 +1613,7 @@ test_expect_success '--local requires a repo' '
 
 cat >.git/config <<-\EOF &&
 [core]
+foo = true
 number = 10
 EOF
 
@@ -1622,4 +1623,21 @@ test_expect_success 'later legacy specifiers are given precedence' '
 	test_cmp expect actual
 '
 
+test_expect_success '--type allows valid type specifiers' '
+	echo "true" >expect &&
+	git config --type=bool core.foo >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success '--no-type unsets type specifiers' '
+	echo "10" > expect &&
+	git config --type=bool --no-type core.number >actual &&
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
2.16.2.440.gc6284da4f
