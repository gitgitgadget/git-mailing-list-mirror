Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14D8BC43381
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 16:03:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 011796525F
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 16:03:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231968AbhCIQCv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Mar 2021 11:02:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231906AbhCIQCj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Mar 2021 11:02:39 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD7FCC06175F
        for <git@vger.kernel.org>; Tue,  9 Mar 2021 08:02:38 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id b18so16655890wrn.6
        for <git@vger.kernel.org>; Tue, 09 Mar 2021 08:02:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MdcKPBZMIW3rJbCamAs4h4GpSS3BajxXL0/C0vL0p78=;
        b=tyDppdnxPWQjPh/pVkDeSFIWdnRYfo+rtXppQz6KdmkqfW1meGVoqoijWykt3f9XBA
         QWgkjDwrLWxw6aMxdtA+YNopk0p8JpxG0MBHHYFzrJ0aDLYRuH5Bbk8nRHxk/r/u/Zve
         PSrbHDKpXT9THVzyOlgxflYEufsJbnNGnrmc9O9u6tN/Ae5k1UJAB+59Otl9JDkNVi8l
         BCldmuMmGkX5qi4Eb6kfhEqXnBU5yHTzWgGTZz5DQB382HB7UImpR8Z4oyiVB6vqh/ZZ
         y5v3J9r+0GCUyZ2gq1jyl11PIWTR4KfdqehY49yFF4z4tttGTs8in3K+NH47um3nQ83N
         E7nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MdcKPBZMIW3rJbCamAs4h4GpSS3BajxXL0/C0vL0p78=;
        b=eCfPgm2vV0yZU/R2iut3xv9WMOpmULYyNOpThby3cbUkHNok6JcnQoOdAZFVPpRUov
         o8vZSSX7pbu+ZqkjYHv8aA6fsi1/EMAtDegORKWzq1FfLTYMtDyXXZXbcJjU9T5KR8FA
         eup3kU6Ur8tl5HXWJXTHKYV4Axj8F3K/oiU4+UvZBegKujPOj0IHITfEzvRMwIOQGtoM
         oIL9zJ+ujdZMQF6I+9o6oueJ6PgpjcW9rr9vAA/YqcWAG26YvZjsrkcWO18SR3DkZW/v
         z3C6w2jL0lO8PdaZ6EjtBJruEJmJWNOvkS6cT5/gHcI3nFJG1td8nOCnp4CP+YnfGgg7
         yE3Q==
X-Gm-Message-State: AOAM532peEhpVhAVwJpddHly6AXMjAju0niimyxXk4NnuFrUEgH1NI/Y
        66SRw2fEgF/1ICuiTpQPSvnk9hnvrm3EEw==
X-Google-Smtp-Source: ABdhPJzXIj2QERM4dkvfJnt9MEHdn1inWuPXecQyTUf6UUSsZM/GXvvVFOXxJiMXqq0WJpuKmcFBQQ==
X-Received: by 2002:adf:ef4c:: with SMTP id c12mr29576740wrp.112.1615305754537;
        Tue, 09 Mar 2021 08:02:34 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n6sm5089223wmd.27.2021.03.09.08.02.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 08:02:34 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 4/7] test-lib: add tee with TAP support to test-tool
Date:   Tue,  9 Mar 2021 17:02:16 +0100
Message-Id: <20210309160219.13779-5-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.rc1.210.g0f8085a843c
In-Reply-To: <87r1kzj7xi.fsf@evledraar.gmail.com>
References: <87r1kzj7xi.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a 'test-tool tee' that behaves similarly to 'tee(1)', except that
it supports sanitizing the TAP emitted on stdout.

This is done by assuming that the TAP is emitted by a friendly library
that promises to prefix valid TAP directives with what we're going to
strip with --strip-prefix="".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile             |  1 +
 t/helper/test-tee.c  | 85 ++++++++++++++++++++++++++++++++++++++++++++
 t/helper/test-tool.c |  1 +
 t/helper/test-tool.h |  1 +
 4 files changed, 88 insertions(+)
 create mode 100644 t/helper/test-tee.c

diff --git a/Makefile b/Makefile
index dfb0f1000fa..d26b9d62ee9 100644
--- a/Makefile
+++ b/Makefile
@@ -742,6 +742,7 @@ TEST_BUILTINS_OBJS += test-string-list.o
 TEST_BUILTINS_OBJS += test-submodule-config.o
 TEST_BUILTINS_OBJS += test-submodule-nested-repo-config.o
 TEST_BUILTINS_OBJS += test-subprocess.o
