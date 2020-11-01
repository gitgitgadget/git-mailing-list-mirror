Return-Path: <SRS0=MFMM=EH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3A61C4741F
	for <git@archiver.kernel.org>; Sun,  1 Nov 2020 19:34:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B00772225C
	for <git@archiver.kernel.org>; Sun,  1 Nov 2020 19:34:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GtfiQbAj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727315AbgKATeW (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 1 Nov 2020 14:34:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727146AbgKATeP (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Nov 2020 14:34:15 -0500
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 325DAC061A47
        for <git@vger.kernel.org>; Sun,  1 Nov 2020 11:34:15 -0800 (PST)
Received: by mail-lj1-x241.google.com with SMTP id k25so12651152lji.9
        for <git@vger.kernel.org>; Sun, 01 Nov 2020 11:34:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oS8sRU8XRe2sZyP1Nx2mZwbdjIr83+Gb1CaMfkAHGZI=;
        b=GtfiQbAj8qGBIQCGFRgmvcHuBOUEa1fTMppF/cdmQNn+Vs9M571fRsn2vkyjxSMgaA
         7DhMsHFfhCaVsEpLiJTmn3c6f6f9NnMiWKGH0pCy3/iWx8ZKvxxXVNXXCjW/XlrXj47L
         cWr6DGzt6Tpq1z1ZbkQWI9OW0tlyyV4tMe2VKg03FUaGii0h1IDg6ei3ghd1WMlYC+01
         12AZZx0pa9El/uK0Ihr9eP82o+eYPSHGgyU2xx1LA21fBD446Ex7mBZoj3up7m7yPxG3
         IBfbAmD3Dpj9QznzsApu3q7mNjeNUOj9+71D8eo2VW9mfGb27qyqcSu1OZOV19boa8T/
         /Gfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oS8sRU8XRe2sZyP1Nx2mZwbdjIr83+Gb1CaMfkAHGZI=;
        b=BTcfKWPkUpV0gXRhV/BQCLsC6DY7hFgGfKXru6sYO9iw71He32IHC5ggiZVcoeh2Lu
         /5wEzOmtr8I6gSlzTM7UqTz+bG1qNHgx/Y8Jbs3IOgs884HrypDty+3yEDaCddJ80WLA
         /Tenl7kAF3DA6P5s06DMI3Mstn0OnZ0Ri5maj8X+cVGGgKhmjhKEKOCaphRDRjJuMgMn
         efA3fet0kgt90nVxKL4zEcja9XgYygwvqf2A6Gjl74g0Itjzd7VsF35K2iFs9u95SsOy
         JCKTTxE048zPHWtD5+VSa3ExxRKmAoMi5VPYfSDwch0tausPLbqJObSGCB7gqHAYK8ag
         VNqg==
X-Gm-Message-State: AOAM53284slK4oWAOIHVezq8xmG0aoaG5cFKkGMKA1gKluNpMSHyhfp4
        sKtvEuViZRa3LwW6Wu4r0K8=
X-Google-Smtp-Source: ABdhPJyhCJL1dX0VQnnzoO22a1UomfRlbp9K88LDWkZJEZxjLB5V6TscL8Tm49ewggl+klxUPJKzvQ==
X-Received: by 2002:a2e:8056:: with SMTP id p22mr4794496ljg.437.1604259253709;
        Sun, 01 Nov 2020 11:34:13 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id m12sm1766526ljc.88.2020.11.01.11.34.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2020 11:34:13 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Sergey Organov <sorganov@gmail.com>
Subject: [PATCH 11/26] diff-merges: new function diff_merges_set_dense_combined_if_unset()
Date:   Sun,  1 Nov 2020 22:33:15 +0300
Message-Id: <20201101193330.24775-12-sorganov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201101193330.24775-1-sorganov@gmail.com>
References: <20201101193330.24775-1-sorganov@gmail.com>
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

