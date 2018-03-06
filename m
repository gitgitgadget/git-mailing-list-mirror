Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B6901F404
	for <e@80x24.org>; Tue,  6 Mar 2018 02:17:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753180AbeCFCRk (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Mar 2018 21:17:40 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:38904 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753055AbeCFCRj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Mar 2018 21:17:39 -0500
Received: by mail-pf0-f194.google.com with SMTP id d26so8139811pfn.5
        for <git@vger.kernel.org>; Mon, 05 Mar 2018 18:17:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Q3K+QgdCSbcj55E2o+ywkyb8US/5WQaZ0ueaTGwR8+s=;
        b=FWjETcbJsTrmR4CnTLW267t6ToOqBpHBrYtZ9AIbDk6Qi2qGPkeAr7OrWw/mYCRTSJ
         Xeof8ROyhTPhH4oPiQmIV9Sb/V7/pCaslR9PWFfC/spi1nRN9Dq9Ssxg01is33OOY5o4
         gHotl4Nzn9JwGjQObGytMAaaAhwmyVEK6kmUvdh2IuPUY5QqSYtmzXcAondlpZj6So6F
         Ar/1cVIeDcEwmOpKArfsc1RlPh6SxTn1TmWtqhURE/IHbYswfN6xqMNlVyaB9dlhR/AO
         XzVyDWQ51uxCHE7hM3Uw0QztySuNNKO7e95k0aQUkOO7VmE9CsnAbKgjnWMnrEn+TVy7
         n68w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Q3K+QgdCSbcj55E2o+ywkyb8US/5WQaZ0ueaTGwR8+s=;
        b=HM5W8hR3vT3UVxqy4bAaMwoti9MCl58568k6mCKYrW/snbbnjIEQApGxrc2BYXUCLz
         lOjNa9F+sM1hgt2bvUXl41vccUdMKl+R9CMqdtMfttUSj/7+j8F0f8fuSDujxwo2KDbD
         jN0d86ffQW1LuM93DNAqTvPuFW9Aq6vxAT+ysFlfSf3TesUthTQ9QglpVrvWjnXcXHsT
         XTJO+r2/Z4rqMdgXs1I8klfy/ejs8cumA1E1PlHpZoeI2lvhjqBSfLZPuAqnlhtjmSFg
         aTNRiBouk7o4Gifpuhny646aQRNu/WVXU7wRqu+ldkdu2Xumcks79G7Y92eM2PTGu+pm
         lihw==
X-Gm-Message-State: APf1xPD0gY73YziaQ2r22ZRTFZJYPhwH1tCS+LXPygNn0biJSciJNdic
        4C4/5MEN/mhaUKDTbeVe4QT5ygEOj/s=
X-Google-Smtp-Source: AG47ELumkN7dhbV1Ai67oR/h3TNzAU43xqhKgetrlbveV2c5jHbw9CWD4KlwEuQHP5AeX6hcuM47Ng==
X-Received: by 10.99.95.15 with SMTP id t15mr13553075pgb.183.1520302657709;
        Mon, 05 Mar 2018 18:17:37 -0800 (PST)
Received: from localhost ([2601:602:9500:3a4f:8042:ad20:287d:7753])
        by smtp.gmail.com with ESMTPSA id r29sm27586146pfj.99.2018.03.05.18.17.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Mar 2018 18:17:36 -0800 (PST)
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, Taylor Blau <me@ttaylorr.com>
Subject: [PATCH 1/4] builtin/config: introduce `--default`
Date:   Mon,  5 Mar 2018 18:17:26 -0800
Message-Id: <20180306021729.45813-2-me@ttaylorr.com>
X-Mailer: git-send-email 2.15.1.354.g95ec6b1b3
In-Reply-To: <20180306021729.45813-1-me@ttaylorr.com>
References: <20180306021729.45813-1-me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In an aim to replace:

  $ git config --get-color slot [default] [...]

with:

  $ git config --default default --color slot [...]

introduce `--defualt` to behave as if the given default were present and
assigned to slot in the case that that slot does not exist.

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
 Documentation/git-config.txt |   4 ++
 builtin/config.c             |  19 +++++++
 t/t1310-config-default.sh    | 119 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 142 insertions(+)
 create mode 100755 t/t1310-config-default.sh

diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index 14da5fc15..390b49831 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -233,6 +233,10 @@ See also <<FILES>>.
 	using `--file`, `--global`, etc) and `on` when searching all
 	config files.
 
+--default value::
+  When using `--get`, `--get-all`, and `--get-regexp`, behave as
+  if value were the value assigned to the given slot.
+
 [[FILES]]
 FILES
 -----
diff --git a/builtin/config.c b/builtin/config.c
index ab5f95476..76edefc07 100644
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
@@ -87,6 +88,7 @@ static struct option builtin_config_options[] = {
 	OPT_BOOL(0, "name-only", &omit_values, N_("show variable names only")),
 	OPT_BOOL(0, "includes", &respect_includes_opt, N_("respect include directives on lookup")),
 	OPT_BOOL(0, "show-origin", &show_origin, N_("show origin of config (file, standard input, blob, command line)")),
+	OPT_STRING(0, "default", &default_value, N_("value"), N_("use default value with missing entry")),
 	OPT_END(),
 };
 
@@ -251,6 +253,16 @@ static int get_value(const char *key_, const char *regex_)
 	config_with_options(collect_config, &values,
 			    &given_config_source, &config_options);
 
+	if (!values.nr && default_value) {
+		struct strbuf *item;
+
+		ALLOC_GROW(values.items, values.nr + 1, values.alloc);
+		item = &values.items[values.nr++];
+		if (format_config(item, key_, default_value) < 0) {
+			values.nr = 0;
+		}
+	}
+
 	ret = !values.nr;
 
 	for (i = 0; i < values.nr; i++) {
@@ -594,6 +606,13 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 		usage_with_options(builtin_config_usage, builtin_config_options);
 	}
 
+	if (default_value && !(actions &
+		(ACTION_GET|ACTION_GET_ALL|ACTION_GET_REGEXP))) {
+		error("--default is only applicable to --get, --get-all, "
+			"and --get-regexp.");
+		usage_with_options(builtin_config_usage, builtin_config_options);
+	}
+
 	if (actions == ACTION_LIST) {
 		check_argc(argc, 0, 0);
 		if (config_with_options(show_all_config, NULL,
diff --git a/t/t1310-config-default.sh b/t/t1310-config-default.sh
new file mode 100755
index 000000000..57fe63295
--- /dev/null
+++ b/t/t1310-config-default.sh
@@ -0,0 +1,119 @@
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
+	echo "1
+true" >expect &&
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
+test_expect_success 'marshal default value as color' '
+	echo "\033[31m" >expect &&
+	git config --default red --color core.foo >actual &&
+	test_cmp expect actual
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
2.15.1.354.g95ec6b1b3

