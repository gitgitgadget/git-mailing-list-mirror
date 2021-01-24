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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76B03C433E0
	for <git@archiver.kernel.org>; Sun, 24 Jan 2021 02:13:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F46422B51
	for <git@archiver.kernel.org>; Sun, 24 Jan 2021 02:13:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726472AbhAXCNu (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Jan 2021 21:13:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbhAXCNh (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Jan 2021 21:13:37 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DF4FC061793
        for <git@vger.kernel.org>; Sat, 23 Jan 2021 18:12:56 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id d16so8110925wro.11
        for <git@vger.kernel.org>; Sat, 23 Jan 2021 18:12:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/pboRxsKgfNSAirMxeF2E7FeLZxextRKJNWowahPAA8=;
        b=rMvxUokkkQAfOVQb/u8CM58SKVHArM3kkOMIjRoaitGcczmvb0Bz137Z6ArmZeWcvV
         rVxIy/dz8vTfLpaaFojp/z3YHbXLc86GRi290yySRvG5pxkE3MvSLg7oIRBVfuYCHX8y
         c4B0ae8B6Rkc0dxeFR3irpMTffZLeR8hvlNPj2NK+NaMlmOdc0jSKB4IP2+F18m6CExj
         GlTXvzzkHaqQ7YFSrPaqa9w7/xhMwdrUkoGAQjeOksXnmDnCfQKmWz6SEtd8S+hhb8N3
         ki+PZPxB1vTidwrFwXfx1c/27u879zSLew7Zg3VP1gzNdaEW3n+xFLzwdcNARyFjT0Qa
         uynQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/pboRxsKgfNSAirMxeF2E7FeLZxextRKJNWowahPAA8=;
        b=YTkHnJnozM9x9olroNhhr6oQcMs8qfr64jIwDhkU1+2XgL1secQsf5MRdKD71OhJZ0
         h15w7OwT0sk2nDhVVuvRK5f2No2d9vCa458TB7PMKO5I0Pd/sUSKTgBcj01ykoe4VLlP
         1h8WVQ5EVxEJoyXUFCfoex8o5nUTaGUF9+cxE+GzLRJduq6fzTDCEfNV0g8rMOfOqLoZ
         kQIoiN7WVndK7p0gHcIg5u1enp4+UoT5Zvcqo9TMySEke5JpjuIX1X6HjccU0iC42SGu
         zDCLbjO471DWr0FByEqR1Ec2wkrAKc5zp3vqx2EYft0IxS8O8GMQAHsf6Qx9t9SVEbm8
         Y+hw==
X-Gm-Message-State: AOAM532Sdzv0F6uxofzcZRhKNCq/CmsbzOlx/hi67CXRe/6sv9kNOPdY
        5GC9mAYxtFI9ZFnOxkenQZPDj6ziLZshTA==
X-Google-Smtp-Source: ABdhPJwZQKfYhOhvObwuos5W7U9rBP+9aAajOmn0+UydntmDpXOPm2b5DYKAzJAc53WdPCisn7Fy8w==
X-Received: by 2002:a5d:47ce:: with SMTP id o14mr11311198wrc.18.1611454374899;
        Sat, 23 Jan 2021 18:12:54 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id z184sm17380129wmg.7.2021.01.23.18.12.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Jan 2021 18:12:54 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Todd Zullinger <tmz@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 4/4] grep/pcre2: better support invalid UTF-8 haystacks
Date:   Sun, 24 Jan 2021 03:12:29 +0100
Message-Id: <20210124021229.25987-5-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <20190726150818.6373-9-avarab@gmail.com>
References: <20190726150818.6373-9-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Improve the support for invalid UTF-8 haystacks given a non-ASCII
needle when using the PCREv2 backend.

This is a more complete fix for a bug I started to fix in
870eea8166 (grep: do not enter PCRE2_UTF mode on fixed matching,
2019-07-26), now that PCREv2 has the PCRE2_MATCH_INVALID_UTF mode we
can make use of it.

This fixes the sort of case described in 8a5999838e (grep: stess test
PCRE v2 on invalid UTF-8 data, 2019-07-26), i.e.:

    - The subject string is non-ASCII (e.g. "ævar")
    - We're under a is_utf8_locale(), e.g. "en_US.UTF-8", not "C"
    - We are using --ignore-case, or we're a non-fixed pattern

If those conditions were satisfied and we matched found non-valid
UTF-8 data PCREv2 might bark on it, in practice this only happened
under the JIT backend (turned on by default on most platforms).

Ultimately this fixes a "regression" in b65abcafc7 ("grep: use PCRE v2
for optimized fixed-string search", 2019-07-01), I'm putting that in
scare-quotes because before then we wouldn't properly support these
complex case-folding, locale etc. cases either, it just broke in
different ways.

There was a bug related to this the PCRE2_NO_START_OPTIMIZE flag fixed
in PCREv2 10.36. It can be worked around by setting the
PCRE2_NO_START_OPTIMIZE flag. Let's do that in those cases, and add
tests for the bug.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile                        |  1 +
 grep.c                          |  8 +++++-
 grep.h                          |  4 +++
 t/helper/test-pcre2-config.c    | 12 +++++++++
 t/helper/test-tool.c            |  1 +
 t/helper/test-tool.h            |  1 +
 t/t7812-grep-icase-non-ascii.sh | 46 ++++++++++++++++++++++++++++++++-
 7 files changed, 71 insertions(+), 2 deletions(-)
 create mode 100644 t/helper/test-pcre2-config.c

diff --git a/Makefile b/Makefile
index 4edfda3e00..42a7ed96e2 100644
--- a/Makefile
+++ b/Makefile
@@ -722,6 +722,7 @@ TEST_BUILTINS_OBJS += test-online-cpus.o
 TEST_BUILTINS_OBJS += test-parse-options.o
 TEST_BUILTINS_OBJS += test-parse-pathspec-file.o
 TEST_BUILTINS_OBJS += test-path-utils.o
+TEST_BUILTINS_OBJS += test-pcre2-config.o
 TEST_BUILTINS_OBJS += test-pkt-line.o
 TEST_BUILTINS_OBJS += test-prio-queue.o
 TEST_BUILTINS_OBJS += test-proc-receive.o
diff --git a/grep.c b/grep.c
index 242b4a3506..305c579aff 100644
--- a/grep.c
+++ b/grep.c
@@ -493,7 +493,13 @@ static void compile_pcre2_pattern(struct grep_pat *p, const struct grep_opt *opt
 	}
 	if (!opt->ignore_locale && is_utf8_locale() && has_non_ascii(p->pattern) &&
 	    (opt->ignore_case || !fixed))
-		options |= PCRE2_UTF;
+		options |= (PCRE2_UTF | PCRE2_MATCH_INVALID_UTF);
+
+	if (PCRE2_MATCH_INVALID_UTF &&
+	    options & (PCRE2_UTF | PCRE2_CASELESS) &&
+	    !(PCRE2_MAJOR >= 10 && PCRE2_MAJOR >= 36))
+		/* Work around https://bugs.exim.org/show_bug.cgi?id=2642 fixed in 10.36 */
+		options |= PCRE2_NO_START_OPTIMIZE;
 
 	p->pcre2_pattern = pcre2_compile((PCRE2_SPTR)p->pattern,
 					 p->patternlen, options, &error, &erroffset,
diff --git a/grep.h b/grep.h
index b5c4e223a8..ade21c8812 100644
--- a/grep.h
+++ b/grep.h
@@ -18,6 +18,10 @@ typedef int pcre2_code;
 typedef int pcre2_match_data;
 typedef int pcre2_compile_context;
 #endif
+#ifndef PCRE2_MATCH_INVALID_UTF
+/* PCRE2_MATCH_* dummy also with !USE_LIBPCRE2, for test-pcre2-config.c */
+#define PCRE2_MATCH_INVALID_UTF 0
+#endif
 #include "thread-utils.h"
 #include "userdiff.h"
 
diff --git a/t/helper/test-pcre2-config.c b/t/helper/test-pcre2-config.c
new file mode 100644
index 0000000000..5258fdddba
--- /dev/null
+++ b/t/helper/test-pcre2-config.c
@@ -0,0 +1,12 @@
+#include "test-tool.h"
+#include "cache.h"
+#include "grep.h"
+
+int cmd__pcre2_config(int argc, const char **argv)
+{
+	if (argc == 2 && !strcmp(argv[1], "has-PCRE2_MATCH_INVALID_UTF")) {
+		int value = PCRE2_MATCH_INVALID_UTF;
+		return !value;
+	}
+	return 1;
+}
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index 9d6d14d929..f97cd9f48a 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -46,6 +46,7 @@ static struct test_cmd cmds[] = {
 	{ "parse-options", cmd__parse_options },
 	{ "parse-pathspec-file", cmd__parse_pathspec_file },
 	{ "path-utils", cmd__path_utils },
+	{ "pcre2-config", cmd__pcre2_config },
 	{ "pkt-line", cmd__pkt_line },
 	{ "prio-queue", cmd__prio_queue },
 	{ "proc-receive", cmd__proc_receive},
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index a6470ff62c..28072c0ad5 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -35,6 +35,7 @@ int cmd__online_cpus(int argc, const char **argv);
 int cmd__parse_options(int argc, const char **argv);
 int cmd__parse_pathspec_file(int argc, const char** argv);
 int cmd__path_utils(int argc, const char **argv);
+int cmd__pcre2_config(int argc, const char **argv);
 int cmd__pkt_line(int argc, const char **argv);
 int cmd__prio_queue(int argc, const char **argv);
 int cmd__proc_receive(int argc, const char **argv);
diff --git a/t/t7812-grep-icase-non-ascii.sh b/t/t7812-grep-icase-non-ascii.sh
index 38457c2e4f..e5d1e4ea68 100755
--- a/t/t7812-grep-icase-non-ascii.sh
+++ b/t/t7812-grep-icase-non-ascii.sh
@@ -57,7 +57,12 @@ test_expect_success GETTEXT_LOCALE,LIBPCRE2 'PCRE v2: setup invalid UTF-8 data'
 	printf "\\200\\n" >invalid-0x80 &&
 	echo "ævar" >expected &&
 	cat expected >>invalid-0x80 &&
-	git add invalid-0x80
+	git add invalid-0x80 &&
+
+	# Test for PCRE2_MATCH_INVALID_UTF bug
+	# https://bugs.exim.org/show_bug.cgi?id=2642
+	printf "\\345Aæ\\n" >invalid-0xe5 &&
+	git add invalid-0xe5
 '
 
 test_expect_success GETTEXT_LOCALE,LIBPCRE2 'PCRE v2: grep ASCII from invalid UTF-8 data' '
@@ -67,6 +72,13 @@ test_expect_success GETTEXT_LOCALE,LIBPCRE2 'PCRE v2: grep ASCII from invalid UT
 	test_cmp expected actual
 '
 
+test_expect_success GETTEXT_LOCALE,LIBPCRE2 'PCRE v2: grep ASCII from invalid UTF-8 data (PCRE2 bug #2642)' '
+	git grep -h "Aæ" invalid-0xe5 >actual &&
+	test_cmp invalid-0xe5 actual &&
+	git grep -h "(*NO_JIT)Aæ" invalid-0xe5 >actual &&
+	test_cmp invalid-0xe5 actual
+'
+
 test_expect_success GETTEXT_LOCALE,LIBPCRE2 'PCRE v2: grep non-ASCII from invalid UTF-8 data' '
 	git grep -h "æ" invalid-0x80 >actual &&
 	test_cmp expected actual &&
@@ -74,9 +86,41 @@ test_expect_success GETTEXT_LOCALE,LIBPCRE2 'PCRE v2: grep non-ASCII from invali
 	test_cmp expected actual
 '
 
+test_expect_success GETTEXT_LOCALE,LIBPCRE2 'PCRE v2: grep non-ASCII from invalid UTF-8 data (PCRE2 bug #2642)' '
+	git grep -h "Aæ" invalid-0xe5 >actual &&
+	test_cmp invalid-0xe5 actual &&
+	git grep -h "(*NO_JIT)Aæ" invalid-0xe5 >actual &&
+	test_cmp invalid-0xe5 actual
+'
+
+test_lazy_prereq PCRE2_MATCH_INVALID_UTF '
+	test-tool pcre2-config has-PCRE2_MATCH_INVALID_UTF
+'
+
 test_expect_success GETTEXT_LOCALE,LIBPCRE2 'PCRE v2: grep non-ASCII from invalid UTF-8 data with -i' '
 	test_might_fail git grep -hi "Æ" invalid-0x80 >actual &&
 	test_might_fail git grep -hi "(*NO_JIT)Æ" invalid-0x80 >actual
 '
 
+test_expect_success GETTEXT_LOCALE,LIBPCRE2,PCRE2_MATCH_INVALID_UTF 'PCRE v2: grep non-ASCII from invalid UTF-8 data with -i' '
+	git grep -hi "Æ" invalid-0x80 >actual &&
+	test_cmp expected actual &&
+	git grep -hi "(*NO_JIT)Æ" invalid-0x80 >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success GETTEXT_LOCALE,LIBPCRE2,PCRE2_MATCH_INVALID_UTF 'PCRE v2: grep non-ASCII from invalid UTF-8 data with -i (PCRE2 bug #2642)' '
+	git grep -hi "Æ" invalid-0xe5 >actual &&
+	test_cmp invalid-0xe5 actual &&
+	git grep -hi "(*NO_JIT)Æ" invalid-0xe5 >actual &&
+	test_cmp invalid-0xe5 actual &&
+
+	# Only the case of grepping the ASCII part in a way that
+	# relies on -i fails
+	git grep -hi "aÆ" invalid-0xe5 >actual &&
+	test_cmp invalid-0xe5 actual &&
+	git grep -hi "(*NO_JIT)aÆ" invalid-0xe5 >actual &&
+	test_cmp invalid-0xe5 actual
+'
+
 test_done
-- 
2.29.2.222.g5d2a92d10f8

