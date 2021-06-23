Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33179C48BC2
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 17:48:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1859761003
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 17:48:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbhFWRu5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Jun 2021 13:50:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbhFWRuw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jun 2021 13:50:52 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AC1EC061574
        for <git@vger.kernel.org>; Wed, 23 Jun 2021 10:48:32 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id f15so3570837wro.8
        for <git@vger.kernel.org>; Wed, 23 Jun 2021 10:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fsov7IjXHhnkilOlMaRcyntUIsQIZUGyIAAo2Mqrd9Y=;
        b=e6ER9NseWhHmsnPDj0JObMNWpvZAkLPaMfivGjQKNjuEoBB/MkoWPoyhOlPpIrwPhN
         41xhwh7iiB0+svcFcUTqVYZiPD2YGK/behNB1vCqlrJN7ZXBULo3Wj1QW1SLTcreamJF
         8hGh0EBpHY6hcFX26KJd+0gNdRYjRxHZG1dYf9BBBhMZLvcBuxY61IYwpCTg4rezb9gt
         E/jvZetEKdVe2ZKj1zZ3HQzfud7xJFptcV2JMWB1X93QPtFz1C1Ya58EV4Eky7PZNTWZ
         KUmqwW9K8sp5XSieRbqIhwitNyyJrmENbPn44LSSWHSURYQQ2zjQ7z7Gg0z7hKXX/Bm8
         SZWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fsov7IjXHhnkilOlMaRcyntUIsQIZUGyIAAo2Mqrd9Y=;
        b=uAXeD0ZrHpm/FaNvFeuDKeYisUfYyZeW4Ch+4FY2D3oXh4L3/X9sxUTObvQHi03vTH
         905qXLX81grvNJV1t2czxMsmEI5N8LDY0vbXOCzYGeF9SBsodA9SApyFnWKJpx3U8Xzf
         NU1a1/MAdYN/2WmDduodxM7d93bZKhQKTZ2A4UV7yqrz61qq63eiVSWKHRZE8JZasnmB
         f2xOjdN7vc1IOQ3MwPj1gA56XH1WcxbPAAshSITq/cu2N719me1X35otwvQ13jAP4Lbo
         xu+bSR3J4BMIIy2MjxDfOx1sQgsHIxrR4NBqu4xqD+40IQjvCfe3jSuZcxv6zsrjQ+M7
         QR1w==
X-Gm-Message-State: AOAM530lCF+JTxXaSTDNKePQx9x0YFD95UndyAGd6qaUI6DKcprr862c
        gFwFxrurHQWXtBZNVPpBeJNv7NA3fOEudw==
X-Google-Smtp-Source: ABdhPJwWWsSm3iuotPH8YQ9iRDdc6+vrGUa2DKFwzWbgNi0tAaCNmY1a7qwwzJPdzQmuMkvs7SXHBA==
X-Received: by 2002:a5d:680c:: with SMTP id w12mr1462186wru.142.1624470510706;
        Wed, 23 Jun 2021 10:48:30 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id x25sm6678281wmj.23.2021.06.23.10.48.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 10:48:30 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 02/25] progress.c tests: make start/stop verbs on stdin
Date:   Wed, 23 Jun 2021 19:48:02 +0200
Message-Id: <patch-02.25-75e949e21d7-20210623T155626Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.599.g3967b4fa4ac
In-Reply-To: <cover-00.25-00000000000-20210623T155626Z-avarab@gmail.com>
References: <YNKWsTsQgB2Ijxu7@nand.local> <cover-00.25-00000000000-20210623T155626Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the usage of the "test-tool progress" introduced in
2bb74b53a49 (Test the progress display, 2019-09-16) to take command
like "start" and "stop" on stdin, instead of running them implicitly.

This makes for tests that are easier to read, since the recipe will
mirror the API usage, and allows for easily testing invalid usage that
would yield (or should yield) a BUG(), e.g. providing two "start"
calls in a row. A subsequent commit will add such stress tests.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/helper/test-progress.c    | 45 ++++++++++++++++++++--------
 t/t0500-progress-display.sh | 59 +++++++++++++++++++++++--------------
 2 files changed, 69 insertions(+), 35 deletions(-)

diff --git a/t/helper/test-progress.c b/t/helper/test-progress.c
index 5d05cbe7894..eb925d591e1 100644
--- a/t/helper/test-progress.c
+++ b/t/helper/test-progress.c
@@ -3,6 +3,9 @@
  *
  * Reads instructions from standard input, one instruction per line:
  *
+ *   "start[ <total>[ <title>]]" - Call start_progress(title, total),
+ *                                 when "start" use a title of
+ *                                 "Working hard" with a total of 0.
  *   "progress <items>" - Call display_progress() with the given item count
  *                        as parameter.
  *   "throughput <bytes> <millis> - Call display_throughput() with the given
@@ -10,6 +13,7 @@
  *                                  specify the time elapsed since the
  *                                  start_progress() call.
  *   "update" - Set the 'progress_update' flag.
