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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB75AC48BE5
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 17:48:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5C59611CB
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 17:48:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbhFWRvL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Jun 2021 13:51:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbhFWRvB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jun 2021 13:51:01 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91042C0617A6
        for <git@vger.kernel.org>; Wed, 23 Jun 2021 10:48:39 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id u8-20020a7bcb080000b02901e44e9caa2aso1802363wmj.4
        for <git@vger.kernel.org>; Wed, 23 Jun 2021 10:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8N+R6M07JfkZE0+gAEOa8HpCZWJSS0NmBIr647albSE=;
        b=mDgU0bsofDu5Xm8Qpac0Vc77KdpsURYsbEa8M0cJAx1TMiMHxNWc4s1Iw5qjJ5lZQY
         1PVQeCZFT8BU3E3y3qL8AfF03KxSPh1LeXv9/TImZ2JEDrw0GpzBROSx0Y4UjrOSXV+8
         ae2hC92UnokFn42mQUvtpWVG+9t2gljs0aL30eIXoec9Gr8kuPWTQ2Tme1l3BC2KatF7
         UFKv5M82Sv22f1FKyd6lNByciVioihMHhbZ/jmqut5eoq+zI1IquvNi5KLOz1TKE/Mzu
         0iYQgcsLmHnI6yBUzwEWbPSxbFU3XtsoEeuc1sYwV/xiYnn7MlNY0/QSCyIcF7yCmPOP
         Es3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8N+R6M07JfkZE0+gAEOa8HpCZWJSS0NmBIr647albSE=;
        b=CTice6oGcsz5C1n+jAZGLMWUoJMM2n6EE79aARiO15MeDjKO2Rgp2/fZLxF0ZYUeGQ
         hNMOq+vyMlmrslPQqJty5Z5fsM9eHQtEzpwuwQl2bNhWFystNse/k6+rJbyuzDrA2ZQ0
         5cO0Uw65MBfiE7KBN2ipi3RVXU3j9kmbiouR+lbOurqBuVRMtFPDNcS1+MNGlOI4qyzi
         RUET/HQ9l+U3rCGnoPz/6R61LtKP4KYbU7bgk0q3cdKcvH5eUpl72bE3YyAoBS2t1YlM
         agHmZ56ebjZTd8VErlyfYAr92cJTwLWx7nafnYFQ7dNGbINaxPrLfhS79/duAldRRPvn
         fqdA==
X-Gm-Message-State: AOAM532wDbSSXNc6PSGlCyCF8gQoW1XeX7oW3vbUeTjV9XtY2ongG3Dm
        ivcWa3R/pUUawfAaTNLJhMWSUtTeoSijhA==
X-Google-Smtp-Source: ABdhPJwEIcTI0QqefWLGfXqF60rw8S1MDeAgA57eJSVhzJjjFzJTw4PoD1cIs2b6IDGw8WQ3Iy7n1g==
X-Received: by 2002:a1c:f215:: with SMTP id s21mr12363521wmc.179.1624470518015;
        Wed, 23 Jun 2021 10:48:38 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id x25sm6678281wmj.23.2021.06.23.10.48.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 10:48:37 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 12/25] progress.c: add & assert a "global_progress" variable
