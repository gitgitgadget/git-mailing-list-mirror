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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90748C4361B
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 20:48:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DFFA22CF6
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 20:48:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727916AbgLDUs5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Dec 2020 15:48:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727517AbgLDUs5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Dec 2020 15:48:57 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92532C061A52
        for <git@vger.kernel.org>; Fri,  4 Dec 2020 12:48:16 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id g14so6543411wrm.13
        for <git@vger.kernel.org>; Fri, 04 Dec 2020 12:48:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=s0PXW8ogrXFRO0LdlzBeU+/0bXqVOha+G8onxIjwhho=;
        b=meN5ca2q6+G5prn42glSifAyQsEmnZsRCjF+XJ8zkhhHylVr7TYAkYtyZD7q+0h15c
         qvDrmVybTFl/uLXmX0LiTwDfrS+GUjH1swDRCEWimT477dwhbHnRs1gTlMqyX9wWTvi3
         9WfH9SSI0dDveyvbvJdC5K8NGoFTpKalqwjm/UZVY3vSWMrbHhgtHLpaSljz3AJj8gFV
         cdzWgc5WokJn3ideHTKYNHioPGC3romqwGyfBLGtGfLDDQaYyNolpIIGWmKQP7yLf0ew
         f1lz+lfo+TGQT4rD3YmO2LkVP8XRE+HRtBkvH0P9CHTra27WcR03lMm/L5Cx6GRMLfkm
         Hqpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=s0PXW8ogrXFRO0LdlzBeU+/0bXqVOha+G8onxIjwhho=;
        b=IolnxFpo67LUylOyQ5JwMKsVtfuXg0nPAhx/av+bnaSEQ3BjzjMLA/mvcH+seBHAcf
         wDtz5xN/MUCiaTASbBnZkYvdgiKR+z67Ch2SoEZ0OO5hadMQNJqndbt1DRwPNOqjeyrt
         Y7Hsksdd6YmTWCgkgWYuIUdZawf6zYiZzRInIeJ9BTAfnrrZ6AJkXKlIx13vDQOKbD7w
         QgObIqefR4w7o5s6Mg/DFHnCeqm599Va2Y+DPK8gg40DcqOMWdcpqrQ/4FW2/Jk7ziuV
         6t5fg9OVD4l9C9QhYROSr681dC9yXMEBlp9mroaP7txBjvHB3XRIaL/PNTZR/N9BB0EM
         TDLg==
X-Gm-Message-State: AOAM532Z0ZuePaqqnKjuz3/YwQo/bFu3SPRkqgGsRh156O9FFQUOIbot
        ZN+t2JNmqdquhVK7FvQqqmtZNxjLdMg=
X-Google-Smtp-Source: ABdhPJxBJhSGyL2rwTUwCArEFIU/QJ9bRZ/j45ScYb8cKQDikR2a7RzRClGkK7+ua0aicII/XkBW5Q==
X-Received: by 2002:adf:ed89:: with SMTP id c9mr5858037wro.4.1607114895134;
        Fri, 04 Dec 2020 12:48:15 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a15sm5183391wrn.75.2020.12.04.12.48.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 12:48:14 -0800 (PST)
Message-Id: <b658536f59d4cca9c660c4bc984fcfb74a219e20.1607114890.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.923.v2.git.git.1607114890.gitgitgadget@gmail.com>
References: <pull.923.git.git.1606635803.gitgitgadget@gmail.com>
        <pull.923.v2.git.git.1607114890.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 04 Dec 2020 20:47:52 +0000
Subject: [PATCH v2 02/20] merge-ort: add some high-level algorithm structure
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
index bb37fdf838..8c9fea1a5a 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -18,6 +18,7 @@
 #include "merge-ort.h"
 
 #include "strmap.h"
+#include "tree.h"
 
 struct merge_options_internal {
 	/*
@@ -154,6 +155,38 @@ struct conflict_info {
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
@@ -170,13 +203,46 @@ void merge_finalize(struct merge_options *opt,
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

