Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 31E5E1F8CF
	for <e@80x24.org>; Fri,  9 Jun 2017 18:18:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751763AbdFISSQ (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Jun 2017 14:18:16 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:34565 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751538AbdFISSG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Jun 2017 14:18:06 -0400
Received: by mail-wr0-f194.google.com with SMTP id u101so8437154wrc.1
        for <git@vger.kernel.org>; Fri, 09 Jun 2017 11:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SE94Lw/jMz84uYszzz4k7Nlc0z4LTE5n83hVAxCCyIk=;
        b=DB/RHbH9aZi3vGKuzydXwDhf5CByEsvFjkOkrWkevfPonJ1o366Me5dSz+B5Zgohz3
         ri5ycsNJolfR3+waCfNTE6YTWJ98B7AQNPr8Yut/YTeozeTkdWMMlwHAk15NUXqFRwJa
         7aitlfMepg//G52QYOnFsU/nEZ6h1bwJO3KTB3o8wmNrcki2f87bY14ub1Mf5dNHDxze
         5jNofLdSKeG4Gdgj3Hn2YNf81QdYK6pBoAQcXO3edyw8pO0Nor/I05Q5T5Cj1/15Aa2e
         QVM67nPC2HfeZXV1x7yKbDRqVZQs2MqdrwyCjKi6TEZBCRourcBUXpEjdNrg880NQDol
         SIVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SE94Lw/jMz84uYszzz4k7Nlc0z4LTE5n83hVAxCCyIk=;
        b=EZzERQ88NPYd+CeNIzcb742A5AJCDfUxPpTY0V5tmvSopUOoiJCG+wF2H2UP2K168J
         Juq4RfKyTN6LmxJzPX1TCWislKtcpONuQPEEhPSSk5HMCvElb9V41ldtt7bFVjuhEyXx
         QSErLq7fu3EqVw/y/0QG8TJMdD1v6fh5F/onLU7K5vG4wDASraXTRWpTEkXjuCVkEYce
         Oo0Dtwg/Twss7+XL/MeQOLGxjRupDn2FOugVnmHjYtKhLpy7bmKCX03C7L0kRhRU4Khv
         ZFCV17mnIsijgNJXlSZKK/Rbq9jfoqorONLO3GFBjrU4N7w8mH1PBvkwILGZOogDfwJF
         Vlhg==
X-Gm-Message-State: AKS2vOxJsOGQ/EPFm4RpvKtCdG4nsfsFNy51v94zzoHTbL1oMphlEdv7
        pr2uw+rK09ZiSw==
X-Received: by 10.28.28.146 with SMTP id c140mr907573wmc.122.1497032284134;
        Fri, 09 Jun 2017 11:18:04 -0700 (PDT)
Received: from localhost.localdomain (x590e0f24.dyn.telefonica.de. [89.14.15.36])
        by smtp.gmail.com with ESMTPSA id g46sm3485851wrg.69.2017.06.09.11.18.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 09 Jun 2017 11:18:03 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCHv2 4/5] revision.c: use skip_prefix() in handle_revision_opt()
Date:   Fri,  9 Jun 2017 20:17:32 +0200
Message-Id: <20170609181733.6793-5-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.13.0.420.g54001f015
In-Reply-To: <20170609181733.6793-1-szeder.dev@gmail.com>
References: <20170602201143.6avkhp224no3dukb@sigill.intra.peff.net>
 <20170609181733.6793-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of starts_with() and a bunch of magic numbers.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 revision.c | 48 +++++++++++++++++++++++-------------------------
 1 file changed, 23 insertions(+), 25 deletions(-)

diff --git a/revision.c b/revision.c
index 68531ff5d..c99c47c50 100644
--- a/revision.c
+++ b/revision.c
@@ -1725,8 +1725,8 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		revs->max_count = atoi(argv[1]);
 		revs->no_walk = 0;
 		return 2;
