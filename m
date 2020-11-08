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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18CF1C63697
	for <git@archiver.kernel.org>; Sun,  8 Nov 2020 21:41:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF792206E3
	for <git@archiver.kernel.org>; Sun,  8 Nov 2020 21:41:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X3fTKhSk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728938AbgKHVlb (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 8 Nov 2020 16:41:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728924AbgKHVl1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Nov 2020 16:41:27 -0500
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 195CDC0613D2
        for <git@vger.kernel.org>; Sun,  8 Nov 2020 13:41:27 -0800 (PST)
Received: by mail-lj1-x242.google.com with SMTP id q19so6091590ljc.10
        for <git@vger.kernel.org>; Sun, 08 Nov 2020 13:41:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Xkou6z8JgTQMAxcN6ZoKs5hW1hcfOLTXTU5A76qbu0U=;
        b=X3fTKhSk4+rBb4GfgAX/iogt3g/QEM2iigEu0jgfoNt9XMk+9nMJRp9bNZGsjHDWJx
         3UPpa1Me61+ZhYaCUAyvGzYssLVKJ2NvdE5MYzy6en8YNtW7ZXoybvlJ3wiY3XKyBuJy
         HVdUEnoq0qyHpCa6COg2BVD/EeRh3GgtKiF+Oz5db8aSSsA7IRteh/YsZPm+maXty8rO
         8S31w7hElFOOPLB/Ipah1ljyMIl9C8J14ksiE4Pm2rJQE1kVL3u/Qti7+AN8wRIhrAqa
         V2JU6GSLuKtNr3P0/DkqU2haL/Kq3jgHJ6dkuzHYPXgzt7VJJ+x1gbygQDaOmIHXL4qj
         EXiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Xkou6z8JgTQMAxcN6ZoKs5hW1hcfOLTXTU5A76qbu0U=;
        b=P/RHkffTZGHQ5qQREgYQhqRRIrTgG8zhpyh/96yS/Hqib/XrlUFbqNscM0Uzc3Re62
         T0skFz3IgEppBorvBp7cQiWjkz/ti3ytQz2sN1ScwnPCHsVmVBjXQ1JKqX16tDusjlS9
         UBr9xOjNeDMCtYpiB7CbC7KLNlzJFTD0OZdxlaTOrpHS+yLzI2RCq8rZsxy0KxPBUCLh
         HlsxEXr1W8jAIWV9D0LhpFlVfThq3UreYFIoAo9sNzEGEICm9NJ8s2Jn49LVMjSrStIb
         2jH745p13Xi4DojSkdUJfxQhjVhHW1ZSwLydI0ojVBf8omsVrC5DLXywsSfej/UQIbZG
         ifWw==
X-Gm-Message-State: AOAM5325IWR+INrewD2UcPEL45Pc2R5TigvpU0mGp3WUMVOZ074tXMGR
        awAHB+FPvs+p1oxElPCk9sA=
X-Google-Smtp-Source: ABdhPJyWatDS6hny6rnciqlA/wdazzxK4CVZFH7E7Ou7z3LN5heJZ3o3bFOidwoaD7FRUKVtIAjkBQ==
X-Received: by 2002:a2e:80d2:: with SMTP id r18mr5216082ljg.286.1604871685654;
        Sun, 08 Nov 2020 13:41:25 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id k21sm1937392ljb.43.2020.11.08.13.41.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2020 13:41:25 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        git@vger.kernel.org, Sergey Organov <sorganov@gmail.com>
Subject: [PATCH v1 06/27] diff-merges: rename all functions to have common prefix
Date:   Mon,  9 Nov 2020 00:38:17 +0300
Message-Id: <20201108213838.4880-7-sorganov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201108213838.4880-1-sorganov@gmail.com>
References: <20201101193330.24775-1-sorganov@gmail.com>
 <20201108213838.4880-1-sorganov@gmail.com>
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
index 8b9dd4ad5625..85bf0b6d1d1d 100644
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
 	int argcount;
 	const char *optarg;
 	const char *arg = argv[0];
@@ -44,7 +44,7 @@ int parse_diff_merge_opts(struct rev_info *revs, const char **argv) {
 	return 1;
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
index e0cca3d935d3..648c410497cb 100644
--- a/diff-merges.h
+++ b/diff-merges.h
@@ -3,10 +3,15 @@
 
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

