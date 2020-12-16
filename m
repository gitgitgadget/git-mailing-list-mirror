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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C7ADC2BBCA
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 18:52:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2CA02342C
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 18:52:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732296AbgLPSwb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Dec 2020 13:52:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732288AbgLPSw2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Dec 2020 13:52:28 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4D0FC0619D9
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 10:50:56 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id y19so50902818lfa.13
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 10:50:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A1QsJWGnKchWTmtXih1Kz6avfXX9gyJFPraOVGRlFgY=;
        b=Gj/ksvj0LBCEjYVeIx7YiX98qiwbdPaQtMSdtjq4XqazIyc1Nf0UBauylJ/FUghYmN
         0VdKMAGwM9g3csBEvBTX7ZnznPmrq+jxg38kgoh6PWSg7dSRj6mmdc6EqhvC87avzRVD
         9f/ZDmCArY0VfBeZFu8C8UaCZLaBh/TUdCm4foDPK6WcxfvzGTQfg59Df5lLV5JVdm1y
         OOa3OBMVoOzOj81nXDtW29HpUT/iV0W2oh0FK/a99PX9UaQ/+XCPrNDBpWsDOidB4OMn
         9A1VlxzowJa4OBgLnDEcAmZ2FAcYYJRLL6YPj/U1gxqp2FEBB88j7dcOeKWw0j8sH72V
         Uynw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A1QsJWGnKchWTmtXih1Kz6avfXX9gyJFPraOVGRlFgY=;
        b=UOBLyfghe55YdDxwI0os0ZThwKz0GfPHDFO8lTtEwwfPADW2nHN5faIH1NUHrvOElK
         jMx4yRiloDFzSdU+UlmVvCIiKypEQzpiJzs66BFPX4Mz3uMdW5jQbS5woRZ73F+C+aqs
         LhRoHFr0yrWngKjZNH1efrTQ51KNY34ZWjdI7E2Lxtf8baahIpWA9MAHTf7MjWGEpZ5l
         6F7VjmDYF0QdAjQZ4JdF6U+qGQWvgfXNk8XsVf+HZeLNANuZnchYJ9UYFx8UIuXYkOnE
         luyLI4qyQE2hAdgg1ug/xbYycRcEedbssI1wySnBm6p/Vo7BXai3GhTFvrRCtQHrAjw6
         B9HA==
X-Gm-Message-State: AOAM530jGiPpVmvil6jx+jWjfxQL26VZN+0uVAJQOc4ubvMz044bZNMP
        x+DhYFJbFIjlbV85FCsWH+c=
X-Google-Smtp-Source: ABdhPJwoOVf/G5FXwbG3u8ZzVBwW53fbmMcEVC4/K+J+bOkfGJ2idT4v8WXFsO8VzhsawD2oiDmySg==
X-Received: by 2002:a05:6512:211:: with SMTP id a17mr7671625lfo.562.1608144654411;
        Wed, 16 Dec 2020 10:50:54 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id 197sm313871lfe.158.2020.12.16.10.50.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 10:50:53 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>, git@vger.kernel.org,
        Sergey Organov <sorganov@gmail.com>
Subject: [PATCH v2 26/33] diff-merges: let new options enable diff without -p
Date:   Wed, 16 Dec 2020 21:49:22 +0300
Message-Id: <20201216184929.3924-27-sorganov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201216184929.3924-1-sorganov@gmail.com>
References: <20201101193330.24775-1-sorganov@gmail.com>
 <20201216184929.3924-1-sorganov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

New options don't have any visible effect unless -p is either given or
implied, as unlike -c/-cc we don't imply -p with --diff-merges. To fix
this, this patch adds new functionality by letting new options enable
output of diffs for merge commits only.

Add 'merges_need_diff' field and set it whenever diff output for merges is
enabled by any of the new options.

Extend diff output logic accordingly, to output diffs for merges when
'merges_need_diff' is set even when no -p has been provided.

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 diff-merges.c | 16 ++++++++++------
 log-tree.c    | 13 +++++++++----
 revision.h    |  1 +
 3 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/diff-merges.c b/diff-merges.c
