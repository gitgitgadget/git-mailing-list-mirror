Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E73F8C4332F
	for <git@archiver.kernel.org>; Fri, 30 Sep 2022 11:36:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231710AbiI3Lgm (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Sep 2022 07:36:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231470AbiI3Lft (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Sep 2022 07:35:49 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C41E413DDAF
        for <git@vger.kernel.org>; Fri, 30 Sep 2022 04:28:29 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id z13-20020a7bc7cd000000b003b5054c6f9bso4865579wmk.2
        for <git@vger.kernel.org>; Fri, 30 Sep 2022 04:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=gUZy4XxJKLC/vFO7dhaMUDkuz3vAtT8JCz9hHmDiKN0=;
        b=FJB/jDrPTgaijuWU6eOln2PBVqtaJ0AaQ1ydzuxuzkcQjv54uSChNzTAuJtQG3LuM1
         gVD3OR4AboGAUTClX4qcU0Ww+Ugzts/Cf6fHf1ZwSuq/05Ptq2fhRXHc7APog+BBnmGm
         Wo+YFCfrwHl8lC92JTdIAyJRogXHaTbh9Dan7rYeAQ35mBXKyogKQ6a4+iD0Gz5cIvtg
         XGjTwiYO8XqR18yZp9CQMyS7CeB1SXJKiePfFISSQmSxqzDN3vkZkpFk680xx910Ln/G
         TgB6kD6yTIm//aSQkcRz8v7YjQ770L+vkx+c20d911jRoURQW0NuiforNIU4hFzFw3ku
         k+gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=gUZy4XxJKLC/vFO7dhaMUDkuz3vAtT8JCz9hHmDiKN0=;
        b=cR/WcOs8YWt4wxnwyYdxcOss5Xie6a8ygrlbXLDvcd9WJLNeA3kEAloPVymDoWG3Mw
         bdfuPoBV2aRXG9Ete7buQp16ecjRrEacpvDiEmzc/hR2C+uDErwftoTc4dGNtmG3MnvM
         Gql/bkTuisA5tXV2wwsJ34LnusB1xZKJlYfGyBd2TbutSNNkbkDIDCSPbA/Ha+AJk6je
         8QEHKB4h+ttcNWWzBuw30KeQFp89a3kCnsWoY5+4MOtf/tiY3GnT/vsv4I9AHxdHx/kM
         Y1KHZZanUFCvSTimAxwd6YgdNlm54OJhLhI/pFNMggzxX+Pz5yFbeHgfV6RvJDLQUH8k
         uyfA==
X-Gm-Message-State: ACrzQf3dBgg6YRBpaPR5gNxLR6FH+yzo8q824qp4NiikDDmfMArAkrNS
        Mw11MYpYYjRVpEYPH9p25SyfGGa8snMYFA==
X-Google-Smtp-Source: AMsMyM5Dc3I6on5tAZIwRRUmSzln8Vl4JU4Bgo2R0RA1p8HUcfVpQlqdwS3N251Xwt4fPxjUmElVTQ==
X-Received: by 2002:a05:600c:4ec8:b0:3b4:bdc6:9b3d with SMTP id g8-20020a05600c4ec800b003b4bdc69b3dmr13719998wmq.181.1664537307005;
        Fri, 30 Sep 2022 04:28:27 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l19-20020a5d5273000000b00228dbf15072sm1760799wrc.62.2022.09.30.04.28.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 04:28:26 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Calvin Wan <calvinwan@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 10/15] run-command API: add nascent "struct run_process_parallel_opts"
Date:   Fri, 30 Sep 2022 13:28:07 +0200
Message-Id: <patch-10.15-613ccb85fa2-20220930T111343Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.rc2.935.g6b421ae1592
In-Reply-To: <cover-00.15-00000000000-20220930T111343Z-avarab@gmail.com>
References: <cover-00.15-00000000000-20220930T111343Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As noted in fd3aaf53f71 (run-command: add an "ungroup" option to
run_process_parallel(), 2022-06-07) which added the "ungroup" passing
it to "run_process_parallel()" via the global
"run_processes_parallel_ungroup" variable was a compromise to get the
smallest possible regression fix for "maint" at the time.

This follow-up to that is a start at passing that parameter and others
via a new "struct run_process_parallel_opts", as the earlier
version[1] of what became fd3aaf53f71 did.

For now we're only changing how data is passed internally to
"run-command.c", i.e. from "run_process_parallel()" to
pp_init(). Subsequent commits will change "run_processes_parallel()"
itself, as well as the "run_processes_parallel_tr2()" wrapper
function.

1. https://lore.kernel.org/git/cover-v2-0.8-00000000000-20220518T195858Z-avarab@gmail.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 run-command.c | 38 ++++++++++++++++++++++----------------
 run-command.h | 44 +++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 63 insertions(+), 19 deletions(-)

diff --git a/run-command.c b/run-command.c
index 31a856f8b9a..f82fc7f1515 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1563,21 +1563,21 @@ static void handle_children_on_signal(int signo)
 }
 
 static void pp_init(struct parallel_processes *pp,
-		    unsigned int jobs,
-		    get_next_task_fn get_next_task,
-		    start_failure_fn start_failure,
-		    task_finished_fn task_finished,
-		    void *data, int ungroup)
+		    const struct run_process_parallel_opts *opts)
 {
 	unsigned int i;
+	void *data = opts->data;
+	get_next_task_fn get_next_task = opts->get_next_task;
+	start_failure_fn start_failure = opts->start_failure;
+	task_finished_fn task_finished = opts->task_finished;
 
-	if (!jobs)
+	if (!opts->jobs)
 		BUG("you must provide a non-zero number of jobs!");
 
-	pp->max_processes = jobs;
+	pp->max_processes = opts->jobs;
 
 	trace_printf("run_processes_parallel: preparing to run up to %d tasks",
-		     jobs);
+		     opts->jobs);
 
 	pp->data = data;
 	if (!get_next_task)