+ *   "stop" - Call stop_progress().
  *
  * See 't0500-progress-display.sh' for examples.
  */
@@ -22,31 +26,42 @@
 
 int cmd__progress(int argc, const char **argv)
 {
-	int total = 0;
-	const char *title;
+	const char *default_title = "Working hard";
+	char *detached_title = NULL;
 	struct strbuf line = STRBUF_INIT;
-	struct progress *progress;
+	struct progress *progress = NULL;
 
 	const char *usage[] = {
-		"test-tool progress [--total=<n>] <progress-title>",
+		"test-tool progress <stdin",
 		NULL
 	};
 	struct option options[] = {
-		OPT_INTEGER(0, "total", &total, "total number of items"),
 		OPT_END(),
 	};
 
 	argc = parse_options(argc, argv, NULL, options, usage, 0);
-	if (argc != 1)
-		die("need a title for the progress output");
-	title = argv[0];
+	if (argc)
+		usage_with_options(usage, options);
 
 	progress_testing = 1;
-	progress = start_progress(title, total);
 	while (strbuf_getline(&line, stdin) != EOF) {
 		char *end;
 
-		if (skip_prefix(line.buf, "progress ", (const char **) &end)) {
+		if (!strcmp(line.buf, "start")) {
+			progress = start_progress(default_title, 0);
+		} else if (skip_prefix(line.buf, "start ", (const char **) &end)) {
+			uint64_t total = strtoull(end, &end, 10);
+			if (*end == '\0') {
+				progress = start_progress(default_title, total);
+			} else if (*end == ' ') {
+				if (detached_title)
+					free(detached_title);
+				detached_title = strbuf_detach(&line, NULL);
+				progress = start_progress(end + 1, total);
+			} else {
+				die("invalid input: '%s'\n", line.buf);
+			}
+		} else if (skip_prefix(line.buf, "progress ", (const char **) &end)) {
 			uint64_t item_count = strtoull(end, &end, 10);
 			if (*end != '\0')
 				die("invalid input: '%s'\n", line.buf);
@@ -63,12 +78,16 @@ int cmd__progress(int argc, const char **argv)
 				die("invalid input: '%s'\n", line.buf);
 			progress_test_ns = test_ms * 1000 * 1000;
 			display_throughput(progress, byte_count);
-		} else if (!strcmp(line.buf, "update"))
+		} else if (!strcmp(line.buf, "update")) {
 			progress_test_force_update();
-		else
+		} else if (!strcmp(line.buf, "stop")) {
+			stop_progress(&progress);
+		} else {
 			die("invalid input: '%s'\n", line.buf);
+		}
 	}
-	stop_progress(&progress);
+	if (detached_title)
+		free(detached_title);
 
 	return 0;
 }
diff --git a/t/t0500-progress-display.sh b/t/t0500-progress-display.sh
index 66c092a0fe3..ce6c3434673 100755
--- a/t/t0500-progress-display.sh
+++ b/t/t0500-progress-display.sh
@@ -22,6 +22,7 @@ test_expect_success 'simple progress display' '
 	EOF
 
 	cat >in <<-\EOF &&
+	start 0
 	update
 	progress 1
 	update
@@ -30,8 +31,9 @@ test_expect_success 'simple progress display' '
 	progress 4
 	update
 	progress 5
+	stop
 	EOF
-	test-tool progress "Working hard" <in 2>stderr &&
+	test-tool progress <in 2>stderr &&
 
 	show_cr <stderr >out &&
 	test_cmp expect out
@@ -46,11 +48,13 @@ test_expect_success 'progress display with total' '
 	EOF
 
 	cat >in <<-\EOF &&
+	start 3
 	progress 1
 	progress 2
 	progress 3
+	stop
 	EOF
-	test-tool progress --total=3 "Working hard" <in 2>stderr &&
+	test-tool progress <in 2>stderr &&
 
 	show_cr <stderr >out &&
 	test_cmp expect out
@@ -67,14 +71,14 @@ Working hard.......2.........3.........4.........5.........6:
 EOF
 
 	cat >in <<-\EOF &&
+	start 100000 Working hard.......2.........3.........4.........5.........6
 	progress 100
 	progress 1000
 	progress 10000
 	progress 100000
+	stop
 	EOF
-	test-tool progress --total=100000 \
-		"Working hard.......2.........3.........4.........5.........6" \
-		<in 2>stderr &&
+	test-tool progress <in 2>stderr &&
 
 	show_cr <stderr >out &&
 	test_cmp expect out
@@ -93,16 +97,15 @@ Working hard.......2.........3.........4.........5.........6:
 EOF
 
 	cat >in <<-\EOF &&
-	update
+	start 100000 Working hard.......2.........3.........4.........5.........6
 	progress 1
 	update
 	progress 2
 	progress 10000
 	progress 100000
+	stop
 	EOF
-	test-tool progress --total=100000 \
-		"Working hard.......2.........3.........4.........5.........6" \
-		<in 2>stderr &&
+	test-tool progress <in 2>stderr &&
 
 	show_cr <stderr >out &&
 	test_cmp expect out
