Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C1ABC433EF
	for <git@archiver.kernel.org>; Mon, 18 Apr 2022 17:24:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347069AbiDRR1S (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Apr 2022 13:27:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347041AbiDRR1G (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Apr 2022 13:27:06 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6083033E24
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 10:24:12 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id l62-20020a1c2541000000b0038e4570af2fso9141205wml.5
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 10:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=D+Gw7CagraOmL3b8IcmEIeG/bS8ACWFXBCrrI5tilX8=;
        b=TuDqlyxQ3SPV2yYMFpReSw9xjj+DSFD9sGpFoU3+qaBhFtCkiNHL0LwvgNxrSIguf8
         1hdGtOKvrvDN55e5x/piRVAVvhfqOc4qJsvaZZSS+WlceykNniorMA21w8jaGWpExDm6
         cSvxJRyJdOBV3vya7HEYi4FZ57pejXbg6mK1qJxPghKz5FpeIde0KvmTvtA0s6YH/Ftf
         BVtqscscADr8W4jiR9higVpBgR0xpLZ564kldqlUh10G08TAlHZVSUk3m6uC6kAn4INc
         L5hIDJrPlIgViw99vU7svTzWpXqjlAoMROZI12yf4M9qyjTtAzZi2knGBIvFMn+7eKRf
         re6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D+Gw7CagraOmL3b8IcmEIeG/bS8ACWFXBCrrI5tilX8=;
        b=Avl1+QEfDDEV0S2/Hv8AhxOAqQuKWCOt8Px4YOkpirAiLj1Ob+WjhTUSHs5kJr58sd
         Jnpok1luLoc0JL2iJizUCuJaOopf07BCouZDKOAybq6MzVrE7lraIbxzn9cfZUu3tTf+
         fkJ35tHK60cI8c6u85jLumM1FUn0JSI8eY3ZdahfaWgEFW/qccAoAgYJWgVNwmLf8L81
         jE0ArlqW0gp9y07vRwldJV7LAO8UNZJZFPtlwa97RD+FRJAbh70N2y/cXILJ0G0ITwZy
         EkITzFVyzbUlOzX37YiVGSywKMrUJ/P9TlRAPWm4HGIW5Ww+204BI4XwgCgJR/JyASY6
         likg==
X-Gm-Message-State: AOAM532RbXC4rQsIkZvBnRgtoz6S7B4au1mM9y2Z2YbZrlJ+JDhwi0ZD
        OMUSAYY+R7H7QYh0pAjVYCVaotu0WAjbNg==
X-Google-Smtp-Source: ABdhPJylqd1xBzwX8mcPGDfUsnBJnA9zEYv5+tV0NttiYgMh9/Jrj8kjhbcSuZnn4VQSfUU2L0E2Aw==
X-Received: by 2002:a05:600c:6011:b0:38e:bc5f:5197 with SMTP id az17-20020a05600c601100b0038ebc5f5197mr12366523wmb.37.1650302650616;
        Mon, 18 Apr 2022 10:24:10 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m20-20020a05600c3b1400b0038ebbbb2ad2sm16803066wms.44.2022.04.18.10.24.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 10:24:09 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Albert Cui <albertqcui@gmail.com>,
        "Robin H . Johnson" <robbat2@gentoo.org>,
        Teng Long <dyroneteng@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH v2 10/36] bundle-uri client: add "bundle-uri" parsing + tests
Date:   Mon, 18 Apr 2022 19:23:27 +0200
Message-Id: <RFC-patch-v2-10.36-2a487981328-20220418T165545Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.0.rc2.902.g60576bbc845
In-Reply-To: <RFC-cover-v2-00.36-00000000000-20220418T165545Z-avarab@gmail.com>
References: <RFC-cover-v2-00.13-00000000000-20220311T155841Z-avarab@gmail.com> <RFC-cover-v2-00.36-00000000000-20220418T165545Z-avarab@gmail.com>
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
index 8f27310836d..c8a14793005 100644
--- a/Makefile
+++ b/Makefile
@@ -706,6 +706,7 @@ PROGRAMS += $(patsubst %.o,git-%$X,$(PROGRAM_OBJS))
 TEST_BUILTINS_OBJS += test-advise.o
 TEST_BUILTINS_OBJS += test-bitmap.o
 TEST_BUILTINS_OBJS += test-bloom.o
+TEST_BUILTINS_OBJS += test-bundle-uri.o
 TEST_BUILTINS_OBJS += test-chmtime.o
 TEST_BUILTINS_OBJS += test-config.o
 TEST_BUILTINS_OBJS += test-crontab.o
diff --git a/bundle-uri.c b/bundle-uri.c
index ff054ddc690..33386769f55 100644
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
+				err = error("bundle-uri: column %"PRIuMAX": got an empty attribute (full line was '%s')",
+					    (uintmax_t)i, line);
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
+			err = error("bundle-uri: column %"PRIuMAX": '%s' more than one '=' character (full line was '%s')",
+				    (uintmax_t)i, arg, line);
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
index 5a7e556a0ba..be6d1df97ff 100644
--- a/bundle-uri.h
+++ b/bundle-uri.h
@@ -3,6 +3,7 @@
 #include "repository.h"
 #include "pkt-line.h"
 #include "strbuf.h"
+#include "string-list.h"
 
 /**
  * API used by serve.[ch].
@@ -10,4 +11,19 @@
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
index 0424f7adf5d..bff823fbd3e 100644
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
index c876e8246fb..eb747e07dd1 100644
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
2.36.0.rc2.902.g60576bbc845

