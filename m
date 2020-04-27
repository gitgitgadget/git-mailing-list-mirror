Return-Path: <SRS0=mOGp=6L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEA19C54FCB
	for <git@archiver.kernel.org>; Mon, 27 Apr 2020 14:23:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BACE8206B9
	for <git@archiver.kernel.org>; Mon, 27 Apr 2020 14:23:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hPEI0ld3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728064AbgD0OXB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Apr 2020 10:23:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727073AbgD0OXA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Apr 2020 10:23:00 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 613F2C0610D5
        for <git@vger.kernel.org>; Mon, 27 Apr 2020 07:23:00 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id a5so7579024pjh.2
        for <git@vger.kernel.org>; Mon, 27 Apr 2020 07:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1hYkfd0yPcvYslNgBt1AP5LqF9tJ+DGQKIb29SkvhF8=;
        b=hPEI0ld3PE+KwzcMYsJWvvAp0oT1yVIvx1xdIJDLnJqa3PEviQxf5fBhLilHO/EdgY
         nndWkOudE9IMXprkJE1wfV7BKX+Yp58JlabW4bgeMxd37+h8v2zTU6nAp092gotNiBEI
         hCnpkElgtvQu2rNG+EBJGbt9iEbgfBSPj9e0T3FVehNyBBtuJDGgkUTWIJ/ZseYTlGif
         16CM/4wYMbjuSJreGwpIUIu62ztv1hg3xExvqzrIzFRisuVtDGOCZsbc2ihCgRHjC7ou
         OO7mYVn9uD6DxV9WHBDUdybu1vHwRKakDhbhtL2dugYtHa/ZDQt+hbCTYA3x8Trw76eN
         /Z/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1hYkfd0yPcvYslNgBt1AP5LqF9tJ+DGQKIb29SkvhF8=;
        b=iPTLYb1hOrEs2JDab01XMD3PD/rzRTcrmZeClfXywOKBuGexJYBVQqXK6pkQL0s3VL
         lyycdFB15TeWFdJ2NgejxG6FQyvRhWF3gTNjOBxdIgx/Zjon4yfD1fT8TJQXhpyPPOOu
         PgdZKT/29YZhb1NaLmuFJI1uq8bmDe1y2lu0XCRjsTrG6xp0XOdQJqQcosmPTR4Y+TNR
         ZR+DEaGJCT5BNmQnQygq9HWPcmGlw5SVQIxJcfDLTSQ+NVTk7TjEqSMEVYSPTA44o2C+
         A8e9aAZ2u3hQgFs4TRJHva0vxjYi8gJxPzJMr/Vg16akgJPXMST3ygKbRVK5B18XQl3J
         5iiw==
X-Gm-Message-State: AGi0PubqlSBZ2e1IbR4LqbeW+mfeW4n3l6cqxI4Y3pBAzFqdvVtrhTan
        hkaArblD+deKginbf2ZUp0+Umg39
X-Google-Smtp-Source: APiQypLEmBZj0j1syeX+FfwI9fvD9RTlcrejODhP04UtwEntjcml06PL9Pb6WEQrOPLEpnxW53iZ3w==
X-Received: by 2002:a17:90a:2401:: with SMTP id h1mr24420919pje.1.1587997379712;
        Mon, 27 Apr 2020 07:22:59 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6374:bf12:8518:c5e6:e4cc:3967])
        by smtp.gmail.com with ESMTPSA id c1sm12589602pfc.94.2020.04.27.07.22.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Apr 2020 07:22:59 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH v3 4/4] progress.c: silence cgcc suggestion about internal linkage
Date:   Mon, 27 Apr 2020 21:22:37 +0700
Message-Id: <d66d9aa677944205cdd5af77192c35ec929692ea.1587996766.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.26.2.526.g744177e7f7
In-Reply-To: <cover.1587996765.git.congdanhqx@gmail.com>
References: <cover.1587648870.git.congdanhqx@gmail.com> <cover.1587996765.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---

Notes:
    Unify all declaration together and keep them under an ifdef.
    
    With the hope that no other static analysis tools complain.

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
2.26.2.526.g744177e7f7

