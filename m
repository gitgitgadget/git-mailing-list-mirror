Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F4C11F404
	for <e@80x24.org>; Fri, 30 Mar 2018 05:28:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751259AbeC3F2l (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Mar 2018 01:28:41 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:33986 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751017AbeC3F2k (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Mar 2018 01:28:40 -0400
Received: by mail-it0-f66.google.com with SMTP id z7-v6so751343iti.1
        for <git@vger.kernel.org>; Thu, 29 Mar 2018 22:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bgtyX9FHxMFLQ/Kx1jLY8MFwSFiwAH2zdFq/ckLQPtE=;
        b=W3Ks3+2Q0J+E1aINEIckYmsc1T9j0TJZMu1bICql1om52LslNv7gGRXRizdjTtfkR7
         94whCAsWOuS8JcWFSYGuVBoXBCU+XC+VhKgCMFnyXPQDnym+B6dKrPSXG4wP0AgbVCHV
         61ku0CU2kNsIYyeNSxVisUamEaI3rpJGItd5rfwEBMzNoShd+QQChIsPPmvGEEfRg6Cy
         n2M1jt/lUrTNYnEyg5USxh8JwY2t10yvv33b0fqtxrsMeT61YHL1fHfkGohAbiwsmHuC
         gt75nOYWb5UlCiqm4jJ2C4X/dxQWx85ElF2EsPzmAAV/qXuDSADhTGMwEqMTUx1JWVCq
         8eLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bgtyX9FHxMFLQ/Kx1jLY8MFwSFiwAH2zdFq/ckLQPtE=;
        b=gl4vkXF+QYCv58+BqXDulKN5J91xTtB+lEMvUNvG8Q2RYAtc1ERyT2poqZWhkuo1l2
         WgAhx52PkOd9jyudxSL40smX9Uv5S5IMM4bfvLpbTXPuMMvQgxKOY2tm4mkmsdtSGDSA
         FUMdYofevObUAHDSTI6MuZV2lr4v7ZCX2pjJ1atfs/aWULGhVFrP3EnJKJs0Sav6X95N
         F1hYMWP8q/R9CLamUE+UlykfKKHJiqHpHiu0DS8spPrqBR6ZzFpmJOGcfOkn+tDdbN1Q
         g99AWDgccbt+5d+4/IoZczxw8huuS8n+45gaNO6ycB3ZTgHil85H+LyE45tFR2Nk8qOU
         /4Yg==
X-Gm-Message-State: ALQs6tBtP/nOfkwbqDCV+SESgUHPdEWWr5a/0/wlIM8nKsiye4JFVS8y
        QuS8NIx4LTm3alfqu6w+gbK7rA==
X-Google-Smtp-Source: AIpwx499tQo/+lC39IJFDC3c7w//MCoM4/kfRRUwrdaGXEfv6Rz3k5AKOwzzwZXP57xV7fChYqTKKA==
X-Received: by 2002:a24:3093:: with SMTP id q141-v6mr1623296itq.21.1522387719238;
        Thu, 29 Mar 2018 22:28:39 -0700 (PDT)
Received: from localhost ([2601:401:c500:7dd8:1cc3:31e8:a3ff:d05])
        by smtp.gmail.com with ESMTPSA id 188sm4676004iov.11.2018.03.29.22.28.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Mar 2018 22:28:38 -0700 (PDT)
From:   Taylor Blau <me@ttaylorr.com>
To:     peff@peff.net, gitster@pobox.com
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v2 2/2] builtin/config.c: prefer `--type=bool` over `--bool`, etc.
Date:   Fri, 30 Mar 2018 01:28:30 -0400
Message-Id: <20180330052830.57251-2-me@ttaylorr.com>
X-Mailer: git-send-email 2.16.2.440.gc6284da4f
In-Reply-To: <20180330052830.57251-1-me@ttaylorr.com>
References: <20180328234719.595-1-me@ttaylorr.com>
 <20180330052830.57251-1-me@ttaylorr.com>
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
`--int`, `--bool`, and etc. This allows the aforementioned other patch
to add `--color` (in the non-traditional sense) via `--type=color`,
instead of `--color`.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/git-config.txt | 66 +++++++++++++++++++-----------------
 builtin/config.c             | 23 +++++++++++++
 t/t1300-repo-config.sh       | 18 ++++++++++
 3 files changed, 75 insertions(+), 32 deletions(-)

diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index e09ed5d7d..9956b03f7 100644
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
+--type [type]::
+  'git config' will ensure that any input output is valid under the given type
+  constraint(s), and will canonicalize outgoing values in `[type]`'s canonical
+  form.
++
+Valid `[type]`'s include:
++
+- 'bool': canonicalize  values as either "true" or "false".
+- 'int': canonicalize  values as simple decimla numbers. An optional suffix of
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
index fd7b36c41..8833f928a 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -61,6 +61,28 @@ static int show_origin;
 #define TYPE_PATH (1<<3)
 #define TYPE_EXPIRY_DATE (1<<4)
 
+static int option_parse_type(const struct option *opt, const char *arg,
+			     int unset)
+{
+	int *type = opt->value;
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
+		die(_("unexpected --type argument, %s"), arg);
+		return 1;
+	}
+	return 0;
+}
+
 static struct option builtin_config_options[] = {
 	OPT_GROUP(N_("Config file location")),
 	OPT_BOOL(0, "global", &use_global_config, N_("use global config file")),
@@ -84,6 +106,7 @@ static struct option builtin_config_options[] = {
 	OPT_BIT(0, "get-color", &actions, N_("find the color configured: slot [default]"), ACTION_GET_COLOR),
 	OPT_BIT(0, "get-colorbool", &actions, N_("find the color setting: slot [stdout-is-tty]"), ACTION_GET_COLORBOOL),
 	OPT_GROUP(N_("Type")),
+	OPT_CALLBACK('t', "type", &type, N_("type"), N_("value is given this type"), option_parse_type),
 	OPT_SET_INT(0, "bool", &type, N_("value is \"true\" or \"false\""), TYPE_BOOL),
 	OPT_SET_INT(0, "int", &type, N_("value is decimal number"), TYPE_INT),
 	OPT_SET_INT(0, "bool-or-int", &type, N_("value is --bool or --int"), TYPE_BOOL_OR_INT),
diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index aa45b9267..8c5210fdf 100755
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
+test_expect_success '--type rejects unknown specifiers' '
+	test_must_fail git config --type=nonsense core.foo 2>error &&
+	test_i18ngrep "unexpected --type argument" error
+'
+
+test_expect_success 'later legacy specifiers are given precedence' '
+	git config --bool --int core.number >actual &&
+	echo 10 > expect &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.16.2.440.gc6284da4f

