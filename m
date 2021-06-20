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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AF3DC48BDF
	for <git@archiver.kernel.org>; Sun, 20 Jun 2021 20:03:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F02B56117A
	for <git@archiver.kernel.org>; Sun, 20 Jun 2021 20:03:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbhFTUFn (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Jun 2021 16:05:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbhFTUFf (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Jun 2021 16:05:35 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 858D5C06175F
        for <git@vger.kernel.org>; Sun, 20 Jun 2021 13:03:19 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id hz1so2562940ejc.1
        for <git@vger.kernel.org>; Sun, 20 Jun 2021 13:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=62/Xd/ZzNu8TpHQR8YHzFTR2WvKXoIJlKkBxgK0/R7M=;
        b=qCld8OK4W6Z948VH7Ef5EE33kpwyBbISNYsLwKydj/QTxCTbgTmGO9ZEDBM4vySOPy
         EMx5AoXMdsIstkVKy20tI433iQBxh+WprVolHif9624ACSwWK2tVoA2ldGuGKJg8tb23
         l2aTDh4dIgpSAEjEFxTtEQH7AG/eqBRiw9amfDjJPM9tN6QCOoPt2HDgWTgYeACWlPLP
         DrQmiQgjLjc9aNiih1wOAhKque+E96dUiqz7d63cA2V8S9GXJM82xUBhQNjJ7iYwNvPt
         86vs+GVx+EwIL3PoRpk64AQGSOFJaCmpE+jh2NCWBFD+RV2cjprJGVygOZmmn25ak3SY
         ZVxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=62/Xd/ZzNu8TpHQR8YHzFTR2WvKXoIJlKkBxgK0/R7M=;
        b=cGndV1xYiQcMijYpyjzcO/mvZdQfgjkrtDq1KXn64hg7lwxckiJv5CMrrxnD+cc/wu
         9leQBEw1S6Nce587m5LfgdDV3P6qkzTkBncPqyWUPlL2o6jAqHO2McwSng3GhTiRTxF3
         8asS2ltEgkS+IzrLHRZnrCzmU3PzgpMnIx8BfRDUYTorZFs1Kyex+ZgcMJa13RoaKDbB
         gTFakK6EOYNkgFdW9U8xhl2fafQnjLBIhGZ+bF73uiZNn/vENl0kZclhn9F7JJW9vk6P
         oEA0j6Qm4SaTjv9JO5XYlXda/GF26xIxvP6n6cTLYil+RU2P9SxSdbSkTk3HpaxjgPNT
         y5Lg==
X-Gm-Message-State: AOAM530quHLoUF/EUqGan+ZtnMUJOk5d36ExEt/1OQMBmKM0H5pxldlG
        zSLpVHAmuD4KBA0ICKhzt2yeb76JymI=
X-Google-Smtp-Source: ABdhPJxPyqlk8EIR++dmK+yZtL4MqGmDZ3zzt6mMyfQpGR6RnzqiG0DOdHHcaWfw2b/pZ8Nvya+E1w==
X-Received: by 2002:a17:906:ae99:: with SMTP id md25mr13086489ejb.14.1624219397986;
        Sun, 20 Jun 2021 13:03:17 -0700 (PDT)
Received: from localhost.localdomain (94-21-23-215.pool.digikabel.hu. [94.21.23.215])
        by smtp.gmail.com with ESMTPSA id cw10sm3893904ejb.62.2021.06.20.13.03.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Jun 2021 13:03:17 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 3/7] progress: catch backwards counting with GIT_TEST_CHECK_PROGRESS
Date:   Sun, 20 Jun 2021 22:02:59 +0200
Message-Id: <20210620200303.2328957-4-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.32.0.289.g44fbea0957
In-Reply-To: <20210620200303.2328957-1-szeder.dev@gmail.com>
References: <20210620200303.2328957-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We had to fix a buggy progress line recently, where the progress
counter counted backwards, see 8e118e8490 (pack-objects: update
"nr_seen" progress based on pack-reused count, 2021-04-11).

Extend GIT_TEST_CHECK_PROGRESS to catch these cases as well, i.e.
trigger a BUG() when the counter passed to display_progress() is
smaller than the previous value.

Note that we allow subsequent display_progress() calls with the same
counter value, because:

  - Strictly speaking, it's not wrong to do so.

  - Forbidding it might make the code calling display_progress() more
    complex; I suspect that would be the case with e.g. the "Updating
    index flags" progress line in 'unpack-trees.c', where the counter
    is increased in recursive function calls.

  - We would need to special case the internal display() call in
    stop_progress_msg(), because it uses the same counter value as the
    last display_progress() call, which would trigger this BUG().

't0500-progress-display.sh' countains a few tests that check how
shortened progress lines are covered up, and one of them ('progress
shortens - crazy caller') shortens the progress line by counting
backwards.  From now on that test would trigger this BUG(), so remove
it; the other test cases cover shortening progress lines sufficiently.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 progress.c                  |  6 ++++++
 t/t0500-progress-display.sh | 35 +++++++++++++----------------------
 2 files changed, 19 insertions(+), 22 deletions(-)

diff --git a/progress.c b/progress.c
index 549e8d1fe7..034d50cd6b 100644
--- a/progress.c
+++ b/progress.c
@@ -115,6 +115,12 @@ static void display(struct progress *progress, uint64_t n, const char *done)
 	int show_update = 0;
 	int last_count_len = counters_sb->len;
 
+	if (test_check_progress && progress->last_value != -1 &&
+	    n < progress->last_value)
+		BUG("progress \"%s\" counts backwards %"PRIuMAX" -> %"PRIuMAX,
+		    progress->title, (uintmax_t)progress->last_value,
+		    (uintmax_t)n);
+
 	progress->last_value = n;
 
 	if (progress->delay && (!progress_update || --progress->delay))
diff --git a/t/t0500-progress-display.sh b/t/t0500-progress-display.sh
index 641fa0964e..a73dd45153 100755
--- a/t/t0500-progress-display.sh
+++ b/t/t0500-progress-display.sh
@@ -153,28 +153,6 @@ EOF
 	test_cmp expect out
 '
 
-# Progress counter goes backwards, this should not happen in practice.
-test_expect_success 'progress shortens - crazy caller' '
-	cat >expect <<-\EOF &&
-	Working hard:  10% (100/1000)<CR>
-	Working hard:  20% (200/1000)<CR>
-	Working hard:   0% (1/1000)  <CR>
-	Working hard: 100% (1000/1000)<CR>
-	Working hard: 100% (1000/1000), done.
-	EOF
-
-	cat >in <<-\EOF &&
-	progress 100
-	progress 200
-	progress 1
-	progress 1000
-	EOF
-	test-tool progress --total=1000 "Working hard" <in 2>stderr &&
-
-	show_cr <stderr >out &&
-	test_cmp expect out
-'
-
 test_expect_success 'progress display with throughput' '
 	cat >expect <<-\EOF &&
 	Working hard: 10<CR>
@@ -324,13 +302,26 @@ test_expect_success 'GIT_TEST_CHECK_PROGRESS catches non-matching total' '
 	grep "BUG:.*total progress does not match" stderr
 '
 
+test_expect_success 'GIT_TEST_CHECK_PROGRESS catches backwards counting' '
+	cat >in <<-\EOF &&
+	progress 2
+	progress 1
+	EOF
+
+	test_must_fail env GIT_TEST_CHECK_PROGRESS=1 \
+		test-tool progress --total=3 "Working hard" <in 2>stderr &&
+	grep "BUG:.*counts backwards" stderr
+'
+
 test_expect_success 'tolerate bogus progress without GIT_TEST_CHECK_PROGRESS' '
 	cat >expect <<-\EOF &&
+	Working hard:  66% (2/3)<CR>
 	Working hard:  33% (1/3)<CR>
 	Working hard:  33% (1/3), done.
 	EOF
 
 	cat >in <<-\EOF &&
+	progress 2
 	progress 1
 	EOF
 	(
-- 
2.32.0.289.g44fbea0957

