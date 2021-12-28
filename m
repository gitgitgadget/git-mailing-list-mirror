Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71B5CC433F5
	for <git@archiver.kernel.org>; Tue, 28 Dec 2021 19:36:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237198AbhL1Tg5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Dec 2021 14:36:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237176AbhL1Tgt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Dec 2021 14:36:49 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34682C06173F
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 11:36:49 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id a9so40081291wrr.8
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 11:36:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=MzyQ7sKYS6t8DnWeU9JqW61Cri7RU8Dnj0m1yVwcC+M=;
        b=QLmG9tJ+plBFn/je+WSo1A6JtYy25X4fkFIk7Cxw6N0EGHPMYpeB81/S3KdgN2LWn8
         OcMIbIxWzLkn3Qq16pKpE9aWZLT4E+IGxxRrDitBku1zypL6tt2VVFVK1rxrOoGiq83j
         PZZ6+Fv7HM/8pgIYPlE6rErRZayzMtG8b1q2BDtV0ZQvbdzspfcTeiY4B8ZMVWSJDXGn
         vq0S28XGBXtjm9y9xaigbJa0OESS8eOjCXRFMtuTAE376jtN5L5XrnUMuE2mRuwNV7Dm
         qCB6Mk4ybgPwsEhhQ32R5giKCEGplWDiUsQ8DPj+ETpEGT/gBUdX9aAOmNHusi+tQjuY
         BbXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=MzyQ7sKYS6t8DnWeU9JqW61Cri7RU8Dnj0m1yVwcC+M=;
        b=73rFF5YimLeEP9gci/Z5zJGz9GGzPxXn8yHHt08F4JKbGR87zif84Ynr0pJVI16dul
         SU6RymP6EDyrqcYB5y2xqHIYbhA86Rhp55bMkbIQ2s/bU8vCX1sCKMkGdX/u6ujHuyBu
         eq7ExtRrgFuMjF6v1z+Fq71ZT3wxNApKG7XOqkERtcxVXHkcSI6KU/Szx5mUqj1QCD2B
         O5mSFI2yask3/yvaQ9B72Y1KAHEX/ERtKbO2pWaOvEmEWa10nYlm9dmuka/DtpuYiS9V
         HieRFLI3NIeQa/BwFBERn0i78FaDL+mdoSti96LEX5qBOm+mD+hrMt77SreT8xOzZvn8
         5GDw==
X-Gm-Message-State: AOAM533ObrTdZ4ABlFXE5apBBaBI8n3c2VxT3X7fyN4BCpweHrMz/BxW
        XdQk6IejlAY+Iu9vPYFciEcOPNB3WLA=
X-Google-Smtp-Source: ABdhPJwaY1HCFe6138AMTlW0kg1UDiutRLM7N2hZqqBsyo7sYHQfJtMehgvac6rqbffmG//eYKCHwQ==
X-Received: by 2002:a5d:548a:: with SMTP id h10mr17740920wrv.221.1640720207581;
        Tue, 28 Dec 2021 11:36:47 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u11sm10808140wmq.41.2021.12.28.11.36.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Dec 2021 11:36:47 -0800 (PST)
Message-Id: <62a5c8b035671e8b5df6121660e657ba216d90fc.1640720202.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1099.v2.git.1640720202.gitgitgadget@gmail.com>
References: <pull.1099.git.1640012469.gitgitgadget@gmail.com>
        <pull.1099.v2.git.1640720202.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 28 Dec 2021 19:36:39 +0000
Subject: [PATCH v2 6/9] trace2: add timer events to perf and event target
 formats
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <stolee@gmail.com>,
        Matheus Tavares <matheus.bernardino@usp.br>,
        Johannes Sixt <j6t@kdbg.org>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Teach Trace2 "perf" and "event" formats to handle "timer" events for
stopwatch timers.  Update API documentation accordingly.

