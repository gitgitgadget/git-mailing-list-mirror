Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E74DC4332F
	for <git@archiver.kernel.org>; Mon,  6 Sep 2021 00:45:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB1EB61054
	for <git@archiver.kernel.org>; Mon,  6 Sep 2021 00:45:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232675AbhIFAiq (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 5 Sep 2021 20:38:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbhIFAiq (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Sep 2021 20:38:46 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51846C061575
        for <git@vger.kernel.org>; Sun,  5 Sep 2021 17:37:42 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id k5-20020a05600c1c8500b002f76c42214bso3740558wms.3
        for <git@vger.kernel.org>; Sun, 05 Sep 2021 17:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JuwnO0OjH+gaWVzdYXPNxFdAhQNQj1eUzI5FLTaLbX8=;
        b=IkSSMxnJtpt+7O33Cvco6suI74rrx9fOUfO7jW7e3QloWrsYirIIYdPSdrBwlEU/Gg
         fA+u40jBEBKNLaJn3mKWdPyw2iAEROcDAgMTYP2ilGtSon7DsfS/Gg4aqqixgoPFPie0
         Z6CG3IHLbtOEGnN5o2xda3RMPVzz+uEeW4zqMaaw0gJCRepxZ8Sq7B4CV/7Kg4DZ1ode
         PtHsC5ny7YALegWXFrWBGF0p4UmeHJLGcwkT4Y7wuQZ7wCCLbpbH4hElMwSzFwAk511n
         mk7P9FwIYmokuHE1gYU06rijmEP+gDZ8fqQsmBFoRuGSuHI4952wURvjyZPvZzT+25bN
         058g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JuwnO0OjH+gaWVzdYXPNxFdAhQNQj1eUzI5FLTaLbX8=;
        b=h3XgabTvQOIWWkTvTE9EtbYh1ZHFrSNEcSQd1tqdUN2cEZm5IC9xEv+XoX03Fu3Fjk
         I1BcIQHeRPUz0szSCe9vOG++nm2T4DPrw4iJn55EO6W8igv85M7mswCktIfQR8d5/TlK
         J85F0W/zmeRZQUp3ZZBGvN1dJu0SYeZGQwmOmvYpmT4Mp9gDBPR2u2sXM+jkR/qczPKS
         F+hyr+2bdcixt6nLMpagnSOcCX7TTKBucvKwq8wKINYym+RcZB98oz3zmS21M4ZNcAth
         yPWPyu5MMleEzUn458KLZrZubQe+PfCW0OqD7Kx4fQ7KSwsq3Kv/fO+hP3LwvzpxiW9A
         3DLA==
X-Gm-Message-State: AOAM533qUHnTiwzjBAzlcPJmwLx7PsXf9Nrmn/sGtyyf6bilS2kM6PUQ
        5KX27vhO/iL8HCY1bhLvywTgTQUoc8OSZA==
X-Google-Smtp-Source: ABdhPJz1qazPUB5lLh9JhVp6Nti+6oSO+rTujgFmV+3MmPzyDHBLRly7yZh3vXtrxZKk14iY6PrOzw==
X-Received: by 2002:a1c:402:: with SMTP id 2mr8982783wme.158.1630888660570;
        Sun, 05 Sep 2021 17:37:40 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i5sm6254175wrc.86.2021.09.05.17.37.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Sep 2021 17:37:40 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Sibi Siddharthan <sibisiv.siddharthan@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] test-tool run-command: remove dead "testsuite" code
Date:   Mon,  6 Sep 2021 02:37:37 +0200
Message-Id: <patch-1.1-d1e464da0a9-20210906T002938Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.821.g8b294b0dcf8
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove the "test-tool run-command testsuite" sub-sub-command, it has
not been used since 4c2c38e800f (ci: modification of main.yml to use
cmake for vs-build job, 2020-06-26), see also the earlier
6081d3898fe (ci: retire the Azure Pipelines definition, 2020-04-11)
for another phasing out of the command.

This the "testsuite" functionality here was added in
be5d88e1128 (test-tool run-command: learn to run (parts of) the
testsuite, 2019-10-04), and then first used in 46689317ac0 (ci: also
build and test with MS Visual Studio on Azure Pipelines, 2019-10-04).

I'd started out fixing a bug in the "init" pattern here. We set "next"
to "-1" and then proceed to memset() the whole struct to "0", so the
two "STRING_LIST_INIT_DUP" here are also redundant to our setting of
the "strdup_strings" members later on.

But rather than fix that let's just remove this whole thing, as
nothing is using it.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

There's a trivial conflict here with ab/config-based-hooks-base. This
removes code, that series adds a couple of new (but unrelated)
functions in-between some of these removed functions.

 t/helper/test-run-command.c | 151 ------------------------------------
 1 file changed, 151 deletions(-)

diff --git a/t/helper/test-run-command.c b/t/helper/test-run-command.c
index 7ae03dc7123..1d41c0eda81 100644
--- a/t/helper/test-run-command.c
+++ b/t/helper/test-run-command.c
@@ -10,14 +10,10 @@
 
 #include "test-tool.h"
 #include "git-compat-util.h"
-#include "cache.h"
 #include "run-command.h"
 #include "strvec.h"
 #include "strbuf.h"
 #include "parse-options.h"
-#include "string-list.h"
-#include "thread-utils.h"
-#include "wildmatch.h"
 #include "gettext.h"
 #include "parse-options.h"
 
@@ -55,151 +51,6 @@ static int task_finished(int result,
 	return 1;
 }
 
-struct testsuite {
-	struct string_list tests, failed;
-	int next;
-	int quiet, immediate, verbose, verbose_log, trace, write_junit_xml;
-};
-#define TESTSUITE_INIT \
-	{ STRING_LIST_INIT_DUP, STRING_LIST_INIT_DUP, -1, 0, 0, 0, 0, 0, 0 }
-
-static int next_test(struct child_process *cp, struct strbuf *err, void *cb,
-		     void **task_cb)
-{
-	struct testsuite *suite = cb;
-	const char *test;
-	if (suite->next >= suite->tests.nr)
-		return 0;
-
-	test = suite->tests.items[suite->next++].string;
-	strvec_pushl(&cp->args, "sh", test, NULL);
-	if (suite->quiet)
-		strvec_push(&cp->args, "--quiet");
-	if (suite->immediate)
-		strvec_push(&cp->args, "-i");
-	if (suite->verbose)
-		strvec_push(&cp->args, "-v");
-	if (suite->verbose_log)
-		strvec_push(&cp->args, "-V");
-	if (suite->trace)
-		strvec_push(&cp->args, "-x");
-	if (suite->write_junit_xml)
-		strvec_push(&cp->args, "--write-junit-xml");
-
-	strbuf_addf(err, "Output of '%s':\n", test);
-	*task_cb = (void *)test;
-
-	return 1;
-}
-
-static int test_finished(int result, struct strbuf *err, void *cb,
-			 void *task_cb)
-{
-	struct testsuite *suite = cb;
-	const char *name = (const char *)task_cb;
-
-	if (result)
-		string_list_append(&suite->failed, name);
-
-	strbuf_addf(err, "%s: '%s'\n", result ? "FAIL" : "SUCCESS", name);
-
-	return 0;
-}
-
-static int test_failed(struct strbuf *out, void *cb, void *task_cb)
-{
-	struct testsuite *suite = cb;
-	const char *name = (const char *)task_cb;
-
-	string_list_append(&suite->failed, name);
-	strbuf_addf(out, "FAILED TO START: '%s'\n", name);
-
-	return 0;
-}
-
-static const char * const testsuite_usage[] = {
-	"test-run-command testsuite [<options>] [<pattern>...]",
-	NULL
-};
-
-static int testsuite(int argc, const char **argv)
-{
-	struct testsuite suite = TESTSUITE_INIT;
-	int max_jobs = 1, i, ret;
-	DIR *dir;
-	struct dirent *d;
-	struct option options[] = {
-		OPT_BOOL('i', "immediate", &suite.immediate,
-			 "stop at first failed test case(s)"),
-		OPT_INTEGER('j', "jobs", &max_jobs, "run <N> jobs in parallel"),
-		OPT_BOOL('q', "quiet", &suite.quiet, "be terse"),
-		OPT_BOOL('v', "verbose", &suite.verbose, "be verbose"),
-		OPT_BOOL('V', "verbose-log", &suite.verbose_log,
-			 "be verbose, redirected to a file"),
-		OPT_BOOL('x', "trace", &suite.trace, "trace shell commands"),
-		OPT_BOOL(0, "write-junit-xml", &suite.write_junit_xml,
-			 "write JUnit-style XML files"),
-		OPT_END()
-	};
-
-	memset(&suite, 0, sizeof(suite));
-	suite.tests.strdup_strings = suite.failed.strdup_strings = 1;
-
-	argc = parse_options(argc, argv, NULL, options,
-			testsuite_usage, PARSE_OPT_STOP_AT_NON_OPTION);
-
-	if (max_jobs <= 0)
-		max_jobs = online_cpus();
-
-	dir = opendir(".");
-	if (!dir)
-		die("Could not open the current directory");
-	while ((d = readdir(dir))) {
-		const char *p = d->d_name;
-
-		if (*p != 't' || !isdigit(p[1]) || !isdigit(p[2]) ||
-		    !isdigit(p[3]) || !isdigit(p[4]) || p[5] != '-' ||
-		    !ends_with(p, ".sh"))
-			continue;
-
-		/* No pattern: match all */
-		if (!argc) {
-			string_list_append(&suite.tests, p);
-			continue;
-		}
-
-		for (i = 0; i < argc; i++)
-			if (!wildmatch(argv[i], p, 0)) {
-				string_list_append(&suite.tests, p);
-				break;
-			}
-	}
-	closedir(dir);
-
-	if (!suite.tests.nr)
-		die("No tests match!");
-	if (max_jobs > suite.tests.nr)
-		max_jobs = suite.tests.nr;
-
-	fprintf(stderr, "Running %d tests (%d at a time)\n",
-		suite.tests.nr, max_jobs);
-
-	ret = run_processes_parallel(max_jobs, next_test, test_failed,
-				     test_finished, &suite);
-
-	if (suite.failed.nr > 0) {
-		ret = 1;
-		fprintf(stderr, "%d tests failed:\n\n", suite.failed.nr);
-		for (i = 0; i < suite.failed.nr; i++)
-			fprintf(stderr, "\t%s\n", suite.failed.items[i].string);
-	}
-
-	string_list_clear(&suite.tests, 0);
-	string_list_clear(&suite.failed, 0);
-
-	return !!ret;
-}
-
 static uint64_t my_random_next = 1234;
 
 static uint64_t my_random(void)
@@ -373,8 +224,6 @@ int cmd__run_command(int argc, const char **argv)
 	struct child_process proc = CHILD_PROCESS_INIT;
 	int jobs;
 
-	if (argc > 1 && !strcmp(argv[1], "testsuite"))
-		exit(testsuite(argc - 1, argv + 1));
 	if (!strcmp(argv[1], "inherited-handle"))
 		exit(inherit_handle(argv[0]));
 	if (!strcmp(argv[1], "inherited-handle-child"))
-- 
2.33.0.821.g8b294b0dcf8

