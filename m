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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0720C48BC2
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 17:49:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88D7061003
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 17:49:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbhFWRvV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Jun 2021 13:51:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbhFWRvI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jun 2021 13:51:08 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C70BDC06175F
        for <git@vger.kernel.org>; Wed, 23 Jun 2021 10:48:43 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id e22so3605668wrc.1
        for <git@vger.kernel.org>; Wed, 23 Jun 2021 10:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BF1i2aC1pfSsCFopjiez7u/PukvYhKu1GTcsAAyxkQs=;
        b=nBOKhLkRu+A+chp8MZ6EDDF6l1Y0oflRno5XgWsBDovJUvwOMWWJE4iyjiFRT6JUgF
         DOg9FKY3UfZVvPZUBoHEXBn/8Gx+LvpIWA9o8uUipKbrJJhn4vwt29OPjx3JhMM6KVtS
         u8SCjHXE+rdoN+khsT63fvnwgA3x5MZzIADSqJSztmSvFwCa7h6o9mYgC60D+HdTCAog
         Z0x/m4/Bv76D/RSRJThDldxwqI+YVTIrq5KY8tnDhB3Zji+cuj1R0G5K1hISoALTQazq
         iZhLPZ0/0xmDcc5Wt9Xog1eBooV6yA6lSaBOWbsbF1+oSwQUqI64wc8MbFd6Z+3pNE8/
         ZE/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BF1i2aC1pfSsCFopjiez7u/PukvYhKu1GTcsAAyxkQs=;
        b=U2hZ+F+EcnKzQgapuqTWWNyzqeavGJ8uFv6Zyf11eNW2DfjNJQPH04+9UjuLafsoIx
         72Uvj4B/JO3kesKTlprkNAOqqIuoasnUgFkk4I7jmskaO7j4hRUJYfXOCCloO0G4W+jK
         IM2EhmD+hBjVMCc1duvLIFStF8tfeiPB9Mb4otKcELQoIF8uz7djci2z15hVMIkbV1Iu
         0E2D510K2AWMdKTg6bJ4Gz4I9exunyhoz22DWsT4MMzSEhbyQ8u2IYIOexz0JxcJwReo
         nmZMiv1ED7yH2BRYO8Q+oNz1m8bSJ3S2dr2oicjpBNqIgZJIVLHQtUj507SVsfqav3eQ
         1dRw==
X-Gm-Message-State: AOAM531MrfL65P9UcYadhLrkspYw+1tqmKFLGvNm+o0dXZfLJmY4uobo
        GCyC+V578EXCNv11BzGRa94USgh//vVQJw==
X-Google-Smtp-Source: ABdhPJzyasq5+GxsaW6gkPOqmsNb3T8mOheJdhD/RMblUnfiCzJom7Xl6iPCR8qwWipRSHLWkULvkw==
X-Received: by 2002:a05:6000:114a:: with SMTP id d10mr1439930wrx.7.1624470522252;
        Wed, 23 Jun 2021 10:48:42 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id x25sm6678281wmj.23.2021.06.23.10.48.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 10:48:41 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 18/25] progress.c: emit progress on first signal, show "stalled"
Date:   Wed, 23 Jun 2021 19:48:18 +0200
Message-Id: <patch-18.25-e21fc66623f-20210623T155626Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.599.g3967b4fa4ac
In-Reply-To: <cover-00.25-00000000000-20210623T155626Z-avarab@gmail.com>
References: <YNKWsTsQgB2Ijxu7@nand.local> <cover-00.25-00000000000-20210623T155626Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ever since the progress.c code was added in 96a02f8f6d2 (common
progress display support, 2007-04-18) we have been driven purely by
calls to the display() function (via the public display_progress()),
or via stop_progress(). Even though we got a signal and invoked
progress_interval() that function would not actually emit progress
output for us.

Thus in cases like "git gc" we don't emit any "Enumerating Objects"
output until we get past the setup code, and start enumerating
objects, we'll now (at least on my laptop) show output earlier, and
emit a "stalled" message before we start the count.

But more generally, this is a first step towards never showing a
hanging progress bar from the user's perspective. If we're truly
taking a very long time with one item we can show some spinner that we
update every time we get a signal. We don't right now, and only
special-case the most common case of hanging before we get to the
first item.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 progress.c                  |  7 +++++
 t/t0500-progress-display.sh | 63 ++++++++++++++++++++++++++++++++++---
 2 files changed, 66 insertions(+), 4 deletions(-)

