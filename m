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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F10DC433DB
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 18:15:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DC9922D08
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 18:15:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726065AbgLUSPW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Dec 2020 13:15:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726108AbgLUSPV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Dec 2020 13:15:21 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32D71C0613D3
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 10:14:41 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id b73so10435041edf.13
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 10:14:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4J+ZFZqQ2+Y9sw/AYBJ+HoKrti5Dgq9RlTn2IRe9w5g=;
        b=NtDPtz39RZYNLwe93QK3FJ5eOsR740l09yzFrh3yR5fonsQtmIkl5dgQi2QeoVaX4s
         7ifRBZ/p+/yLtBPa5wb066ktIYhKL9cbOoXw/VR/l/tE+koT3N2vkLJyA1eLEdoU+Eis
         I/Ij4oH8Yuk6SHZgSkMhHEUeioKBPh/CMscNmDbnHQdWygZO6gL8FgDVTbBDXQNf9Y33
         E0/GjONPDHHZiAZJarm4J5iutYo5daFaH2rG8PWSmv8kgT6abC+k+ZPQ4SFrZMKSqBpJ
         jCtGrgFwUTlH5ZHQVFd0LTBwyY7ekkg1CqvW25Nikqm5ROUh1YSTu2qSRF5OY/uYN2cu
         gPzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4J+ZFZqQ2+Y9sw/AYBJ+HoKrti5Dgq9RlTn2IRe9w5g=;
        b=BOE5fpM8VMvY1khqDBua2IGbVr+lxCwsLsy/MVCmhoS1K23tUbXQ6MT7NYxbEOe5zM
         Me4BEOGrWn2IFfM627WdXchax7bQ5vCJjV22LdhYWfVU6dJtZ3qKkWHVVtu7ZL1ORzGp
         vSvoo1xSqdd6r1LwfMtK1onRPj6PmAnUgtV0XSnPe1FMao3wYjXyydzk8e5/P2Jez3nV
         QD6jhaY7n3zWCRj3XPRbBpo0QU43Q6E4uPnzsFhRL1KjUstudqVQDs6OsidQO9lSWW9B
         pDTCg6nCDWq5oZs9c4bJKi+t/Us4WQdYg2t3YcZrWxo64tVnD2w/LBVV7ORWdwnEQ0qq
         Tdpg==
X-Gm-Message-State: AOAM5310MJoRVADght0nMZNCc3Ni5q7VT6RtOs11eaWY0NWEWh7fRya4
        Tg8caicbqMK3Op95T14g6tvC4539RbA=
X-Google-Smtp-Source: ABdhPJy6kgosHxyIztMD8dt40M3TjvGaJeXmqVvJAR40oEbG1OxsD9ZkXzKqm01aArB3Z1shBr04yQ==
X-Received: by 2002:a2e:b522:: with SMTP id z2mr7321773ljm.500.1608564061828;
        Mon, 21 Dec 2020 07:21:01 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id c5sm2220085ljj.67.2020.12.21.07.21.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Dec 2020 07:21:01 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        git@vger.kernel.org, Sergey Organov <sorganov@gmail.com>
Subject: [PATCH v3 25/32] diff-merges: let new options enable diff without -p
Date:   Mon, 21 Dec 2020 18:19:53 +0300
Message-Id: <20201221152000.13134-26-sorganov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201221152000.13134-1-sorganov@gmail.com>
References: <20201101193330.24775-1-sorganov@gmail.com>
 <20201221152000.13134-1-sorganov@gmail.com>
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
 diff-merges.c | 17 ++++++++++++-----
 log-tree.c    | 13 +++++++++----
 revision.h    |  1 +
 3 files changed, 22 insertions(+), 9 deletions(-)

diff --git a/diff-merges.c b/diff-merges.c
index 6d48ac5ab93d..ee91ed0db409 100644
--- a/diff-merges.c
+++ b/diff-merges.c
@@ -10,6 +10,7 @@ static void suppress(struct rev_info *revs)
 	revs->dense_combined_merges = 0;
 	revs->combined_all_paths = 0;
 	revs->combined_imply_patch = 0;
+	revs->merges_need_diff = 0;
 }
 
 static void set_separate(struct rev_info *revs)
@@ -51,9 +52,13 @@ static void set_dense_combined(struct rev_info *revs)
 
 static void set_diff_merges(struct rev_info *revs, const char *optarg)
 {
-	if (!strcmp(optarg, "off") || !strcmp(optarg, "none"))
+	if (!strcmp(optarg, "off") || !strcmp(optarg, "none")) {
 		suppress(revs);
-	else if (!strcmp(optarg, "first-parent"))
+		/* Return early to leave revs->merges_need_diff unset */
+		return;
+	}
+
+	if (!strcmp(optarg, "first-parent"))
 		set_first_parent(revs);
 	else if (!strcmp(optarg, "separate"))
 		set_separate(revs);
@@ -63,6 +68,9 @@ static void set_diff_merges(struct rev_info *revs, const char *optarg)
 		set_dense_combined(revs);
 	else
 		die(_("unknown value for --diff-merges: %s"), optarg);
+
+	/* The flag is cleared by set_xxx() functions, so don't move this up */
+	revs->merges_need_diff = 1;
 }
 
 /*
@@ -129,10 +137,9 @@ void diff_merges_setup_revs(struct rev_info *revs)
 		revs->first_parent_merges = 0;
 	if (revs->combined_all_paths && !revs->combine_merges)
 		die("--combined-all-paths makes no sense without -c or --cc");
-	if (revs->combine_merges)
+	if (revs->combined_imply_patch)
 		revs->diff = 1;
-	if (revs->combined_imply_patch) {
-		/* Turn --cc/-c into -p --cc/-c when -p was not given */
+	if (revs->combined_imply_patch || revs->merges_need_diff) {
 		if (!revs->diffopt.output_format)
 			revs->diffopt.output_format = DIFF_FORMAT_PATCH;
 	}
diff --git a/log-tree.c b/log-tree.c
index f9385b1dae6f..9f50a81e537e 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -899,15 +899,21 @@ static int log_tree_diff(struct rev_info *opt, struct commit *commit, struct log
 	int showed_log;
 	struct commit_list *parents;
 	struct object_id *oid;
+	int is_merge;
+	int all_need_diff = opt->diff || opt->diffopt.flags.exit_with_status;
 
-	if (!opt->diff && !opt->diffopt.flags.exit_with_status)
+	if (!all_need_diff && !opt->merges_need_diff)
 		return 0;
 
 	parse_commit_or_die(commit);
 	oid = get_commit_tree_oid(commit);
 
-	/* Root commit? */
 	parents = get_saved_parents(opt, commit);
+	is_merge = parents && parents->next;
+	if (!is_merge && !all_need_diff)
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

