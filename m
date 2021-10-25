Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82F5AC433EF
	for <git@archiver.kernel.org>; Mon, 25 Oct 2021 21:26:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CA7A61073
	for <git@archiver.kernel.org>; Mon, 25 Oct 2021 21:26:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232957AbhJYV2o (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Oct 2021 17:28:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232776AbhJYV2d (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Oct 2021 17:28:33 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E653C061767
        for <git@vger.kernel.org>; Mon, 25 Oct 2021 14:26:10 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id u18so11858445wrg.5
        for <git@vger.kernel.org>; Mon, 25 Oct 2021 14:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mbjuKJ790S9hFw3HUFMMdYOT0SLn4BgVpAkEn5Uw620=;
        b=WG1FQAg1IFIMuKiuZCRpZp2c8YRkI8cKIZIZ5s2FNnWg8c8ypPdUoL7kVKotg279BK
         0G6GiQviWOALu4pbqCdRJDymkyLbMeTMBXS52+M7cjIjgsExvPuSCeeumCrLD49BdHz5
         Gk12A5RptqG65yjdtdAN5R/cjuJ72Iqwo5O0ZFpbpxuDze8DKcFe1WxFhvMOh71zQ800
         ocFlyoPPJ6Ox2g8K4invdl+W6Rvm7QjF2AUypBytI4S5w9/W4PfQd1FHU/ZxOPbInRGl
         PlNHZjnPRnf2Ft6N2JMmv9C0JRk3TM6GSVV4cW9LQQPLLwiL6KipEvHm/PQp8X13b5gQ
         FaHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mbjuKJ790S9hFw3HUFMMdYOT0SLn4BgVpAkEn5Uw620=;
        b=Gc/4d3d4DTw4hKnxQyba1hnYuQVgWnXQMjLibmvoJ3mVF+TONAR7nRFdn9aqycd8WR
         HMrl6vtfs7799JXkIcTLqPpQS1hfEdEOANb4D70y0UAQuHi79t+YmaPalL4EtU3OTXC9
         Vt3X0JvYn7fuhkCLdNbQcMRgTQEoGvCVXoJ4DXuqELtf5GTT5efcLb4WmGKzsOdfowCr
         2YDqo8FfFcZ5TSc0XetuAsN2g0qk7rN5G+acU3JxMZgcRjmD1L2g+Zdd+1VrH4Yg2SUE
         g7IZ17+60F12vuqHzwkPg9Encnqtxa9alV/xRXPlibjUukPtbi8QNSqWfNI7GfGGrcU/
         ut3g==
X-Gm-Message-State: AOAM53030UhBlYayJTFOV9urUs8bBDftTpHZ2wXSXrJw0o+mrNPOguuq
        Q3o6JkZ4LcTbNso98WGKcLGQDcitLaE2aA==
X-Google-Smtp-Source: ABdhPJxBQIoqhMQtG7M7X1GGcgupK5T7sc2jnY0V19zEOFir+kO3/KuziMUvL/DiDyQmzm+DNEEgBQ==
X-Received: by 2002:a05:6000:18a8:: with SMTP id b8mr10134845wri.340.1635197168286;
        Mon, 25 Oct 2021 14:26:08 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m15sm17972784wmq.0.2021.10.25.14.26.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 14:26:07 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>,
        Patrick Steinhardt <ps@pks.im>,
        Christian Couder <christian.couder@gmail.com>,
        Albert Cui <albertqcui@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        "Robin H . Johnson" <robbat2@gentoo.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 3/3] bundle-uri client: add "bundle-uri" parsing + tests
Date:   Mon, 25 Oct 2021 23:25:46 +0200
Message-Id: <patch-3.3-64224ec2cba-20211025T211159Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1511.g4a4db174869
In-Reply-To: <cover-0.3-00000000000-20211025T211159Z-avarab@gmail.com>
References: <cover-0.3-00000000000-20211025T211159Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a "test-tool bundle-uri parse" which parses the format defined in
the newly specified "bundle-uri" command.

As note in the "bundle-uri" section in protocol-v2.txt we haven't
specified any key-values yet, just URI lines, but we should parse
their format for conformity with the spec.

We need to make sure our future client doesn't die if this optional
data is ever provided by the server, and that we've covered all the
edge cases with these key-values in our specification. Let's add and
test a bundle_uri_parse_line() to do that.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile                    |   1 +
 bundle-uri.c                | 124 +++++++++++++++++++++++++++++
 bundle-uri.h                |  16 ++++
 t/helper/test-bundle-uri.c  |  83 +++++++++++++++++++
 t/helper/test-tool.c        |   1 +
 t/helper/test-tool.h        |   1 +
 t/t5750-bundle-uri-parse.sh | 153 ++++++++++++++++++++++++++++++++++++
 7 files changed, 379 insertions(+)
 create mode 100644 t/helper/test-bundle-uri.c
 create mode 100755 t/t5750-bundle-uri-parse.sh

diff --git a/Makefile b/Makefile
index e41ac60829d..de66a016c78 100644
--- a/Makefile
+++ b/Makefile
@@ -691,6 +691,7 @@ PROGRAMS += $(patsubst %.o,git-%$X,$(PROGRAM_OBJS))
 TEST_BUILTINS_OBJS += test-advise.o
 TEST_BUILTINS_OBJS += test-bitmap.o
 TEST_BUILTINS_OBJS += test-bloom.o
+TEST_BUILTINS_OBJS += test-bundle-uri.o
 TEST_BUILTINS_OBJS += test-chmtime.o
 TEST_BUILTINS_OBJS += test-config.o
 TEST_BUILTINS_OBJS += test-crontab.o
diff --git a/bundle-uri.c b/bundle-uri.c
index ff054ddc690..9827fc5da17 100644
--- a/bundle-uri.c
+++ b/bundle-uri.c
@@ -53,3 +53,127 @@ int bundle_uri_command(struct repository *r,
 
 	return 0;
 }
+
+/**
+ * General API for {transport,connect}.c etc.
+ */
+int bundle_uri_parse_line(struct string_list *bundle_uri, const char *line)
+{
+	size_t i;
+	struct string_list columns = STRING_LIST_INIT_DUP;
+	const char *uri;
+	struct string_list *uri_columns = NULL;
+	int ret = 0;
+
+	if (!strlen(line))
+		return error(_("bundle-uri: got an empty line"));
+
+	/*
+	 * Right now we don't understand anything beyond the first SP,
+	 * but let's be tolerant and ignore any future unknown
+	 * fields. See the "MUST" note about "bundle-feature-key" in
+	 * Documentation/technical/protocol-v2.txt
+	 */
+	if (string_list_split(&columns, line, ' ', -1) < 1)
+		return error(_("bundle-uri: line not in SP-delimited format: %s"), line);
+
+	/*
+	 * We represent a "<uri>[ <key-values>...]" line with the URI
+	 * being the .string in a string list, and the .util being an
+	 * optional string list of key (.string) and values
+	 * (.util). If the top-level .util is NULL there's no
+	 * key-value pairs....
+	 */
+	uri = columns.items[0].string;
+	if (!strlen(uri)) {
+		ret = error(_("bundle-uri: got an empty URI component"));
+		goto cleanup;
+	}
+
+	/*
+	 * ... we're going to need that non-NULL .util .
+	 */
+	if (columns.nr > 1) {
+		uri_columns = xcalloc(1, sizeof(struct string_list));
+		string_list_init_dup(uri_columns);
+	}
+
+	/*
+	 * Let's parse the optional "kv" format, even if we don't
+	 * understand any of the keys or values yet.
+	 */
+	for (i = 1; i < columns.nr; i++) {
+		struct string_list kv = STRING_LIST_INIT_DUP;
+		const char *arg = columns.items[i].string;
+		int fields = string_list_split(&kv, arg, '=', 2);
+		int err = 0;
+
+		switch (fields) {
+		case 0:
+			BUG("should have no fields=0");
+		case 1:
+			if (!strlen(arg)) {
+				err = error("bundle-uri: column %lu: got an empty attribute (full line was '%s')",
+					    i, line);
+				break;
+			}
+			/*
+			 * We could dance around with
+			 * string_list_append_nodup() and skip
+			 * string_list_clear(&kv, 0) here, but let's
+			 * keep it simple.
+			 */
+			string_list_append(uri_columns, arg);
+			break;
+		case 2:
+		{
+			const char *k = kv.items[0].string;
+			const char *v = kv.items[1].string;
+
+			string_list_append(uri_columns, k)->util = xstrdup(v);
+			break;
+		}
+		default:
+			err = error("bundle-uri: column %lu: '%s' more than one '=' character (full line was '%s')",
+				    i, arg, line);
+			break;
+		}
+
+		string_list_clear(&kv, 0);
+		if (err) {
+			ret = err;
+			break;
+		}
+	}
+
+
+	/*
+	 * Per the spec we'll only consider bundle-uri lines OK if
+	 * there were no parsing problems, even if the problems were
+	 * with attributes whose content we don't understand.
+	 */
+	if (ret && uri_columns) {
+		string_list_clear(uri_columns, 1);
+		free(uri_columns);
+	} else if (!ret) {
+		string_list_append(bundle_uri, uri)->util = uri_columns;
+	}
+
+cleanup:
+	string_list_clear(&columns, 0);
+	return ret;
+}
+
+static void bundle_uri_string_list_clear_cb(void *util, const char *string)
+{
+	struct string_list *fields = util;
+	if (!fields)
+		return;
+	string_list_clear(fields, 1);
+	free(fields);
+}
+
+void bundle_uri_string_list_clear(struct string_list *bundle_uri)
+{
+	string_list_clear_func(bundle_uri, bundle_uri_string_list_clear_cb);
+}
diff --git a/bundle-uri.h b/bundle-uri.h
index b8762e6a8e4..c23d7316555 100644
--- a/bundle-uri.h
+++ b/bundle-uri.h
@@ -4,6 +4,7 @@
 struct repository;
 struct packet_reader;
 struct packet_writer;
+struct string_list;
 
 /**
  * API used by serve.[ch].
@@ -11,4 +12,19 @@ struct packet_writer;
 int bundle_uri_advertise(struct repository *r, struct strbuf *value);
 int bundle_uri_command(struct repository *r, struct packet_reader *request);
 
+/**
+ * General API for {transport,connect}.c etc.
+ */
+
+/**
+ * bundle_uri_parse_line() returns 0 when a valid bundle-uri has been
+ * added to `bundle_uri`, <0 on error.
+ */
+int bundle_uri_parse_line(struct string_list *bundle_uri, const char *line);
+
+/**
+ * Clear the `bundle_uri` list. Just a very thin wrapper on
+ * string_list_clear().
+ */
+void bundle_uri_string_list_clear(struct string_list *bundle_uri);
 #endif /* BUNDLE_URI_H */
diff --git a/t/helper/test-bundle-uri.c b/t/helper/test-bundle-uri.c
new file mode 100644
index 00000000000..805a86c0130
--- /dev/null
+++ b/t/helper/test-bundle-uri.c
@@ -0,0 +1,83 @@
+#include "test-tool.h"
+#include "parse-options.h"
+#include "bundle-uri.h"
+#include "strbuf.h"
+#include "string-list.h"
+
+static int cmd__bundle_uri_parse(int argc, const char **argv)
+{
+	const char *usage[] = {
+		"test-tool bundle-uri parse <in",
+		NULL
+	};
+	struct option options[] = {
+		OPT_END(),
+	};
+	struct strbuf sb = STRBUF_INIT;
+	struct string_list list = STRING_LIST_INIT_DUP;
+	int err = 0;
+	struct string_list_item *item;
+	size_t line_nr = 0;
+
+	argc = parse_options(argc, argv, NULL, options, usage, 0);
+	if (argc)
+		goto usage;
+
+	while (strbuf_getline(&sb, stdin) != EOF) {
+		line_nr++;
+		if (bundle_uri_parse_line(&list, sb.buf) < 0)
+			err = error("bad line: '%s'", sb.buf);
+	}
+
+	for_each_string_list_item(item, &list) {
+		struct string_list_item *kv_item;
+		struct string_list *kv = item->util;
+
+		fprintf(stdout, "%s", item->string);
+		if (!kv) {
+			fprintf(stdout, "\n");
+			continue;
+		}
+		for_each_string_list_item(kv_item, kv) {
+			const char *k = kv_item->string;
+			const char *v = kv_item->util;
+
+			if (v)
+				fprintf(stdout, " [kv: %s => %s]", k, v);
+			else
+				fprintf(stdout, " [attr: %s]", k);
+		}
+		fprintf(stdout, "\n");
+	}
+	strbuf_release(&sb);
+
+	bundle_uri_string_list_clear(&list);
+
+	return err < 0 ? 1 : 0;
+usage:
+	usage_with_options(usage, options);
+}
+
+int cmd__bundle_uri(int argc, const char **argv)
+{
+	const char *usage[] = {
+		"test-tool bundle-uri <subcommand> [<options>]",
+		NULL
+	};
+	struct option options[] = {
+		OPT_END(),
+	};
+
+	argc = parse_options(argc, argv, NULL, options, usage,
+			     PARSE_OPT_STOP_AT_NON_OPTION |
+			     PARSE_OPT_KEEP_ARGV0);
+	if (argc == 1)
+		goto usage;
+
+	if (!strcmp(argv[1], "parse"))
+		return cmd__bundle_uri_parse(argc - 1, argv + 1);
+	error("there is no test-tool bundle-uri tool '%s'", argv[1]);
+
+usage:
+	usage_with_options(usage, options);
+}
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index 3ce5585e53a..b6e1ee7b253 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -17,6 +17,7 @@ static struct test_cmd cmds[] = {
 	{ "advise", cmd__advise_if_enabled },
 	{ "bitmap", cmd__bitmap },
 	{ "bloom", cmd__bloom },
+	{ "bundle-uri", cmd__bundle_uri },
 	{ "chmtime", cmd__chmtime },
 	{ "config", cmd__config },
 	{ "crontab", cmd__crontab },
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index 9f0f5228508..ef839ac7262 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -7,6 +7,7 @@
 int cmd__advise_if_enabled(int argc, const char **argv);
 int cmd__bitmap(int argc, const char **argv);
 int cmd__bloom(int argc, const char **argv);
+int cmd__bundle_uri(int argc, const char **argv);
 int cmd__chmtime(int argc, const char **argv);
 int cmd__config(int argc, const char **argv);
 int cmd__crontab(int argc, const char **argv);
diff --git a/t/t5750-bundle-uri-parse.sh b/t/t5750-bundle-uri-parse.sh
new file mode 100755
index 00000000000..70fd1b398e9
--- /dev/null
+++ b/t/t5750-bundle-uri-parse.sh
@@ -0,0 +1,153 @@
+#!/bin/sh
+
+test_description="Test bundle-uri bundle_uri_parse_line()"
+
+TEST_NO_CREATE_REPO=1
+TEST_PASSES_SANITIZE_LEAK=true
+. ./test-lib.sh
+
+test_expect_success 'bundle_uri_parse_line() just URIs' '
+	cat >in <<-\EOF &&
+	http://example.com/bundle.bdl
+	https://example.com/bundle.bdl
+	file:///usr/share/git/bundle.bdl
+	EOF
+
+	# For the simple case
+	cp in expect &&
+
+	test-tool bundle-uri parse <in >actual 2>err &&
+	test_must_be_empty err &&
+	test_cmp expect actual
+'
+
+test_expect_success 'bundle_uri_parse_line() with attributes' '
+	cat >in <<-\EOF &&
+	http://example.com/bundle1.bdl attr
+	http://example.com/bundle2.bdl ibute
+	EOF
+
+	cat >expect <<-\EOF &&
+	http://example.com/bundle1.bdl [attr: attr]
+	http://example.com/bundle2.bdl [attr: ibute]
+	EOF
+
+	test-tool bundle-uri parse <in >actual 2>err &&
+	test_must_be_empty err &&
+	test_cmp expect actual
+'
+
+test_expect_success 'bundle_uri_parse_line() with attributes and key-value attributes' '
+	cat >in <<-\EOF &&
+	http://example.com/bundle1.bdl x a=b y c=d z e=f a=b
+	EOF
+
+
+	cat >expect <<-\EOF &&
+	http://example.com/bundle1.bdl [attr: x] [kv: a => b] [attr: y] [kv: c => d] [attr: z] [kv: e => f] [kv: a => b]
+	EOF
+
+	test-tool bundle-uri parse <in >actual 2>err &&
+	test_must_be_empty err &&
+	test_cmp expect actual
+'
+
+test_expect_success 'bundle_uri_parse_line() parsing edge cases: extra SP' '
+	cat >in <<-\EOF &&
+	http://example.com/bundle1.bdl one-space
+	http://example.com/bundle2.bdl  two-space
+	http://example.com/bundle3.bdl   three-space
+	EOF
+
+	cat >err.expect <<-\EOF &&
+	error: bundle-uri: column 1: got an empty attribute (full line was '\''http://example.com/bundle2.bdl  two-space'\'')
+	error: bad line: '\''http://example.com/bundle2.bdl  two-space'\''
+	error: bundle-uri: column 1: got an empty attribute (full line was '\''http://example.com/bundle3.bdl   three-space'\'')
+	error: bad line: '\''http://example.com/bundle3.bdl   three-space'\''
+	EOF
+
+	cat >expect <<-\EOF &&
+	http://example.com/bundle1.bdl [attr: one-space]
+	EOF
+
+	test_must_fail test-tool bundle-uri parse <in >actual 2>err.actual &&
+	test_cmp err.expect err.actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'bundle_uri_parse_line() parsing edge cases: empty lines' '
+	cat >in <<-\EOF &&
+	http://example.com/bundle1.bdl
+
+	http://example.com/bundle2.bdl a=b
+
+	http://example.com/bundle3.bdl
+	EOF
+
+	cat >err.expect <<-\EOF &&
+	error: bundle-uri: got an empty line
+	error: bad line: '\'''\''
+	error: bundle-uri: got an empty line
+	error: bad line: '\'''\''
+	EOF
+
+	# We fail, but try to continue parsing regardless
+	cat >expect <<-\EOF &&
+	http://example.com/bundle1.bdl
+	http://example.com/bundle2.bdl [kv: a => b]
+	http://example.com/bundle3.bdl
+	EOF
+
+	test_must_fail test-tool bundle-uri parse <in >actual 2>err.actual &&
+	test_cmp err.expect err.actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'bundle_uri_parse_line() parsing edge cases: empty URIs' '
+	sed "s/> //" >in <<-\EOF &&
+	http://example.com/bundle1.bdl
+	>  a=b
+	http://example.com/bundle3.bdl a=b
+	EOF
+
+	cat >err.expect <<-\EOF &&
+	error: bundle-uri: got an empty URI component
+	error: bad line: '\'' a=b'\''
+	EOF
+
+	# We fail, but try to continue parsing regardless
+	cat >expect <<-\EOF &&
+	http://example.com/bundle1.bdl
+	http://example.com/bundle3.bdl [kv: a => b]
+	EOF
+
+	test_must_fail test-tool bundle-uri parse <in >actual 2>err.actual &&
+	test_cmp err.expect err.actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'bundle_uri_parse_line() parsing edge cases: multiple = in key-values' '
+	cat >in <<-\EOF &&
+	http://example.com/bundle1.bdl k=v=extra
+	http://example.com/bundle2.bdl a=b k=v=extra c=d
+	http://example.com/bundle3.bdl kv=ok
+	EOF
+
+	cat >err.expect <<-\EOF &&
+	error: bundle-uri: column 1: '\''k=v=extra'\'' more than one '\''='\'' character (full line was '\''http://example.com/bundle1.bdl k=v=extra'\'')
+	error: bad line: '\''http://example.com/bundle1.bdl k=v=extra'\''
+	error: bundle-uri: column 2: '\''k=v=extra'\'' more than one '\''='\'' character (full line was '\''http://example.com/bundle2.bdl a=b k=v=extra c=d'\'')
+	error: bad line: '\''http://example.com/bundle2.bdl a=b k=v=extra c=d'\''
+	EOF
+
+	# We fail, but try to continue parsing regardless
+	cat >expect <<-\EOF &&
+	http://example.com/bundle3.bdl [kv: kv => ok]
+	EOF
+
+	test_must_fail test-tool bundle-uri parse <in >actual 2>err.actual &&
+	test_cmp err.expect err.actual &&
+	test_cmp expect actual
+'
+
+test_done
-- 
2.33.1.1511.gd15d1b313a6

