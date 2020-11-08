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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 746E4C56201
	for <git@archiver.kernel.org>; Sun,  8 Nov 2020 21:41:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A91920657
	for <git@archiver.kernel.org>; Sun,  8 Nov 2020 21:41:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CN15WwV3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728914AbgKHVl0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 8 Nov 2020 16:41:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728893AbgKHVlZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Nov 2020 16:41:25 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E0A0C0613CF
        for <git@vger.kernel.org>; Sun,  8 Nov 2020 13:41:25 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id f11so3298677lfs.3
        for <git@vger.kernel.org>; Sun, 08 Nov 2020 13:41:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=grSGKk6XgsOZA5TlHcMTJbWxLxMLrRkarHdd03r2/ew=;
        b=CN15WwV3pmJnceOo3Yl8A2glkE7syPFfCH3qalwyGuFeNexo7aoOn9XVQ/axkjgYlQ
         1azXZRVaVSsmRzXBrmvKL2d8wnkjm35FuagkOe+5nfaMk+45lOzzgp7byKUJlb0DHA9C
         tYNtfouhIZm0ZYCcwcWLN7JYz4ix+OjXu6SZIs4oh60zxH4/SsqV9SXg/d+sAeX16AqH
         Y2E1OyfXndLrzZIhbUmKUZFz+rDp5USmJJKtpCugJ5rcjaVmoQtfTykZTjX4WZuFt1g+
         K1gFUYbT60EcoyKof+XRGISKMNtpXHOyJsV7ZdYKEgx+uinKxRwvAjiR1IyS5mWk3Zlp
         TVXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=grSGKk6XgsOZA5TlHcMTJbWxLxMLrRkarHdd03r2/ew=;
        b=bMK2F6y46e0NfXozhwe3ce7uD9TLJLDyVzDAJzeAue8GiF8Z8rLwWXrQcOiAoQn0xK
         QruZOCDO46iNIB11s/FzTcDx0jQvu1iVAkV0rG2nImFQgMX76eKf2CIZo7S/ArEo/f4w
         rOD5d9D4K7B5wXkqbtshYZQuQsPaQaPHa8CTq6hU53mJEDADWNSzKrM+q6OVznOB7yaL
         w8wdCCShhKQenAx8Ohd8MvCCT+n2MOORPAXsYSHFwDrmiud2Ioy4GDDSPypITGJJUUz/
         j8YxkjUf+w9CINFgJSjBmZ/dAu78slL1/96kmWtzgB7dagsfxQq14f31z05lcUaNbtuI
         5fsg==
X-Gm-Message-State: AOAM532sNWr0lFq5cQ1idrggEjroEHSJ67RgVFVAs5hu0GgUrvy3Z3QH
        Rs5TldzkClRtCDGpPRRem7I=
X-Google-Smtp-Source: ABdhPJyJQFo3q4KM4zkickT2MzlQcDzonELxn7HSFrajrlF3QHXvC5uVLkQGjcv3F7dPqIiJ930Bng==
X-Received: by 2002:ac2:5de4:: with SMTP id z4mr4112936lfq.98.1604871683649;
        Sun, 08 Nov 2020 13:41:23 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id k21sm1937392ljb.43.2020.11.08.13.41.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2020 13:41:23 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        git@vger.kernel.org, Sergey Organov <sorganov@gmail.com>
Subject: [PATCH v1 04/27] revision: provide implementation for diff merges tweaks
Date:   Mon,  9 Nov 2020 00:38:15 +0300
Message-Id: <20201108213838.4880-5-sorganov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201108213838.4880-1-sorganov@gmail.com>
References: <20201101193330.24775-1-sorganov@gmail.com>
 <20201108213838.4880-1-sorganov@gmail.com>
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