diff --git a/progress.c b/progress.c
index 6c4038df791..35847d3a7f2 100644
--- a/progress.c
+++ b/progress.c
@@ -255,6 +255,13 @@ void display_progress(struct progress *progress, uint64_t n)
 static void progress_interval(int signum)
 {
 	progress_update = 1;
+
+	if (global_progress->last_value != -1)
+		return;
+
+	display(global_progress, 0, _(", stalled."), 0);
+	progress_update = 1;
+	return;
 }
 
 void test_progress_force_update(void)
diff --git a/t/t0500-progress-display.sh b/t/t0500-progress-display.sh
index 883e044fe64..bc458cfc28b 100755
--- a/t/t0500-progress-display.sh
+++ b/t/t0500-progress-display.sh
@@ -15,7 +15,8 @@ test_expect_success 'setup COLUMNS' '
 
 test_expect_success 'simple progress display' '
 	cat >expect <<-\EOF &&
-	Working hard: 1<CR>
+	Working hard: 0, stalled.<CR>
+	Working hard: 1          <CR>
 	Working hard: 2<CR>
 	Working hard: 5<CR>
 	Working hard: 5, done.
@@ -60,6 +61,57 @@ test_expect_success 'progress display with total' '
 	test_cmp expect out
 '
 
+test_expect_success 'stalled progress display' '
+	cat >expect <<-\EOF &&
+	Working hard:   0% (0/3), stalled.<CR>
+	Working hard:  33% (1/3)          <CR>
+	Working hard:  66% (2/3)<CR>
+	Working hard: 100% (3/3)<CR>
+	Working hard: 100% (3/3), done.
+	EOF
+
+	cat >in <<-\EOF &&
+	start 3
+	signal
+	signal
+	signal
+	progress 1
+	signal
+	update
+	signal
+	progress 2
+	update
+	progress 3
+	stop
+	EOF
+	STALLED=1 test-tool progress <in 2>stderr &&
+
+	show_cr <stderr >out &&
+	test_cmp expect out
+'
+
+test_expect_success 'progress display breaks long lines #0, stalled' '
+	sed -e "s/Z$//" >expect <<\EOF &&
+Working hard.......2.........3.........4.........5.........6.........7:
+    0% (0/100), stalled.<CR>
+    1% (1/100)          <CR>
+   50% (50/100)<CR>
+   50% (50/100), done.
+EOF
+
+	cat >in <<-\EOF &&
+	start 100 Working hard.......2.........3.........4.........5.........6.........7
+	signal
+	progress 1
+	progress 50
+	stop
+	EOF
+	test-tool progress <in 2>stderr &&
+
+	show_cr <stderr >out &&
+	test_cmp expect out
+'
+
 test_expect_success 'progress display breaks long lines #1' '
 	sed -e "s/Z$//" >expect <<\EOF &&
 Working hard.......2.........3.........4.........5.........6:   0% (100/100000)<CR>
@@ -183,7 +235,8 @@ test_expect_success 'progress shortens - crazy caller' '
 
 test_expect_success 'progress display with throughput' '
 	cat >expect <<-\EOF &&
-	Working hard: 10<CR>
+	Working hard: 0, stalled.<CR>
+	Working hard: 10         <CR>
 	Working hard: 20, 200.00 KiB | 100.00 KiB/s<CR>
 	Working hard: 30, 300.00 KiB | 100.00 KiB/s<CR>
 	Working hard: 40, 400.00 KiB | 100.00 KiB/s<CR>
@@ -241,7 +294,8 @@ test_expect_success 'progress display with throughput and total' '
 
 test_expect_success 'cover up after throughput shortens' '
 	cat >expect <<-\EOF &&
-	Working hard: 1<CR>
+	Working hard: 0, stalled.<CR>
+	Working hard: 1          <CR>
 	Working hard: 2, 800.00 KiB | 400.00 KiB/s<CR>
 	Working hard: 3, 1.17 MiB | 400.00 KiB/s  <CR>
 	Working hard: 4, 1.56 MiB | 400.00 KiB/s<CR>
@@ -272,7 +326,8 @@ test_expect_success 'cover up after throughput shortens' '
 
 test_expect_success 'cover up after throughput shortens a lot' '
 	cat >expect <<-\EOF &&
-	Working hard: 1<CR>
+	Working hard: 0, stalled.<CR>
+	Working hard: 1          <CR>
 	Working hard: 2, 1000.00 KiB | 1000.00 KiB/s<CR>
 	Working hard: 3, 3.00 MiB | 1.50 MiB/s      <CR>
 	Working hard: 3, 3.00 MiB | 1024.00 KiB/s, done.
-- 
2.32.0.599.g3967b4fa4ac

