Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9720F1F404
	for <e@80x24.org>; Thu, 29 Mar 2018 01:16:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751249AbeC2BQl (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Mar 2018 21:16:41 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:34988 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751088AbeC2BQk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Mar 2018 21:16:40 -0400
Received: by mail-pf0-f194.google.com with SMTP id u86so2076642pfd.2
        for <git@vger.kernel.org>; Wed, 28 Mar 2018 18:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Dll6/H5zG0+LvFqrGDKQSNVu8v+z8MS88VIoSlJsmyg=;
        b=QCIoUJCECqwyi4hYlxEVE/QiNt/hAnGXmTu+AKQWCw78A2yjmfPBFDvVkqrkpTqRtg
         obCN0G+zhsNjfvrm+rm5Nyfhh7ZycPT/dLuQ3D4blCUktP1yspzp+bQvCJ63U3mdNNi8
         FMydWOisRgeRx0njSTcx9Y/YQRf5GVGVabK/fCcfFFcuilVfJHeVImCVJpAaKxS7KP4/
         i+8R9CjYni6BaUjHxXn/KJYqKPGuQK953B3B8vpWSifyxdfHHMiM16fstjNaBvFuk1w4
         y3qaceNbGMj5VaOHt5ChtPOIWRXa0jjTGemmw6GIXX0etdJSwGu+YesxssWydiVlBHa1
         gDOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Dll6/H5zG0+LvFqrGDKQSNVu8v+z8MS88VIoSlJsmyg=;
        b=FD4Btkoc9uCZt4X1xGIKqLAktOmF1ZqqNhau99dhsTOFAU3peyAd2xALevEPcAe7zJ
         /fsRolvmRn8RofF2QtQFIhwQyo3PL0xDzkMZTVAwiQR67IKvrwh5thwxLhmdyQZ5aOYO
         QKwW8Py7UuXySs1s+dgF8AmjddTV3HS7a68roPk2+tc6YvzCVHEeMZiCkZ8Jq2Fk0Gx6
         LQH1AtP5FIoOzJZq9AgD4zpmc9XkYWdQ9sgtp8FTMr3/KSfCwmcqsOlsJBA4WLkQdkkS
         URkXWmBxlayPlcCfh20IAqrcaOXLlzv2LUDGa6D26N98ftbipopJCjWJ24Sn0TXBZv5t
         PrHg==
X-Gm-Message-State: AElRT7HPvHCM0zOGX7yDL1WW99aW7OuVxelow5oV6gmrshzWC+XH2/Xj
        qpDuZ7bPMVqZvzurOoUHC3d9Qg==
X-Google-Smtp-Source: AIpwx4/2sV5A9LnGEfoZX+Jr4NayrDRI2aGr4u6FEYtmmx4SlFWNSSBF/AfSRKMSxT91IsmOjIyIMQ==
X-Received: by 2002:a17:902:3e5:: with SMTP id d92-v6mr6206776pld.104.1522286199500;
        Wed, 28 Mar 2018 18:16:39 -0700 (PDT)
Received: from localhost ([2601:602:9500:3a4f:ec10:419d:d341:c920])
        by smtp.gmail.com with ESMTPSA id g85sm10780099pfd.109.2018.03.28.18.16.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Mar 2018 18:16:38 -0700 (PDT)
From:   Taylor Blau <me@ttaylorr.com>
To:     peff@peff.net, gitster@pobox.com
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v3 1/3] builtin/config: introduce `--default`
Date:   Wed, 28 Mar 2018 18:16:32 -0700
Message-Id: <20180329011634.68582-2-me@ttaylorr.com>
X-Mailer: git-send-email 2.16.2.440.gc6284da4f
In-Reply-To: <20180329011634.68582-1-me@ttaylorr.com>
References: <20180324005556.8145-1-me@ttaylorr.com>
 <20180329011634.68582-1-me@ttaylorr.com>
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
configuration.

Specifically, this means that the following will work:

  $ git config --int --default 1M does.not.exist
  1048576

In subsequent commits, we will offer `--color`, which (in conjunction
with `--default`) will be sufficient to replace `--get-color`.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/git-config.txt |  4 ++++
 builtin/config.c             | 17 ++++++++++++++++
 t/t1310-config-default.sh    | 38 ++++++++++++++++++++++++++++++++++++
 3 files changed, 59 insertions(+)
 create mode 100755 t/t1310-config-default.sh

diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index a4a5ffb41..5aa528878 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -235,6 +235,10 @@ Valid `[type]`'s include:
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
index ea7923493..4340f5f3d 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -27,6 +27,7 @@ static int use_global_config, use_system_config, use_local_config;
 static struct git_config_source given_config_source;
 static int actions, types;
 static char *type;
+static char *default_value;
 static int end_null;
 static int respect_includes_opt = -1;
 static struct config_options config_options;
@@ -96,6 +97,7 @@ static struct option builtin_config_options[] = {
 	OPT_BOOL(0, "name-only", &omit_values, N_("show variable names only")),
 	OPT_BOOL(0, "includes", &respect_includes_opt, N_("respect include directives on lookup")),
 	OPT_BOOL(0, "show-origin", &show_origin, N_("show origin of config (file, standard input, blob, command line)")),
+	OPT_STRING(0, "default", &default_value, N_("value"), N_("with --get, use default value when missing entry")),
 	OPT_END(),
 };
 
@@ -260,6 +262,16 @@ static int get_value(const char *key_, const char *regex_)
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
@@ -618,6 +630,11 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 		usage_with_options(builtin_config_usage, builtin_config_options);
 	}
 
+	if (default_value && !(actions & ACTION_GET)) {
+		error("--default is only applicable to --get");
+		usage_with_options(builtin_config_usage, builtin_config_options);
+	}
+
 	if (type) {
 		if (types != 0) {
 			error("usage of --type is ambiguous");
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
2.16.2.440.gc6284da4f

