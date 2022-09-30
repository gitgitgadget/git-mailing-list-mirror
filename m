Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34DD2C433F5
	for <git@archiver.kernel.org>; Fri, 30 Sep 2022 11:36:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231552AbiI3Lgx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Sep 2022 07:36:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231542AbiI3LgC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Sep 2022 07:36:02 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7485A1406DB
        for <git@vger.kernel.org>; Fri, 30 Sep 2022 04:28:34 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id n10so6365666wrw.12
        for <git@vger.kernel.org>; Fri, 30 Sep 2022 04:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=9Ycgg2JszRspFfDzhL7QVHgfnxpx3jksh2x6kKh6fYA=;
        b=NivjlQ6xLk4UvT8R1nCl1W+HHDuXkqGy5cgELY4dUQ0amzROJ11jwDQKUKOHF5R3bV
         YI04ab/anZCKqBTvhr4HCyMOwvRFW4nKwQYCHC+R5+eDnDLTQv9XMvuubQ2RTnakLDkH
         dD91FxxvExEYR+vPFduImYeMGh8mj/CmuuwJekzw05erh12i2iPUViGkwkG/1PFFbN5N
         B+G9WQeIClQAk+SuuXTrq1tDpLHdLFVB8sUZGp1qOXjUuKDPlRmuyV8HvXvFTJkrH/iW
         ePVMUKWdSz1G8PFrXTwvQCBZk0fTfea+V6GOygHUqlU1b0w2SojcZvxaWVlK9EV7nWRT
         j8XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=9Ycgg2JszRspFfDzhL7QVHgfnxpx3jksh2x6kKh6fYA=;
        b=7RHDCbOSTUdpJMuqe5iKgAJYttEVx6iVyxZtV4JkxJsKx0in/p2K6BY76CdVO2j0bw
         wWOmpV45diKc9rI4/bDZH4E8slY19I358J033Eh4xDa2/5daXdCdQ1CdXeUm6p/+6kYm
         uXQu2koUrH9h+fD0rXgxvlJ/PJ6BM8DzynYnyD4JgsqWVP3/yfhgIV7sPXpuxKv9UXH5
         jIv1IzZI7euG489CKNlxgd1L7s/7t4LtPoIaR9+qab+zoUQqXZ7gMJuXyejjlyD8ubDH
         cg9v/6wdhuDRyTjqG3b17RNoDsZkciNUsIEd6xorW6wC8lDWkcf4SKl1emIDY0SYJvAu
         XEbg==
X-Gm-Message-State: ACrzQf1xMzvmtQbyJH473i7ne+Lbv2Dzo0WYIDPkPIxjp+tpIwslEYZW
        MQFIi4kNTe0KE9cIa3/br1Y2Mznc12jgZQ==
X-Google-Smtp-Source: AMsMyM6MehT6mc2mjwlAsR2T6PQ8jszq8IvDudSTBFAvaQ+G0UhhYhiuCA5gMIqbA4xkVtIooagHIw==
X-Received: by 2002:a5d:4442:0:b0:22a:e096:9039 with SMTP id x2-20020a5d4442000000b0022ae0969039mr5474646wrr.304.1664537311406;
        Fri, 30 Sep 2022 04:28:31 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l19-20020a5d5273000000b00228dbf15072sm1760799wrc.62.2022.09.30.04.28.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 04:28:30 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Calvin Wan <calvinwan@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 14/15] run-command.c: don't copy *_fn to "struct parallel_processes"
Date:   Fri, 30 Sep 2022 13:28:11 +0200
Message-Id: <patch-14.15-68605f4034b-20220930T111343Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.rc2.935.g6b421ae1592
In-Reply-To: <cover-00.15-00000000000-20220930T111343Z-avarab@gmail.com>
References: <cover-00.15-00000000000-20220930T111343Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The only remaining reason for copying the callbacks in the "struct
run_process_parallel_opts" over to the "struct parallel_processes" was
to avoid two if/else statements in case the "start_failure" and
"task_finished" callbacks were NULL.

Let's handle those cases in pp_start_one() and pp_collect_finished()
instead, and avoid the default_* stub functions, and the need to copy
this data around.

Organizing the code like this made more sense before the "struct
run_parallel_parallel_opts" existed, as we'd have needed to pass each
of these as a separate parameter.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 run-command.c | 67 +++++++++++++++++++--------------------------------
 1 file changed, 25 insertions(+), 42 deletions(-)

