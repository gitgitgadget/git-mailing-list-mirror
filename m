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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97EEAC433E0
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 19:13:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BC0B22527
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 19:13:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726071AbgLUTMU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Dec 2020 14:12:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725785AbgLUTMU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Dec 2020 14:12:20 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC7F0C061793
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 11:11:38 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id a12so26273475lfl.6
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 11:11:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mV2DL/c4HjDqgMyPJ4ynRIXRuP9LpBLgsziGY0pucv8=;
        b=Sqzdi9LdIjYacvC0tbmB5xYsoZlhiFO8Ed3Sw00U5PYF8A7InonkauMOfjvPBjekjv
         hn2/G6kdBKCSPHLJdtrUoWFhFJVZAJ6avFg7/ot3C1uRtKIP+C5AAmqXO0Jrcqlbick0
         9r/pmkfk+6flhXJXtI3SGq6BF0cqiofbyPMs14XzZooGDOe2ShFUpkDVF3rOYpn3BzbS
         LOtd7+8tJRaA5NB1a9m97K/iUdoQ8MF5xiz7Cv6wYMYG5iW099JTlkCV70n2BRekCdCw
         yjf9zXueJ7fXA/7By+aigYYuRMmVRq96eTVQtN2WvKphuCWWK8S/dh+TypKPQuP6ZvdV
         bF+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mV2DL/c4HjDqgMyPJ4ynRIXRuP9LpBLgsziGY0pucv8=;
        b=Vrzfeh+J0wJ7SMj215hx3WBIU3tWnsa59t6++32RI12OHB3qU6F3Z1tp3n1BRI6oLA
         SWAchEaKUyMLRMdUHENY6iy7elPSiNWGSQs20MFhm9OGG6kCzii/heKYCeXDh71tUIr5
         BfrOICFH3zRqb8CJJZ6NwBXw/r4FBtcnjj8P7vR0vILnpEOXT23xZVLebOfk0IlkakXg
         qQiM6rVsauvf4hMGDMi3bg3uCmc5vj+bN5X4g5fconHwdVr6+qUqSbC0nBIYP/4t/Nch
         vXHPHL+vNKeOqVIC3P9SAriWwvJiTUPicjLDzHNxW/0RyV1wFXKL4czXOmxhCNiD09Je
         gDgg==
X-Gm-Message-State: AOAM530v5kh9QyZAy4b7qxL1aAkhQmBw3Qsc0Y+yYxZ6/Mh/yBSrKZg/
        nA/j8m7RraKH2nmDcvUToGlfTapaMvk=
X-Google-Smtp-Source: ABdhPJyDljoRLHThiGAMvLgwux3DQohDiD8FovgpxA0/uWorgpg5AfzdUhwp+Aznl/ZfT1npb8YEfA==
X-Received: by 2002:a2e:b88e:: with SMTP id r14mr7382525ljp.254.1608564034096;
        Mon, 21 Dec 2020 07:20:34 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id c5sm2220085ljj.67.2020.12.21.07.20.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Dec 2020 07:20:33 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        git@vger.kernel.org, Sergey Organov <sorganov@gmail.com>
Subject: [PATCH v3 01/32] revision: factor out parsing of diff-merge related options
Date:   Mon, 21 Dec 2020 18:19:29 +0300
Message-Id: <20201221152000.13134-2-sorganov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201221152000.13134-1-sorganov@gmail.com>
References: <20201101193330.24775-1-sorganov@gmail.com>
 <20201221152000.13134-1-sorganov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move all the parsing code related to diffing merges into new
parse_diff_merge_opts() function.

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 revision.c | 67 ++++++++++++++++++++++++++++++++----------------------
 1 file changed, 40 insertions(+), 27 deletions(-)

diff --git a/revision.c b/revision.c
index aa6221204081..8b17cfd754fe 100644
--- a/revision.c
+++ b/revision.c
@@ -2153,6 +2153,45 @@ static void add_message_grep(struct rev_info *revs, const char *pattern)
 	add_grep(revs, pattern, GREP_PATTERN_BODY);
 }
 
+static int parse_diff_merge_opts(struct rev_info *revs, const char **argv)
+{
+	int argcount = 1;
+	const char *optarg;
+	const char *arg = argv[0];
+
+	if (!strcmp(arg, "-m")) {
+		/*
+		 * To "diff-index", "-m" means "match missing", and to the "log"
+		 * family of commands, it means "show full diff for merges". Set
+		 * both fields appropriately.
+		 */
+		revs->ignore_merges = 0;
+		revs->match_missing = 1;
+	} else if (!strcmp(arg, "-c")) {
+		revs->diff = 1;
+		revs->dense_combined_merges = 0;
+		revs->combine_merges = 1;
+	} else if (!strcmp(arg, "--cc")) {
+		revs->diff = 1;
+		revs->dense_combined_merges = 1;
+		revs->combine_merges = 1;
+	} else if (!strcmp(arg, "--no-diff-merges")) {
+		revs->ignore_merges = 1;
+	} else if (!strcmp(arg, "--combined-all-paths")) {
+		revs->diff = 1;
+		revs->combined_all_paths = 1;
+	} else if ((argcount = parse_long_opt("diff-merges", argv, &optarg))) {
+		if (!strcmp(optarg, "off")) {
+			revs->ignore_merges = 1;
+		} else {
+			die(_("unknown value for --diff-merges: %s"), optarg);
+		}
+	} else
+		argcount = 0;
+
+	return argcount;
+}
+
 static int handle_revision_opt(struct rev_info *revs, int argc, const char **argv,
 			       int *unkc, const char **unkv,
 			       const struct setup_revision_opt* opt)
@@ -2349,34 +2388,8 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		revs->diff = 1;
 		revs->diffopt.flags.recursive = 1;
 		revs->diffopt.flags.tree_in_recursive = 1;
-	} else if (!strcmp(arg, "-m")) {
-		/*
-		 * To "diff-index", "-m" means "match missing", and to the "log"
-		 * family of commands, it means "show full diff for merges". Set
-		 * both fields appropriately.
-		 */
-		revs->ignore_merges = 0;
-		revs->match_missing = 1;
-	} else if ((argcount = parse_long_opt("diff-merges", argv, &optarg))) {
-		if (!strcmp(optarg, "off")) {
-			revs->ignore_merges = 1;
-		} else {
-			die(_("unknown value for --diff-merges: %s"), optarg);
-		}
+	} else if ((argcount = parse_diff_merge_opts(revs, argv))) {
 		return argcount;
-	} else if (!strcmp(arg, "--no-diff-merges")) {
-		revs->ignore_merges = 1;
-	} else if (!strcmp(arg, "-c")) {
-		revs->diff = 1;
-		revs->dense_combined_merges = 0;
-		revs->combine_merges = 1;
-	} else if (!strcmp(arg, "--combined-all-paths")) {
-		revs->diff = 1;
-		revs->combined_all_paths = 1;
-	} else if (!strcmp(arg, "--cc")) {
-		revs->diff = 1;
-		revs->dense_combined_merges = 1;
-		revs->combine_merges = 1;
 	} else if (!strcmp(arg, "-v")) {
 		revs->verbose_header = 1;
 	} else if (!strcmp(arg, "--pretty")) {
-- 
2.25.1

