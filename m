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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F526C433DB
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 18:53:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9BEA22AAB
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 18:53:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725883AbgLUSxn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Dec 2020 13:53:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725777AbgLUSxm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Dec 2020 13:53:42 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 358E1C0613D6
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 10:53:02 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id o19so26214037lfo.1
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 10:53:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hrLNlI7e9ugKl9VkhvjWwIEmsRj6frckGTWUDBYWgpE=;
        b=VeJcuBjMpobxf45rchxF/ylUZxL7ZC4yg2j7wAVDropH8nK4xVTGHUjW3eySoumL8b
         J2ThiFetHwWp6nUuTXou/VcGGEORVoOvWTrfUUQTtcyN3U3vKj0ELCQR0Y+eTSxgclJb
         AsKK9jabYo6meiBH9BT54ItuLW9M8OlseufkNDZ2LTUgg7H1TFKfgU4z4ppxF/rtHj8y
         LGxcem3nJPtP5cdUwS/87FXlnOnF2QV8L6l9uwUHxT6I0Dxf87Rg/TRwcTc4A6C2u0qd
         twpSPt1zhxSmjv7URxvX1DZqj2W6YbmsXMAc1rpJ1C3WOR7Mvda4Z8EkOMBiVQiUvomW
         x7Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hrLNlI7e9ugKl9VkhvjWwIEmsRj6frckGTWUDBYWgpE=;
        b=jCcw2Mz54ByjTr75Z9SMPj7g5ukS+OuKqeYsGuSEPdw69ama7Z02//q0aZApiWZmJ8
         kDViVzmXQyWBdi2NOIuK8NSsP1vy6n0b4jRTgjesUJeI4O+RSqEXN0wnoQpHK2Sk9pFn
         ZKGOcn+Uk9SuwmUkd5eZTVTF+oRVZ6M6H0EEAekVZMzOlzFqeNZxGvP6ADQTi7oN5u6f
         75wy8dngWwgoXDBQzEJK2Hy+A7c4ykbrlaOrzddqleS0NvGbz/spURPIoTBlAoXO2Bd+
         J3lWFD9qlGIbh9waM41dYoArMaiNKtBjpreXbcLUOWyvAdhYnfLFDID2gkBQ41TzOk3O
         pg0g==
X-Gm-Message-State: AOAM533FVtvqZAlxtG/2aSVxo4Sk4/sS+CRrecIrV/T8Eujdy3b590sT
        VpS9HiVWRYjlvcUyzkusob2Yw1QIuSc=
X-Google-Smtp-Source: ABdhPJyhqJyqX2drJcy9Zj2es+VrcMMNHk3dSVgxq3K7t54p1rMOTvXAzTyOFAhhfFW25wNLNHYT5w==
X-Received: by 2002:a2e:86d0:: with SMTP id n16mr7978392ljj.147.1608564038735;
        Mon, 21 Dec 2020 07:20:38 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id c5sm2220085ljj.67.2020.12.21.07.20.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Dec 2020 07:20:37 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        git@vger.kernel.org, Sergey Organov <sorganov@gmail.com>
Subject: [PATCH v3 05/32] revision: move diff merges functions to its own diff-merges.c
Date:   Mon, 21 Dec 2020 18:19:33 +0300
Message-Id: <20201221152000.13134-6-sorganov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201221152000.13134-1-sorganov@gmail.com>
References: <20201101193330.24775-1-sorganov@gmail.com>
 <20201221152000.13134-1-sorganov@gmail.com>
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
 diff-merges.c | 76 +++++++++++++++++++++++++++++++++++++++++++++++++++
 diff-merges.h | 18 ++++++++++++
 revision.c    | 76 +--------------------------------------------------
 revision.h    |  3 --
 6 files changed, 97 insertions(+), 78 deletions(-)
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
index 000000000000..0204292aa9bb
--- /dev/null
+++ b/diff-merges.c
@@ -0,0 +1,76 @@
+#include "diff-merges.h"
+
+#include "revision.h"
+
+void init_diff_merge_revs(struct rev_info *revs)
+{
+	revs->ignore_merges = -1;
+}
+
+int parse_diff_merge_opts(struct rev_info *revs, const char **argv)
+{
+	int argcount = 1;
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
+		argcount = 0;
+
+	return argcount;
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
+void rev_diff_merges_first_parent_defaults_to_enable(struct rev_info *revs)
+{
+	if (revs->first_parent_only && revs->ignore_merges < 0)
+		revs->ignore_merges = 0;
+}
+
+void rev_diff_merges_default_to_dense_combined(struct rev_info *revs)
+{
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
index 000000000000..7e970b266cf5
--- /dev/null
+++ b/diff-merges.h
@@ -0,0 +1,18 @@
+#ifndef DIFF_MERGES_H
+#define DIFF_MERGES_H
+
+/*
+ * diff-merges - utility module to handle command-line options for
+ * selection of particular diff format of merge commits
+ * representation.
+ */
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
index 1c224d276474..4bc14a08a624 100644
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
@@ -2155,79 +2154,6 @@ static void add_message_grep(struct rev_info *revs, const char *pattern)
 	add_grep(revs, pattern, GREP_PATTERN_BODY);
 }
 
-static void init_diff_merge_revs(struct rev_info *revs)
-{
-	revs->ignore_merges = -1;
-}
-
-static int parse_diff_merge_opts(struct rev_info *revs, const char **argv)
-{
-	int argcount = 1;
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
-		argcount = 0;
-
-	return argcount;
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
-void rev_diff_merges_first_parent_defaults_to_enable(struct rev_info *revs)
-{
-	if (revs->first_parent_only && revs->ignore_merges < 0)
-		revs->ignore_merges = 0;
-}
-
-void rev_diff_merges_default_to_dense_combined(struct rev_info *revs)
-{
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

