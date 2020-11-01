Return-Path: <SRS0=MFMM=EH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86FFBC388F9
	for <git@archiver.kernel.org>; Sun,  1 Nov 2020 19:34:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49CFD20B1F
	for <git@archiver.kernel.org>; Sun,  1 Nov 2020 19:34:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e+OwxhXR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727264AbgKATeQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 1 Nov 2020 14:34:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727211AbgKATeO (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Nov 2020 14:34:14 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 481A6C0617A6
        for <git@vger.kernel.org>; Sun,  1 Nov 2020 11:34:14 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id l2so14678961lfk.0
        for <git@vger.kernel.org>; Sun, 01 Nov 2020 11:34:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=W47mVANbyr6U4QjohuRUI5qYDRLcugfgmhMpZzMRKhE=;
        b=e+OwxhXRGsAHiCQKTfPtVD2uD+6M9jeyctclZI/zty7b306EOige5yo45bKPRg0pbh
         DizfvxTtdWaSlHHc+RBzLI3z4qHXEqomJU4UGVbxC+ICLgdu2liM/5hcDH/pYTJIDD8c
         KpckTL4Nk3wz2wO+rj+y+/0aSw6LINnzUjrBV3h6r5CRz+hRXdwNwRumG3VtQsyt1mWI
         py4T72EgjAgoVcsWkcCXHxXWlZCQfEa1AYBw1G6dIVeYK2la7fkmHt09acrO4eR6kHW1
         D8MeTBdRHeXcbTVj1wmcTfNIptmEwizXy/Dx5vgLDojszTXdIVfQ/hkfhenyw+wicqc5
         mHWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W47mVANbyr6U4QjohuRUI5qYDRLcugfgmhMpZzMRKhE=;
        b=agBK89x9aC9gYApWpAzCpNkxGICnsk0YLnKmpsEW91Mr/kvGCoj1ZxOEv9vMLK4ODD
         oz/ZsdaZ3MGYUgCxnjSkLBkrmGuwICArF0xpIHFcSEfr35sYtt4IJ/JlWrEVr1LbhtFX
         +Q1G77wcmdcSeaGsiOB7PuE2O/Y9ZO0MgalLgOGMsRjRZM8AWmahB1TV3UvlnYPzlo9q
         vdVqDsQIb/Mk8uQL0keMQ7nqmrV61PFPyxAwmJpeRd6H8LuKF3cwpaKegRzDmSedTSuy
         9dQwWlGLYz9/SrTayGiHjpXqfQ4nVWxCm/HiO8bwxIaRIY1ELuPD0zofYDC4uhm4dJUu
         DCBg==
X-Gm-Message-State: AOAM530T1h2Y58Gr95vDZGx5+1oioeL5+tKMOaqv5RHFyqGhzN7jnizn
        36kcLUvILpYYhvNBIJk82Es=
X-Google-Smtp-Source: ABdhPJwS9HVc+jZ0CbjLncrDpInLQk3Hb1IGtQCRLYL86Yfy6hp6R+Ku/Q/wVrm0C2/ZhWZ0ztS8eQ==
X-Received: by 2002:a19:4286:: with SMTP id p128mr4363155lfa.5.1604259252756;
        Sun, 01 Nov 2020 11:34:12 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id m12sm1766526ljc.88.2020.11.01.11.34.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2020 11:34:12 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Sergey Organov <sorganov@gmail.com>
Subject: [PATCH 10/26] diff-merges: new function diff_merges_suppress()
Date:   Sun,  1 Nov 2020 22:33:14 +0300
Message-Id: <20201101193330.24775-11-sorganov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201101193330.24775-1-sorganov@gmail.com>
References: <20201101193330.24775-1-sorganov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This function sets all the relevant flags to disabled state, so that
no code that checks only one of them get it wrong.

Then we call this new function everywhere where diff merges output
suppression is needed.

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 builtin/merge.c |  3 ++-
 diff-merges.c   | 18 ++++++++++++++----
 diff-merges.h   |  2 ++
 fmt-merge-msg.c |  3 ++-
 4 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index 9d5359edc2f7..1f7b69982b40 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -14,6 +14,7 @@
 #include "lockfile.h"
 #include "run-command.h"
 #include "diff.h"
+#include "diff-merges.h"
 #include "refs.h"
 #include "refspec.h"
 #include "commit.h"
@@ -400,7 +401,7 @@ static void squash_message(struct commit *commit, struct commit_list *remotehead
 	printf(_("Squash commit -- not updating HEAD\n"));
 
 	repo_init_revisions(the_repository, &rev, NULL);
-	rev.ignore_merges = 1;
+	diff_merges_suppress(&rev);
 	rev.commit_format = CMIT_FMT_MEDIUM;
 
 	commit->object.flags |= UNINTERESTING;
diff --git a/diff-merges.c b/diff-merges.c
index 8536941e0b56..25bd9b12e667 100644
--- a/diff-merges.c
+++ b/diff-merges.c
@@ -2,6 +2,13 @@
 
 #include "revision.h"
 
+static void suppress(struct rev_info *revs) {
+	revs->ignore_merges = 1;
+	revs->first_parent_merges = 0;
+	revs->combine_merges = 0;
+	revs->dense_combined_merges = 0;
+}
+
 /*
  * Public functions. They are in the order they are called.
  */
@@ -29,16 +36,15 @@ int diff_merges_parse_opts(struct rev_info *revs, const char **argv) {
 		revs->combine_merges = 1;
 	} else if (!strcmp(arg, "--cc")) {
 		revs->diff = 1;
-		revs->dense_combined_merges = 1;
-		revs->combine_merges = 1;
+		set_dense_combined(revs);
 	} else if (!strcmp(arg, "--no-diff-merges")) {
-		revs->ignore_merges = 1;
+		suppress(revs);
 	} else if (!strcmp(arg, "--combined-all-paths")) {
 		revs->diff = 1;
 		revs->combined_all_paths = 1;
 	} else if ((argcount = parse_long_opt("diff-merges", argv, &optarg))) {
 		if (!strcmp(optarg, "off")) {
-			revs->ignore_merges = 1;
+			suppress(revs);
 		} else {
 			die(_("unknown value for --diff-merges: %s"), optarg);
 		}
@@ -48,6 +54,10 @@ int diff_merges_parse_opts(struct rev_info *revs, const char **argv) {
 	return 1;
 }
 
+void diff_merges_suppress(struct rev_info *revs) {
+	suppress(revs);
+}
+
 void diff_merges_default_to_first_parent(struct rev_info *revs) {
 	if (revs->ignore_merges < 0)		/* No -m */
 		revs->ignore_merges = 0;
diff --git a/diff-merges.h b/diff-merges.h
index 4b023c385d00..32720bc9b40f 100644
--- a/diff-merges.h
+++ b/diff-merges.h
@@ -7,6 +7,8 @@ void diff_merges_init_revs(struct rev_info *revs);
 
 int diff_merges_parse_opts(struct rev_info *revs, const char **argv);
 
+void diff_merges_suppress(struct rev_info *revs);
+
 void diff_merges_default_to_first_parent(struct rev_info *revs);
 
 void diff_merges_default_to_dense_combined(struct rev_info *revs);
diff --git a/fmt-merge-msg.c b/fmt-merge-msg.c
index bd22e1ea8865..abc3403fb820 100644
--- a/fmt-merge-msg.c
+++ b/fmt-merge-msg.c
@@ -2,6 +2,7 @@
 #include "refs.h"
 #include "object-store.h"
 #include "diff.h"
+#include "diff-merges.h"
 #include "revision.h"
 #include "tag.h"
 #include "string-list.h"
@@ -668,7 +669,7 @@ int fmt_merge_msg(struct strbuf *in, struct strbuf *out,
 		head = lookup_commit_or_die(&head_oid, "HEAD");
 		repo_init_revisions(the_repository, &rev, NULL);
 		rev.commit_format = CMIT_FMT_ONELINE;
-		rev.ignore_merges = 1;
+		diff_merges_suppress(&rev);
 		rev.limited = 1;
 
 		strbuf_complete_line(out);
-- 
2.25.1

