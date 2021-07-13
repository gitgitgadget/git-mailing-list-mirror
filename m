Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42CFAC11F67
	for <git@archiver.kernel.org>; Tue, 13 Jul 2021 08:05:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28187606A5
	for <git@archiver.kernel.org>; Tue, 13 Jul 2021 08:05:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234617AbhGMIIW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Jul 2021 04:08:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234357AbhGMIIU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jul 2021 04:08:20 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EF50C0613DD
        for <git@vger.kernel.org>; Tue, 13 Jul 2021 01:05:29 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id m2so18218403wrq.2
        for <git@vger.kernel.org>; Tue, 13 Jul 2021 01:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rpuU+hkjgrosuGrPdHtiXP1P3pJ99yiJMY5kQ9aVvUs=;
        b=egUDd4DTj0FP/YEXuic+xaaianUfo27LZbpeEMi6cRUggbXR4984xHoOfMDeQyVFhx
         A5vZa++2PD6yEdhYzqsyx7y+e6xu+wKS5Mpd5qBU3zlbFKD9FDyUgEk+RKeB+HQs24Ur
         8PIr4iFMNPJ3RnSjdyw9c32y8nuTlERY01yPM+wce1UdkE/I3mW/ylSC2c2LexydsVh8
         rGTmCJroN/gcwDIwt7bJrg/y3V34hr8/iPOBYTLW2HSFtEGVFX4EKuIws7/WYurJWkXq
         YuIozvc8zdYx+TVbY08W35GUdZwQh6FTok01mLyGZruVb+Ocit2oh1qyu3fhCzMSmyd2
         pmZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rpuU+hkjgrosuGrPdHtiXP1P3pJ99yiJMY5kQ9aVvUs=;
        b=O29ffvaI1QtAGKnzXypNcuDQ3zgzuJRmD4tNxNCP7zkovhHgPZZChhRjBWu/sANfSO
         IGgV1v0yAfptSVrVkw5BAGg0j1R8Pah43vZa0VlRGSZupzVohiPZ3UbD6+4/LP8ne4gK
         925uh30Cke6BQSVtKUbl0a04ELCq44rl1B5hrxJ2Ui1WZYqrUNAvnclAIu8MlO4Cx1hq
         Jx/edz3aEDj0uCpSBysP13OaBKVI2wPpuTM+gUkf4X2ckJ1DiIFfaZulojvWDlxZMXyQ
         x0HJlFmFbvNEo6FkovKSjH4KckLceB9g+FYF6xdWUNs2ROpbjid5nUBgbPRJH6XZPllE
         sw3w==
X-Gm-Message-State: AOAM533yEACTZ/JA3B1ujVd8hdJeCwdpJ8c9NpM6/eT5kYc0IEfiosMX
        +1IwojR5CKfuqH0QOF4u3YeF3fPrLUrmGg==
X-Google-Smtp-Source: ABdhPJzS7q80EpR9kITASMes3uqS1T0ZkZtTv4mTa3ZLBM3WJ3bCNcZJMzoQD2Q3Qz0SIVErPjln1Q==
X-Received: by 2002:a05:6000:1841:: with SMTP id c1mr3825722wri.423.1626163527870;
        Tue, 13 Jul 2021 01:05:27 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id z11sm17156772wru.65.2021.07.13.01.05.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 01:05:27 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 5/6] advice.h: add missing __attribute__((format)) & fix usage
Date:   Tue, 13 Jul 2021 10:05:20 +0200
Message-Id: <patch-5.6-a001e851d2-20210713T080411Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0-dev
In-Reply-To: <cover-0.6-0000000000-20210713T080411Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20210710T084445Z-avarab@gmail.com> <cover-0.6-0000000000-20210713T080411Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add the missing __attribute__((format)) checking to
advise_if_enabled(). This revealed a trivial issue introduced in
b3b18d16213 (advice: revamp advise API, 2020-03-02). We treated the
argv[1] as a format string, but did not intend to do so. Let's use
"%s" and pass argv[1] as an argument instead.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 advice.h               | 1 +
 t/helper/test-advise.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/advice.h b/advice.h
index bd26c385d0..9f8ffc7354 100644
--- a/advice.h
+++ b/advice.h
@@ -90,6 +90,7 @@ int advice_enabled(enum advice_type type);
 /**
  * Checks the visibility of the advice before printing.
  */
+__attribute__((format (printf, 2, 3)))
 void advise_if_enabled(enum advice_type type, const char *advice, ...);
 
 int error_resolve_conflict(const char *me);
diff --git a/t/helper/test-advise.c b/t/helper/test-advise.c
index a7043df1d3..cb881139f7 100644
--- a/t/helper/test-advise.c
+++ b/t/helper/test-advise.c
@@ -16,7 +16,7 @@ int cmd__advise_if_enabled(int argc, const char **argv)
 	 * selected here and in t0018 where this command is being
 	 * executed.
 	 */
-	advise_if_enabled(ADVICE_NESTED_TAG, argv[1]);
+	advise_if_enabled(ADVICE_NESTED_TAG, "%s", argv[1]);
 
 	return 0;
 }
-- 
2.32.0-dev

