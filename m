Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73C10C433EF
	for <git@archiver.kernel.org>; Mon,  1 Nov 2021 19:09:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5646D60F70
	for <git@archiver.kernel.org>; Mon,  1 Nov 2021 19:09:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232532AbhKATMC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Nov 2021 15:12:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232469AbhKATL4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Nov 2021 15:11:56 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0554FC061714
        for <git@vger.kernel.org>; Mon,  1 Nov 2021 12:09:23 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id d13so29542550wrf.11
        for <git@vger.kernel.org>; Mon, 01 Nov 2021 12:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wivfjiON1dMNNN7ZvnB/kfbCmpVJdKNvBcImrkNxhig=;
        b=eg+PmqqqQCiDkmSqjs5Lr/h0FmtOrS5/aVHq4eu0FMJGssDCJ3K77bxVrwf/wyMjRx
         GIkQyuxO9gTyOCMagHkbuYAeIb76yEa+Ap4ATetnyQnyOmA6PR3cRZoCeOLeQQkrJhn0
         +hVFpAanJcC6WPJivtkrEIQTRbybbjSvIOYRZ5vHMqj5qB1cTG8A2SQpmTnr0+TXqRsf
         vhWcAdf6Agc+ztMNocr6UB37U6ld0JQNzHNPitJ0mqFnxH2ZUZT5Ev3Od9P4T8FaWzya
         VKoVpQ+dv0mjLmzkooiNfx88El/IcxquqgxzmgnCuArRnug51zSo4ODTXftKU9ee9J7E
         gPpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wivfjiON1dMNNN7ZvnB/kfbCmpVJdKNvBcImrkNxhig=;
        b=KBgxdqhdiluHo/7GkWyMW9eB7VQzCv6EPPZIrmKKayXtEJwtcjOLLHNIy5Ry9gBVaq
         v4jUpempYEwY2IuUI4mWINsjvvdQYlW/f85Fn1hi5v6ga87/fJOvAs15U53T9XLo80cy
         aZKuTvxxDmf+MyhyfkQuOqL8SiQZck9uDombROmiJX4finGqQ+8RxjOsMlK9iGT6pHH8
         XfTLX10isCnQ7i4JScqfgRamCIDa039/vIrFt9i1czXXhF2WcxQgqZBYJuMU2nDEnU1k
         Iqkm1edTVitao9vRYyEoS8uMmkwKrHq+pVSD7j443tQ88VNp3UvJD7HSa19OV3O9845D
         cWXg==
X-Gm-Message-State: AOAM5313mqJSKZohZ5ySqPpB1LLKhDPIVvZlK368pkNt4ZB8WlHWeLal
        INQw568VHL4AnQqDo36XKaY58oaJivCsZmJ/
X-Google-Smtp-Source: ABdhPJxufkNf4Bh2ltC8VB9OLkY1PHpRguu8XAo+7ITQdjBaCITNrEex7bqUnPe5b61HpcE33PMgOQ==
X-Received: by 2002:adf:9bdb:: with SMTP id e27mr38138161wrc.417.1635793761389;
        Mon, 01 Nov 2021 12:09:21 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id p12sm4337211wro.33.2021.11.01.12.09.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Nov 2021 12:09:20 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Emily Shaffer <emilyshaffer@google.com>,
        Taylor Blau <me@ttaylorr.com>, Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 4/8] progress.c tests: test some invalid usage
Date:   Mon,  1 Nov 2021 20:09:10 +0100
Message-Id: <patch-v5-4.8-9bcc8cfc9d2-20211101T190630Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1570.g069344fdd45
In-Reply-To: <cover-v5-0.8-00000000000-20211101T190630Z-avarab@gmail.com>
References: <cover-v4-0.8-00000000000-20211025T111915Z-avarab@gmail.com> <cover-v5-0.8-00000000000-20211101T190630Z-avarab@gmail.com>
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

