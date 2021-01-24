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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52685C43381
	for <git@archiver.kernel.org>; Sun, 24 Jan 2021 17:29:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3857822DD6
	for <git@archiver.kernel.org>; Sun, 24 Jan 2021 17:29:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726160AbhAXR30 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 Jan 2021 12:29:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbhAXR3L (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Jan 2021 12:29:11 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 329A0C061756
        for <git@vger.kernel.org>; Sun, 24 Jan 2021 09:28:31 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id u14so8738874wmq.4
        for <git@vger.kernel.org>; Sun, 24 Jan 2021 09:28:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SSn0T22CqueU07Qc9YFJJF0vG5X6K2OtIRAxqsXZ8UM=;
        b=Q+TLSUUZqLMCPxhSYaUwuNrj/71AvJrYQghUS1NRzUovAjlGi26dxvYBDd74Mcm1T/
         jtXj/sFoPI5aJZZJNcZ2uit5N/EpbxT7Pa/ydEg+BveRzv82/PF2+6USVoDZYOlYd6T3
         zhqkk4RvOD72y567+T0Yi5j2MtGUexJsHVMCKyhNRVjIbWJyfC76AHYnt2heBkHkYLIu
         9sGpdGeh662esMFoMiV/OimhL1xGHVbn7vUanWPWSRQ/Bark+of4/13GnLLND4j6Blrv
         MJMGmYhr58qGwTz7DDpW4nI1rgEju8VCA2AsgRk8n2qVE1zHVbd482dKErF1t33gNeN9
         3nCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SSn0T22CqueU07Qc9YFJJF0vG5X6K2OtIRAxqsXZ8UM=;
        b=T3bJQDNfzmBk+Zk0uIrqmUAZa0CI3ZnDuNmt39z174STaCMWMhsdauq/w+nSURNNAV
         Er9SXJdohdsl+p14O8zDF0SOfeW7auxqNp8LMKqvkvpbtCSaVNLHbUE/QPj+k3bUkjex
         HFaWeR1O4zea0nwtjfwB2mT6Zem/nYIIfBDaDhXMY3R9Nb5jivN5LvOQaPFPUa6AXgQE
         v98+T03TxncR/+jxTFtORlOtTxZP4bdwGj37YNg++d/GmsP5Rmt+xDwhkRLg++MHEnr2
         3bAT+T3AyrhxtdU1mqjvKQLEPXIZ7vW+2wslIhrR5oXazOHTk+u59GLEs3kCxBMc5wWo
         EwKQ==
X-Gm-Message-State: AOAM5335plLSvgFnXnObfsOzXO1RYGFPQ9TcwiqAQCW07vdcb2NH8o3f
        K9ssXxd7xNhCTrE0lT+tfdnBYzpyEyYJcA==
X-Google-Smtp-Source: ABdhPJwx9OawrtuvkzXBZ3cOk9AHQNDKBWQk1bygQBHdnSb9gzwpfS3T9+NdKP1K1684kZdKX/Z7bQ==
X-Received: by 2002:a1c:4057:: with SMTP id n84mr12435356wma.141.1611509309603;
        Sun, 24 Jan 2021 09:28:29 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id z185sm4127332wmb.0.2021.01.24.09.28.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Jan 2021 09:28:28 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Todd Zullinger <tmz@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 2/2] grep/pcre2: better support invalid UTF-8 haystacks
Date:   Sun, 24 Jan 2021 18:28:13 +0100
Message-Id: <20210124172813.9547-3-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <20210124114855.13036-1-avarab@gmail.com>
References: <20210124114855.13036-1-avarab@gmail.com>
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
 grep.c                          | 18 ++++++++++++-
 grep.h                          |  4 +++
 t/helper/test-pcre2-config.c    | 12 +++++++++
 t/helper/test-tool.c            |  1 +
 t/helper/test-tool.h            |  1 +
 t/t7812-grep-icase-non-ascii.sh | 46 ++++++++++++++++++++++++++++++++-
 7 files changed, 81 insertions(+), 2 deletions(-)
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
index efeb6dc58d..ad0af66a26 100644
--- a/grep.c
+++ b/grep.c
@@ -492,7 +492,23 @@ static void compile_pcre2_pattern(struct grep_pat *p, const struct grep_opt *opt
 	}
 	if (!opt->ignore_locale && is_utf8_locale() && has_non_ascii(p->pattern) &&
 	    !(!opt->ignore_case && (p->fixed || p->is_fixed)))
-		options |= PCRE2_UTF;
+		options |= (PCRE2_UTF | PCRE2_MATCH_INVALID_UTF);
+
+	/* Work around https://bugs.exim.org/show_bug.cgi?id=2642 fixed in 10.36 */
+	if (PCRE2_MATCH_INVALID_UTF && options & (PCRE2_UTF | PCRE2_CASELESS)) {
+		struct strbuf buf;
+		int len;
+		int err;
+
+		if ((len = pcre2_config(PCRE2_CONFIG_VERSION, NULL)) < 0)
+			BUG("pcre2_config(..., NULL) failed: %d", len);
+		strbuf_init(&buf, len + 1);
+		if ((err = pcre2_config(PCRE2_CONFIG_VERSION, buf.buf)) < 0)
+			BUG("pcre2_config(..., buf.buf) failed: %d", err);
+		if (versioncmp(buf.buf, "10.36") < 0)
+			options |= PCRE2_NO_START_OPTIMIZE;
+		strbuf_release(&buf);
+	}
 
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

