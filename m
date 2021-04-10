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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD05DC43460
	for <git@archiver.kernel.org>; Sat, 10 Apr 2021 17:17:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86C34611AE
	for <git@archiver.kernel.org>; Sat, 10 Apr 2021 17:17:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234866AbhDJRRm (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 10 Apr 2021 13:17:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234738AbhDJRRg (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Apr 2021 13:17:36 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0B9CC06138A
        for <git@vger.kernel.org>; Sat, 10 Apr 2021 10:17:21 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id c1so1908717ljd.7
        for <git@vger.kernel.org>; Sat, 10 Apr 2021 10:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fWPLUK/87IasufE+rzXw9S6VGHfQUN0z9gXDzUuyxzs=;
        b=uLcCpOaA7ubD4qu6/3ue03fazJDFAivec3KdbiH4UhiZwfDnQCjncSINafO9bx6iAK
         uJ29ktsPVkZaET1azzXAPsKY4aAP/fBKp8V5teZNJOfIegUqNFQmgGIA1BPKVTOcMK9J
         60vbC5vfNS+DgLAQc89lJUEzSs9q83wS3tmxu8Vz3APD10R0JP1ByromvfSjIlBxjAiS
         Mb1FVdVt11BnAXyGhFAolEvhoNI5x4fHY5YCWwIS7lJZpYKfyika3PQgmH2daYKkoB8k
         lJV2oXYlUXbIX3TbxUbOpgff4169PMWPLrBa3Ge1xufmhV/+LL8fn1X3auRXnrtCvOd6
         N0jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fWPLUK/87IasufE+rzXw9S6VGHfQUN0z9gXDzUuyxzs=;
        b=D6f6/aj9J8mmX7DN9WuSX7AiGzZcMXy4q9Rfjtp6CJWJNXnZccPAapAXEi4mG7GWbi
         B6Un4KW6J3yVYyKlINcdh/ZRq4389lwnS/oq5fSdf4fDuKT4EnkjXTJLBqzOj7gvnpNe
         k56G8YSS6tOT6VeP+yZ39BGSY1KU9yAW5a4rvk0AGVNXB8IsZJoOQxxHpAIPXK4iGErz
         CxzVVTUTxO4JBrlTgpThpTxb21rZUEfUa+yRnkYsXSY1lJT/1WW6OVdSHztoNAG7pEIu
         uV+29vKwcxEL5qVoBqjSM6hnhxzk3Ru0u4h+uBdk+U1aNyRj5lLpizGaNqd7rLuaj8te
         WlkQ==
X-Gm-Message-State: AOAM532C46cQviJ5XHIaQ18F4her3B4PDXs0GhLvarFB0n2x6TolzjEQ
        J3vJgJKoikLe8Wkwhmt4FxQ=
X-Google-Smtp-Source: ABdhPJw4v08NBHtdnoI7KJ9J22n0bslbJwNplKMZI5lSuIEtrVxOfmtHej+ugQXMsstXTiq1zwT8qw==
X-Received: by 2002:a2e:5049:: with SMTP id v9mr7212582ljd.259.1618075039537;
        Sat, 10 Apr 2021 10:17:19 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id z7sm1336543ljo.64.2021.04.10.10.17.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Apr 2021 10:17:19 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, git@vger.kernel.org,
        Sergey Organov <sorganov@gmail.com>
Subject: [PATCH v1 2/5] diff-merges: refactor set_diff_merges()
Date:   Sat, 10 Apr 2021 20:16:54 +0300
Message-Id: <20210410171657.20159-3-sorganov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210410171657.20159-1-sorganov@gmail.com>
References: <20210407225608.14611-1-sorganov@gmail.com>
 <20210410171657.20159-1-sorganov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Split set_diff_merges() into separate parsing and execution functions,
the former to be reused for parsing of configuration values later in
the patch series.

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 diff-merges.c | 36 +++++++++++++++++++++---------------
 1 file changed, 21 insertions(+), 15 deletions(-)

diff --git a/diff-merges.c b/diff-merges.c
index 7690580d7464..9918b6ac55e4 100644
--- a/diff-merges.c
+++ b/diff-merges.c
@@ -55,29 +55,35 @@ static void set_dense_combined(struct rev_info *revs)
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
 	else if (!strcmp(optarg, "default"))
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

