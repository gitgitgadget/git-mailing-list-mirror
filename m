Return-Path: <SRS0=LF8V=6I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 243C8C54FD0
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 15:12:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0396320706
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 15:12:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Acjn2iJe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728019AbgDXPMs (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Apr 2020 11:12:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726849AbgDXPMq (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 24 Apr 2020 11:12:46 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E057DC09B045
        for <git@vger.kernel.org>; Fri, 24 Apr 2020 08:12:46 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id o185so4772371pgo.3
        for <git@vger.kernel.org>; Fri, 24 Apr 2020 08:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tcH94ZFcCTHG09/dto/Vv8Bt0IloAwuj36FNn2js+xU=;
        b=Acjn2iJe14x0Y2AxGxzbOYI0e5XhOkhyomtQgu2M79WsI1gEn1/GyXa/e/tUx8/q1d
         /Vn0GVFDquH7uEQWLpSeC/ic7XVu80JQsrTTv86/i/SrVQUGhOEvOkMC7TJ2j+/d9bNZ
         twE/CbixOynExJd791yW1JtLsMTvyYB3X7SUPls1lKB5GyVPlD9EKH+8Wypjt/NcQwB7
         ozKc9c5uWw9k5NqvPomkf7nOF7h5/7deOcNLEPMILsTOD6nrEQ8eukhLxbMlLAMbLrEW
         2IxXfNWnefE9fxf2/N0TlQlzIepX7Zc9F/8s6HCYD4vFppW6uUzLHtSoiLzhL/YoBOy4
         eemg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tcH94ZFcCTHG09/dto/Vv8Bt0IloAwuj36FNn2js+xU=;
        b=mfSmNOpEmeztAhSATl3miomNE12po5mAjj1I6/U0XyTMlf0rG3q341OwVdaUJqVBwl
         nLXM7IL6FxugL7eoPH4ap9MM16zCYISlHIljKiBARzuiNJUMRL8HCYxmZiqIDdIq19tX
         dgZk4BVqdaXoJlziNRa7iaXOjPVg0Ew8sSAcLwGfS9Qz9NaKL2Ts5wy5ADX8bVn81c37
         HWIzBUV791tnjk6Dt+Fa7NFV86RlVz3gPIHYzb4I9iglL9QUTn84d8tLjYhZr/HPAOwW
         tc0bkeRJwD6EhiWBpU3byORAO5WpDscC9DV6APpI0btie7P8bZaKlyfpytTaMhKtGS3q
         JfaA==
X-Gm-Message-State: AGi0PuYmw20rocJaWvpmfbKpkVWlXHDhR8ySZJC2ZvZnUC0Oz07MiLb1
        IfMR9oRDRZ7nsze5V42xy+1O96tr
X-Google-Smtp-Source: APiQypLdvY4frZMMQ6TzPzZvBi/ymeYBTcHEn44Gf8Nc9NvfrHlN0obWXXhQsA1Ax5IGsMtJQHXfpQ==
X-Received: by 2002:a63:d13:: with SMTP id c19mr9372464pgl.180.1587741166269;
        Fri, 24 Apr 2020 08:12:46 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6374:f359:1ce8:a621:5f80:1116])
        by smtp.gmail.com with ESMTPSA id f99sm5078429pjg.22.2020.04.24.08.12.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Apr 2020 08:12:45 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH v2 4/4] progress.c: silence cgcc suggestion about internal linkage
Date:   Fri, 24 Apr 2020 22:12:33 +0700
Message-Id: <41eecf18edf3772ba04aebd656018e36058182d6.1587740959.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.26.2.384.g435bf60bd5
In-Reply-To: <cover.1587740959.git.congdanhqx@gmail.com>
References: <cover.1587648870.git.congdanhqx@gmail.com> <cover.1587740959.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 progress.c               | 2 +-
 progress.h               | 8 ++++++++
 t/helper/test-progress.c | 9 +--------
 3 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/progress.c b/progress.c
index 19805ac646..75633e9c5e 100644
--- a/progress.c
+++ b/progress.c
@@ -8,6 +8,7 @@
  * published by the Free Software Foundation.
  */
 
+#define GIT_TEST_PROGRESS_ONLY
 #include "cache.h"
 #include "gettext.h"
 #include "progress.h"
@@ -52,7 +53,6 @@ static volatile sig_atomic_t progress_update;
  */
 int progress_testing;
 uint64_t progress_test_ns = 0;
-void progress_test_force_update(void); /* To silence -Wmissing-prototypes */
 void progress_test_force_update(void)
 {
 	progress_update = 1;
diff --git a/progress.h b/progress.h
index 847338911f..f1913acf73 100644
--- a/progress.h
+++ b/progress.h
@@ -3,6 +3,14 @@
 
 struct progress;
 
+#ifdef GIT_TEST_PROGRESS_ONLY
+
+extern int progress_testing;
+extern uint64_t progress_test_ns;
+void progress_test_force_update(void);
+
+#endif
+
 void display_throughput(struct progress *progress, uint64_t total);
 void display_progress(struct progress *progress, uint64_t n);
 struct progress *start_progress(const char *title, uint64_t total);
diff --git a/t/helper/test-progress.c b/t/helper/test-progress.c
index 42b96cb103..5d05cbe789 100644
--- a/t/helper/test-progress.c
+++ b/t/helper/test-progress.c
@@ -13,20 +13,13 @@
  *
  * See 't0500-progress-display.sh' for examples.
  */
+#define GIT_TEST_PROGRESS_ONLY
 #include "test-tool.h"
 #include "gettext.h"
 #include "parse-options.h"
 #include "progress.h"
 #include "strbuf.h"
 
-/*
- * These are defined in 'progress.c', but are not exposed in 'progress.h',
- * because they are exclusively for testing.
- */
-extern int progress_testing;
-extern uint64_t progress_test_ns;
-void progress_test_force_update(void);
-
 int cmd__progress(int argc, const char **argv)
 {
 	int total = 0;
-- 
2.26.2.384.g435bf60bd5

