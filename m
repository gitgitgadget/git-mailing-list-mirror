Return-Path: <SRS0=1y/A=EO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83C72C61DD8
	for <git@archiver.kernel.org>; Sun,  8 Nov 2020 21:41:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DF16206ED
	for <git@archiver.kernel.org>; Sun,  8 Nov 2020 21:41:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RYjJXso2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729013AbgKHVlp (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 8 Nov 2020 16:41:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728971AbgKHVlk (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Nov 2020 16:41:40 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 563C1C0613D2
        for <git@vger.kernel.org>; Sun,  8 Nov 2020 13:41:40 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id e27so9553414lfn.7
        for <git@vger.kernel.org>; Sun, 08 Nov 2020 13:41:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mxL+yxGkREL9Bx+2kD827DLOziGiEYPg/QyJ/uLUuh0=;
        b=RYjJXso2Lg5lPqPtutOfdP7N5H5FCRoYNzvDzjMYIlZ23yF+r9W+Imgi7/IVPcc5yX
         jEQWs1Ugfw0bjFxGJFFMOaXZCQ4qOSk8wZ3WbiB/jo2WFwF0p5LIq9K81u+ods13XCEp
         VbNFrd11wuEVVf8mjkbxgxUm778T8kCQsHZBWMMR3m/H0sbb0L4K5C+8XjFOxjhW2dm3
         afOZvvZCXNGeLAbWnFRsUJz1nFrwySvS1yAT0C136ihlfvZ7e4hIpwEWoDk6VOdz3G6f
         xJtFydpFj1+AQ3CZAGjMGqd/d0VRP2vjhqV/yk/cn905gYXqSV/7hspOqGjd86uWa0GF
         n52A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mxL+yxGkREL9Bx+2kD827DLOziGiEYPg/QyJ/uLUuh0=;
        b=bQEZSTlNkUYb0PxQghh7Cl5M6PrPvq4iK+YifmB6Y1G0pT+xZUGhMeC0tu0Cppt9Wq
         SICmfGGnuR+EmpxGXsWCi7POp1UKeBDvmInNV9n8tOl4kakidPpUFB2ZH2WFTMy8vENj
         /zes+XzRmEdtzubtgF6P5JYrz1fT+vJ1igSfLN7TsmAID4+b7qoUuA4n8vAthiLEbnQK
         JFG0qjPFNmblaAOa36la4Bqy4Wzx+ZDwqjPtmoH2GenJCW/ayE9P0PztkPrhdZMwvlED
         +LrGjIJeP/psvz1MWzUS21edokhTBBblJB9TQZPGW+7N5GUPbwIhOwh/A1hKs+JthK8o
         T52Q==
X-Gm-Message-State: AOAM530roIhWHgQYFLjJQY/IVw3zzOZFQ9VjhCoJ3IyxUn+s5/P/GRUm
        KnE04NsbM6k3UahXaqQ2bBw=
X-Google-Smtp-Source: ABdhPJy3dcKtPzDfKhdXGtxM6pXCjz599mgVwbepXlps04+U3Vbz2UZGjseknGrlRd5EOiNmEBo6oA==
X-Received: by 2002:ac2:4893:: with SMTP id x19mr4223721lfc.309.1604871698870;
        Sun, 08 Nov 2020 13:41:38 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id k21sm1937392ljb.43.2020.11.08.13.41.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2020 13:41:38 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        git@vger.kernel.org, Sergey Organov <sorganov@gmail.com>
Subject: [PATCH v1 20/27] diff-merges: refactor opt settings into separate functions
Date:   Mon,  9 Nov 2020 00:38:31 +0300
Message-Id: <20201108213838.4880-21-sorganov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201108213838.4880-1-sorganov@gmail.com>
References: <20201101193330.24775-1-sorganov@gmail.com>
 <20201108213838.4880-1-sorganov@gmail.com>
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

