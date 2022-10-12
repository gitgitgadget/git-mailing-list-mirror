Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AECAC433FE
	for <git@archiver.kernel.org>; Wed, 12 Oct 2022 21:03:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbiJLVD3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Oct 2022 17:03:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbiJLVDZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2022 17:03:25 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F762BDB
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 14:03:24 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id r13so27925985wrj.11
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 14:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bUdYd+/n3y2i5wi6BAUzfJxEHaBcqp9427yq15owIfc=;
        b=WvRsELn2wLSRXgiTbMYyra7YxgMqHBrsM7SUUw1g2KXVlpy+BqGk9SXl+V+OTT/RdB
         8l/bk1Y3o7dGxA8+iPxeGVlvD7skvgUDRuBL+FMw5vNdrheKt9FEi4Ye9zE6sEvKb98J
         DULCxIn5DBb5i1h/ORYK9udIcesjpKcpAk+zjC92nwjK9uiWW/oulQyQfIe76cC724t3
         PcXlRG6ocdimZaIMxPj63vovijAQPpVhzoSiW/GALmH06cE57l4asdjE/xyiNW/iXocP
         cXHVcx/CNfmM0F6lIueavGd/IUAtspU4V8SqZgWDKhW08mRwYXe/LkBheUBgBtkzSlUO
         Pr9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bUdYd+/n3y2i5wi6BAUzfJxEHaBcqp9427yq15owIfc=;
        b=s150slDPL8tb6/h1+sIuxQD3bXf9QBMl54RPTOPYPwYgYmq7gaJQAVhFVS26O7gpZu
         pznp0rmWdGNkyW2+PgFCOKJBdTUGwndJJEUPNnoe7W/YZbfwtdGjRijbfZXZq+6vZbRW
         I5HyWx1Tz3d+Ra1Qh6Wusy1hwcKqemFqUpMMH3EEMTZ17VZkrtCWFrkJpuR21cUMClDT
         l0apAqJQFEmAedfvGaLoTP7mzOj637JbkaFpAW2MmXXUQS2quJLRtGoKKrhM+LEJtR8z
         pe0yF79VhWmObsOvBEn55WWaJtT4+dNw5JfDVei6iLgTWTqLk8SOlC79J1ZdzP6O2nhU
         aQ8A==
X-Gm-Message-State: ACrzQf1/mDPcr9ZGNIXn/d76CDqfYwce0SnjOOADv6/Ew11ftP/Ci5L3
        gtyo10LDrZ/bnyKMHZTHn2nvzVoXvJuWtg==
X-Google-Smtp-Source: AMsMyM6jCPlO7Bo7UhlM1MWi5F4UV5NlNjJbWSE2pY3xOt/D2hkYGTMHthx+WmT4zPe9O1UQhgZrJg==
X-Received: by 2002:a05:6000:1a85:b0:230:f238:a48c with SMTP id f5-20020a0560001a8500b00230f238a48cmr8828953wry.92.1665608602677;
        Wed, 12 Oct 2022 14:03:22 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b6-20020adff246000000b00228a6ce17b4sm550079wrp.37.2022.10.12.14.03.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 14:03:22 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Calvin Wan <calvinwan@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 02/15] run-command API: have "run_processes_parallel{,_tr2}()" return void
Date:   Wed, 12 Oct 2022 23:02:21 +0200
Message-Id: <patch-v3-02.15-a2e4fd652c1-20221012T205712Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.971.ge79ff6d20e7
In-Reply-To: <cover-v3-00.15-00000000000-20221012T205712Z-avarab@gmail.com>
References: <cover-v2-00.22-00000000000-20221012T084850Z-avarab@gmail.com> <cover-v3-00.15-00000000000-20221012T205712Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the "run_processes_parallel{,_tr2}()" functions to return void,
instead of int. Ever since c553c72eed6 (run-command: add an
asynchronous parallel child processor, 2015-12-15) they have
unconditionally returned 0.

To get a "real" return value out of this function the caller needs to
get it via the "task_finished_fn" callback, see the example in hook.c
added in 96e7225b310 (hook: add 'run' subcommand, 2021-12-22).

So the "result = " and "if (!result)" code added to "builtin/fetch.c"
d54dea77dba (fetch: let --jobs=<n> parallelize --multiple, too,
2019-10-05) has always been redundant, we always took that "if"
path. Likewise the "ret =" in "t/helper/test-run-command.c" added in
be5d88e1128 (test-tool run-command: learn to run (parts of) the
testsuite, 2019-10-04) wasn't used, instead we got the return value
from the "if (suite.failed.nr > 0)" block seen in the context.

Subsequent commits will alter this API interface, getting rid of this
always-zero return value makes it easier to understand those changes.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/fetch.c             | 17 ++++++++---------
 run-command.c               | 27 +++++++++++----------------
 run-command.h               | 16 ++++++++--------
 t/helper/test-run-command.c | 16 ++++++++--------
 4 files changed, 35 insertions(+), 41 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index a0fca93bb6a..78043fb67ef 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1953,15 +1953,14 @@ static int fetch_multiple(struct string_list *list, int max_children)
 		struct parallel_fetch_state state = { argv.v, list, 0, 0 };
 
 		strvec_push(&argv, "--end-of-options");
