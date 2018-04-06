Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0BA6A1F424
	for <e@80x24.org>; Fri,  6 Apr 2018 06:30:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752349AbeDFGaR (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Apr 2018 02:30:17 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:33309 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751623AbeDFGaQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Apr 2018 02:30:16 -0400
Received: by mail-pf0-f179.google.com with SMTP id f15so83428pfn.0
        for <git@vger.kernel.org>; Thu, 05 Apr 2018 23:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=m2epS9m+dFCZav/0d9BIKan5QvauYOVDpgs3PkOmrEQ=;
        b=uF7kPrLa/AHC/Y5dGArFNqh3ZED5VMJ8XqZ7t46l7uWxfa6mPRrQgKfvXoZJljdS0B
         SbNmP/J6Pshi09SmRgTmimlr/3S25YQvvz9euWlWi9JtXCM6V+p3ZUU/MQpwceJavOv0
         it72UfEJnJz0qZa6VOLIOJPD/QeENdzAZbA7WHGqw6Nt6qOm3153+FeJcQ1CUTgkYaQ3
         jt1lWygHh7kmcCtdOo/Nw4kEROcWoyw2rcvrBDqYadHMrx7n8wCahIfAqvOy6HD6sy5O
         8ZNvjNtcbBILzM2GEF/8+1RnDJ9D2yw+4i1beOni92rzlLi+ED+3xRWpcRo77lF5hp4c
         YI/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=m2epS9m+dFCZav/0d9BIKan5QvauYOVDpgs3PkOmrEQ=;
        b=mkNh+1Mv63yenA8gpIkVyFhjAqrP/W5fllaANA31dS6mYritsjT83WzF64rjXCa6Gf
         2zo8+B1RO8oblbdB7FDGJpxYWzOTYrgimrY9xUGfiorKWk2NGl9wO8cNPe48fLCaMxvT
         uABl+MVW9M+w7JyjAekz+YhtyD3xXIgu7A3pyKjUri0oGhG0ICbJKhKiy3zUkcQeLeQo
         RD5HveYOkBp/J6xdyLlxir6DnLRROrUY78DL/JG2mg/cvgRl8s2wfgbLGff5xu50hxso
         qCvJ0ST7RO6WA6kvJE4MT8DeDQAAOsxDeB3YSFwlW+6QmE1iR0F0BlvJ0uS+6xxgtrtw
         fOPA==
X-Gm-Message-State: AElRT7E/vEOo2TPfoJChfwiuG8zhA7gdylYH+MurQu6qqlspdvvNh7Dd
        st1L0qRTgV49y0qTbOZ2DljHdGmzEkw=
X-Google-Smtp-Source: AIpwx49PjvkJE/yys0iJrQx0mLMXg6Grb1qmY/bzwRWOoBJTDR6672Y12Sng+VAz0B50yZEIgtF32A==
X-Received: by 10.98.156.7 with SMTP id f7mr19659600pfe.104.1522996214910;
        Thu, 05 Apr 2018 23:30:14 -0700 (PDT)
Received: from localhost ([2601:602:9500:3a4f:3d01:699f:f606:da49])
        by smtp.gmail.com with ESMTPSA id 195sm15616280pgd.3.2018.04.05.23.30.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Apr 2018 23:30:13 -0700 (PDT)
Date:   Thu, 5 Apr 2018 23:30:13 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, sunshine@sunshineco.com, gitster@pobox.com
Subject: [PATCH v5 1/3] builtin/config: introduce `--default`
Message-ID: <20180406063013.GB662@syl.local>
References: <20180306021729.45813-1-me@ttaylorr.com>
 <cover.1522996150.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1522996150.git.me@ttaylorr.com>
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
 builtin/config.c             | 19 ++++++++++++++++++
 t/t1310-config-default.sh    | 38 ++++++++++++++++++++++++++++++++++++
 3 files changed, 61 insertions(+)
 create mode 100755 t/t1310-config-default.sh

diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index 31931ae00..28567f75a 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -243,6 +243,10 @@ Valid `<type>`'s include:
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
index 6e1495eac..e8da4009e 100644
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
+			die(_("failed to format default config value"));
+		}
+	}
+
 	ret = !values.nr;
 
 	for (i = 0; i < values.nr; i++) {
@@ -624,6 +636,13 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 		usage_with_options(builtin_config_usage, builtin_config_options);
 	}
 
+
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
index 000000000..b74c93276
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

