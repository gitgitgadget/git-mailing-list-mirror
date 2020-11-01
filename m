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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38F0DC388F9
	for <git@archiver.kernel.org>; Sun,  1 Nov 2020 19:34:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB35120B1F
	for <git@archiver.kernel.org>; Sun,  1 Nov 2020 19:34:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rhpDXjHC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbgKATeK (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 1 Nov 2020 14:34:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727033AbgKATeI (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Nov 2020 14:34:08 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91406C0617A6
        for <git@vger.kernel.org>; Sun,  1 Nov 2020 11:34:08 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id b1so14596054lfp.11
        for <git@vger.kernel.org>; Sun, 01 Nov 2020 11:34:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=grSGKk6XgsOZA5TlHcMTJbWxLxMLrRkarHdd03r2/ew=;
        b=rhpDXjHCWKMd8cSkd0vSEIBp6fJrxkljcSHRC5bNA2x+OD7jUyuwf1u4H0hb03T28w
         W+I1cgaS0qCtrHdbYAerVB0EV6icXU2vSmA9OyPXXTmnYsv5qiY2e4TB1/VoBo/SFkGi
         7eLaDld/srdtBKJ26EQbhqI54Vb7708fyN1dVX/Uj94eoFLhQCKy/s/Wqr7xKF328GPI
         0dlZ/omz1hFy4tzr/W+0g0AkDxcRrLdZcaRCkn6Zyk3YNBRl28df4GBx5zJ+cLYk1Ek/
         Lm50Rw0k4Q0eJV3UFvgGeKzqcQqfA9+V0yhH4T8apLpf2EijdWkKODhByJmfxsp+HaFV
         SKOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=grSGKk6XgsOZA5TlHcMTJbWxLxMLrRkarHdd03r2/ew=;
        b=NrFC9G/fGwnem9tfoMx848sc0sr2/Sl9/QgMdAwrza6fwlFAZfFRWq+ESJLr5bXNSc
         V43hgUxbCxsSvjPA8YPQ15vleDjERcJyzXGLQihgimvlaAVzx/ls8UyIsBSRRIdXLZAd
         RWnmlwSY2HSW16vlxbxV6+dpCYrhXv1RWag4egr8X4BevpAix9FHXSN95pkauTbWZriZ
         ii2dF8EwNDbxmB2QGfgx0RjezxpUlk1GwP4VCTSoLnjs57sat9/cX2zQdBZZMhwRLpKk
         54cX8/v7vTYP9/JLD1pwLVsfKM3XGjXhSTE1MU5bdvqO2jMsNCOdNtQ+gzMpxKDGucus
         8ZyA==
X-Gm-Message-State: AOAM531tG7Pk5s63dWGUPVBeYCufianqGDyybrPykp8xkUeYhn+3JoOd
        e154cJ05CO2hFpZxi/FCXgtRFMS/pIc=
X-Google-Smtp-Source: ABdhPJyl3tVvTUv5lTn+FdK1PA+Tg08iE+g4HqTgTpUPaabJXtz2hiFWUTMiGL4o4xNGfc/DtSZUOw==
X-Received: by 2002:a19:e015:: with SMTP id x21mr5119229lfg.586.1604259247110;
        Sun, 01 Nov 2020 11:34:07 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id m12sm1766526ljc.88.2020.11.01.11.34.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2020 11:34:06 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Sergey Organov <sorganov@gmail.com>
Subject: [PATCH 04/26] revision: provide implementation for diff merges tweaks
Date:   Sun,  1 Nov 2020 22:33:08 +0300
Message-Id: <20201101193330.24775-5-sorganov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201101193330.24775-1-sorganov@gmail.com>
References: <20201101193330.24775-1-sorganov@gmail.com>
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
index bc568fb79778..ce90c2991657 100644
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

