Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF759C32773
	for <git@archiver.kernel.org>; Fri, 19 Aug 2022 16:33:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353105AbiHSQdO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Aug 2022 12:33:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353017AbiHSQaX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2022 12:30:23 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 801A011BB2B
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 09:04:41 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id gk3so9625371ejb.8
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 09:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=6mBG6oeEPnLpU27Vlq5sUd/TK51DHUZyAgpmipQiFi8=;
        b=JAb+bReW0cV1QzrKIJbonq2FQKmK6Y04xkjPzJKpjKaXKlM/1YBnVcvN9m8y04NXdo
         EX/1OSnx6Qj6gdbbShwSAZLrVd3c82Ijww36Unveafg17WUc3RW76ft+gLy/EcuXsUIJ
         pR/K6kJNDjQCoWj2X+MZwxmZDfetbzp/znUNEa35VyAbjZ6PxCZN+/4P2q/xqVX1nDcT
         pxzF/NbjDUZa58tkUhDvyFZjOaGCBthXDBgIBswOcUO3DUDqW09FmIOzk7b4oD91bDTN
         ljmI5AUPegcfKai9JZlIvF0H89FjXl9UoE9S5mmOsbvXDyZdKWg8g+Dl2eNwnG7ly+DE
         6q+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=6mBG6oeEPnLpU27Vlq5sUd/TK51DHUZyAgpmipQiFi8=;
        b=CdpeyPKY/HgJ2lZGG1WcgF+Y/jEiO/eqKLd79NEnzRAQGMYW0o8MSuJJe/C0umiBy0
         Uh7wqZw7GfR3213DSNau22o8Ex1Lur6dzrMJ/TljtkMfGBfIc+F7DVg4LSGVi4KJeXiI
         1Kc3rL2zbE08QsYVhG5fZGTXUHoIqcJAQKERzwXmrGv0YRzWPB12AqPY7WRUMAXCSCRs
         dJJvLueu6/Y4b8497BL4u5H7ESBK0BCq1zwxBBO++FWnL1ZUm0N59NcCil0HIH5hxice
         mgVeaWjzlhowLFEz0I+Gscrs5NoMI8d7BMBhNS6zo7XS/+qe0i8U41X14bjPwWx/mSAG
         bRyw==
X-Gm-Message-State: ACgBeo3HqBuyjn0bzgsdLrJfI7e76nSU5KG+Ca1R8qydL8G0QXsPzCQf
        tQtJeJVaDe10syWl5phJyi8kWtpo+z8=
X-Google-Smtp-Source: AA6agR4vUjHN/tye9VAF1GmByPKjIc+TIPOtpwytL9JPK2J6/nlMnkUrqwYYCXwjM/vnhmYz0KlI5g==
X-Received: by 2002:a17:907:60c8:b0:730:9efe:ecbd with SMTP id hv8-20020a17090760c800b007309efeecbdmr5136631ejc.90.1660925079529;
        Fri, 19 Aug 2022 09:04:39 -0700 (PDT)
Received: from localhost (84-236-78-250.pool.digikabel.hu. [84.236.78.250])
        by smtp.gmail.com with ESMTPSA id n3-20020a170906b30300b007081282cbd8sm2468520ejz.76.2022.08.19.09.04.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 09:04:39 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 04/20] t0040-parse-options: test parse_options() with various 'parse_opt_flags'
Date:   Fri, 19 Aug 2022 18:03:55 +0200
Message-Id: <20220819160411.1791200-5-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.37.2.817.g36f84ce71d
In-Reply-To: <20220819160411.1791200-1-szeder.dev@gmail.com>
References: <20220725123857.2773963-1-szeder.dev@gmail.com>
 <20220819160411.1791200-1-szeder.dev@gmail.com>
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
 t/helper/test-parse-options.c | 66 +++++++++++++++++++++++++++++++++
 t/helper/test-tool.c          |  1 +
 t/helper/test-tool.h          |  1 +
 t/t0040-parse-options.sh      | 70 +++++++++++++++++++++++++++++++++++
 4 files changed, 138 insertions(+)

diff --git a/t/helper/test-parse-options.c b/t/helper/test-parse-options.c
index 48d3cf6692..88919785d3 100644
--- a/t/helper/test-parse-options.c
+++ b/t/helper/test-parse-options.c
@@ -192,3 +192,69 @@ int cmd__parse_options(int argc, const char **argv)
 
 	return ret;
 }
+
+static void print_args(int argc, const char **argv)
+{
+	for (int i = 0; i < argc; i++)
+		printf("arg %02d: %s\n", i, argv[i]);
+}
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
+	print_args(argc, argv);
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
index ed2fb620a9..8511ce24bb 100755
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
+	grep "^error: unknown switch \`h$SQ" err &&
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
2.37.2.817.g36f84ce71d

