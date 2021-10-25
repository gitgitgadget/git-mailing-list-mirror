Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 117A6C433F5
	for <git@archiver.kernel.org>; Mon, 25 Oct 2021 11:25:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7C5261039
	for <git@archiver.kernel.org>; Mon, 25 Oct 2021 11:25:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233092AbhJYL1j (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Oct 2021 07:27:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233096AbhJYL1g (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Oct 2021 07:27:36 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC9A7C061243
        for <git@vger.kernel.org>; Mon, 25 Oct 2021 04:25:14 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 83-20020a1c0456000000b0032cb02544aaso870938wme.5
        for <git@vger.kernel.org>; Mon, 25 Oct 2021 04:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ADbg9X0OR2ynfZEOBez2fCy1svIgi27eg5SO/lLPkDA=;
        b=l2AXJavmQRFMDl95zozd+1/MmzAtrOjzJLXj/3dfkV0EYFw1uLfE6/WXrkSocnUUC5
         rCdyJGhZTJp5H4pIZwO/xqsVUgCyfS5O0APBQvEZdaCPj0GlyTXgZ1HYnnQXjJxiXeaR
         DD9n8Qe9ZR44a/cTahShPmSvZyqtLcbDgDIf9VUuWGNAWX7AjjW7mIhvTRC8p0yOSR9F
         mWE5Q+uGA3j6MLKQmV83bh4BOjEc/08addaJY4bTrBOv8PWIST94gR+cbe3QdNLqlaoo
         P3Jggh0gk+3EvgZTelyM3aDxITCF9RBcJqVXk4jG/+Rh7CVU6t7IkTRD8NUMvl68c1m9
         2izw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ADbg9X0OR2ynfZEOBez2fCy1svIgi27eg5SO/lLPkDA=;
        b=qrSylE6uyCrrHEXDpbnIjmmEEQjTy1941fiF1TqKz7lZCmVj7mAqjCy2BpvBZAAOIl
         P/qhRJkWxo0jdePZ0YksmBBDs7WuPkD/xDSpZtIRmM+Y8W0Y4Al4YiW+aipnDHQofmuD
         zXNxEKySlhDorDRmF7vK119aPzmccqyp8jDVc5Eyxo+AbPQ2Tkf4atRBnrmCvHqy1Ttm
         4w0dmA9E3F0QurVrHG3pM0duwPWkjXd1wbZvMCYIH+HzGMCEacCpHUFqvFPO9n5orXmg
         qbUr0J+mAtNVXBou2jfJ3BMujaZAF7aLddBRBSirnIj+A03Q3i663CLVgG4SKTPvJzdA
         1snA==
X-Gm-Message-State: AOAM532Q1GhZGVCoifVJgKKsMOyghTrGxh56V+0m9DWDq+iF+GLdq3E1
        /LIG+gqvS5glW4fcPsZsc8T48ytqK8JQxQ==
X-Google-Smtp-Source: ABdhPJzwW4QjUzqaJRz/y+5cS86O9GXqWVZFEwW6Gjj8EzaJ715DfiFUAZhZMYe4TKmKMOOybNo+9g==
X-Received: by 2002:a05:600c:2314:: with SMTP id 20mr11669583wmo.76.1635161113170;
        Mon, 25 Oct 2021 04:25:13 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l2sm19021993wmi.1.2021.10.25.04.25.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 04:25:12 -0700 (PDT)
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
Subject: [PATCH v4 4/8] progress.c tests: test some invalid usage
Date:   Mon, 25 Oct 2021 13:25:03 +0200
Message-Id: <patch-v4-4.8-474ce31f9d2-20211025T111915Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1510.ge5c82eefb93
In-Reply-To: <cover-v4-0.8-00000000000-20211025T111915Z-avarab@gmail.com>
References: <cover-v3-00.10-00000000000-20211013T222329Z-avarab@gmail.com> <cover-v4-0.8-00000000000-20211025T111915Z-avarab@gmail.com>
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

These tests are not merely testing the helper, but invalid API usage
that can happen if the progress.c API is misused.

The "without stop" test will leak under SANITIZE=leak, since this
buggy use of the API will leak memory. But let's not skip it entirely,
or use the "!SANITIZE_LEAK" prerequisite check as we'd do with tests
that we're skipping due to leaks we haven't fixed yet. Instead
annotate the specific command that should skip leak checking with
custom $LSAN_OPTIONS[1].

1. https://github.com/google/sanitizers/wiki/AddressSanitizerLeakSanitizer

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t0500-progress-display.sh | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/t/t0500-progress-display.sh b/t/t0500-progress-display.sh
index 27ab4218b01..59e9f226ea4 100755
--- a/t/t0500-progress-display.sh
+++ b/t/t0500-progress-display.sh
@@ -325,4 +325,39 @@ test_expect_success 'progress generates traces' '
 	grep "\"key\":\"total_bytes\",\"value\":\"409600\"" trace.event
 '
 
+test_expect_success 'progress generates traces: stop / start' '
+	cat >in <<-\EOF &&
+	start 0
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
+	start 0
+	EOF
+
+	GIT_TRACE2_EVENT="$(pwd)/trace-start.event" \
+	LSAN_OPTIONS=detect_leaks=0 \
+	test-tool progress \
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
2.33.1.1510.ge5c82eefb93

