Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E27AF1F404
	for <e@80x24.org>; Tue, 10 Apr 2018 00:18:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752264AbeDJASx (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Apr 2018 20:18:53 -0400
Received: from mail-pl0-f47.google.com ([209.85.160.47]:40533 "EHLO
        mail-pl0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752134AbeDJAS3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Apr 2018 20:18:29 -0400
Received: by mail-pl0-f47.google.com with SMTP id x4-v6so6220976pln.7
        for <git@vger.kernel.org>; Mon, 09 Apr 2018 17:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=g0a5KCUACoTr0j/A/hwplYr8IKqz+I/iY2ZRDaCpBpY=;
        b=bcVr3mJ1kwRt9EtzsB6sKC87ym3XCNTP78hLhPIHIesH2O2M9rSRWNCdRW9rWSgUqp
         pM1/LAYz7JFdUF+U7umT2Ukghzk2QdJydCQhBfw7gMYFn8mZbaH+8ZTlmpodSS9pUbyc
         R46dEki3azxapZZ/AgymcTnxapnirx5wWdF1N/ueO7P8H6R+spuBpR9z0lQjGSW8EcIm
         NWERj94Fpee0c4dfhdx4kn9zJ4E7MzZiTwsYM/8gZknhYkIL2+LYS3KGkz5+zbe0haMk
         SXUGkwxWp5bt8s4/6rtjZ9BOBXmjyFP+LwaC3mDwel2iTz5op3hI7BI/DstYqiZSPC+Q
         dJkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=g0a5KCUACoTr0j/A/hwplYr8IKqz+I/iY2ZRDaCpBpY=;
        b=oicVBMgfqf2jgmJBvv/XGBjJszOKa+YbB3W/zBHYoAnmaBeDWUlM1qt3v6KTnuhNen
         CBSwlDzYjgxnG+cq/xVHR3ZE29CwJpDtH9yyhVsrssIHOFcbwY2nOLJ8rq5wAweshfBc
         hukzRJyZfobFWgO6dsB8yRpoUNHH6LxlFpdrDKHt7BpfpKhrg0nZz1LpUtZLRBw90s3L
         myRASD1T6iaoxfurHQ+UD0BPpmXpGolNDNc/UnqGECRI5poBw7EE/q99eIABVhkckXtK
         Bwd1Db2Kt9p5H7t8sFGi58I0vJPusV3uliTo4KUHPATxp8kBM/cpNFMuhvC1qBeNFIqi
         qk4w==
X-Gm-Message-State: ALQs6tBbA7A8WHpU32qQ549QRwCu4nU7Cz3AY3H/EPDARJcaAPnKl8hF
        LrNKZ/ePbLMqkIP+g5PhUrYz5xjc/N0=
X-Google-Smtp-Source: AIpwx4/vQwEWvr2UiIfpG/v+2bMboMkNBOYfOrNnM/nX9cz5pBu7AGuwzlgRRtscGS4UOqYmTrXigQ==
X-Received: by 2002:a17:902:b60f:: with SMTP id b15-v6mr5386498pls.12.1523319508194;
        Mon, 09 Apr 2018 17:18:28 -0700 (PDT)
Received: from localhost ([2601:602:9500:3a4f:1d66:22f3:ac1d:6007])
        by smtp.gmail.com with ESMTPSA id g26sm3345815pfk.173.2018.04.09.17.18.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Apr 2018 17:18:27 -0700 (PDT)
Date:   Mon, 9 Apr 2018 17:18:26 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     sunshine@sunshineco.com, gitster@pobox.com, peff@peff.net
Subject: [PATCH v6 1/3] builtin/config: introduce `--default`
Message-ID: <20180410001826.GB67209@syl.local>
References: <20180306021729.45813-1-me@ttaylorr.com>
 <cover.1523319159.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1523319159.git.me@ttaylorr.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For some use cases, callers of the `git-config(1)` builtin would like to
fallback to default values when the variable asked for does not exist.
In addition, users would like to use existing type specifiers to ensure
that values are parsed correctly when they do exist in the
configuration.

For example, to fetch a value without a type specifier and fallback to
`$fallback`, the following is required:

  $ git config core.foo || echo "$fallback"

This is fine for most values, but can be tricky for difficult-to-express
`$fallback`'s, like ANSI color codes.

This motivates `--get-color`, which is a one-off exception to the normal
type specifier rules wherein a user specifies both the configuration
variable and an optional fallback. Both are formatted according to their
type specifier, which eases the burden on the user to ensure that values
are correctly formatted.

This commit (and those following it in this series) aim to eventually
replace `--get-color` with a consistent alternative. By introducing
`--default`, we allow the `--get-color` action to be promoted to a
`--type=color` type specifier, retaining the "fallback" behavior via the
`--default` flag introduced in this commit.

For example, we aim to replace:

  $ git config --get-color variable [default] [...]

with:

  $ git config --default default --type=color variable [...]

Values filled by `--default` behave exactly as if they were present in
the affected configuration file; they will be parsed by type specifiers
without the knowledge that they are not themselves present in the
configuration.

Specifically, this means that the following will work:

  $ git config --int --default 1M does.not.exist
  1048576

In subsequent commits, we will offer `--type=color`, which (in
conjunction with `--default`) will be sufficient to replace
`--get-color`.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/git-config.txt |  4 ++++
 builtin/config.c             | 18 ++++++++++++++++++
 t/t1310-config-default.sh    | 36 ++++++++++++++++++++++++++++++++++++
 3 files changed, 58 insertions(+)
 create mode 100755 t/t1310-config-default.sh

diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index a1e3ffe750..b644a44ae9 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -240,6 +240,10 @@ Valid `<type>`'s include:
 	using `--file`, `--global`, etc) and `on` when searching all
 	config files.
 
+--default <value>::
+  When using `--get`, and the requested variable is not found, behave as if
+  <value> were the value assigned to the that variable.
+
 CONFIGURATION
 -------------
 `pager.config` is only respected when listing configuration, i.e., when
diff --git a/builtin/config.c b/builtin/config.c
index 5c8952a17c..014e3a0d53 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -26,6 +26,7 @@ static char term = '\n';
 static int use_global_config, use_system_config, use_local_config;
 static struct git_config_source given_config_source;
 static int actions, type;
+static char *default_value;
 static int end_null;
 static int respect_includes_opt = -1;
 static struct config_options config_options;
@@ -121,6 +122,7 @@ static struct option builtin_config_options[] = {
 	OPT_BOOL(0, "name-only", &omit_values, N_("show variable names only")),
 	OPT_BOOL(0, "includes", &respect_includes_opt, N_("respect include directives on lookup")),
 	OPT_BOOL(0, "show-origin", &show_origin, N_("show origin of config (file, standard input, blob, command line)")),
+	OPT_STRING(0, "default", &default_value, N_("value"), N_("with --get, use default value when missing entry")),
 	OPT_END(),
 };
 
@@ -285,6 +287,16 @@ static int get_value(const char *key_, const char *regex_)
 	config_with_options(collect_config, &values,
 			    &given_config_source, &config_options);
 
+	if (!values.nr && default_value) {
+		struct strbuf *item;
+		ALLOC_GROW(values.items, values.nr + 1, values.alloc);
+		item = &values.items[values.nr++];
+		strbuf_init(item, 0);
+		if (format_config(item, key_, default_value) < 0)
+			die(_("failed to format default config value: %s"),
+				default_value);
+	}
+
 	ret = !values.nr;
 
 	for (i = 0; i < values.nr; i++) {
@@ -623,6 +635,12 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 		usage_with_options(builtin_config_usage, builtin_config_options);
 	}
 
+	if (default_value && !(actions & ACTION_GET)) {
+		error("--default is only applicable to --get");
+		usage_with_options(builtin_config_usage,
+			builtin_config_options);
+	}
+
 	if (actions & PAGING_ACTIONS)
 		setup_auto_pager("config", 1);
 
diff --git a/t/t1310-config-default.sh b/t/t1310-config-default.sh
new file mode 100755
index 0000000000..6049d91708
--- /dev/null
+++ b/t/t1310-config-default.sh
@@ -0,0 +1,36 @@
+#!/bin/sh
+
+test_description='Test git config in different settings (with --default)'
+
+. ./test-lib.sh
+
+test_expect_success 'uses --default when entry missing' '
+	echo quux >expect &&
+	git config -f config --default=quux core.foo >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'does not use --default when entry present' '
+	echo bar >expect &&
+	git -c core.foo=bar config --default=baz core.foo >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'canonicalizes --default with appropriate type' '
+	echo true >expect &&
+	git config -f config --default=yes --bool core.foo >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'dies when --default cannot be parsed' '
+	test_must_fail git config -f config --type=expiry-date --default=x --get \
+		not.a.section 2>error &&
+	test_i18ngrep "failed to format default config value" error
+'
+
+test_expect_success 'does not allow --default without --get' '
+	test_must_fail git config --default=quux --unset a.section >output 2>&1 &&
+	test_i18ngrep "\-\-default is only applicable to" output
+'
+
+test_done
-- 
2.17.0

