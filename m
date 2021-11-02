Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DB82C433EF
	for <git@archiver.kernel.org>; Tue,  2 Nov 2021 12:27:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49B9660F24
	for <git@archiver.kernel.org>; Tue,  2 Nov 2021 12:27:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231267AbhKBMaP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Nov 2021 08:30:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230321AbhKBMaN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Nov 2021 08:30:13 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BFAFC061766
        for <git@vger.kernel.org>; Tue,  2 Nov 2021 05:27:38 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id t30so8190032wra.10
        for <git@vger.kernel.org>; Tue, 02 Nov 2021 05:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wivfjiON1dMNNN7ZvnB/kfbCmpVJdKNvBcImrkNxhig=;
        b=KsopsXAXMPdE5wxVy8uLRdJTkLp6AOr4wY5rip/ua8wlzyx0TpAE1SiWvqi+WrTu7b
         rzXn9sdD5cnt1812egd1ID3xpp4E9DT8r7ZY6zoov8aixc97FilpdMtaGowtQmbnzfnN
         BGV8jX9sAOu6YgDk+TLwMljD6y/RBhy9W9UbPyiWm4F2OO/QNaBZTTLnc9503eghKmgC
         wo+frpJqHNA8lgjgsfNIEC45aCqofR/hGfyH8I9/9hkbFGtwMk+XNEXlwedsxOtQN7S3
         hAqf3QaHVcVtzK6CaZ7c17R02vFnjLeNCNWeadLycw/CM54/YK8rxOF4ERjpAuhR6DD5
         5Kzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wivfjiON1dMNNN7ZvnB/kfbCmpVJdKNvBcImrkNxhig=;
        b=2L0D9MdKS6KwsICBUou5Z6ZE9kmCUec1jrCluLG+Ii1BPAVpyFarEvcgx2cxTE6kDG
         mqu6Ehm+s9I1DxKpR+aOnlJzf0naTMlhaQSKROcTP2lrBGX/Ms8UXdoznyaKu5HfMBbx
         +2rv1dhUyFQEuqeD9CZJR17C5zzqwNOntvhnJF4d01xNe8qODPVRv749LSvtGydwNiS7
         giC1rGjCgNghiaflYukuvvNJXBY8ka2IO3QLyYj9o3ERlQVF5oYg9Mi51gBsTtNMgWEW
         kASofMuUk0pD33k+h89AjO/Cjg+ilD3AvKWFh6IG0drORrQBP+D4uami90dUYWJoU+tO
         b0MA==
X-Gm-Message-State: AOAM533t1qE/HtnvgsVtRuM8bSWPtVLx4ZGerfET/kw49uf0cgnnXSRb
        gzal9aKvEETuwStYXZcK0nWjOMueWmAyWw==
X-Google-Smtp-Source: ABdhPJwC+PSou88Srh0p8pNYy7M/TYcjK+s9dGnC9hOTdUWMi4bBO2m5y0gj0PamYvUxEkSFoXQ7wA==
X-Received: by 2002:adf:a1d4:: with SMTP id v20mr4603080wrv.190.1635856056619;
        Tue, 02 Nov 2021 05:27:36 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q84sm3332236wme.3.2021.11.02.05.27.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Nov 2021 05:27:35 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Emily Shaffer <emilyshaffer@google.com>,
        Taylor Blau <me@ttaylorr.com>, Johannes Sixt <j6t@kdbg.org>,
        Carlo Arenas <carenas@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v6 4/8] progress.c tests: test some invalid usage
Date:   Tue,  2 Nov 2021 13:27:26 +0100
Message-Id: <patch-v6-4.8-7557975a122-20211102T122507Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1570.g069344fdd45
In-Reply-To: <cover-v6-0.8-00000000000-20211102T122507Z-avarab@gmail.com>
References: <cover-v5-0.8-00000000000-20211101T190630Z-avarab@gmail.com> <cover-v6-0.8-00000000000-20211102T122507Z-avarab@gmail.com>
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
2.33.1.1570.g069344fdd45

