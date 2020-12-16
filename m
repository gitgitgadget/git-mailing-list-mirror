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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEAECC2BBCA
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 18:51:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 950F02342C
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 18:51:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731102AbgLPSvp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Dec 2020 13:51:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729292AbgLPSvp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Dec 2020 13:51:45 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59387C061282
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 10:50:32 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id u18so50980481lfd.9
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 10:50:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Dqq5ziyxOSrHFh9+bhWNiLJTwOSaI7Y3ZHJog5FNCz4=;
        b=kF+DXAoaACVPYkAFYm+Z02TwTUaQk+UuiCvQaBvW+Jg8t/NkaOjyvSDhgcO0yEz0TR
         PPe5pNvGPGtqakdrwI1cHBUpQ616ceLbaWaKo24vqmYTAVRQKzR/kCGK4/ImzammMS8V
         BN5plu9VMJ4T9EU+H2Q7y/C46rArzL/CrEhy6eNKjk9bwDrM92OaQsUBeURFWdkbw2Yo
         Ws1evB1wsIbgl53OEyDxOZ9YXBA3df4uXLWQD3F4FGibk+Pg3TtjFMcghrL8AkIuDlSb
         yqyI9CLb9XRYjLDa9LeZ+IDZ9SZ4knO+z5mLu0DHpXMnKIZishTOmqfBXhvyLRe3lniF
         8s8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Dqq5ziyxOSrHFh9+bhWNiLJTwOSaI7Y3ZHJog5FNCz4=;
        b=k5iZt0VOPJDPCJYfmEkzcJlMbclrJQCFjumtkN3X8uqaWmK11n8k1+kg5WqWLjcL+v
         zv9a+7XO6Qx6H057IO6LZ3Dqyr0ni34jYLklXzSnTCkxUJiNhZJ9rcH9/DKfMspcfCap
         Kids0nc2TcHpvKQ3tO35HgKWUv9/eOU95JuF5yuXz/22YAG4XPfiNv+jrzcuBLa0+ZrM
         Ylq+c2H99a3GOn9/slShw1nTXCczuwYRT9RWibjbfTwzilpYiLCSzaifRmOPtPtxwySw
         qwY9ZNwpAMUWFRLUKcXwGaArzCPsirAu/jdbjbe1BSIf13dVR2Ptm//VZGVMqdOV+Keq
         pX4A==
X-Gm-Message-State: AOAM533gmHEM2FMwn/EmQ9z0y1q4MNjRLXoETr5Lh657+jw9As5PBO5h
        j8m47SiySl59Ba9Z+ZjRd2I=
X-Google-Smtp-Source: ABdhPJw/bL6+VheeoSaWd/6uGf056MH+4cLZ0g50NcADRFHYh5cjgT1IXq8qBbQP0L8sLZnjdNT9bg==
X-Received: by 2002:a19:385e:: with SMTP id d30mr14968093lfj.187.1608144630055;
        Wed, 16 Dec 2020 10:50:30 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id 197sm313871lfe.158.2020.12.16.10.50.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 10:50:29 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>, git@vger.kernel.org,
        Sergey Organov <sorganov@gmail.com>
Subject: [PATCH v2 06/33] diff-merges: rename all functions to have common prefix
Date:   Wed, 16 Dec 2020 21:49:02 +0300
Message-Id: <20201216184929.3924-7-sorganov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201216184929.3924-1-sorganov@gmail.com>
References: <20201101193330.24775-1-sorganov@gmail.com>
 <20201216184929.3924-1-sorganov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use the same "diff_merges" prefix for all the diff merges function
