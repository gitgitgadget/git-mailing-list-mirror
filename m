Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 491F0C433EF
	for <git@archiver.kernel.org>; Wed, 13 Oct 2021 22:28:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31A4B61163
	for <git@archiver.kernel.org>; Wed, 13 Oct 2021 22:28:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231162AbhJMWal (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Oct 2021 18:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230446AbhJMWah (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Oct 2021 18:30:37 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52A38C061570
        for <git@vger.kernel.org>; Wed, 13 Oct 2021 15:28:33 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id t2so13195534wrb.8
        for <git@vger.kernel.org>; Wed, 13 Oct 2021 15:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=obL6wYtLKpKX8U1DvI6zm9EhffbdHUjcFscbxnXSJH8=;
        b=ltRpX1Hbxj9+nORjRC3BFgMjLF+ekPSODaovS+i623sH96Tn9hb8XQRTGQ1GSiB3SO
         3JpNYF/rtnIyNQSG4/P370eywZqXxlaVmpLts4+9U1BGm259wmOLoh+l4fzojnTQjNLS
         xjHK1bS3Fk24AEOWMK6W+4BQmHoSUjtWTLctDUKfD8JfNZmAlWjcHOBjojFm9tLbMd3i
         sNdyB2gnMiIY9X5dlnSO5FjElybdVjeWPJg515i88zmqf3ifwdxkD9XxLVQ/zLqSVtq/
         v4R5pS8ZcTVtLcnose2Eqs8CES7aup0w21sTCJgTQe7cdtOdbrWitPlFcy57YcaY3Pnd
         FnGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=obL6wYtLKpKX8U1DvI6zm9EhffbdHUjcFscbxnXSJH8=;
        b=zraCOUrOwJdUsnpmq68DwaoH4UnNbT70NlTngjf+2vfPqFRZ2AqgKAPxp2Om9wHH4M
         NQvalc17KB0EsqIWF8qpWJohmTH8Azi2Qlcisqf8wJizD335AIYHVeHLsFJMbDPRFKAC
         hZe3HCLJcqjYYRQZXjRaLuW6X+27Vkc5M95n0N/nHHIA2mYGKZmcOk1kXxdADgnhgDy+
         Ia5uMdZvEQZmKHQNpDYDNaCRKzQlw6oLgeBpB7m7D/mLMfvBnaoMgiBll/t+fiBKOztt
         K91WhDs2uBMNPRQO+x7KzrsrbwrKI50LzsBWuZLdzQmFn6NL7MoTWeUi1tIjPKspn1Cf
         V8Aw==
X-Gm-Message-State: AOAM531+GJdhBcZKLglDgTelrhRb8YUrR4yeftfbFxsDW9n52uEputf2
        idKMG/S+P21Jfwl2FII6YYUi1pMkhDGjEQ==
X-Google-Smtp-Source: ABdhPJz5fW3Q/16yIvdrQ+wXS2t+SDfEJXpd45qAcnBliRg1jf4rcyeh0WtyESHed6o+NKnkfEGk/w==
X-Received: by 2002:a7b:cc0b:: with SMTP id f11mr15443802wmh.2.1634164111691;
        Wed, 13 Oct 2021 15:28:31 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l5sm736683wrq.77.2021.10.13.15.28.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 15:28:31 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Emily Shaffer <emilyshaffer@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 04/10] progress.c tests: test some invalid usage
Date:   Thu, 14 Oct 2021 00:28:20 +0200
Message-Id: <patch-v3-04.10-efc0ec360cc-20211013T222329Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1346.g48288c3c089
In-Reply-To: <cover-v3-00.10-00000000000-20211013T222329Z-avarab@gmail.com>
References: <cover-v2-0.8-00000000000-20210920T225701Z-avarab@gmail.com> <cover-v3-00.10-00000000000-20211013T222329Z-avarab@gmail.com>
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
2.33.1.1346.g48288c3c089

