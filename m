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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48E6DC2BBCA
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 18:52:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 034E62342C
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 18:52:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732286AbgLPSw0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Dec 2020 13:52:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732277AbgLPSwZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Dec 2020 13:52:25 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E174C0611D0
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 10:50:46 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id m25so50936155lfc.11
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 10:50:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gnGl71CSNDCprW7cvqUe7rP/g3NSBy0mNnoMBVxrUk4=;
        b=P1Q14BX5+iJ0pkQ0RO8jI9cGShINppLFKQfnfQKsX5PYXkMEQA/p1VeDQwxJvpKYNp
         of+uCnedxzcy37p6JeRUov988JwUgriyKWJp31iNRIAzdsZO65XQ52j2h5mFi1y10zYo
         wH7eFOkYLkwfGko23LjW+KJzQbhNBVTCiuElcAhhJw/XTHBTu+qAA7//xb6XsVosnn8i
         H2MxeL7+hrNk+rs1CMSIU6tmQHn1RcRDaAMZTnGJ4YAAuQuHbN8Dt7xbrTuwfrkenhdk
         y8CVmRHfdt9rX/NrG1KHHLw0Co5P42xooG0Ssng0JH1N7RlupGACTMqAgFjXKDKW/pta
         ca+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gnGl71CSNDCprW7cvqUe7rP/g3NSBy0mNnoMBVxrUk4=;
        b=gIPl5+aq3JktcGe10UJMv4F8vXduWGXJuRMTFtLORdGRKPe7wK5N/rJmYYAJeUKqbr
         /rHo8qcROQ7WPrDXzgK6KnsmfMmmxX8DifWm/WWeeOKrz2wfhrX62e/pTIUwRtdJVjrZ
         GIf2+Z2pkQpDpoo4F0iiHWtq/WhectTX7Ctv+jGXt3VZivqRxw7iMi49WK3EWzuLWmt+
         evduCRcJqcaNcrKto0hNS4bUR0EnAiS12rIA84KKf0sDJskhZZ9MhsIeJqWBqeuDFLrx
         OdGMzDiLw8U6Du47nYCFlgiE6WRlzDe742pnY0z9aHOZ4Jgzun0wG4Y5YgMWQwQHRvG9
         c0Iw==
X-Gm-Message-State: AOAM533MjoL1FzMYh62rruBQJ1gGjaYaeiV4LVzmn/we1RRE0L6pTOLp
        30mDlur4T4Af9qCejcPo0aw=
X-Google-Smtp-Source: ABdhPJwVjDWw9iP6KdmZtaQyv1nM7jK221X2GsZxCN1pw/UQuLYnznSHxvNhasMqGXB1VG3ZK8t6zA==
X-Received: by 2002:a2e:bc05:: with SMTP id b5mr15688009ljf.444.1608144643962;
        Wed, 16 Dec 2020 10:50:43 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id 197sm313871lfe.158.2020.12.16.10.50.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 10:50:43 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>, git@vger.kernel.org,
        Sergey Organov <sorganov@gmail.com>
Subject: [PATCH v2 17/33] diff-merges: split 'ignore_merges' field
Date:   Wed, 16 Dec 2020 21:49:13 +0300
Message-Id: <20201216184929.3924-18-sorganov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201216184929.3924-1-sorganov@gmail.com>
References: <20201101193330.24775-1-sorganov@gmail.com>
 <20201216184929.3924-1-sorganov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

'ignore_merges' was 3-way field that served two distinct purposes that
we now assign to 2 new independent flags: 'separate_merges', and
'explicit_diff_merges'.

'separate_merges' tells that we need to output diff format containing
separate diff for every parent (as opposed to 'combine_merges').

'explicit_diff_merges' tells that at least one of diff-merges options
has been explicitly specified on the command line, so no defaults
should apply.

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 diff-merges.c | 31 +++++++++++++------------------
 log-tree.c    | 15 ++++++++-------
 revision.h    |  3 ++-
 3 files changed, 23 insertions(+), 26 deletions(-)

