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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C756C4743C
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 17:49:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4AAD611AC
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 17:49:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbhFWRve (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Jun 2021 13:51:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbhFWRvR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jun 2021 13:51:17 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10E3FC0611FB
        for <git@vger.kernel.org>; Wed, 23 Jun 2021 10:48:48 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id a5-20020a7bc1c50000b02901e3bbe0939bso1930970wmj.0
        for <git@vger.kernel.org>; Wed, 23 Jun 2021 10:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=etL2kUR7l5vGKO9c3eHK2m4wLBwJgd+LB9ELYFMVl64=;
        b=jA1Nymueso3qxsx44dnEMTksNoi9Q/2zXc5UaSqbif5lb6awN6OUqP60IsdNmqqVMy
         8SuOBg4aRxnETAz1Gok24rk49YBftVC8t8B+e6aQNMPRVTkGVSTD0Kn2lZ6Sv9I2CRFd
         IZUXPGD9rsnm9SkkL8nUVNIZZihVWBrIlH+hTZ3JKZ20UVkLXhEvxCu411nE0qghhZIK
         NgXxwSFGWG94y9bByQnjk7s7YmoGEoJkFH1pps7pK7RQr386Fm8Msl/ijDI3vUgB59EH
         5YBrAzm/56dYSCztqusNzGv2LlSMesoQKYi+64sRqC8doLn199NEVbZ1UxoC11Xk1wy9
         m9mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=etL2kUR7l5vGKO9c3eHK2m4wLBwJgd+LB9ELYFMVl64=;
        b=TlzNOHtKAk6Ik2+XU5sP8YpLhBIyL11N6TF7vG5zmQ1GJQ8mdpAQdWyzbs2uawg3oH
         helPmxoNHKlSb63zIwxO2sA4mOnALM4fpBdYmODz1ehnsmUnbxeHs7whC28EuudMwpHI
         /gESJQqgYbFGOpRKnsdOhk1vBdetilZizUxy459DYl8GjYl8rf6lNkapRHGHsexL7DgP
         SQutWf0+Gkh4ZK6bVeUdMHUMADpSE7Ewc6Y9WzohXAmN6YZuv/OaDfT0XO4eHKxfr4yh
         HWj9pTOBiB5yttqX/3QYr10vVk/gZEEMjyqZ58rTmUKFlO9ckbcSaqndcVbh23Egh4De
         neyg==
X-Gm-Message-State: AOAM533AhMhqBWoGcqAcVGj83q1coB4jjMxyn/13TPQnyjjph2/fGGlE
        ecL4WOsQjx0RlPD4Vu4WIYQobeAou6EktA==
X-Google-Smtp-Source: ABdhPJyOMKiFWBOgeK+3uOOFq06dRawX5jK43pHS8lBS2zWTDa2SsilPJuv66TuaSYF1mh+t6Uoq1Q==
X-Received: by 2002:a1c:4b04:: with SMTP id y4mr12400534wma.186.1624470526466;
        Wed, 23 Jun 2021 10:48:46 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id x25sm6678281wmj.23.2021.06.23.10.48.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 10:48:46 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC/PATCH 24/25] progress: assert last update in stop_progress()
Date:   Wed, 23 Jun 2021 19:48:24 +0200
Message-Id: <patch-24.25-37b3d1e4d9d-20210623T155626Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.599.g3967b4fa4ac
In-Reply-To: <cover-00.25-00000000000-20210623T155626Z-avarab@gmail.com>
References: <YNKWsTsQgB2Ijxu7@nand.local> <cover-00.25-00000000000-20210623T155626Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: SZEDER Gábor <szeder.dev@gmail.com>

We had to fix a couple of buggy progress lines in the past, where the
progress counter's final value didn't match the expected total [1],
e.g.:

  Expanding reachable commits in commit graph: 138606% (824706/595), done.
  Writing out commit graph in 3 passes: 166% (4187845/2512707), done.

Let's do better, and, instead of waiting for someone to notice such
issues by mere chance, start verifying progress counters in the test
suite. Let's track what the last display_progress() value was, and if
it doesn't match the total at the end invoke BUG().

