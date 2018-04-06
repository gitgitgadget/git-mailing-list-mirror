Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 203E51F424
	for <e@80x24.org>; Fri,  6 Apr 2018 06:39:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751722AbeDFGjT (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Apr 2018 02:39:19 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:44058 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751696AbeDFGjS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Apr 2018 02:39:18 -0400
Received: by mail-pl0-f67.google.com with SMTP id b6-v6so69683pla.11
        for <git@vger.kernel.org>; Thu, 05 Apr 2018 23:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sZOFdCG04FQWtWApAu2e5fMe9HQuX584iQvC1aVRWoM=;
        b=HVX11CSP1pb7+XtxsLuD86WEfkjpzFgeYaOsNwCKaHiAaZM/vLdOBl2PRCbNHBVzwR
         baA9UJCSBb1G2r2Rov2B8+u74YOAt2XNF62l8YBmkh/XKe6xu8ci1NHDbJhJo77YIWDH
         Rfj5j44z1xyKgB01h/UXj5bbE41GqWKiVg40kgclTX8I7EHYmmZhKxo2Vvtr0lvSbl7b
         zFTiiBGWJuIEJzQlRS5NlgizzOVcXQANB9oFI827ON0zAlksJzwGBLIgD1aT4Ukugw/g
         bZpu/Muc23q40P3Q4OZS+XLY3G50VONyjGSbTkjbSO12VOkBQmAcJVHeh4qCEdsVcsj5
         UprA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sZOFdCG04FQWtWApAu2e5fMe9HQuX584iQvC1aVRWoM=;
        b=LXX1fiUdrnQxhp/PP/dZhz3Gcu+i9zOfKyZVSbRLnLPtJz4m0JkCIbvg8RFSx/5XKb
         dvzZrFa5tyREPzFTTrphAgKZJ+HIYmLeV0z1ic9mUxN6MPdb87RfvyqeaVljny+FMmTn
         IXqDBHyOo6Wc7hIIZpANu7lRspPLgr8/MhykqlUkeT3D+5gwW1+8g8ka5AmEC3b+utYF
         cLz2nmRScErJDMT1hEmBOmD7cb+rssVey0RhtUj4Aj/qt1T38QpcXKqqcIvpHQeDunLy
         LxOTLFJdL93DABmIiVtLhqI0v3zDZUsO2LxmHD0BpBcmmq7ElJ22EClhficZ70fk9uSg
         C2zQ==
X-Gm-Message-State: AElRT7H5+4Xue9QbzfqWZtjTvdGSppleXsvnzeZ8F4BsPIIeR6yjHP+B
        iu5DKzoF/L78kOxNUv63b0WmaWEObIo=
X-Google-Smtp-Source: AIpwx48AAAR8X96CYu0UwsccMweg7alOfZt2Fbjm2NCuAxAQ27GCdsMSJZrsPETMdZxld69BGI7pTw==
X-Received: by 2002:a17:902:9a44:: with SMTP id x4-v6mr26123350plv.312.1522996757200;
        Thu, 05 Apr 2018 23:39:17 -0700 (PDT)
Received: from localhost ([2601:602:9500:3a4f:3d01:699f:f606:da49])
        by smtp.gmail.com with ESMTPSA id v186sm17913853pfb.182.2018.04.05.23.39.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Apr 2018 23:39:16 -0700 (PDT)
Date:   Thu, 5 Apr 2018 23:39:15 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, sunshine@sunshineco.com, gitster@pobox.com
Subject: [PATCH v6 2/2] builtin/config.c: support `--type=<type>` as
 preferred alias for `--type`
Message-ID: <20180406063915.GC2908@syl.local>
References: <20180328234719.595-1-me@ttaylorr.com>
 <cover.1522996619.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1522996619.git.me@ttaylorr.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

`git config` has long allowed the ability for callers to provide a 'type
specifier', which instructs `git config` to (1) ensure that incoming
values are satisfiable under that type, and (2) that outgoing values are
canonicalized under that type.

In another series, we propose to extend this functionality with
`--type=color` and `--default` to replace `--get-color`.

However, we traditionally use `--color` to mean "colorize this output",
instead of "this value should be treated as a color".

Currently, `git config` does not support this kind of colorization, but
we should be careful to avoid inhabiting this option too soon, so that
`git config` can support `--type=color` (in the traditional sense) in
the future, if that is desired.

In this patch, we support `--type=<int|bool|bool-or-int|...>` in
addition to `--int`, `--bool`, and etc. This allows the aforementioned
upcoming patch to support querying a color value with a default via
`--type=color --default=...`, without squandering `--color`.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/git-config.txt | 73 ++++++++++++++++++++----------------
 builtin/config.c             | 27 +++++++++++++
 t/t1300-repo-config.sh       | 18 +++++++++
 3 files changed, 86 insertions(+), 32 deletions(-)

diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index e09ed5d7d..b7686fcbe 100644
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
@@ -38,12 +38,12 @@ existing values that match the regexp are updated or unset.  If
 you want to handle the lines that do *not* match the regex, just
 prepend a single exclamation mark in front (see also <<EXAMPLES>>).

-The type specifier can be either `--int` or `--bool`, to make
-'git config' ensure that the variable(s) are of the given type and
-convert the value to the canonical form (simple decimal number for int,
-a "true" or "false" string for bool), or `--path`, which does some
-path expansion (see `--path` below).  If no type specifier is passed, no
-checks or transformations are performed on the value.
+The `--type` option requests 'git config' to ensure that the configured values
+associated with the given variable(s) are of the given type. When given
+`--type`, 'git config' will ensure that the variable(s) are of the given type
+and convert the value to the canonical form. If no type specifier is passed, no
+checks or transformations are performed on the value. Callers may unset any
+pre-existing type specifiers with `--no-type`.

 When reading, the values are read from the system, global and
 repository local configuration files by default, and options
@@ -160,30 +160,39 @@ See also <<FILES>>.
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
+
+--no-type::
+  Un-sets the previously set type specifier (if one was previously set). This
+  option requests that 'git config' not canonicalize the retrieved variable.
+  `--no-type` has no effect without `--type=<type>` or `--<type>`.

 -z::
 --null::
diff --git a/builtin/config.c b/builtin/config.c
index 92fb8d56b..5c8952a17 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -61,6 +61,32 @@ static int show_origin;
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
+	else
+		die(_("unrecognized --type argument, %s"), arg);
+
+	return 0;
+}
+
 static struct option builtin_config_options[] = {
 	OPT_GROUP(N_("Config file location")),
 	OPT_BOOL(0, "global", &use_global_config, N_("use global config file")),
@@ -84,6 +110,7 @@ static struct option builtin_config_options[] = {
 	OPT_BIT(0, "get-color", &actions, N_("find the color configured: slot [default]"), ACTION_GET_COLOR),
 	OPT_BIT(0, "get-colorbool", &actions, N_("find the color setting: slot [stdout-is-tty]"), ACTION_GET_COLORBOOL),
 	OPT_GROUP(N_("Type")),
+	OPT_CALLBACK('t', "type", &type, N_("type"), N_("value is given this type"), option_parse_type),
 	OPT_SET_INT(0, "bool", &type, N_("value is \"true\" or \"false\""), TYPE_BOOL),
 	OPT_SET_INT(0, "int", &type, N_("value is decimal number"), TYPE_INT),
 	OPT_SET_INT(0, "bool-or-int", &type, N_("value is --bool or --int"), TYPE_BOOL_OR_INT),
diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index 24de37d54..f5ae80e9a 100755
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
+	echo "10" >expect &&
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
2.17.0
