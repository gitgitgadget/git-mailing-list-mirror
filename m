Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8757C433F5
	for <git@archiver.kernel.org>; Mon, 20 Dec 2021 15:21:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239609AbhLTPVo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Dec 2021 10:21:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240232AbhLTPTs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Dec 2021 10:19:48 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA74BC0698DF
        for <git@vger.kernel.org>; Mon, 20 Dec 2021 07:01:15 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id b186-20020a1c1bc3000000b00345734afe78so102110wmb.0
        for <git@vger.kernel.org>; Mon, 20 Dec 2021 07:01:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=nesuMok0cLAOuodSJOi0AB21PJ7ZUZYUwDjxz50WiK0=;
        b=mIT2YSvZ8kXZI8hX4oNrsnJPy6V0HklcSDNLY5DgfPtMZMnMsOq+8VGZFZXVAPjpoL
         LiFwMVPvBGzZwblsCFcsIl/fHSpS6WA4+j8ZfpQDYy7+bo6xQhHJwcNDdOLSxR4kFEXO
         NHadqMI6jJ19Omdp9Ov1zdfrZ0XlMx9LNo8pL6+HgMfPea2mkPL44hpEOQWAaCZwSW0y
         btQOSs7Bi3V6+VsLRyhdYOj8I5wrywvj4t6G6G44xS6v7j/cLsNI5hsnBknMkG+a+Jay
         qDR0p2pcxwBb8PFpADtoAg2B5OEiaOt+25gNchCrpQnXjwp+7Xav4wgHKwxieDrSYOM9
         C+iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=nesuMok0cLAOuodSJOi0AB21PJ7ZUZYUwDjxz50WiK0=;
        b=RzfTUphpmuc9SeimQhSn7anEkW6gIIwXR18ZYZaSCE9/rQNXMPYXn1dickZFEF6zo6
         gBZp292bnYsiCsRqu16Kitz7d36KetldPOpJU426akEyNKsLmyUtGSb2nbJ/52JyUOZx
         b0pvYwDF2Q328s5COnW185uZNoORMfmOdMLnOpbS8va/C3n60BRYInJLdAb5Ql037ZHn
         dlIxBqwNIPzSoRaqtvVIXnbXYYU6Lj5zHFasdE3nkmdeEqsxyBrncqY98B+LDm1zY9qO
         zmzfjP5NFZqMo5FfAcKonr9MHZ3UARQnRlC7Y2YlLgJmsDivs3Y88UonoIhi9/2Lt/zF
         tWxg==
X-Gm-Message-State: AOAM533kzhL13rJH4KYNpW9UTp6+TcgumJJnhTY1BEvO+C0u61wwxHZH
        0YVTxy1CEqBKdX847f/FsL12MwZMcPc=
X-Google-Smtp-Source: ABdhPJyKkqyJGzUrFs3tmsLZ5c5BX8ha07T7wTf4gWRJvtJIfGoyiyb0xAVj6BVW8pD8AbjVv4PaLA==
X-Received: by 2002:a7b:c94f:: with SMTP id i15mr14398571wml.79.1640012474054;
        Mon, 20 Dec 2021 07:01:14 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t8sm20283716wmq.32.2021.12.20.07.01.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Dec 2021 07:01:13 -0800 (PST)
Message-Id: <c5d5ff05e6ca5729993133ce0b6b94af2503808a.1640012469.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1099.git.1640012469.gitgitgadget@gmail.com>
References: <pull.1099.git.1640012469.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 20 Dec 2021 15:01:06 +0000
Subject: [PATCH 6/9] trace2: add timer events to perf and event target formats
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhost@microsoft.com>,
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
 Documentation/technical/api-trace2.txt | 25 +++++++++++++++-
 trace2/tr2_tgt.h                       | 25 ++++++++++++++++
 trace2/tr2_tgt_event.c                 | 40 +++++++++++++++++++++++++-
 trace2/tr2_tgt_normal.c                |  1 +
 trace2/tr2_tgt_perf.c                  | 29 +++++++++++++++++++
 5 files changed, 118 insertions(+), 2 deletions(-)

diff --git a/Documentation/technical/api-trace2.txt b/Documentation/technical/api-trace2.txt
index bb13ca3db8b..e6ed94ba814 100644
--- a/Documentation/technical/api-trace2.txt
+++ b/Documentation/technical/api-trace2.txt
@@ -391,7 +391,7 @@ only present on the "start" and "atexit" events.
 {
 	"event":"version",
 	...
-	"evt":"3",		       # EVENT format version
+	"evt":"4",		       # EVENT format version
 	"exe":"2.20.1.155.g426c96fcdb" # git version
 }
 ------------
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
+	"t_total":1.234,    # sum of all intervals (by thread or globally)
+	"t_min":0.1,        # shortest interval
+	"t_max":0.9,        # longest interval
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
index 65f94e15748..1f548eb4b93 100644
--- a/trace2/tr2_tgt.h
+++ b/trace2/tr2_tgt.h
@@ -96,6 +96,30 @@ typedef void(tr2_tgt_evt_printf_va_fl_t)(const char *file, int line,
 					 uint64_t us_elapsed_absolute,
 					 const char *fmt, va_list ap);
 
