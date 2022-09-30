Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 107FFC433F5
	for <git@archiver.kernel.org>; Fri, 30 Sep 2022 11:36:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231667AbiI3LgX (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Sep 2022 07:36:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231285AbiI3Lfi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Sep 2022 07:35:38 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82DCB13D1D7
        for <git@vger.kernel.org>; Fri, 30 Sep 2022 04:28:26 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id c11so6370565wrp.11
        for <git@vger.kernel.org>; Fri, 30 Sep 2022 04:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=+zSnZAMIHC4SsGE8MPlRmCUI+hZT7jCkaZhiPBJ5KBs=;
        b=OEkdK2a7eRpY0ORGh90uIvPqH9xVsawOvYqKgZRGdcQejwRHigUwNWhyShMA7rAaNO
         dmlGaAx7/Yc6MSI+v7mAnvuyuNDRGNy6fyk/CAIbQiaKgujLbEbqFtQhBDF9EUPAWRwG
         Or0AY4uOZqe1N9HoEGlpIV3mwbZGm5EOUiCNnn5bNPlw7KRCk1JyIp+Ss1aczIVh8SE5
         kyxlkWvbsWHAlXzH22zsG2H71K6xfbb2AJoKJiWpoCjcsd+RYd/OgNewu3S8VlBWB7U6
         9dCkFY9hsG17YjHIi6zJuquHWGtuuEr+At1xu6gtBzQCvfkMMKSxEL+XGQpnbl4SZT9P
         8tNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=+zSnZAMIHC4SsGE8MPlRmCUI+hZT7jCkaZhiPBJ5KBs=;
        b=hBIH8YtrSYo762zQoRcSI+LzcknPA2kDmuat8r7PYKtOqBEhPdXZ3RaxNnK1FRIiML
         FMbKVfQvTJ8RdHVKQxwgVT6Qul5hMOxp9v1am71jrWiwe4Sk1arbX3NujyEMjv/6IFTy
         YFukq3IPRD4NcX8y1C5pBbzcBOFSBVWoyVo6GOz9aO/H4BLnnbynHI4E2jRx/i81QeSC
         SIFswLCKUoECYHTqlvQ0MgS5y9lH5/+9itWTnwKlgvbzMeM7yzDGle/YxUb6zTkGxC8M
         K0g+m6B6cn7e8Dz9SzoqKaWq2Aeacq1vhyTDgRGr5dn9kHbb/kZe6LKBtWKjXbMlG4Ew
         aoOA==
X-Gm-Message-State: ACrzQf36SHSuv9aAOnmoQnFMqCYmmP9/uR0VROKBy1klpo8ab0UcID8v
        NTmpFVi23PgfvKnwtz6GE+XtCZgH1azvPw==
X-Google-Smtp-Source: AMsMyM7MVNi1bDLBSUnKKby0RjuoSMpOTctbWm6KlYJjHxwvo5a/s/iGVen6LCkF84Ddo1wfThUDvw==
X-Received: by 2002:a5d:4209:0:b0:22c:d5fd:1a06 with SMTP id n9-20020a5d4209000000b0022cd5fd1a06mr5051820wrq.508.1664537302233;
        Fri, 30 Sep 2022 04:28:22 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l19-20020a5d5273000000b00228dbf15072sm1760799wrc.62.2022.09.30.04.28.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 04:28:21 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Calvin Wan <calvinwan@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 06/15] run-command API: have "run_processes_parallel{,_tr2}()" return void
Date:   Fri, 30 Sep 2022 13:28:03 +0200
Message-Id: <patch-06.15-c86dc59d07c-20220930T111343Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.rc2.935.g6b421ae1592
In-Reply-To: <cover-00.15-00000000000-20220930T111343Z-avarab@gmail.com>
References: <cover-00.15-00000000000-20220930T111343Z-avarab@gmail.com>
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
 t/helper/test-run-command.c |  4 ++--
 4 files changed, 29 insertions(+), 35 deletions(-)

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
index ebda2203408..c431e3094df 100644
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
-- 
2.38.0.rc2.935.g6b421ae1592

