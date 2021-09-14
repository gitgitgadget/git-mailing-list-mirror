Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ADB8C433EF
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 14:43:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 313AA60698
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 14:43:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234964AbhINOos (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Sep 2021 10:44:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235221AbhINOoJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Sep 2021 10:44:09 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98898C0611C4
        for <git@vger.kernel.org>; Tue, 14 Sep 2021 07:39:21 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id j17-20020a05600c1c1100b002e754875260so2730630wms.4
        for <git@vger.kernel.org>; Tue, 14 Sep 2021 07:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=tEEtHAQ8UCYDaO4A/Ch4X+sM3t0MfBKstGjJxvTXvA8=;
        b=eKGy/ROX5WlGmUL9WeZQPe95KILA0zul/XVOFhxQ+hU8SMJMPbMgDXtNQN+CdTeW/9
         5o4DcLuXKSPNRXFHtuoOSvx2IcpikZqze63z/WSOj7k1c6k3HDBk7VZOP9GJTD4b4czy
         tgmyk/G2BwqQhQwdmtYeXtu34weKEtLE3gTX+qPEdNZ4TaA8x1XUDPKS1JLS5foPlkXC
         Wn6uU4ieSmYTYkjnnQkR2nJL4owiHEJCpfdp2kenxXxJfzMbzwyjKwzsww23oh/wuI27
         tBTsVkWUD3OcUhyK/2YCiBITVtPhA9KBO1k7KYlj2dDWrKNVseBpdW0KvU6c2LNLXADr
         g1hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=tEEtHAQ8UCYDaO4A/Ch4X+sM3t0MfBKstGjJxvTXvA8=;
        b=3v17E56B/KzsaGTzHNyeSROv44pRdHqIFUwGktrCstBYi/a7fR+GgNJEEJDzSDxHDO
         VxAaguOBeT1klE2pgP2DFW9YJU6ymq2TxfipQ9nCgrdBESz+yIxC6s0ZzVvsxa2ObYvo
         WPkG/nPYvC84rSWaaLaYQrhLCL1rDwLIyADJI7LgSo6l487gczncEVf85K971de+j4iW
         JMx5MqwyqIgL2J2LE1XjuYwCTfXimAZjSIgHrdnLMsg5qHasRWdjptlblz8hX+Uo/fTn
         4g+dbj3gdH8Aji2RdDnLq9C/UP8ZQX7kQU/n6fZrEN7tbAsxliZ2Yk+nFlqt+PZigVEZ
         EdkQ==
X-Gm-Message-State: AOAM530OwIGFPbqjPNDgOWsyl3MoS8Q6rLNd7PKR1cx43ZxSHXvGrTla
        uVkcdxKrlQolIpOcozoaVWZF8zJWXUU=
X-Google-Smtp-Source: ABdhPJxQm+Uy3t1PixXf8n2fFJCPw/0zFGco/5IMlSB/ZXHGRODlT/cF+S81c61nlqgOhrsDlZTJoQ==
X-Received: by 2002:a7b:ce06:: with SMTP id m6mr2634547wmc.85.1631630360212;
        Tue, 14 Sep 2021 07:39:20 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o7sm1197557wmq.36.2021.09.14.07.39.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 07:39:19 -0700 (PDT)
Message-Id: <14992033d7cf50b3d536f276221be06bbdabc2fe.1631630356.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1005.v4.git.1631630356.gitgitgadget@gmail.com>
References: <pull.1005.v3.git.1631129086.gitgitgadget@gmail.com>
        <pull.1005.v4.git.1631630356.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 14 Sep 2021 14:39:04 +0000
Subject: [PATCH v4 03/15] scalar: create test infrastructure
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

To test the Scalar command, create a test script in contrib/scalar/t
that is executed as `make -C contrib/scalar test`. Since Scalar has no
meaningful capabilities yet, the only test is rather simple. We will add
more tests in subsequent commits that introduce corresponding, new
functionality.

Note: this test script is intended to test `scalar` only lightly, even
after all of the functionality is implemented.

A more comprehensive functional (or: integration) test suite can be
found at https://github.com/microsoft/scalar; It is used in the workflow
https://github.com/microsoft/git/blob/HEAD/.github/workflows/scalar-functional-tests.yml
in Microsoft's Git fork. This test suite performs end-to-end tests with
a real remote repository, and is run as part of the regular CI builds.
Since those tests require some functionality supported only by
Microsoft's Git fork ("GVFS protocol"), there is no intention to port
that fuller test suite to `contrib/scalar/`.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 contrib/scalar/Makefile          | 17 +++++--
 contrib/scalar/t/Makefile        | 78 ++++++++++++++++++++++++++++++++
 contrib/scalar/t/t9099-scalar.sh | 17 +++++++
 3 files changed, 109 insertions(+), 3 deletions(-)
 create mode 100644 contrib/scalar/t/Makefile
 create mode 100755 contrib/scalar/t/t9099-scalar.sh

diff --git a/contrib/scalar/Makefile b/contrib/scalar/Makefile
index 85c186634e9..8620042f281 100644
--- a/contrib/scalar/Makefile
+++ b/contrib/scalar/Makefile
@@ -3,6 +3,7 @@ QUIET_SUBDIR1  =
 
 ifneq ($(findstring s,$(MAKEFLAGS)),s)
 ifndef V
+	QUIET_GEN      = @echo '   ' GEN $@;
 	QUIET_SUBDIR0  = +@subdir=
 	QUIET_SUBDIR1  = ;$(NO_SUBDIR) echo '   ' SUBDIR $$subdir; \
 			 $(MAKE) $(PRINT_DIR) -C $$subdir
@@ -21,7 +22,7 @@ include ../../config.mak.uname
 TARGETS = scalar$(X) scalar.o
 GITLIBS = ../../common-main.o ../../libgit.a ../../xdiff/lib.a
 
-all: scalar$X
+all: scalar$X ../../bin-wrappers/scalar
 
 $(GITLIBS):
 	$(QUIET_SUBDIR0)../.. $(QUIET_SUBDIR1) $(subst ../../,,$@)
@@ -30,9 +31,19 @@ $(TARGETS): $(GITLIBS) scalar.c
 	$(QUIET_SUBDIR0)../.. $(QUIET_SUBDIR1) $(patsubst %,contrib/scalar/%,$@)
 
 clean:
-	$(RM) $(TARGETS)
+	$(RM) $(TARGETS) ../../bin-wrappers/scalar
 	$(RM) scalar.1 scalar.html scalar.xml
 
+../../bin-wrappers/scalar: ../../wrap-for-bin.sh Makefile
+	@mkdir -p ../../bin-wrappers
+	$(QUIET_GEN)sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
+	     -e 's|@@BUILD_DIR@@|$(shell cd ../.. && pwd)|' \
+	     -e 's|@@PROG@@|contrib/scalar/scalar$(X)|' < $< > $@ && \
+	chmod +x $@
+
+test: all
+	$(MAKE) -C t
+
 docs: scalar.html scalar.1
 
 scalar.html: | scalar.1 # prevent them from trying to build `doc.dep` in parallel
@@ -43,4 +54,4 @@ scalar.html scalar.1: scalar.txt
 		../contrib/scalar/$@
 	$(QUIET)test scalar.1 != "$@" || mv ../../Documentation/$@ .
 
-.PHONY: all clean docs FORCE
+.PHONY: all clean docs test FORCE
diff --git a/contrib/scalar/t/Makefile b/contrib/scalar/t/Makefile
new file mode 100644
index 00000000000..6170672bb37
--- /dev/null
+++ b/contrib/scalar/t/Makefile
@@ -0,0 +1,78 @@
+# Run scalar tests
+#
+# Copyright (c) 2005,2021 Junio C Hamano, Johannes Schindelin
+#
+
+-include ../../../config.mak.autogen
+-include ../../../config.mak
+
+SHELL_PATH ?= $(SHELL)
+PERL_PATH ?= /usr/bin/perl
+RM ?= rm -f
+PROVE ?= prove
+DEFAULT_TEST_TARGET ?= test
+TEST_LINT ?= test-lint
+
+ifdef TEST_OUTPUT_DIRECTORY
+TEST_RESULTS_DIRECTORY = $(TEST_OUTPUT_DIRECTORY)/test-results
+else
+TEST_RESULTS_DIRECTORY = ../../../t/test-results
+endif
+
+# Shell quote;
+SHELL_PATH_SQ = $(subst ','\'',$(SHELL_PATH))
+PERL_PATH_SQ = $(subst ','\'',$(PERL_PATH))
+TEST_RESULTS_DIRECTORY_SQ = $(subst ','\'',$(TEST_RESULTS_DIRECTORY))
+
+T = $(sort $(wildcard t[0-9][0-9][0-9][0-9]-*.sh))
+
+all: $(DEFAULT_TEST_TARGET)
+
+test: $(TEST_LINT)
+	$(MAKE) aggregate-results-and-cleanup
+
+prove: $(TEST_LINT)
+	@echo "*** prove ***"; GIT_CONFIG=.git/config $(PROVE) --exec '$(SHELL_PATH_SQ)' $(GIT_PROVE_OPTS) $(T) :: $(GIT_TEST_OPTS)
+	$(MAKE) clean-except-prove-cache
+
+$(T):
+	@echo "*** $@ ***"; GIT_CONFIG=.git/config '$(SHELL_PATH_SQ)' $@ $(GIT_TEST_OPTS)
+
+clean-except-prove-cache:
+	$(RM) -r 'trash directory'.* '$(TEST_RESULTS_DIRECTORY_SQ)'
+	$(RM) -r valgrind/bin
+
+clean: clean-except-prove-cache
+	$(RM) .prove
+
+test-lint: test-lint-duplicates test-lint-executable test-lint-shell-syntax
+
+test-lint-duplicates:
+	@dups=`echo $(T) | tr ' ' '\n' | sed 's/-.*//' | sort | uniq -d` && \
+		test -z "$$dups" || { \
+		echo >&2 "duplicate test numbers:" $$dups; exit 1; }
+
+test-lint-executable:
+	@bad=`for i in $(T); do test -x "$$i" || echo $$i; done` && \
+		test -z "$$bad" || { \
+		echo >&2 "non-executable tests:" $$bad; exit 1; }
+
+test-lint-shell-syntax:
+	@'$(PERL_PATH_SQ)' ../../../t/check-non-portable-shell.pl $(T)
+
+aggregate-results-and-cleanup: $(T)
+	$(MAKE) aggregate-results
+	$(MAKE) clean
+
+aggregate-results:
+	for f in '$(TEST_RESULTS_DIRECTORY_SQ)'/t*-*.counts; do \
+		echo "$$f"; \
+	done | '$(SHELL_PATH_SQ)' ../../../t/aggregate-results.sh
+
+valgrind:
+	$(MAKE) GIT_TEST_OPTS="$(GIT_TEST_OPTS) --valgrind"
+
+test-results:
+	mkdir -p test-results
+
+.PHONY: $(T) aggregate-results clean valgrind
diff --git a/contrib/scalar/t/t9099-scalar.sh b/contrib/scalar/t/t9099-scalar.sh
new file mode 100755
index 00000000000..16f2b72b126
--- /dev/null
+++ b/contrib/scalar/t/t9099-scalar.sh
@@ -0,0 +1,17 @@
+#!/bin/sh
+
+test_description='test the `scalar` command'
+
+TEST_DIRECTORY=$PWD/../../../t
+export TEST_DIRECTORY
+
+# Make it work with --no-bin-wrappers
+PATH=$PWD/..:$PATH
+
+. ../../../t/test-lib.sh
+
+test_expect_success 'scalar shows a usage' '
+	test_expect_code 129 scalar -h
+'
+
+test_done
-- 
gitgitgadget

