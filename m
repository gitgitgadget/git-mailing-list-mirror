Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA9FDC433FE
	for <git@archiver.kernel.org>; Mon, 25 Oct 2021 11:25:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D584560F9D
	for <git@archiver.kernel.org>; Mon, 25 Oct 2021 11:25:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233110AbhJYL1i (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Oct 2021 07:27:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233089AbhJYL1g (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Oct 2021 07:27:36 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F029DC061745
        for <git@vger.kernel.org>; Mon, 25 Oct 2021 04:25:13 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id e4so12214743wrc.7
        for <git@vger.kernel.org>; Mon, 25 Oct 2021 04:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ExLol0ckdF5sciF5S24HHMxBQPBbMshO7V/WDmjRjgI=;
        b=Rvs1IhBGOwLpRIIEEe8VSEJ6shGUQHGzsx1dhW8C+HF67q18FjpAjAE+beWjevVvY9
         gV6rtyYgBajpY7FjRzKqmQ2ZaXbF2FadIxSumnGZRSpyByNIC0dRpDyzv6U6AoZq4vmy
         cRVegLoT7YVYhm5i/8OfN/ir4FDhxbMvd0ygrRXVbn3xtC3d9C9Sxl2j0rZZLC/3Nq9/
         4OjGseYgrd5n11OGeFVGS8TWX3fihWt9dI+yGS7L+tInJEgYbhNHHyl2wIZtl5adjzok
         53/ut/2d0F3R82Fw8XGSmihIV8dUChhScdzVDcx4+gPLhlXo5Ivpkqi9QAPTEX3uQbPE
         7rbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ExLol0ckdF5sciF5S24HHMxBQPBbMshO7V/WDmjRjgI=;
        b=CiRbDD6s/9agfZ44xl8mcCzvnK4tahuJR3VqNyJqOFvNkVBz+FbGH83qsecpNU6S+W
         fUvVAzohEd3P0MSELf+dEK101s/o0NJ8TJPwaKtl8VBBN9Pb/07IfaOCRZ3vG/x3eGtX
         Axsu/rlq6q02DAHZGPT8cjOjpGZSHXUaXKIForhv3NccIkfrnsilVjLRWhpO3138Edif
         6aJxp3oIHRXpMoNIc3iIP0X3+Rv80SGO1TX7JzGCVBiO9oaN2vtDzPnVwpzG5hgh3jxx
         BxUw/G7vtlWfDmxkDDiudIBA7ngzBx4COcRAu5kfEZOZX39XUMsdafw3Mj3P6ZnqDuQh
         ITow==
X-Gm-Message-State: AOAM5332DWKZnMY2Zp6m00TESswE2KCVqlHZ9dlR4jnPDoWJY6eVSs4X
        AchpT6Hdgu5o+R10vobt5+t23aQlbPQ+xw==
X-Google-Smtp-Source: ABdhPJzRN8ccKtAVQ6Yiu0xVY5YavIIR+1AMGzvINMDeA2u6nWpgyHEFOtgvTKk9JDGXmEhI7Y1i/Q==
X-Received: by 2002:a5d:6484:: with SMTP id o4mr22695832wri.337.1635161112307;
        Mon, 25 Oct 2021 04:25:12 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l2sm19021993wmi.1.2021.10.25.04.25.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 04:25:11 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Emily Shaffer <emilyshaffer@google.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 3/8] progress.c tests: make start/stop commands on stdin
Date:   Mon, 25 Oct 2021 13:25:02 +0200
Message-Id: <patch-v4-3.8-1c5f9bdfe6d-20211025T111915Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1510.ge5c82eefb93
In-Reply-To: <cover-v4-0.8-00000000000-20211025T111915Z-avarab@gmail.com>
References: <cover-v3-00.10-00000000000-20211013T222329Z-avarab@gmail.com> <cover-v4-0.8-00000000000-20211025T111915Z-avarab@gmail.com>
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
calls in a row. A subsequent commit will add such tests.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/helper/test-progress.c    | 46 ++++++++++++++++++++++-------
 t/t0500-progress-display.sh | 58 +++++++++++++++++++++++--------------
 2 files changed, 72 insertions(+), 32 deletions(-)

diff --git a/t/helper/test-progress.c b/t/helper/test-progress.c
index 50fd3be3dad..1435c28e950 100644
--- a/t/helper/test-progress.c
+++ b/t/helper/test-progress.c
@@ -3,6 +3,9 @@
  *
  * Reads instructions from standard input, one instruction per line:
  *
+ *   "start <total>[ <title>]" - Call start_progress(title, total),
+ *                               Uses the default title of "Working hard"
+ *                               if the " <title>" is omitted.
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
@@ -19,34 +23,52 @@
 #include "parse-options.h"
 #include "progress.h"
 #include "strbuf.h"
+#include "string-list.h"
+
+/*
+ * We can't use "end + 1" as an argument to start_progress() below, it
+ * doesn't xstrdup() its "title" argument. We need to hold onto a
+ * valid "char *" for it until the end.
+ */
+static char *dup_title(struct string_list *titles, const char *title)
+{
+	return string_list_insert(titles, title)->string;
+}
 
 int cmd__progress(int argc, const char **argv)
 {
-	int total = 0;
-	const char *title;
+	const char *const default_title = "Working hard";
+	struct string_list titles = STRING_LIST_INIT_DUP;
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
+		if (skip_prefix(line.buf, "start ", (const char **) &end)) {
+			uint64_t total = strtoull(end, &end, 10);
+			if (*end == '\0')
+				progress = start_progress(default_title, total);
+			else if (*end == ' ')
+				progress = start_progress(dup_title(&titles,
+								    end + 1),
+							  total);
+			else
+				die("invalid input: '%s'\n", line.buf);
+		} else if (skip_prefix(line.buf, "progress ", (const char **) &end)) {
 			uint64_t item_count = strtoull(end, &end, 10);
 			if (*end != '\0')
 				die("invalid input: '%s'\n", line.buf);
@@ -65,12 +87,14 @@ int cmd__progress(int argc, const char **argv)
 			display_throughput(progress, byte_count);
 		} else if (!strcmp(line.buf, "update")) {
 			progress_test_force_update();
+		} else if (!strcmp(line.buf, "stop")) {
+			stop_progress(&progress);
 		} else {
 			die("invalid input: '%s'\n", line.buf);
 		}
 	}
-	stop_progress(&progress);
 	strbuf_release(&line);
+	string_list_clear(&titles, 0);
 
 	return 0;
 }
