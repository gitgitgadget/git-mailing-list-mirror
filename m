Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F075CC4338F
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 15:07:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA03F60EE5
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 15:07:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241811AbhHEPIA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Aug 2021 11:08:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241788AbhHEPHy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Aug 2021 11:07:54 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D0C1C0613D5
        for <git@vger.kernel.org>; Thu,  5 Aug 2021 08:07:39 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id l18so7017063wrv.5
        for <git@vger.kernel.org>; Thu, 05 Aug 2021 08:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ymcFBiqCpg2n5b6B373QBftuPLgXHZVVsLtynEOn+iY=;
        b=LXGhtMgryiK7OJ9DJ/JCj2X+rMAAajnxrw2kRfUV/86i1Zm5Hthaev+hKaYFrACpDU
         nZKuMst05h21FBUMFly63oUiAAhYr2Zgm9trf1BqC917VL5K6hlfuoSs35W9L+w0qCxs
         jNfAWLZSO2CF2thebtgkMY918HfKda6OvakbdES51ihQeyg0VDq7zDZmoow8KN5J61vQ
         bcxJ6XgKms3LqoLpZdTBUtdN/bqqXH9ZF+vP2S02ZxGHQnXdYMYrm0FWswuJonnnHhYh
         SN+LMFq3OXP+Xhvt9jgTirhtB2nc97q1cOP9B1gx16lA8jMtpmqFirtEp8fo+SbNPgvd
         7f5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ymcFBiqCpg2n5b6B373QBftuPLgXHZVVsLtynEOn+iY=;
        b=da/q2AeJZw2sHpbHKzKexvQ1BxJFrv639UDGKxmuAJGn3MPBERa6fhd7zQC8FskZHB
         3x0/5bMnXPRgGLAQK/D+/rENIP3EUWF/SUivvuFi4ZUM1/1yEGSjKFN2SNXTuId1iREV
         XZBXL5y2xbfRBKJmBS4f134cXceTjFvS2C+fdhtB0Bk1T8lYLg6gNo37E5Jt+yQqz+nY
         QCjzq9ZU6eMVcdRelXY9oG/V9YlyS3msn0vbYZlacTuVTUqSnBKbUCsCJ8R5QQa6XIPQ
         XK+MjLgzj2kAT0N/Pd99E60xIa4wfBHqytXp4pMcvU0px6uCKpF/p1fynZIQaco9n1Tq
         y6lQ==
X-Gm-Message-State: AOAM531IrSgxwoEjHy2igW7hbMUx6hPxbhyMXMiC33Mx+lttiwLVSO2S
        kmcm9wMrP4ACRH35ZplvxDX0N+ZdBBzLJQ==
X-Google-Smtp-Source: ABdhPJwrGSUyZ/Iin0IcbGxaaub2UNfUY46B6gwm55Ds6maCcPYGwl/aCQcNoB8A1JncBtErOWGGZg==
X-Received: by 2002:adf:f287:: with SMTP id k7mr5705256wro.206.1628176057548;
        Thu, 05 Aug 2021 08:07:37 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id w4sm6856340wrm.24.2021.08.05.08.07.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Aug 2021 08:07:37 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>,
        Christian Couder <christian.couder@gmail.com>,
        Albert Cui <albertqcui@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH 02/13] bundle-uri client: add "bundle-uri" parsing + tests
Date:   Thu,  5 Aug 2021 17:07:18 +0200
Message-Id: <RFC-patch-02.13-70c2209c10-20210805T150534Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.rc0.646.g585563e77f
In-Reply-To: <RFC-cover-00.13-0000000000-20210805T150534Z-avarab@gmail.com>
References: <RFC-cover-00.13-0000000000-20210805T150534Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a "test-tool bundle-uri parse" which parses the format defined in
the newly specified "bundle-uri" command.

As note in the "bundle-uri" section in protocol-v2.txt we haven't
specified any key-values yet, just URI lines, but we need to make sure
our client doesn't die if this optional data is provided by the
server. Let's add a bundle_uri_parse_line() to do that, in subsequent
commits the actual client code in {connect,transport}.c will make use
of it.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile                    |  1 +
 bundle-uri.c                | 80 ++++++++++++++++++++++++++++++
 bundle-uri.h                | 16 ++++++
 t/helper/test-bundle-uri.c  | 80 ++++++++++++++++++++++++++++++
 t/helper/test-tool.c        |  1 +
 t/helper/test-tool.h        |  1 +
 t/t5750-bundle-uri-parse.sh | 98 +++++++++++++++++++++++++++++++++++++
 7 files changed, 277 insertions(+)
 create mode 100644 t/helper/test-bundle-uri.c
 create mode 100755 t/t5750-bundle-uri-parse.sh

diff --git a/Makefile b/Makefile
index 877c6c47b6..6d3612b962 100644
--- a/Makefile
+++ b/Makefile
@@ -699,6 +699,7 @@ PROGRAMS += $(patsubst %.o,git-%$X,$(PROGRAM_OBJS))
 TEST_BUILTINS_OBJS += test-advise.o
 TEST_BUILTINS_OBJS += test-bitmap.o
 TEST_BUILTINS_OBJS += test-bloom.o
+TEST_BUILTINS_OBJS += test-bundle-uri.o
 TEST_BUILTINS_OBJS += test-chmtime.o
 TEST_BUILTINS_OBJS += test-config.o
 TEST_BUILTINS_OBJS += test-crontab.o