+/*
+ * Stopwatch timer event.  This function writes the previously accumlated
+ * stopwatch timer values to the event streams.  Unlike other Trace2 API
+ * events, this is decoupled from the data collection.
+ *
+ * This does not take a (file,line) pair because a timer event reports
+ * the cummulative time spend in the timer over a series of intervals
+ * -- it does not represent a single usage (like region or data events
+ * do).
+ *
+ * The thread name is optional.  If non-null it will override the
+ * value inherited from the caller's TLS CTX.  This allows data
+ * for global timers to be reported without associating it with a
+ * single thread.
+ */
+typedef void(tr2_tgt_evt_timer_t)(uint64_t us_elapsed_absolute,
+				  const char *thread_name,
+				  const char *category,
+				  const char *timer_name,
+				  uint64_t interval_count,
+				  uint64_t us_total_time,
+				  uint64_t us_min_time,
+				  uint64_t us_max_time);
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
index 4ce50944298..9b3905b920c 100644
--- a/trace2/tr2_tgt_event.c
+++ b/trace2/tr2_tgt_event.c
@@ -19,8 +19,13 @@ static struct tr2_dst tr2dst_event = { TR2_SYSENV_EVENT, 0, 0, 0, 0 };
  * interpretation of existing events or fields. Smaller changes, such as adding
  * a new field to an existing event, do not require an increment to the EVENT
  * format version.
+ *
+ * Verison 1: original version
+ * Version 2: added "too_many_files" event
+ * Version 3: added "child_ready" event
+ * Version 4: added "timer" event
  */
-#define TR2_EVENT_VERSION "3"
+#define TR2_EVENT_VERSION "4"
 
 /*
  * Region nesting limit for messages written to the event target.
@@ -615,6 +620,38 @@ static void fn_data_json_fl(const char *file, int line,
 	}
 }
 
+static void fn_timer(uint64_t us_elapsed_absolute,
+		     const char *thread_name,
+		     const char *category,
+		     const char *timer_name,
+		     uint64_t interval_count,
+		     uint64_t us_total_time,
+		     uint64_t us_min_time,
+		     uint64_t us_max_time)
+{
+	const char *event_name = "timer";
+	struct json_writer jw = JSON_WRITER_INIT;
+	double t_abs = (double)us_elapsed_absolute / 1000000.0;
+
+	double t_total = (double)us_total_time / 1000000.0;
+	double t_min   = (double)us_min_time   / 1000000.0;
+	double t_max   = (double)us_max_time   / 1000000.0;
+
+	jw_object_begin(&jw, 0);
+	event_fmt_prepare(event_name, __FILE__, __LINE__, NULL, &jw, thread_name);
+	jw_object_double(&jw, "t_abs", 6, t_abs);
+	jw_object_string(&jw, "name", timer_name);
+	jw_object_intmax(&jw, "count", interval_count);
+	jw_object_double(&jw, "t_total", 6, t_total);
+	jw_object_double(&jw, "t_min", 6, t_min);
+	jw_object_double(&jw, "t_max", 6, t_max);
+
+	jw_end(&jw);
+
+	tr2_dst_write_line(&tr2dst_event, &jw.json);
+	jw_release(&jw);
+}
+
 struct tr2_tgt tr2_tgt_event = {
 	&tr2dst_event,
 
@@ -646,4 +683,5 @@ struct tr2_tgt tr2_tgt_event = {
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
index 47293e99d4b..7597cb52ed5 100644
--- a/trace2/tr2_tgt_perf.c
+++ b/trace2/tr2_tgt_perf.c
@@ -554,6 +554,34 @@ static void fn_printf_va_fl(const char *file, int line,
 	strbuf_release(&buf_payload);
 }
 
+static void fn_timer(uint64_t us_elapsed_absolute,
+		     const char *thread_name,
+		     const char *category,
+		     const char *timer_name,
+		     uint64_t interval_count,
+		     uint64_t us_total_time,
+		     uint64_t us_min_time,
+		     uint64_t us_max_time)
+{
+	const char *event_name = "timer";
+	struct strbuf buf_payload = STRBUF_INIT;
+
+	double t_total = (double)us_total_time / 1000000.0;
+	double t_min   = (double)us_min_time   / 1000000.0;
+	double t_max   = (double)us_max_time   / 1000000.0;
+
+	strbuf_addf(&buf_payload, "name:%s", timer_name);
+	strbuf_addf(&buf_payload, " count:%"PRIu64, interval_count);
+	strbuf_addf(&buf_payload, " total:%9.6f", t_total);
+	strbuf_addf(&buf_payload, " min:%9.6f", t_min);
+	strbuf_addf(&buf_payload, " max:%9.6f", t_max);
+
+	perf_io_write_fl(__FILE__, __LINE__, event_name, NULL,
+			 &us_elapsed_absolute, NULL,
+			 category, &buf_payload, thread_name);
+	strbuf_release(&buf_payload);
+}
+
 struct tr2_tgt tr2_tgt_perf = {
 	&tr2dst_perf,
 
@@ -585,4 +613,5 @@ struct tr2_tgt tr2_tgt_perf = {
 	fn_data_fl,
 	fn_data_json_fl,
 	fn_printf_va_fl,
+	fn_timer,
 };
-- 
gitgitgadget

