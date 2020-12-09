Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69822C4361B
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 19:42:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 224DD23C92
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 19:42:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387855AbgLITmm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Dec 2020 14:42:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732198AbgLITmM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Dec 2020 14:42:12 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51261C061793
        for <git@vger.kernel.org>; Wed,  9 Dec 2020 11:41:32 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id k14so3053992wrn.1
        for <git@vger.kernel.org>; Wed, 09 Dec 2020 11:41:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=v5ff/3V5zCDHnxLgjmtWFllBH95eypHAvqX8wSVf7ns=;
        b=gitU+ftiZgElpm3v/eXm1v2gnAxDnUcoUIDn9Z9rxeQdT/LDp9+HlOA/9cdlYE53CQ
         yBXGhZAUoPovw4FEFDtJ7jw4VbHNp2sZf8oAGSc7WeFtpM+fp/Ys8/AIX0dXjQttvJX1
         D//u0EOKyzeM3PqKwnkML22PyqcATEqz3pBVD+BvS+uGyf622+vFdmHZt/dBlu3TFPib
         njchf4RPC0X5FQ/SkhsG6rZ9b02CueGh+UvofhJ5Usr8mCNzIohTsp3YLJoK2W6CgyY7
         QjRQj3/BpfHReUuaWmpaNY73Fs+wW4NmKNYkJRrviMwNFcDRQQnL4wJAf0/MgMC5GHEg
         tJgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=v5ff/3V5zCDHnxLgjmtWFllBH95eypHAvqX8wSVf7ns=;
        b=F9FQUIEbaD3a3K8fhX7Dn8hZhtx0KV2BxJ+w/4YxG7iQmavodl9AtYR2SHw5ZEZ1lt
         bAOBRAATWE+1S1K38hkL5sLFIPpmMPpALlh4AE1bsxE+tuYNz7/F41rbUleTBeCSqJuB
         oQ0fY6sM63XoNglMO605Qtmr+ZXq8baaHMVkLZ5lHNbhHw4XLMOwjUlSTZSEn/0LDWiq
         9E2FtOzQ1ioJwOeaJYc++L6icfFA3+rJhtJcWOiveRyys81HxPByq58YudvoR8vEw6Do
         TvzEV/BTPuXT9A/KKvMr0gdzTQx34doIGXIWAbtZbL2wD36m3rOePtJO+9OwVF6zVzm3
         dPCg==
X-Gm-Message-State: AOAM532daW8ZwKdi/Xljxk+sfRQLzyYjUulFgceKvpt9/wTTGsbC7ZSc
        IlXYqgVrC0QJzpvETxktX2kigfxEPbk=
X-Google-Smtp-Source: ABdhPJxHz5JKJlWWjctgn3i/Yzwu/X4q/nTznJxMsoH33ORd19C3p/ivpK/J6r1Ekz8iWpTOQcYIuA==
X-Received: by 2002:adf:8b09:: with SMTP id n9mr4269392wra.180.1607542890864;
        Wed, 09 Dec 2020 11:41:30 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b12sm5559885wmj.2.2020.12.09.11.41.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 11:41:30 -0800 (PST)
Message-Id: <b9e0e1a60b92a6a220193bf9fe80796df91126a7.1607542887.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.812.git.1607542887.gitgitgadget@gmail.com>
References: <pull.812.git.1607542887.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 09 Dec 2020 19:41:18 +0000
Subject: [PATCH 02/11] merge-ort: add initial outline for basic rename
 detection
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 68 ++++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 60 insertions(+), 8 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index 90baedac407..92b765dd3f0 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -617,20 +617,72 @@ static int handle_content_merge(struct merge_options *opt,
 
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
+	struct rename_info *renames = opt->priv->renames;
+	int s, clean = 1;
+
+	memset(&combined, 0, sizeof(combined));
+
+	detect_regular_renames(opt, merge_base, side1, 1);
+	detect_regular_renames(opt, merge_base, side2, 2);
+
+	ALLOC_GROW(combined.queue,
+		   renames->pairs[1].nr + renames->pairs[2].nr,
+		   combined.alloc);
+	clean &= collect_renames(opt, &combined, 1);
+	clean &= collect_renames(opt, &combined, 2);
+	QSORT(combined.queue, combined.nr, compare_pairs);
+
+	clean &= process_renames(opt, &combined);
+
+	/* Free memory for renames->pairs[] and combined */
+	for (s = 1; s <= 2; s++) {
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

