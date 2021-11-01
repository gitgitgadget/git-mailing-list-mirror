Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B77BC433F5
	for <git@archiver.kernel.org>; Mon,  1 Nov 2021 19:09:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E57860F58
	for <git@archiver.kernel.org>; Mon,  1 Nov 2021 19:09:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232468AbhKATMC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Nov 2021 15:12:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232299AbhKATLz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Nov 2021 15:11:55 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13C20C061764
        for <git@vger.kernel.org>; Mon,  1 Nov 2021 12:09:22 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id t30so4709045wra.10
        for <git@vger.kernel.org>; Mon, 01 Nov 2021 12:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DoQQQWG40nCbzLeYEIQr3jxIiP3Ql09y1EeOaoRNU7E=;
        b=Be6jUi6tyOSbM06nkONgMi+eaeUsyUAgojvneZzfnqo5ViyRymrhAbOdA2xOA5j1Xp
         EA5Rq6iZEIGHzcP7vAN5Ty/kFpI5riQX+mG/pTxI6qeVdiM+gOewApwlOdh13TJYJVkP
         5mOEjnnREUulVLNHx0EnLFe2LqUbgaT2I4yaYMEqg55WLZal4IsHcG4LUShsECFHVGUf
         7IKUqlwkxl9bHHjdSsAb8zkHeeDx3DRdFZlaElWBoxDnfRNgetLw3qM/by7JZFQjANIh
         FlH4crOKqM/hRXqwfuVYWOV3AFlyiPLq29XDckBfQieJd5qYKf8ILwsFXtVfSyx1E8k2
         b+Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DoQQQWG40nCbzLeYEIQr3jxIiP3Ql09y1EeOaoRNU7E=;
        b=GPlNguQG5p/eKHC+al8ran5XbkHCewa0GYHpXZST2nu/ukFp+ADAHYl1aZ5rJ/X3nD
         l4hW/N2K4Xk3xJtLBXcAF3CGo0B3FOWR1vbxQYTqLETpVo3zs+bebfALO+/MGWsGQlUd
         u+64QlREJvjcFMTJzQaeac6towQ20rfFUe+O6ptiBi4My+8uvxcUE5/ye/40nqr5HIgL
         ekPekB0ANocmJZuAsoT6Q0gzoR06lC8GDzU+dC8BDKdRWNlQ8OFef8yMU8DY1EXnxlQI
         6zOy2DTPsclGeNvGikVYxYiieHKUCb9GdR/UkrOcsQiFN/S93rAdwtafnwqJmYNyiZlD
         e3mA==
X-Gm-Message-State: AOAM532zgJ5nIXuWdMaerCsvXpRurS3onj31ziquHSy42BFzAxz/BSha
        3RtL10HM1uQOTVG4b4t8/XrMtMUT/MdF2Fzy
X-Google-Smtp-Source: ABdhPJzPusbVd3Ihn4aXW8EZ3hnHQJk2rgCSNA7uBH1+carRpuwfPojy3RuOuSCr6yDBCTpYhy64uw==
X-Received: by 2002:adf:e682:: with SMTP id r2mr8704811wrm.281.1635793760434;
        Mon, 01 Nov 2021 12:09:20 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id p12sm4337211wro.33.2021.11.01.12.09.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Nov 2021 12:09:19 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Emily Shaffer <emilyshaffer@google.com>,
        Taylor Blau <me@ttaylorr.com>, Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 3/8] progress.c tests: make start/stop commands on stdin
Date:   Mon,  1 Nov 2021 20:09:09 +0100
Message-Id: <patch-v5-3.8-767aa010026-20211101T190630Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1570.g069344fdd45
In-Reply-To: <cover-v5-0.8-00000000000-20211101T190630Z-avarab@gmail.com>
References: <cover-v4-0.8-00000000000-20211025T111915Z-avarab@gmail.com> <cover-v5-0.8-00000000000-20211101T190630Z-avarab@gmail.com>
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
2.33.1.1570.g069344fdd45

