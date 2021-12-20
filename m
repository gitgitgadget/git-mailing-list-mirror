Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8610FC433FE
	for <git@archiver.kernel.org>; Mon, 20 Dec 2021 15:21:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239636AbhLTPVp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Dec 2021 10:21:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240292AbhLTPTz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Dec 2021 10:19:55 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E64CFC019D93
        for <git@vger.kernel.org>; Mon, 20 Dec 2021 07:01:16 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id s1so15285422wra.6
        for <git@vger.kernel.org>; Mon, 20 Dec 2021 07:01:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=j4FXYtpX3k8craHbH/JSo5Kqm/3gwvHkm2nJWkS/0cE=;
        b=n00c2Ucwa8BCfoklIab7va0BV+tYK2v0W/q9IMQMqzilB8qrI9Cq3IjjWPhmmDUcaS
         g5BtESK/NLu7v43yV+sWudWZgVAoTM3iXNNzj8Kuc2YYAUe2LL0xfg+PRqlxp4E7MSBy
         S80shufTy9X6njBw36tt6eGoO9xqD+5EEMwEeP9KOzcJM47yaBb5VVCqyNLdXTtsk3nN
         ku+5Y4vUFpkcu14Uy7vKDP6EbtZJq/8gjitc/KfIR2ibBeHgKn9Mb9oH2wkfRpMmjxH3
         KiBmq8d35dvrjTr1lbNThGwr3Z2uwWMlf2SA/PzfNtNuNwKpNDxoW0cAE6lyePoJ1MI5
         b9Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=j4FXYtpX3k8craHbH/JSo5Kqm/3gwvHkm2nJWkS/0cE=;
        b=ptaX4FlcpMXMseby1e9BEXoyPll6s+/zaopwgTofDh1ErLlvCidF8TbGi+c2jIdFBE
         rpN8w3v5w3Ep/VFXaYx2W6fzrppD+oMBWSU9AGTT88nruC/QfnBpUpUsEbw5V6lnJtec
         iG+S6fhJQfuUoEIVimDEwxrdy01owtEh4hYT4t7FxCqJ762372OB8EqW6OHltA6HQV7+
         qyIzdohEX3DD6UDzQKynPhVPdXX5nDoGroaxS7e2e4zSFcFjH4nLvk0z7oplDh9eGW3e
         vXAYGaJvXt4iFx6iEzjQbhIBmQpoHoeLwnW4T4JD0fiJtwNyI7zQ0co8Eb0KUbXvJfCH
         xMCQ==
X-Gm-Message-State: AOAM532jkEdEPbafsEIUHUTnB+UDc+kekQcO2B3R+mzjZDOrgerfe/ls
        8RjVe5SSkv2NzpXnAchBnmRUNwWxT+Y=
X-Google-Smtp-Source: ABdhPJyTxYq/mUzBkzLL5/5I8r2dfE0pJYkpYOVW9IVEB3IbwaMnHzesnz1YVJe3C+oDuBkayHO6iQ==
X-Received: by 2002:adf:ab43:: with SMTP id r3mr13767518wrc.585.1640012475306;
        Mon, 20 Dec 2021 07:01:15 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b13sm16263177wrh.32.2021.12.20.07.01.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Dec 2021 07:01:15 -0800 (PST)
Message-Id: <3e39c8172f5de572c7b67f381d51631623a41762.1640012469.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1099.git.1640012469.gitgitgadget@gmail.com>
References: <pull.1099.git.1640012469.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 20 Dec 2021 15:01:08 +0000
Subject: [PATCH 8/9] trace2: add counter events to perf and event target
 formats
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

Teach Trace2 "perf" and "event" formats to handle "counter" events
for global counters.  Update the API documentation accordingly.

In a future commit, global counters will be added to the Trace2 API
and it will emit these "counter" events at program exit.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 Documentation/technical/api-trace2.txt | 19 +++++++++++++++++++
 trace2/tr2_tgt.h                       | 14 ++++++++++++++
 trace2/tr2_tgt_event.c                 | 25 ++++++++++++++++++++++++-
 trace2/tr2_tgt_normal.c                |  1 +
 trace2/tr2_tgt_perf.c                  | 19 +++++++++++++++++++
 5 files changed, 77 insertions(+), 1 deletion(-)

diff --git a/Documentation/technical/api-trace2.txt b/Documentation/technical/api-trace2.txt
index 03a61332a2d..bb116dc85db 100644
--- a/Documentation/technical/api-trace2.txt
+++ b/Documentation/technical/api-trace2.txt
@@ -838,6 +838,25 @@ may exceed the "atexit" elapsed time of the program.
 Timer events may represent an individual thread or a summation across
 the entire program.  Summation events will have a unique thread name.
 
+`"counter"`::
+	This event is generated at the end of the program and contains
+	the value of a global counter.
++
+------------
+{
+	"event":"counter",
+	...
+	"name":"test",      # counter name
+	"value":42,         # value of the counter
+}
+------------
++
+A global counter can be incremented throughout the execution of the
+program.  It will be reported in a "counter" event just prior to exit.
++
+Counter events may represent an individual thread or a summation across
+the entire program.  Summation events will have a unique thread name.
+
 == Example Trace2 API Usage
 
 Here is a hypothetical usage of the Trace2 API showing the intended
