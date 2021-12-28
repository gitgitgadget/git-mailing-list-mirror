Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29C8CC433FE
	for <git@archiver.kernel.org>; Tue, 28 Dec 2021 15:19:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235039AbhL1PTe (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Dec 2021 10:19:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234237AbhL1PT2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Dec 2021 10:19:28 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6A46C06173E
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 07:19:27 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id c66so11810351wma.5
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 07:19:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EBzC+Q+mUZTXUmuAsf2kQ2DszosjpfL5mFe1dsSkXbY=;
        b=ikO4jxLxq7EWrseegOX7GQRvRjrsCGm78j6R8I6xZQNkw6zQ1HC5E88IgOb+fw5Q6I
         0puACQVUgIgzqThzBRE/eYLJE8+ZON+kQOWwGo2CWjYySdP19M1Fo5kRiPFtI4TVXeWt
         w7bi3IKMco44uSjrMaHjidz2EG96Tk1mdr9kduNUYI9ERZxoLwyhPBrHTRJUE3JU6rJf
         pRfRVfEzZfyoGWZzEHvd28M43C+Au5EBnMtwH262UcPtK3WQjHNI3pqFPizpbM2GAjg+
         A0egzjlkhhRZtU1eDUZMI8wAEIJClVFOUmm/wfG1JKbNp7ileBsCZCt8MtLfGzrO/hZW
         0FOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EBzC+Q+mUZTXUmuAsf2kQ2DszosjpfL5mFe1dsSkXbY=;
        b=06z74LOBd4w+PK0yZbnjF8lYnaM7jV9NNATDexPODX71wbV8AlSagknypPGlhnLboX
         LUI/RoBEmqaTh5RFelbfJRuf7c95KsKwx00Apj3NqtG0d7DZQG4sClS/U+8LA1VMqzox
         k/WlRewGjsqtoMkhodxZHTeV9cIR192lpsbfDHQR1oht2pQPVtBX+HiUD9W68bJefMCf
         h9ZVXEJbQsbgRazcCHqpwDu2TTgj+M5HH25+EHEnvfGzvz25iXEI1aGXySbNUCDo2Bt+
         GTvEofd2Odu2h7sCLyE9VMxfKIl3LkphoaCT+gFj3We+Gwah/cxYAD7akhxmEQvkfH/Y
         dS6Q==
X-Gm-Message-State: AOAM532SsuxW9wEp9zDE/C9xpb+oKfx8bVbpMiE2Z1q6JXtvURAEF4rZ
        nv0t4lQNZkVmWkzFZUEZZMDwJut3aGzehTj4
X-Google-Smtp-Source: ABdhPJym4ahyRczn/7mDACC7cnD5TpY09eTaNldsXzjv/55nD4fL23ne5kR5qRmnObuUjFgAYYEaGg==
X-Received: by 2002:a05:600c:2186:: with SMTP id e6mr17413947wme.153.1640704766303;
        Tue, 28 Dec 2021 07:19:26 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id p11sm20491022wru.99.2021.12.28.07.19.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Dec 2021 07:19:25 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Johannes Altmanninger <aclopte@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v8 4/7] progress.c tests: test some invalid usage
Date:   Tue, 28 Dec 2021 16:19:00 +0100
Message-Id: <patch-v8-4.7-7c1b8b287c5-20211228T150728Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.1257.g2af47340c7b
In-Reply-To: <cover-v8-0.7-00000000000-20211228T150728Z-avarab@gmail.com>
References: <cover-v6-0.6-00000000000-20211228T143223Z-avarab@gmail.com> <cover-v8-0.7-00000000000-20211228T150728Z-avarab@gmail.com>
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
2.34.1.1257.g2af47340c7b

