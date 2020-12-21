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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0194FC433E0
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 18:09:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A60B722D08
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 18:09:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbgLUSJQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Dec 2020 13:09:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbgLUSJP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Dec 2020 13:09:15 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05110C0613D6
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 10:08:35 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id u19so10470443edx.2
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 10:08:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rCg+5kbzmz51UX6bsWImblE4lls6ZuhM0R+PAqA8Wl8=;
        b=X2/+hNUE2K8wLHWAzQCuuZK1pX7EG4uAjDRmC4M4VgVbfhAYO4qQCKwAIXiHSEFIJh
         QUKeij3Py9pKWY29ahD7ZbO5EaAZzE63HZYKZWwUEqvjVv1setoghs3CDdrKLITcs6GT
         rTad8uEXpJ6yvue52qu6igCqZ+1CbjqqzNRfC/w2UnCkGLnfI4csSNKpY4AQjt1ZZF+b
         nbzTNRfF1w/dPVcAGD25ya37K4BEGLMthx8WwQykt8/CdsdGgjbyv9PzLDYqQHJCjuPg
         LW69c2I7uOjkGKaePe2Rh1WwZxqLhkr6ldDB2a40UIJ9T6wmKAkc5oWJfjniCk9XODKp
         A/Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rCg+5kbzmz51UX6bsWImblE4lls6ZuhM0R+PAqA8Wl8=;
        b=jcUxZfu9U2uae7ceabDfZ0uUpQqxWuKVU1MCi0OXXgEoG6cfkzCbmNGZRmIjuEcD1Y
         7ZhrB1LtmY2rV1Bs5eYJg/w8EV2e6tfHYQDj3m3zwX+lzVTeBeHAEmSMDS5CvIUXjX2F
         8CjYorJWPgX2/sqRO1NzEfynCyFEPtQpXVcsNYo4sCYiNV9mRQ2efxps255bsJIakZ3d
         wnDA9i9d832wZk18ekq2sVisKVnaQ9VVROJ1vR58yT9zpKjkHuTQS4EzGXo3gzva+iAH
         t6lXsBpiABhqwFSHm9Y7Uy+epAVyAocivKHBU29cPs16XzLx8nbgj/soSAWhdIMAV36a
         +GlQ==
X-Gm-Message-State: AOAM532tTrhXK/hpIESFCfrZpzLJGMo7HdsxznUWDdRdTGnBV8b+2Q8E
        SttaGiFfhGHmd6hQ1ML3UVCaNvLiMRA=
X-Google-Smtp-Source: ABdhPJx9zK6Gu6cEjBVnb06+d7hdiL0pLKmw4aCwcV3ShwTy78p39gPD2V7AtgsQ2Rn9Ghmn7Dsl5w==
X-Received: by 2002:a2e:98ca:: with SMTP id s10mr7192119ljj.417.1608564054253;
        Mon, 21 Dec 2020 07:20:54 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id c5sm2220085ljj.67.2020.12.21.07.20.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Dec 2020 07:20:53 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        git@vger.kernel.org, Sergey Organov <sorganov@gmail.com>
Subject: [PATCH v3 18/32] diff-merges: split 'ignore_merges' field
Date:   Mon, 21 Dec 2020 18:19:46 +0300
Message-Id: <20201221152000.13134-19-sorganov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201221152000.13134-1-sorganov@gmail.com>
References: <20201101193330.24775-1-sorganov@gmail.com>
 <20201221152000.13134-1-sorganov@gmail.com>
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
index 047bf81e6777..eff54cca8287 100644
--- a/diff-merges.c
+++ b/diff-merges.c
@@ -4,7 +4,7 @@
 
 static void suppress(struct rev_info *revs)
 {
-	revs->ignore_merges = 1;
+	revs->separate_merges = 0;
 	revs->first_parent_merges = 0;
 	revs->combine_merges = 0;
 	revs->dense_combined_merges = 0;
@@ -23,7 +23,6 @@ static void set_dense_combined(struct rev_info *revs)
 
 void diff_merges_init_revs(struct rev_info *revs)
 {
-	revs->ignore_merges = -1;
 }
 
 int diff_merges_parse_opts(struct rev_info *revs, const char **argv)
@@ -39,7 +38,7 @@ int diff_merges_parse_opts(struct rev_info *revs, const char **argv)
 		 * family of commands, it means "show full diff for merges". Set
 		 * both fields appropriately.
 		 */
-		revs->ignore_merges = 0;
+		revs->separate_merges = 1;
 		revs->match_missing = 1;
 	} else if (!strcmp(arg, "-c")) {
 		revs->dense_combined_merges = 0;
@@ -57,8 +56,9 @@ int diff_merges_parse_opts(struct rev_info *revs, const char **argv)
 			die(_("unknown value for --diff-merges: %s"), optarg);
 		}
 	} else
-		argcount = 0;
+		return 0;
 
+	revs->explicit_diff_merges = 1;
 	return argcount;
 }
 
@@ -69,21 +69,16 @@ void diff_merges_suppress(struct rev_info *revs)
 
 void diff_merges_default_to_first_parent(struct rev_info *revs)
 {
-	if (revs->ignore_merges < 0)		/* No -m */
-		revs->ignore_merges = 0;
-	if (!revs->combine_merges)		/* No -c/--cc" */
+	if (!revs->explicit_diff_merges)
+		revs->separate_merges = 1;
+	if (revs->separate_merges)
 		revs->first_parent_merges = 1;
 }
 
 void diff_merges_default_to_dense_combined(struct rev_info *revs)
 {
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
 
 void diff_merges_set_dense_combined_if_unset(struct rev_info *revs)
@@ -94,10 +89,10 @@ void diff_merges_set_dense_combined_if_unset(struct rev_info *revs)
 
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
 	if (revs->combine_merges) {
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

