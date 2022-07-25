Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8907CC43334
	for <git@archiver.kernel.org>; Mon, 25 Jul 2022 12:39:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232991AbiGYMjT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Jul 2022 08:39:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235107AbiGYMjQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jul 2022 08:39:16 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E919A1A83F
        for <git@vger.kernel.org>; Mon, 25 Jul 2022 05:39:10 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id l23so20349959ejr.5
        for <git@vger.kernel.org>; Mon, 25 Jul 2022 05:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CpAZbLrDCQjHbpdXOGSzpE3zbzjplAN91rp22KZF0Dg=;
        b=JWs13T1G89Dp2K8mJNySUKRzrOz/1B/Wibtk0hWDgcTnWju1QCFs7TDmjMkur1b8gc
         7+uKK6Zko5kPULr32rmmm2pwZADmgjHyOuYtYmPjog0A/3RLYIHKxUGJ/b9zNGS4YUXy
         8u2fuXFi9fuEMbsv/E41OTtKJu8DSjIRs5jbvqy+bcHRtymkU6T+zlJ+sx6A2+rLMpLf
         ZEKbQqssViMJYBw18abPRwOKwQU2EKt91CHzar5PILyuvRZSTb80kr07ALn7r+rv+Q2g
         +s/Yzy0d6r1N4fpVB5XBokSwZnpQ49BjzRQKtMpHluqhDd52P/7Flv6I1xE80o/jSMtz
         WB4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CpAZbLrDCQjHbpdXOGSzpE3zbzjplAN91rp22KZF0Dg=;
        b=nDxqUrpIrkxkJnypjRIEVWqWJ4ITZUHt0TC/w2NEQSd1VzaLjolidODVrjpeoZb6S+
         YE9KTn19g0T2bvQj0/vRElQocFhKlN8MrotODXGfAqeKS56Kl4XIRHhqqMNJiIz9FzhA
         Z01UoTpmW99LEl7caHCv85F+E7b1CYPtuQR9cZSNhuw524beHNGhIOLoZJqeFhwrVzkA
         qsvKgDtLFZlS3C2jjwdpM2aZxCtKMGBtCD2izYngVBvsPu69cg3BsN0od5LO1m61QqQS
         R3HSdCcwdkJ7NneznHUPd3iv7NEj2IARkzfV0i8GQcWDqHNySDRXlRqrRkEAFLs/vIjQ
         +fPg==
X-Gm-Message-State: AJIora/yCazm/H7rjnsuZTiXFz5EY9cpFg3QdUPU2WfsESgJurkS1zee
        OFJWcy+Edx6hawn5+tSB154gSJtL4BA=
X-Google-Smtp-Source: AGRyM1ttqcNy7z09uQ7tiEH+W6Pu0sLc0BkdKcWOntHd+DLZlyLEsqpX5TvD7VQ+IgnpMsOh1nhXPg==
X-Received: by 2002:a17:907:75e3:b0:72b:198a:b598 with SMTP id jz3-20020a17090775e300b0072b198ab598mr9947920ejc.401.1658752749447;
        Mon, 25 Jul 2022 05:39:09 -0700 (PDT)
Received: from localhost (94-21-23-94.pool.digikabel.hu. [94.21.23.94])
        by smtp.gmail.com with ESMTPSA id e2-20020a170906314200b0072b3406e9c2sm5328114eje.95.2022.07.25.05.39.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 05:39:09 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 04/20] t0040-parse-options: test parse_options() with various 'parse_opt_flags'
Date:   Mon, 25 Jul 2022 14:38:41 +0200
Message-Id: <20220725123857.2773963-5-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.37.1.633.g6a0fa73e39
In-Reply-To: <20220725123857.2773963-1-szeder.dev@gmail.com>
References: <20220725123857.2773963-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In 't0040-parse-options.sh' we thoroughly test the parsing of all
types and forms of options, but in all those tests parse_options() is
always invoked with a 0 flags parameter.

Add a few tests to demonstrate how various 'enum parse_opt_flags'
values are supposed to influence option parsing.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 t/helper/test-parse-options.c | 61 ++++++++++++++++++++++++++++++
 t/helper/test-tool.c          |  1 +
 t/helper/test-tool.h          |  1 +
 t/t0040-parse-options.sh      | 70 +++++++++++++++++++++++++++++++++++
 4 files changed, 133 insertions(+)

diff --git a/t/helper/test-parse-options.c b/t/helper/test-parse-options.c
index 48d3cf6692..32b906bd6a 100644
--- a/t/helper/test-parse-options.c
+++ b/t/helper/test-parse-options.c
@@ -192,3 +192,64 @@ int cmd__parse_options(int argc, const char **argv)
 
 	return ret;
 }