diff --git a/bundle-uri.c b/bundle-uri.c
index 2d93e8b003..d48bb78012 100644
--- a/bundle-uri.c
+++ b/bundle-uri.c
@@ -63,3 +63,83 @@ int bundle_uri_command(struct repository *r,
 
 	return 0;
 }
+
+/**
+ * General API for {transport,connect}.c etc.
+ */
+int bundle_uri_parse_line(struct string_list *bundle_uri, const char *line)
+{
+	int i;
+	struct string_list uri = STRING_LIST_INIT_DUP;
+	struct string_list_item *item = NULL;
+	int err = 0;
+
+	/*
+	 * Right now we don't understand anything beyond the first SP,
+	 * but let's be tolerant and ignore any future unknown
+	 * fields. See the "MUST" note about "bundle-feature-key" in
+	 * technical/protocol-v2.txt
+	 */
+	if (string_list_split(&uri, line, ' ', -1) < 1)
+		return error(_("bundle-uri line not in SP-delimited format: %s"), line);
+
+	for (i = 0; i < uri.nr; i++) {
+		struct string_list kv = STRING_LIST_INIT_DUP;
+		struct string_list_item *kv_item = NULL;
+		const char *arg = uri.items[i].string;
+		int fields;
+
+		/*
+		 * The "string" for each list item is the parsed URI
+		 * at the start of the line
+		 */
+		if (i == 0) {
+			item = string_list_append(bundle_uri, arg);
+			continue;
+		}
+
+		/*
+		 * Anything else on the line is keys or key-value
+		 * pairs separated by "=".
+		 *
+		 * Let's parse the format, even if we don't understand
+		 * any of the keys or values yet.
+		 */
+		assert(item);
+		arg = uri.items[i].string;
+		if (i == 1) {
+			item->util = xcalloc(1, sizeof(struct string_list));
+			string_list_init(item->util, 1);
+		}
+
+		fields = string_list_split(&kv, arg, '=', 2);
+		if (fields < 1 || fields > 2) {
+			err = error("expected `k` or `k=v` in column %d of bundle-uri line '%s', got '%s'",
+				     i, line, arg);
+			string_list_clear(&kv, 0);
+			continue;
+		}
+
+		kv_item = string_list_append(item->util, kv.items[0].string);
+		if (kv.nr == 2)
+			kv_item->util = xstrdup(kv.items[1].string);
+
+		string_list_clear(&kv, 0);
+	}
+	string_list_clear(&uri, 0);
+	return err;
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
index 6a40efeb39..2d271801b8 100644
--- a/bundle-uri.h
+++ b/bundle-uri.h
@@ -4,6 +4,7 @@
 struct repository;
 struct packet_reader;
 struct packet_writer;
+struct string_list;
 
 /**
  * serve.[ch] API.
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
index 0000000000..014da1b6ab
--- /dev/null
+++ b/t/helper/test-bundle-uri.c
@@ -0,0 +1,80 @@
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
+
+	argc = parse_options(argc, argv, NULL, options, usage, 0);
+	if (argc)
+		goto usage;
+
+	while (strbuf_getline(&sb, stdin) != EOF) {
+		if (bundle_uri_parse_line(&list, sb.buf) < 0)
+			err = error("bad line: %s", sb.buf);
+	}
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
index 3ce5585e53..b6e1ee7b25 100644
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
index 9f0f522850..ef839ac726 100644
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
index 0000000000..ef1b9fedea
--- /dev/null
+++ b/t/t5750-bundle-uri-parse.sh
@@ -0,0 +1,98 @@
+#!/bin/sh
+
+test_description="Test bundle-uri bundle_uri_parse_line()"
+
+TEST_NO_CREATE_REPO=1
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
+	http://example.com/bundle1.bdl  two-space
+	http://example.com/bundle1.bdl   three-space
+	EOF
+
+	# We are anal just the one SP
+	cat >expect <<-\EOF &&
+	http://example.com/bundle1.bdl [attr: one-space]
+	http://example.com/bundle1.bdl [attr: ] [attr: two-space]
+	http://example.com/bundle1.bdl [attr: ] [attr: ] [attr: three-space]
+	EOF
+
+	test-tool bundle-uri parse <in >actual 2>err &&
+	test_must_be_empty err &&
+	test_cmp expect actual
+'
+
+test_expect_success 'bundle_uri_parse_line() parsing edge cases: multiple = in key-values' '
+	cat >in <<-\EOF &&
+	http://example.com/bundle1.bdl k=v=extra
+	http://example.com/bundle2.bdl a=b k=v=extra c=d
+	EOF
+
+	cat >err.expect <<-\EOF &&
+	error: expected `k` or `k=v` in column 1 of bundle-uri line '"'"'http://example.com/bundle1.bdl k=v=extra'"'"', got '"'"'k=v=extra'"'"'
+	error: bad line: http://example.com/bundle1.bdl k=v=extra
+	error: expected `k` or `k=v` in column 2 of bundle-uri line '"'"'http://example.com/bundle2.bdl a=b k=v=extra c=d'"'"', got '"'"'k=v=extra'"'"'
+	error: bad line: http://example.com/bundle2.bdl a=b k=v=extra c=d
+	EOF
+
+	# We fail, but try to continue parsing regardless
+	cat >expect <<-\EOF &&
+	http://example.com/bundle1.bdl
+	http://example.com/bundle2.bdl [kv: a => b] [kv: c => d]
+	EOF
+
+	test_must_fail test-tool bundle-uri parse <in >actual 2>err.actual &&
+	test_cmp err.expect err.actual &&
+	test_cmp expect actual
+'
+
+test_done
-- 
2.33.0.rc0.646.g585563e77f

