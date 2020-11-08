Return-Path: <SRS0=1y/A=EO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5966EC63777
	for <git@archiver.kernel.org>; Sun,  8 Nov 2020 21:41:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19BC420656
	for <git@archiver.kernel.org>; Sun,  8 Nov 2020 21:41:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cRLs37Ra"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728969AbgKHVlg (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 8 Nov 2020 16:41:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728947AbgKHVlc (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Nov 2020 16:41:32 -0500
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E25EBC0613CF
        for <git@vger.kernel.org>; Sun,  8 Nov 2020 13:41:31 -0800 (PST)
Received: by mail-lj1-x244.google.com with SMTP id v18so7849660ljc.3
        for <git@vger.kernel.org>; Sun, 08 Nov 2020 13:41:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oS8sRU8XRe2sZyP1Nx2mZwbdjIr83+Gb1CaMfkAHGZI=;
        b=cRLs37RaWJ48vr9OkCtLc4WFa3wRgzJLmf6kVjQ3ipDSHXpnbLxyg8tFr5Rdal+lcg
         A8lUIhaboObEkjHl/eNlAOb5X1OIlu61g7ItFfCBJ1n1IVzELh4NTUplovH+rhusJSw0
         QF92Lxh7eE7UxP3WeWsSM3XvG9cLysCLO7hQ2nbVS6rtm5T0FTqI0G0HW/uZXUFBD4JO
         JsINTplyYGNYRloE9My9e2hKpZOKRiKszAl1iPPPEd7MHXTsIYQnIvNPWBmlazFYlVfC
         ZCkRnaDA4WbRTGaR53gB4TspZdLPJxnrGJZblAfVFqhbPb1a2whdYcy/H4EM9a4Q8MCu
         piWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oS8sRU8XRe2sZyP1Nx2mZwbdjIr83+Gb1CaMfkAHGZI=;
        b=FJj9SwK1azCjxIF+gWwKsOXXQOIqwrEzCuEVqGlpHg9kQj3lIriF5QZ71ufarTDRGI
         ZnJ/Q4qKNZcVWZWXaFl0XVLrzONyvoc8nvi5J3zi3/1veuE+NYQz+/vaf9GY/5JzHg/w
         npmA0Iq9HbOUnS4vve06NEH4wI++pdmtxYGCECCBUIUsjhM02B9KsAxJu9rkS0k8Zo9T
         WqoJEb6ynU6Eq/Z9EMFOzMZfiBvEH5nSfI1LWDcq6TUkoGQUrQNNb1EaPJoe5TBCZ6pi
         XB3O+SN5dkGxgyGQc0OwybWCBuHMOSC209pbQTojaKGFd0xL3Sn+uSIVE0zjtKsR8n+f
         SIbw==
X-Gm-Message-State: AOAM530TBsCur60MmBevy8Vq6Vv6+5qoxFNvrcOdC0aSASZzt6UHZywN
        UATisteB9QUWee8O8ZNrFA0=
X-Google-Smtp-Source: ABdhPJwGJy7Ytrl0VrgMutsLz2gPoOjwDvR6Qa3X6DLzjiYoCgCWcPiFK+DqjGsfq96J4D6x/67b8w==
X-Received: by 2002:a2e:309:: with SMTP id 9mr4489037ljd.297.1604871690457;
        Sun, 08 Nov 2020 13:41:30 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id k21sm1937392ljb.43.2020.11.08.13.41.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2020 13:41:29 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        git@vger.kernel.org, Sergey Organov <sorganov@gmail.com>
Subject: [PATCH v1 11/27] diff-merges: new function diff_merges_set_dense_combined_if_unset()
Date:   Mon,  9 Nov 2020 00:38:22 +0300
Message-Id: <20201108213838.4880-12-sorganov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201108213838.4880-1-sorganov@gmail.com>
References: <20201101193330.24775-1-sorganov@gmail.com>
 <20201108213838.4880-1-sorganov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Call it where given functionality is needed instead of direct
checking/tweaking of diff merges related fields.

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 builtin/diff-files.c |  5 +++--
 builtin/diff.c       |  9 +++++----
 diff-merges.c        | 11 +++++++++++
 diff-merges.h        |  2 ++
 4 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/builtin/diff-files.c b/builtin/diff-files.c
