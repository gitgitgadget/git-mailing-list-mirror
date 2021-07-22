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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D959DC6377D
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 12:55:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC5B56137D
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 12:55:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232042AbhGVMOk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Jul 2021 08:14:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231965AbhGVMOi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jul 2021 08:14:38 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F05AFC061575
        for <git@vger.kernel.org>; Thu, 22 Jul 2021 05:55:12 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id l7so5830962wrv.7
        for <git@vger.kernel.org>; Thu, 22 Jul 2021 05:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kk/3xkfv7KDZcog8KY7lY+9twPmyj1guz2egAszznhU=;
        b=Qq+6ic6BrYvGcAC6Fvrh5T0azoL6KcP1sTsDXo758o7z5PXjlsRQrg0mZpkU6hGsE5
         3R4tHhBKkhbxNEaa5Y/q8C0L9Cy9P4rXgghqfL9Ln2FcjFTtRdEZPSJmsgAIQNcofDpH
         TvFPJF2DJaghwXO02XROkqvZSGWsdvsQjlEbcZwY6YqCYaRAclBI3BGZ+4VLKvCfHrNb
         v5GBFuj6WRvUW9XgC3AQGwqMK3cSP7VXTegJi5K7mHQjWdPi3Mc1SboTPxC3sAq5VzaM
         I4SguztwqgVViN5Hj9O0mXNP1balXKdFA9d2b6B06Dq7Fz8Ut0cBK90vdxMKhf5wxshX
         1Tlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kk/3xkfv7KDZcog8KY7lY+9twPmyj1guz2egAszznhU=;
        b=QP8/fxzdByKq9nkK0AiBOC+2X0AoQ8CUeCM1e1Z9S1PG0YUvgq6+F9fRqmkJ7/3xTI
         8YhhSoaoLihd8dnc/u3J71Y4lOP9QTMv07pCLUjwuz3geLKNj4ItlcpfIpWdEtWCgWw5
         vATVtQYH12kfr1Q1aKZulh1HLxqkdrZfLqmHtCk8jk6En3ezQjHYiD8bQYpgl/r1cgyh
         ZgLboOotQWJe/v+dQifFyYi3/o6yp74iT2Z3/eAltYG/5BB6hSes+WU+fPDNmh7nTund
         KyBNdt8l9bSHQsN9LLJeeVb3X3jazCyVUAfbBwuo6eQp2tkfiL4Z/XshDlmTvUNZGPP7
         SYKA==
X-Gm-Message-State: AOAM531LG/2LLLdYAcInQB9ySu+2gwBxWfS/OLQpzicM7jEN947nQcaO
        hIOyQA0hql9kxnWLg1OXJbXYIIbiS4YLOg==
X-Google-Smtp-Source: ABdhPJy+f47SVEmHT1Pd+K2HO/Md2XtaV8NGs0bBHItSenjC8bseqAXPTudr6YxLEY7+iyD0F5sVgA==
X-Received: by 2002:a5d:608c:: with SMTP id w12mr24974676wrt.53.1626958511315;
        Thu, 22 Jul 2021 05:55:11 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id g3sm29937483wru.95.2021.07.22.05.55.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jul 2021 05:55:10 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/8] progress.c tests: test some invalid usage
Date:   Thu, 22 Jul 2021 14:55:00 +0200
Message-Id: <patch-2.8-2dc0d255c8-20210722T125012Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.957.gd9e39d72fe6
In-Reply-To: <cover-0.8-0000000000-20210722T125012Z-avarab@gmail.com>
References: <20210620200303.2328957-1-szeder.dev@gmail.com> <cover-0.8-0000000000-20210722T125012Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Test what happens when we "stop" without a "start", omit the "stop"
after a "start", or try to start two concurrent progress bars. This
extends the trace2 tests added in 98a13647408 (trace2: log progress
time and throughput, 2020-05-12).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t0500-progress-display.sh | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/t/t0500-progress-display.sh b/t/t0500-progress-display.sh
index ca96ac1fa5..ffa819ca1d 100755
--- a/t/t0500-progress-display.sh
+++ b/t/t0500-progress-display.sh
@@ -323,4 +323,37 @@ test_expect_success 'progress generates traces' '
 	grep "\"key\":\"total_bytes\",\"value\":\"409600\"" trace.event
 '
 
+test_expect_success 'progress generates traces: stop / start' '
+	cat >in <<-\EOF &&
+	start
+	stop
+	EOF
+
+	GIT_TRACE2_EVENT="$(pwd)/trace-startstop.event" test-tool progress \
+		<in 2>stderr &&
+	test_region progress "Working hard" trace-startstop.event
+'
+
+test_expect_success 'progress generates traces: start without stop' '
+	cat >in <<-\EOF &&
+	start
+	EOF
+
+	GIT_TRACE2_EVENT="$(pwd)/trace-start.event" test-tool progress \
+		<in 2>stderr &&
+	grep region_enter.*progress trace-start.event &&
+	! grep region_leave.*progress trace-start.event
+'
+
+test_expect_success 'progress generates traces: stop without start' '
+	cat >in <<-\EOF &&
+	stop
+	EOF
+
+	GIT_TRACE2_EVENT="$(pwd)/trace-stop.event" test-tool progress \
+		<in 2>stderr &&
+	! grep region_enter.*progress trace-stop.event &&
+	! grep region_leave.*progress trace-stop.event
+'
+
 test_done
-- 
2.32.0.957.gd9e39d72fe6

