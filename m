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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49F24C4361B
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 18:51:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 120C52342C
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 18:51:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731101AbgLPSvp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Dec 2020 13:51:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728177AbgLPSvp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Dec 2020 13:51:45 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16760C06138C
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 10:50:31 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id x20so31448510lfe.12
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 10:50:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JUiOqUyqjaUoBO09wKqBlRfHIkLjuSIe3ERh6Gs/PSc=;
        b=q5QTIX+/f2LvEwMeLa+L3OffpU9gYU1Wsk57sVQACnaHfQQC84YREzUQpZS0Ik3nhC
         AVO3V4XjopE2vB8Uk5oYK5KuWVUevbcydaNhLmeJ5y5Tew6OCzVa7+L5sOn4jmXuX+yR
         QsqQCZiBZJviWeDFmCYsojJRrDFIWrZlN0rzlby7nIgmsVgCMvIUmSa9me97eFXg/AEu
         Gqdt5erZp2elIVivYB/OG2b9JRvKEiH80Izcr1kYkd9vc+7KBJoo5UN8Eq5qOHUWf19d
         +RlkaZFXL061JjhCGw8s4tgY3NJpyoWU16KGlvutrbflxsOZy8baYK1aQzQy0FR5Vw8o
         7aQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JUiOqUyqjaUoBO09wKqBlRfHIkLjuSIe3ERh6Gs/PSc=;
        b=WTQcHu24rC7xBOSJYQs1jUv6cHIjTp7ATBylaGK/CIVedGH907eMivTwOr3GnQmCW1
         sRJ+JFE1xcoJJnE5pJ4X1CqdNGdelzJ38h/6ih+/9n6ItusJemcJM7FdfM+7QDus44sH
         QytqJiXPT3Gl6Epc3jTnyuuHsGaPi8wGbfDSdWsZT0wTtlgaTbCdsjWtWZOwO58aXLl1
         mZqmL2M3HC9gFEbhvGzRkgvteazvq8iLr6ZEzyobX0OO7On6UGSm/C2h30sHXOGPnpnE
         iuj7odIJydnPRau2NdEVT/SgcQTCOC/K1bLZc1jTC82jUjlLcksRTYTlIaqK2U7nz+KS
         YAfQ==
X-Gm-Message-State: AOAM533FsMZQKD/UE2SUd/vhVxQrs1AbrZodPuL87pLJLhjnziCvXGdZ
        pl2dud0G79Y/YfOPXhtKKeQ=
X-Google-Smtp-Source: ABdhPJwuzsPCg3VxT20d9MjolI09S3YBpUlJIctGw3DII+hfGvh3VGUkPdCN/eq6O4mqA3yMEILK4g==
X-Received: by 2002:a19:c85:: with SMTP id 127mr12252826lfm.240.1608144628738;
        Wed, 16 Dec 2020 10:50:28 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id 197sm313871lfe.158.2020.12.16.10.50.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 10:50:28 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>, git@vger.kernel.org,
        Sergey Organov <sorganov@gmail.com>
Subject: [PATCH v2 05/33] revision: move diff merges functions to its own diff-merges.c
Date:   Wed, 16 Dec 2020 21:49:01 +0300
Message-Id: <20201216184929.3924-6-sorganov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201216184929.3924-1-sorganov@gmail.com>
References: <20201101193330.24775-1-sorganov@gmail.com>
 <20201216184929.3924-1-sorganov@gmail.com>
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
 diff-merges.h | 18 +++++++++++++
 revision.c    | 72 +--------------------------------------------------
 revision.h    |  3 ---
 6 files changed, 93 insertions(+), 74 deletions(-)
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
index 000000000000..eb25bcca2494
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
index 7b5b59a3c848..4bc14a08a624 100644
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