-		result = run_processes_parallel_tr2(max_children,
-						    &fetch_next_remote,
-						    &fetch_failed_to_start,
-						    &fetch_finished,
-						    &state,
-						    "fetch", "parallel/fetch");
-
-		if (!result)
-			result = state.result;
+		run_processes_parallel_tr2(max_children,
+					   &fetch_next_remote,
+					   &fetch_failed_to_start,
+					   &fetch_finished,
+					   &state,
+					   "fetch", "parallel/fetch");
+
+		result = state.result;
 	} else
 		for (i = 0; i < list->nr; i++) {
 			const char *name = list->items[i].string;
diff --git a/run-command.c b/run-command.c
index 5ec3a46dccf..642e6b6e057 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1783,11 +1783,11 @@ static int pp_collect_finished(struct parallel_processes *pp)
 	return result;
 }
 
-int run_processes_parallel(int n,
-			   get_next_task_fn get_next_task,
-			   start_failure_fn start_failure,
-			   task_finished_fn task_finished,
-			   void *pp_cb)
+void run_processes_parallel(int n,
+			    get_next_task_fn get_next_task,
+			    start_failure_fn start_failure,
+			    task_finished_fn task_finished,
+			    void *pp_cb)
 {
 	int i, code;
 	int output_timeout = 100;
@@ -1834,25 +1834,20 @@ int run_processes_parallel(int n,
 	}
 
 	pp_cleanup(&pp);
-	return 0;
 }
 
-int run_processes_parallel_tr2(int n, get_next_task_fn get_next_task,
-			       start_failure_fn start_failure,
-			       task_finished_fn task_finished, void *pp_cb,
-			       const char *tr2_category, const char *tr2_label)
+void run_processes_parallel_tr2(int n, get_next_task_fn get_next_task,
+				start_failure_fn start_failure,
+				task_finished_fn task_finished, void *pp_cb,
+				const char *tr2_category, const char *tr2_label)
 {
-	int result;
-
 	trace2_region_enter_printf(tr2_category, tr2_label, NULL, "max:%d",
 				   ((n < 1) ? online_cpus() : n));
 
-	result = run_processes_parallel(n, get_next_task, start_failure,
-					task_finished, pp_cb);
+	run_processes_parallel(n, get_next_task, start_failure,
+			       task_finished, pp_cb);
 
 	trace2_region_leave(tr2_category, tr2_label, NULL);
-
-	return result;
 }
 
 int run_auto_maintenance(int quiet)
diff --git a/run-command.h b/run-command.h
index 0e85e5846a5..e76a1b6b5b3 100644
--- a/run-command.h
+++ b/run-command.h
@@ -485,14 +485,14 @@ typedef int (*task_finished_fn)(int result,
  * API reads that setting.
  */
 extern int run_processes_parallel_ungroup;
-int run_processes_parallel(int n,
-			   get_next_task_fn,
-			   start_failure_fn,
-			   task_finished_fn,
-			   void *pp_cb);
-int run_processes_parallel_tr2(int n, get_next_task_fn, start_failure_fn,
-			       task_finished_fn, void *pp_cb,
-			       const char *tr2_category, const char *tr2_label);
+void run_processes_parallel(int n,
+			    get_next_task_fn,
+			    start_failure_fn,
+			    task_finished_fn,
+			    void *pp_cb);
+void run_processes_parallel_tr2(int n, get_next_task_fn, start_failure_fn,
+				task_finished_fn, void *pp_cb,
+				const char *tr2_category, const char *tr2_label);
 
 /**
  * Convenience function which prepares env for a command to be run in a
diff --git a/t/helper/test-run-command.c b/t/helper/test-run-command.c
index 390fa4fb724..30c474f3243 100644
--- a/t/helper/test-run-command.c
+++ b/t/helper/test-run-command.c
@@ -192,8 +192,8 @@ static int testsuite(int argc, const char **argv)
 	fprintf(stderr, "Running %"PRIuMAX" tests (%d at a time)\n",
 		(uintmax_t)suite.tests.nr, max_jobs);
 
-	ret = run_processes_parallel(max_jobs, next_test, test_failed,
-				     test_finished, &suite);
+	run_processes_parallel(max_jobs, next_test, test_failed,
+			       test_finished, &suite);
 
 	if (suite.failed.nr > 0) {
 		ret = 1;
@@ -428,16 +428,16 @@ int cmd__run_command(int argc, const char **argv)
 	strvec_pushv(&proc.args, (const char **)argv + 3);
 
 	if (!strcmp(argv[1], "run-command-parallel")) {
-		exit(run_processes_parallel(jobs, parallel_next,
-					    NULL, NULL, &proc));
+		run_processes_parallel(jobs, parallel_next, NULL, NULL, &proc);
 	} else if (!strcmp(argv[1], "run-command-abort")) {
-		exit(run_processes_parallel(jobs, parallel_next,
-					    NULL, task_finished, &proc));
+		run_processes_parallel(jobs, parallel_next, NULL,
+				       task_finished, &proc);
 	} else if (!strcmp(argv[1], "run-command-no-jobs")) {
-		exit(run_processes_parallel(jobs, no_job,
-					    NULL, task_finished, &proc));
+		run_processes_parallel(jobs, no_job, NULL, task_finished,
+				       &proc);
 	} else {
 		fprintf(stderr, "check usage\n");
 		return 1;
 	}
+	exit(0);
 }
-- 
2.38.0.971.ge79ff6d20e7

