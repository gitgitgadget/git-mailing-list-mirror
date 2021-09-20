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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02C9BC4167E
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 02:22:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0D7A61355
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 02:21:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348033AbhIUCWs (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Sep 2021 22:22:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236931AbhIUBvy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Sep 2021 21:51:54 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FFE6C0386C4
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 16:09:41 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id u18so32248661wrg.5
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 16:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QAW3l7E2VC5xfPBAYoUUmqk4sQJhfNBZ2Uvg11ooxjE=;
        b=bDAzdp9BmQmck2FJzIzxn5QFTAfWByIU2gDoQw5WwnrsUi2iup1ewHsscSgpwC88Lz
         mzLTn69HnJOE+Cq4xca4y66wffHeo1ACIxcUKVUxwXcOyGNP63bkRhF0XRmOFk3Kaw+I
         lD+o/SeSPE+29B6RZqclWg+0Zixk0M7Qs413glmvk/bJ6/odjMhCVYwcHoOGn8ldms4S
         dnnZdXDk339bSVxgso/7j3BppM/JZZIVHleEM6TmUUiejvB1TTPuXtt+wUzwj/him85L
         yp6rXR5sDiqDq7PjAXMGzC2ZlNRaC2FquCAmp5Av7YxyEcyWEuV9o6M8vlwsVxnLB7aP
         tLHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QAW3l7E2VC5xfPBAYoUUmqk4sQJhfNBZ2Uvg11ooxjE=;
        b=MwMI6pqqE06lTp0LH8B+QMlsxiki/XmGLPzVdwKd7h4zdFipDEMfqSsL457iXX9NNw
         6S2lMzLtFNwApsDWJpT44L5NW//9U/pLq+dQAdXwjx4xCV6DX0Jgt7Y4rXeutAoFeYZQ
         MDnzfmIO+R6kmex+o5EkzgVWHi1UPJJRTP/hNEGqeJqX5B5VQvFZVnJjdAVMHqjTZPuC
         nECIZEC/w01JWljq2Wd/iavcGFjgcFu6LNqOwXPxM6Jv7WW0l+nEhu7YjqMoeGCiFxHf
         5Kyx3sUbaiTx8j/TmTx7oIGkz56/Xl2z+KuaLHQe/bgpavx6hamn6flvPpojv7uKQg28
         7jKg==
X-Gm-Message-State: AOAM533oPGkKwNY+60UpcVGGcrhHJJMMhlgHmSTsuFhWF6j9qyk93w2Z
        jvqlx5ervXQCR1k2apu+pp+ZWwal63W+yA==
X-Google-Smtp-Source: ABdhPJxK1f8oT0qiP2hPpAYymLr9b0Lzfc8e99MEWbP3hjWbW/Jr7DqUGvZC4QAjdntFMIl1pbMHDw==
X-Received: by 2002:a05:600c:1c9e:: with SMTP id k30mr1381412wms.74.1632179379990;
        Mon, 20 Sep 2021 16:09:39 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c8sm10409154wru.30.2021.09.20.16.09.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 16:09:39 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 3/8] progress.c: move signal handler functions lower
Date:   Tue, 21 Sep 2021 01:09:24 +0200
Message-Id: <patch-v2-3.8-f1b8bf1dbde-20210920T225701Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1098.gf02a64c1a2d
In-Reply-To: <cover-v2-0.8-00000000000-20210920T225701Z-avarab@gmail.com>
References: <cover-0.8-0000000000-20210722T125012Z-avarab@gmail.com> <cover-v2-0.8-00000000000-20210920T225701Z-avarab@gmail.com>
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
2.33.0.1098.gf02a64c1a2d