@@ -121,14 +124,14 @@ Working hard.......2.........3.........4.........5.........6:
 EOF
 
 	cat >in <<-\EOF &&
+	start 100000 Working hard.......2.........3.........4.........5.........6
 	progress 25000
 	progress 50000
 	progress 75000
 	progress 100000
+	stop
 	EOF
-	test-tool progress --total=100000 \
-		"Working hard.......2.........3.........4.........5.........6" \
-		<in 2>stderr &&
+	test-tool progress <in 2>stderr &&
 
 	show_cr <stderr >out &&
 	test_cmp expect out
@@ -145,14 +148,14 @@ Working hard.......2.........3.........4.........5.........6.........7.........:
 EOF
 
 	cat >in <<-\EOF &&
+	start 100000 Working hard.......2.........3.........4.........5.........6.........7.........
 	progress 25000
 	progress 50000
 	progress 75000
 	progress 100000
+	stop
 	EOF
-	test-tool progress --total=100000 \
-		"Working hard.......2.........3.........4.........5.........6.........7........." \
-		<in 2>stderr &&
+	test-tool progress <in 2>stderr &&
 
 	show_cr <stderr >out &&
 	test_cmp expect out
@@ -169,12 +172,14 @@ test_expect_success 'progress shortens - crazy caller' '
 	EOF
 
 	cat >in <<-\EOF &&
+	start 1000
 	progress 100
 	progress 200
 	progress 1
 	progress 1000
+	stop
 	EOF
-	test-tool progress --total=1000 "Working hard" <in 2>stderr &&
+	test-tool progress <in 2>stderr &&
 
 	show_cr <stderr >out &&
 	test_cmp expect out
@@ -190,6 +195,7 @@ test_expect_success 'progress display with throughput' '
 	EOF
 
 	cat >in <<-\EOF &&
+	start
 	throughput 102400 1000
 	update
 	progress 10
@@ -202,8 +208,9 @@ test_expect_success 'progress display with throughput' '
 	throughput 409600 4000
 	update
 	progress 40
+	stop
 	EOF
-	test-tool progress "Working hard" <in 2>stderr &&
+	test-tool progress <in 2>stderr &&
 
 	show_cr <stderr >out &&
 	test_cmp expect out
@@ -219,6 +226,7 @@ test_expect_success 'progress display with throughput and total' '
 	EOF
 
 	cat >in <<-\EOF &&
+	start 40
 	throughput 102400 1000
 	progress 10
 	throughput 204800 2000
@@ -227,8 +235,9 @@ test_expect_success 'progress display with throughput and total' '
 	progress 30
 	throughput 409600 4000
 	progress 40
+	stop
 	EOF
-	test-tool progress --total=40 "Working hard" <in 2>stderr &&
+	test-tool progress <in 2>stderr &&
 
 	show_cr <stderr >out &&
 	test_cmp expect out
@@ -244,6 +253,7 @@ test_expect_success 'cover up after throughput shortens' '
 	EOF
 
 	cat >in <<-\EOF &&
+	start
 	throughput 409600 1000
 	update
 	progress 1
@@ -256,8 +266,9 @@ test_expect_success 'cover up after throughput shortens' '
 	throughput 1638400 4000
 	update
 	progress 4
+	stop
 	EOF
-	test-tool progress "Working hard" <in 2>stderr &&
+	test-tool progress <in 2>stderr &&
 
 	show_cr <stderr >out &&
 	test_cmp expect out
@@ -272,6 +283,7 @@ test_expect_success 'cover up after throughput shortens a lot' '
 	EOF
 
 	cat >in <<-\EOF &&
+	start
 	throughput 1 1000
 	update
 	progress 1
@@ -281,8 +293,9 @@ test_expect_success 'cover up after throughput shortens a lot' '
 	throughput 3145728 3000
 	update
 	progress 3
+	stop
 	EOF
-	test-tool progress "Working hard" <in 2>stderr &&
+	test-tool progress <in 2>stderr &&
 
 	show_cr <stderr >out &&
 	test_cmp expect out
@@ -290,6 +303,7 @@ test_expect_success 'cover up after throughput shortens a lot' '
 
 test_expect_success 'progress generates traces' '
 	cat >in <<-\EOF &&
+	start 40
 	throughput 102400 1000
 	update
 	progress 10
@@ -302,10 +316,11 @@ test_expect_success 'progress generates traces' '
 	throughput 409600 4000
 	update
 	progress 40
+	stop
 	EOF
 
-	GIT_TRACE2_EVENT="$(pwd)/trace.event" test-tool progress --total=40 \
-		"Working hard" <in 2>stderr &&
+	GIT_TRACE2_EVENT="$(pwd)/trace.event" test-tool progress \
+		<in 2>stderr &&
 
 	# t0212/parse_events.perl intentionally omits regions and data.
 	test_region progress "Working hard" trace.event &&
-- 
2.32.0.599.g3967b4fa4ac

