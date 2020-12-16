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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDC94C0018C
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 18:51:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABFCC23432
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 18:51:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731127AbgLPSvt (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Dec 2020 13:51:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731104AbgLPSvs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Dec 2020 13:51:48 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15BEBC0611C5
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 10:50:38 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id l11so51010017lfg.0
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 10:50:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k8OTIuDYdPVnBiDWXAbW96V7zFaL6kOclSSRUpMpR8E=;
        b=c0kiCaUueEGcidGNwc9bSx2QPcs403xUeyBnmnE4B43sxAeVqXs5UoxBp4NdbtKPGQ
         Z9ktki1EVCaTrfK+VdTVMWlORtOUERTAEFBzYCzXGxZaiSBK6uLKLwkvkyQtypfRDOiB
         dJwacZrsSvnI5ZWTiVhJPqiAGsERV01JUiQ+5hJ6k2r88O5L00SkwdUAKVAoqGn5i7VP
         ctkCczRZ0OSqBoA2iEJDbqS/C+RO8wfwNz+tUIu4FPyRy+XoMozVaeGC/N4O7uJn8uZb
         ls+C/6Q8v31S5CmqPBQ8B3UxgUVCPtlYZrL/lDKZvKMAZggAt3epplV+StZ/4vHa0IjK
         kDVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k8OTIuDYdPVnBiDWXAbW96V7zFaL6kOclSSRUpMpR8E=;
        b=TadprFynvI+VZ8ARRzEyEdXJaS8qAS8OmL+8w2ZRy0q76/G1yuRTbHIvp56yYwBMfP
         PhM2hm+i+oEt7ho/zbyn2aCOsBdH9Qi8ST/vP8iNrD8tXNXjnsJXpUSISsneffEKzxR9
         ssN6s/Jrt/7Fl+poC8Ax8yEGD6DS9gJvXZqVHO3kE/z1hM9HY/sbLydkWH1+9NzD40FL
         V70QZDvlpF9YZkuTpQuEKSfFmF14hbEFqZwzc30Pz3HB0cd47RNUZqVXcx396SOV3G8e
         hSLNYvx0KCK89lCM5pJoJKv8hRafmxTctvGQuGXYUh+e3xFx5K3iT6Zf4jOs36UGqJ1d
         ObnQ==
X-Gm-Message-State: AOAM533A/5joo98+Z/8Bq2jKOdCXlOvddSrbIugvWP7Ua7eCbjTY+jqo
        NAyn5JVMnZSxwHFV66qgjUw=
X-Google-Smtp-Source: ABdhPJy+noG81P+1wSMJwRZ5klCsICKzk7FA8OuSlM/iz7ZZNan4fuYvPnSBZ0k+qDovZKhNfghYnA==
X-Received: by 2002:a2e:87cb:: with SMTP id v11mr14652439ljj.218.1608144635740;
        Wed, 16 Dec 2020 10:50:35 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id 197sm313871lfe.158.2020.12.16.10.50.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 10:50:34 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>, git@vger.kernel.org,
        Sergey Organov <sorganov@gmail.com>
Subject: [PATCH v2 10/33] diff-merges: new function diff_merges_suppress()
Date:   Wed, 16 Dec 2020 21:49:06 +0300
Message-Id: <20201216184929.3924-11-sorganov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201216184929.3924-1-sorganov@gmail.com>
References: <20201101193330.24775-1-sorganov@gmail.com>
 <20201216184929.3924-1-sorganov@gmail.com>
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
 diff-merges.c   | 15 +++++++++++++--
 diff-merges.h   |  2 ++
 fmt-merge-msg.c |  3 ++-
 4 files changed, 19 insertions(+), 4 deletions(-)

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
index a3b732c34717..b150c0490b1d 100644
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
@@ -32,13 +39,13 @@ int diff_merges_parse_opts(struct rev_info *revs, const char **argv) {
 		revs->dense_combined_merges = 1;
 		revs->combine_merges = 1;
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
@@ -48,6 +55,10 @@ int diff_merges_parse_opts(struct rev_info *revs, const char **argv) {
 	return argcount;
 }
 
+void diff_merges_suppress(struct rev_info *revs) {
+	suppress(revs);
+}
+
 void diff_merges_default_to_first_parent(struct rev_info *revs) {
 	if (revs->ignore_merges < 0)		/* No -m */
 		revs->ignore_merges = 0;
diff --git a/diff-merges.h b/diff-merges.h
index 243ef915c4cd..a031240576f7 100644
--- a/diff-merges.h
+++ b/diff-merges.h
@@ -13,6 +13,8 @@ void diff_merges_init_revs(struct rev_info *revs);
 
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