@@ -1590,12 +1590,12 @@ static void pp_init(struct parallel_processes *pp,
 	pp->nr_processes = 0;
 	pp->output_owner = 0;
 	pp->shutdown = 0;
-	pp->ungroup = ungroup;
-	CALLOC_ARRAY(pp->children, jobs);
+	pp->ungroup = opts->ungroup;
+	CALLOC_ARRAY(pp->children, opts->jobs);
 	if (!pp->ungroup)
-		CALLOC_ARRAY(pp->pfd, jobs);
+		CALLOC_ARRAY(pp->pfd, opts->jobs);
 
-	for (i = 0; i < jobs; i++) {
+	for (i = 0; i < opts->jobs; i++) {
 		strbuf_init(&pp->children[i].err, 0);
 		child_process_init(&pp->children[i].process);
 		if (pp->pfd) {
@@ -1793,14 +1793,20 @@ void run_processes_parallel(unsigned int jobs,
 	int i, code;
 	int output_timeout = 100;
 	int spawn_cap = 4;
-	int ungroup = run_processes_parallel_ungroup;
 	struct parallel_processes pp = PARALLEL_PROCESSES_INIT;
+	const struct run_process_parallel_opts opts = {
+		.jobs = jobs,
+		.get_next_task = get_next_task,
+		.start_failure = start_failure,
+		.task_finished = task_finished,
+		.ungroup = run_processes_parallel_ungroup,
+		.data = pp_cb,
+	};
 
 	/* unset for the next API user */
 	run_processes_parallel_ungroup = 0;
 
-	pp_init(&pp, jobs, get_next_task, start_failure, task_finished, pp_cb,
-		ungroup);
+	pp_init(&pp, &opts);
 	while (1) {
 		for (i = 0;
 		    i < spawn_cap && !pp.shutdown &&
@@ -1817,7 +1823,7 @@ void run_processes_parallel(unsigned int jobs,
 		}
 		if (!pp.nr_processes)
 			break;
-		if (ungroup) {
+		if (opts.ungroup) {
 			int i;
 
 			for (i = 0; i < pp.max_processes; i++)
diff --git a/run-command.h b/run-command.h
index 4502bdc64dc..210fb9e8bc4 100644
--- a/run-command.h
+++ b/run-command.h
@@ -458,6 +458,47 @@ typedef int (*task_finished_fn)(int result,
 				void *pp_cb,
 				void *pp_task_cb);
 
+/**
+ * Option used by run_processes_parallel(), { 0 }-initialized means no
+ * options.
+ */
+struct run_process_parallel_opts
+{
+	/**
+	 * jobs: see 'jobs' in run_processes_parallel() below.
+	 */
+	int jobs;
+
+	/**
+	 * ungroup: see 'ungroup' in run_processes_parallel() below.
+	 */
+	unsigned int ungroup:1;
+
+	/**
+	 * get_next_task: See get_next_task_fn() above. This must be
+	 * specified.
+	 */
+	get_next_task_fn get_next_task;
+
+	/**
+	 * start_failure: See start_failure_fn() above. This can be
+	 * NULL to omit any special handling.
+	 */
+	start_failure_fn start_failure;
+
+	/**
+	 * task_finished: See task_finished_fn() above. This can be
+	 * NULL to omit any special handling.
+	 */
+	task_finished_fn task_finished;
+
+	/**
+	 * data: user data, will be passed as "pp_cb" to the callback
+	 * parameters.
+	 */
+	void *data;
+};
+
 /**
  * Runs up to 'jobs' processes at the same time. Whenever a process can be
  * started, the callback get_next_task_fn is called to obtain the data
@@ -467,9 +508,6 @@ typedef int (*task_finished_fn)(int result,
  * (both stdout and stderr) is routed to stderr in a manner that output
  * from different tasks does not interleave (but see "ungroup" below).
  *
- * start_failure_fn and task_finished_fn can be NULL to omit any
- * special handling.
- *
  * If the "ungroup" option isn't specified, the API will set the
  * "stdout_to_stderr" parameter in "struct child_process" and provide
  * the callbacks with a "struct strbuf *out" parameter to write output
-- 
2.38.0.rc2.935.g6b421ae1592

