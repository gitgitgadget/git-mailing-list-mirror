Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6DADC48BDF
	for <git@archiver.kernel.org>; Sun, 20 Jun 2021 20:03:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C390F6117A
	for <git@archiver.kernel.org>; Sun, 20 Jun 2021 20:03:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbhFTUFa (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Jun 2021 16:05:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbhFTUF2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Jun 2021 16:05:28 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3376BC061574
        for <git@vger.kernel.org>; Sun, 20 Jun 2021 13:03:15 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id s6so16045955edu.10
        for <git@vger.kernel.org>; Sun, 20 Jun 2021 13:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7bxCqFOfE06xrZBvQwdJLS/9WWjqVUwVxsNoPxsTFWg=;
        b=siUyflqzRRdU2HPhgwNBgwSfp3CcqXsnFJVoK2Na5SePLhkDYVtIxzqii5dCZazMcs
         lKNZSQaN55qIeAXgZHNHnD/PeWOHzzuKjeqlg4zoIfdzbpPpovM87aYeeUb5yN8Qlh5b
         A2YjAuqdqCg3nddOks35zoU93SlzOEOug9OlpNgDggygUA22UuVplSeAeK9KcJ0Qm3L2
         /TCF5jO7A4PJiGbqKsAnIZ/a+MBCdqTzr+ZkQaFkIEjKqeH/Oh3e8mY1LXCoglpYBwgy
         4N+p4mSPaBMeLAnNd6Ap/AXmJfudLCFeBErOWVYwRPE4S6jrkUdWNS4fb91bYSN1/XPp
         Wg4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7bxCqFOfE06xrZBvQwdJLS/9WWjqVUwVxsNoPxsTFWg=;
        b=qTvUqXea7ydLuM3ctjQe6T7u5qJEtwdNXlVRZZ3/3ZIDOYSOKb85NeuGFB6cr8KahC
         oLg/4xHpBaQqFcMxwFhqoK7b5zBplX6z7a+3aZFK3IgyqPDJlorWhMrCalUJLuudhHaF
         hRstzb47ZjSGJaGCHs6YNWm4apTAhdV0sqH3G8FZy+M9yQvUFKo8O++nyTqtACGn5xLv
         Rbt8/diYVKzavHIkGBg/5N1oQkW5XMV5jCHbrb6zhaL9LEal3vpF4pPOR5iOCP76LB/F
         U/4FjnAmoAHsW5hufrsAdS8eBTo9jBWpBvjET8S8bNrQIGI1DMNZStoNOEosSfNYPfFl
         hTbw==
X-Gm-Message-State: AOAM532lylbtpqGiymUHbewuFLcaJKMUIhmVxJp4SpiuuEH1QecesvJy
        laMYOZXXqh29vGITuXEmvDhnJ3TWJfM=
X-Google-Smtp-Source: ABdhPJzTc68a4rfGStyi7IP/1O+8oudc5zmOelln4nmR19nOxXPfLjuhhTffBvfGTKBAqx55aWMqqw==
X-Received: by 2002:aa7:c256:: with SMTP id y22mr17391505edo.177.1624219393790;
        Sun, 20 Jun 2021 13:03:13 -0700 (PDT)
Received: from localhost.localdomain (94-21-23-215.pool.digikabel.hu. [94.21.23.215])
        by smtp.gmail.com with ESMTPSA id cw10sm3893904ejb.62.2021.06.20.13.03.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Jun 2021 13:03:13 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 1/7] progress: introduce GIT_TEST_CHECK_PROGRESS to verify progress counters
Date:   Sun, 20 Jun 2021 22:02:57 +0200
Message-Id: <20210620200303.2328957-2-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.32.0.289.g44fbea0957
In-Reply-To: <20210620200303.2328957-1-szeder.dev@gmail.com>
References: <20210620200303.2328957-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We had to fix a couple of buggy progress lines in the past, where the
progress counter's final value didn't match the expected total [1],
e.g.:

  Expanding reachable commits in commit graph: 138606% (824706/595), done.
  Writing out commit graph in 3 passes: 166% (4187845/2512707), done.

Let's do better, and, instead of waiting for someone to notice such
issues by mere chance, start verifying progress counters in the test
suite: introduce the GIT_TEST_CHECK_PROGRESS knob to automatically
check that the final value of each progress counter matches the
expected total upon calling stop_progress(), and trigger a BUG() if it
doesn't.

This check should cover progress lines that are too fast to be shown,
because the repositories used in our tests are tiny and most of our
progress lines are delayed.  However, in case of a delayed progress
line the variable holding the value of the progress counter
('progress->last_value') is only updated after that delay is up, and,
consequently, we can't compare the progress counter with the expected
total in stop_progress() in these cases.

So let's update 'progress->last_value' already during the initial
delay as well.  This doesn't affect the visible behavior of progress
lines, though it results in additional invocations of the internal
display() function during the initial delay, but those don't make any
difference, because display() returns early without displaying
anything until the delay is up anyway.

