Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C637E1F404
	for <e@80x24.org>; Sat, 24 Mar 2018 00:56:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751864AbeCXA4E (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Mar 2018 20:56:04 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:35506 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751745AbeCXA4B (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Mar 2018 20:56:01 -0400
Received: by mail-qt0-f195.google.com with SMTP id s2so14422288qti.2
        for <git@vger.kernel.org>; Fri, 23 Mar 2018 17:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VOo8J4qBz77JoLK58FBIYO/V45r9XlMPiFoe1Yl6wME=;
        b=yyBvpwLRd6K2GUtqfFg2yVsWEl6gqh1EqugsBClYHPwQEFY379ShomOeFbPgKZ9ZhO
         p4Dx7+9gjptm0gXNbEKF03miy9Cuwt51F44vXu3L+ppGLd3WNjaqih+yhopkSnHis5KA
         ruXxISJaat/ULYsBNVe59hbu8LCfjEqVxOG7tHEPLbbNDV3P+XYWJwg9C8K5NMpaRs+J
         nB5+5127+0DRqHBglDTA8KW5eUrqwIiaccBWjUe8PqeF1Cz+vP6WAMGL4nQMT1n4NXMg
         /qtR2TDW/jjDPlGM988BHN4zi6TpJnpDyOfPTxN4/5mAJHalxXckQuWNWdTM6s6fjrzJ
         HPfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VOo8J4qBz77JoLK58FBIYO/V45r9XlMPiFoe1Yl6wME=;
        b=mN5erk6H+YW986roxABKtb7mZLCTtEu3pn0Vrle6yMCQUNDcAqPX9aoSbwyWm4HF4k
         gD0xnlyi66iSvHR35ZbrLQLZIRvJf/PPs1E0NB74XeLqShRls7/968AQ5OCS6L30aycU
         ulBcdTJHwhJAPloJ0ofGC5C31T9xd4UcL5EUdgSeF4tDXDle5V6VmqMHGcVYtkHDD7aP
         vvCFeQNiBLwiZdChRLPDtbu7vQVSvCr5jMFIo7T8U7V469Ed6gE1D1yHr96Jq5dLzrXu
         F1VIGIR8xKBOv8N0EbNg5ixjX8oJrRZBDcr3lHrueX1Q5wNcJHHme2iw+4DifW5CTNra
         +y0Q==
X-Gm-Message-State: AElRT7HbpSrIvi2ITYsBFcqbzWZXB+/JRKaC3nLyuSb9yoKC6mhDR2Wm
        AELdBIOWoWjM9GIC45gc+qsM3g==
X-Google-Smtp-Source: AG47ELsu573j3kKY+AyiM/fDbMKREr4EkQaF9gKnpm7vM3XfP6UwuNUqOTKFvxNZ4KH3+i91IOffGA==
X-Received: by 10.200.46.139 with SMTP id h11mr27290794qta.253.1521852960585;
        Fri, 23 Mar 2018 17:56:00 -0700 (PDT)
Received: from localhost (u-of-rochester-128-151-150-17.wireless.rochester.edu. [128.151.150.17])
        by smtp.gmail.com with ESMTPSA id t62sm7782537qkd.50.2018.03.23.17.55.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Mar 2018 17:55:59 -0700 (PDT)
From:   Taylor Blau <me@ttaylorr.com>
To:     me@ttaylorr.com
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        sunshine@sunshineco.com
Subject: [PATCH v2 1/4] builtin/config: introduce `--default`
Date:   Fri, 23 Mar 2018 20:55:53 -0400
Message-Id: <20180324005556.8145-2-me@ttaylorr.com>
X-Mailer: git-send-email 2.16.2.440.gc6284da4f
In-Reply-To: <20180324005556.8145-1-me@ttaylorr.com>
References: <20180306021729.45813-1-me@ttaylorr.com>
 <20180324005556.8145-1-me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For some use cases, callers of the `git-config(1)` builtin would like to
fallback to default values when the slot asked for does not exist. In
addition, users would like to use existing type specifiers to ensure
that values are parsed correctly when they do exist in the
configuration.

For example, to fetch a value without a type specifier and fallback to
`$fallback`, the following is required:

  $ git config core.foo || echo "$fallback"

This is fine for most values, but can be tricky for difficult-to-express
`$fallback`'s, like ANSI color codes.

This motivates `--get-color`, which is a one-off exception to the normal
type specifier rules wherein a user specifies both the configuration
slot and an optional fallback. Both are formatted according to their
type specifier, which eases the burden on the user to ensure that values
are correctly formatted.

This commit (and those following it in this series) aim to eventually
replace `--get-color` with a consistent alternative. By introducing
`--default`, we allow the `--get-color` action to be promoted to a
`--color` type specifier, retaining the "fallback" behavior via the
`--default` flag introduced in this commit.

For example, we aim to replace:

  $ git config --get-color slot [default] [...]

with:

  $ git config --default default --color slot [...]

Values filled by `--default` behave exactly as if they were present in
the affected configuration file; they will be parsed by type specifiers
without the knowledge that they are not themselves present in the
configuraion.

Specifically, this means that the following will work:

  $ git config --int --default 1M does.not.exist
  1048576

In subsequent commits, we will offer `--color`, which (in conjunction
with `--default`) will be sufficient to replace `--get-color`.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/git-config.txt |   6 +-
 builtin/config.c             |  17 +++++
 t/t1310-config-default.sh    | 125 +++++++++++++++++++++++++++++++++++
 3 files changed, 146 insertions(+), 2 deletions(-)
 create mode 100755 t/t1310-config-default.sh

diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index e09ed5d7d..d9e389a33 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -233,8 +233,10 @@ See also <<FILES>>.
 	using `--file`, `--global`, etc) and `on` when searching all
 	config files.
 
-CONFIGURATION
--------------
+--default value::
+  When using `--get`, behave as if value were the value assigned to the given
+  slot.
+
 `pager.config` is only respected when listing configuration, i.e., when
 using `--list` or any of the `--get-*` which may return multiple results.
 The default is to use a pager.
diff --git a/builtin/config.c b/builtin/config.c
index 01169dd62..1410be850 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -26,6 +26,7 @@ static char term = '\n';
 static int use_global_config, use_system_config, use_local_config;
 static struct git_config_source given_config_source;
 static int actions, types;
+static char *default_value;
 static int end_null;
 static int respect_includes_opt = -1;
 static struct config_options config_options;
@@ -94,6 +95,7 @@ static struct option builtin_config_options[] = {
 	OPT_BOOL(0, "name-only", &omit_values, N_("show variable names only")),
 	OPT_BOOL(0, "includes", &respect_includes_opt, N_("respect include directives on lookup")),
 	OPT_BOOL(0, "show-origin", &show_origin, N_("show origin of config (file, standard input, blob, command line)")),
+	OPT_STRING(0, "default", &default_value, N_("value"), N_("with --get, use default value when missing entry")),
 	OPT_END(),
 };
 
@@ -258,6 +260,16 @@ static int get_value(const char *key_, const char *regex_)
 	config_with_options(collect_config, &values,
 			    &given_config_source, &config_options);
 
+	if (!values.nr && default_value) {
+		struct strbuf *item;
+		ALLOC_GROW(values.items, values.nr + 1, values.alloc);
+		item = &values.items[values.nr++];
+		strbuf_init(item, 0);
+		if (format_config(item, key_, default_value) < 0) {
+			values.nr = 0;
+		}
+	}
+
 	ret = !values.nr;
 
 	for (i = 0; i < values.nr; i++) {
@@ -601,6 +613,11 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 		usage_with_options(builtin_config_usage, builtin_config_options);
 	}
 
+	if (default_value && !(actions & ACTION_GET)) {
+		error("--default is only applicable to --get");
+		usage_with_options(builtin_config_usage, builtin_config_options);
+	}
+
 	if (actions & PAGING_ACTIONS)
 		setup_auto_pager("config", 1);
 
diff --git a/t/t1310-config-default.sh b/t/t1310-config-default.sh
new file mode 100755
index 000000000..0e464c206
--- /dev/null
+++ b/t/t1310-config-default.sh
@@ -0,0 +1,125 @@
+#!/bin/sh
+
+test_description='Test git config in different settings (with --default)'
+
+. ./test-lib.sh
+
+test_expect_success 'clear default config' '
+	rm -f .git/config
+'
+
+test_expect_success 'uses default when missing entry' '
+	echo quux >expect &&
+	git config --default quux core.foo >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'uses entry when available' '
+	echo bar >expect &&
+	git config --add core.foo bar &&
+	git config --default baz core.foo >actual &&
+	git config --unset core.foo &&
+	test_cmp expect actual
+'
+
+test_expect_success 'marshals default value as bool' '
+	echo true >expect &&
+	git config --default true --bool core.foo >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'marshals default value as int' '
+	echo 810 >expect &&
+	git config --default 810 --int core.foo >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'marshals default value as int (storage unit)' '
+	echo 1048576 >expect &&
+	git config --default 1M --int core.foo >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'marshals default value as bool-or-int' '
+	{
+		echo 1 &&
+		echo true
+	} >expect &&
+	git config --default 1 --bool-or-int core.foo >actual &&
+	git config --default true --bool-or-int core.foo >>actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'marshal default value as path' '
+	echo /path/to/file >expect &&
+	git config --default /path/to/file --path core.foo >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'marshal default value as expiry-date' '
+	echo 0 >expect &&
+	git config --default never --expiry-date core.foo >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'does not allow --default with --get-all' '
+	test_must_fail git config --default quux --get-all a >output 2>&1 &&
+	test_i18ngrep "\-\-default is only applicable to" output
+'
+
+test_expect_success 'does not allow --default with --get-regexp' '
+	test_must_fail git config --default quux --get-regexp a >output 2>&1 &&
+	test_i18ngrep "\-\-default is only applicable to" output
+'
+
+test_expect_success 'does not allow --default with --replace-all' '
+	test_must_fail git config --default quux --replace-all a b >output 2>&1 &&
+	test_i18ngrep "\-\-default is only applicable to" output
+'
+
+test_expect_success 'does not allow --default with --add' '
+	test_must_fail git config --default quux --add a b >output 2>&1 &&
+	test_i18ngrep "\-\-default is only applicable to" output
+'
+
+test_expect_success 'does not allow --default with --unset' '
+	test_must_fail git config --default quux --unset a >output 2>&1 &&
+	test_i18ngrep "\-\-default is only applicable to" output
+'
+
+test_expect_success 'does not allow --default with --unset-all' '
+	test_must_fail git config --default quux --unset-all a >output 2>&1 &&
+	test_i18ngrep "\-\-default is only applicable to" output
+'
+
+test_expect_success 'does not allow --default with --rename-section' '
+	test_must_fail git config --default quux --rename-section a >output 2>&1 &&
+	test_i18ngrep "\-\-default is only applicable to" output
+'
+
+test_expect_success 'does not allow --default with --remove-section' '
+	test_must_fail git config --default quux --remove-section a >output 2>&1 &&
+	test_i18ngrep "\-\-default is only applicable to" output
+'
+
+test_expect_success 'does not allow --default with --list' '
+	test_must_fail git config --default quux --list >output 2>&1 &&
+	test_i18ngrep "\-\-default is only applicable to" output
+'
+
+test_expect_success 'does not allow --default with --edit' '
+	test_must_fail git config --default quux --edit >output 2>&1 &&
+	test_i18ngrep "\-\-default is only applicable to" output
+'
+
+test_expect_success 'does not allow --default with --get-color' '
+	test_must_fail git config --default quux --get-color >output 2>&1 &&
+	test_i18ngrep "\-\-default is only applicable to" output
+'
+
+test_expect_success 'does not allow --default with --get-colorbool' '
+	test_must_fail git config --default quux --get-colorbool >output 2>&1 &&
+	test_i18ngrep "\-\-default is only applicable to" output
+'
+
+test_done
-- 
2.16.2.440.gc6284da4f

