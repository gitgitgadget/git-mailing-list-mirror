Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DC1B720D13
	for <e@80x24.org>; Fri,  2 Jun 2017 19:10:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751163AbdFBTKU (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Jun 2017 15:10:20 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34287 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750918AbdFBTKS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jun 2017 15:10:18 -0400
Received: by mail-wm0-f67.google.com with SMTP id d127so20334191wmf.1
        for <git@vger.kernel.org>; Fri, 02 Jun 2017 12:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fwRY9cviDoo0Ln1G8UJ5eWpH2wkgnpmlrzJc6AXfVEg=;
        b=t6gjadugqP5q796tLTzUTkMVxxs6mUuVNHsZhl+3SsS1kWkjuiiRqRqmdR0K09uVi7
         prpBZKOG/6vmuW/y+Vwi8xgBQ0w2C+Qu4dkeoeQWm7OLkNpyqk9ieu2qgohh18iIFFFI
         kh6xik82hQqKfgOJ0J6W1pD2qYqTl2J/dptpOjfFBpuqGnNZ/CDe2S7d5lb4KfjMGjWA
         nehGw3rjYkOQrJ7lMFBqr6xd0udAh3Omtns6nqAhtCUlxfoECLsDHpJfcU5Z/DTz3bHK
         RU6SPPId0Wo08KKRe9pazJiy1tl576JbKdLzGLKxw2LbmnmJUIyJ/a+G0GHq0+yn95oe
         qkmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fwRY9cviDoo0Ln1G8UJ5eWpH2wkgnpmlrzJc6AXfVEg=;
        b=I7VSoO18gZDZR8DfjW5c5VSV3YPDsyUGpyhCqVr+sDatjnCsc6u4qG4647Knn2eJDz
         yR8g/xC8hDGc5YZRW86IT6Od+K3DtE7ggha0GmrQjMnaGBBwOITHnwIa657rruvsFyxP
         WZB2xf+doconBBfQLU2sTSxS4FnPnk1EkQiFaX6WXBdbAbMmWGMQPLgcIHam/GazWxpS
         sGfgEU/hVFv7VUTerCimdiTc0tdyIDvw4xniDrAGV4kfuVriYgn8uFELXaGFdU0uCczV
         biiW3obTd0h1me4gxRuX19GvrIruPYifaOJtUVrhxs3bV0rsX0ineJJK7e6tEHMQVC9T
         RarA==
X-Gm-Message-State: AODbwcAzij+QtMR3+mmTSUfrZHYQVTtWZ3qao/8bpSOwGOg55jxJJsfE
        jZNWRlhXJXPMUIOM
X-Received: by 10.80.195.17 with SMTP id a17mr7118281edb.9.1496430617185;
        Fri, 02 Jun 2017 12:10:17 -0700 (PDT)
Received: from localhost.localdomain (x4db0e5ea.dyn.telefonica.de. [77.176.229.234])
        by smtp.gmail.com with ESMTPSA id j50sm8552465eda.44.2017.06.02.12.10.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 02 Jun 2017 12:10:16 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 2/3] revision.c: use skip_prefix() in handle_revision_opt()
Date:   Fri,  2 Jun 2017 21:10:09 +0200
Message-Id: <20170602191010.16834-3-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.13.0.420.g54001f015
In-Reply-To: <20170602191010.16834-1-szeder.dev@gmail.com>
References: <20170602191010.16834-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of starts_with() and a bunch of magic numbers.

While at it, there is an indentation fix where processing
'--early-output', and a coding style fix where processing
'--show-notes'.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 revision.c | 54 ++++++++++++++++++++++++++++--------------------------
 1 file changed, 28 insertions(+), 26 deletions(-)

diff --git a/revision.c b/revision.c
index 2f37e1e3a..2b64b7e0e 100644
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
@@ -1785,15 +1785,15 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 	} else if (!strcmp(arg, "--author-date-order")) {
 		revs->sort_order = REV_SORT_BY_AUTHOR_DATE;
 		revs->topo_order = 1;
-	} else if (starts_with(arg, "--early-output")) {
+	} else if (skip_prefix(arg, "--early-output", &optarg)) {
 		int count = 100;
-		switch (arg[14]) {
+		switch (*optarg) {
 		case '=':
-			count = atoi(arg+15);
+			count = atoi(optarg + 1);
 			/* Fallthrough */
 		case 0:
 			revs->topo_order = 1;
-		       revs->early_output = count;
+			revs->early_output = count;
 		}
 	} else if (!strcmp(arg, "--parents")) {
 		revs->rewrite_parents = 1;
@@ -1810,12 +1810,12 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
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
@@ -1897,14 +1897,15 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
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
@@ -1922,26 +1923,27 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		revs->show_signature = 1;
 	} else if (!strcmp(arg, "--no-show-signature")) {
 		revs->show_signature = 0;
-	} else if (!strcmp(arg, "--show-linear-break") ||
-		   starts_with(arg, "--show-linear-break=")) {
-		if (starts_with(arg, "--show-linear-break="))
-			revs->break_bar = xstrdup(arg + 20);
-		else
+	} else if (skip_prefix(arg, "--show-linear-break", &optarg)) {
+		switch (*optarg) {
+		case '=':
+			revs->break_bar = xstrdup(optarg + 1);
+			break;
+		case 0:
 			revs->break_bar = "                    ..........";
+		}
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
+		if (starts_with(arg, "--show-notes=")) {
 			if (revs->notes_opt.use_default_notes < 0)
 				revs->notes_opt.use_default_notes = 1;
-			strbuf_addstr(&buf, arg+13);
-		}
-		else
-			strbuf_addstr(&buf, arg+8);
+			strbuf_addstr(&buf, optarg);
+		} else
+			strbuf_addstr(&buf, optarg);
 		expand_notes_ref(&buf);
 		string_list_append(&revs->notes_opt.extra_notes_refs,
 				   strbuf_detach(&buf, NULL));
@@ -1978,8 +1980,8 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
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

