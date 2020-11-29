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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EFABC64E7C
	for <git@archiver.kernel.org>; Sun, 29 Nov 2020 07:45:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C2F8207CD
	for <git@archiver.kernel.org>; Sun, 29 Nov 2020 07:45:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P3hhB1UB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727168AbgK2Hp1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 29 Nov 2020 02:45:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726669AbgK2Hp1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Nov 2020 02:45:27 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C33B8C061A55
        for <git@vger.kernel.org>; Sat, 28 Nov 2020 23:43:40 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id v14so6543820wml.1
        for <git@vger.kernel.org>; Sat, 28 Nov 2020 23:43:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=W3Bhf2BLQ8bIe2cDp1LDmVIo03O0xRmiZCI1HPp2dfU=;
        b=P3hhB1UB8xUtGe5hLoEVLeF49Cx/4YL9YzbggjbDOf05huEI3pIHjGNP4xRRJK4tKI
         RuGNh2E+wUH3ob2Fkm0ybzCTZykmabLiM15hvpq8N+yNlSFthQ4/mfpDwjilbYdH+/xX
         E1RzbepdT79VpJ0WydLRTIpZrvpDRLV71TappI/1F0JotDwb3BUtaQQNX6AAGVEyR5ky
         WdIEzKBAzcfrxerpQgtxJ00pnnqUGiMs6Y3hhWunkzRGzx0YXCOOFjhDlWt65STh+IhK
         Vz0dTAG0eOp0kVShqL1U/yT/3cUEirjOA/6nCcnIo79To/lDjHxW47z6yph9ZHHO0mYk
         js8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=W3Bhf2BLQ8bIe2cDp1LDmVIo03O0xRmiZCI1HPp2dfU=;
        b=iXrpnFnKnRQtUaFOWpOBAPXwxGoxJYyvpqeMrJ5cHL5C1471YyIsA5zWYe62cermaA
         bQ8A1fQI8SrJnvVLVQn0ZgWCh07MNONdCJCrQqGuvs2FUelrEmDqI2TtknP7W8QN8nuc
         boH5SDONSxFsQM9BNyeIBueA3WqIkLuByIl3m9aksWb5KBfgZRYhEAxAS4mqrcbYznO8
         ekn7Esonxci4toKpLPs4Ezpr4q88kqC2JZ0gKAB9pQEu/7rCpN0wk64w4f0XOlUso+cl
         gud0TT0dNI1ALOfN8HguRlC1IW/l+/+D4wl6Yz7UwQoOAbBHbfKF1hUF2+PUVxjHV6Qa
         8zMA==
X-Gm-Message-State: AOAM530mm0dWX5Wpy4AekOlC8qK2JHN1R4ml4Oyo3pftmXGFRUaoTUJe
        FpEW+8KxG51CFMSVIePJwMIKlt2XXj8=
X-Google-Smtp-Source: ABdhPJyiB7iiRhW5XLfVJwL2ofbFfDtmZjNOYbfZEf+41dUP3b01dJ2oiQlK4IukwfS9U6yOCUvLqQ==
X-Received: by 2002:a1c:b742:: with SMTP id h63mr16619656wmf.122.1606635819344;
        Sat, 28 Nov 2020 23:43:39 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a1sm23061481wrv.61.2020.11.28.23.43.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Nov 2020 23:43:38 -0800 (PST)
Message-Id: <68307f1b676d0ece1ca8b586ecc7d73a331e6b1a.1606635803.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.923.git.git.1606635803.gitgitgadget@gmail.com>
References: <pull.923.git.git.1606635803.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 29 Nov 2020 07:43:20 +0000
Subject: [PATCH 17/20] merge-ort: add implementation of checkout()
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

Since merge-ort creates a tree for its output, when there are no
conflicts, updating the working tree and index is as simple as using the
unpack_trees() machinery with a twoway_merge (i.e. doing the equivalent
of a "checkout" operation).

If there were conflicts in the merge, then since the tree we created
included all the conflict markers, then using the unpack_trees machinery
in this manner will still update the working tree correctly.  Further,
all index entries corresponding to cleanly merged files will also be
updated correctly by this procedure.  Index entries corresponding to
conflicted entries will appear as though the user had run "git add -u"
after the merge to accept all files as-is with conflict markers.

Thus, after running unpack_trees(), there needs to be a separate step
for updating the entries in the index corresponding to conflicted files.
This will be the job for the function record_conflicted_index_entris(),
which will be implemented in a subsequent commit.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 45 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 44 insertions(+), 1 deletion(-)

diff --git a/merge-ort.c b/merge-ort.c
index 1ef32a4053..69b9fbe591 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -19,9 +19,11 @@
 
 #include "diff.h"
 #include "diffcore.h"
+#include "dir.h"
 #include "object-store.h"
 #include "strmap.h"
 #include "tree.h"
+#include "unpack-trees.h"
 #include "xdiff-interface.h"
 
 struct merge_options_internal {
@@ -937,7 +939,48 @@ static int checkout(struct merge_options *opt,
 		    struct tree *prev,
 		    struct tree *next)
 {
-	die("Not yet implemented.");
+	/* Switch the index/working copy from old to new */
+	int ret;
+	struct tree_desc trees[2];
+	struct unpack_trees_options unpack_opts;
+
+	memset(&unpack_opts, 0, sizeof(unpack_opts));
+	unpack_opts.head_idx = -1;
+	unpack_opts.src_index = opt->repo->index;
+	unpack_opts.dst_index = opt->repo->index;
+
+	setup_unpack_trees_porcelain(&unpack_opts, "merge");
+
+	/*
+	 * NOTE: if this were just "git checkout" code, we would probably
+	 * read or refresh the cache and check for a conflicted index, but
+	 * builtin/merge.c or sequencer.c really needs to read the index
+	 * and check for conflicted entries before starting merging for a
+	 * good user experience (no sense waiting for merges/rebases before
+	 * erroring out), so there's no reason to duplicate that work here.
+	 */
+
+	/* 2-way merge to the new branch */
+	unpack_opts.update = 1;
+	unpack_opts.merge = 1;
+	unpack_opts.quiet = 0; /* FIXME: sequencer might want quiet? */
+	unpack_opts.verbose_update = (opt->verbosity > 2);
+	unpack_opts.fn = twoway_merge;
+	if (1/* FIXME: opts->overwrite_ignore*/) {
+		unpack_opts.dir = xcalloc(1, sizeof(*unpack_opts.dir));
+		unpack_opts.dir->flags |= DIR_SHOW_IGNORED;
+		setup_standard_excludes(unpack_opts.dir);
+	}
+	parse_tree(prev);
+	init_tree_desc(&trees[0], prev->buffer, prev->size);
+	parse_tree(next);
+	init_tree_desc(&trees[1], next->buffer, next->size);
+
+	ret = unpack_trees(2, trees, &unpack_opts);
+	clear_unpack_trees_porcelain(&unpack_opts);
+	dir_clear(unpack_opts.dir);
+	FREE_AND_NULL(unpack_opts.dir);
+	return ret;
 }
 
 static int record_conflicted_index_entries(struct merge_options *opt,
-- 
gitgitgadget

