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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE3A8C63797
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 12:55:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B65576139A
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 12:55:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232054AbhGVMOm (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Jul 2021 08:14:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232039AbhGVMOj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jul 2021 08:14:39 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1D08C061757
        for <git@vger.kernel.org>; Thu, 22 Jul 2021 05:55:13 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id f17so5830557wrt.6
        for <git@vger.kernel.org>; Thu, 22 Jul 2021 05:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7UncCd9MO7yaV5/Dm2Q57Vd3+VlDfWXcAYWvvQQRVWo=;
        b=tdQi2/cxIMTymB6eR/j+EF7m11S2dl5p01SP2oCF0QBHz13T7Yor359ePwxfDY/gs0
         LohWlCpGLtDgXjfj93Y3hZdqZ4FkaGSQsVtV7GlwE0NTHBzr3WAb9ywl0xzO17pC7+B3
         eV/0+yBzAC8UaFD6wdQCfXxpvpqyRFnzR+RidiYsnDlFx/Z+yv3Qw20lijVYb+kqWIyL
         K/UUao10CGBqHG2nzYhBw2Z/zqS8AkpWsOYZXo1JUD6Zgec5vA5Wfy6jzxG5Q80nSzpw
         zNgpvJ7Jx/W6OnUaCE6rfQRFq5UZ++Nf+7vzv4fpcf9ReHDKBW0MPMfuHyEm1Z5SG3ox
         7qaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7UncCd9MO7yaV5/Dm2Q57Vd3+VlDfWXcAYWvvQQRVWo=;
        b=hxG/XULkC08A0vz9sb/nJKB1kydF+eSvz0sX0zil+xVqhZ5zZ//KIAyE8KeRX09aPJ
         eZIT24h9mJi7sO4NjIcQ9/vNyezaecrBEhnLnPAqySFE60POtwnUehvsLgaF6AopfkNB
         lxe0c4D6q0cuS2ATwn3zLgUST2TP0LEx5ahwt498QzzfQcb3peNVb5p81bQTwtagJMXP
         D31hxAT+ifMpUZ1r4UUT4ftaxzIyE7H+eVyKJxkqI+ReN9g6TSJdKOiGGWUlCPTegYBo
         rW+4mvwO5Aq4+QPTbe+Rns8cE0q3Luv/FTMocnwJ2afAe7OFrgFnhkVEmmEPIXirDfoR
         GmwQ==
X-Gm-Message-State: AOAM531jgjCbSqwAd4SrGSGUQejzxVu9FN7tHL4iL36w28ZDcp57sqBW
        gzr8avjOSZv7CF19kotT4tZuuEJiU1Oz4g==
X-Google-Smtp-Source: ABdhPJwLnw20L3i1fR4uymw2BKDOk2+Fdusfcxy2Bn9ZnlsGSgAL/qb2JxRasAxU7PjMdj4aZ4SUsg==
X-Received: by 2002:a5d:488a:: with SMTP id g10mr47157146wrq.327.1626958512161;
        Thu, 22 Jul 2021 05:55:12 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id g3sm29937483wru.95.2021.07.22.05.55.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jul 2021 05:55:11 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 3/8] progress.c: move signal handler functions lower
Date:   Thu, 22 Jul 2021 14:55:01 +0200
Message-Id: <patch-3.8-b91e37fdb5-20210722T125012Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.957.gd9e39d72fe6
In-Reply-To: <cover-0.8-0000000000-20210722T125012Z-avarab@gmail.com>
References: <20210620200303.2328957-1-szeder.dev@gmail.com> <cover-0.8-0000000000-20210722T125012Z-avarab@gmail.com>
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
index 680c6a8bf9..893cb0fe56 100644
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
2.32.0.957.gd9e39d72fe6

