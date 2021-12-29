Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0022DC433EF
	for <git@archiver.kernel.org>; Wed, 29 Dec 2021 01:53:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238284AbhL2BxQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Dec 2021 20:53:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbhL2BxP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Dec 2021 20:53:15 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AF95C061574
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 17:53:15 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id j6so80274227edw.12
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 17:53:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=CRKXQ9pS/DESdKSkMUn1ksCFiUQMSkoiQboH0I6rrwM=;
        b=A1MKZiMO6r4kcy1Wsxc5BTEiv6I5y0oMBeten0KNGxdwXrAOvYBV+yYVz5rWxEY0WS
         CZ4Kkv234P+fLaV+kLyBeqgNMaIO3bG3Io/Sr3MK3gfoU6VQq2p4ZxtLAhY4IpMy8eK/
         Bw7PrtZilDWcXgf+4CxV5NxAanP8rz4y8GJgtzEr0eBLg5gLUJQQ1DdgkeBpcn0A0uLa
         RhUWdVt9onrQy7Y0AH1tZco7QfIWeULX63ycLyOPjfi1dyiDiBp3jVH7zu9Unf6CwS2a
         aOF9a5YyxaAxbATAP2JaKDJJU4iftEzSgc6ILF5aeBz1DhUSAE+LavogyoUXvD5mE+dc
         m7ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=CRKXQ9pS/DESdKSkMUn1ksCFiUQMSkoiQboH0I6rrwM=;
        b=Q9I2WxmNbVnquWCW0UueB+DZbNNRFqheOv68v1Pm1DEH9rn+CTBQcqOsxn0whv6qjM
         mKdN96xdQE4d1hVbi4yIuUL/FGZHrrjP4bek5vbyMRGp4tO/E00DwOevcp4rbC0qszi3
         y+rQ8ZzU+I3CZidv7v/UBTjHrpsm6lm6R+IUizpEMIf3y1ipST44JLejiT31ZtCYFTjw
         g8Qpyv6cKOoUKyJ04VC20cMO3HezRwOzsYR8u9CCcJubUlmTlY+FJblL2DD+uiYiUuhc
         T1ydAo2+WTkzJV4tnim2HZ9dx16SJdVE1uH2iADu6FgtTpUT3Q1aVNscr2u2nrpwY0IS
         z0hw==
X-Gm-Message-State: AOAM531kGYMIlA+DXzww6iMkM638tMXK7E00kwKdNwEvmMZIi2wuuYFM
        U30lTPbTVZDSW3Gcp3EFQEdkuXyjHqxprqJB
X-Google-Smtp-Source: ABdhPJyj3QzweFCgyH7xMpe6k1Jr8WonyTYyS2UraOXbaVxCocRNn6WepDDbkGQoWvFrY2VOAXCC8g==
X-Received: by 2002:a05:6402:350b:: with SMTP id b11mr23594071edd.228.1640742793338;
        Tue, 28 Dec 2021 17:53:13 -0800 (PST)
Received: from gmgdl (157-157-127-103.dsl.dynamic.simnet.is. [157.157.127.103])
        by smtp.gmail.com with ESMTPSA id ec4sm7962295edb.79.2021.12.28.17.53.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Dec 2021 17:53:12 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1n2O9Q-000IHR-8C;
        Wed, 29 Dec 2021 02:53:12 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <stolee@gmail.com>,
        Matheus Tavares <matheus.bernardino@usp.br>,
        Johannes Sixt <j6t@kdbg.org>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v2 5/9] trace2: add thread-name override to perf target
Date:   Wed, 29 Dec 2021 02:48:33 +0100
References: <pull.1099.git.1640012469.gitgitgadget@gmail.com>
 <pull.1099.v2.git.1640720202.gitgitgadget@gmail.com>
 <82c445b75f1002bcfa0a770bd47038a747d98970.1640720202.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <82c445b75f1002bcfa0a770bd47038a747d98970.1640720202.git.gitgitgadget@gmail.com>
Message-ID: <211229.86ilv8gos7.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Dec 28 2021, Jeff Hostetler via GitGitGadget wrote:

