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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22B53C433E0
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 18:16:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4A6723103
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 18:16:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726665AbgLUSQM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Dec 2020 13:16:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726556AbgLUSQL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Dec 2020 13:16:11 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F246AC061285
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 10:15:30 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id b2so10511744edm.3
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 10:15:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/tiJaIrs+w3dght1iOvCrrZWJsCxl5+W23rO17dPpXk=;
        b=cLOCpr1KOKS4zMM4hrPTis7LbqiYcc+2hicYQ8HyNgSqc+kM63Lg5wKRiYtfHKIggR
         8UJJrRUAZE4gfnryQeoHJiU2OaKmBsY71Z+0KwsA11g6QgB6Tl6kHnZcdG3fRGdyUsn/
         xBjFzoPWvTj7gK+MicjV38JF9C57GVI+tS+1+thKaQr0hzb4A2js4zAV/v53AsJqQjod
         BEoAMaqgSr8oG4ivuTMjZeFU4TX6+z/pO4kCunU2mkR8Q7IKxNwJ309rPwn5RoXtZdWd
         xMyDv/RQCIXGmODl+ufb3ZPCoOFs3pCki7LZDH/keX3GoYP5nC/dG2C8vXbJYVvwSfXq
         PxgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/tiJaIrs+w3dght1iOvCrrZWJsCxl5+W23rO17dPpXk=;
        b=hzG7rqC/40CRqtDUXkTstCD0/EJXGpnUOtpKbLsExbl37NJkmEyVGbrtzuuN6HM2qu
         gKmGeZsKgt4J28fBrfdY7c+NFlRyk5KBA6oPDpgEoH4/wD8LPSmyUWtYGIPGLcFWH+Op
         rHAcvM4oyrUnWsqATMUvE4zOMCohSjmEoo0fiM0VfFQuzliLxhvOsfyPDg4+cW0KhPXh
         zUpYd8LHrOyR3famsK0eELj/LWgtv61WQLZVPR9r6zFRJbv78It6YhzWibF6dEyAst1k
         MWefFedBR7JmO1C0oc+7fJ4o8I+oZZozydnCOZ5pdWDQvZRs7lh3yR67iHRzwnUFf0lC
         KaLg==
X-Gm-Message-State: AOAM530hV4p4iw4eGlPkWA/jPA5HMLKq/swTBAz0T9hIhPdTmYdszJTz
        DuXxOeBANSk5URt6wicDA9IJyXIrduA=
X-Google-Smtp-Source: ABdhPJx+IZyK9dS4Lw4n8j/FIA79mTA+30zbQtDppdgR4OS4aLFO4ukZs3FhUsx/WM0xxuTJab3VDA==
X-Received: by 2002:a05:651c:513:: with SMTP id o19mr7971804ljp.149.1608564041288;
        Mon, 21 Dec 2020 07:20:41 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id c5sm2220085ljj.67.2020.12.21.07.20.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Dec 2020 07:20:40 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        git@vger.kernel.org, Sergey Organov <sorganov@gmail.com>
Subject: [PATCH v3 07/32] diff-merges: move checks for first_parent_only out of the module
Date:   Mon, 21 Dec 2020 18:19:35 +0300
Message-Id: <20201221152000.13134-8-sorganov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201221152000.13134-1-sorganov@gmail.com>
References: <20201101193330.24775-1-sorganov@gmail.com>
 <20201221152000.13134-1-sorganov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The checks for first_parent_only don't in fact belong to this module,
as the primary purpose of this flag is history traversal limiting, so
get it out of this module and rename the

diff_merges_first_parent_defaults_to_enable()

to

diff_merges_default_to_enable()

to match new semantics.

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 builtin/log.c |  8 ++++++--
 diff-merges.c | 10 ++++------
 diff-merges.h |  2 +-
 3 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 77a7bba543ad..a7791c003c91 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -599,7 +599,10 @@ static int show_tree_object(const struct object_id *oid,
 static void show_setup_revisions_tweak(struct rev_info *rev,
 				       struct setup_revision_opt *opt)
 {
-	diff_merges_default_to_dense_combined(rev);
+	if (rev->first_parent_only)
+		diff_merges_default_to_enable(rev);
+	else
+		diff_merges_default_to_dense_combined(rev);
 	if (!rev->diffopt.output_format)
 		rev->diffopt.output_format = DIFF_FORMAT_PATCH;
 }
@@ -724,7 +727,8 @@ static void log_setup_revisions_tweak(struct rev_info *rev,
 	if (!rev->diffopt.output_format && rev->combine_merges)
 		rev->diffopt.output_format = DIFF_FORMAT_PATCH;
 
-	diff_merges_first_parent_defaults_to_enable(rev);
+	if (rev->first_parent_only)
+		diff_merges_default_to_enable(rev);
 }
 
 int cmd_log(int argc, const char **argv, const char *prefix)
diff --git a/diff-merges.c b/diff-merges.c
index 9286dbbd4dfd..a3bafa92f3e1 100644
--- a/diff-merges.c
+++ b/diff-merges.c
@@ -56,19 +56,17 @@ void diff_merges_setup_revs(struct rev_info *revs)
 		die("--combined-all-paths makes no sense without -c or --cc");
 }
 
-void diff_merges_first_parent_defaults_to_enable(struct rev_info *revs)
+void diff_merges_default_to_enable(struct rev_info *revs)
 {
-	if (revs->first_parent_only && revs->ignore_merges < 0)
+	if (revs->ignore_merges < 0)		/* No -m */
 		revs->ignore_merges = 0;
 }
 
 void diff_merges_default_to_dense_combined(struct rev_info *revs)
 {
-	if (revs->ignore_merges < 0) {
-		/* There was no "-m" variant on the command line */
+	if (revs->ignore_merges < 0) {		/* No -m */
 		revs->ignore_merges = 0;
-		if (!revs->first_parent_only && !revs->combine_merges) {
-			/* No "--first-parent", "-c", or "--cc" */
+		if (!revs->combine_merges) {	/* No -c/--cc" */
 			revs->combine_merges = 1;
 			revs->dense_combined_merges = 1;
 		}
diff --git a/diff-merges.h b/diff-merges.h
index 4ced909b795e..6937d46219f1 100644
--- a/diff-merges.h
+++ b/diff-merges.h
@@ -17,7 +17,7 @@ void diff_merges_setup_revs(struct rev_info *revs);
 
 void diff_merges_default_to_dense_combined(struct rev_info *revs);
 
-void diff_merges_first_parent_defaults_to_enable(struct rev_info *revs);
+void diff_merges_default_to_enable(struct rev_info *revs);
 
 
 #endif
-- 
2.25.1

