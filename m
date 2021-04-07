Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C7FAC43460
	for <git@archiver.kernel.org>; Wed,  7 Apr 2021 22:56:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2238961184
	for <git@archiver.kernel.org>; Wed,  7 Apr 2021 22:56:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbhDGW4g (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Apr 2021 18:56:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbhDGW4e (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Apr 2021 18:56:34 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77389C061760
        for <git@vger.kernel.org>; Wed,  7 Apr 2021 15:56:24 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id n138so744669lfa.3
        for <git@vger.kernel.org>; Wed, 07 Apr 2021 15:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6y4PDA5OU6djTBMJ9vfefYoDq8e35okklITaBUhn6Yg=;
        b=cMHH2yabN7zqbsTc8RKCQMcuQgb7YASq4T3Fn5EklIiFZtJBYJ4qWfk0WHoKesGTio
         bk0rKVG0AngDtbiMTqxmshAajy4UcUNMHd6qgDR4nulk4QDySk3UzHnPQ3UMQh9g1oxk
         Ogz4nl33ZoTa8SCcRyCzjax1X+Px/oEB99CqTc8scpbEs/+HAdCspCoVpWmLL88vAEUj
         WRqNX4KYcVbiX/l/7/p6JwmWmHYtgkTGZwah2Ab7iUrhdUwNYDEJYUNVPSwxZlzwdZAh
         L+yk+uNkuXUog7+9IWCcq3yysE4MJ4GnsXKbtG4OQH8ohBD1dnr9ZsKX7mmySK0U3Yhu
         k3ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6y4PDA5OU6djTBMJ9vfefYoDq8e35okklITaBUhn6Yg=;
        b=BbyQe7bq6bY2E9GiiN08YPxczFuTxiDmgqv8kyXEMpCNCDj/yxBqIE53uaGxmcUZyJ
         mdao6e3ykCH8yZ+jNVxhrzdomMjDoM9uvpOK8nEm5HBjqFN8i03NlU5kkXh47m8h1ouU
         OqV30M4RMnX7ru0dFyHibwyKWr1wZ9lUl3CycbPwaT1qE7mqdP/bZG7M+CdBPgK0vroG
         jJT3XVyGVSsMJ9Xqnj8uCFa1Z44KFrl6EZJuBx+q4N/Cn3QLtnjbUq/CrC0zud6OwDc5
         B1VnxUNDygkparjsvRde7ut+BWT83XEvVDtejxcBTqOI7w3KGnadN9S4k6btMVlmhdZm
         nZFA==
X-Gm-Message-State: AOAM533f5RX7leLeEo47v7hpSia07GUPzZP9g9K5xaeugWM2NFFrY3or
        S8QuFgLO3HujAF5Q+hLPjkdkew5ysfE=
X-Google-Smtp-Source: ABdhPJzIQsGnp6MB69UEmZEJkuQX6DTlfJfKWQRt2Bv3ZMQurBzjmobhIOkSj1NvqRhlC4J23i9Eiw==
X-Received: by 2002:a05:6512:3692:: with SMTP id d18mr4086392lfs.128.1617836183034;
        Wed, 07 Apr 2021 15:56:23 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id t25sm2580101ljo.102.2021.04.07.15.56.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 15:56:22 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        git@vger.kernel.org, Sergey Organov <sorganov@gmail.com>
Subject: [PATCH 2/9] diff-merges: refactor set_diff_merges()
Date:   Thu,  8 Apr 2021 01:56:01 +0300
Message-Id: <20210407225608.14611-3-sorganov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210407225608.14611-1-sorganov@gmail.com>
References: <20210407225608.14611-1-sorganov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Split set_diff_merges() into separate parsing and execution functions,
the former to be reused later in the series for parsing of
configuration values.

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 diff-merges.c | 41 ++++++++++++++++++++++++-----------------
 1 file changed, 24 insertions(+), 17 deletions(-)

diff --git a/diff-merges.c b/diff-merges.c
index 0887a07cfc67..93ede09fb36f 100644
--- a/diff-merges.c
+++ b/diff-merges.c
@@ -3,6 +3,9 @@
 #include "revision.h"
 
 typedef void (*diff_merges_setup_func_t)(struct rev_info *);
+static void set_separate(struct rev_info *revs);
+
+static diff_merges_setup_func_t set_to_default = set_separate;
 
 static void suppress(struct rev_info *revs)
 {
@@ -21,8 +24,6 @@ static void set_separate(struct rev_info *revs)
 	revs->separate_merges = 1;
 }
 
-static diff_merges_setup_func_t set_to_default = set_separate;
-
 static void set_first_parent(struct rev_info *revs)
 {
 	set_separate(revs);
@@ -54,29 +55,35 @@ static void set_dense_combined(struct rev_info *revs)
 	revs->dense_combined_merges = 1;
 }
 
-static void set_diff_merges(struct rev_info *revs, const char *optarg)
+static diff_merges_setup_func_t func_by_opt(const char *optarg)
 {
-	if (!strcmp(optarg, "off") || !strcmp(optarg, "none")) {
-		suppress(revs);
-		/* Return early to leave revs->merges_need_diff unset */
-		return;
-	}
-
+	if (!strcmp(optarg, "off") || !strcmp(optarg, "none"))
+		return suppress;
 	if (!strcmp(optarg, "1") || !strcmp(optarg, "first-parent"))
-		set_first_parent(revs);
+		return set_first_parent;
 	else if (!strcmp(optarg, "m") || !strcmp(optarg, "separate"))
-		set_separate(revs);
+		return set_separate;
 	else if (!strcmp(optarg, "c") || !strcmp(optarg, "combined"))
-		set_combined(revs);
+		return set_combined;
 	else if (!strcmp(optarg, "cc") || !strcmp(optarg, "dense-combined"))
-		set_dense_combined(revs);
+		return set_dense_combined;
 	else if (!strcmp(optarg, "def"))
-		set_to_default(revs);
-	else
+		return set_to_default;
+	return NULL;
+}
+
+static void set_diff_merges(struct rev_info *revs, const char *optarg)
+{
+	diff_merges_setup_func_t func = func_by_opt(optarg);
+
+	if (!func)
 		die(_("unknown value for --diff-merges: %s"), optarg);
 
-	/* The flag is cleared by set_xxx() functions, so don't move this up */
-	revs->merges_need_diff = 1;
+	func(revs);
+
+	/* NOTE: the merges_need_diff flag is cleared by func() call */
+	if (func != suppress)
+		revs->merges_need_diff = 1;
 }
 
 /*
-- 
2.25.1

