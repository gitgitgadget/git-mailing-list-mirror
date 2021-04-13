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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66FC7C433B4
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 11:41:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4614D61244
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 11:41:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244877AbhDMLmN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Apr 2021 07:42:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244674AbhDMLmK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Apr 2021 07:42:10 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D17BAC061574
        for <git@vger.kernel.org>; Tue, 13 Apr 2021 04:41:49 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id e14so14050277lfn.11
        for <git@vger.kernel.org>; Tue, 13 Apr 2021 04:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fS9EG/dhB0miWf93AsvJj3SbQyj78Nif124509juy5w=;
        b=RbbLU8dQ35EsUJCqFI4EyKLZh3o13va/tptMSro3fKaxSyNPmz0156aD0n035NO1TE
         aiG3jGW0x3uuoCBci69M95w5yJN9X3QFtndWvRrrmeZBZoBs1IeTGUp7WjF8QE/DqFnl
         u9DZEvF4bSKLcrSyFv9GSMG9v9c0vq8EwUHg8PuY+/nga0WinMZNQkHs0tN35DR+mMeu
         hr82pzSs6vOm8hF/n9FO+KKC0oUjPG8xi7OZanBrqhGT/vG6PbY94Cr/pOW01xw07xdf
         ZHTxgxzPnJO/Sgs5EEhpmdvb3iH0NHKUhGccT6gpncmGFcc5HZdnVJf9FEnkqetnFXnd
         oteg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fS9EG/dhB0miWf93AsvJj3SbQyj78Nif124509juy5w=;
        b=F+D5FpkVCbIq1BxCvNU/AHw/o6dyfIht1bZQQVvVUawFCENSUAUFM6B0dKk6CiVvty
         tNioQZu2wgHVVZXYolVeH3OlujnrvJ9sk8x2ZNW6MDDAyCpe+bUKXwxD3nVypBgGisfg
         Y24z38fczaKKaLg/VGOfkNVnR33D6CM+6ZJnDLghjlATFCOKm0/0DPsxOK830GYgGYki
         T9FHCEivldFNxZM6RFkfIaoyQIRqmM3Ek6XuvMRz+rkHXNVfDeUmnx4XpBPh4SVB3qpm
         veq3bKfHJ/Y3V1Aj7JQIY69Iy/x71HZbOOP/FqYaJVOkDb1031r0Z9bV5rPOVuwuNEbK
         g93w==
X-Gm-Message-State: AOAM531PawFyX/EClEo7KLGCxFpt4ccKJwEoclC++8Rff1DhZh5tkRrM
        WRLWbKsUfth5gEN0v7hR1kNsv3xln6E=
X-Google-Smtp-Source: ABdhPJx81UsAJmqX2QRzW+BZprl6dzL0j4yL8bI2eIilryJeyz9rdUbXkGYToioWlfl84g3lAoFGDg==
X-Received: by 2002:ac2:5187:: with SMTP id u7mr10023283lfi.511.1618314108372;
        Tue, 13 Apr 2021 04:41:48 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id b11sm663339lfi.292.2021.04.13.04.41.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 04:41:47 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, git@vger.kernel.org,
        Sergey Organov <sorganov@gmail.com>
Subject: [PATCH v2 2/5] diff-merges: refactor set_diff_merges()
Date:   Tue, 13 Apr 2021 14:41:15 +0300
Message-Id: <20210413114118.25693-3-sorganov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210413114118.25693-1-sorganov@gmail.com>
References: <20210407225608.14611-1-sorganov@gmail.com>
 <20210413114118.25693-1-sorganov@gmail.com>
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
index ff227368bd46..66c8ba0cc6a0 100644
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
 	else if (!strcmp(optarg, "on"))
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

