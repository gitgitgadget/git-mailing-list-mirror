Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E2B2C433FE
	for <git@archiver.kernel.org>; Mon, 20 Sep 2021 15:36:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E2BB61107
	for <git@archiver.kernel.org>; Mon, 20 Sep 2021 15:36:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237257AbhITPhv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Sep 2021 11:37:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236512AbhITPht (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Sep 2021 11:37:49 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42798C061760
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 08:36:22 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id u15so30930351wru.6
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 08:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=F7ftG0KmR42eaPTl8ZcevL+CQzKh8Tj9uSnnBfOlSG0=;
        b=egtEJ30qTUmv+FMkIvcC0ROGbgr04xDVIsrNsb/vTCjn2N2U1RfCLSc8pTdH9PO3uH
         xIlS/LdAWGIVhmWD5CS58danBdZs7ttyoIzLhzgo7G0AON4gcQ1di/ggTr3+V1E9xFrM
         19/VQ61/aYqCFqZVKf9oYJmu7tXkrPXbf6SKssJLAKnl+Nh6Gin4MpCWrwKIsiHvIWWR
         vmY9gb1tPdRV1zdiEx4b/QAv7QwBy1QlnHYyYcs+CDVXoG6+AuZ+TBjXGC6Orups7jXx
         5VKhgCxbwfrOpjW9u/PArGJCn3KYMl+VDcLARsy7PO38V0gpbCLBtXVvPfK64oSBwzFC
         I/aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=F7ftG0KmR42eaPTl8ZcevL+CQzKh8Tj9uSnnBfOlSG0=;
        b=M/FAcuAY+BxQonKecr6IO+g+p7OeERpptQl4qNkkdPGurAebIIks6FGg81RJECb7G1
         qzgxOrG2P2ERbRPzlyj5D+l8jRPb1RYN1N+6OEORO8WQR4m2uuEno1O3n9S4oMeGybrC
         20hUMOIZDgdAEvtjeOUnZ/FuXx+LleZOToGcUGTC4CCtehTD2Wq8XEtrjDz1JflIPc8X
         e3SyS/2p2Lh8xBhMe7DH8Q+4cB6xLYCDpF/Y9ov4mHR5Pp+OeZwKgEgALVXh4fxUdbvt
         kOkV8jYpOR9b7Fnkx1Wjb/OzlRYB3W9g/Tx/iQQ8oyryJCaRO8IK7+kkUyeO+HNyT7po
         hzbw==
X-Gm-Message-State: AOAM532T+intKC+Tf/fEnmYGQdse3tpcsA6LF3Hh4XY/lQ5FjZ/SbMhw
        LCHltJXTXtDtufbK1/TSAKo5oImwUxY=
X-Google-Smtp-Source: ABdhPJxzVD/0FoS1m+UA78VCLML29xy1cxeKBRToxql6Jwgoh/n4JomkJnMcIVlm4/bpIpK6btEaEg==
X-Received: by 2002:a5d:630a:: with SMTP id i10mr29850878wru.178.1632152180679;
        Mon, 20 Sep 2021 08:36:20 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h8sm19165694wmb.35.2021.09.20.08.36.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 08:36:20 -0700 (PDT)
Message-Id: <f88e9feff26a44b07db91d0bb8159529dc082bb1.1632152178.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1040.v2.git.1632152178.gitgitgadget@gmail.com>
References: <pull.1040.git.1631738177.gitgitgadget@gmail.com>
        <pull.1040.v2.git.1632152178.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 20 Sep 2021 15:36:12 +0000
Subject: [PATCH v2 1/7] trace2: add trace2_child_ready() to report on
 background children
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Jeff Hostetler <git@jeffhostetler.com>,
        Carlo Arenas <carenas@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Create "child_ready" event to capture the state of a child process
created in the background.

When a child command is started a "child_start" event is generated in
the Trace2 log.  For normal synchronous children, a "child_exit" event
is later generated when the child exits or is terminated.  The two events
include information, such as the "child_id" and "pid", to allow post
analysis to match-up the command line and exit status.

When a child is started in the background (and may outlive the parent
process), it is not possible for the parent to emit a "child_exit"
event.  Create a new "child_ready" event to indicate whether the
child was successfully started.  Also include the "child_id" and "pid"
to allow similar post processing.

This will be used in a later commit with the new "start_bg_command()".

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 Documentation/technical/api-trace2.txt | 40 ++++++++++++++++++++++++++
 trace2.c                               | 31 ++++++++++++++++++++
 trace2.h                               | 25 ++++++++++++++++
 trace2/tr2_tgt.h                       |  5 ++++
 trace2/tr2_tgt_event.c                 | 22 ++++++++++++++
 trace2/tr2_tgt_normal.c                | 14 +++++++++
 trace2/tr2_tgt_perf.c                  | 15 ++++++++++
 7 files changed, 152 insertions(+)

diff --git a/Documentation/technical/api-trace2.txt b/Documentation/technical/api-trace2.txt
index b9f3198fbe7..ef7fe02a8f7 100644
--- a/Documentation/technical/api-trace2.txt
+++ b/Documentation/technical/api-trace2.txt
@@ -613,6 +613,46 @@ stopping after the waitpid() and includes OS process creation overhead).
 So this time will be slightly larger than the atexit time reported by
 the child process itself.
 
