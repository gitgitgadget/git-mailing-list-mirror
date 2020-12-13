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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B72CC4361B
	for <git@archiver.kernel.org>; Sun, 13 Dec 2020 08:05:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9E3C22D73
	for <git@archiver.kernel.org>; Sun, 13 Dec 2020 08:05:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391790AbgLMIFN (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 13 Dec 2020 03:05:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725777AbgLMIFM (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Dec 2020 03:05:12 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24C16C0613D6
        for <git@vger.kernel.org>; Sun, 13 Dec 2020 00:04:32 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id v14so11036342wml.1
        for <git@vger.kernel.org>; Sun, 13 Dec 2020 00:04:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=RNb+86sFrfx/u9J090MtIk+rxf0vfyt/r7AKOVdVyZE=;
        b=mJD+e+JhLH9muZ08J0OZXJFLSIEqjID97Elry5hD8yS6NEPPX5RcZuCFhMTzpY3MlB
         gDrzskFjVnmaSYKbd5iHVeju6UCopmgTU52g61OgNr9H+7c2spbxCxQypQu1rPkOLn1G
         TgBC5aIMJk5bjSA5kacWtlMfWXahwBgvRUHimN17+ehABS1aeFjEJXr1KknQ41ciFfRw
         BYBQHxhq7FTrmHQ6otio3gxOyV+12g7jeai7FTr8McQpElt7lGuGhQrWW+3CgpG4FxBU
         3A45LByJXIeik3+H88EXgdejMJEyrWXM17Esn/VTa0kYRmXcXxk3w4E/LqAWx6MAWgoe
         H+Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=RNb+86sFrfx/u9J090MtIk+rxf0vfyt/r7AKOVdVyZE=;
        b=oImJlJZ/BEoHzxmcKkS2ZGXa0yjLPwVWqmjIhEkBSN/pm9hfTYqW2AgjtMfyJyhafE
         8UnUP6MRmdWWr9o/OXHOnCpqWJO0BzAGscpPFbbKaKoZJ15SePCL967sRYv4fgmHHRVr
         reKtaY4SKuaxqU2dlT+xkOSAqkvi3xl3Zg3Kt09P6FWMl+wbL2vGVes9Xzwb9/CE+d9Q
         urAOddIPYw6BoITvPemYMyaFTLb27B/16cOQjMO2ynEqtTKzo7bpR9hH6BY5MIazmssw
         0Gk2V6fftTGwmVYEQOyBlIXZXc75LO7nLL5HX5KHHY+3hj6n2H7pJ9cM4feMqVUQCJ6K
         Bc6Q==
X-Gm-Message-State: AOAM530Dv4ID8zxn/EOBFWvMUgGkNsR7Xjzi/B+HxSETFVAyZdhOQ0a9
        D/PhI7nCvpEjFLcstzW0k/wabf1nams=
X-Google-Smtp-Source: ABdhPJxDjO7kbd2kM+3gijQ6ru6TIeP+u0i2x4zZ3j3yixTHc+Lcu/X4DQwY3Nv5RYlGIgZ81PGhWA==
X-Received: by 2002:a1c:bc57:: with SMTP id m84mr21761872wmf.163.1607846670749;
        Sun, 13 Dec 2020 00:04:30 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j7sm23571366wmb.40.2020.12.13.00.04.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Dec 2020 00:04:30 -0800 (PST)
Message-Id: <5827ec7f3ebf7f333c15a64aea6d25ce596bf0cf.1607846667.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.923.v3.git.git.1607846667.gitgitgadget@gmail.com>
References: <pull.923.v2.git.git.1607114890.gitgitgadget@gmail.com>
        <pull.923.v3.git.git.1607846667.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 13 Dec 2020 08:04:09 +0000
Subject: [PATCH v3 02/20] merge-ort: add some high-level algorithm structure
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     jonathantanmy@google.com, dstolee@microsoft.com,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
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
 merge-ort.c | 68 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 67 insertions(+), 1 deletion(-)

diff --git a/merge-ort.c b/merge-ort.c
index 3325c9c0a2c..d0abee9b6ab 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -18,6 +18,7 @@
 #include "merge-ort.h"
 
 #include "strmap.h"
+#include "tree.h"
 
 struct merge_options_internal {
 	/*
@@ -164,6 +165,38 @@ struct conflict_info {
 	unsigned match_mask:3;
 };
 
+static int collect_merge_info(struct merge_options *opt,
+			      struct tree *merge_base,
+			      struct tree *side1,
+			      struct tree *side2)
+{
+	/* TODO: Implement this using traverse_trees() */
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
@@ -180,13 +213,46 @@ void merge_finalize(struct merge_options *opt,
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

