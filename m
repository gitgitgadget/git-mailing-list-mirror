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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91C3EC4743C
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 17:48:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F13C611CB
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 17:48:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbhFWRvM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Jun 2021 13:51:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbhFWRvC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jun 2021 13:51:02 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D601EC0617AE
        for <git@vger.kernel.org>; Wed, 23 Jun 2021 10:48:40 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id u11so3548856wrw.11
        for <git@vger.kernel.org>; Wed, 23 Jun 2021 10:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nas0R6uX9+LqJxi/c4zKrj/09+ZQQsXmwa5KSv0WXMk=;
        b=FdeTMtio0qa3UU/MZ5aYuhMehZNoe7bMNHwSqLo3CscvxHfs/mfENlaIhG40pumG5s
         +8EKmVM5pg2TKqxkrt1a4kILL8nWqnkvJY+stj2aO6kUgIFfcvy8i+cAA41bQzSAZ9rp
         A2DOH6CB9gK9xeivYJ9j2HxYrHj1uxyYC0iGOE0XucTlyCdHz5V8FKFyc+bWW0aDFnkn
         XnPdyWkvf9Z2N2QVLISBIJ5+b+/1/RphRlmL+hmfLmtTy3yi0iFRX+U0dayB44ZAQkkI
         9WFi4LMwcbuQvyWCa2CD+OXcC3tWvl8HLByTY9fzgaywbWP9PkZiX7rAo7rrG8315sqP
         ITJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nas0R6uX9+LqJxi/c4zKrj/09+ZQQsXmwa5KSv0WXMk=;
        b=lDLneQegzrHJyvfIIT+kt1QFnp4UencNxgJaR4NCQdzkvXaEw4sMXe2NIXAiKGeiAW
         aR/iFvOAfkSBRKKOx3BPyoVK6o/Jookd6y2tXSPnNIXo6c42MN2LwnQYqFejn4P6wHXt
         ylC6C5QDa7IYvADVoDjvh8gK/UDVgdKHSfmlGUiumMN1xqpdXRT6JqnlZ8ieCM7R5B0w
         PvZjJB1P154FwrVQolmNmc+5WqT5lwJsSk6iKJ5re1eEklO/d4fT5T6Pspne+uPY0pTd
         wkriaA1GppHuUzB2gGKidCePgzIwwO2IZ/KgkWThe+gJJ+mhfF2bc8NfZOCNZ4mJsocN
         u2EA==
X-Gm-Message-State: AOAM533aim+gJ797VFLOOZQ2dXUc30Wa4QrJaTEU7p5KPuminRHN5Vab
        W3SXdLPvKaj9uMHQEmjk+TIZL1YVlSKvcw==
X-Google-Smtp-Source: ABdhPJwubB8ijljO6HODkpajt476EQj+JOWfZxz3WR7QDTuuydGXL7LoDjmkzhtOIJgVGWkxSrG2Rw==
X-Received: by 2002:adf:f743:: with SMTP id z3mr1389781wrp.329.1624470519279;
        Wed, 23 Jun 2021 10:48:39 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id x25sm6678281wmj.23.2021.06.23.10.48.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 10:48:38 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 14/25] progress.[ch]: move test-only code away from "extern" variables
Date:   Wed, 23 Jun 2021 19:48:14 +0200
Message-Id: <patch-14.25-88d864c373a-20210623T155626Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.599.g3967b4fa4ac
In-Reply-To: <cover-00.25-00000000000-20210623T155626Z-avarab@gmail.com>
References: <YNKWsTsQgB2Ijxu7@nand.local> <cover-00.25-00000000000-20210623T155626Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since the test-only support code was added in 2bb74b53a49 (Test the
progress display, 2019-09-16) we've had to define
GIT_TEST_PROGRESS_ONLY more widely as part of the bugfix in
3cacb9aaf46 (progress.c: silence cgcc suggestion about internal
linkage, 2020-04-27).

So the only thing we were getting out of this indirection was keeping
GIT_TEST_PROGRESS_ONLY from being defined in progress.h itself,
i.e. so the likes of csum-file.h wouldn't have access to them, we'd
still compile them in progress.o.

Let's just always define and compile them without this needless slight
of hand, the linking and strip step will take care of removing these
unused symbols, if needed.

We now expose a start_progress_testing() function instead, which'll
set a "test_mode" member, which the test of the code can check.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 progress.c               | 34 ++++++++++++++--------------------
 progress.h               | 21 ++++++++++++++-------
 t/helper/test-progress.c | 11 +++++------
 3 files changed, 33 insertions(+), 33 deletions(-)

diff --git a/progress.c b/progress.c
index aff9af9ee8b..39d7f6bd86b 100644
--- a/progress.c
+++ b/progress.c
@@ -8,7 +8,6 @@
  * published by the Free Software Foundation.
  */
 
-#define GIT_TEST_PROGRESS_ONLY
 #include "cache.h"
 #include "gettext.h"
 #include "progress.h"
@@ -20,13 +19,6 @@
 static volatile sig_atomic_t progress_update;
 static struct progress *global_progress;
 