diff --git a/diff-merges.c b/diff-merges.c
index 5d20e329a661..711df9975dd5 100644
--- a/diff-merges.c
+++ b/diff-merges.c
@@ -3,7 +3,7 @@
 #include "revision.h"
 
 static void suppress(struct rev_info *revs) {
-	revs->ignore_merges = 1;
+	revs->separate_merges = 0;
 	revs->first_parent_merges = 0;
 	revs->combine_merges = 0;
 	revs->dense_combined_merges = 0;
@@ -20,7 +20,6 @@ static void set_dense_combined(struct rev_info *revs) {
  */
 
 void diff_merges_init_revs(struct rev_info *revs) {
-	revs->ignore_merges = -1;
 }
 
 int diff_merges_parse_opts(struct rev_info *revs, const char **argv) {
@@ -35,7 +34,7 @@ int diff_merges_parse_opts(struct rev_info *revs, const char **argv) {
 		 * family of commands, it means "show full diff for merges". Set
 		 * both fields appropriately.
 		 */
-		revs->ignore_merges = 0;
+		revs->separate_merges = 1;
 		revs->match_missing = 1;
 	} else if (!strcmp(arg, "-c")) {
 		revs->dense_combined_merges = 0;
@@ -53,8 +52,9 @@ int diff_merges_parse_opts(struct rev_info *revs, const char **argv) {
 			die(_("unknown value for --diff-merges: %s"), optarg);
 		}
 	} else
-		argcount = 0;
+		return 0;
 
+	revs->explicit_diff_merges = 1;
 	return argcount;
 }
 
@@ -63,20 +63,15 @@ void diff_merges_suppress(struct rev_info *revs) {
 }
 
 void diff_merges_default_to_first_parent(struct rev_info *revs) {
-	if (revs->ignore_merges < 0)		/* No -m */
-		revs->ignore_merges = 0;
-	if (!revs->combine_merges)		/* No -c/--cc" */
+	if (!revs->explicit_diff_merges)
+		revs->separate_merges = 1;
+	if (revs->separate_merges)
 		revs->first_parent_merges = 1;
 }
 
 void diff_merges_default_to_dense_combined(struct rev_info *revs) {
-	if (revs->ignore_merges < 0) {		/* No -m */
-		revs->ignore_merges = 0;
-		if (!revs->combine_merges) {	/* No -c/--cc" */
-			revs->combine_merges = 1;
-			revs->dense_combined_merges = 1;
-		}
-	}
+	if (!revs->explicit_diff_merges)
+		set_dense_combined(revs);
 }
 
 void diff_merges_set_dense_combined_if_unset(struct rev_info *revs) {
@@ -86,10 +81,10 @@ void diff_merges_set_dense_combined_if_unset(struct rev_info *revs) {
 
 void diff_merges_setup_revs(struct rev_info *revs)
 {
-	if (revs->combine_merges && revs->ignore_merges < 0)
-		revs->ignore_merges = 0;
-	if (revs->ignore_merges < 0)
-		revs->ignore_merges = 1;
+	if (revs->combine_merges == 0)
+		revs->dense_combined_merges = 0;
+	if (revs->separate_merges == 0)
+		revs->first_parent_merges = 0;
 	if (revs->combined_all_paths && !revs->combine_merges)
 		die("--combined-all-paths makes no sense without -c or --cc");
 	if (revs->combine_merges)
diff --git a/log-tree.c b/log-tree.c
index 3fdc0fc64bfb..f9385b1dae6f 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -918,14 +918,15 @@ static int log_tree_diff(struct rev_info *opt, struct commit *commit, struct log
 
 	/* More than one parent? */
 	if (parents->next) {
-		if (opt->ignore_merges)
-			return 0;
-		else if (opt->combine_merges)
+		if (opt->combine_merges)
 			return do_diff_combined(opt, commit);
-		else if (!opt->first_parent_merges) {
-			/* If we show multiple diffs, show the parent info */
-			log->parent = parents->item;
-		}
+		if (opt->separate_merges) {
+			if (!opt->first_parent_merges) {
+				/* Show parent info for multiple diffs */
+				log->parent = parents->item;
+			}
+		} else
+			return 0;
 	}
 
 	showed_log = 0;
diff --git a/revision.h b/revision.h
index ba2aef79215e..fcc532c873d1 100644
--- a/revision.h
+++ b/revision.h
@@ -191,12 +191,13 @@ struct rev_info {
 			match_missing:1,
 			no_commit_id:1,
 			verbose_header:1,
+			explicit_diff_merges: 1,
+			separate_merges: 1,
 			combine_merges:1,
 			combined_all_paths:1,
 			dense_combined_merges:1,
 			first_parent_merges:1,
 			always_show_header:1;
-	int             ignore_merges:2;
 
 	/* Format info */
 	int		show_notes;
-- 
2.25.1

