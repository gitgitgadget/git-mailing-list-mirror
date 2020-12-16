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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2906C4361B
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 18:51:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 902032342C
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 18:51:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731119AbgLPSvr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Dec 2020 13:51:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729292AbgLPSvq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Dec 2020 13:51:46 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B186EC061285
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 10:50:33 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id a9so50972908lfh.2
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 10:50:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iNW8Ve2ipkb0+6ZllyCODjmDgA5uMCLVcVnyvm7hSZM=;
        b=psL1jyiSLK/bdgJ4NI7MSzmMLRSXN0BA7WvasScW1GK1rtAmcBLmfacTmU40yBVnZ3
         Xsj0aWcqRPCN/GeFbBfL4eiopqF4SpWNwV0WnA6onRbb6iANEMcg68ibQJMp2tsOogwN
         atr57RHveDPJVd1KRil0G6n2qJ2D2UpBiGj2ntwwM6WpOiJtWFgGxcs0/sjxt88FIQM6
         bvgEFdUJNmN4dYUkY8TIkbUXdwNjxE9Jqvknq5fDT9KEVfQWOwAyOtFoVuYFtNtMAPq5
         aftHmwJqRg/2aMixN0Q/tLXg6uoLZScqB6kmiKG3sO/np6lyxrlVv6ROZ5ASn0B6dCqO
         Thmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iNW8Ve2ipkb0+6ZllyCODjmDgA5uMCLVcVnyvm7hSZM=;
        b=HUuZ3lUygFu8HhfrXq5JVfAqH18zV7h34zJ+EypBPHrnuawbrD/Y5W/ELdxCdVlE3p
         b1y/ADAITSHh6tc6Z1HAeLxVXCmUOkyoyDehy/X6BRODZXWE+bq+GFzTWSGU10ovMSx1
         OKm8x31lritwVxJu0B+2UrK/+dBO+GkrthX5QOuCQ5POuZaTRFaJTntRCpk/Bph3cyqS
         +uBfwX2WAiji3XkI0IvvUnIB7HmDg82iC3LdMH3S233igTT7anb0VVwCjacgi+fczyMW
         3/hIy7JsCdSoH4ezfXOz33pTbxQWUR1OLp9ygqNqj/2QIyhsJ01kWT9OozJdIFDriSTn
         STPA==
X-Gm-Message-State: AOAM5334xiryUVQDntv2Oj3Vwd2+q8JwF4Rm6VUsBV8Xp05FYhsxx6dL
        Fpe0NU/5TtalwRx7XG1Ml0k=
X-Google-Smtp-Source: ABdhPJy3G/F2k0nvdjlMoTVGkESDil2bqcjn+mM4l4VPOLrrKHZPdbS1FpzQrEuIBF5q4hHkmHxmwg==
X-Received: by 2002:a19:c018:: with SMTP id q24mr9135093lff.631.1608144631376;
        Wed, 16 Dec 2020 10:50:31 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id 197sm313871lfe.158.2020.12.16.10.50.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 10:50:30 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>, git@vger.kernel.org,
        Sergey Organov <sorganov@gmail.com>
Subject: [PATCH v2 07/33] diff-merges: move checks for first_parent_only out of the module
Date:   Wed, 16 Dec 2020 21:49:03 +0300
Message-Id: <20201216184929.3924-8-sorganov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201216184929.3924-1-sorganov@gmail.com>
References: <20201101193330.24775-1-sorganov@gmail.com>
 <20201216184929.3924-1-sorganov@gmail.com>
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
index b647920bdb22..f0d0ae208213 100644
--- a/diff-merges.c
+++ b/diff-merges.c
@@ -54,17 +54,15 @@ void diff_merges_setup_revs(struct rev_info *revs)
 		die("--combined-all-paths makes no sense without -c or --cc");
 }
 
-void diff_merges_first_parent_defaults_to_enable(struct rev_info *revs) {
-	if (revs->first_parent_only && revs->ignore_merges < 0)
+void diff_merges_default_to_enable(struct rev_info *revs) {
+	if (revs->ignore_merges < 0)		/* No -m */
 		revs->ignore_merges = 0;
 }
 
 void diff_merges_default_to_dense_combined(struct rev_info *revs) {
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

