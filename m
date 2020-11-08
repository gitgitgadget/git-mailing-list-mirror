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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8F75C61DD8
	for <git@archiver.kernel.org>; Sun,  8 Nov 2020 21:41:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87F2920657
	for <git@archiver.kernel.org>; Sun,  8 Nov 2020 21:41:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KJph8iXf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729037AbgKHVly (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 8 Nov 2020 16:41:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728977AbgKHVli (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Nov 2020 16:41:38 -0500
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92CBFC0613CF
        for <git@vger.kernel.org>; Sun,  8 Nov 2020 13:41:37 -0800 (PST)
Received: by mail-lf1-x141.google.com with SMTP id u18so9542463lfd.9
        for <git@vger.kernel.org>; Sun, 08 Nov 2020 13:41:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PGd6j7To+NuX/B5UYxxq/KaMVtI38onwgReOQu04Rxs=;
        b=KJph8iXfhhHXdkyZnDqx+eSvnkiiqig/HSk59SYxgJptkCvTyDWw7r/8aMaahMngjc
         adUtQuvOOe6OHn61rE0O5dYg4HX3BgB0M5JqDi/d6wFJm47n1K1UbulZ9RiknZV8XYsy
         378i9VhVAhK95pjyiN5qoeuzQSENR4YJGGi0oTY3g7mZiOYlmehNJgocvDnyzG3Nrz4g
         huVi3IYTn4Tn0N+032ZZqvut84GoEDdSuOBpp9qX3AAoXYqNVL1ZJIaj2okVMFIMirdT
         YVm4XTXAXAnXeOevd5v7d5LLv2Y39YbwLzRA0Mn0sEol1JGr46pwOZydAfO/b3wj9hMd
         ZSrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PGd6j7To+NuX/B5UYxxq/KaMVtI38onwgReOQu04Rxs=;
        b=STO5PmRPMRE7XGcp5RrknJukU3Wp9pO7J5y8hXREXhVzb7yPmOrdd9a2yNyzXaZoic
         omRgbfOHHLmZusHxCUjycVpMSDpbzC8FKAaqPtk7MIVzbuzrxq3yq94VIUXmWzMwVYb2
         yml/RbYcr7BK4GG61Z0OJVTnURrlcPc15zfjqqbNuX8AOmeBBxlSNgFBySkminiTUfvq
         5mtFUby2lKYEsPHamwiCZFj9+RIwbXiF7dOHNXZhARds7xYlxhqG4B1qG1t5K8QKX/Fy
         032f8QR3Ob51EbphUnRmkaDvKemoRuep90WNPen1fD5Sxm/OrcJtnpEog+zwKEX/M434
         0C6g==
X-Gm-Message-State: AOAM530wLyWGtk4GNtoVROmu8XgWjq0Ru7dvYPA6bu253Dm/643Gqv9u
        6gSyXoug4gpbZt6LzIC/n5s=
X-Google-Smtp-Source: ABdhPJyyb9CqhVd9JcdcGKvyKXUkjEGpfTutMqlm1mkqQFiYcbdDfl9IgbOCAR6Y3rKVOtbB3PJTsQ==
X-Received: by 2002:a19:42d3:: with SMTP id p202mr4537148lfa.85.1604871696067;
        Sun, 08 Nov 2020 13:41:36 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id k21sm1937392ljb.43.2020.11.08.13.41.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2020 13:41:35 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        git@vger.kernel.org, Sergey Organov <sorganov@gmail.com>
Subject: [PATCH v1 17/27] diff-merges: split 'ignore_merges' field
Date:   Mon,  9 Nov 2020 00:38:28 +0300
Message-Id: <20201108213838.4880-18-sorganov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201108213838.4880-1-sorganov@gmail.com>
References: <20201101193330.24775-1-sorganov@gmail.com>
 <20201108213838.4880-1-sorganov@gmail.com>
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
 diff-merges.c | 29 ++++++++++++-----------------
 log-tree.c    | 15 ++++++++-------
 revision.h    |  3 ++-
 3 files changed, 22 insertions(+), 25 deletions(-)

diff --git a/diff-merges.c b/diff-merges.c
index f2b9ed789ca8..19cdad1aa4a1 100644
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
@@ -55,6 +54,7 @@ int diff_merges_parse_opts(struct rev_info *revs, const char **argv) {
 	} else
 		return 0;
 
+	revs->explicit_diff_merges = 1;
 	return 1;
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

