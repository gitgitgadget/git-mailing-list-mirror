Return-Path: <SRS0=4tT/=EF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BE1AC388F9
	for <git@archiver.kernel.org>; Fri, 30 Oct 2020 03:42:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADAD12098B
	for <git@archiver.kernel.org>; Fri, 30 Oct 2020 03:42:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Th4ZU/tT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726261AbgJ3Dmh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Oct 2020 23:42:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbgJ3Dme (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Oct 2020 23:42:34 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E66EFC0613D3
        for <git@vger.kernel.org>; Thu, 29 Oct 2020 20:41:44 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id 32so4474566otm.3
        for <git@vger.kernel.org>; Thu, 29 Oct 2020 20:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tSMS3p7w30guZJLBhcOnk/FlnusbE8UmdUxhNbx8iRs=;
        b=Th4ZU/tTBUSBPv+9GBPZd56cgOBbS7BOM5kI8/yyNrN/0HvqHEX2N602xJym9XAKkE
         6gcrZ2+3wu43KcBy4/3bwGNDYziBGtYDfilChRnjDe1lEDSuCddx1RokRmPgEkn2SWzM
         0GZ/OW0iJBOtBmXWpTiInoIQ2S7QvV6IoI5x2Aq/RUiG6YX7l1+c1ZTh9gwRNIdchEkF
         UOmQJcr04lqxx+nUxrxoFj/BsE+EkcoozC0UPoxt842cSqb4t6m/UTSchSe7jBwq8CF6
         RcrSSVXicaGZieRkEYrKHnqvSS4pkLFaTaT/buxNLCQ7pUyc87RA3jR7FBpSRrMdXYQ7
         x1FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tSMS3p7w30guZJLBhcOnk/FlnusbE8UmdUxhNbx8iRs=;
        b=PY/dCpX2+5uzis68Kh0PWoLI0aI6Ll9R4Jm/1quIIDoHPFP3gdGEBo+jqHzanOpX9F
         e94pwnoAgIgTPvkwJExzmAT1ISWluL5V9UiTT/DCSx0Gp73YkH2/zWaC/8tgnAxe2m6b
         Jk1IhUjAkhpDpb2up+AE6gozdblw1fPzECd4pT7nB+ngoXM04DqtHvrOoYNlFjS7XhvP
         xyJWg37d6w//4DYh6UjLdFYf3OAw2U4evuZxorrDtkFibB7zFZo6hC1odL2xhaFJYuQ6
         5hbhOlrAc+Umrldn7SisMz0vl5IGzxZSYdjZr5BKxYxcVooiqV547Plu/eiTtR4EL8PA
         o9Lw==
X-Gm-Message-State: AOAM530hUN/RFx9lqxb1IKmxxDmp+rlowqabkUon1z98OzEPzIljTGgD
        t3ipBCCkjqGhPoQCKjdwIqWhh8B/6g86qg==
X-Google-Smtp-Source: ABdhPJwCYvqbtvlt3CDBkheTLf+sMRO0CGRF2MgD7GJ7JE98x4iDyr+mwK2yCBwHA4t88f2Vzu2Ynw==
X-Received: by 2002:a9d:3662:: with SMTP id w89mr184437otb.277.1604029304114;
        Thu, 29 Oct 2020 20:41:44 -0700 (PDT)
Received: from tiger.attlocal.net ([2602:30a:2c28:20f0:7c1a:85e3:2ea9:5d7e])
        by smtp.gmail.com with ESMTPSA id x13sm1047063otg.66.2020.10.29.20.41.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 20:41:43 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Subject: [PATCH 02/20] merge-ort: add some high-level algorithm structure
Date:   Thu, 29 Oct 2020 20:41:13 -0700
Message-Id: <20201030034131.1479968-3-newren@gmail.com>
X-Mailer: git-send-email 2.29.1.56.ga287c268e6.dirty
In-Reply-To: <20201030034131.1479968-1-newren@gmail.com>
References: <20201030034131.1479968-1-newren@gmail.com>
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
2.29.1.56.ga287c268e6.dirty

