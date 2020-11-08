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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B306CC388F9
	for <git@archiver.kernel.org>; Sun,  8 Nov 2020 21:41:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59CF520656
	for <git@archiver.kernel.org>; Sun,  8 Nov 2020 21:41:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dFwPmKmU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728871AbgKHVlX (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 8 Nov 2020 16:41:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727570AbgKHVlW (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Nov 2020 16:41:22 -0500
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B370C0613CF
        for <git@vger.kernel.org>; Sun,  8 Nov 2020 13:41:22 -0800 (PST)
Received: by mail-lj1-x244.google.com with SMTP id y25so6928673lja.9
        for <git@vger.kernel.org>; Sun, 08 Nov 2020 13:41:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UdtQHjBNcJL3UN2wB1VmLveE4ycKuZLXDtFgxF9YfFU=;
        b=dFwPmKmUYOuo+yL63ZQRWl1SoaecGPbwH7/wtujLiHGCgSvEkAzVWDkGv7Ty//0Cee
         h6irxuBWSzjwYZj5XPq6daZ5fsrvucbTHRhf6BsmfeFqpCl9BuZUkJUh3JkhdAiW2DIZ
         v+WaWkp2zRBD3ukrWC0QP2y+EiHk4oJbDAsHHilkzV/WUcNjLbkzXGmlbK/HM4Mw4QwL
         au97LNULsantvM91NBVTprZhoj4ijU6zAqx6Qe1OiiCPcsdtUc8LpRhFJIUpWQTArNTo
         1NUoqdsr8A/8W+mO3nDQMrYB08UPlXQnx1XWOSOnWiXVdGn9MBitDM6nMXa38dE3YoqS
         RRmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UdtQHjBNcJL3UN2wB1VmLveE4ycKuZLXDtFgxF9YfFU=;
        b=XX3ZvrkZmcEPIb0j7FbeWypaYl+tKIqGHnXuYJpaV/jarqwpuEvu1t7YU+/doiolEl
         YE+rWfBOlBYTSOYoaNHTgHsgM/icvdQbYf7yqOmS1wuJuqNaI3JbOb14n57PA6i0CAFy
         JN+vBBt1Wy0+i8oySg7yHp/6qRMkLzv7IIbn/BmboQh8jGHfCaIZEeBMky7bBR1288qX
         KZOCfkUWfiGFFWXLS8y4pw6sXyzBGKhT+n65oHgGCpjFxBMLiw3j89nrkMT3ioqbAuCi
         t6qxL7+nd1680VvxXWMcZ3jrALww3Soo8C+ikqGJ0/byo0C4Kf/mAetF/8nADIrq5gtS
         Ef6Q==
X-Gm-Message-State: AOAM5305Jan0U9t+M7UFjY2Iji24FosiwtxmYwJmphfPMJDDGjIGLFpl
        bRVQd0TgWwgWWYc+cvVCEUA=
X-Google-Smtp-Source: ABdhPJxlFJMHlNL51pw9ZULXpUunmWirnQ5S4swgfdUGx+7g8KcJZyKPl0FAPyyJz3Iur/GppnaTxA==
X-Received: by 2002:a2e:b5b1:: with SMTP id f17mr243492ljn.291.1604871680809;
        Sun, 08 Nov 2020 13:41:20 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id k21sm1937392ljb.43.2020.11.08.13.41.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2020 13:41:20 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        git@vger.kernel.org, Sergey Organov <sorganov@gmail.com>
Subject: [PATCH v1 01/27] revision: factor out parsing of diff-merge related options
Date:   Mon,  9 Nov 2020 00:38:12 +0300
Message-Id: <20201108213838.4880-2-sorganov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201108213838.4880-1-sorganov@gmail.com>
References: <20201101193330.24775-1-sorganov@gmail.com>
 <20201108213838.4880-1-sorganov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move all the parsing code related to diffing merges into new
parse_diff_merge_opts() function.

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 revision.c | 66 ++++++++++++++++++++++++++++++++----------------------
 1 file changed, 39 insertions(+), 27 deletions(-)

diff --git a/revision.c b/revision.c
index aa6221204081..a09f4872acd7 100644
--- a/revision.c
+++ b/revision.c
@@ -2153,6 +2153,44 @@ static void add_message_grep(struct rev_info *revs, const char *pattern)
 	add_grep(revs, pattern, GREP_PATTERN_BODY);
 }
 
+static int parse_diff_merge_opts(struct rev_info *revs, const char **argv) {
+	int argcount;
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
+		return 0;
+
+	return 1;
+}
+
 static int handle_revision_opt(struct rev_info *revs, int argc, const char **argv,
 			       int *unkc, const char **unkv,
 			       const struct setup_revision_opt* opt)
@@ -2349,34 +2387,8 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
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

