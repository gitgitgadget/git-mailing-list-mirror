Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F8E8C4332F
	for <git@archiver.kernel.org>; Fri, 17 Dec 2021 04:25:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231796AbhLQEZb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Dec 2021 23:25:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231634AbhLQEZ1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Dec 2021 23:25:27 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7C38C06173F
        for <git@vger.kernel.org>; Thu, 16 Dec 2021 20:25:26 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id i12so760086wmq.4
        for <git@vger.kernel.org>; Thu, 16 Dec 2021 20:25:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uxGBkhC2ruqacI1Nb/VTJJM9cUs7c1A9zQhg89yTDTs=;
        b=M6bRyleBqMlNYT+7drJICLdXxhXWGRgShoBffsJUz0S8ZknvtHRiKU7f2+aJKYrJfe
         sjw1LgZCsy/NUYmalAdmrmwqm6eWeZJJRx0P7RQXkXmRkkpUyQ7ZDJGzKIctkC71/vc4
         0MEK0nwW3wbSTm4yhGyFSlIgzE4EfZ5U+XWpBYqtMxk6f3ENdb6RrqJ39M1CNL3ma6P0
         skpXVRIoyMyyY78IGGPB0qGLl+DG9LDCKXlhsQ6MhdrYu/4r/buNH+pNXwKKRpUj4peS
         iNXoqvkJ08W5L6QLlLiszCa1q2mJHvw9kjx+WjQAboRs5u8b526Munm9MZofIAKe5+6j
         BQTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uxGBkhC2ruqacI1Nb/VTJJM9cUs7c1A9zQhg89yTDTs=;
        b=d5rUJ0gU4L8KstHoRhyEvhmm6KoStuiP5TvRM4AGnxy8u6i8PlPZB2RGSSmY75o5mB
         sJplEog5BGkC74sJKB2s3Ky0HvbOxP409SUlOF01jwXZ+y6LNc+aHtKnimu5jFDJX7m8
         cp+7DrqADm1knoMTVI7CsQYA1ZCfgAVpj3+KxiEzjs7nan1vb9EBDFwTCS3WVbN93msd
         EYXI1DGyuovE7G2I7+fEc5bHTNa0M6NMEk8Vry403sN1lqQVzE4Wpy91h/ShZC+Qr4DI
         Qy/m5VeNbWP/ASitICCoUns5NQargBq6dMufga7K38/AaNbfP83ualOfbsa7Ice96/pm
         Gfkw==
X-Gm-Message-State: AOAM532xhLb5Ayq0TuUR5gLHNZak6y+VuHF77qV+OCR4nDSWknDk2GSP
        GPaI0T3864O5gL63jTp7IBnjbm7U/FNk8w==
X-Google-Smtp-Source: ABdhPJw7C/nZEa1bEYTI+YLOQUfJDV9wmI0cOIKDNEg4nmKCkGS72eWQy4JRKk7N4jxvFJa/LxD/Iw==
X-Received: by 2002:a7b:c452:: with SMTP id l18mr915985wmi.46.1639715125265;
        Thu, 16 Dec 2021 20:25:25 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o64sm6325634wme.28.2021.12.16.20.25.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 20:25:24 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v7 4/7] progress.c tests: test some invalid usage
Date:   Fri, 17 Dec 2021 05:24:59 +0100
Message-Id: <patch-v7-4.7-40e446da277-20211217T041945Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.1119.g7a3fc8778ee
In-Reply-To: <cover-v7-0.7-00000000000-20211217T041945Z-avarab@gmail.com>
References: <cover-v7-0.7-00000000000-20211217T041945Z-avarab@gmail.com>
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
2.34.1.1119.g7a3fc8778ee

