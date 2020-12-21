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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83041C433DB
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 19:18:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46AF822ADF
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 19:18:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726071AbgLUTSe (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Dec 2020 14:18:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbgLUTSe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Dec 2020 14:18:34 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D663DC0613D3
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 11:17:53 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id x20so26229580lfe.12
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 11:17:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=81t35u6BLxne4GZv6Q4N80La/+ff+O8tk+vKdsz8EMw=;
        b=G+TuRQ/3ISehNcTuGNvMF/neei8aKyre8KuKdQs5JiKj/HZs9yVZjeB7UhdiIvEb+J
         xnm2xS+1I0UJc3tC6zEQxohtvR6hTk2+evYGAUlL35DBI7BsQkBrth/7tcZG2GpjnphD
         IXfBKb07SWMQ9d/TqdMeClPWvCjW9dzV7dGweDhlAtndy4f8RJcnMrqHnlmvSkw1uHrT
         81MtDxmxRi11WgVLkOP97lzn8sS19DxLNMLrCg853IJTOagRb027Ius2rbbC6C3dzaxB
         yGM4CmlCzBzS9Usl45nLXjePfxMRrEunxwuMaF0io2mJb1YjJNYnfJbgcNckEIBBRACQ
         TMYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=81t35u6BLxne4GZv6Q4N80La/+ff+O8tk+vKdsz8EMw=;
        b=Lwo4CNqcIucA7oypvJoyDo/ZvmxV7PqY+ubQw/OB2ZOk4902ITBZGzcwq+7X4InMmv
         dCdvvVCgn15LPK3k6WQahdGJrt/xCK3B6n0d0HJYMSXBdjuQ4zjkZcJzPdrtGoEB1LND
         J19Bc/I6f9r+wHpbMdS9on/xWZCMnPaNMDbEzIXTgjc5r+Jy+ZDHTMu1LNrDrqWGGdXE
         mA6GSbQ/M2P7MXc+fyOzmcfI7P5XjCbHU6Hj3SAUTQnf/JOXsRaQxsdoETNWf7MCh/q9
         dGLJCqOGyOMCHu4ZWocn0+Y0rahWUPDEnMzC+THSbd3PyqVFBw8CS0yw4ZmIMtWolAW2
         tywg==
X-Gm-Message-State: AOAM532oMbyu6CfnVH/c1KwFlNGJ8hNhXJLUbTDGbQn7shFAbdX8fSA8
        uSk5wETZenZ9o7B7YNZ4ao1PTQXDxqo=
X-Google-Smtp-Source: ABdhPJzLN7S3VpW2oLgqUdMRp40GxLIUotdziCMMhjG4HmmjWM32SYA3NlkRK08HI68Yuw59to2DZg==
X-Received: by 2002:a2e:894c:: with SMTP id b12mr7318714ljk.401.1608564037421;
        Mon, 21 Dec 2020 07:20:37 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id c5sm2220085ljj.67.2020.12.21.07.20.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Dec 2020 07:20:36 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        git@vger.kernel.org, Sergey Organov <sorganov@gmail.com>
Subject: [PATCH v3 04/32] revision: provide implementation for diff merges tweaks
Date:   Mon, 21 Dec 2020 18:19:32 +0300
Message-Id: <20201221152000.13134-5-sorganov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201221152000.13134-1-sorganov@gmail.com>
References: <20201101193330.24775-1-sorganov@gmail.com>
 <20201221152000.13134-1-sorganov@gmail.com>
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
 revision.c    | 19 +++++++++++++++++++
 revision.h    |  3 +++
 3 files changed, 24 insertions(+), 11 deletions(-)

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
index 3250b2d7e112..1c224d276474 100644
--- a/revision.c
+++ b/revision.c
@@ -2209,6 +2209,25 @@ static void setup_diff_merges_revs(struct rev_info *revs)
 		die("--combined-all-paths makes no sense without -c or --cc");
 }
 
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