+`"child_ready"`::
+	This event is generated after the current process has started
+	a background process and released all handles to it.
++
+------------
+{
+	"event":"child_ready",
+	...
+	"child_id":2,
+	"pid":14708,	 # child PID
+	"ready":"ready", # child ready state
+	"t_rel":0.110605 # observed run-time of child process
+}
+------------
++
+Note that the session-id of the child process is not available to
+the current/spawning process, so the child's PID is reported here as
+a hint for post-processing.  (But it is only a hint because the child
+process may be a shell script which doesn't have a session-id.)
++
+This event is generated after the child is started in the background
+and given a little time to boot up and start working.  If the child
+startups normally and while the parent is still waiting, the "ready"
+field will have the value "ready".
+If the child is too slow to start and the parent times out, the field
+will have the value "timeout".
+If the child starts but the parent is unable to probe it, the field
+will have the value "error".
++
+After the parent process emits this event, it will release all of its
+handles to the child process and treat the child as a background
+daemon.  So even if the child does eventually finish booting up,
+the parent will not emit an updated event.
++
+Note that the `t_rel` field contains the observed run time in seconds
+when the parent released the child process into the background.
+The child is assumed to be a long-running daemon process and may
+outlive the parent process.  So the parent's child event times should
+not be compared to the child's atexit times.
+
 `"exec"`::
 	This event is generated before git attempts to `exec()`
 	another command rather than starting a child process.
diff --git a/trace2.c b/trace2.c
index b9b154ac440..b2d471526fd 100644
--- a/trace2.c
+++ b/trace2.c
@@ -394,6 +394,37 @@ void trace2_child_exit_fl(const char *file, int line, struct child_process *cmd,
 						 us_elapsed_child);
 }
 
