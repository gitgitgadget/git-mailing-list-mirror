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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AEF4C4332D
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 18:03:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E263B22D49
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 18:03:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726203AbgLUSDl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Dec 2020 13:03:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725785AbgLUSDl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Dec 2020 13:03:41 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71D4DC0613D3
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 10:03:25 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id u19so10454983edx.2
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 10:03:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=61BINhQ8Eu2xwEp9/vsPlUB9w5wSgAz0Ciq+G02xFXs=;
        b=XyRoyB89/fWFqJ4G6LI4uTILGBS47kL25APJ11TC6iJsFYpGbBFqt0q4Ko1GqUzY1X
         Yu7fR8JOFJHAAKfuOY/D6Lxjfw0L4a9yQveGbwXtKWBqU9AbyZZ5g8WssZ269CEGJGEk
         VJ4K216ViXPan+g2rUOQ2niz/HIYX4XZQ3aUOjFJ0AC8xrfFdw443v7kUTjECStNhecZ
         aswr/BBoXMdCk1CNgZwV0/V8JJuYCG9GBv4rDcM0hqEJuHLfTy/5oniH6A/CqzQK7upJ
         nB2RtuupSFSwrjjTdC5lxj9M9NPp2/AYXzbG8Qb3WixocLzGAbRz8ua9dDRaGShqNosR
         gY/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=61BINhQ8Eu2xwEp9/vsPlUB9w5wSgAz0Ciq+G02xFXs=;
        b=N7gXGgswGMvFknaJWnI8jwAfUYF4wHO9k1tosVdBHI1qs8lL/7Hzy3GltesJFSHzfK
         gEs5HSU/PTmMlPARYUCQC13g4N7nedZCE0TDfjuDKpxj9an8fIg/Mk4uJPuu9snf+HnH
         gOgDj7l6OFAiGeR83WAfCzAJMMXKq5Uo3JUHMz4iUZhNCutiusWyxczuwERtY6BBT5+4
         I2eWioQKnIqQIhcE3A/8i8ODlB5HO9T/TMq5aiQdPSmTgd4T2v1hbU0hm7WzaGbF8VWu
         kVMINBSovwXS1GR7HbF2KunWq5VW5R35RhqErsxZSZbeULNer3NKSihkVf7ADeO6t2YC
         mqYw==
X-Gm-Message-State: AOAM530Ii55grek3i4vFtrOSkBX4ikvy6xIxNnWPWlb7qDGKxoxEjOC/
        ziu3yLfL8aUzo/3ReZ3cy2wfJnPErdo=
X-Google-Smtp-Source: ABdhPJwAvfZ8k8Ic8FaZgWCOjkFq9Fu6M9WiwmNOIWehLWH26DTezR+TLm5RTwhaBsQ9CO1jGjn8kQ==
X-Received: by 2002:a2e:988b:: with SMTP id b11mr7370391ljj.167.1608564046184;
        Mon, 21 Dec 2020 07:20:46 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id c5sm2220085ljj.67.2020.12.21.07.20.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Dec 2020 07:20:45 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        git@vger.kernel.org, Sergey Organov <sorganov@gmail.com>
Subject: [PATCH v3 11/32] diff-merges: new function diff_merges_set_dense_combined_if_unset()
Date:   Mon, 21 Dec 2020 18:19:39 +0300
Message-Id: <20201221152000.13134-12-sorganov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201221152000.13134-1-sorganov@gmail.com>
References: <20201101193330.24775-1-sorganov@gmail.com>
 <20201221152000.13134-1-sorganov@gmail.com>
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
 diff-merges.c        | 16 ++++++++++++++--
 diff-merges.h        |  2 ++
 4 files changed, 24 insertions(+), 8 deletions(-)

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
index 23e6cb11d1ad..24f922cf8a0f 100644
--- a/diff-merges.c
+++ b/diff-merges.c
@@ -10,6 +10,13 @@ static void suppress(struct rev_info *revs)
 	revs->dense_combined_merges = 0;
 }
 
+static void set_dense_combined(struct rev_info *revs)
+{
+	revs->combine_merges = 1;
+	revs->dense_combined_merges = 1;
+}
+
+
 /*
  * Public functions. They are in the order they are called.
  */
@@ -39,8 +46,7 @@ int diff_merges_parse_opts(struct rev_info *revs, const char **argv)
 		revs->combine_merges = 1;
 	} else if (!strcmp(arg, "--cc")) {
 		revs->diff = 1;
-		revs->dense_combined_merges = 1;
-		revs->combine_merges = 1;
+		set_dense_combined(revs);
 	} else if (!strcmp(arg, "--no-diff-merges")) {
 		suppress(revs);
 	} else if (!strcmp(arg, "--combined-all-paths")) {
@@ -80,6 +86,12 @@ void diff_merges_default_to_dense_combined(struct rev_info *revs)
 	}
 }
 
+void diff_merges_set_dense_combined_if_unset(struct rev_info *revs)
+{
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

