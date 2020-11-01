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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCA66C2D0A3
	for <git@archiver.kernel.org>; Sun,  1 Nov 2020 19:34:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C0FF21527
	for <git@archiver.kernel.org>; Sun,  1 Nov 2020 19:34:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cPGF4hIc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727052AbgKATeI (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 1 Nov 2020 14:34:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726790AbgKATeH (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Nov 2020 14:34:07 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C90E8C0617A6
        for <git@vger.kernel.org>; Sun,  1 Nov 2020 11:34:05 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id h6so14645693lfj.3
        for <git@vger.kernel.org>; Sun, 01 Nov 2020 11:34:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UdtQHjBNcJL3UN2wB1VmLveE4ycKuZLXDtFgxF9YfFU=;
        b=cPGF4hIc6+DI99yKG7FdnfI8WYZ4rOSHeVI4xGvqzmK3InuXxHEAo9WDpUzDxdgLnd
         lAi3S84A5d0bcC6XctSrlara5HNd3T1vwhPkA6wTFDlytkSBRbDcJaTw3xp8M2AgWPff
         WirI8PrG2bc19gkCKFdc6i5g+QoIBYmBVwLS1eCK8sYzYLRDlNAnZvBv1sxmEWWrx+9o
         Okq5SbNuq4KFc8xLXCzdVi9hdt9IwxGgJDVSBm4B9KU8aci3o4zZgmutNRQkAjecC8BZ
         vmUvL1btTWWcb5iwUNhwxT35Tjm/bhxGAl+efqgsF3vxNhaBXZKPaDpisAV/i/Orbl8W
         xkNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UdtQHjBNcJL3UN2wB1VmLveE4ycKuZLXDtFgxF9YfFU=;
        b=bMua6uc7rvpS5xUVNynQrmF75oEA+Iirnw7KqUIO4BT0nI1pfc8Gj0RrTy1cO3wZ0A
         LR/Sc3loEzfUI/MQ0lJQeP2OsdyzxlLWmTUBEpXmCAyqzT5j1wBf3xtpVdO2u9h2CS1s
         VFxPQ01zUaPUVIgPPANZukj0kqEDQLI0Ce3YolaPxQFw1LPmt5bd02MnbmDkKcQj5wY5
         tGT3iNXLt9ikWu6NGD+dzNK0/cLkTgqwoMbzvlNAqvEVfpD/COXB9bYQhLe70IBOXCa4
         aOFqdPrZh4iwWqIYWNqR9eNTu5Ybb7CmfNRRMFWgEAYjgiHqi3+WY424Tu1N5W1UosBc
         /sfA==
X-Gm-Message-State: AOAM531VD/Cc330TRIxoBoRHSYMhPxrmyjMUKIxFYLG74sVZOpC8yUcS
        403623cl7XzYy6UY+4ypTeU=
X-Google-Smtp-Source: ABdhPJx04NJ6KoR3O5+wjF1shNbE+FOeKz6gGd9IY1kkxlQoZfjfXoo0gDnxyOKb76L5XDetf7XKhQ==
X-Received: by 2002:a19:8889:: with SMTP id k131mr3466673lfd.0.1604259244271;
        Sun, 01 Nov 2020 11:34:04 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id m12sm1766526ljc.88.2020.11.01.11.34.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2020 11:34:03 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Sergey Organov <sorganov@gmail.com>
Subject: [PATCH 01/26] revision: factor out parsing of diff-merge related options
Date:   Sun,  1 Nov 2020 22:33:05 +0300
Message-Id: <20201101193330.24775-2-sorganov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201101193330.24775-1-sorganov@gmail.com>
References: <20201101193330.24775-1-sorganov@gmail.com>
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

