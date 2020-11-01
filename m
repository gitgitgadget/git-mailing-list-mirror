Return-Path: <SRS0=MFMM=EH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 276FAC4741F
	for <git@archiver.kernel.org>; Sun,  1 Nov 2020 19:34:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAA41208B6
	for <git@archiver.kernel.org>; Sun,  1 Nov 2020 19:34:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u5ynb69H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727342AbgKATe1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 1 Nov 2020 14:34:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727277AbgKATeY (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Nov 2020 14:34:24 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1374C061A4B
        for <git@vger.kernel.org>; Sun,  1 Nov 2020 11:34:23 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id v6so14583584lfa.13
        for <git@vger.kernel.org>; Sun, 01 Nov 2020 11:34:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mxL+yxGkREL9Bx+2kD827DLOziGiEYPg/QyJ/uLUuh0=;
        b=u5ynb69HtGnrE/jy6cyEFJ5qHXmRpd/L86W+CCc2mj1JZ2X3cMSKUFdwGvNfud32D6
         C5n9YXVlAmR2S8FyCbKbupiNw+XfN+ENEVSiASs+1hEwitLnS5hn1nCRwUXC/G7RZ/BI
         HLq61GpjeTfcMNwUnas8rg0VlJ3ekmEAX1H0NydoHZgMyy5PayT3+99OM56tPJCTBDjx
         yjE9mK9UpymquSibCQvAFnygyAsSLRbqjNaaKPUi4wJi5ti9fZzE93W9ygfX1wtzZx4n
         8CBpig/s/QFOLQ9fb7VkHLlh7FTmsm2ZGyBIfed0ZzZ2ommF2oXJxU/IgN+GnpNow/sU
         MSHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mxL+yxGkREL9Bx+2kD827DLOziGiEYPg/QyJ/uLUuh0=;
        b=eI0CwFwhTBV4B1odM3pdRvx7+SKs+pt+iuzVwCJcXx5epw01L3slEO/ZtCtNhgo7mU
         SHHY6QzICQ7Gaorxpg91MFbFbrWGUe+PdupIkhLa9DPIkwSo+YBmEUKu0AkiOlm6Iw6F
         BzcIsFqaMmNDqXxBSpxQ5ygczbd/R90URX4QWItxpDPX0Rv+EBEdo1udSFJeIrF1B7lF
         sL8ufGcsRA4OBW+A04mwfc6nrW8veRGDYjGOiZqS8Cr1ENfQtSHrskqoHKXD7TXPfb2r
         0yQ6Gh8L9IqAhwJGXpw41WvMATcfSo/z2ulMh3pIaIPbD/LZEAGmvHyoLOw3ysyhkOMO
         I6Xg==
X-Gm-Message-State: AOAM533ErmQ9oJZDz8EqO0jGRfpw4uSy+5B7F7dHUj8smB570gnh6TY0
        9gkRHefsmJfPE/zvjz9xpY+Y17TpZco=
X-Google-Smtp-Source: ABdhPJxbMZM5tVC1oRl1HMm0WViRa9MjHO4MgKeCdchva1UXVmxvKax/Gvbx9nitYzaRV4C/6M/59g==
X-Received: by 2002:a19:641b:: with SMTP id y27mr5085626lfb.325.1604259262187;
        Sun, 01 Nov 2020 11:34:22 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id m12sm1766526ljc.88.2020.11.01.11.34.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2020 11:34:21 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Sergey Organov <sorganov@gmail.com>
Subject: [PATCH 20/26] diff-merges: refactor opt settings into separate functions
Date:   Sun,  1 Nov 2020 22:33:24 +0300
Message-Id: <20201101193330.24775-21-sorganov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201101193330.24775-1-sorganov@gmail.com>
References: <20201101193330.24775-1-sorganov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To prepare introduction of new options some of which will be synonyms
to existing options, let every option handling code just call
corresponding function.

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 diff-merges.c | 59 ++++++++++++++++++++++++++++++++-------------------
 1 file changed, 37 insertions(+), 22 deletions(-)

diff --git a/diff-merges.c b/diff-merges.c
index 29818abcc00e..8c22b447f106 100644
--- a/diff-merges.c
+++ b/diff-merges.c
@@ -9,11 +9,38 @@ static void suppress(struct rev_info *revs) {
 	revs->dense_combined_merges = 0;
 }
 
+static void set_separate(struct rev_info *revs) {
+	suppress(revs);
+	revs->separate_merges = 1;
+}
+
+static void set_m(struct rev_info *revs) {
+	/*
+	 * To "diff-index", "-m" means "match missing", and to the "log"
+	 * family of commands, it means "show full diff for merges". Set
+	 * both fields appropriately.
+	 */
+	set_separate(revs);
+	revs->match_missing = 1;
+}
+
+static void set_combined(struct rev_info *revs) {
+	revs->combine_merges = 1;
+	revs->dense_combined_merges = 0;
+}
+
 static void set_dense_combined(struct rev_info *revs) {
 	revs->combine_merges = 1;
 	revs->dense_combined_merges = 1;
 }
 
+static void set_diff_merges(struct rev_info *revs, const char *optarg) {
+	if (!strcmp(optarg, "off")) {
+		suppress(revs);
+	} else {
+		die(_("unknown value for --diff-merges: %s"), optarg);
+	}
+}
 
 /*
  * Public functions. They are in the order they are called.
@@ -24,31 +51,19 @@ int diff_merges_parse_opts(struct rev_info *revs, const char **argv) {
 	const char *optarg;
 	const char *arg = argv[0];
 
-	if (!strcmp(arg, "-m")) {
-		suppress(revs);
-		/*
-		 * To "diff-index", "-m" means "match missing", and to the "log"
-		 * family of commands, it means "show full diff for merges". Set
-		 * both fields appropriately.
-		 */
-		revs->separate_merges = 1;
-		revs->match_missing = 1;
-	} else if (!strcmp(arg, "-c")) {
-		revs->dense_combined_merges = 0;
-		revs->combine_merges = 1;
-	} else if (!strcmp(arg, "--cc")) {
+	if (!strcmp(arg, "-m"))
+		set_m(revs);
+	else if (!strcmp(arg, "-c"))
+		set_combined(revs);
+	else if (!strcmp(arg, "--cc"))
 		set_dense_combined(revs);
-	} else if (!strcmp(arg, "--no-diff-merges")) {
+	else if (!strcmp(arg, "--no-diff-merges"))
 		suppress(revs);
-	} else if (!strcmp(arg, "--combined-all-paths")) {
+	else if (!strcmp(arg, "--combined-all-paths"))
 		revs->combined_all_paths = 1;
-	} else if ((argcount = parse_long_opt("diff-merges", argv, &optarg))) {
-		if (!strcmp(optarg, "off")) {
-			suppress(revs);
-		} else {
-			die(_("unknown value for --diff-merges: %s"), optarg);
-		}
-	} else
+	else if ((argcount = parse_long_opt("diff-merges", argv, &optarg)))
+		set_diff_merges(revs, optarg);
+	else
 		return 0;
 
 	revs->explicit_diff_merges = 1;
-- 
2.25.1

