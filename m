Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E47F1FA373D
	for <git@archiver.kernel.org>; Mon, 24 Oct 2022 23:06:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbiJXXGn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Oct 2022 19:06:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231503AbiJXXGI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Oct 2022 19:06:08 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 985891118
        for <git@vger.kernel.org>; Mon, 24 Oct 2022 14:27:18 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E3CCF1B6FC7;
        Mon, 24 Oct 2022 16:31:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=n/4M7q6MsIPSqT1u0UegsFZ3AyYguY+N/g6x6t
        1kWOU=; b=ltBvVxEdch0RZSxsnYXsmks6E059AGlxLJJXn8hS5uY+2DoWs137OO
        b6gu+xQmwi/pQ8uEMt1hoEereYko28T0T/TywlvG9Dey5nv9CtuU8varAveX/sVR
        YqRt6Pz9UpIIT+MxpJhcFyOaWHGedlgdtyZcMCRPaLMNyC9p276L0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C472A1B6FC6;
        Mon, 24 Oct 2022 16:31:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id CC2651B6FC3;
        Mon, 24 Oct 2022 16:31:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v4 1/8] trace2: use size_t alloc,nr_open_regions in
 tr2tls_thread_ctx
References: <pull.1373.v3.git.1666290489.gitgitgadget@gmail.com>
        <pull.1373.v4.git.1666618868.gitgitgadget@gmail.com>
        <6e7e4f3187e2fbbbb54bb1cf5793bf6e981a5a94.1666618868.git.gitgitgadget@gmail.com>
Date:   Mon, 24 Oct 2022 13:31:19 -0700
In-Reply-To: <6e7e4f3187e2fbbbb54bb1cf5793bf6e981a5a94.1666618868.git.gitgitgadget@gmail.com>
        (Jeff Hostetler via GitGitGadget's message of "Mon, 24 Oct 2022
        13:41:00 +0000")
Message-ID: <xmqqeduxrmjs.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D1F0258C-53DA-11ED-B3D3-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As I do not see a cover letter for this series, here is the summary
of the change since the previous round that has been in 'seen'.

I didn't see anything questionable in these.

Thanks, will queue.

 trace2/tr2_tgt.h        | 2 +-
 trace2/tr2_tgt_event.c  | 6 +++---
 trace2/tr2_tgt_normal.c | 6 +++---
 trace2/tr2_tgt_perf.c   | 6 +++---
 trace2/tr2_tls.h        | 2 +-
 5 files changed, 11 insertions(+), 11 deletions(-)

diff --git c/trace2/tr2_tgt.h w/trace2/tr2_tgt.h
index 95f4c75472..bf8745c4f0 100644
--- c/trace2/tr2_tgt.h
+++ w/trace2/tr2_tgt.h
@@ -9,7 +9,7 @@ struct tr2_timer;
 struct tr2_counter_metadata;
 struct tr2_counter;
 
-#define NS_PER_SEC_D ((double)1000*1000*1000)
+#define NS_TO_SEC(ns) ((double)(ns) / 1.0e9)
 
 /*
  * Function prototypes for a TRACE2 "target" vtable.
diff --git c/trace2/tr2_tgt_event.c w/trace2/tr2_tgt_event.c
index 981863a660..16f6332755 100644
--- c/trace2/tr2_tgt_event.c
+++ w/trace2/tr2_tgt_event.c
@@ -624,9 +624,9 @@ static void fn_timer(const struct tr2_timer_metadata *meta,
 {
 	const char *event_name = is_final_data ? "timer" : "th_timer";
 	struct json_writer jw = JSON_WRITER_INIT;
-	double t_total = ((double)timer->total_ns) / NS_PER_SEC_D;
-	double t_min = ((double)timer->min_ns) / NS_PER_SEC_D;
-	double t_max = ((double)timer->max_ns) / NS_PER_SEC_D;
+	double t_total = NS_TO_SEC(timer->total_ns);
+	double t_min = NS_TO_SEC(timer->min_ns);
+	double t_max = NS_TO_SEC(timer->max_ns);
 
 	jw_object_begin(&jw, 0);
 	event_fmt_prepare(event_name, __FILE__, __LINE__, NULL, &jw);
diff --git c/trace2/tr2_tgt_normal.c w/trace2/tr2_tgt_normal.c
index def18674e8..fbbef68dfc 100644
--- c/trace2/tr2_tgt_normal.c
+++ w/trace2/tr2_tgt_normal.c
@@ -336,9 +336,9 @@ static void fn_timer(const struct tr2_timer_metadata *meta,
 {
 	const char *event_name = is_final_data ? "timer" : "th_timer";
 	struct strbuf buf_payload = STRBUF_INIT;
-	double t_total = ((double)timer->total_ns) / NS_PER_SEC_D;
-	double t_min = ((double)timer->min_ns) / NS_PER_SEC_D;
-	double t_max = ((double)timer->max_ns) / NS_PER_SEC_D;
+	double t_total = NS_TO_SEC(timer->total_ns);
+	double t_min = NS_TO_SEC(timer->min_ns);
+	double t_max = NS_TO_SEC(timer->max_ns);
 
 	strbuf_addf(&buf_payload, ("%s %s/%s"
 				   " intervals:%"PRIu64
diff --git c/trace2/tr2_tgt_perf.c w/trace2/tr2_tgt_perf.c
index db94b2ef47..adae803263 100644
--- c/trace2/tr2_tgt_perf.c
+++ w/trace2/tr2_tgt_perf.c
@@ -562,9 +562,9 @@ static void fn_timer(const struct tr2_timer_metadata *meta,
 {
 	const char *event_name = is_final_data ? "timer" : "th_timer";
 	struct strbuf buf_payload = STRBUF_INIT;
-	double t_total = ((double)timer->total_ns) / NS_PER_SEC_D;
-	double t_min = ((double)timer->min_ns) / NS_PER_SEC_D;
-	double t_max = ((double)timer->max_ns) / NS_PER_SEC_D;
+	double t_total = NS_TO_SEC(timer->total_ns);
+	double t_min = NS_TO_SEC(timer->min_ns);
+	double t_max = NS_TO_SEC(timer->max_ns);
 
 	strbuf_addf(&buf_payload, ("name:%s"
 				   " intervals:%"PRIu64
diff --git c/trace2/tr2_tls.h w/trace2/tr2_tls.h
index 289b62d072..f9049805d4 100644
--- c/trace2/tr2_tls.h
+++ w/trace2/tr2_tls.h
@@ -38,7 +38,7 @@ struct tr2tls_thread_ctx {
  * Subsequent threads are given a non-zero thread_id and a thread_name
  * constructed from the id and a thread base name (which is usually just
  * the name of the thread-proc function).  For example:
- *     { .thread_id=10, .thread_name="th10fsm-listen" }
+ *     { .thread_id=10, .thread_name="th10:fsm-listen" }
  * This helps to identify and distinguish messages from concurrent threads.
  * The ctx.thread_name field is truncated if necessary to help with column
  * alignment in printf-style messages.
