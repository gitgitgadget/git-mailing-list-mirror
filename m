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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7806C56202
	for <git@archiver.kernel.org>; Sun,  8 Nov 2020 21:41:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83F0020657
	for <git@archiver.kernel.org>; Sun,  8 Nov 2020 21:41:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m2WxTIlo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728944AbgKHVlb (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 8 Nov 2020 16:41:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728893AbgKHVl2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Nov 2020 16:41:28 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17962C0613CF
        for <git@vger.kernel.org>; Sun,  8 Nov 2020 13:41:28 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id e27so9552892lfn.7
        for <git@vger.kernel.org>; Sun, 08 Nov 2020 13:41:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5pCBzPS8bIv9Loi9jdaZq5GcWqyP3eTWThTaodtOZtY=;
        b=m2WxTIloqm0WvpLyJBG/w0OjlgI2CzPkAusnJFUJZ2Tg42bP91z3EoRGT+hA8LQr9H
         cTknPyQzF8LGA23ValuJq3KIyugvnmkVPRphGNLQu4EMXsWud1ypCxKKnX/jkSISsIdk
         5CJS+4pnIgcMWJoyWBsGIjcK8kkHS/oUzkF3TCqLbPREBQepmmBWnrz/+zwinBG/sZiI
         7XxrxAOokhfOzk0PcJ4Vd664OqjzJr+4yoet+sxKc++r4eZwtZa+hw7Nk/ZwXm3Cw5KC
         h+0CLL0D6B8vHvps2feSrcwVj/L5MjOhef/iMSW0EAvxIGnQJp7f+iSbPpq2WJeK5QSQ
         AQIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5pCBzPS8bIv9Loi9jdaZq5GcWqyP3eTWThTaodtOZtY=;
        b=L/pGdwEx7fMOixzgyfMskdTrkshJZJfERm4keEn83RkWz1bRlDOuT7W8qHs+Af/wOe
         p7q3mexkLZ/YKrfPaatzP1CFKljRSkyR8EyQXh9SZo5fF6Nk77xgUWuNZkeC2Ol21NRz
         t3auycb5Z9J7dtDebFNDssPH1CzwKGCZV/ic0EnA2wJbcwWAdg1+y0VR10pIyulmm2lF
         Meql7dWbVBfBFDtqBJdBchRxnIEla2nb969u0i7IYQ6w02njs3EJe7/eIXty5BjkrhuY
         Vlej31InMt/lWdLQ0UTkZyWQKg173yrjsNowFzNgKUzmwcGEva/4jEkuPnvyRZt5AAu6
         10iQ==
X-Gm-Message-State: AOAM530MTMNTUn1FoJo+VIZe0m4o5cIrTBtdwbIAUcCW3M5PW+5+BMh+
        JaWIEkggli7w9QyD+53FhgA=
X-Google-Smtp-Source: ABdhPJyMACWuNYDesxkrJMi36un7A/89dEyHPbYPfEDy0snSaUNtNqhU6SxrdsP11RnhMl1R22wl1g==
X-Received: by 2002:ac2:4847:: with SMTP id 7mr4806378lfy.463.1604871686650;
        Sun, 08 Nov 2020 13:41:26 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id k21sm1937392ljb.43.2020.11.08.13.41.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2020 13:41:26 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        git@vger.kernel.org, Sergey Organov <sorganov@gmail.com>
Subject: [PATCH v1 07/27] diff-merges: move checks for first_parent_only out of the module
Date:   Mon,  9 Nov 2020 00:38:18 +0300
Message-Id: <20201108213838.4880-8-sorganov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201108213838.4880-1-sorganov@gmail.com>
References: <20201101193330.24775-1-sorganov@gmail.com>
 <20201108213838.4880-1-sorganov@gmail.com>
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
index 85bf0b6d1d1d..9dd472803d15 100644
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
index 648c410497cb..cf411414898d 100644
--- a/diff-merges.h
+++ b/diff-merges.h
@@ -11,7 +11,7 @@ void diff_merges_setup_revs(struct rev_info *revs);
 
 void diff_merges_default_to_dense_combined(struct rev_info *revs);
 
-void diff_merges_first_parent_defaults_to_enable(struct rev_info *revs);
+void diff_merges_default_to_enable(struct rev_info *revs);
 
 
 #endif
-- 
2.25.1