-	} else if (starts_with(arg, "-n")) {
-		revs->max_count = atoi(arg + 2);
+	} else if (skip_prefix(arg, "-n", &optarg)) {
+		revs->max_count = atoi(optarg);
 		revs->no_walk = 0;
 	} else if ((argcount = parse_long_opt("max-age", argv, &optarg))) {
 		revs->max_age = atoi(optarg);
@@ -1807,12 +1807,12 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		revs->min_parents = 2;
 	} else if (!strcmp(arg, "--no-merges")) {
 		revs->max_parents = 1;
-	} else if (starts_with(arg, "--min-parents=")) {
-		revs->min_parents = atoi(arg+14);
+	} else if (skip_prefix(arg, "--min-parents=", &optarg)) {
+		revs->min_parents = atoi(optarg);
 	} else if (!strcmp(arg, "--no-min-parents")) {
 		revs->min_parents = 0;
-	} else if (starts_with(arg, "--max-parents=")) {
-		revs->max_parents = atoi(arg+14);
+	} else if (skip_prefix(arg, "--max-parents=", &optarg)) {
+		revs->max_parents = atoi(optarg);
 	} else if (!strcmp(arg, "--no-max-parents")) {
 		revs->max_parents = -1;
 	} else if (!strcmp(arg, "--boundary")) {
@@ -1894,14 +1894,15 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		revs->verbose_header = 1;
 		revs->pretty_given = 1;
 		get_commit_format(NULL, revs);
-	} else if (starts_with(arg, "--pretty=") || starts_with(arg, "--format=")) {
+	} else if (skip_prefix(arg, "--pretty=", &optarg) ||
+		   skip_prefix(arg, "--format=", &optarg)) {
 		/*
 		 * Detached form ("--pretty X" as opposed to "--pretty=X")
 		 * not allowed, since the argument is optional.
 		 */
 		revs->verbose_header = 1;
 		revs->pretty_given = 1;
-		get_commit_format(arg+9, revs);
+		get_commit_format(optarg, revs);
 	} else if (!strcmp(arg, "--expand-tabs")) {
 		revs->expand_tabs_in_log = 8;
 	} else if (!strcmp(arg, "--no-expand-tabs")) {
@@ -1919,26 +1920,23 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		revs->show_signature = 1;
 	} else if (!strcmp(arg, "--no-show-signature")) {
 		revs->show_signature = 0;
-	} else if (!strcmp(arg, "--show-linear-break") ||
-		   starts_with(arg, "--show-linear-break=")) {
-		if (starts_with(arg, "--show-linear-break="))
-			revs->break_bar = xstrdup(arg + 20);
-		else
-			revs->break_bar = "                    ..........";
+	} else if (!strcmp(arg, "--show-linear-break")) {
+		revs->break_bar = "                    ..........";
+		revs->track_linear = 1;
+		revs->track_first_time = 1;
+	} else if (skip_prefix(arg, "--show-linear-break=", &optarg)) {
+		revs->break_bar = xstrdup(optarg);
 		revs->track_linear = 1;
 		revs->track_first_time = 1;
-	} else if (starts_with(arg, "--show-notes=") ||
-		   starts_with(arg, "--notes=")) {
+	} else if (skip_prefix(arg, "--show-notes=", &optarg) ||
+		   skip_prefix(arg, "--notes=", &optarg)) {
 		struct strbuf buf = STRBUF_INIT;
 		revs->show_notes = 1;
 		revs->show_notes_given = 1;
-		if (starts_with(arg, "--show-notes")) {
-			if (revs->notes_opt.use_default_notes < 0)
-				revs->notes_opt.use_default_notes = 1;
-			strbuf_addstr(&buf, arg+13);
-		}
-		else
-			strbuf_addstr(&buf, arg+8);
+		if (starts_with(arg, "--show-notes=") &&
+		    revs->notes_opt.use_default_notes < 0)
+			revs->notes_opt.use_default_notes = 1;
+		strbuf_addstr(&buf, optarg);
 		expand_notes_ref(&buf);
 		string_list_append(&revs->notes_opt.extra_notes_refs,
 				   strbuf_detach(&buf, NULL));
@@ -1975,8 +1973,8 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		revs->abbrev = 0;
 	} else if (!strcmp(arg, "--abbrev")) {
 		revs->abbrev = DEFAULT_ABBREV;
-	} else if (starts_with(arg, "--abbrev=")) {
-		revs->abbrev = strtoul(arg + 9, NULL, 10);
+	} else if (skip_prefix(arg, "--abbrev=", &optarg)) {
+		revs->abbrev = strtoul(optarg, NULL, 10);
 		if (revs->abbrev < MINIMUM_ABBREV)
 			revs->abbrev = MINIMUM_ABBREV;
 		else if (revs->abbrev > 40)
-- 
2.13.0.420.g54001f015