Note that this can only check progress lines that are actually
started, i.e. that are shown by default even when standard error is
not a terminal, or that are forced to show with the '--progress'
option of whichever Git command displaying them.

Nonetheless, running the test suite with this new knob enabled results
in failures in 't0021-conversion.sh' and 't5510-fetch.sh', revealing
two more progress lines whose counter doesn't reach the expected
total.  These will be fixed in later patches in this series, and after
that GIT_TEST_CHECK_PROGRESS will be enabled by default in the test
suite.

[1] c4ff24bbb3 (commit-graph.c: display correct number of chunks when
                writing, 2021-02-24)
    1cbdbf3bef (commit-graph: drop count_distinct_commits() function,
                2020-12-07), though this didn't actually fixed, but
                instead removed a buggy progress line.
    150cd3b61d (commit-graph: fix "Writing out commit graph" progress
                counter, 2020-07-09)
    67fa6aac5a (commit-graph: don't show progress percentages while
                expanding reachable commits, 2019-09-07)
    531e6daa03 (prune-packed: advanced progress even for non-existing
                fan-out directories, 2009-04-27)

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 progress.c                  | 16 ++++++++++++++--
 t/t0500-progress-display.sh | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+), 2 deletions(-)

diff --git a/progress.c b/progress.c
index 680c6a8bf9..255995406f 100644
--- a/progress.c
+++ b/progress.c
@@ -47,6 +47,8 @@ struct progress {
 
 static volatile sig_atomic_t progress_update;
 
+static int test_check_progress;
+
 /*
  * These are only intended for testing the progress output, i.e. exclusively
  * for 'test-tool progress'.
@@ -111,10 +113,11 @@ static void display(struct progress *progress, uint64_t n, const char *done)
 	int show_update = 0;
 	int last_count_len = counters_sb->len;
 
+	progress->last_value = n;
+
 	if (progress->delay && (!progress_update || --progress->delay))
 		return;
 
-	progress->last_value = n;
 	tp = (progress->throughput) ? progress->throughput->display.buf : "";
 	if (progress->total) {
 		unsigned percent = n * 100 / progress->total;
@@ -252,7 +255,11 @@ void display_progress(struct progress *progress, uint64_t n)
 static struct progress *start_progress_delay(const char *title, uint64_t total,
 					     unsigned delay, unsigned sparse)
 {
-	struct progress *progress = xmalloc(sizeof(*progress));
+	struct progress *progress;
+
+	test_check_progress = git_env_bool("GIT_TEST_CHECK_PROGRESS", 0);
+
+	progress = xmalloc(sizeof(*progress));
 	progress->title = title;
 	progress->total = total;
 	progress->last_value = -1;
@@ -349,6 +356,11 @@ void stop_progress_msg(struct progress **p_progress, const char *msg)
 	progress = *p_progress;
 	if (!progress)
 		return;
+	if (test_check_progress && progress->total &&
+	    progress->total != progress->last_value)
+		BUG("total progress does not match for \"%s\": expected: %"PRIuMAX" got: %"PRIuMAX,
+		    progress->title, (uintmax_t)progress->total,
+		    (uintmax_t)progress->last_value);
 	*p_progress = NULL;
 	if (progress->last_value != -1) {
 		/* Force the last update */
diff --git a/t/t0500-progress-display.sh b/t/t0500-progress-display.sh
index 22058b503a..641fa0964e 100755
--- a/t/t0500-progress-display.sh
+++ b/t/t0500-progress-display.sh
@@ -308,4 +308,38 @@ test_expect_success 'progress generates traces' '
 	grep "\"key\":\"total_bytes\",\"value\":\"409600\"" trace.event
 '
 
+test_expect_success 'GIT_TEST_CHECK_PROGRESS catches non-matching total' '
+	cat >in <<-\EOF &&
+	progress 1
+	progress 2
+	progress 4
+	EOF
+
+	test_must_fail env GIT_TEST_CHECK_PROGRESS=1 \
+		test-tool progress --total=3 "Not enough" <in 2>stderr &&
+	grep "BUG:.*total progress does not match" stderr &&
+
+	test_must_fail env GIT_TEST_CHECK_PROGRESS=1 \
+		test-tool progress --total=5 "Too much" <in 2>stderr &&
+	grep "BUG:.*total progress does not match" stderr
+'
+
+test_expect_success 'tolerate bogus progress without GIT_TEST_CHECK_PROGRESS' '
+	cat >expect <<-\EOF &&
+	Working hard:  33% (1/3)<CR>
+	Working hard:  33% (1/3), done.
+	EOF
+
+	cat >in <<-\EOF &&
+	progress 1
+	EOF
+	(
+		sane_unset GIT_TEST_CHECK_PROGRESS &&
+		test-tool progress --total=3 "Working hard" <in 2>stderr
+	) &&
+
+	show_cr <stderr >out &&
+	test_cmp expect out
+'
+
 test_done
-- 
2.32.0.289.g44fbea0957

