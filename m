Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07A23C433F5
	for <git@archiver.kernel.org>; Thu,  3 Feb 2022 21:40:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243733AbiBCVkn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Feb 2022 16:40:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354612AbiBCVkb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Feb 2022 16:40:31 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E269C061401
        for <git@vger.kernel.org>; Thu,  3 Feb 2022 13:40:30 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id n8so3100737wmk.3
        for <git@vger.kernel.org>; Thu, 03 Feb 2022 13:40:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nOWIhTHlYqFSATUkwpcKEdTA1tXltlnMcMbJPoO6Fr8=;
        b=OanROUbC2hb8dAP3fvrRDKMASMMhL3r1GE3KP6y88d8hKSQkRezZZ4u6XIGOGJiIpk
         DC4tbhmb6J+65uZ4LhK0Z0mXt7BAGQqypw9lZNh2j3jeQaZo9N8M92/LldVeeWp30o/6
         o1Mg5/h/X1/gbooyLuS5msXHAnXnDeFi3sz5fuSvBK+qeZ7s49S6L6IWkMhZHyVtH4zx
         GLTAvZe/32pcbYTDA1BW+0Jyb742xJyDV12e/Vt/ONK+1zFGZAOkSarvs0OOGO87j1SL
         4s0EDwWddtH3+OlhbOAU1HcUTO8bnzJXStBgRkpozK6mSj6gps5/B+qm6Vm5BEx5foDF
         gVWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nOWIhTHlYqFSATUkwpcKEdTA1tXltlnMcMbJPoO6Fr8=;
        b=ksxRRAP9dXUkgBiWIT3WL0l5O3vOOa+2nQKr4qE2VDcofniDI7wq5HVr9gYR/Wl6Dt
         QUPZvKxtQtbfNM66yXi9d0Et/OtIDorAeiK613/WU8Fr0GssV3mYsaOVjA+/M+0vkJj+
         XztngYRh5qYnV7Zdrj0TmTcn3LPHMgCWS0KftchEa0xwjeK2OxNo2E/XXkq4Wu6RO9Mf
         zxeHSuaYtT0QoOQ+Zvj+Qf55hnIUWtd8JT6MfvrvwHLd3roJ/HAS7Mlm23cM+NHDC3Ls
         ipFEi0IHQCpWYnLOwDtutsxBBRcmOdvPh8U/y/Ynh618HCFKqyYJrz0vhHhZ1ura60pX
         Hqmg==
X-Gm-Message-State: AOAM531MO+/QAekZECZFUYgn+bekPEhS7syf0edNAdQ8Mi+QYLTrJz5d
        lJCuSaEba8esupMfBIIMXAdU+R/BpeCnBA==
X-Google-Smtp-Source: ABdhPJxBIy06+B192XGuVq5qDVHEGKy7/S4LfeAWSQugYPQPrUTCpT6iXhj5blh7MUps+kpoTZ7V0g==
X-Received: by 2002:a05:600c:4341:: with SMTP id r1mr12164103wme.99.1643924428634;
        Thu, 03 Feb 2022 13:40:28 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i13sm10637wrf.3.2022.02.03.13.40.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 13:40:27 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v9 4/9] progress.c tests: test some invalid usage
Date:   Thu,  3 Feb 2022 22:40:14 +0100
Message-Id: <patch-v9-4.9-965d4ba7b54-20220203T213350Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.939.g42bf83caa3d
In-Reply-To: <cover-v9-0.9-00000000000-20220203T213350Z-avarab@gmail.com>
References: <cover-v6-0.8-00000000000-20211102T122507Z-avarab@gmail.com> <cover-v9-0.9-00000000000-20220203T213350Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Test what happens when we "stop" without a "start", omit the "stop"
after a "start", or start two concurrent progress bars. This
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
 t/t0500-progress-display.sh | 50 +++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/t/t0500-progress-display.sh b/t/t0500-progress-display.sh
index 27ab4218b01..1eb3a8306ba 100755
--- a/t/t0500-progress-display.sh
+++ b/t/t0500-progress-display.sh
@@ -325,4 +325,54 @@ test_expect_success 'progress generates traces' '
 	grep "\"key\":\"total_bytes\",\"value\":\"409600\"" trace.event
 '
 
+test_expect_success 'progress generates traces: stop / start' '
+	cat >in <<-\EOF &&
+	start 0
+	stop
+	EOF
+
+	GIT_TRACE2_EVENT="$PWD/trace-startstop.event" test-tool progress \
+		<in 2>stderr &&
+	test_region progress "Working hard" trace-startstop.event
+'
+
+test_expect_success 'progress generates traces: start without stop' '
+	cat >in <<-\EOF &&
+	start 0
+	EOF
+
+	GIT_TRACE2_EVENT="$PWD/trace-start.event" \
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
+	GIT_TRACE2_EVENT="$PWD/trace-stop.event" test-tool progress \
+		<in 2>stderr &&
+	! grep region_enter.*progress trace-stop.event &&
+	! grep region_leave.*progress trace-stop.event
+'
+
+test_expect_success 'progress generates traces: start with active progress bar (no stops)' '
+	cat >in <<-\EOF &&
+	start 0 One
+	start 0 Two
+	EOF
+
+	GIT_TRACE2_EVENT="$PWD/trace-2start.event" \
+	LSAN_OPTIONS=detect_leaks=0 \
+	test-tool progress \
+		<in 2>stderr &&
+	grep region_enter.*progress.*One trace-2start.event &&
+	grep region_enter.*progress.*Two trace-2start.event &&
+	! grep region_leave trace-2start.event
+'
+
 test_done
-- 
2.35.1.939.g42bf83caa3d

