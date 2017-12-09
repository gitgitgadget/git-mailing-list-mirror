Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D99111F406
	for <e@80x24.org>; Sat,  9 Dec 2017 20:40:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751347AbdLIUke (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Dec 2017 15:40:34 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:39674 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751306AbdLIUkd (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Dec 2017 15:40:33 -0500
Received: by mail-wr0-f195.google.com with SMTP id a41so13855633wra.6
        for <git@vger.kernel.org>; Sat, 09 Dec 2017 12:40:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=eMXwHCKsnVPja/Vg6r6FmSVai332qqLNIKwnsC0erRA=;
        b=a8gVXxSryXOkED8riX89Maar5cBuIoVA3jWI51OPXXQJ6jk9JrRpyWDR/88w2GWToy
         y7yIPqu8Abaavz8DvX6IBDS6IbffCH83komJC2s1FGSOsVT7Fm1vfCusMm8O+/sSoYU6
         0f9wHh9vWo6LwhHmkE22c3qMGJDnVkMHD+ini1SGgOR7mX2FMv91AhzKF1cxQuZlIA9P
         kKZpTcqsa0IkChVbLjGmYRvEl8hvkK4ALox3BwEIxLL6dkVDPYqd6QIPwI9N4D8KZuYy
         RerZZgE3pL8aMkq93lnF1djQWt5SnBHe5uEwm/6eQyqZ+g2XOvHQE66YnIjJZsnYLibP
         shhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=eMXwHCKsnVPja/Vg6r6FmSVai332qqLNIKwnsC0erRA=;
        b=E2b5TaubQhV8I46G3YD95xzjBSfacJwuAm3g0t8EDK1cRPzsw1Mr4PmYQNWQXRnx5o
         xQZ5uH90UfpBdPrE4viP91A8copkN51dl3yaIdDqDzNwQY9qh2jyBAkNIwydIQb3uZbj
         W3ZdupZRiJ1mNq9dWx5Wn9gYjrsvc4H2gmKAY/l7R6yZFt8ilAZlMS2dG9M0rW6yh/zK
         USe9rYNY+TEumoyCuvRfsbaF4ab09FU8tVAPLlcIz94zwWZqlk+KnUz4/9/9GUFHZBXp
         yLDrVkS6u/RQ+XZgTMW/X2z1xolMjbEBI2TfSNMDaKIjrsNQBgq2/SEy76Q1G3h2je9t
         WR4g==
X-Gm-Message-State: AJaThX4PLnDUShdR0WGoAm+m0DGpAqq0PAIYIrV0hEUnqBV39H/2uJHQ
        0PKB3X9+yZxlAiD29c1OeCrM22jP
X-Google-Smtp-Source: AGs4zMYc8v5BeXET9p/Qy3uGWhwJbM/pDCAXZrMSvOAIifMcnzjxdVVy7rnzAZA4DaItAcV+Lq2DAQ==
X-Received: by 10.223.185.79 with SMTP id b15mr31448509wrg.58.1512852031550;
        Sat, 09 Dec 2017 12:40:31 -0800 (PST)
Received: from localhost.localdomain (sud35-h04-89-95-107-230.dsl.sta.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id v18sm12491283wrv.37.2017.12.09.12.40.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 09 Dec 2017 12:40:30 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Donald R Laster Jr <laster@dlaster.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 4/7] diff: use skip_to_optional_arg_default()
Date:   Sat,  9 Dec 2017 21:40:10 +0100
Message-Id: <20171209204013.10997-4-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.15.1.361.g8b07d831d0
In-Reply-To: <20171209204013.10997-1-chriscool@tuxfamily.org>
References: <20171209204013.10997-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Christian Couder <christian.couder@gmail.com>

Let's simplify diff option parsing using
skip_to_optional_arg_default().

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff.c | 20 ++++----------------
 1 file changed, 4 insertions(+), 16 deletions(-)

diff --git a/diff.c b/diff.c
index 464a53adb5..28e1ab168f 100644
--- a/diff.c
+++ b/diff.c
@@ -4623,9 +4623,7 @@ int diff_opt_parse(struct diff_options *options,
 	else if (!strcmp(arg, "--no-follow")) {
 		options->flags.follow_renames = 0;
 		options->flags.default_follow_renames = 0;
-	} else if (!strcmp(arg, "--color"))
-		options->use_color = 1;
-	else if (skip_prefix(arg, "--color=", &arg)) {
+	} else if (skip_to_optional_arg_default(arg, "--color", &arg, "always")) {
 		int value = git_config_colorbool(NULL, arg);
 		if (value < 0)
 			return error("option `color' expects \"always\", \"auto\", or \"never\"");
@@ -4645,14 +4643,9 @@ int diff_opt_parse(struct diff_options *options,
 		if (cm < 0)
 			die("bad --color-moved argument: %s", arg);
 		options->color_moved = cm;
-	} else if (!strcmp(arg, "--color-words")) {
-		options->use_color = 1;
-		options->word_diff = DIFF_WORDS_COLOR;
-	}
-	else if (skip_prefix(arg, "--color-words=", &arg)) {
+	} else if (skip_to_optional_arg_default(arg, "--color-words", &options->word_regex, NULL)) {
 		options->use_color = 1;
 		options->word_diff = DIFF_WORDS_COLOR;
-		options->word_regex = arg;
 	}
 	else if (!strcmp(arg, "--word-diff")) {
 		if (options->word_diff == DIFF_WORDS_NONE)
@@ -4691,15 +4684,10 @@ int diff_opt_parse(struct diff_options *options,
 		options->flags.textconv_set_via_cmdline = 1;
 	} else if (!strcmp(arg, "--no-textconv"))
 		options->flags.allow_textconv = 0;
-	else if (!strcmp(arg, "--ignore-submodules")) {
-		options->flags.override_submodule_config = 1;
-		handle_ignore_submodules_arg(options, "all");
-	} else if (skip_prefix(arg, "--ignore-submodules=", &arg)) {
+	else if (skip_to_optional_arg_default(arg, "--ignore-submodules", &arg, "all")) {
 		options->flags.override_submodule_config = 1;
 		handle_ignore_submodules_arg(options, arg);
-	} else if (!strcmp(arg, "--submodule"))
-		options->submodule_format = DIFF_SUBMODULE_LOG;
-	else if (skip_prefix(arg, "--submodule=", &arg))
+	} else if (skip_to_optional_arg_default(arg, "--submodule", &arg, "log"))
 		return parse_submodule_opt(options, arg);
 	else if (skip_prefix(arg, "--ws-error-highlight=", &arg))
 		return parse_ws_error_highlight_opt(options, arg);
-- 
2.15.1.361.g8b07d831d0

