Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA1A4ECAAD3
	for <git@archiver.kernel.org>; Wed, 14 Sep 2022 19:31:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbiINTbX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Sep 2022 15:31:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbiINTbS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Sep 2022 15:31:18 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72F056DAD8
        for <git@vger.kernel.org>; Wed, 14 Sep 2022 12:31:17 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id a14so17385587ljj.8
        for <git@vger.kernel.org>; Wed, 14 Sep 2022 12:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=a67sK+msJDeWV6TfnbTlt+U+XbR7a5Z7mv0i63WkSFA=;
        b=RMDspkhwRhN2iDufdeKKmJHi7IotdH1YY5iLciGjEBLRP4oEr2vOORdeOjiNprgze2
         VcoD2i3lPaa4gK3dsTMEkHpFN1WJkvUlyerGeKNx26fud27qrYV01d7haUmP1wCWrnDd
         2k9BANpavxvn5qpbfwrAmdm+6ublTSzMM6vmUnZ4SEI4wOE/sCsQTXJDi3Az/CbjR3Ed
         iyFYtdcw6BDFtv1RTPnW6R0Z0BDf3Un14gtr8AASz06CAxYWSgI3HwkZe5gFutwYaiQM
         n+uyfQYnv+nrMTbksoJhSjSWjyEAQrBndz1MhOzekTbRLiGCRImB687Hj9k/zkRgZGGN
         GWlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=a67sK+msJDeWV6TfnbTlt+U+XbR7a5Z7mv0i63WkSFA=;
        b=rT9wvSoFQSZ4T0ZOPAmsHjnemKV/ingnSTKbraFGL8hqyrFchnpjTKjJWTTbKzpRro
         iF/MMXiPHTYL1X3QPqLF5OzimN9VmwtSOrgpt30MBZXZSNij4HGxUAg9npiw4iUOfEIx
         EAq/fYLa6GD23ei2EMcJnwohWKzGpAT7lcaic5DKYt1yb+k9/8purEKkK1stdIXxvyTg
         pklBx4CFDKL6N3vFQSqUx+HpLBfh+m43JAD1NTaQV6Bl0Ok0f9YsWQe4TiC/wnSA8mwq
         1Te+K87VETBHRUoXuoSJybtbHNCovTzqrR7nA5m69t842oPFWa1To7agO5dtQdtYN1OH
         zrtA==
X-Gm-Message-State: ACgBeo2WoGOwMAF2V8CwIxa4wGrCN4LOytXy685sl9bgTlqTnlFzkMrn
        rg/pYmr/Z1YUNYdOmuY2b3k=
X-Google-Smtp-Source: AA6agR5WLMMydg3+GJQzlRsOpyunatZAyT32ptg29FZJJuQMcR3AtLDPJtWSfikn8i3Sm295Ef2Qrw==
X-Received: by 2002:a05:651c:101:b0:250:896d:f870 with SMTP id a1-20020a05651c010100b00250896df870mr12068861ljb.235.1663183875832;
        Wed, 14 Sep 2022 12:31:15 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id u3-20020a05651220c300b0048ad4c718f3sm2522305lfr.30.2022.09.14.12.31.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 12:31:15 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Sergey Organov <sorganov@gmail.com>
Subject: [PATCH 2/3] diff-merges: cleanup set_diff_merges()
Date:   Wed, 14 Sep 2022 22:31:01 +0300
Message-Id: <20220914193102.5275-3-sorganov@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220914193102.5275-1-sorganov@gmail.com>
References: <20220914193102.5275-1-sorganov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Get rid of special-casing of 'suppress' in set_diff_merges(). Instead
set 'merges_need_diff' flag correctly in every option handling
function.

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 diff-merges.c | 30 +++++++++++++++++++-----------
 1 file changed, 19 insertions(+), 11 deletions(-)

diff --git a/diff-merges.c b/diff-merges.c
index 780ed08fc87f..85cbefa5afd7 100644
--- a/diff-merges.c
+++ b/diff-merges.c
@@ -20,9 +20,20 @@ static void suppress(struct rev_info *revs)
 	revs->remerge_diff = 0;
 }
 
+static void common_setup(struct rev_info *revs)
+{
+	suppress(revs);
+	revs->merges_need_diff = 1;
+}
+
+static void set_none(struct rev_info *revs)
+{
+	suppress(revs);
+}
+
 static void set_separate(struct rev_info *revs)
 {
-	suppress(revs);
+	common_setup(revs);
 	revs->separate_merges = 1;
 	revs->simplify_history = 0;
 }
@@ -35,21 +46,21 @@ static void set_first_parent(struct rev_info *revs)
 
 static void set_combined(struct rev_info *revs)
 {
-	suppress(revs);
+	common_setup(revs);
 	revs->combine_merges = 1;
 	revs->dense_combined_merges = 0;
 }
 
 static void set_dense_combined(struct rev_info *revs)
 {
-	suppress(revs);
+	common_setup(revs);
 	revs->combine_merges = 1;
 	revs->dense_combined_merges = 1;
 }
 
 static void set_remerge_diff(struct rev_info *revs)
 {
-	suppress(revs);
+	common_setup(revs);
 	revs->remerge_diff = 1;
 	revs->simplify_history = 0;
 }
@@ -57,7 +68,7 @@ static void set_remerge_diff(struct rev_info *revs)
 static diff_merges_setup_func_t func_by_opt(const char *optarg)
 {
 	if (!strcmp(optarg, "off") || !strcmp(optarg, "none"))
-		return suppress;
+		return set_none;
 	if (!strcmp(optarg, "1") || !strcmp(optarg, "first-parent"))
 		return set_first_parent;
 	if (!strcmp(optarg, "separate"))
@@ -81,10 +92,6 @@ static void set_diff_merges(struct rev_info *revs, const char *optarg)
 		die(_("invalid value for '%s': '%s'"), "--diff-merges", optarg);
 
 	func(revs);
-
-	/* NOTE: the merges_need_diff flag is cleared by func() call */
-	if (func != suppress)
-		revs->merges_need_diff = 1;
 }
 
 /*
@@ -115,6 +122,7 @@ int diff_merges_parse_opts(struct rev_info *revs, const char **argv)
 
 	if (!suppress_m_parsing && !strcmp(arg, "-m")) {
 		set_to_default(revs);
+		revs->merges_need_diff = 0;
 	} else if (!strcmp(arg, "-c")) {
 		set_combined(revs);
 		revs->merges_imply_patch = 1;
@@ -125,7 +133,7 @@ int diff_merges_parse_opts(struct rev_info *revs, const char **argv)
 		set_remerge_diff(revs);
 		revs->merges_imply_patch = 1;
 	} else if (!strcmp(arg, "--no-diff-merges")) {
-		suppress(revs);
+		set_none(revs);
 	} else if (!strcmp(arg, "--combined-all-paths")) {
 		revs->combined_all_paths = 1;
 	} else if ((argcount = parse_long_opt("diff-merges", argv, &optarg))) {
@@ -139,7 +147,7 @@ int diff_merges_parse_opts(struct rev_info *revs, const char **argv)
 
 void diff_merges_suppress(struct rev_info *revs)
 {
-	suppress(revs);
+	set_none(revs);
 }
 
 void diff_merges_default_to_first_parent(struct rev_info *revs)
-- 
2.25.1

