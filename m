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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA3F2C4167B
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 02:21:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D57336134F
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 02:21:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347990AbhIUCWq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Sep 2021 22:22:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236929AbhIUBvx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Sep 2021 21:51:53 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1778C0386C3
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 16:09:40 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id t8so33999428wrq.4
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 16:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Jl93F6D2mfoyFx0Y28aThKOlb8mtcUJajLA2zpkbph8=;
        b=XJKnm6hhaXoO+CUcaDngOA7Rj8m7SKbPwK16sBi2OJQyPtXlQ1mPOjH0+opFgbsz4X
         e85AppEhl1ThutbvlzHqKDNtvKNXW9e+AZCzF4HXMkuVaMpN5tmUh6CPRwMZ/7CBdBYk
         FJBLIuAS0hEmnpnBjgyHzj3oRy2a3AODNyhMKLTho35NOOHrkBnqevAXnpaOsmqEhUei
         0P+VINogvOsQbeoM1OzZw4HTTMtKJPRhRE2Rwu/3H4B8siI6nwIVk/1HqhbobDa92zMU
         BqglWgupBGlpSKfJuHFQBQgBN3qpsjjyOeZSG+2BX4ILyxAJZ8JDHsRAWxeUldln0q8n
         avDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Jl93F6D2mfoyFx0Y28aThKOlb8mtcUJajLA2zpkbph8=;
        b=P0zRXNToszAK/GTBWOwo0fOA2toCCswN5oSzKGdzgMDevICQhcC6zlZW8y8v8ut2me
         PNYSWuqOldnq20k3hIxtXW7j/yEgRSUW6fwtmUPXbb1XffBFlVQCnmBxHhY8f4fWL9rD
         gGiAb3OK/7ZRdsC64XYkAM7Lp4VBG+/4FW7smrYIxFo6cId1dB0DhR7UKDYXnafk8fvw
         ht7x7nSBahNOP9zjPuEKCbzfa4mK9DgGrlwpgj1oGNi4an+RQbFnaiBcpCalnCglANCr
         LkYhKhe8q0jDuiSiCgLkM/Gi+aK7GR5irNl9ny7prMD2QvjNDO/y4IYWYUdykxypbx8x
         wIQA==
X-Gm-Message-State: AOAM530VL/guO2Nh3+Pk1qvYYFyc3keE2N24PAXxeEtEglSOHrAkM2IJ
        5Sb1W8syVS4pKbYBxBSjIKsoR0XdnniD2g==
X-Google-Smtp-Source: ABdhPJxAU36dPqjI3ve2bIbMa2H6RG10sEVY+x8qA1kucJz1ryqfjEEVlLkg6Rtm7Z/+nOyun5PK6A==
X-Received: by 2002:a1c:7ed3:: with SMTP id z202mr1347025wmc.152.1632179379328;
        Mon, 20 Sep 2021 16:09:39 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c8sm10409154wru.30.2021.09.20.16.09.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 16:09:38 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 2/8] progress.c tests: test some invalid usage
Date:   Tue, 21 Sep 2021 01:09:23 +0200
Message-Id: <patch-v2-2.8-7b1220b641e-20210920T225701Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1098.gf02a64c1a2d
In-Reply-To: <cover-v2-0.8-00000000000-20210920T225701Z-avarab@gmail.com>
References: <cover-0.8-0000000000-20210722T125012Z-avarab@gmail.com> <cover-v2-0.8-00000000000-20210920T225701Z-avarab@gmail.com>
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
index ca96ac1fa55..ffa819ca1db 100755
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
2.33.0.1098.gf02a64c1a2d