index 725db2312074..ffe20d8daa4a 100644
--- a/diff-merges.c
+++ b/diff-merges.c
@@ -10,6 +10,7 @@ static void suppress(struct rev_info *revs)
 	revs->dense_combined_merges = 0;
 	revs->combined_all_paths = 0;
 	revs->combined_imply_patch = 0;
+	revs->merges_need_diff = 0;
 }
 
 static void set_separate(struct rev_info *revs)
@@ -51,9 +52,11 @@ static void set_dense_combined(struct rev_info *revs)
 
 static void set_diff_merges(struct rev_info *revs, const char *optarg)
 {
+	if (!strcmp(optarg, "off") || !strcmp(optarg, "none")) {
+		suppress(revs);
+		return;
+	}
 	if (0) ;
-	else if (!strcmp(optarg, "off")   || !strcmp(optarg, "none"))
-		suppress(revs);
 	else if (!strcmp(optarg, "first") || !strcmp(optarg, "first-parent"))
 		set_first_parent(revs);
 	else if (!strcmp(optarg, "sep")   || !strcmp(optarg, "separate"))
@@ -64,6 +67,7 @@ static void set_diff_merges(struct rev_info *revs, const char *optarg)
 		set_dense_combined(revs);
 	else
 		die(_("unknown value for --diff-merges: %s"), optarg);
+	revs->merges_need_diff = 1;
 }
 
 /*
@@ -132,12 +136,12 @@ void diff_merges_setup_revs(struct rev_info *revs)
 		revs->first_parent_merges = 0;
 	if (revs->combined_all_paths && !revs->combine_merges)
 		die("--combined-all-paths makes no sense without -c or --cc");
-	if (revs->combine_merges)
+
+	if (revs->combined_imply_patch)
 		revs->diff = 1;
-	if (revs->combined_imply_patch) {
-		/* Turn --cc/-c into -p --cc/-c when -p was not given */
+
+	if (revs->combined_imply_patch || revs->merges_need_diff) {
 		if (!revs->diffopt.output_format)
 			revs->diffopt.output_format = DIFF_FORMAT_PATCH;
 	}
-
 }
diff --git a/log-tree.c b/log-tree.c
index f9385b1dae6f..67060492ca0a 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -899,15 +899,21 @@ static int log_tree_diff(struct rev_info *opt, struct commit *commit, struct log
 	int showed_log;
 	struct commit_list *parents;
 	struct object_id *oid;
+	int is_merge;
+	int regulars_need_diff = opt->diff || opt->diffopt.flags.exit_with_status;
 
-	if (!opt->diff && !opt->diffopt.flags.exit_with_status)
+	if (!regulars_need_diff && !opt->merges_need_diff)
 		return 0;
 
 	parse_commit_or_die(commit);
 	oid = get_commit_tree_oid(commit);
 
-	/* Root commit? */
 	parents = get_saved_parents(opt, commit);
+	is_merge = parents && parents->next;
+	if(!is_merge && !regulars_need_diff)
+		return 0;
+
+	/* Root commit? */
 	if (!parents) {
 		if (opt->show_root_diff) {
 			diff_root_tree_oid(oid, "", &opt->diffopt);
@@ -916,8 +922,7 @@ static int log_tree_diff(struct rev_info *opt, struct commit *commit, struct log
 		return !opt->loginfo;
 	}
 
-	/* More than one parent? */
-	if (parents->next) {
+	if (is_merge) {
 		if (opt->combine_merges)
 			return do_diff_combined(opt, commit);
 		if (opt->separate_merges) {
diff --git a/revision.h b/revision.h
index bfbae526ad6e..494d86142454 100644
--- a/revision.h
+++ b/revision.h
@@ -194,6 +194,7 @@ struct rev_info {
 			always_show_header:1,
 			/* Diff-merge flags */
 			explicit_diff_merges: 1,
+			merges_need_diff: 1,
 			separate_merges: 1,
 			combine_merges:1,
 			combined_all_paths:1,
-- 
2.25.1