We need to introduce a "last_update" distinct from "last_value" for
this, since the "last_value" really means "last displayed value", and
the logic in display() relies on it having those semantics.

Using the "last_value" would also leave us with a subtle case where
this assertion wouldn't catch broken API uses, as an earlier version
of this change did.

Even if that was not the case we couldn't rely on it for the purposes
of this assertion. In the case of a delayed progress the variable
holding the value of the progress counter
('progress->last_value') is only updated after that delay is up, and,
consequently, we can't compare the progress counter with the expected
total in stop_progress() in these cases. Thus this check will cover
progress lines that are too fast to be shown, because the repositories
used in our tests are tiny and most of our progress lines are delayed.

What it can't cover is code that doesn't start the progress bar at
all, e.g. due to its own isatty() check, so progress that is only
started and shown when standard error is not a terminal won't be
covered by our tests.

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
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

WARNING: I belive this is subtly buggy, see the discussion in the
cover letter. It needs more fixes of the progress.c API usage in
various places before being ready.

 progress.c                  |  8 ++++++++
 t/t0500-progress-display.sh | 30 +++++++++++++++++++++++++++++-
 2 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/progress.c b/progress.c
index c1cb01ba975..40043bf6601 100644
--- a/progress.c
+++ b/progress.c
@@ -325,6 +325,7 @@ static struct progress *start_progress_delay(const char *title, uint64_t total,
 
 	progress->total = total;
 	progress->last_value = -1;
+	progress->last_update = -1;
 	progress->last_percent = -1;
 	progress->delay = delay;
 	progress->throughput = NULL;
@@ -393,6 +394,13 @@ void stop_progress_msg(struct progress **p_progress, const char *msg)
 	if (!progress)
 		return;
 	*p_progress = NULL;
+
+	if (progress->total &&
+	    progress->total != progress->last_update)
+		BUG("total progress does not match for \"%*s\": expected: %"PRIuMAX" got: %"PRIuMAX,
+		    (int)(progress->status_len_utf8), progress->title.buf,
+		    (uintmax_t)progress->total,
+		    (uintmax_t)progress->last_update);
 	if (progress->last_value != -1) {
 		/* Force the last update */
 		struct throughput *tp = progress->throughput;
diff --git a/t/t0500-progress-display.sh b/t/t0500-progress-display.sh
index bc458cfc28b..3f00e52ce46 100755
--- a/t/t0500-progress-display.sh
+++ b/t/t0500-progress-display.sh
@@ -96,7 +96,8 @@ Working hard.......2.........3.........4.........5.........6.........7:
     0% (0/100), stalled.<CR>
     1% (1/100)          <CR>
    50% (50/100)<CR>
-   50% (50/100), done.
+  100% (100/100)<CR>
+  100% (100/100), done.
 EOF
 
 	cat >in <<-\EOF &&
@@ -104,6 +105,7 @@ EOF
 	signal
 	progress 1
 	progress 50
+	progress 100
 	stop
 	EOF
 	test-tool progress <in 2>stderr &&
@@ -423,4 +425,30 @@ test_expect_success 'BUG: start two concurrent progress bars' '
 	grep -E "^BUG: .*: should have no global_progress in set_progress_signal\(\)$" stderr
 '
 
+test_expect_success 'BUG: display_progress() goes past declared "total"' '
+	cat >in <<-\EOF &&
+	start 3
+	progress 1
+	progress 2
+	progress 4
+	stop
+	EOF
+
+	test_must_fail test-tool progress <in 2>stderr &&
+	grep "BUG:.*total progress does not match" stderr
+'
+
+test_expect_success 'BUG: display_progress() does not reach declared "total"' '
+	cat >in <<-\EOF &&
+	start 5
+	progress 1
+	progress 2
+	progress 4
+	stop
+	EOF
+
+	test_must_fail test-tool progress <in 2>stderr &&
+	grep "BUG:.*total progress does not match" stderr
+'
+
 test_done
-- 
2.32.0.599.g3967b4fa4ac

