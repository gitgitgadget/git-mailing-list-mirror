Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B44F4C433EF
	for <git@archiver.kernel.org>; Tue, 28 Dec 2021 19:37:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237201AbhL1Tg6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Dec 2021 14:36:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237189AbhL1Tgu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Dec 2021 14:36:50 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78415C061746
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 11:36:50 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id w20so31165142wra.9
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 11:36:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=1tgR+lkbjnipk/1V/6W39iDTeFiIJi4O4RDuvV39PEQ=;
        b=A09t9P007DiPosGiwL9FDKh845kohUHNU+Mh5XhQJWFZ5QrCkCBzp/aPaE2gCG/vVE
         iebuvdowJ3w7zGTQzMmNaRIRGjWkAhLueFhdL9jppKC6sAyNOd9UjRNZdp+hA4pkfNst
         k/BEejCgsiNy0w/0tSqmQiCLlToVmxE2OS9AuaqT+g9cPp0Ev1i5fv6lnoPBliCgkwpt
         HYcYFFPT9rzTT9xR/2RrpgjvLlhPE0tJlKj+OMcxgJBzGh2IHXNzvY0BH6D1+Os+guSR
         b0deGIwtsByeeTl12JhoxWx4l54rxn8x2YyZwIRArk5ne9/hJXsJe9VoRJZOK3VND8rr
         RziA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=1tgR+lkbjnipk/1V/6W39iDTeFiIJi4O4RDuvV39PEQ=;
        b=g3uZIsBCBjZbIHnQnY1g8XDnUf1J8pi480ONcLA8S3kP7CM0DiVfS+BgoNlFxLlyEb
         6ZiAt5sDw4l8AfTaqHO7ugWJ5WvSdSpYPM7A7RstFMIcO7BQfYmMAUoY6cuPTsK15SXV
         cbJYr3Q5vmKox18x2mhCQ+ku+ix+4sEWky7cnVg3tRzKF8yC6A2Z5oLQ0TqKLWIszVbh
         J6CkOywOlbGw0cWp2WpeJNAQjYddsQI08hpqBleOB9C/fN67lzdK8rv22PLcs7bFObzP
         ymWe6IKCmqR91kxoMvDri9I3N+kKWJAKjxZFcDetGFieoYaT2IE4Ce5C65+F8ie8Dqtd
         Zkgg==
X-Gm-Message-State: AOAM5335wpbuJ4JDGPH01ZYHhJuPuMQ4dmIi9O8q7TAjN3XKdidAF9CE
        p7Iee9tjiqmIbkXfuSzD8PpdEHHwweU=
X-Google-Smtp-Source: ABdhPJz00FCz7VEkt+XciTpgFY5bIdgfWufNJHOkiRJm/2CljZ7280MoRfowYoCqwi0g6kVcGNjkCQ==
X-Received: by 2002:a05:6000:1818:: with SMTP id m24mr7197716wrh.549.1640720208880;
        Tue, 28 Dec 2021 11:36:48 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r62sm18876717wmr.35.2021.12.28.11.36.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Dec 2021 11:36:48 -0800 (PST)
Message-Id: <0ef23190759710451bf912a38fbc420d4452800b.1640720202.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1099.v2.git.1640720202.gitgitgadget@gmail.com>
References: <pull.1099.git.1640012469.gitgitgadget@gmail.com>
        <pull.1099.v2.git.1640720202.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 28 Dec 2021 19:36:41 +0000
Subject: [PATCH v2 8/9] trace2: add counter events to perf and event target
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

Teach Trace2 "perf" and "event" formats to handle "counter" events
for global counters.  Update the API documentation accordingly.

In a future commit, global counters will be added to the Trace2 API
and it will emit these "counter" events at program exit.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 Documentation/technical/api-trace2.txt | 19 +++++++++++++++++++
 trace2/tr2_tgt.h                       | 14 ++++++++++++++
 trace2/tr2_tgt_event.c                 | 23 +++++++++++++++++++++++
 trace2/tr2_tgt_normal.c                |  1 +
 trace2/tr2_tgt_perf.c                  | 18 ++++++++++++++++++
 5 files changed, 75 insertions(+)

diff --git a/Documentation/technical/api-trace2.txt b/Documentation/technical/api-trace2.txt
index 616001bcbb0..bdba0f92280 100644
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
index a41f91d09b5..66f34b9258f 100644
--- a/trace2/tr2_tgt.h
+++ b/trace2/tr2_tgt.h
@@ -120,6 +120,19 @@ typedef void(tr2_tgt_evt_timer_t)(uint64_t us_elapsed_absolute,
 				  uint64_t ns_min_time,
 				  uint64_t ns_max_time);
 
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
index fe89e80bb1a..907bff80827 100644
--- a/trace2/tr2_tgt_event.c
+++ b/trace2/tr2_tgt_event.c
@@ -643,6 +643,28 @@ static void fn_timer(uint64_t us_elapsed_absolute,
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
 
@@ -675,4 +697,5 @@ struct tr2_tgt tr2_tgt_event = {
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
index c07ffad1a32..911cf6e6eab 100644
--- a/trace2/tr2_tgt_perf.c
+++ b/trace2/tr2_tgt_perf.c
@@ -581,6 +581,23 @@ static void fn_timer(uint64_t us_elapsed_absolute,
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
+	strbuf_addf(&buf_payload, "name:%s value:%"PRIu64, counter_name, value);
+
+	perf_io_write_fl(__FILE__, __LINE__, event_name, NULL,
+			 &us_elapsed_absolute, NULL,
+			 category, &buf_payload, thread_name);
+	strbuf_release(&buf_payload);
+}
+
 struct tr2_tgt tr2_tgt_perf = {
 	&tr2dst_perf,
 
@@ -613,4 +630,5 @@ struct tr2_tgt tr2_tgt_perf = {
 	fn_data_json_fl,
 	fn_printf_va_fl,
 	fn_timer,
+	fn_counter,
 };
-- 
gitgitgadget