+
+static int parse_options_flags__cmd(int argc, const char **argv,
+				    enum parse_opt_flags test_flags)
+{
+	const char *usage[] = {
+		"<...> cmd [options]",
+		NULL
+	};
+	int opt = 0;
+	const struct option options[] = {
+		OPT_INTEGER('o', "opt", &opt, "an integer option"),
+		OPT_END()
+	};
+
+	argc = parse_options(argc, argv, NULL, options, usage, test_flags);
+
+	printf("opt: %d\n", opt);
+	for (int i = 0; i < argc; i++)
+		printf("arg %02d: %s\n", i, argv[i]);
+
+	return 0;
+}
+
+static enum parse_opt_flags test_flags = 0;
+static const struct option test_flag_options[] = {
+	OPT_GROUP("flag-options:"),
+	OPT_BIT(0, "keep-dashdash", &test_flags,
+		"pass PARSE_OPT_KEEP_DASHDASH to parse_options()",
+		PARSE_OPT_KEEP_DASHDASH),
+	OPT_BIT(0, "stop-at-non-option", &test_flags,
+		"pass PARSE_OPT_STOP_AT_NON_OPTION to parse_options()",
+		PARSE_OPT_STOP_AT_NON_OPTION),
+	OPT_BIT(0, "keep-argv0", &test_flags,
+		"pass PARSE_OPT_KEEP_ARGV0 to parse_options()",
+		PARSE_OPT_KEEP_ARGV0),
+	OPT_BIT(0, "keep-unknown", &test_flags,
+		"pass PARSE_OPT_KEEP_UNKNOWN to parse_options()",
+		PARSE_OPT_KEEP_UNKNOWN),
+	OPT_BIT(0, "no-internal-help", &test_flags,
+		"pass PARSE_OPT_NO_INTERNAL_HELP to parse_options()",
+		PARSE_OPT_NO_INTERNAL_HELP),
+	OPT_END()
+};
+
+int cmd__parse_options_flags(int argc, const char **argv)
+{
+	const char *usage[] = {
+		"test-tool parse-options-flags [flag-options] cmd [options]",
+		NULL
+	};
+
+	argc = parse_options(argc, argv, NULL, test_flag_options, usage,
+			     PARSE_OPT_STOP_AT_NON_OPTION);
+
+	if (argc == 0 || strcmp(argv[0], "cmd")) {
+		error("'cmd' is mandatory");
+		usage_with_options(usage, test_flag_options);
+	}
+
+	return parse_options_flags__cmd(argc, argv, test_flags);
+}
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index 318fdbab0c..6e62282b60 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -51,6 +51,7 @@ static struct test_cmd cmds[] = {
 	{ "online-cpus", cmd__online_cpus },
 	{ "pack-mtimes", cmd__pack_mtimes },
 	{ "parse-options", cmd__parse_options },
+	{ "parse-options-flags", cmd__parse_options_flags },
 	{ "parse-pathspec-file", cmd__parse_pathspec_file },
 	{ "partial-clone", cmd__partial_clone },
 	{ "path-utils", cmd__path_utils },
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index bb79927163..d8e8403d70 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -41,6 +41,7 @@ int cmd__oidtree(int argc, const char **argv);
 int cmd__online_cpus(int argc, const char **argv);
 int cmd__pack_mtimes(int argc, const char **argv);
 int cmd__parse_options(int argc, const char **argv);
+int cmd__parse_options_flags(int argc, const char **argv);
 int cmd__parse_pathspec_file(int argc, const char** argv);
 int cmd__partial_clone(int argc, const char **argv);
 int cmd__path_utils(int argc, const char **argv);
diff --git a/t/t0040-parse-options.sh b/t/t0040-parse-options.sh
index ed2fb620a9..569e906579 100755
--- a/t/t0040-parse-options.sh
+++ b/t/t0040-parse-options.sh
@@ -456,4 +456,74 @@ test_expect_success '--end-of-options treats remainder as args' '
 	    --end-of-options --verbose
 '
 
+test_expect_success 'KEEP_DASHDASH works' '
+	test-tool parse-options-flags --keep-dashdash cmd --opt=1 -- --opt=2 --unknown >actual &&
+	cat >expect <<-\EOF &&
+	opt: 1
+	arg 00: --
+	arg 01: --opt=2
+	arg 02: --unknown
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'KEEP_ARGV0 works' '
+	test-tool parse-options-flags --keep-argv0 cmd arg0 --opt=3 >actual &&
+	cat >expect <<-\EOF &&
+	opt: 3
+	arg 00: cmd
+	arg 01: arg0
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'STOP_AT_NON_OPTION works' '
+	test-tool parse-options-flags --stop-at-non-option cmd --opt=4 arg0 --opt=5 --unknown >actual &&
+	cat >expect <<-\EOF &&
+	opt: 4
+	arg 00: arg0
+	arg 01: --opt=5
+	arg 02: --unknown
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'KEEP_UNKNOWN works' '
+	test-tool parse-options-flags --keep-unknown cmd --unknown=1 --opt=6 -u2 >actual &&
+	cat >expect <<-\EOF &&
+	opt: 6
+	arg 00: --unknown=1
+	arg 01: -u2
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'NO_INTERNAL_HELP works for -h' '
+	test_expect_code 129 test-tool parse-options-flags --no-internal-help cmd -h 2>err &&
+	cat err &&
+	grep "^error: unknown switch \`h'\''" err &&
+	grep "^usage: " err
+'
+
+for help_opt in help help-all
+do
+	test_expect_success "NO_INTERNAL_HELP works for --$help_opt" "
+		test_expect_code 129 test-tool parse-options-flags --no-internal-help cmd --$help_opt 2>err &&
+		cat err &&
+		grep '^error: unknown option \`'$help_opt\' err &&
+		grep '^usage: ' err
+	"
+done
+
+test_expect_success 'KEEP_UNKNOWN | NO_INTERNAL_HELP works' '
+	test-tool parse-options-flags --keep-unknown --no-internal-help cmd -h --help --help-all >actual &&
+	cat >expect <<-\EOF &&
+	opt: 0
+	arg 00: -h
+	arg 01: --help
+	arg 02: --help-all
+	EOF
+	test_cmp expect actual
+'
+
 test_done
-- 
2.37.1.633.g6a0fa73e39

