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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A03BC61DD8
	for <git@archiver.kernel.org>; Sun,  8 Nov 2020 21:41:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E3B520656
	for <git@archiver.kernel.org>; Sun,  8 Nov 2020 21:41:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dp+zpxXD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728927AbgKHVl1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 8 Nov 2020 16:41:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728893AbgKHVl0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Nov 2020 16:41:26 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 451B5C0613CF
        for <git@vger.kernel.org>; Sun,  8 Nov 2020 13:41:26 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id o24so1133079ljj.6
        for <git@vger.kernel.org>; Sun, 08 Nov 2020 13:41:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VaM4m6zZ8y9f7azXEuR8zeljPWHkrI5z3xciGl3JqVo=;
        b=dp+zpxXDGVF2crNf18UKFOpHCgwM1cqayQQX4Q2LgXRn166GsVPQtURolQfmq/dLEL
         w7/++0WYmhXgepnOKjGir8hpfMnBH/TtYoc57LEuFAUMdgas03Qu73K2/6Tv3/YS9ruB
         oZM3OStjdm5oX7ZQAnN56NijCY23RfPIa2EUQwh/IU+iUomkix08Hyu+8w2NjQUlV2X8
         yew7N0AoU3FRYFcsPQJLi8IdXe5h5M4xisCPtLcXLavfTqF+rOZdoidFkfoUdG4ujgpS
         PpBX4IkkEFKsfFQs9SXBcdSFTB0QhdOX52hEELkExzQHmKvcKWUtueIrbS2uzikr812w
         O/OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VaM4m6zZ8y9f7azXEuR8zeljPWHkrI5z3xciGl3JqVo=;
        b=M+MQHu7821fJT+3tx/fzZ8gIxog3oAR5Fs32SHqVo7d2wmjiZC35STNaZcyM90hewi
         yzq6i+Gz2oZfFuvdP/aDBgVq4s97Dp5ShtoCpHNrqzxAQbEw8o6EEEbUldUPmP0FLep3
         zabnBcltNr5G91xZrkuzVEW1hqwpzmQHDW5/kLY4j2LAX3bG2BXzhskWDYKy0iM+FR2G
         ZetZhAoWnlqxxuBTI3mBUh2LCM96rzjgoMqWdxzSM2/kslyTSZs0+1sgto3HP5bEqol5
         0Gs1DDzLrxCfYETvRdTnj6QnXWZmgFtRJAWpALXKkZrFRAaa3oaKqYKsppGSaUvphcpX
         8Jvg==
X-Gm-Message-State: AOAM531CpM/gzxhEAWxb8Xvi8s369vxxQnfAglI0g+44sCqjMv7Ngwnm
        hT9jSItsG0Xbsgyq60PceJM=
X-Google-Smtp-Source: ABdhPJzEEF/vDay7FoIkRx/Oy+DefG6qgiPfBDtUBORfWSvsmXs6fyYgc4dn95RubduN/x0WscwV2g==
X-Received: by 2002:a2e:9811:: with SMTP id a17mr4222400ljj.164.1604871684758;
        Sun, 08 Nov 2020 13:41:24 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id k21sm1937392ljb.43.2020.11.08.13.41.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2020 13:41:24 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        git@vger.kernel.org, Sergey Organov <sorganov@gmail.com>
Subject: [PATCH v1 05/27] revision: move diff merges functions to its own diff-merges.c
Date:   Mon,  9 Nov 2020 00:38:16 +0300
Message-Id: <20201108213838.4880-6-sorganov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201108213838.4880-1-sorganov@gmail.com>
References: <20201101193330.24775-1-sorganov@gmail.com>
 <20201108213838.4880-1-sorganov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Create separate diff-merges.c and diff-merges.h files, and move all