+TEST_BUILTINS_OBJS += test-tee.o
 TEST_BUILTINS_OBJS += test-trace2.o
 TEST_BUILTINS_OBJS += test-urlmatch-normalization.o
 TEST_BUILTINS_OBJS += test-wildmatch.o
diff --git a/t/helper/test-tee.c b/t/helper/test-tee.c
new file mode 100644
index 00000000000..4ed34e9db93
--- /dev/null
+++ b/t/helper/test-tee.c
@@ -0,0 +1,85 @@
+#include "test-tool.h"
+#include "parse-options.h"
+#include "strbuf.h"
+
+static int line_has_tap(struct strbuf *line)
+{
+	/*
+	 * This is a less permissive version of
+	 * https://metacpan.org/release/Test-Harness/source/lib/TAP/Parser/Grammar.pm
+	 */
+	if (starts_with(line->buf, "ok") ||
+	    starts_with(line->buf, "not ok") ||
+	    starts_with(line->buf, "1..") ||
+	    starts_with(line->buf, "Bail out!") ||
+	    starts_with(line->buf, "TAP version") ||
+	    starts_with(line->buf, "pragma"))
+		return 1;
+	if (starts_with(line->buf, "#"))
+		/*
+		 * We're ignoring comments from now, but might treat them
+		 * specially in the future for sanctioned messaging from the
+		 * test-lib.sh.
+		 */
+		return 0;
+	return  0;
+}
+
+int cmd__tee(int argc, const char **argv)
+{
+	int tap = 0;
+	int escape_stdout = 0, escape_file = 0;
+	char *prefix = NULL;
+	size_t prefix_len = 0;
+	const char *tee_usage[] = {
+		"test-tool tee [<options>] <FILE>",
+		NULL
+	};
+	struct option options[] = {
+		OPT_BOOL(0, "escape-stdout", &escape_stdout,
+			 "escape output on stdout"),
+		OPT_BOOL(0, "escape-file", &escape_file,
+			 "escape output written to file"),
+		OPT_BOOL(0, "tap", &tap,
+			 "output is TAP"),
+		OPT_STRING(0, "prefix", &prefix, "str",
+			   "prefix to strip from the output"),
+		OPT_END()
+	};
+	struct strbuf line = STRBUF_INIT;
+	FILE *logfp = NULL;
+
+	argc = parse_options(argc, argv, NULL, options,
+			     tee_usage, PARSE_OPT_STOP_AT_NON_OPTION);
+	if (argc > 1) {
+		fprintf(stderr, "got bad option: %s\n", argv[0]);
+		usage_with_options(tee_usage, options);
+	}
+	if (prefix)
+		prefix_len = strlen(prefix);
+
+	if (argc)
+		logfp = xfopen(argv[0], "w");
+
+	while (strbuf_getline(&line, stdin) != EOF) {
+		size_t offs = 0;
+		if (prefix && starts_with(line.buf, prefix))
+			offs = prefix_len;
+
+		if (!offs && tap && line_has_tap(&line)) {
+			if (escape_stdout)
+				fprintf(stdout, "\\");
+			if (logfp && escape_file)
+				fprintf(logfp, "\\");
+		}
+
+		fprintf(stdout, "%s\n", line.buf + offs);
+		if (logfp)
+			fprintf(logfp, "%s\n", line.buf + offs);
+	}
+	strbuf_release(&line);
+	if (logfp)
+		fclose(logfp);
+
+	return 0;
+}
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index f97cd9f48a6..1876bad8f42 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -70,6 +70,7 @@ static struct test_cmd cmds[] = {
 	{ "submodule-config", cmd__submodule_config },
 	{ "submodule-nested-repo-config", cmd__submodule_nested_repo_config },
 	{ "subprocess", cmd__subprocess },
+	{ "tee", cmd__tee },
 	{ "trace2", cmd__trace2 },
 	{ "urlmatch-normalization", cmd__urlmatch_normalization },
 	{ "xml-encode", cmd__xml_encode },
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index 28072c0ad5a..9b3c1f75267 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -60,6 +60,7 @@ int cmd__string_list(int argc, const char **argv);
 int cmd__submodule_config(int argc, const char **argv);
 int cmd__submodule_nested_repo_config(int argc, const char **argv);
 int cmd__subprocess(int argc, const char **argv);
+int cmd__tee(int argc, const char **argv);
 int cmd__trace2(int argc, const char **argv);
 int cmd__urlmatch_normalization(int argc, const char **argv);
 int cmd__xml_encode(int argc, const char **argv);
-- 
2.31.0.rc1.210.g0f8085a843c