> From: Jeff Hostetler <jeffhost@microsoft.com>
>
> Teach the message formatter in the Trace2 perf target to accept an
> optional thread name argument.  This will override the thread name
> inherited from the thread local storage data block.
>
> This will be used in a future commit for global events that should
> not be tied to a particular thread, such as a global stopwatch timer.

We already have a "ctx", and that "ctx" has a "thread_name", but here
and in the preceding commit we're adding a "thread_name" to every caller
of these functions in case we'd like to override it.

Wouldn't it make more sense to just pass a "ctx" to these functions? One
of them already takes it, here's an (obviously incomplete) fixup on top
of your series to make the one that doesn't take a "ctx", and for the
only non-NULL users of "thread_name" to just use a trivial helper to
pass in a "ctx" with a new "thread_name", then to swap it back.

It would make for a smaller diffstat for this already large series, or
we could do exactly what we're doing now, but avoid the churn of
adjusting every caller by introducing a new sister function for those
who want this parameter to be non-NULL.

(The below patch is "broken" in that __FILE__ and __LINE__ need to be
passed in as parameters, but this is just a trivial change for
show/commentary)

diff --git a/trace2/tr2_tgt_event.c b/trace2/tr2_tgt_event.c
index b9eb2cdb77a..7aaec83dff7 100644
--- a/trace2/tr2_tgt_event.c
+++ b/trace2/tr2_tgt_event.c
@@ -82,16 +82,15 @@ static void fn_term(void)
 static void event_fmt_prepare(const char *event_name, const char *file,
 			      int line, const struct repository *repo,
 			      struct json_writer *jw,
-			      const char *thread_name_override)
+			      struct tr2tls_thread_ctx *ctx)
 {
 	struct tr2_tbuf tb_now;
+	if (!ctx)
+		ctx = tr2tls_get_self();
 
 	jw_object_string(jw, "event", event_name);
 	jw_object_string(jw, "sid", tr2_sid_get());
-	jw_object_string(jw, "thread",
-			 ((thread_name_override && *thread_name_override)
-			  ? thread_name_override
-			  : tr2tls_get_self()->thread_name));
+	jw_object_string(jw, "thread", ctx->thread_name);
 
 	/*
 	 * In brief mode, only emit <time> on these 2 event types.
@@ -111,6 +110,20 @@ static void event_fmt_prepare(const char *event_name, const char *file,
 		jw_object_intmax(jw, "repo", repo->trace2_repo_id);
 }
 
+static void event_fmt_prepare_tn(const char *event_name, const char *file,
+				 int line, const struct repository *repo,
+				 struct json_writer *jw,
+				 const char *thread_name)
+{
+	struct tr2tls_thread_ctx *ctx = tr2tls_get_self();
+	const char *tmp;
+
+	tmp = ctx->thread_name;
+	ctx->thread_name = thread_name;
+	event_fmt_prepare(event_name, __FILE__, __LINE__, NULL, jw, ctx);
+	ctx->thread_name = tmp;
+}
+
 static void fn_too_many_files_fl(const char *file, int line)
 {
 	const char *event_name = "too_many_files";
@@ -629,7 +642,7 @@ static void fn_timer(uint64_t us_elapsed_absolute,
 	double t_abs = (double)us_elapsed_absolute / 1000000.0;
 
 	jw_object_begin(&jw, 0);
-	event_fmt_prepare(event_name, __FILE__, __LINE__, NULL, &jw, thread_name);
+	event_fmt_prepare_tn(event_name, __FILE__, __LINE__, NULL, &jw, thread_name);
 	jw_object_double(&jw, "t_abs", 6, t_abs);
 	jw_object_string(&jw, "name", timer_name);
 	jw_object_intmax(&jw, "count", interval_count);
@@ -654,7 +667,7 @@ static void fn_counter(uint64_t us_elapsed_absolute,
 	double t_abs = (double)us_elapsed_absolute / 1000000.0;
 
 	jw_object_begin(&jw, 0);
-	event_fmt_prepare(event_name, __FILE__, __LINE__, NULL, &jw, thread_name);
+	event_fmt_prepare_tn(event_name, __FILE__, __LINE__, NULL, &jw, thread_name);
 	jw_object_double(&jw, "t_abs", 6, t_abs);
 	jw_object_string(&jw, "name", counter_name);
 	jw_object_intmax(&jw, "value", value);
