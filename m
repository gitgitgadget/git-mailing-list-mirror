Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B52E1F404
	for <e@80x24.org>; Thu,  5 Apr 2018 02:59:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751277AbeDEC7Q (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Apr 2018 22:59:16 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:44815 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750890AbeDEC7P (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Apr 2018 22:59:15 -0400
Received: by mail-pl0-f68.google.com with SMTP id b6-v6so15159834pla.11
        for <git@vger.kernel.org>; Wed, 04 Apr 2018 19:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ubsf/Z1pOHBVsqj2cnRF4aCxhgGjr43t0gQAMzDyOmc=;
        b=YOzXDuHc/siFnRSqNjxHwxYaAItesVDiFrWVh73iCYpkLbsIS7C1Zx5e8JfLuFmk54
         yjTNE9ZYjffjNDJPO7M9ApDuzXa3Zc3hQqx2+BYoevHpBwx4g4E9kc8L1W8T2oEuRGgq
         hsXnW9f1HRW2ae8cQEZ4Nrzag8d+4HLKRiq+jwZzZtgMHim9DLNbZAZEeqBzkGHlL4Rb
         oShmXH8rM2SvLFAXX/x2l+iYgqbZRSHEvT0onzvbXM1lnYLXYYkh6aaeWhvgu5NuAHVX
         5WTYhhLO2Ubyn78LdLensH44l6ZzLu/vkEayXDvm1mfQWuWOb9j1NH+UgJDpOcNPaOXV
         zx7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ubsf/Z1pOHBVsqj2cnRF4aCxhgGjr43t0gQAMzDyOmc=;
        b=GFef7HzXlsPUKOLY2RVhuKcJ5eu6EcAtpMbetmBonwJaMyyIL2CGEFWO4tTxp/+X9f
         9L194WnCjuET8QPN7gzXsfuLqpyoIlrC6yl6WRo77jE7MJHFRAPGkJkMpDmKyiGwZ2w1
         af1hFxZDygMFKA+beJoyas5sc7piWEnwUZfGmw1P5tFVYhG+5nJKeGqa2ICol9+ZxJBx
         4rsOKqDsYv7OuCTuL2wE6PoNjQ+30l1kbfAe4H6w3HEEU35jXqlqW2Zd0HPgZv0Xy16I
         k1etwb6p9Ga9ptkYU7WiY9H6fouPgZ5EGUvQlETwFDAU+m+IQXPhs+Q+FCnexbapK+oD
         iRbA==
X-Gm-Message-State: AElRT7Gdrz1i98EVh2UIy8PQXOYNNXdsVcymNtwQUCf5vFaIDQxJ+msY
        ZZyMZTIzEyVGr452qAQCx1SmdwlVe5OItA==
X-Google-Smtp-Source: AIpwx4+HCV3YxTn80p4w8JqCpO6Lq4lgkK5hJSCioL/eJEdZGukJoqr86IDGaoZsB1Vl2gXosKOpsA==
X-Received: by 10.99.124.79 with SMTP id l15mr13578132pgn.19.1522897154112;
        Wed, 04 Apr 2018 19:59:14 -0700 (PDT)
Received: from localhost ([2601:602:9500:3a4f:dc75:c2ae:e99:b3d1])
        by smtp.gmail.com with ESMTPSA id e62sm12521071pfl.117.2018.04.04.19.59.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Apr 2018 19:59:13 -0700 (PDT)
Date:   Wed, 4 Apr 2018 19:59:12 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, sunshine@sunshineco.com
Subject: [PATCH v4 1/3] builtin/config: introduce `--default`
Message-ID: <20180405025912.GB49902@syl.local>
References: <20180329011634.68582-1-me@ttaylorr.com>
 <cover.1522896713.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1522896713.git.me@ttaylorr.com>
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
 builtin/config.c             | 12 ++++++++++++
 t/t1310-config-default.sh    | 38 ++++++++++++++++++++++++++++++++++++
 3 files changed, 54 insertions(+)
 create mode 100755 t/t1310-config-default.sh

diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index c7e56e3fd..620492d1e 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -235,6 +235,10 @@ Valid `<type>`'s include:
 	using `--file`, `--global`, etc) and `on` when searching all
 	config files.
 
+--default value::
+  When using `--get`, and the requested slot is not found, behave as if value
+  were the value assigned to the that slot.
+
 CONFIGURATION
 -------------
 `pager.config` is only respected when listing configuration, i.e., when
diff --git a/builtin/config.c b/builtin/config.c
index 6e1495eac..1328b568b 100644
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
@@ -122,6 +123,7 @@ static struct option builtin_config_options[] = {
 	OPT_BOOL(0, "name-only", &omit_values, N_("show variable names only")),
 	OPT_BOOL(0, "includes", &respect_includes_opt, N_("respect include directives on lookup")),
 	OPT_BOOL(0, "show-origin", &show_origin, N_("show origin of config (file, standard input, blob, command line)")),
+	OPT_STRING(0, "default", &default_value, N_("value"), N_("with --get, use default value when missing entry")),
 	OPT_END(),
 };
 
@@ -286,6 +288,16 @@ static int get_value(const char *key_, const char *regex_)
 	config_with_options(collect_config, &values,
 			    &given_config_source, &config_options);
 
+	if (!values.nr && default_value) {
+		struct strbuf *item;
+		ALLOC_GROW(values.items, values.nr + 1, values.alloc);
+		item = &values.items[values.nr++];
+		strbuf_init(item, 0);
+		if (format_config(item, key_, default_value) < 0) {
+			exit(1);
+		}
+	}
+
 	ret = !values.nr;
 
 	for (i = 0; i < values.nr; i++) {
diff --git a/t/t1310-config-default.sh b/t/t1310-config-default.sh
new file mode 100755
index 000000000..ab4e35f06
--- /dev/null
+++ b/t/t1310-config-default.sh
@@ -0,0 +1,38 @@
+#!/bin/sh
+
+test_description='Test git config in different settings (with --default)'
+
+. ./test-lib.sh
+
+test_expect_success 'uses --default when missing entry' '
+	echo quux >expect &&
+	git config -f config --default quux core.foo >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'canonicalizes --default with appropriate type' '
+	echo true >expect &&
+	git config -f config --default=true --bool core.foo >actual &&
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
+test_expect_success 'dies when --default cannot be parsed' '
+	test_must_fail git config -f config --type=int --default=x --get \
+		not.a.section 2>error &&
+	test_i18ngrep "invalid unit" error
+'
+
+test_expect_success 'does not allow --default without --get' '
+	test_must_fail git config --default quux --unset a >output 2>&1 &&
+	test_i18ngrep "\-\-default is only applicable to" output
+'
+
+test_done
-- 
2.17.0