diff --git a/trace2/tr2_tgt.h b/trace2/tr2_tgt.h
index 1f548eb4b93..33a2bb99199 100644
--- a/trace2/tr2_tgt.h
+++ b/trace2/tr2_tgt.h
@@ -120,6 +120,19 @@ typedef void(tr2_tgt_evt_timer_t)(uint64_t us_elapsed_absolute,
 				  uint64_t us_min_time,
 				  uint64_t us_max_time);
 
+/*
+ * Item counter event.
+ *
+ * This also does not take a (file,line) pair.
+ *
+ * The thread name is optional.
+ */
+typedef void(tr2_tgt_evt_counter_t)(uint64_t us_elapsed_absolute,
+				    const char *thread_name,
+				    const char *category,
+				    const char *counter_name,
+				    uint64_t value);
+
 /*
  * "vtable" for a TRACE2 target.  Use NULL if a target does not want
  * to emit that message.
@@ -157,6 +170,7 @@ struct tr2_tgt {
 	tr2_tgt_evt_data_json_fl_t              *pfn_data_json_fl;
 	tr2_tgt_evt_printf_va_fl_t              *pfn_printf_va_fl;
 	tr2_tgt_evt_timer_t                     *pfn_timer;
+	tr2_tgt_evt_counter_t                   *pfn_counter;
 };
 /* clang-format on */
 
diff --git a/trace2/tr2_tgt_event.c b/trace2/tr2_tgt_event.c
index 9b3905b920c..ca36d44dfd7 100644
--- a/trace2/tr2_tgt_event.c
+++ b/trace2/tr2_tgt_event.c
@@ -23,7 +23,7 @@ static struct tr2_dst tr2dst_event = { TR2_SYSENV_EVENT, 0, 0, 0, 0 };
  * Verison 1: original version
  * Version 2: added "too_many_files" event
  * Version 3: added "child_ready" event
- * Version 4: added "timer" event
+ * Version 4: added "timer" and "counter" events
  */
 #define TR2_EVENT_VERSION "4"
 
@@ -652,6 +652,28 @@ static void fn_timer(uint64_t us_elapsed_absolute,
 	jw_release(&jw);
 }
 
+static void fn_counter(uint64_t us_elapsed_absolute,
+		       const char *thread_name,
+		       const char *category,
+		       const char *counter_name,
+		       uint64_t value)
+{
+	const char *event_name = "counter";
+	struct json_writer jw = JSON_WRITER_INIT;
+	double t_abs = (double)us_elapsed_absolute / 1000000.0;
+
+	jw_object_begin(&jw, 0);
+	event_fmt_prepare(event_name, __FILE__, __LINE__, NULL, &jw, thread_name);
+	jw_object_double(&jw, "t_abs", 6, t_abs);
+	jw_object_string(&jw, "name", counter_name);
+	jw_object_intmax(&jw, "value", value);
+
+	jw_end(&jw);
+
+	tr2_dst_write_line(&tr2dst_event, &jw.json);
+	jw_release(&jw);
+}
+
 struct tr2_tgt tr2_tgt_event = {
 	&tr2dst_event,
 
@@ -684,4 +706,5 @@ struct tr2_tgt tr2_tgt_event = {
 	fn_data_json_fl,
 	NULL, /* printf */
 	fn_timer,
+	fn_counter,
 };
diff --git a/trace2/tr2_tgt_normal.c b/trace2/tr2_tgt_normal.c
index 23a7e78dcaa..1778232f6e9 100644
--- a/trace2/tr2_tgt_normal.c
+++ b/trace2/tr2_tgt_normal.c
@@ -356,4 +356,5 @@ struct tr2_tgt tr2_tgt_normal = {
 	NULL, /* data_json */
 	fn_printf_va_fl,
 	NULL, /* timer */
+	NULL, /* counter */
 };
diff --git a/trace2/tr2_tgt_perf.c b/trace2/tr2_tgt_perf.c
index 7597cb52ed5..eb4577ec40b 100644
--- a/trace2/tr2_tgt_perf.c
+++ b/trace2/tr2_tgt_perf.c
@@ -582,6 +582,24 @@ static void fn_timer(uint64_t us_elapsed_absolute,
 	strbuf_release(&buf_payload);
 }
 
+static void fn_counter(uint64_t us_elapsed_absolute,
+		       const char *thread_name,
+		       const char *category,
+		       const char *counter_name,
+		       uint64_t value)
+{
+	const char *event_name = "counter";
+	struct strbuf buf_payload = STRBUF_INIT;
+
+	strbuf_addf(&buf_payload, "name:%s", counter_name);
+	strbuf_addf(&buf_payload, " value:%"PRIu64, value);
+
+	perf_io_write_fl(__FILE__, __LINE__, event_name, NULL,
+			 &us_elapsed_absolute, NULL,
+			 category, &buf_payload, thread_name);
+	strbuf_release(&buf_payload);
+}
+
 struct tr2_tgt tr2_tgt_perf = {
 	&tr2dst_perf,
 
@@ -614,4 +632,5 @@ struct tr2_tgt tr2_tgt_perf = {
 	fn_data_json_fl,
 	fn_printf_va_fl,
 	fn_timer,
+	fn_counter,
 };
-- 
gitgitgadget

