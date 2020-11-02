Return-Path: <SRS0=DNVg=EI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EFA6C2D0A3
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 20:46:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB031206E5
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 20:46:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pyzTSyqf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727301AbgKBUod (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Nov 2020 15:44:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726878AbgKBUnw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Nov 2020 15:43:52 -0500
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91FC1C0617A6
        for <git@vger.kernel.org>; Mon,  2 Nov 2020 12:43:52 -0800 (PST)
Received: by mail-ot1-x341.google.com with SMTP id y22so3416772oti.10
        for <git@vger.kernel.org>; Mon, 02 Nov 2020 12:43:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=T+XG60ElO52BdiW2lH9zi9v/2gK1c0M/S/IJh6MzwkQ=;
        b=pyzTSyqfA4y4WnxqA4N4lUkj4Uh85XqOM5BJkpjUbo213T+Slq0G1vR5jvxIINTox1
         zjzWFhnij4eCg6n96sGcAuZ71Si0twANTLgnDpHHIu755lveC58FSKIjcnNVfAKoPMEw
         YuGZN7kCSnUu3ZoRAsQ2HwGvauWrMm3VCrW/ChESSW8hq3Jtownh7k82IaG20ZV4V45v
         bN4ue994Jd7IS2mf/Ob0xMUFJY+XrzJbPQStqmfcf/9ev2Ih0rUmMJ3G1kIXmcQVKdAi
         n1JXTfc4Do/JqSJUHbGupMfuTOw/qD7bnmVYeqwtmqYFLrmIjOLHrZtdHSuC7v71/gWp
         FpBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T+XG60ElO52BdiW2lH9zi9v/2gK1c0M/S/IJh6MzwkQ=;
        b=VMe9H3L+kiJOYAh8rIvXpQJJgUFNPaHUAqkF6W1SGOKqFWesx8Q34GXK/qn7x3aI6y
         00v84NJcjd1Pq/EwmnUdeRc0Rd+d568u+LromClxJO6gNEz1mcbBFgF7r35G0oQvfhH7
         3LhgcsvJdyc8AI4vnf8lj0PmRxfWx8fYOD6E2D6V5gC4Im1F2GQy+QdZFBq4gbrl3qnD
         g7VkFt+wSz0bm7j/UeFX/YIY0TAuOt0q5IBLZPPOiWbBM1L6sDqs1YQLsohXu9k4JZY9
         AojImlBA0ZMTbPftmx2m8iCPHUHk0uyf/ubmX19JlB8/U9SGoUU5fY3HRQzimL1xGu6T
         sfnw==
X-Gm-Message-State: AOAM530OwM52qykpeIAtxgpiegDxJFwqFn6i41tZWyk69LaHOWB2Ii9L
        alqhFMXeihsE3PIub6eoaureBozM/sykBg==
X-Google-Smtp-Source: ABdhPJxmvORgzYkvjhGWh2J4hty0vQScpF0lHO1nPrb8wj2DVypvIDdnMpgDo/kS3zfVn0UvtvEr4w==
X-Received: by 2002:a05:6830:18e6:: with SMTP id d6mr13051547otf.60.1604349831779;
        Mon, 02 Nov 2020 12:43:51 -0800 (PST)
Received: from tiger.attlocal.net ([2602:30a:2c28:20f0:7c1a:85e3:2ea9:5d7e])
        by smtp.gmail.com with ESMTPSA id t27sm3848512otc.14.2020.11.02.12.43.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 12:43:51 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Subject: [PATCH v2 02/20] merge-ort: add some high-level algorithm structure
Date:   Mon,  2 Nov 2020 12:43:26 -0800
Message-Id: <20201102204344.342633-3-newren@gmail.com>
X-Mailer: git-send-email 2.29.0.471.ga4f56089c0
In-Reply-To: <20201102204344.342633-1-newren@gmail.com>
References: <20201102204344.342633-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

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
index 9d5ea0930d..b53cd80104 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -18,6 +18,7 @@
 #include "merge-ort.h"
 
 #include "strmap.h"
+#include "tree.h"
 
 struct merge_options_internal {
 	struct strmap paths;    /* maps path -> (merged|conflict)_info */
@@ -57,6 +58,37 @@ struct conflict_info {
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
@@ -73,13 +105,46 @@ void merge_finalize(struct merge_options *opt,
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
+	/* existence of unmerged entries implies unclean */
+	result->clean &= strmap_empty(&opt->priv->unmerged);
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
2.29.0.471.ga4f56089c0

