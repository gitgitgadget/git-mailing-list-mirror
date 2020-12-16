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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3D93C2BBCA
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 18:52:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 634B82342C
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 18:52:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732246AbgLPSwC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Dec 2020 13:52:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732242AbgLPSwC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Dec 2020 13:52:02 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D54A5C0619D2
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 10:50:49 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id o13so27798432lfr.3
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 10:50:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nx0nrlAZcbTTgDQsVD7PY+kREjdUbQ0Un3LK+en8vyQ=;
        b=pyyhqe8zWpgfdA6MRkOuHS7dyk0xnFjLbudyyI1qxyEkZJwAMFRBD4x5AxuCanj/i/
         cVa6y65HCH7wa5Is0QRz1/KTD448IoJApfVHyk5mTisHCPefq89EA07dSXb3UwykO/pr
         CMhjrWRnT7g9NhnpxRxkJ7XbZHZ/SGS272dZjAG71UlDMHh6zqqINg+W+OkqXD7rjse6
         43qwVXbV08dOc8pqnGojoA8C4S70F66dAn8TZHJUMjf3YfvX9Q7Xab1ngfjrXhdAHEO7
         l50Jgwqrer5WbPjc7ftFPrjgxEWoz/T/0+o+L/MZENOUilWMd1fh992PAngQJNlqXKfZ
         tSkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nx0nrlAZcbTTgDQsVD7PY+kREjdUbQ0Un3LK+en8vyQ=;
        b=Rrp12hZXI4lIZfnFR+3eG7NEKbLpCrtbbLIWHR6KtFY98SSBXiui6HgJIfx86/OyYy
         9ShMIL4mG9kVBcqsN9cEP60nPaiS8KlbAZW+bH+fmQZTVrFR4NUnd0klTm0qtvKi2CBb
         BemJOsKI1x2pG4lfwAJHdI3ZuNX2IwQHewp1xYcu3yL7nBtA+V2naIQuXBuPBOS9h6fC
         cJGdEWvmY6LAPYGx/Fe+NbzG/uY8+G4AHb0AzNAHGBPyghbng4u3mwZQGsp+XPRgcsXH
         R6JT4INIfQ1MsOUQ32wGv++/CGCumcT1Fq9s3Qh+Y6+kmvX7wy7Tgkpff5hPjB4he04e
         18/A==
X-Gm-Message-State: AOAM532M+FSble9Oxmm78FW01qe7DmCvi2Cp1BPIWyCUJWYPUh3JQyqo
        SJheDB2g/gnhQ7O5MUnenjg=
X-Google-Smtp-Source: ABdhPJyfwrfWCf52l1hpDw6OlWpqpzt98gHRWJNEDt4q8ajf+xgiG27S301ulo0bmS5MLTPxz+wN+w==
X-Received: by 2002:a05:651c:301:: with SMTP id a1mr14493473ljp.275.1608144647552;
        Wed, 16 Dec 2020 10:50:47 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id 197sm313871lfe.158.2020.12.16.10.50.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 10:50:46 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>, git@vger.kernel.org,
        Sergey Organov <sorganov@gmail.com>
Subject: [PATCH v2 20/33] diff-merges: refactor opt settings into separate functions
Date:   Wed, 16 Dec 2020 21:49:16 +0300
Message-Id: <20201216184929.3924-21-sorganov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201216184929.3924-1-sorganov@gmail.com>
References: <20201101193330.24775-1-sorganov@gmail.com>
 <20201216184929.3924-1-sorganov@gmail.com>
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
index 9ff6ea02edb8..4c434e914c8d 100644
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

