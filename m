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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C5E5C64E7D
	for <git@archiver.kernel.org>; Sun, 29 Nov 2020 07:44:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCB8C20855
	for <git@archiver.kernel.org>; Sun, 29 Nov 2020 07:44:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LkrcK+8E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726472AbgK2HoI (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 29 Nov 2020 02:44:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbgK2HoI (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Nov 2020 02:44:08 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AC33C0613D3
        for <git@vger.kernel.org>; Sat, 28 Nov 2020 23:43:28 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id u12so10846537wrt.0
        for <git@vger.kernel.org>; Sat, 28 Nov 2020 23:43:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=tIc/yVjj5JkzkP94oZThu+8Obk4wAdjeVxslrCVvI4E=;
        b=LkrcK+8E4LczdveRZv/b0wA4u+67Yr/v5n/6YnujYULCxX46AX/uCC+veVuI3aIA2s
         bvIjQUl9RWgfNJsYX6hCyOqvY/N/np2ZPNSM33Znv18/sedXvrW/a8pnARYi1hErVaLM
         MQve0rylkF2Okh4LRX96NvCRmXriRrXMWGNgbOVu/+584dnjav2pv//wJAcqJHZ0EhoH
         ANUpLUZIXZOfmF/eTyqnQdXbFaDcEoBJFg5bT54kPJgCSmoajtguLEPvLC05e1xJ3D1I
         ST2TzH8ynZdnlex132sFhCyy53G5cwTkJvQ7W5dnmKp7GDjoRdPqzQzAtkuK5hhz0MP7
         /yAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=tIc/yVjj5JkzkP94oZThu+8Obk4wAdjeVxslrCVvI4E=;
        b=Mprvj2NdrLkKLXL/dhQwQCi8KjVJ2NS0m1hcCJN4Og5koFlsuVOJEFMaI0Eep7nNR5
         /OW+kK92ReXl0KpNkI9zQMaE8CFuMMleoHrUHbpUumVE4IHPBB392IAPBkPiGSZfqZ9J
         EaXdzzXE3pb6Nq5QYDtHOtOTB/Geud7khc+OyjevWRKrMfeJx51Wr/H2lyNCl4v4TF59
         DleJ0HtcKLpbWxVetPHtrHyDN17ivy8M07Ioixboh1Ljl5x39evDuNv0M70Mt8BKaDoF
         fWrHZWXXuOHZu5HJJA6MW+hS4ag9SmodJmEqE5Rwsml2stz3P7Y4jV1TVr7BbCLlhe1d
         oPJQ==
X-Gm-Message-State: AOAM533P5J14R1Qen8MG2C1HXoAHqLUWQj6PZoNFtCXGqw2Rj+bnsacZ
        +8D7AtFd0f1lockziHBRwc0N1HKlnKo=
X-Google-Smtp-Source: ABdhPJzgyZqD9KPi0XjiP5EAP/ZJslX1UsG8jKZTYzgZW8WqigSBU+IJJLfCIEtZYv/xxsY47tcPhQ==
X-Received: by 2002:adf:e84e:: with SMTP id d14mr20349540wrn.190.1606635806806;
        Sat, 28 Nov 2020 23:43:26 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d16sm24236451wrw.17.2020.11.28.23.43.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Nov 2020 23:43:26 -0800 (PST)
Message-Id: <3a063865c39f9d1d03acc0cda9023811007d92b5.1606635803.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.923.git.git.1606635803.gitgitgadget@gmail.com>
References: <pull.923.git.git.1606635803.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 29 Nov 2020 07:43:05 +0000
Subject: [PATCH 02/20] merge-ort: add some high-level algorithm structure
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

merge_ort_nonrecursive_internal() will be used by both
merge_inmemory_nonrecursive() and merge_inmemory_recursive(); let's
focus on it for now.  It involves some setup -- merge_start() --
followed by the following chain of functions:

  collect_merge_info()
    This function will populate merge_options_internal's paths field,
    via a call to traverse_trees() and a new callback that will be added
    later.

  detect_and_process_renames()
    This function will detect renames, and then adjust entries in paths
    to move conflict stages from old pathnames into those for new
    pathnames, so that the next step doesn't have to think about renames
    and just can do three-way content merging and such.

  process_entries()
    This function determines how to take the various stages (versions of
    a file from the three different sides) and merge them, and whether
    to mark the result as conflicted or cleanly merged.  It also writes
    out these merged file versions as it goes to create a tree.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 67 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 66 insertions(+), 1 deletion(-)

diff --git a/merge-ort.c b/merge-ort.c
index bb37fdf838..97ef2276bd 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -18,6 +18,7 @@
 #include "merge-ort.h"
 
 #include "strmap.h"
+#include "tree.h"
 
 struct merge_options_internal {
 	/*
@@ -154,6 +155,37 @@ struct conflict_info {
 	unsigned match_mask:3;
 };
 
+static int collect_merge_info(struct merge_options *opt,
+			      struct tree *merge_base,
+			      struct tree *side1,
+			      struct tree *side2)
+{
+	die("Not yet implemented.");
+}
+
+static int detect_and_process_renames(struct merge_options *opt,
+				      struct tree *merge_base,
+				      struct tree *side1,
+				      struct tree *side2)
+{
+	int clean = 1;
+
+	/*
+	 * Rename detection works by detecting file similarity.  Here we use
+	 * a really easy-to-implement scheme: files are similar IFF they have
+	 * the same filename.  Therefore, by this scheme, there are no renames.
+	 *
+	 * TODO: Actually implement a real rename detection scheme.
+	 */
+	return clean;
+}
+
+static void process_entries(struct merge_options *opt,
+			    struct object_id *result_oid)
+{
+	die("Not yet implemented.");
+}
+
 void merge_switch_to_result(struct merge_options *opt,
 			    struct tree *head,
 			    struct merge_result *result,
@@ -170,13 +202,46 @@ void merge_finalize(struct merge_options *opt,
 	die("Not yet implemented");
 }
 
+static void merge_start(struct merge_options *opt, struct merge_result *result)
+{
+	die("Not yet implemented.");
+}
+
+/*
+ * Originally from merge_trees_internal(); heavily adapted, though.
+ */
+static void merge_ort_nonrecursive_internal(struct merge_options *opt,
+					    struct tree *merge_base,
+					    struct tree *side1,
+					    struct tree *side2,
+					    struct merge_result *result)
+{
+	struct object_id working_tree_oid;
+
+	collect_merge_info(opt, merge_base, side1, side2);
+	result->clean = detect_and_process_renames(opt, merge_base,
+						   side1, side2);
+	process_entries(opt, &working_tree_oid);
+
+	/* Set return values */
+	result->tree = parse_tree_indirect(&working_tree_oid);
+	/* existence of conflicted entries implies unclean */
+	result->clean &= strmap_empty(&opt->priv->conflicted);
+	if (!opt->priv->call_depth) {
+		result->priv = opt->priv;
+		opt->priv = NULL;
+	}
+}
+
 void merge_incore_nonrecursive(struct merge_options *opt,
 			       struct tree *merge_base,
 			       struct tree *side1,
 			       struct tree *side2,
 			       struct merge_result *result)
 {
-	die("Not yet implemented");
+	assert(opt->ancestor != NULL);
+	merge_start(opt, result);
+	merge_ort_nonrecursive_internal(opt, merge_base, side1, side2, result);
 }
 
 void merge_incore_recursive(struct merge_options *opt,
-- 
gitgitgadget

