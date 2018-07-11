Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C07A1F85B
	for <e@80x24.org>; Wed, 11 Jul 2018 06:48:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbeGKGuu (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Jul 2018 02:50:50 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:35181 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726480AbeGKGut (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jul 2018 02:50:49 -0400
Received: by mail-io0-f193.google.com with SMTP id q4-v6so22641229iob.2
        for <git@vger.kernel.org>; Tue, 10 Jul 2018 23:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=N403gMZzOUhXc3UtCJwkoREJ5Ow505uh8maaSv+Zepo=;
        b=tJYY3MHI4BdROLVB1hGL/13T5EYuhhYvxJEBeoj7Gxq/0OwWEEXZytp+g5shAtYwjU
         v6ayHz6KJ6GgrNCrwkRio+MUsPK4vWWvkOVKYCZzSTGuyGekyYW60B1qsUOOyqGPWncJ
         A2brPEByETJuAgA+hbZw+s5XtKNL5mkM5a/Y9IBz0tlrqtwFKR7EOtzFbmBO/FRcuMnz
         d+ewJYQAqF1mD+DUQSe1NYthvCWUUf3Ye1ep0VRooaYlW+VyQonNzzEzVqh18XtPgQVZ
         2Fwc3cdb6pjQauL+jAleLLyR+RLJLdZ2qO21CZT0tgQVKpfPa+lDFHcROCR9cdwMH1jP
         T9Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=N403gMZzOUhXc3UtCJwkoREJ5Ow505uh8maaSv+Zepo=;
        b=nXlA0oWQiQf9IMJ6d2LxPhjdzGc3MwmN7H6R7zJ7fVIyIM58hZMBGlorZoETrLVRjp
         YXgWiCgTBmrxEV8M42T5LGAGOLb+7YzCeMoxUBC8/yYNCq74cRDsHHekIM2j7Jk/5DVu
         I0kLVemp4FvueoagKRpQuzu5lVYstXbdW7gjMZ9bzIdjZnNeU09uGzDQ0akrc4ooCaVM
         Cr31kjSfghdu5jByZeWtrP+V75/SAoVTFcbdD0uya8DABegE8t1Eg1j838mtVGYHNtU+
         21fCul21qYXkZrdf24eyGvTyQgBYh2tBn3xbkTzJyIqkfkSicPl8ErODzTheq5UTkbvB
         qPmg==
X-Gm-Message-State: AOUpUlFR40Q4NuQ3MBpWSl7g3wXpjNIRheIRaQ9WRq0xJIWqHT1Z5xNz
        3cpHjn7asb0tTsgZhJwlerpE9A==
X-Google-Smtp-Source: AAOMgpdVxG7o0LMSGz201n+QjcODeHqI29sNxjPyzw2Gv9c0L7ZnlPcr5h/qGSVKwG9XS+7oBy4W3Q==
X-Received: by 2002:a6b:ca85:: with SMTP id a127-v6mr24405581iog.31.1531291683545;
        Tue, 10 Jul 2018 23:48:03 -0700 (PDT)
Received: from localhost.localdomain (user-12l2cs3.cable.mindspring.com. [69.81.51.131])
        by smtp.gmail.com with ESMTPSA id b143-v6sm11308298ioe.66.2018.07.10.23.48.02
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 10 Jul 2018 23:48:03 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Luke Diamand <luke@diamand.org>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 02/10] t/Makefile: add machinery to check correctness of chainlint.sed
Date:   Wed, 11 Jul 2018 02:46:34 -0400
Message-Id: <20180711064642.6933-3-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9
In-Reply-To: <20180711064642.6933-1-sunshine@sunshineco.com>
References: <20180626073001.6555-1-sunshine@sunshineco.com>
 <20180711064642.6933-1-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The --chain-lint option uses heuristics and knowledge of shell syntax to
detect broken &&-chains in subshells by pure textual inspection.
Although the heuristics work well, they are still best-guesses and
future changes could accidentally break assumptions upon which they are
based. To protect against this possibility, tests checking correctness
of the linter itself will be added. As preparation, add a new makefile
"check-chainlint" target and associated machinery.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/.gitignore |  1 +
 t/Makefile   | 25 +++++++++++++++++++++----
 2 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/t/.gitignore b/t/.gitignore
index 4e731dc1e3..348715f0e4 100644
--- a/t/.gitignore
+++ b/t/.gitignore
@@ -1,3 +1,4 @@
 /trash directory*
 /test-results
 /.prove
+/chainlinttmp
diff --git a/t/Makefile b/t/Makefile
index 96317a35f4..c83fd18861 100644
--- a/t/Makefile
+++ b/t/Makefile
@@ -18,8 +18,10 @@ TEST_LINT ?= test-lint
 
 ifdef TEST_OUTPUT_DIRECTORY
 TEST_RESULTS_DIRECTORY = $(TEST_OUTPUT_DIRECTORY)/test-results
+CHAINLINTTMP = $(TEST_OUTPUT_DIRECTORY)/chainlinttmp
 else
 TEST_RESULTS_DIRECTORY = test-results
+CHAINLINTTMP = chainlinttmp
 endif
 
 # Shell quote;
@@ -27,14 +29,17 @@ SHELL_PATH_SQ = $(subst ','\'',$(SHELL_PATH))
 TEST_SHELL_PATH_SQ = $(subst ','\'',$(TEST_SHELL_PATH))
 PERL_PATH_SQ = $(subst ','\'',$(PERL_PATH))
 TEST_RESULTS_DIRECTORY_SQ = $(subst ','\'',$(TEST_RESULTS_DIRECTORY))
+CHAINLINTTMP_SQ = $(subst ','\'',$(CHAINLINTTMP))
 
 T = $(sort $(wildcard t[0-9][0-9][0-9][0-9]-*.sh))
 TGITWEB = $(sort $(wildcard t95[0-9][0-9]-*.sh))
 THELPERS = $(sort $(filter-out $(T),$(wildcard *.sh)))
+CHAINLINTTESTS = $(sort $(patsubst chainlint/%.test,%,$(wildcard chainlint/*.test)))
+CHAINLINT = sed -f chainlint.sed
 
 all: $(DEFAULT_TEST_TARGET)
 
-test: pre-clean $(TEST_LINT)
+test: pre-clean check-chainlint $(TEST_LINT)
 	$(MAKE) aggregate-results-and-cleanup
 
 failed:
@@ -43,7 +48,7 @@ failed:
 		sed -n 's/\.counts$$/.sh/p') && \
 	test -z "$$failed" || $(MAKE) $$failed
 
-prove: pre-clean $(TEST_LINT)
+prove: pre-clean check-chainlint $(TEST_LINT)
 	@echo "*** prove ***"; $(PROVE) --exec '$(TEST_SHELL_PATH_SQ)' $(GIT_PROVE_OPTS) $(T) :: $(GIT_TEST_OPTS)
 	$(MAKE) clean-except-prove-cache
 
@@ -53,13 +58,25 @@ $(T):
 pre-clean:
 	$(RM) -r '$(TEST_RESULTS_DIRECTORY_SQ)'
 
-clean-except-prove-cache:
+clean-except-prove-cache: clean-chainlint
 	$(RM) -r 'trash directory'.* '$(TEST_RESULTS_DIRECTORY_SQ)'
 	$(RM) -r valgrind/bin
 
 clean: clean-except-prove-cache
 	$(RM) .prove
 
+clean-chainlint:
+	$(RM) -r '$(CHAINLINTTMP_SQ)'
+
+check-chainlint:
+	@mkdir -p '$(CHAINLINTTMP_SQ)' && \
+	err=0 && \
+	for i in $(CHAINLINTTESTS); do \
+		$(CHAINLINT) <chainlint/$$i.test | \
+		sed -e '/^# LINT: /d' >'$(CHAINLINTTMP_SQ)'/$$i.actual && \
+		diff -u chainlint/$$i.expect '$(CHAINLINTTMP_SQ)'/$$i.actual || err=1; \
+	done && exit $$err
+
 test-lint: test-lint-duplicates test-lint-executable test-lint-shell-syntax \
 	test-lint-filenames
 
@@ -102,4 +119,4 @@ valgrind:
 perf:
 	$(MAKE) -C perf/ all
 
-.PHONY: pre-clean $(T) aggregate-results clean valgrind perf
+.PHONY: pre-clean $(T) aggregate-results clean valgrind perf check-chainlint clean-chainlint
-- 
2.18.0.203.gfac676dfb9

