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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB9F9C48BE5
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 07:01:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93AFE600D3
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 07:01:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbhFUHDp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Jun 2021 03:03:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbhFUHDl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jun 2021 03:03:41 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 454B7C061756
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 00:01:27 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id l18-20020a1ced120000b029014c1adff1edso13006528wmh.4
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 00:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mlewV+UhZEKclgbh2toSnqBQ342/BxxP5B5mt6Qdlqo=;
        b=f9/5OVCpaeau2uy/enD3aqsuSMiugSWTR3GdCqqV3LH/d5wNq8U5yCr6tb72tGhRIn
         ViXwXT/aiF18bFsQI5LB+pZzq2q7rmwyD+4O3yIKrmLBlioXfXzC5r/F3ayWjmQ7jcoz
         Wbm5WzsZNhZ5n52Io1SZ5o8CA9siOdcacTygQUafD8x0lE7zXg/lHSrmQUfboQwoRsws
         /U8D0VqPLjftb49++D3d9okVZDMZN9Ad8CTc+a1OE3a2odcK15gGgHpv7esYIKzFLK7L
         ef/wegBQs6GOSls4EypnoxcfBt18nrlF6PcHDj1Yz1V1pLmGw5IxmHDUgu+smZgSavk+
         Yg5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mlewV+UhZEKclgbh2toSnqBQ342/BxxP5B5mt6Qdlqo=;
        b=dpPjO6YXtHx1Ep+Weu8FUn02GRCFYDSVn2bUdBDj0u1WpL7GscMgWYWO5ghASd+EiG
         +8EVNUYnpfdTZC/kWRBiKONCDm4tSECyhOAD9cEuLomMyGbY2TJ47Goo2eHH37GGtyxL
         BIZVtI1yPdyC2RxgtCBRsTvYF79tdAwiX42QnWSqQgk2FsNWPnosp2mp9USjAo8b1Xp3
         B8bwukumwLS3FCTClNKqXgW5Ww+6E0Wo1EULv6puwVq0LgUyKbgrY5DvcIE7mUe4dmx6
         iCjag6M/s60Vop2ag/5v9ckXkoEPeRRW8x5gRLq0Lo/FCduGYZcALu9DStKfpbMez9in
         EfPw==
X-Gm-Message-State: AOAM533FGrlogs7TG1H8lDNamDqpL4pjuqav5KG0IErDHBIuxEkAk6Rp
        kwVMkh2q14hsS1cb7CNUmQiUMd81EZo=
X-Google-Smtp-Source: ABdhPJzAwPLDbxo6IZljTPS3MPxUHJwra1lnbFPwxqabCeiPxpcIgsGg+kOiuxbuhDwffKpVpN7MYw==
X-Received: by 2002:a7b:ca58:: with SMTP id m24mr10112172wml.155.1624258885706;
        Mon, 21 Jun 2021 00:01:25 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f14sm17822911wmq.10.2021.06.21.00.01.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 00:01:25 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] progress.c tests: fix breakage with COLUMNS != 80
Date:   Mon, 21 Jun 2021 09:01:23 +0200
Message-Id: <patch-1.1-cba5d88ca35-20210621T070114Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.595.g55105f1e212
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The tests added in 2bb74b53a49 (Test the progress display, 2019-09-16)
broke under anything except COLUMNS=80, i.e. when running them under
the "-v" mode under a differently sized terminal.

Let's set the expected number of COLUMNS at the start of the test to
fix that bug. It's handy not do do this in test-progress.c itself, in
case we'd like to test for a different number of COLUMNS, either
manually or in a future test.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t0500-progress-display.sh | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/t/t0500-progress-display.sh b/t/t0500-progress-display.sh
index 22058b503ac..66c092a0fe3 100755
--- a/t/t0500-progress-display.sh
+++ b/t/t0500-progress-display.sh
@@ -8,6 +8,11 @@ show_cr () {
 	tr '\015' Q | sed -e "s/Q/<CR>\\$LF/g"
 }
 
+test_expect_success 'setup COLUMNS' '
+	COLUMNS=80 &&
+	export COLUMNS
+'
+
 test_expect_success 'simple progress display' '
 	cat >expect <<-\EOF &&
 	Working hard: 1<CR>
-- 
2.32.0.595.g55105f1e212

