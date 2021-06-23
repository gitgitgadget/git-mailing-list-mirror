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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D3FBC4743C
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 17:48:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18C05611C1
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 17:48:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbhFWRu4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Jun 2021 13:50:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbhFWRuw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jun 2021 13:50:52 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61748C061760
        for <git@vger.kernel.org>; Wed, 23 Jun 2021 10:48:34 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id d11so3638674wrm.0
        for <git@vger.kernel.org>; Wed, 23 Jun 2021 10:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DkvS1LeVH/TbQQs9SC63giIb22OtgUaW5qc43Njz9ZE=;
        b=KppSc5pRZ0lY1Xqdr5BGNxaE7pc6VofNvKoM9D/oXln4HNScTYLyLZty5aBZaW2S2K
         UGwbbFYuyrrrf6g1iDgJvrEEkZUhJBZqnEiXxfTZe5WB/IcwDj22UgSljWGj/1yrH5a+
         1ftm4I9BOlroiO9/go9ZPQ3XGY3jr/sqgpI3KINUaSv1WsiUig5hIsvN+j07svtGzU2t
         M2iQXL+v9mOzlAjMUwE76V8U9NBuWHUkBONAYGtPVPLVCkMdiV6uPxvglIqfKFYn6uRv
         JkEXgFfXFLt29eFMniB+UwrEXIW0SuiAB4Q2L5fRxmr57AuvLgfzQ6KinZcl3m64Iz9v
         9DFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DkvS1LeVH/TbQQs9SC63giIb22OtgUaW5qc43Njz9ZE=;
        b=emsjCYY3/NJDZHSL9LP2C8+KHM3qKCbu5eaweBNEOQEF/DJnvyOuuN/I7N/Lp+Rz33
         KAiUR0JO9Kotbbv8hZzZOQ+mTS17HfM3p7gqGmguHHZmqX3CUGpuc2OwqZZV7Ax+hi/x
         tZSYObIrMheQ6HP9q+ll/3QBpl/zu1WD+VOpm1R9Gs3ltI9KBQFHxjAnvKPlJaQ+H1Sz
         jsSJmWeB+9COVyzqehl6TyAGdJ1/JTY300zXVPuY2p4KcKSCPpvpVuzT3/L2Guq9SCHg
         kmQWJ/KqNmE8JtJ4z6RjFmesOtXbdVk6pSoQq3ME9dE9D6rvurPSPF2aQi1sc/PC0hS6
         RPLA==
X-Gm-Message-State: AOAM532Tyg7y7fQ58EzuRY2Y44e0OG1mSGi6Br28xfUdhMUpbL9Qnl/K
        dvkWTrUxUQ13U5Ecm3G5Sbi29k4OW1OrjA==
X-Google-Smtp-Source: ABdhPJwoWe8/Rw0QYYEypqoJ7L+lW2Z1IgpFVk4ZBN/FL6OEKuBjmZMs+gXNgUyrCdZkOPqCMUKi7Q==
X-Received: by 2002:adf:e4c8:: with SMTP id v8mr1438998wrm.143.1624470512715;
        Wed, 23 Jun 2021 10:48:32 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id x25sm6678281wmj.23.2021.06.23.10.48.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 10:48:32 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 05/25] progress.c: move signal handler functions lower
Date:   Wed, 23 Jun 2021 19:48:05 +0200
Message-Id: <patch-05.25-fa6359da171-20210623T155626Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.599.g3967b4fa4ac
In-Reply-To: <cover-00.25-00000000000-20210623T155626Z-avarab@gmail.com>
References: <YNKWsTsQgB2Ijxu7@nand.local> <cover-00.25-00000000000-20210623T155626Z-avarab@gmail.com>
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
2.32.0.599.g3967b4fa4ac