In a future commit, stopwatch timers will be added to the Trace2 API
and it will emit these "timer" events.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 Documentation/technical/api-trace2.txt | 23 ++++++++++++++++++++
 trace2/tr2_tgt.h                       | 25 ++++++++++++++++++++++
 trace2/tr2_tgt_event.c                 | 29 ++++++++++++++++++++++++++
 trace2/tr2_tgt_normal.c                |  1 +
 trace2/tr2_tgt_perf.c                  | 27 ++++++++++++++++++++++++
 5 files changed, 105 insertions(+)

diff --git a/Documentation/technical/api-trace2.txt b/Documentation/technical/api-trace2.txt
index bb13ca3db8b..351d140879e 100644
--- a/Documentation/technical/api-trace2.txt
+++ b/Documentation/technical/api-trace2.txt
@@ -815,6 +815,29 @@ The "value" field may be an integer or a string.
 }
 ------------
 
+`"timer"`::
+	This event is generated at the end of the program and contains
+	statistics for a global stopwatch timer.
++
+------------
+{
+	"event":"timer",
+	...
+	"name":"test",      # timer name
+	"count":42,         # number of start+stop intervals
+	"ns_total":1234,    # sum of all intervals in nanoseconds
+	"ns_min":11,        # shortest interval in nanoseconds
+	"ns_max":789,       # longest interval in nanoseconds
+}
+------------
++
+Stopwatch timer data is independently collected by each thread and then
+aggregated for the whole program, so the total time reported here
+may exceed the "atexit" elapsed time of the program.
++
+Timer events may represent an individual thread or a summation across
+the entire program.  Summation events will have a unique thread name.
+
 == Example Trace2 API Usage
 
 Here is a hypothetical usage of the Trace2 API showing the intended
diff --git a/trace2/tr2_tgt.h b/trace2/tr2_tgt.h
index 65f94e15748..a41f91d09b5 100644
--- a/trace2/tr2_tgt.h
+++ b/trace2/tr2_tgt.h
@@ -96,6 +96,30 @@ typedef void(tr2_tgt_evt_printf_va_fl_t)(const char *file, int line,
 					 uint64_t us_elapsed_absolute,
 					 const char *fmt, va_list ap);
 
+/*
+ * Stopwatch timer event.  This function writes the previously accumulated
+ * stopwatch timer values to the event streams.  Unlike other Trace2 API
+ * events, this is decoupled from the data collection.
+ *
+ * This does not take a (file,line) pair because a timer event reports
+ * the cumulative time spend in the timer over a series of intervals
+ * -- it does not represent a single usage (like region or data events
+ * do).
+ *
+ * The thread name is optional.  If non-null it will override the
+ * value inherited from the caller's thread local storage.  This
+ * allows timer data to be aggregated and reported without associating
+ * it to a specific thread.
+ */
+typedef void(tr2_tgt_evt_timer_t)(uint64_t us_elapsed_absolute,
+				  const char *thread_name,
+				  const char *category,
+				  const char *timer_name,
+				  uint64_t interval_count,
+				  uint64_t ns_total_time,
+				  uint64_t ns_min_time,
+				  uint64_t ns_max_time);
+
 /*
  * "vtable" for a TRACE2 target.  Use NULL if a target does not want
  * to emit that message.
@@ -132,6 +156,7 @@ struct tr2_tgt {
 	tr2_tgt_evt_data_fl_t                   *pfn_data_fl;
 	tr2_tgt_evt_data_json_fl_t              *pfn_data_json_fl;
 	tr2_tgt_evt_printf_va_fl_t              *pfn_printf_va_fl;
+	tr2_tgt_evt_timer_t                     *pfn_timer;
 };
 /* clang-format on */
 
diff --git a/trace2/tr2_tgt_event.c b/trace2/tr2_tgt_event.c
index 4ce50944298..fe89e80bb1a 100644
--- a/trace2/tr2_tgt_event.c
+++ b/trace2/tr2_tgt_event.c
@@ -615,6 +615,34 @@ static void fn_data_json_fl(const char *file, int line,
 	}
 }
 