the code related to handling of diff merges there.

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 Makefile      |  1 +
 builtin/log.c |  1 +
 diff-merges.c | 72 +++++++++++++++++++++++++++++++++++++++++++++++++++
 diff-merges.h | 12 +++++++++
 revision.c    | 72 +--------------------------------------------------
 revision.h    |  3 ---
 6 files changed, 87 insertions(+), 74 deletions(-)
 create mode 100644 diff-merges.c
 create mode 100644 diff-merges.h

diff --git a/Makefile b/Makefile
index 1fb0ec17059a..d1347ef262cf 100644
--- a/Makefile
+++ b/Makefile
@@ -872,6 +872,7 @@ LIB_OBJS += date.o
 LIB_OBJS += decorate.o
 LIB_OBJS += delta-islands.o
 LIB_OBJS += diff-delta.o
+LIB_OBJS += diff-merges.o
 LIB_OBJS += diff-lib.o
 LIB_OBJS += diff-no-index.o
 LIB_OBJS += diff.o
diff --git a/builtin/log.c b/builtin/log.c
index 717855a49e90..ad3092fdd854 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -12,6 +12,7 @@
 #include "color.h"
 #include "commit.h"
 #include "diff.h"
+#include "diff-merges.h"
 #include "revision.h"
 #include "log-tree.h"
 #include "builtin.h"
diff --git a/diff-merges.c b/diff-merges.c
new file mode 100644
index 000000000000..8b9dd4ad5625
--- /dev/null
+++ b/diff-merges.c
@@ -0,0 +1,72 @@
+#include "diff-merges.h"
+
+#include "revision.h"
+
+void init_diff_merge_revs(struct rev_info *revs) {
+	revs->ignore_merges = -1;
+}
+
+int parse_diff_merge_opts(struct rev_info *revs, const char **argv) {
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
+void setup_diff_merges_revs(struct rev_info *revs)
+{
+	if (revs->combine_merges && revs->ignore_merges < 0)
+		revs->ignore_merges = 0;
+	if (revs->ignore_merges < 0)
+		revs->ignore_merges = 1;
+	if (revs->combined_all_paths && !revs->combine_merges)
+		die("--combined-all-paths makes no sense without -c or --cc");
+}
+
+void rev_diff_merges_first_parent_defaults_to_enable(struct rev_info *revs) {
+	if (revs->first_parent_only && revs->ignore_merges < 0)
+		revs->ignore_merges = 0;
+}
+
+void rev_diff_merges_default_to_dense_combined(struct rev_info *revs) {
+	if (revs->ignore_merges < 0) {
+		/* There was no "-m" variant on the command line */
+		revs->ignore_merges = 0;
+		if (!revs->first_parent_only && !revs->combine_merges) {
+			/* No "--first-parent", "-c", or "--cc" */
+			revs->combine_merges = 1;
+			revs->dense_combined_merges = 1;
+		}
+	}
+}
diff --git a/diff-merges.h b/diff-merges.h
new file mode 100644
index 000000000000..e0cca3d935d3
--- /dev/null
+++ b/diff-merges.h
@@ -0,0 +1,12 @@
+#ifndef DIFF_MERGES_H
+#define DIFF_MERGES_H
+
+struct rev_info;
+
+void init_diff_merge_revs(struct rev_info *revs);
+int parse_diff_merge_opts(struct rev_info *revs, const char **argv);
+void setup_diff_merges_revs(struct rev_info *revs);
+void rev_diff_merges_default_to_dense_combined(struct rev_info *revs);
+void rev_diff_merges_first_parent_defaults_to_enable(struct rev_info *revs);
+
+#endif
diff --git a/revision.c b/revision.c
index ce90c2991657..4bc14a08a624 100644
--- a/revision.c
+++ b/revision.c
@@ -5,6 +5,7 @@
 #include "tree.h"
 #include "commit.h"
 #include "diff.h"
+#include "diff-merges.h"
 #include "refs.h"
 #include "revision.h"
 #include "repository.h"
@@ -1805,8 +1806,6 @@ static int add_parents_only(struct rev_info *revs, const char *arg_, int flags,
 	return 1;
 }
 
-static void init_diff_merge_revs(struct rev_info *revs);
-
 void repo_init_revisions(struct repository *r,
 			 struct rev_info *revs,
 			 const char *prefix)
@@ -2155,75 +2154,6 @@ static void add_message_grep(struct rev_info *revs, const char *pattern)
 	add_grep(revs, pattern, GREP_PATTERN_BODY);
 }
 