+void trace2_child_ready_fl(const char *file, int line,
+			   struct child_process *cmd,
+			   const char *ready)
+{
+	struct tr2_tgt *tgt_j;
+	int j;
+	uint64_t us_now;
+	uint64_t us_elapsed_absolute;
+	uint64_t us_elapsed_child;
+
+	if (!trace2_enabled)
+		return;
+
+	us_now = getnanotime() / 1000;
+	us_elapsed_absolute = tr2tls_absolute_elapsed(us_now);
+
+	if (cmd->trace2_child_us_start)
+		us_elapsed_child = us_now - cmd->trace2_child_us_start;
+	else
+		us_elapsed_child = 0;
+
+	for_each_wanted_builtin (j, tgt_j)
+		if (tgt_j->pfn_child_ready_fl)
+			tgt_j->pfn_child_ready_fl(file, line,
+						  us_elapsed_absolute,
+						  cmd->trace2_child_id,
+						  cmd->pid,
+						  ready,
+						  us_elapsed_child);
+}
+
 int trace2_exec_fl(const char *file, int line, const char *exe,
 		   const char **argv)
 {
diff --git a/trace2.h b/trace2.h
index 9b7286c572f..6fe9802598b 100644
--- a/trace2.h
+++ b/trace2.h
@@ -253,6 +253,31 @@ void trace2_child_exit_fl(const char *file, int line, struct child_process *cmd,
 #define trace2_child_exit(cmd, code) \
 	trace2_child_exit_fl(__FILE__, __LINE__, (cmd), (code))
 
+/**
+ * Emits a "child_ready" message containing the "child-id" and a flag
+ * indicating whether the child was considered "ready" when we
+ * released it.
+ *
+ * This function should be called after starting a daemon process in
+ * the background (and after giving it sufficient time to boot
+ * up) to indicate that we no longer control or own it.
+ *
+ * The "ready" argument should contain one of { "ready", "timeout",
+ * "error" } to indicate the state of the running daemon when we
+ * released it.
+ *
+ * If the daemon process fails to start or it exits or is terminated
+ * while we are still waiting for it, the caller should emit a
+ * regular "child_exit" to report the normal process exit information.
+ *
+ */
+void trace2_child_ready_fl(const char *file, int line,
+			   struct child_process *cmd,
+			   const char *ready);
+
+#define trace2_child_ready(cmd, ready) \
+	trace2_child_ready_fl(__FILE__, __LINE__, (cmd), (ready))
+
 /**
  * Emit an 'exec' event prior to calling one of exec(), execv(),
  * execvp(), and etc.  On Unix-derived systems, this will be the
diff --git a/trace2/tr2_tgt.h b/trace2/tr2_tgt.h
index 1f66fd65730..65f94e15748 100644
--- a/trace2/tr2_tgt.h
+++ b/trace2/tr2_tgt.h
@@ -45,6 +45,10 @@ typedef void(tr2_tgt_evt_child_exit_fl_t)(const char *file, int line,
 					  uint64_t us_elapsed_absolute, int cid,
 					  int pid, int code,
 					  uint64_t us_elapsed_child);
+typedef void(tr2_tgt_evt_child_ready_fl_t)(const char *file, int line,
+					   uint64_t us_elapsed_absolute,
+					   int cid, int pid, const char *ready,
+					   uint64_t us_elapsed_child);
 
 typedef void(tr2_tgt_evt_thread_start_fl_t)(const char *file, int line,
 					    uint64_t us_elapsed_absolute);
@@ -116,6 +120,7 @@ struct tr2_tgt {
 	tr2_tgt_evt_alias_fl_t                  *pfn_alias_fl;
 	tr2_tgt_evt_child_start_fl_t            *pfn_child_start_fl;
 	tr2_tgt_evt_child_exit_fl_t             *pfn_child_exit_fl;
+	tr2_tgt_evt_child_ready_fl_t            *pfn_child_ready_fl;
 	tr2_tgt_evt_thread_start_fl_t           *pfn_thread_start_fl;
 	tr2_tgt_evt_thread_exit_fl_t            *pfn_thread_exit_fl;
 	tr2_tgt_evt_exec_fl_t                   *pfn_exec_fl;
diff --git a/trace2/tr2_tgt_event.c b/trace2/tr2_tgt_event.c
index 578a9a5287a..70cfc2f77cc 100644
--- a/trace2/tr2_tgt_event.c
+++ b/trace2/tr2_tgt_event.c
@@ -383,6 +383,27 @@ static void fn_child_exit_fl(const char *file, int line,
 	jw_release(&jw);
 }
 
+static void fn_child_ready_fl(const char *file, int line,
+			      uint64_t us_elapsed_absolute, int cid, int pid,
+			      const char *ready, uint64_t us_elapsed_child)
+{
+	const char *event_name = "child_ready";
+	struct json_writer jw = JSON_WRITER_INIT;
+	double t_rel = (double)us_elapsed_child / 1000000.0;
+
+	jw_object_begin(&jw, 0);
+	event_fmt_prepare(event_name, file, line, NULL, &jw);
+	jw_object_intmax(&jw, "child_id", cid);
+	jw_object_intmax(&jw, "pid", pid);
+	jw_object_string(&jw, "ready", ready);
+	jw_object_double(&jw, "t_rel", 6, t_rel);
+	jw_end(&jw);
+
+	tr2_dst_write_line(&tr2dst_event, &jw.json);
+
+	jw_release(&jw);
+}
+
 static void fn_thread_start_fl(const char *file, int line,
 			       uint64_t us_elapsed_absolute)
 {
@@ -610,6 +631,7 @@ struct tr2_tgt tr2_tgt_event = {
 	fn_alias_fl,
 	fn_child_start_fl,
 	fn_child_exit_fl,
+	fn_child_ready_fl,
 	fn_thread_start_fl,
 	fn_thread_exit_fl,
 	fn_exec_fl,
diff --git a/trace2/tr2_tgt_normal.c b/trace2/tr2_tgt_normal.c
index a5751c88644..58d9e430f05 100644
--- a/trace2/tr2_tgt_normal.c
+++ b/trace2/tr2_tgt_normal.c
@@ -251,6 +251,19 @@ static void fn_child_exit_fl(const char *file, int line,
 	strbuf_release(&buf_payload);
 }
 
+static void fn_child_ready_fl(const char *file, int line,
+			      uint64_t us_elapsed_absolute, int cid, int pid,
+			      const char *ready, uint64_t us_elapsed_child)
+{
+	struct strbuf buf_payload = STRBUF_INIT;
+	double elapsed = (double)us_elapsed_child / 1000000.0;
+
+	strbuf_addf(&buf_payload, "child_ready[%d] pid:%d ready:%s elapsed:%.6f",
+		    cid, pid, ready, elapsed);
+	normal_io_write_fl(file, line, &buf_payload);
+	strbuf_release(&buf_payload);
+}
+
 static void fn_exec_fl(const char *file, int line, uint64_t us_elapsed_absolute,
 		       int exec_id, const char *exe, const char **argv)
 {
@@ -330,6 +343,7 @@ struct tr2_tgt tr2_tgt_normal = {
 	fn_alias_fl,
 	fn_child_start_fl,
 	fn_child_exit_fl,
+	fn_child_ready_fl,
 	NULL, /* thread_start */
 	NULL, /* thread_exit */
 	fn_exec_fl,
diff --git a/trace2/tr2_tgt_perf.c b/trace2/tr2_tgt_perf.c
index af4d65a0a5f..e4acca13d64 100644
--- a/trace2/tr2_tgt_perf.c
+++ b/trace2/tr2_tgt_perf.c
@@ -360,6 +360,20 @@ static void fn_child_exit_fl(const char *file, int line,
 	strbuf_release(&buf_payload);
 }
 
+static void fn_child_ready_fl(const char *file, int line,
+			      uint64_t us_elapsed_absolute, int cid, int pid,
+			      const char *ready, uint64_t us_elapsed_child)
+{
+	const char *event_name = "child_ready";
+	struct strbuf buf_payload = STRBUF_INIT;
+
+	strbuf_addf(&buf_payload, "[ch%d] pid:%d ready:%s", cid, pid, ready);
+
+	perf_io_write_fl(file, line, event_name, NULL, &us_elapsed_absolute,
+			 &us_elapsed_child, NULL, &buf_payload);
+	strbuf_release(&buf_payload);
+}
+
 static void fn_thread_start_fl(const char *file, int line,
 			       uint64_t us_elapsed_absolute)
 {
@@ -553,6 +567,7 @@ struct tr2_tgt tr2_tgt_perf = {
 	fn_alias_fl,
 	fn_child_start_fl,
 	fn_child_exit_fl,
+	fn_child_ready_fl,
 	fn_thread_start_fl,
 	fn_thread_exit_fl,
 	fn_exec_fl,
-- 
gitgitgadget