names.

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 builtin/log.c |  4 ++--
 diff-merges.c | 10 +++++-----
 diff-merges.h | 15 ++++++++++-----
 revision.c    |  6 +++---
 4 files changed, 20 insertions(+), 15 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index ad3092fdd854..77a7bba543ad 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -599,7 +599,7 @@ static int show_tree_object(const struct object_id *oid,
 static void show_setup_revisions_tweak(struct rev_info *rev,
 				       struct setup_revision_opt *opt)
 {
-	rev_diff_merges_default_to_dense_combined(rev);
+	diff_merges_default_to_dense_combined(rev);
 	if (!rev->diffopt.output_format)
 		rev->diffopt.output_format = DIFF_FORMAT_PATCH;
 }
@@ -724,7 +724,7 @@ static void log_setup_revisions_tweak(struct rev_info *rev,
 	if (!rev->diffopt.output_format && rev->combine_merges)
 		rev->diffopt.output_format = DIFF_FORMAT_PATCH;
 
-	rev_diff_merges_first_parent_defaults_to_enable(rev);
+	diff_merges_first_parent_defaults_to_enable(rev);
 }
 
 int cmd_log(int argc, const char **argv, const char *prefix)
diff --git a/diff-merges.c b/diff-merges.c
index eb25bcca2494..b647920bdb22 100644
--- a/diff-merges.c
+++ b/diff-merges.c
@@ -2,11 +2,11 @@
 
 #include "revision.h"
 
-void init_diff_merge_revs(struct rev_info *revs) {
+void diff_merges_init_revs(struct rev_info *revs) {
 	revs->ignore_merges = -1;
 }
 
-int parse_diff_merge_opts(struct rev_info *revs, const char **argv) {
+int diff_merges_parse_opts(struct rev_info *revs, const char **argv) {
 	int argcount = 1;
 	const char *optarg;
 	const char *arg = argv[0];
@@ -44,7 +44,7 @@ int parse_diff_merge_opts(struct rev_info *revs, const char **argv) {
 	return argcount;
 }
 
-void setup_diff_merges_revs(struct rev_info *revs)
+void diff_merges_setup_revs(struct rev_info *revs)
 {
 	if (revs->combine_merges && revs->ignore_merges < 0)
 		revs->ignore_merges = 0;
@@ -54,12 +54,12 @@ void setup_diff_merges_revs(struct rev_info *revs)
 		die("--combined-all-paths makes no sense without -c or --cc");
 }
 
-void rev_diff_merges_first_parent_defaults_to_enable(struct rev_info *revs) {
+void diff_merges_first_parent_defaults_to_enable(struct rev_info *revs) {
 	if (revs->first_parent_only && revs->ignore_merges < 0)
 		revs->ignore_merges = 0;
 }
 
-void rev_diff_merges_default_to_dense_combined(struct rev_info *revs) {
+void diff_merges_default_to_dense_combined(struct rev_info *revs) {
 	if (revs->ignore_merges < 0) {
 		/* There was no "-m" variant on the command line */
 		revs->ignore_merges = 0;
diff --git a/diff-merges.h b/diff-merges.h
index 7e970b266cf5..4ced909b795e 100644
--- a/diff-merges.h
+++ b/diff-merges.h
@@ -9,10 +9,15 @@
 
 struct rev_info;
 
-void init_diff_merge_revs(struct rev_info *revs);
-int parse_diff_merge_opts(struct rev_info *revs, const char **argv);
-void setup_diff_merges_revs(struct rev_info *revs);
-void rev_diff_merges_default_to_dense_combined(struct rev_info *revs);
-void rev_diff_merges_first_parent_defaults_to_enable(struct rev_info *revs);
+void diff_merges_init_revs(struct rev_info *revs);
+
+int diff_merges_parse_opts(struct rev_info *revs, const char **argv);
+
+void diff_merges_setup_revs(struct rev_info *revs);
+
+void diff_merges_default_to_dense_combined(struct rev_info *revs);
+
+void diff_merges_first_parent_defaults_to_enable(struct rev_info *revs);
+
 
 #endif
diff --git a/revision.c b/revision.c
index 4bc14a08a624..5a0e3d6ad542 100644
--- a/revision.c
+++ b/revision.c
@@ -1814,7 +1814,7 @@ void repo_init_revisions(struct repository *r,
 
 	revs->repo = r;
 	revs->abbrev = DEFAULT_ABBREV;
-	init_diff_merge_revs(revs);
+	diff_merges_init_revs(revs);
 	revs->simplify_history = 1;
 	revs->pruning.repo = r;
 	revs->pruning.flags.recursive = 1;
@@ -2350,7 +2350,7 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		revs->diff = 1;
 		revs->diffopt.flags.recursive = 1;
 		revs->diffopt.flags.tree_in_recursive = 1;
-	} else if ((argcount = parse_diff_merge_opts(revs, argv))) {
+	} else if ((argcount = diff_merges_parse_opts(revs, argv))) {
 		return argcount;
 	} else if (!strcmp(arg, "-v")) {
 		revs->verbose_header = 1;
@@ -2849,7 +2849,7 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 				      &revs->prune_data);
 	}
 
-	setup_diff_merges_revs(revs);
+	diff_merges_setup_revs(revs);
 
 	revs->diffopt.abbrev = revs->abbrev;
 
-- 
2.25.1

