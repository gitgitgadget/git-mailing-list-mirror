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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91644C48BE5
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 17:48:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76E83611C1
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 17:48:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbhFWRu6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Jun 2021 13:50:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbhFWRuu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jun 2021 13:50:50 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF751C061756
        for <git@vger.kernel.org>; Wed, 23 Jun 2021 10:48:32 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id l12so2857357wrt.3
        for <git@vger.kernel.org>; Wed, 23 Jun 2021 10:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tD78MRBOxKvzL0clC6iqaURr6D8zaloqS1Zt4t0omDs=;
        b=ffcjjUej/pXumPpSHQW7l13isrhpy3aUZBV+MtSaB6d3Pr7MlzgfezGdbkNtlo2Qh9
         tZzaBAKsLdvhhrzrggc1UB4Elwt1+KpKmh0IxgXGn8fmV40dSjan6oc7YvWe+XcjCE2s
         EYTenIgkWxFX121pSk7ZQb3mkDh1LaewsSFzz3UHfcROlt+jdmXn1bYWMw7eCvm1yND7
         PeH9WgDU0osmqBxjePMe4GO4YiZhPSxiSXT+lmkyjZ1rr6S/oLHJKHJtDo2x+1LO9M7F
         XrYc1g2Zf/xZ1KjeVk7QfwpeissLNbgtneFYVI50/KKhJI52dEugEiHNsq6y9Nul7ND5
         LL2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tD78MRBOxKvzL0clC6iqaURr6D8zaloqS1Zt4t0omDs=;
        b=GD/zsSH12a0ep+6ybULckPnh4dRnr3K5ihPv7BLYl0kHOAXSdFCWWfqRtBI5QW5dBD
         kRlRzQEfY9W886IyVtgQj49ff2rh5IcwApA5PDCYgRTxYQ+iNgt9KlzeBePwXDtAJCW1
         ypm2isW6u6oEQ3EtppJ9aq8nQuak8IlX60nuYWtFfQFFWzLYuS9ht0ni34BklwlLsGow
         RJvgzWFqZJ3z+5qPzgIB4j0y55Eju3DTuw9HZZAQRX6h/RV3hI/oxX7qTQYDRBYBl7mz
         vKCg73i0s2VmCbJbVmhpm9baV1qCj0oCfPS0BospCf4piWMwPRqUH5QZr4WHxXPYHJ6c
         SbRw==
X-Gm-Message-State: AOAM533tP+n7jfukUAeSQwoIrv02L6RIziXyErUqosUAyhdJb/wFeZpf
        hPbQrXx20VAymqWyJyXT6eG+AcQtahm1ig==
X-Google-Smtp-Source: ABdhPJx0pG86EKU+/j6FKJwid3bOOZaV9MvN4PrfTQKhL94kk9/5uMZYivdfdiDub6S2ThLBR5lcAg==
X-Received: by 2002:adf:d216:: with SMTP id j22mr1523692wrh.2.1624470511327;
        Wed, 23 Jun 2021 10:48:31 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id x25sm6678281wmj.23.2021.06.23.10.48.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 10:48:30 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 03/25] progress.c tests: test some invalid usage
Date:   Wed, 23 Jun 2021 19:48:03 +0200
Message-Id: <patch-03.25-397291e0f65-20210623T155626Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.599.g3967b4fa4ac
In-Reply-To: <cover-00.25-00000000000-20210623T155626Z-avarab@gmail.com>
References: <YNKWsTsQgB2Ijxu7@nand.local> <cover-00.25-00000000000-20210623T155626Z-avarab@gmail.com>
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
index ce6c3434673..50eced31f03 100755
--- a/t/t0500-progress-display.sh
+++ b/t/t0500-progress-display.sh
@@ -328,4 +328,37 @@ test_expect_success 'progress generates traces' '
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
2.32.0.599.g3967b4fa4ac