index 1e352dd8f77c..4742a4559b21 100644
--- a/builtin/diff-files.c
+++ b/builtin/diff-files.c
@@ -7,6 +7,7 @@
 #include "cache.h"
 #include "config.h"
 #include "diff.h"
+#include "diff-merges.h"
 #include "commit.h"
 #include "revision.h"
 #include "builtin.h"
@@ -69,9 +70,9 @@ int cmd_diff_files(int argc, const char **argv, const char *prefix)
 	 * was not asked to.  "diff-files -c -p" should not densify
 	 * (the user should ask with "diff-files --cc" explicitly).
 	 */
-	if (rev.max_count == -1 && !rev.combine_merges &&
+	if (rev.max_count == -1 &&
 	    (rev.diffopt.output_format & DIFF_FORMAT_PATCH))
-		rev.combine_merges = rev.dense_combined_merges = 1;
+		diff_merges_set_dense_combined_if_unset(&rev);
 
 	if (read_cache_preload(&rev.diffopt.pathspec) < 0) {
 		perror("read_cache_preload");
diff --git a/builtin/diff.c b/builtin/diff.c
index cd4083fed96e..2f570a3131cb 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -13,6 +13,7 @@
 #include "blob.h"
 #include "tag.h"
 #include "diff.h"
+#include "diff-merges.h"
 #include "diffcore.h"
 #include "revision.h"
 #include "log-tree.h"
@@ -199,8 +200,8 @@ static int builtin_diff_combined(struct rev_info *revs,
 	if (argc > 1)
 		usage(builtin_diff_usage);
 
-	if (!revs->dense_combined_merges && !revs->combine_merges)
-		revs->dense_combined_merges = revs->combine_merges = 1;
+	diff_merges_set_dense_combined_if_unset(revs);
+
 	for (i = 1; i < ents; i++)
 		oid_array_append(&parents, &ent[i].item->oid);
 	diff_tree_combined(&ent[0].item->oid, &parents, revs);
@@ -248,9 +249,9 @@ static int builtin_diff_files(struct rev_info *revs, int argc, const char **argv
 	 * dense one, --cc can be explicitly asked for, or just rely
 	 * on the default).
 	 */
-	if (revs->max_count == -1 && !revs->combine_merges &&
+	if (revs->max_count == -1 &&
 	    (revs->diffopt.output_format & DIFF_FORMAT_PATCH))
-		revs->combine_merges = revs->dense_combined_merges = 1;
+		diff_merges_set_dense_combined_if_unset(revs);
 
 	setup_work_tree();
 	if (read_cache_preload(&revs->diffopt.pathspec) < 0) {
diff --git a/diff-merges.c b/diff-merges.c
index 25bd9b12e667..691aabadbb32 100644
--- a/diff-merges.c
+++ b/diff-merges.c
@@ -9,6 +9,12 @@ static void suppress(struct rev_info *revs) {
 	revs->dense_combined_merges = 0;
 }
 
+static void set_dense_combined(struct rev_info *revs) {
+	revs->combine_merges = 1;
+	revs->dense_combined_merges = 1;
+}
+
+
 /*
  * Public functions. They are in the order they are called.
  */
@@ -73,6 +79,11 @@ void diff_merges_default_to_dense_combined(struct rev_info *revs) {
 	}
 }
 
+void diff_merges_set_dense_combined_if_unset(struct rev_info *revs) {
+	if (!revs->combine_merges)
+		set_dense_combined(revs);
+}
+
 void diff_merges_setup_revs(struct rev_info *revs)
 {
 	if (revs->combine_merges && revs->ignore_merges < 0)
diff --git a/diff-merges.h b/diff-merges.h
index 32720bc9b40f..ae1cc8ef9410 100644
--- a/diff-merges.h
+++ b/diff-merges.h
@@ -13,6 +13,8 @@ void diff_merges_default_to_first_parent(struct rev_info *revs);
 
 void diff_merges_default_to_dense_combined(struct rev_info *revs);
 
+void diff_merges_set_dense_combined_if_unset(struct rev_info *revs);
+
 void diff_merges_setup_revs(struct rev_info *revs);
 
 #endif
-- 
2.25.1

