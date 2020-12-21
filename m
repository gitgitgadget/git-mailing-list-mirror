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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FCD2C433E6
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 18:33:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A2C3230FC
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 18:33:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbgLUSdC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Dec 2020 13:33:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725953AbgLUSdC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Dec 2020 13:33:02 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8B76C061793
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 10:32:21 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id lt17so14806322ejb.3
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 10:32:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CfkxbejOxM56mU9DMpXRocxRv86D3jT5RYLM0GM3qkY=;
        b=lW7XsDc5ooCrDkJwvx/IzFXshdNSxBvYiDhZEb7eG8X3w5u7RFvF09VD5bYZuV2Rx0
         hzOnJBpr1e/E+2AwSZotn8KcTIVGqqLNv7t5bCYXjaoauc3FgsILW5HeKei//yoNgHW5
         czX2U/OgxR5yCWAgwQBBzlUmfZTKZ3o2AgtHMqTZVYiZbLhXmPmpBcnVBvKcYhulwGt+
         szsV3mMt7lj7wIeZURD7ndbc1nWCC25e+Ry94GrSlQ370xTxIrmdyD5CeW4cqDePm1B/
         eT8XdPRFPU2vYybO5sAuitReiWUi6T3ZM7cY/RcJO7oMTYygID0hv+4mq+Nmta5odEjQ
         8H3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CfkxbejOxM56mU9DMpXRocxRv86D3jT5RYLM0GM3qkY=;
        b=BZ4khApEElZsiI6eL48S45mTJMBNS0qz3ib31Wijno27vUASr/dI2RHVClnjY7n2yC
         EGCw1QzCkLjow6Xm19jinKrrWKFLt7p4odnMQo31ZSHMO/Lo1p6SLfuvcnHOJZ+LzU4y
         0jwdraEf1L32R8ADpyXrrMPy9Z6+zatLEpAmo+1hbpGDS3qP0tR6ps6GTc3ciqPbC/0U
         5ywt6aMBr6l4C+HwT/F9uUQ8RZwCmZmO3aXzXq/EQDpzyZ7cyiWg9VfJ7IsnBNfWKH4C
         4wV8wqDTRm08W1BTeeVCVPdh8YzowWKJmWt+kO39u+LfOOXH9lnTz5rMEnywWCJREGb6
         rTMA==
X-Gm-Message-State: AOAM530VUelOoTC3QXWF72L68VnzhTPACh36aXf0ldBmsleQMpelumkQ
        OSNCJrn5CLVZbdxOxvPyqXzXMcNxc5I=
X-Google-Smtp-Source: ABdhPJwc0zKYb4M4RIJvjkUGuBpVdLAGpyVSDRr5+Fc8yutxKnF1xT8OTnkzs26ejWKW0HrMUSj22g==
X-Received: by 2002:a2e:9ad3:: with SMTP id p19mr7253701ljj.286.1608564057391;
        Mon, 21 Dec 2020 07:20:57 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id c5sm2220085ljj.67.2020.12.21.07.20.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Dec 2020 07:20:56 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        git@vger.kernel.org, Sergey Organov <sorganov@gmail.com>
Subject: [PATCH v3 21/32] diff-merges: refactor opt settings into separate functions
Date:   Mon, 21 Dec 2020 18:19:49 +0300
Message-Id: <20201221152000.13134-22-sorganov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201221152000.13134-1-sorganov@gmail.com>
References: <20201101193330.24775-1-sorganov@gmail.com>
 <20201221152000.13134-1-sorganov@gmail.com>
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
 diff-merges.c | 63 +++++++++++++++++++++++++++++++++------------------
 1 file changed, 41 insertions(+), 22 deletions(-)

diff --git a/diff-merges.c b/diff-merges.c
index 34d7ed7c70b7..b8fd92adcf16 100644
--- a/diff-merges.c
+++ b/diff-merges.c
@@ -10,12 +10,43 @@ static void suppress(struct rev_info *revs)
 	revs->dense_combined_merges = 0;
 }
 
+static void set_separate(struct rev_info *revs)
+{
+	suppress(revs);
+	revs->separate_merges = 1;
+}
+
+static void set_m(struct rev_info *revs)
+{
+	/*
+	 * To "diff-index", "-m" means "match missing", and to the "log"
+	 * family of commands, it means "show full diff for merges". Set
+	 * both fields appropriately.
+	 */
+	set_separate(revs);
+	revs->match_missing = 1;
+}
+
+static void set_combined(struct rev_info *revs)
+{
+	revs->combine_merges = 1;
+	revs->dense_combined_merges = 0;
+}
+
 static void set_dense_combined(struct rev_info *revs)
 {
 	revs->combine_merges = 1;
 	revs->dense_combined_merges = 1;
 }
 
+static void set_diff_merges(struct rev_info *revs, const char *optarg)
+{
+	if (!strcmp(optarg, "off")) {
+		suppress(revs);
+	} else {
+		die(_("unknown value for --diff-merges: %s"), optarg);
+	}
+}
 
 /*
  * Public functions. They are in the order they are called.
@@ -27,31 +58,19 @@ int diff_merges_parse_opts(struct rev_info *revs, const char **argv)
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