+static void fn_timer(uint64_t us_elapsed_absolute,
+		     const char *thread_name,
+		     const char *category,
+		     const char *timer_name,
+		     uint64_t interval_count,
+		     uint64_t ns_total_time,
+		     uint64_t ns_min_time,
+		     uint64_t ns_max_time)
+{
+	const char *event_name = "timer";
+	struct json_writer jw = JSON_WRITER_INIT;
+	double t_abs = (double)us_elapsed_absolute / 1000000.0;
+
+	jw_object_begin(&jw, 0);
+	event_fmt_prepare(event_name, __FILE__, __LINE__, NULL, &jw, thread_name);
+	jw_object_double(&jw, "t_abs", 6, t_abs);
+	jw_object_string(&jw, "name", timer_name);
+	jw_object_intmax(&jw, "count", interval_count);
+	jw_object_intmax(&jw, "ns_total", ns_total_time);
+	jw_object_intmax(&jw, "ns_min", ns_min_time);
+	jw_object_intmax(&jw, "ns_max", ns_max_time);
+
+	jw_end(&jw);
+
+	tr2_dst_write_line(&tr2dst_event, &jw.json);
+	jw_release(&jw);
+}
+
 struct tr2_tgt tr2_tgt_event = {
 	&tr2dst_event,
 
@@ -646,4 +674,5 @@ struct tr2_tgt tr2_tgt_event = {
 	fn_data_fl,
 	fn_data_json_fl,
 	NULL, /* printf */
+	fn_timer,
 };
diff --git a/trace2/tr2_tgt_normal.c b/trace2/tr2_tgt_normal.c
index 58d9e430f05..23a7e78dcaa 100644
--- a/trace2/tr2_tgt_normal.c
+++ b/trace2/tr2_tgt_normal.c
@@ -355,4 +355,5 @@ struct tr2_tgt tr2_tgt_normal = {
 	NULL, /* data */
 	NULL, /* data_json */
 	fn_printf_va_fl,
+	NULL, /* timer */
 };
diff --git a/trace2/tr2_tgt_perf.c b/trace2/tr2_tgt_perf.c
index c008fd08ae8..c07ffad1a32 100644
--- a/trace2/tr2_tgt_perf.c
+++ b/trace2/tr2_tgt_perf.c
@@ -555,6 +555,32 @@ static void fn_printf_va_fl(const char *file, int line,
 	strbuf_release(&buf_payload);
 }
 
+static void fn_timer(uint64_t us_elapsed_absolute,
+		     const char *thread_name,
+		     const char *category,
+		     const char *timer_name,
+		     uint64_t interval_count,
+		     uint64_t ns_total_time,
+		     uint64_t ns_min_time,
+		     uint64_t ns_max_time)
+{
+	const char *event_name = "timer";
+	struct strbuf buf_payload = STRBUF_INIT;
+
+	strbuf_addf(&buf_payload, ("name:%s"
+				   " count:%"PRIu64
+				   " ns_total:%"PRIu64
+				   " ns_min:%"PRIu64
+				   " ns_max:%"PRIu64),
+		    timer_name, interval_count, ns_total_time, ns_min_time,
+		    ns_max_time);
+
+	perf_io_write_fl(__FILE__, __LINE__, event_name, NULL,
+			 &us_elapsed_absolute, NULL,
+			 category, &buf_payload, thread_name);
+	strbuf_release(&buf_payload);
+}
+
 struct tr2_tgt tr2_tgt_perf = {
 	&tr2dst_perf,
 
@@ -586,4 +612,5 @@ struct tr2_tgt tr2_tgt_perf = {
 	fn_data_fl,
 	fn_data_json_fl,
 	fn_printf_va_fl,
+	fn_timer,
 };
-- 
gitgitgadget