-static void init_diff_merge_revs(struct rev_info *revs) {
-	revs->ignore_merges = -1;
-}
-
-static int parse_diff_merge_opts(struct rev_info *revs, const char **argv) {
-	int argcount;
-	const char *optarg;
-	const char *arg = argv[0];
-
-	if (!strcmp(arg, "-m")) {
-		/*
-		 * To "diff-index", "-m" means "match missing", and to the "log"
-		 * family of commands, it means "show full diff for merges". Set
-		 * both fields appropriately.
-		 */
-		revs->ignore_merges = 0;
-		revs->match_missing = 1;
-	} else if (!strcmp(arg, "-c")) {
-		revs->diff = 1;
-		revs->dense_combined_merges = 0;
-		revs->combine_merges = 1;
-	} else if (!strcmp(arg, "--cc")) {
-		revs->diff = 1;
-		revs->dense_combined_merges = 1;
-		revs->combine_merges = 1;
-	} else if (!strcmp(arg, "--no-diff-merges")) {
-		revs->ignore_merges = 1;
-	} else if (!strcmp(arg, "--combined-all-paths")) {
-		revs->diff = 1;
-		revs->combined_all_paths = 1;
-	} else if ((argcount = parse_long_opt("diff-merges", argv, &optarg))) {
-		if (!strcmp(optarg, "off")) {
-			revs->ignore_merges = 1;
-		} else {
-			die(_("unknown value for --diff-merges: %s"), optarg);
-		}
-	} else
-		return 0;
-
-	return 1;
-}
-
-static void setup_diff_merges_revs(struct rev_info *revs)
-{
-	if (revs->combine_merges && revs->ignore_merges < 0)
-		revs->ignore_merges = 0;
-	if (revs->ignore_merges < 0)
-		revs->ignore_merges = 1;
-	if (revs->combined_all_paths && !revs->combine_merges)
-		die("--combined-all-paths makes no sense without -c or --cc");
-}
-
-void rev_diff_merges_first_parent_defaults_to_enable(struct rev_info *revs) {
-	if (revs->first_parent_only && revs->ignore_merges < 0)
-		revs->ignore_merges = 0;
-}
-
-void rev_diff_merges_default_to_dense_combined(struct rev_info *revs) {
-	if (revs->ignore_merges < 0) {
-		/* There was no "-m" variant on the command line */
-		revs->ignore_merges = 0;
-		if (!revs->first_parent_only && !revs->combine_merges) {
-			/* No "--first-parent", "-c", or "--cc" */
-			revs->combine_merges = 1;
-			revs->dense_combined_merges = 1;
-		}
-	}
-}
-
 static int handle_revision_opt(struct rev_info *revs, int argc, const char **argv,
 			       int *unkc, const char **unkv,
 			       const struct setup_revision_opt* opt)
diff --git a/revision.h b/revision.h
index 3dd0229f4edc..f6bf860d19e5 100644
--- a/revision.h
+++ b/revision.h
@@ -456,7 +456,4 @@ int rewrite_parents(struct rev_info *revs,
  */
 struct commit_list *get_saved_parents(struct rev_info *revs, const struct commit *commit);
 
-void rev_diff_merges_default_to_dense_combined(struct rev_info *revs);
-void rev_diff_merges_first_parent_defaults_to_enable(struct rev_info *revs);
-
 #endif
-- 
2.25.1