-/*
- * These are only intended for testing the progress output, i.e. exclusively
- * for 'test-tool progress'.
- */
-int progress_testing;
-uint64_t progress_test_ns = 0;
-
 static int is_foreground_fd(int fd)
 {
 	int tpgrp = tcgetpgrp(fd);
@@ -108,8 +100,8 @@ static void throughput_string(struct strbuf *buf, uint64_t total,
 
 static uint64_t progress_getnanotime(struct progress *progress)
 {
-	if (progress_testing)
-		return progress->start_ns + progress_test_ns;
+	if (progress->test_getnanotime)
+		return progress->start_ns + progress->test_getnanotime;
 	else
 		return getnanotime();
 }
@@ -185,11 +177,7 @@ static void progress_interval(int signum)
 	progress_update = 1;
 }
 
-/*
- * The progress_test_force_update() function is intended for testing
- * the progress output, i.e. exclusively for 'test-tool progress'.
- */
-void progress_test_force_update(void)
+void test_progress_force_update(void)
 {
 	progress_interval(SIGALRM);
 }
@@ -203,7 +191,7 @@ static void set_progress_signal(struct progress *progress)
 		BUG("should have no global_progress in set_progress_signal()");
 	global_progress = progress;
 
-	if (progress_testing)
+	if (progress->test_mode)
 		return;
 
 	progress_update = 0;
@@ -228,7 +216,7 @@ static void clear_progress_signal(struct progress *progress)
 		BUG("should have a global_progress in clear_progress_signal()");
 	global_progress = NULL;
 
-	if (progress_testing)
+	if (progress->test_mode)
 		return;
 
 	setitimer(ITIMER_REAL, &v, NULL);
@@ -237,7 +225,7 @@ static void clear_progress_signal(struct progress *progress)
 }
 
 static struct progress *start_progress_delay(const char *title, uint64_t total,
-					     unsigned delay)
+					     unsigned delay, int testing)
 {
 	struct progress *progress = xmalloc(sizeof(*progress));
 	progress->title = title;
@@ -250,11 +238,17 @@ static struct progress *start_progress_delay(const char *title, uint64_t total,
 	strbuf_init(&progress->counters_sb, 0);
 	progress->title_len = utf8_strwidth(title);
 	progress->split = 0;
+	progress->test_mode = testing;
 	set_progress_signal(progress);
 	trace2_region_enter("progress", title, the_repository);
 	return progress;
 }
 
+struct progress *start_progress_testing(const char *title, uint64_t total)
+{
+	return start_progress_delay(title, total, 0, 1);
+}
+
 static int get_default_delay(void)
 {
 	static int delay_in_secs = -1;
@@ -267,12 +261,12 @@ static int get_default_delay(void)
 
 struct progress *start_delayed_progress(const char *title, uint64_t total)
 {
-	return start_progress_delay(title, total, get_default_delay());
+	return start_progress_delay(title, total, get_default_delay(), 0);
 }
 
 struct progress *start_progress(const char *title, uint64_t total)
 {
-	return start_progress_delay(title, total, 0);
+	return start_progress_delay(title, total, 0, 0);
 }
 
 void stop_progress(struct progress **p_progress)
diff --git a/progress.h b/progress.h
index 4fb2b483d36..4693dddb6c5 100644
--- a/progress.h
+++ b/progress.h
@@ -27,15 +27,22 @@ struct progress {
 	struct strbuf counters_sb;
 	int title_len;
 	int split;
-};
-
-#ifdef GIT_TEST_PROGRESS_ONLY
 
-extern int progress_testing;
-extern uint64_t progress_test_ns;
-void progress_test_force_update(void);
+	/*
+	 * The test_* members are are only intended for testing the
+	 * progress output, i.e. exclusively for 'test-tool progress'.
+	 */
+	int test_mode;
+	uint64_t test_getnanotime;
+};
 
-#endif
+/*
+ * *_testing() functions are only for use in
+ * t/helper/test-progress.c. Do not use them elsewhere!
+ */
+void test_progress_force_update(void);
+struct progress *start_progress_testing(const char *title, uint64_t total);
+void test_progress_setnanotime(struct progress *progress, uint64_t time);
 
 void display_throughput(struct progress *progress, uint64_t total);
 void display_progress(struct progress *progress, uint64_t n);
diff --git a/t/helper/test-progress.c b/t/helper/test-progress.c
index 7ca58a3ee78..40dbacb0557 100644
--- a/t/helper/test-progress.c
+++ b/t/helper/test-progress.c
@@ -46,21 +46,20 @@ int cmd__progress(int argc, const char **argv)
 	if (argc)
 		usage_with_options(usage, options);
 
-	progress_testing = 1;
 	while (strbuf_getline(&line, stdin) != EOF) {
 		char *end;
 
 		if (!strcmp(line.buf, "start")) {
-			progress = start_progress(default_title, 0);
+			progress = start_progress_testing(default_title, 0);
 		} else if (skip_prefix(line.buf, "start ", (const char **) &end)) {
 			uint64_t total = strtoull(end, &end, 10);
 			if (*end == '\0') {
-				progress = start_progress(default_title, total);
+				progress = start_progress_testing(default_title, total);
 			} else if (*end == ' ') {
 				if (detached_title)
 					free(detached_title);
 				detached_title = strbuf_detach(&line, NULL);
-				progress = start_progress(end + 1, total);
+				progress = start_progress_testing(end + 1, total);
 			} else {
 				die("invalid input: '%s'\n", line.buf);
 			}
@@ -79,11 +78,11 @@ int cmd__progress(int argc, const char **argv)
 			test_ms = strtoull(end + 1, &end, 10);
 			if (*end != '\0')
 				die("invalid input: '%s'\n", line.buf);
-			progress_test_ns = test_ms * 1000 * 1000;
+			progress->test_getnanotime = test_ms * 1000 * 1000;
 			display_throughput(progress, byte_count);
 		} else if (!strcmp(line.buf, "update") ||
 			   !strcmp(line.buf, "signal")) {
-			progress_test_force_update();
+			test_progress_force_update();
 		} else if (!strcmp(line.buf, "stop")) {
 			stop_progress(&progress);
 		} else {
-- 
2.32.0.599.g3967b4fa4ac

