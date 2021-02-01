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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B298C433E0
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 14:55:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3E1C64EA4
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 14:55:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbhBAOzD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Feb 2021 09:55:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231467AbhBAOuW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Feb 2021 09:50:22 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0662AC06178B
        for <git@vger.kernel.org>; Mon,  1 Feb 2021 06:49:41 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id u14so12868461wml.4
        for <git@vger.kernel.org>; Mon, 01 Feb 2021 06:49:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uYhUHo6Ku3bulSheUJkOZuqf/igSgjI+/StyEFlK6/Y=;
        b=Q7RPodz28eF31Y0T1y1RAoxkbKCKEUcethEc7e6RErANE8vdTNaf7nBnu3EBLJ56aH
         myGibDsFE6J7EjekkX+PZEABzfRL10LFzYpYAVfzd7VB819i8H4xzb5cQqhYnJ5jRMTp
         Z0MDGJ6SDOqzhzgYzd2HeUC2PnjKQL9tWPKI9wLuvDYPjloCUlV5MoO3i6+Zl2VlO0b0
         eQTn6hO7edsMJxN+7m5aOqTyhjlt+SdL7YKENuwaeViSVqh/iFdgBCpWoWDUaOYZpqrl
         y8H/IlpO2VjPV59NGEUHCu3P2Azp8Ls0RkEXt+h7IiiHb5y+BV60AHZ8sU2XpvmWokzV
         oF9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uYhUHo6Ku3bulSheUJkOZuqf/igSgjI+/StyEFlK6/Y=;
        b=ZkuO+GeHPSBQmSlhBdVcfg1qBBCrf/sPmbn0l8ZiOJts8YHN1wghxfrars1o3w2j6Y
         VatGiK8vtwCC+aFuyZS2s+PT8TPqDuXxYAn1cuYTkh5cY/iWDALF/9bj4BFPvxL0Musx
         R97kDK947IohWp8FIFENcYfcQEMl5NT8vhS1YqQclQWJ9a71BB6kGfYKb7vHG/eSChzN
         2q/K041OYEHsKUeYxPwaum07gaYXsvHKZyIS33DaYxVVy6jwoXSkI/b7BVLq7HQPj8i8
         3nngEAfHMqEzlcYM7P6wyqwxO0DbVUYfytzdtuAClSQUr3QVtdP47VolqysfbP74mFV8
         iQ8A==
X-Gm-Message-State: AOAM530tXoRHhrA2Bi3v06h+6ZfQur4Hf9QBibrhIyXsn8OnnT3DOK9b
        Xa9SsZNvQNe2fhjgkGw8eeaux3LAZl4JVA==
X-Google-Smtp-Source: ABdhPJyXIIYkJ4mPKcBbn3XwuXGqwFZNJdKFN3oo9+2pSLuIqH5oSQObset5dspW3v5VfmjnhmYjeA==
X-Received: by 2002:a1c:c386:: with SMTP id t128mr9006593wmf.172.1612190979478;
        Mon, 01 Feb 2021 06:49:39 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id k4sm28799954wrm.53.2021.02.01.06.49.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 06:49:38 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Vincent Lefevre <vincent@vinc17.net>,
        Chris Torek <chris.torek@gmail.com>,
        Denton Liu <liu.denton@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/3] pager: refactor wait_for_pager() function
Date:   Mon,  1 Feb 2021 15:49:20 +0100
Message-Id: <20210201144921.8664-3-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <87im7cng42.fsf@evledraar.gmail.com>
References: <87im7cng42.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Refactor the wait_for_pager() function. Since 507d7804c0b (pager:
don't use unsafe functions in signal handlers, 2015-09-04) the
wait_for_pager() and wait_for_pager_atexit() callers diverged on more
than they shared.

Let's extract the common code into a new close_pager_fds() helper, and
move the parts unique to the only to callers to those functions.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 pager.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/pager.c b/pager.c
index ee435de6756..3d37dd7adaa 100644
--- a/pager.c
+++ b/pager.c
@@ -11,29 +11,25 @@
 static struct child_process pager_process = CHILD_PROCESS_INIT;
 static const char *pager_program;
 
-static void wait_for_pager(int in_signal)
+static void close_pager_fds(void)
 {
-	if (!in_signal) {
-		fflush(stdout);
-		fflush(stderr);
-	}
 	/* signal EOF to pager */
 	close(1);
 	close(2);
-	if (in_signal)
-		finish_command_in_signal(&pager_process);
-	else
-		finish_command(&pager_process);
 }
 
 static void wait_for_pager_atexit(void)
 {
-	wait_for_pager(0);
+	fflush(stdout);
+	fflush(stderr);
+	close_pager_fds();
+	finish_command(&pager_process);
 }
 
 static void wait_for_pager_signal(int signo)
 {
-	wait_for_pager(1);
+	close_pager_fds();
+	finish_command_in_signal(&pager_process);
 	sigchain_pop(signo);
 	raise(signo);
 }
-- 
2.30.0.284.gd98b1dd5eaa7