Date:   Wed, 23 Jun 2021 19:48:12 +0200
Message-Id: <patch-12.25-c4e7179e957-20210623T155626Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.599.g3967b4fa4ac
In-Reply-To: <cover-00.25-00000000000-20210623T155626Z-avarab@gmail.com>
References: <YNKWsTsQgB2Ijxu7@nand.local> <cover-00.25-00000000000-20210623T155626Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The progress.c code makes a hard assumption that only one progress bar
be active at a time (see [1] for a bug where this wasn't the case),
but nothing has asserted that that's the case. Let's add a BUG()
that'll trigger if two progress bars are active at the same time.

There's an alternate test-only approach to doing the same thing[2],
but by doing this for all progress bars we'll have a canary to check
if we have any unexpected interaction between the "sig_atomic_t
progress_update" variable and this global struct.

I am then planning on using this scaffolding in the future to fix a
limitation in the progress output, namely the current limitation of
the progress.c bar code that any update must pro-actively go through
the likes of display_progress().

If we e.g. hang forever before the first display_progress(), or in the
middle of a loop that would call display_progress() the user will only
see either no output, or output frozen at the last display_progress()
that would have done an update (e.g. in cases where progress_update
was "1" due to an earlier signal).

This change does not fix that, but sets up the structure for solving
that and other related problems by juggling this "global_progress"
struct. Later changes will make more use of the "global_progress" than
only using it for these assertions.

1. 6f9d5f2fda1 (commit-graph: fix progress of reachable commits, 2020-07-09)
2. https://lore.kernel.org/git/20210620200303.2328957-3-szeder.dev@gmail.com

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 progress.c                  | 17 +++++++++++++----
 t/t0500-progress-display.sh | 11 +++++++++++
 2 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/progress.c b/progress.c
index 912edd4c818..e1b50ef7882 100644
--- a/progress.c
+++ b/progress.c
@@ -45,6 +45,7 @@ struct progress {
 };
 
 static volatile sig_atomic_t progress_update;
+static struct progress *global_progress;
 
 /*
  * These are only intended for testing the progress output, i.e. exclusively
@@ -220,11 +221,15 @@ void progress_test_force_update(void)
 	progress_interval(SIGALRM);
 }
 
-static void set_progress_signal(void)
+static void set_progress_signal(struct progress *progress)
 {
 	struct sigaction sa;
 	struct itimerval v;
 
+	if (global_progress)
+		BUG("should have no global_progress in set_progress_signal()");
+	global_progress = progress;
+
 	if (progress_testing)
 		return;
 
@@ -242,10 +247,14 @@ static void set_progress_signal(void)
 	setitimer(ITIMER_REAL, &v, NULL);
 }
 
-static void clear_progress_signal(void)
+static void clear_progress_signal(struct progress *progress)
 {
 	struct itimerval v = {{0,},};
 
+	if (!global_progress)
+		BUG("should have a global_progress in clear_progress_signal()");
+	global_progress = NULL;
+
 	if (progress_testing)
 		return;
 
@@ -268,7 +277,7 @@ static struct progress *start_progress_delay(const char *title, uint64_t total,
 	strbuf_init(&progress->counters_sb, 0);
 	progress->title_len = utf8_strwidth(title);
 	progress->split = 0;
-	set_progress_signal();
+	set_progress_signal(progress);
 	trace2_region_enter("progress", title, the_repository);
 	return progress;
 }
@@ -342,7 +351,7 @@ void stop_progress_msg(struct progress **p_progress, const char *msg)
 		display(progress, progress->last_value, buf);
 		free(buf);
 	}
-	clear_progress_signal();
+	clear_progress_signal(progress);
 	strbuf_release(&progress->counters_sb);
 	if (progress->throughput)
 		strbuf_release(&progress->throughput->display);
diff --git a/t/t0500-progress-display.sh b/t/t0500-progress-display.sh
index 66c1989b176..476a31222a3 100755
--- a/t/t0500-progress-display.sh
+++ b/t/t0500-progress-display.sh
@@ -361,4 +361,15 @@ test_expect_success 'progress generates traces: stop without start' '
 	! grep region_leave.*progress trace-stop.event
 '
 
+test_expect_success 'BUG: start two concurrent progress bars' '
+	cat >in <<-\EOF &&
+	start 0 one
+	start 0 two
+	EOF
+
+	test_must_fail test-tool progress \
+		<in 2>stderr &&
+	grep -E "^BUG: .*: should have no global_progress in set_progress_signal\(\)$" stderr
+'
+
 test_done
-- 
2.32.0.599.g3967b4fa4ac

