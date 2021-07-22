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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D2E8C63793
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 12:55:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 464D061396
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 12:55:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232069AbhGVMOv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Jul 2021 08:14:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232041AbhGVMOn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jul 2021 08:14:43 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B2B8C0613D5
        for <git@vger.kernel.org>; Thu, 22 Jul 2021 05:55:17 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id i94so5835898wri.4
        for <git@vger.kernel.org>; Thu, 22 Jul 2021 05:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K4Vy+cSoK5dbndzGHvKRxK6XaBL7g7Xz+qOwbSPWW6k=;
        b=KIIIUH91UjENUdYr5bhWYnIsYIi0YmU57uWB+kl1QJ4qXiKTn8bHhTfTLUzDCH77b9
         XjPK+Yeuxv8IW3g76J3MgAv3fUSERMBF/DQNbFkNj/FQsL3aiWNn5WuwGkRcKdiDC/O4
         Ohk2+fFUAWnJp/wD7PBo90yAqmPlO9l5BzFE0xvIiX1tfyF19heRe3gR4yv4JFC8Lf90
         DZI8LjfQbUzcPEis2woRyjAZnkAhh5rdlwp5em8G1KnyX07N1u8khlAEbJHaIYx4KnV1
         6nekAtcAiOHB+zJunIrZSo5FaM2apWRsFuydqiblxflfiPRznO67LCVEdZx4qGTbOR1Z
         sL5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K4Vy+cSoK5dbndzGHvKRxK6XaBL7g7Xz+qOwbSPWW6k=;
        b=cYR8AXM/PmtsY6+kFqQ2AFCOqx7byFMIBFipvbybErnqs1twgIxgj6YpVX+Wst3Hmc
         yROkJgEq07YK1ruCehrZ1ms73oq99pcZBJwR+pJFNY04mqWNuSto7+VqovMB+fmP3PNI
         bW3p0mcolVLTsIQXouEd26bwuYhAsuwTkkvgMKrWFCFOkkgpAkegjPPNPdmHsZAocaJv
         59NzgHf/F4bhjR92QTxDqU6GEE6iUCJapnqhJ6sH08zlQnVOopvOowneuSGFLI3eLFne
         DFlKsQp7hoQ0Nj27yg3gYi9qM5XfwaC4SrdmO5zElTD0bl6ek4KOE9Cec9mgarViGicI
         UPdw==
X-Gm-Message-State: AOAM5329fswPDwixHNDQvnRtyYmwglmdgYqXTe5NVEaySbY3LmTBYInw
        726NDQ+VUR3GFuSfg4Xzl625DQXoegJq0g==
X-Google-Smtp-Source: ABdhPJz+l5kRX2Bl0UW8jpOTjNeANcQXvGKC9mIymnT1MP6zaPFDdieyT5bJL4lT/uPF3Lmh5l+AGQ==
X-Received: by 2002:a05:6000:1841:: with SMTP id c1mr46744476wri.423.1626958515879;
        Thu, 22 Jul 2021 05:55:15 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id g3sm29937483wru.95.2021.07.22.05.55.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jul 2021 05:55:15 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 8/8] progress.c: add & assert a "global_progress" variable
Date:   Thu, 22 Jul 2021 14:55:06 +0200
Message-Id: <patch-8.8-1a14176bee-20210722T125012Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.957.gd9e39d72fe6
In-Reply-To: <cover-0.8-0000000000-20210722T125012Z-avarab@gmail.com>
References: <20210620200303.2328957-1-szeder.dev@gmail.com> <cover-0.8-0000000000-20210722T125012Z-avarab@gmail.com>
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
index 1ab7d19deb..14a023f4b4 100644
--- a/progress.c
+++ b/progress.c
@@ -46,6 +46,7 @@ struct progress {
 };
 
 static volatile sig_atomic_t progress_update;
+static struct progress *global_progress;
 
 /*
  * These are only intended for testing the progress output, i.e. exclusively
@@ -221,11 +222,15 @@ void progress_test_force_update(void)
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
 
@@ -243,10 +248,14 @@ static void set_progress_signal(void)
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
 
@@ -270,7 +279,7 @@ static struct progress *start_progress_delay(const char *title, uint64_t total,
 	strbuf_init(&progress->counters_sb, 0);
 	progress->title_len = utf8_strwidth(title);
 	progress->split = 0;
-	set_progress_signal();
+	set_progress_signal(progress);
 	trace2_region_enter("progress", title, the_repository);
 	return progress;
 }
@@ -374,7 +383,7 @@ void stop_progress_msg(struct progress **p_progress, const char *msg)
 		display(progress, progress->last_value, buf);
 		free(buf);
 	}
-	clear_progress_signal();
+	clear_progress_signal(progress);
 	strbuf_release(&progress->counters_sb);
 	if (progress->throughput)
 		strbuf_release(&progress->throughput->display);
diff --git a/t/t0500-progress-display.sh b/t/t0500-progress-display.sh
index ffa819ca1d..124d33c96b 100755
--- a/t/t0500-progress-display.sh
+++ b/t/t0500-progress-display.sh
@@ -296,6 +296,17 @@ test_expect_success 'cover up after throughput shortens a lot' '
 	test_cmp expect out
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
 test_expect_success 'progress generates traces' '
 	cat >in <<-\EOF &&
 	start 40
-- 
2.32.0.957.gd9e39d72fe6

