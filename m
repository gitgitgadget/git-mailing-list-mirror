Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C822DC433FE
	for <git@archiver.kernel.org>; Wed, 12 Oct 2022 09:03:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbiJLJDN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Oct 2022 05:03:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbiJLJCi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2022 05:02:38 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28BA6BC455
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 02:02:03 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id az22-20020a05600c601600b003c6b72797fdso792522wmb.5
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 02:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XXfkWFxR2czHSHKhsFpSxQ+BbDofQrKSG9T2oknMJ00=;
        b=In9kjOJZqmbNGEqQRVbxNdu7KSPUx3V24/olGlRuiDmZsbdX0+VRK9840YZPieAmq+
         /N8jLnKE561fk1xboB6qqGFx+CeuaFlKzNOdRnTCku5iz2dou8eZjNu95nIXQChmYneP
         MBUrTDWl+IRrSHnpiNLXEJhv71pSPet4HUsF/EwRpSndBDa7u2iuSFIq+vOnmjAZr2Q0
         So6sF0cnqGNTIuvtQY7cDY6dTEa4iLew/y+hNRHBcVwIcPzUcb1fDFb5kmJCwqxMrsFg
         Lw7Wl2fQUD+f+sjj8NxlmhIwfHvqLg3jRxXFo7pjtuPSZOn/4oifdoK/vdpMiWl0bROy
         Ix/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XXfkWFxR2czHSHKhsFpSxQ+BbDofQrKSG9T2oknMJ00=;
        b=62pV2CWFGTnWw8QfqZH5eRnlnAQottsV+Az3pLGGSgrcXjM54djjKlGzysrhSVvztj
         kuPz38EqEDWSQ27WR2iJfibgVDRReuVdnTBqFjGEm1NHZxVUOhw3nc2q9WE9DniunrON
         6WdxEieokFgFDjdXF/m96LSa6ornO7VALdYZrPcCcTtLkPggHIN5oo/EXzv/6xskOZsz
         hXigHNV8/zNO8Bew0rK0KTxvJGivXwlhrtiaZgOs9JjV3rz2afCJ8JXzOce4JZ9leTd+
         7y8+mJgxVRA7Ld8s1WyzdI4SexJYZGaRnirfUKaijh9wmQe4vVgSWWwceYoj2mUtzzKB
         ZI8w==
X-Gm-Message-State: ACrzQf2dkaJXGeyvALFm6JxMnFAik27f4ge++NOSywNsEx+gcqV75sW/
        +JCRjskCoHSUzCRcCpa/7mGHFNSL2cUEAg==
X-Google-Smtp-Source: AMsMyM7iKiJkxCJ+VycETdEzmNCyUnNbf8U3Iq1PvyfvTHOuPRfQKr3i4VNu8d8LFcm2rzq5Yt2jwA==
X-Received: by 2002:a7b:cbc4:0:b0:3b4:fd67:d70d with SMTP id n4-20020a7bcbc4000000b003b4fd67d70dmr2023558wmi.98.1665565321445;
        Wed, 12 Oct 2022 02:02:01 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b1-20020a05600c4e0100b003a3170a7af9sm1280362wmq.4.2022.10.12.02.01.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 02:02:00 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Calvin Wan <calvinwan@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 17/22] run-command.c: don't copy *_fn to "struct parallel_processes"
Date:   Wed, 12 Oct 2022 11:01:25 +0200
Message-Id: <patch-v2-17.22-fdd64236985-20221012T084850Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.971.ge79ff6d20e7
In-Reply-To: <cover-v2-00.22-00000000000-20221012T084850Z-avarab@gmail.com>
References: <cover-00.15-00000000000-20220930T111343Z-avarab@gmail.com> <cover-v2-00.22-00000000000-20221012T084850Z-avarab@gmail.com>
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
index 6c343b9b77b..4fce1193b66 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1500,10 +1500,6 @@ struct parallel_processes {
 	const size_t max_processes;
 	size_t nr_processes;
 
-	get_next_task_fn get_next_task;
-	start_failure_fn start_failure;
-	task_finished_fn task_finished;
-
 	struct {
 		enum child_state state;
 		struct child_process process;
@@ -1523,21 +1519,6 @@ struct parallel_processes {
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
@@ -1558,9 +1539,6 @@ static void pp_init(struct parallel_processes *pp,
 		    const struct run_process_parallel_opts *opts)
 {
 	const size_t n = opts->processes;
-	get_next_task_fn get_next_task = opts->get_next_task;
-	start_failure_fn start_failure = opts->start_failure;
-	task_finished_fn task_finished = opts->task_finished;
 
 	if (!n)
 		BUG("you must provide a non-zero number of processes!");
@@ -1568,12 +1546,8 @@ static void pp_init(struct parallel_processes *pp,
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
@@ -1620,7 +1594,8 @@ static void pp_cleanup(struct parallel_processes *pp)
  * <0 no new job was started, user wishes to shutdown early. Use negative code
  *    to signal the children.
  */
-static int pp_start_one(struct parallel_processes *pp)
+static int pp_start_one(struct parallel_processes *pp,
+			const struct run_process_parallel_opts *opts)
 {
 	size_t i;
 	int code;
@@ -1631,10 +1606,10 @@ static int pp_start_one(struct parallel_processes *pp)
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
@@ -1649,10 +1624,14 @@ static int pp_start_one(struct parallel_processes *pp)
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
@@ -1705,7 +1684,8 @@ static void pp_output(const struct parallel_processes *pp)
 	}
 }
 
-static int pp_collect_finished(struct parallel_processes *pp)
+static int pp_collect_finished(struct parallel_processes *pp,
+			       const struct run_process_parallel_opts *opts)
 {
 	int code;
 	size_t i, n = pp->max_processes;
@@ -1720,9 +1700,12 @@ static int pp_collect_finished(struct parallel_processes *pp)
 
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
@@ -1791,7 +1774,7 @@ void run_processes_parallel(const struct run_process_parallel_opts *opts)
 		    i < spawn_cap && !pp.shutdown &&
 		    pp.nr_processes < pp.max_processes;
 		    i++) {
-			code = pp_start_one(&pp);
+			code = pp_start_one(&pp, opts);
 			if (!code)
 				continue;
 			if (code < 0) {
@@ -1809,7 +1792,7 @@ void run_processes_parallel(const struct run_process_parallel_opts *opts)
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

