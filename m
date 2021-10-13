Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0430BC433F5
	for <git@archiver.kernel.org>; Wed, 13 Oct 2021 22:28:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E25ED61163
	for <git@archiver.kernel.org>; Wed, 13 Oct 2021 22:28:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231177AbhJMWal (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Oct 2021 18:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230499AbhJMWai (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Oct 2021 18:30:38 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 109A3C061570
        for <git@vger.kernel.org>; Wed, 13 Oct 2021 15:28:34 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id r18so13221879wrg.6
        for <git@vger.kernel.org>; Wed, 13 Oct 2021 15:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KQGoMoKgkJeqht+KmlfrwXr3eIR/SmK9Of58DWNXlBo=;
        b=Be3lno3tR3rqfwAi/B773JPO8XCynmQf4nr3t+ytcJatroQihis07iKEM+iREBYdrR
         dIphXZo7KUn0Z5DoWeVZrlBSuEdiCEzoGiUPlTobnzmgTn4nT4DPF+pFB0yJzRt/ycCG
         qKZU38Iav4BQH7k7eezCUNbCkvIa5WlPeemBWIeXyJq6rhUk8PeFK1lyvdzB4lawVFda
         cjxLT/spFyZHqrASA5KDHsJKbn6F8CUDeYBpZgqjcs29sSfQSzJPlbZQyqm3iqNNFaNK
         hRdi0RoOYmD/PiCRsI2D2rdYTq5wEe97g4Jp/JvQ9+J/pCvuQlnvJP6QO5e1osMcqnc8
         efrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KQGoMoKgkJeqht+KmlfrwXr3eIR/SmK9Of58DWNXlBo=;
        b=BIviiJYg5Wz+HJVTlBEsmSgizn5bLmzRnSWL+SU7C/BngqWIrfKxf0ypvPq8wj1pNU
         p6g5iDKos5hDiv3+wAgkBqlmrjRfwMMokLZZd2ykGcLJlWfqVOmLvsYWVkzqT0FpKvbh
         AM8pQMlQOPMR+OI8Abeks5gZQ7wrUGxyXZDyHgVU4FML9Qs4fhAKCJebgrl94/AYQJnZ
         8EY8FpUaH9nqT06cm+CXvaP0lX9n+QmyOZ3je0LGBTBIUmEy3K46plV91Xb0a9WiBTMz
         VMwnd3pjVANuIOoO+TR62W2Pb3ltV7jjnr1+VCyZIOsDP8CpW9vh2MC3TBPF3P7FK8Uu
         Y3wQ==
X-Gm-Message-State: AOAM530vivnT6FEUE52C/J7s5wqoiC0QWwtv6HOL9fS5EsShEID1v5NG
        IShhBXjezwIWXWPfj+6rmoTfDV++8AO+Lw==
X-Google-Smtp-Source: ABdhPJySPRW53hrD/YBosLCgM2Pp9H6nC+Rr+wjBuXQU4ezeY7g+jsP7hvhsxnFQJr3RZNObnizT2A==
X-Received: by 2002:a05:600c:4fcd:: with SMTP id o13mr16043148wmq.158.1634164112446;
        Wed, 13 Oct 2021 15:28:32 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l5sm736683wrq.77.2021.10.13.15.28.31
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
Subject: [PATCH v3 05/10] progress.c: move signal handler functions lower
Date:   Thu, 14 Oct 2021 00:28:21 +0200
Message-Id: <patch-v3-05.10-9e36f03de46-20211013T222329Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1346.g48288c3c089
In-Reply-To: <cover-v3-00.10-00000000000-20211013T222329Z-avarab@gmail.com>
References: <cover-v2-0.8-00000000000-20210920T225701Z-avarab@gmail.com> <cover-v3-00.10-00000000000-20211013T222329Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move the signal handler functions to just before the
start_progress_delay() where they'll be referenced, instead of having
them at the top of the file.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 progress.c | 92 ++++++++++++++++++++++++++++--------------------------
 1 file changed, 48 insertions(+), 44 deletions(-)

diff --git a/progress.c b/progress.c
index 680c6a8bf93..893cb0fe56f 100644
--- a/progress.c
+++ b/progress.c
@@ -53,50 +53,6 @@ static volatile sig_atomic_t progress_update;
  */
 int progress_testing;
 uint64_t progress_test_ns = 0;
-void progress_test_force_update(void)
-{
-	progress_update = 1;
-}
-
-
-static void progress_interval(int signum)
-{
-	progress_update = 1;
-}
-
-static void set_progress_signal(void)
-{
-	struct sigaction sa;
-	struct itimerval v;
-
-	if (progress_testing)
-		return;
-
-	progress_update = 0;
-
-	memset(&sa, 0, sizeof(sa));
-	sa.sa_handler = progress_interval;
-	sigemptyset(&sa.sa_mask);
-	sa.sa_flags = SA_RESTART;
-	sigaction(SIGALRM, &sa, NULL);
-
-	v.it_interval.tv_sec = 1;
-	v.it_interval.tv_usec = 0;
-	v.it_value = v.it_interval;
-	setitimer(ITIMER_REAL, &v, NULL);
-}
-
-static void clear_progress_signal(void)
-{
-	struct itimerval v = {{0,},};
-
-	if (progress_testing)
-		return;
-
-	setitimer(ITIMER_REAL, &v, NULL);
-	signal(SIGALRM, SIG_IGN);
-	progress_update = 0;
-}
 
 static int is_foreground_fd(int fd)
 {
@@ -249,6 +205,54 @@ void display_progress(struct progress *progress, uint64_t n)
 		display(progress, n, NULL);
 }
 
+static void progress_interval(int signum)
+{
+	progress_update = 1;
+}
+
+/*
+ * The progress_test_force_update() function is intended for testing
+ * the progress output, i.e. exclusively for 'test-tool progress'.
+ */
+void progress_test_force_update(void)
+{
+	progress_update = 1;
+}
+
+static void set_progress_signal(void)
+{
+	struct sigaction sa;
+	struct itimerval v;
+
+	if (progress_testing)
+		return;
+
+	progress_update = 0;
+
+	memset(&sa, 0, sizeof(sa));
+	sa.sa_handler = progress_interval;
+	sigemptyset(&sa.sa_mask);
+	sa.sa_flags = SA_RESTART;
+	sigaction(SIGALRM, &sa, NULL);
+
+	v.it_interval.tv_sec = 1;
+	v.it_interval.tv_usec = 0;
+	v.it_value = v.it_interval;
+	setitimer(ITIMER_REAL, &v, NULL);
+}
+
+static void clear_progress_signal(void)
+{
+	struct itimerval v = {{0,},};
+
+	if (progress_testing)
+		return;
+
+	setitimer(ITIMER_REAL, &v, NULL);
+	signal(SIGALRM, SIG_IGN);
+	progress_update = 0;
+}
+
 static struct progress *start_progress_delay(const char *title, uint64_t total,
 					     unsigned delay, unsigned sparse)
 {
-- 
2.33.1.1346.g48288c3c089

