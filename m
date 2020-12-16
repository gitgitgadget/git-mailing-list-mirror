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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FAD9C4361B
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 18:51:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECA862342C
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 18:51:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732210AbgLPSvL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Dec 2020 13:51:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732205AbgLPSvK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Dec 2020 13:51:10 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5AECC0617B0
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 10:50:29 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id y19so50899705lfa.13
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 10:50:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nm6/Ih1KABgGx3/Ln7uPqFvEfdXK5Dgba1WeNZ61KqA=;
        b=JXWj1pfeF6o2AWpjKacvj3GELMZDeHM8BGKkQfkdo1QHjqOFprhdDfZZ52i0pRnJKi
         a3II4OrlpgdPE103UU+fkuBKSBOLwdax4ohQXM8bFSAbJGa0DuDYLY0yULH51R3TWfUR
         2i58HTcH/jwxtkCLM8Z4eNqGzbYpOwzVM8/YvHDmwzwes6aiOekUCHanjfqtI39oIwY7
         qv/KFqd93mTELnn9arw1lkKQFgZypmUdFWyV1v+toPrHC1T9kk9Ike0padhG9NDMAeps
         JdOvcp2IN8QMqLNxz437xQeSxXq4jqJXi1AnRJ0HAoZqelxGJ1WOqOMOcVrU1QEN0p6e
         b+4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nm6/Ih1KABgGx3/Ln7uPqFvEfdXK5Dgba1WeNZ61KqA=;
        b=tSlY5emuT7g76/idGZeIJHH5Mm2mxSuSgGXQ49FDH1ejO6Eo4wIbyJRy6eCtI6LeQ9
         nQmMm7XENVGLEaXHNfpe+7iPxC1oJjnsg7LRBybbNDll31Uj45T9tNx1Gioy+JfrvF7S
         Kx8f+w46z33qITWzV0dENHo3em+yY+LSSDOGPT8E+dhuZafLefe8XC0hACupRU/l7V2i
         GHxsHCu6orFOXLyROVrlYBVrv0H5r3cjLrwbivUUWLYLjIzyByQaQDMZLIETcJ6iIYWd
         5IHMFIxuwuTSFQfiTKdkHTmDj2CXQQP9Zgd1rWk5KgM0CUv32dZqfwFXscur229HVLce
         /x5g==
X-Gm-Message-State: AOAM532/dGpYNBgDEhw0+3oYQe8nIu68CWeR8RT3kyo4ti+lm7ywgL/Z
        bEli5O46HxJCbDZwPoKXudU=
X-Google-Smtp-Source: ABdhPJxXNhsW7CNx0EvydjgvmHYQcuYVinA7pbViEGM/rwi1H1Dw61ZD7B0UCj3vp8yVbgl2dBVS1Q==
X-Received: by 2002:a19:3804:: with SMTP id f4mr5120507lfa.163.1608144627479;
        Wed, 16 Dec 2020 10:50:27 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id 197sm313871lfe.158.2020.12.16.10.50.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 10:50:26 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>, git@vger.kernel.org,
        Sergey Organov <sorganov@gmail.com>
Subject: [PATCH v2 04/33] revision: provide implementation for diff merges tweaks
Date:   Wed, 16 Dec 2020 21:49:00 +0300
Message-Id: <20201216184929.3924-5-sorganov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201216184929.3924-1-sorganov@gmail.com>
References: <20201101193330.24775-1-sorganov@gmail.com>
 <20201216184929.3924-1-sorganov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use these implementations from show_setup_revisions_tweak() and
log_setup_revisions_tweak() in builtin/log.c.

This completes moving of management of diff merges parameters to a
single place, where we can finally observe them simultaneously.

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 builtin/log.c | 13 ++-----------
 revision.c    | 17 +++++++++++++++++
 revision.h    |  3 +++
 3 files changed, 22 insertions(+), 11 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 0a7ed4bef92b..717855a49e90 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -598,15 +598,7 @@ static int show_tree_object(const struct object_id *oid,
 static void show_setup_revisions_tweak(struct rev_info *rev,
 				       struct setup_revision_opt *opt)
 {
-	if (rev->ignore_merges < 0) {
-		/* There was no "-m" variant on the command line */
-		rev->ignore_merges = 0;
-		if (!rev->first_parent_only && !rev->combine_merges) {
-			/* No "--first-parent", "-c", or "--cc" */
-			rev->combine_merges = 1;
-			rev->dense_combined_merges = 1;
-		}
-	}
+	rev_diff_merges_default_to_dense_combined(rev);
 	if (!rev->diffopt.output_format)
 		rev->diffopt.output_format = DIFF_FORMAT_PATCH;
 }
@@ -731,8 +723,7 @@ static void log_setup_revisions_tweak(struct rev_info *rev,
 	if (!rev->diffopt.output_format && rev->combine_merges)
 		rev->diffopt.output_format = DIFF_FORMAT_PATCH;
 
-	if (rev->first_parent_only && rev->ignore_merges < 0)
-		rev->ignore_merges = 0;
+	rev_diff_merges_first_parent_defaults_to_enable(rev);
 }
 
 int cmd_log(int argc, const char **argv, const char *prefix)
diff --git a/revision.c b/revision.c
index da82663c8ce1..7b5b59a3c848 100644
--- a/revision.c
+++ b/revision.c
@@ -2207,6 +2207,23 @@ static void setup_diff_merges_revs(struct rev_info *revs)
 		die("--combined-all-paths makes no sense without -c or --cc");
 }
 
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
+
 static int handle_revision_opt(struct rev_info *revs, int argc, const char **argv,
 			       int *unkc, const char **unkv,
 			       const struct setup_revision_opt* opt)
diff --git a/revision.h b/revision.h
index f6bf860d19e5..3dd0229f4edc 100644
--- a/revision.h
+++ b/revision.h
@@ -456,4 +456,7 @@ int rewrite_parents(struct rev_info *revs,
  */
 struct commit_list *get_saved_parents(struct rev_info *revs, const struct commit *commit);
 
+void rev_diff_merges_default_to_dense_combined(struct rev_info *revs);
+void rev_diff_merges_first_parent_defaults_to_enable(struct rev_info *revs);
+
 #endif
-- 
2.25.1

