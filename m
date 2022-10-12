Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AA8EC4332F
	for <git@archiver.kernel.org>; Wed, 12 Oct 2022 21:04:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbiJLVEU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Oct 2022 17:04:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbiJLVDq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2022 17:03:46 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C2EA65832
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 14:03:35 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id j16so27954990wrh.5
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 14:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pyQuvVPLUhRkE12mMGAs/wCv7zpX+3e+wsxOYmbq5ic=;
        b=fOG1rtwi5M7Np6C496k4rXtSwA/54spu2F+G/sGw1nE0aU74z4iv65HOYWvEf4CQ2C
         Qd90T9AtCOFGrR3BQWvd81Xio9VHeScELNnC6R+MxYz0OfRRY69pnDbVd+4EusBowglB
         FwqWqxNdYp8oRKLNq+XKreF0nHwe4stoHjgxCaY6VMnJzyVi7r5PQGk6kMm0viWfr+wx
         LGqEQPiJ+x7r/Al+d9xLmXIN5+OTOoisIzrygRXgUNJPV3MLJ5BWJ005kvn4mH/MLJma
         A/3YUAb7EmYmY/0IxMChLdir/Pr+UE0g1Ad8P1mIKKzb7vXDJ1jJ6NcNR9AEmBpcHXjN
         EWLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pyQuvVPLUhRkE12mMGAs/wCv7zpX+3e+wsxOYmbq5ic=;
        b=2BQKVJyczkThpVGHgVdXbjA4SkCut3CIySj7hPXYKVnsr1ASsPSPzQUjz90MxOCAlt
         iPX4E49blUOofsItX6NkEDDlSLwzonI/mDi5czYsGIdK66nYKbdKn6GYbjjqHx6jQ9TN
         QZztvpwUWFUsKWYt/uvO3T7ImvA2SCzjOhNJpIkwyTfAeaOPktJTbRU8FP/4dPUjWeQX
         XL0Hjp360ASrAldpuBfoCh8TEqIiHT3sz/65t2493DGvOyzvLV2DxNE6Sb9MoT3BmIu+
         B1g0m77zIJf3S31FIVJ9Y6orjYaXRUSLBhM32e80LTjidplSe42dBdD9otJ5MVDwGVQ8
         vxxA==
X-Gm-Message-State: ACrzQf1pFcioYA7f2hjTmgbCto63vEU+ww93+w9gBWgs8VzIOfPlPdbT
        wDLmYrx7xyTj2yuClm9WggTNACwkxglQeg==
X-Google-Smtp-Source: AMsMyM7drO6zJLcsZXqIUmNAEyWHNoU2I/jFR0HjVWUbpudHEOZZxeiCFeAg6xhdpHpquYfYBEifDg==
X-Received: by 2002:adf:fd04:0:b0:22e:4bf6:4a08 with SMTP id e4-20020adffd04000000b0022e4bf64a08mr20459593wrr.619.1665608613151;
        Wed, 12 Oct 2022 14:03:33 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b6-20020adff246000000b00228a6ce17b4sm550079wrp.37.2022.10.12.14.03.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 14:03:32 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Calvin Wan <calvinwan@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 10/15] run-command.c: don't copy *_fn to "struct parallel_processes"
Date:   Wed, 12 Oct 2022 23:02:29 +0200
Message-Id: <patch-v3-10.15-bf67e24bcc5-20221012T205712Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.971.ge79ff6d20e7
In-Reply-To: <cover-v3-00.15-00000000000-20221012T205712Z-avarab@gmail.com>
References: <cover-v2-00.22-00000000000-20221012T084850Z-avarab@gmail.com> <cover-v3-00.15-00000000000-20221012T205712Z-avarab@gmail.com>
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
index a72c4295adc..e10b1b97390 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1502,10 +1502,6 @@ struct parallel_processes {
 	const size_t max_processes;
 	size_t nr_processes;
 
-	get_next_task_fn get_next_task;
-	start_failure_fn start_failure;
-	task_finished_fn task_finished;
-
 	struct {
 		enum child_state state;
 		struct child_process process;
@@ -1525,21 +1521,6 @@ struct parallel_processes {
 	struct strbuf buffered_output; /* of finished children */
 };
 
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
 static void kill_children(const struct parallel_processes *pp, int signo)
 {
 	for (size_t i = 0; i < pp->max_processes; i++)
@@ -1560,9 +1541,6 @@ static void pp_init(struct parallel_processes *pp,
 		    const struct run_process_parallel_opts *opts)
 {
 	const size_t n = opts->processes;
-	get_next_task_fn get_next_task = opts->get_next_task;
-	start_failure_fn start_failure = opts->start_failure;
-	task_finished_fn task_finished = opts->task_finished;
 
 	if (!n)
 		BUG("you must provide a non-zero number of processes!");
@@ -1570,12 +1548,8 @@ static void pp_init(struct parallel_processes *pp,
 	trace_printf("run_processes_parallel: preparing to run up to %"PRIuMAX" tasks",
 		     (uintmax_t)n);
 
-	if (!get_next_task)
+	if (!opts->get_next_task)
 		BUG("you need to specify a get_next_task function");
-	pp->get_next_task = get_next_task;
-
-	pp->start_failure = start_failure ? start_failure : default_start_failure;
-	pp->task_finished = task_finished ? task_finished : default_task_finished;
 
 	CALLOC_ARRAY(pp->children, n);
 	if (!pp->ungroup)
@@ -1622,7 +1596,8 @@ static void pp_cleanup(struct parallel_processes *pp)
  * <0 no new job was started, user wishes to shutdown early. Use negative code
  *    to signal the children.
  */
-static int pp_start_one(struct parallel_processes *pp)
+static int pp_start_one(struct parallel_processes *pp,
+			const struct run_process_parallel_opts *opts)
 {
 	size_t i;
 	int code;
@@ -1633,10 +1608,10 @@ static int pp_start_one(struct parallel_processes *pp)
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
@@ -1651,10 +1626,14 @@ static int pp_start_one(struct parallel_processes *pp)
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
@@ -1709,7 +1688,8 @@ static void pp_output(const struct parallel_processes *pp)
 	}
 }
 
-static int pp_collect_finished(struct parallel_processes *pp)
+static int pp_collect_finished(struct parallel_processes *pp,
+			       const struct run_process_parallel_opts *opts)
 {
 	int code;
 	size_t i, n = pp->max_processes;
@@ -1724,9 +1704,12 @@ static int pp_collect_finished(struct parallel_processes *pp)
 
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
@@ -1795,7 +1778,7 @@ void run_processes_parallel(const struct run_process_parallel_opts *opts)
 		    i < spawn_cap && !pp.shutdown &&
 		    pp.nr_processes < pp.max_processes;
 		    i++) {
-			code = pp_start_one(&pp);
+			code = pp_start_one(&pp, opts);
 			if (!code)
 				continue;
 			if (code < 0) {
@@ -1813,7 +1796,7 @@ void run_processes_parallel(const struct run_process_parallel_opts *opts)
 			pp_buffer_stderr(&pp, output_timeout);
 			pp_output(&pp);
 		}
-		code = pp_collect_finished(&pp);
+		code = pp_collect_finished(&pp, opts);
 		if (code) {
 			pp.shutdown = 1;
 			if (code < 0)
-- 
2.38.0.971.ge79ff6d20e7