diff --git a/t/t0500-progress-display.sh b/t/t0500-progress-display.sh
index f37cf2eb9c9..27ab4218b01 100755
--- a/t/t0500-progress-display.sh
+++ b/t/t0500-progress-display.sh
@@ -18,6 +18,7 @@ test_expect_success 'simple progress display' '
 	EOF
 
 	cat >in <<-\EOF &&
+	start 0
 	update
 	progress 1
 	update
@@ -26,8 +27,9 @@ test_expect_success 'simple progress display' '
 	progress 4
 	update
 	progress 5
+	stop
 	EOF
-	test-tool progress "Working hard" <in 2>stderr &&
+	test-tool progress <in 2>stderr &&
 
 	show_cr <stderr >out &&
 	test_cmp expect out
@@ -42,11 +44,13 @@ test_expect_success 'progress display with total' '
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
@@ -63,14 +67,14 @@ Working hard.......2.........3.........4.........5.........6:
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
@@ -89,16 +93,16 @@ Working hard.......2.........3.........4.........5.........6:
 EOF
 
 	cat >in <<-\EOF &&
+	start 100000 Working hard.......2.........3.........4.........5.........6
 	update
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
@@ -117,14 +121,14 @@ Working hard.......2.........3.........4.........5.........6:
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
@@ -141,14 +145,14 @@ Working hard.......2.........3.........4.........5.........6.........7.........:
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
@@ -165,12 +169,14 @@ test_expect_success 'progress shortens - crazy caller' '
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
@@ -186,6 +192,7 @@ test_expect_success 'progress display with throughput' '
 	EOF
 
 	cat >in <<-\EOF &&
+	start 0
 	throughput 102400 1000
 	update
 	progress 10
@@ -198,8 +205,9 @@ test_expect_success 'progress display with throughput' '
 	throughput 409600 4000
 	update
 	progress 40
+	stop
 	EOF
-	test-tool progress "Working hard" <in 2>stderr &&
+	test-tool progress <in 2>stderr &&
 
 	show_cr <stderr >out &&
 	test_cmp expect out
@@ -215,6 +223,7 @@ test_expect_success 'progress display with throughput and total' '
 	EOF
 
 	cat >in <<-\EOF &&
+	start 40
 	throughput 102400 1000
 	progress 10
 	throughput 204800 2000
@@ -223,8 +232,9 @@ test_expect_success 'progress display with throughput and total' '
 	progress 30
 	throughput 409600 4000
 	progress 40
+	stop
 	EOF
-	test-tool progress --total=40 "Working hard" <in 2>stderr &&
+	test-tool progress <in 2>stderr &&
 
 	show_cr <stderr >out &&
 	test_cmp expect out
@@ -240,6 +250,7 @@ test_expect_success 'cover up after throughput shortens' '
 	EOF
 
 	cat >in <<-\EOF &&
+	start 0
 	throughput 409600 1000
 	update
 	progress 1
@@ -252,8 +263,9 @@ test_expect_success 'cover up after throughput shortens' '
 	throughput 1638400 4000
 	update
 	progress 4
+	stop
 	EOF
-	test-tool progress "Working hard" <in 2>stderr &&
+	test-tool progress <in 2>stderr &&
 
 	show_cr <stderr >out &&
 	test_cmp expect out
@@ -268,6 +280,7 @@ test_expect_success 'cover up after throughput shortens a lot' '
 	EOF
 
 	cat >in <<-\EOF &&
+	start 0
 	throughput 1 1000
 	update
 	progress 1
@@ -277,8 +290,9 @@ test_expect_success 'cover up after throughput shortens a lot' '
 	throughput 3145728 3000
 	update
 	progress 3
+	stop
 	EOF
-	test-tool progress "Working hard" <in 2>stderr &&
+	test-tool progress <in 2>stderr &&
 
 	show_cr <stderr >out &&
 	test_cmp expect out
@@ -286,6 +300,7 @@ test_expect_success 'cover up after throughput shortens a lot' '
 
 test_expect_success 'progress generates traces' '
 	cat >in <<-\EOF &&
+	start 40
 	throughput 102400 1000
 	update
 	progress 10
@@ -298,10 +313,11 @@ test_expect_success 'progress generates traces' '
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
2.33.1.1510.ge5c82eefb93

