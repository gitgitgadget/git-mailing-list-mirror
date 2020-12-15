Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 687E7C4361B
	for <git@archiver.kernel.org>; Tue, 15 Dec 2020 18:28:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CAD222B2D
	for <git@archiver.kernel.org>; Tue, 15 Dec 2020 18:28:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731550AbgLOS2w (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Dec 2020 13:28:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729368AbgLOS2v (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Dec 2020 13:28:51 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BE6BC0617B0
        for <git@vger.kernel.org>; Tue, 15 Dec 2020 10:28:11 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id x22so141043wmc.5
        for <git@vger.kernel.org>; Tue, 15 Dec 2020 10:28:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=SI+l5g9wGTUq3i9Ft6Oc+PNP4QnKTKBpBnZ3lsTnHgU=;
        b=qj4I0LRtP0oHjb/Fa/MTThmh5E52ddF6UPm3GHm033UD2hes4ckG1bTjKhsLqurQiw
         OOI8CBlyLp74cge3rTNQ1CCCL4vToolnjLAtw0LrRsvPESfo0/8sYYwiAtlt+u2z+bzp
         M69cgBri7sxlVaqHBEdFEY3cbKAjzPKjD01dfo5t8vs6ZlPxBuUJUKrXsk5Vis2v3gAG
         kihLVNSex+tz7pSdrvpDF1Mjfch0unImunsTOc/LoxSpdGJW1I76E4sfVcOOpmaEFqoP
         80LEhB2iyw9+QpEtTkZG+XjgYuyy3cqE2ZpROeQqSTolSuRG8L+8MuyypvXiqe5V4QPo
         uopw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=SI+l5g9wGTUq3i9Ft6Oc+PNP4QnKTKBpBnZ3lsTnHgU=;
        b=BbGMInaKq2drRzIkXNm5YwKOrWupmgSbmI+QvULTAsOJeFiJeuTpff2FmaQFE9wkir
         fQaB0pZG5VvLu9zKrJV3YQvpJICGMGisqYrzW2Eu28Pn4digFlGXnteCjdQ74RM/HEVw
         smY55TyPpu7dkmIaUNlEws32GNE/XnwnI5iddZwINjOrqhhfQJGztaIERK9kYoAuAtsn
         7HkRWuCz5aJ3C4Y1L6j6IUSuqvsBi8M/o354P+TIqBDIImG4JHHT70BdtHco6I/QVct4
         LrpvodsqPkWsxSJkotyi4vdMVhH0v/LT90ncKJWpNEMDNupA5bGoBd9sZSsreEJ66dTv
         LsvA==
X-Gm-Message-State: AOAM53379XCWhx2TTvfoD/RtqTpRP+2r3/Ji2Djw8GNlNh6ToSmT30fH
        7J0fMQj/2mvr5HanDSj/cIjn7usOjpI=
X-Google-Smtp-Source: ABdhPJyZLi/01WOI/RHuge3cm8tesbvLIBZh9S2kDom1rmOQ7uVrxFK+XRIJpZKzL9Tuni867uFSqA==
X-Received: by 2002:a7b:c45a:: with SMTP id l26mr164963wmi.91.1608056890000;
        Tue, 15 Dec 2020 10:28:10 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p19sm45213178wrg.18.2020.12.15.10.28.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Dec 2020 10:28:09 -0800 (PST)
Message-Id: <d846decf40be829590b88bb61fb19ae6f64c3162.1608056886.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.812.v3.git.1608056886.gitgitgadget@gmail.com>
References: <pull.812.v2.git.1607962900.gitgitgadget@gmail.com>
        <pull.812.v3.git.1608056886.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 15 Dec 2020 18:27:57 +0000
Subject: [PATCH v3 02/11] merge-ort: add initial outline for basic rename
 detection
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 68 ++++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 60 insertions(+), 8 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index 1c1a7fa4bf1..8552f5e2318 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -644,20 +644,72 @@ static int handle_content_merge(struct merge_options *opt,
 
 /*** Function Grouping: functions related to regular rename detection ***/
 
+static int process_renames(struct merge_options *opt,
+			   struct diff_queue_struct *renames)
+{
+	die("Not yet implemented.");
+}
+
+static int compare_pairs(const void *a_, const void *b_)
+{
+	die("Not yet implemented.");
+}
+
+/* Call diffcore_rename() to compute which files have changed on given side */
+static void detect_regular_renames(struct merge_options *opt,
+				   struct tree *merge_base,
+				   struct tree *side,
+				   unsigned side_index)
+{
+	die("Not yet implemented.");
+}
+
+/*
+ * Get information of all renames which occurred in 'side_pairs', discarding
+ * non-renames.
+ */
+static int collect_renames(struct merge_options *opt,
+			   struct diff_queue_struct *result,
+			   unsigned side_index)
+{
+	die("Not yet implemented.");
+}
+
 static int detect_and_process_renames(struct merge_options *opt,
 				      struct tree *merge_base,
 				      struct tree *side1,
 				      struct tree *side2)
 {
-	int clean = 1;
+	struct diff_queue_struct combined;
+	struct rename_info *renames = &opt->priv->renames;
+	int s, clean = 1;
+
+	memset(&combined, 0, sizeof(combined));
+
+	detect_regular_renames(opt, merge_base, side1, MERGE_SIDE1);
+	detect_regular_renames(opt, merge_base, side2, MERGE_SIDE2);
+
+	ALLOC_GROW(combined.queue,
+		   renames->pairs[1].nr + renames->pairs[2].nr,
+		   combined.alloc);
+	clean &= collect_renames(opt, &combined, MERGE_SIDE1);
+	clean &= collect_renames(opt, &combined, MERGE_SIDE2);
+	QSORT(combined.queue, combined.nr, compare_pairs);
+
+	clean &= process_renames(opt, &combined);
+
+	/* Free memory for renames->pairs[] and combined */
+	for (s = MERGE_SIDE1; s <= MERGE_SIDE2; s++) {
+		free(renames->pairs[s].queue);
+		DIFF_QUEUE_CLEAR(&renames->pairs[s]);
+	}
+	if (combined.nr) {
+		int i;
+		for (i = 0; i < combined.nr; i++)
+			diff_free_filepair(combined.queue[i]);
+		free(combined.queue);
+	}
 
-	/*
-	 * Rename detection works by detecting file similarity.  Here we use
-	 * a really easy-to-implement scheme: files are similar IFF they have
-	 * the same filename.  Therefore, by this scheme, there are no renames.
-	 *
-	 * TODO: Actually implement a real rename detection scheme.
-	 */
 	return clean;
 }
 
-- 
gitgitgadget

