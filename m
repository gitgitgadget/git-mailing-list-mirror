Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F257C0018C
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 18:51:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F9882342C
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 18:51:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731137AbgLPSvv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Dec 2020 13:51:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731130AbgLPSvv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Dec 2020 13:51:51 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80667C0611CA
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 10:50:39 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id a12so50989106lfl.6
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 10:50:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=n28UYN9Ovxtsxb+nVL6sKTyfaqRQ+GtHFsIzx0Dkeww=;
        b=KIBsI8cYlEBtQsmWkc7fZYehFyhANQktp3NeguP68yL6Osl7n9LgeYLnEhhGTBJ/97
         W5EbhbPofmvs9DJvbtLNjWjmPmB3j757V+rOgiHY8K6ff5RTcGDYpCSF+meZoa5ouVa4
         rGYYgKxmEOtnX1AeDr9MDlGDbNIktsvinCZV4EBHR1dJRAJMlStyE4h2HOuIkrAKv1hH
         rwHM5yDRVd+NUq1eMQrzhbTTChEczcSjRpPx+vpjh3ivgnFTK4WDxjWcLfyw86n8D04K
         SDlAeU9BxvR/x9PYWK7YfSBir7e5NWJL0Imq6FzHN3LN7iuygu2i3el8FPH2nqHYu7CS
         SgyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=n28UYN9Ovxtsxb+nVL6sKTyfaqRQ+GtHFsIzx0Dkeww=;
        b=XlXtiIHf5NfSZxPm1/Z3ZeVSkmh+mud+VSGGIsqTl9fsBHMcYZHeKFzehq6klvS1RC
         8Iorm++ogfnoEnDrv5eCr1vP5JLJV0IM/71G+wKvh0/Tg5UOWQsxzw+Mgm6SPHNEYW2k
         k3CSUtDngm3TZy0gGS7rmbBSbOJkBO44d81ID7yEABqt2wnAuqmx1eGYDds+/bRI2lnV
         6ymqYmGb9YtWuWmB2uhfQq5CBGc2lNQMWI3dfWWTCDfQsCJhvkYiACw3s1SqhMg/yIqb
         lPIK0dpZWZVrI4UpVXCUmSqTpfRXYdRTBnEsRWY2a1AkHK/j+71kYEY4FiXfwpmlRWwM
         Pxug==
X-Gm-Message-State: AOAM532YJfGC2BZqinQRmTdSKOetpmYCUi2ewKpskqz7aQ+XL0EwGwpO
        7C7w8Gyd0jITOX89LmKvH+Q=
X-Google-Smtp-Source: ABdhPJyfYr59l+VNNoYbiMuJchbIWj+8Nyw0hgwnmoHWm9VB4Ee7W1YNaY/O4rm586WNpeS+EWaUNA==
X-Received: by 2002:a19:23cf:: with SMTP id j198mr9572570lfj.509.1608144637090;
        Wed, 16 Dec 2020 10:50:37 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id 197sm313871lfe.158.2020.12.16.10.50.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 10:50:36 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>, git@vger.kernel.org,
        Sergey Organov <sorganov@gmail.com>
Subject: [PATCH v2 11/33] diff-merges: new function diff_merges_set_dense_combined_if_unset()
Date:   Wed, 16 Dec 2020 21:49:07 +0300
Message-Id: <20201216184929.3924-12-sorganov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201216184929.3924-1-sorganov@gmail.com>
References: <20201101193330.24775-1-sorganov@gmail.com>
 <20201216184929.3924-1-sorganov@gmail.com>
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
 diff-merges.c        | 14 ++++++++++++--
 diff-merges.h        |  2 ++
 4 files changed, 22 insertions(+), 8 deletions(-)

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
index b150c0490b1d..899f9e905d3c 100644
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
@@ -36,8 +42,7 @@ int diff_merges_parse_opts(struct rev_info *revs, const char **argv) {
 		revs->combine_merges = 1;
 	} else if (!strcmp(arg, "--cc")) {
 		revs->diff = 1;
-		revs->dense_combined_merges = 1;
-		revs->combine_merges = 1;
+		set_dense_combined(revs);
 	} else if (!strcmp(arg, "--no-diff-merges")) {
 		suppress(revs);
 	} else if (!strcmp(arg, "--combined-all-paths")) {
@@ -74,6 +79,11 @@ void diff_merges_default_to_dense_combined(struct rev_info *revs) {
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
index a031240576f7..f92de137d3a0 100644
--- a/diff-merges.h
+++ b/diff-merges.h
@@ -19,6 +19,8 @@ void diff_merges_default_to_first_parent(struct rev_info *revs);
 
 void diff_merges_default_to_dense_combined(struct rev_info *revs);
 
+void diff_merges_set_dense_combined_if_unset(struct rev_info *revs);
+
 void diff_merges_setup_revs(struct rev_info *revs);
 
 #endif
-- 
2.25.1