diff --git a/run-command.c b/run-command.c
index 1d5a500ecce..b25e74fcc06 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1502,10 +1502,6 @@ struct parallel_processes {
 	unsigned int max_processes;
 	unsigned int nr_processes;
 
-	get_next_task_fn get_next_task;
-	start_failure_fn start_failure;
-	task_finished_fn task_finished;
-
 	struct {
 		enum child_state state;
 		struct child_process process;
@@ -1528,21 +1524,6 @@ struct parallel_processes {
 	.buffered_output = STRBUF_INIT, \
 }
 
-static int default_start_failure(struct strbuf *out,
-				 void *pp_cb,
-				 void *pp_task_cb)
-{
-	return 0;
-}
-
-static int default_task_finished(int result,
-				 struct strbuf *out,
-				 void *pp_cb,
-				 void *pp_task_cb)
-{
-	return 0;
-}
-
 static void kill_children(struct parallel_processes *pp, int signo)
 {
 	int i, n = pp->max_processes;
@@ -1566,9 +1547,6 @@ static void pp_init(struct parallel_processes *pp,
 {
 	unsigned int i;
 	void *data = opts->data;
-	get_next_task_fn get_next_task = opts->get_next_task;
-	start_failure_fn start_failure = opts->start_failure;
-	task_finished_fn task_finished = opts->task_finished;
 
 	if (!opts->jobs)
 		BUG("you must provide a non-zero number of jobs!");
@@ -1579,12 +1557,8 @@ static void pp_init(struct parallel_processes *pp,
 		     opts->jobs);
 
 	pp->data = data;
-	if (!get_next_task)
+	if (!opts->get_next_task)
 		BUG("you need to specify a get_next_task function");
-	pp->get_next_task = get_next_task;
-
-	pp->start_failure = start_failure ? start_failure : default_start_failure;
-	pp->task_finished = task_finished ? task_finished : default_task_finished;
 
 	pp->nr_processes = 0;
 	pp->output_owner = 0;
@@ -1637,7 +1611,8 @@ static void pp_cleanup(struct parallel_processes *pp)
  * <0 no new job was started, user wishes to shutdown early. Use negative code
  *    to signal the children.
  */
-static int pp_start_one(struct parallel_processes *pp)
+static int pp_start_one(struct parallel_processes *pp,
+			const struct run_process_parallel_opts *opts)
 {
 	int i, code;
 
@@ -1647,10 +1622,10 @@ static int pp_start_one(struct parallel_processes *pp)
 	if (i == pp->max_processes)
 		BUG("bookkeeping is hard");
 
-	code = pp->get_next_task(&pp->children[i].process,
-				 pp->ungroup ? NULL : &pp->children[i].err,
-				 pp->data,
-				 &pp->children[i].data);
+	code = opts->get_next_task(&pp->children[i].process,
+				   pp->ungroup ? NULL : &pp->children[i].err,
+				   pp->data,
+				   &pp->children[i].data);
 	if (!code) {
 		if (!pp->ungroup) {
 			strbuf_addbuf(&pp->buffered_output, &pp->children[i].err);
@@ -1665,10 +1640,14 @@ static int pp_start_one(struct parallel_processes *pp)
 	pp->children[i].process.no_stdin = 1;
 
 	if (start_command(&pp->children[i].process)) {
-		code = pp->start_failure(pp->ungroup ? NULL :
-					 &pp->children[i].err,
-					 pp->data,
-					 pp->children[i].data);
+		if (opts->start_failure)
+			code = opts->start_failure(pp->ungroup ? NULL :
+						   &pp->children[i].err,
+						   pp->data,
+						   pp->children[i].data);
+		else
+			code = 0;
+
 		if (!pp->ungroup) {
 			strbuf_addbuf(&pp->buffered_output, &pp->children[i].err);
 			strbuf_reset(&pp->children[i].err);
@@ -1723,7 +1702,8 @@ static void pp_output(struct parallel_processes *pp)
 	}
 }
 
-static int pp_collect_finished(struct parallel_processes *pp)
+static int pp_collect_finished(struct parallel_processes *pp,
+			       const struct run_process_parallel_opts *opts)
 {
 	int i, code;
 	int n = pp->max_processes;
@@ -1738,9 +1718,12 @@ static int pp_collect_finished(struct parallel_processes *pp)
 
 		code = finish_command(&pp->children[i].process);
 
-		code = pp->task_finished(code, pp->ungroup ? NULL :
-					 &pp->children[i].err, pp->data,
-					 pp->children[i].data);
+		if (opts->task_finished)
+			code = opts->task_finished(code, pp->ungroup ? NULL :
+						   &pp->children[i].err, pp->data,
+						   pp->children[i].data);
+		else
+			code = 0;
 
 		if (code)
 			result = code;
@@ -1804,7 +1787,7 @@ void run_processes_parallel(const struct run_process_parallel_opts *opts)
 		    i < spawn_cap && !pp.shutdown &&
 		    pp.nr_processes < pp.max_processes;
 		    i++) {
-			code = pp_start_one(&pp);
+			code = pp_start_one(&pp, opts);
 			if (!code)
 				continue;
 			if (code < 0) {
@@ -1824,7 +1807,7 @@ void run_processes_parallel(const struct run_process_parallel_opts *opts)
 			pp_buffer_stderr(&pp, output_timeout);
 			pp_output(&pp);
 		}
-		code = pp_collect_finished(&pp);
+		code = pp_collect_finished(&pp, opts);
 		if (code) {
 			pp.shutdown = 1;
 			if (code < 0)
-- 
2.38.0.rc2.935.g6b421ae1592

