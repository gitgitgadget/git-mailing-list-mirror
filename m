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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E6CAC433FE
	for <git@archiver.kernel.org>; Sun, 13 Dec 2020 08:06:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E05E22D72
	for <git@archiver.kernel.org>; Sun, 13 Dec 2020 08:06:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393962AbgLMIGV (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 13 Dec 2020 03:06:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393156AbgLMIFv (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Dec 2020 03:05:51 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9DCBC0617A6
        for <git@vger.kernel.org>; Sun, 13 Dec 2020 00:04:35 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id q18so5735573wrn.1
        for <git@vger.kernel.org>; Sun, 13 Dec 2020 00:04:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=z7gfcsgza8x3dT0GL9H+Upq6sllDr5cmde6UM++ogtA=;
        b=iMlNL9oP4MocnJu6bvKTlv5I9fcHCPW5gSgfizFY0YFmcDe7VYm45BjK5JBvYnoSPa
         UVPmaEyU553bCpZz5n4rRdr5bsnpY0Jr2UHfPC4hhmRj4S3C4q/RDlTTFDg+vRZJYzDW
         mGurDE5aIXce0jSKdJrlRTvPsWMGJGdjlht3CYXEzTwm7N2wqWFJ3fScQvAL4jZIW2Fm
         /wcy/8mYYl8fJjDmTeFG7vKi32IlUVnSOWJDX6hdSX5HTDDrOnsVwz9AtWyvsCmN6U63
         VZNVJwYx4UKUHkwh6OrbqSEKIwwlJE8ws/ver+tByv2oA8vcXaaAwbUH3h1vWiWgwDZf
         oiWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=z7gfcsgza8x3dT0GL9H+Upq6sllDr5cmde6UM++ogtA=;
        b=KZpx2/9tO8z8d1X1XBaoIq4Zv+l/042ExFQZBZBfQAXBlc+OSDrvycFNV2a5TasD/a
         ZkQUrJuSs3E1XhXWbLJfVr4VAbhftXCZ4bvInEjcImUYSz7DJBVO8nQTWU4HoAY2JCCv
         gkj8mbXuuRGYyuc/4QMIwNehz61cJoybiorVPG55wFWtSWsmjLsftV8rTJYVZr1/D1t7
         4dX44LR46b0tpwAJ18sdfmxWCN2aeXl8YfkyO0zTAJUHjeQ0tkObiEq84AcO4usE/OII
         xGsYXR+YR6J/JtaHZrkWqg59cyKwsBhdGRIZv+OkKf8wHCNEQGFROgaHVI+t9kODgBOd
         A0pg==
X-Gm-Message-State: AOAM531zbGUKz8Yt5P1UImTJuJ7TQm7et2zGy9Y4TRbLswwHXSSntCpG
        w7erdBXLm10ZtfVieXfy6hm48Lyf42c=
X-Google-Smtp-Source: ABdhPJxX+DBaB2cUv2/0mT7se9E8CSIVry+u3R3hPj/gnBs2tpRajHyjz+pzZNvdC8aAf69UUd4i2A==
X-Received: by 2002:adf:eb08:: with SMTP id s8mr22964874wrn.12.1607846674278;
        Sun, 13 Dec 2020 00:04:34 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u85sm23072856wmu.43.2020.12.13.00.04.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Dec 2020 00:04:33 -0800 (PST)
Message-Id: <242f6462ebb10f2cad50260d2301dc800408196b.1607846667.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.923.v3.git.git.1607846667.gitgitgadget@gmail.com>
References: <pull.923.v2.git.git.1607114890.gitgitgadget@gmail.com>
        <pull.923.v3.git.git.1607846667.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 13 Dec 2020 08:04:13 +0000
Subject: [PATCH v3 06/20] merge-ort: implement a very basic
 collect_merge_info()
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

This does not actually collect any necessary info other than the
pathnames involved, since it just allocates an all-zero conflict_info
and stuffs that into paths.  However, it invokes the traverse_trees()
machinery to walk over all the paths and sets up the basic
infrastructure we need.

I have left out a few obvious optimizations to try to make this patch as
short and obvious as possible.  A subsequent patch will add some of
those back in with some more useful data fields before we introduce a
patch that actually sets up the conflict_info fields.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 135 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 134 insertions(+), 1 deletion(-)

diff --git a/merge-ort.c b/merge-ort.c
index 76c0f934279..4a2c7de6e8e 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -23,6 +23,23 @@
 #include "tree.h"
 #include "xdiff-interface.h"
 
+/*
+ * We have many arrays of size 3.  Whenever we have such an array, the
+ * indices refer to one of the sides of the three-way merge.  This is so
+ * pervasive that the constants 0, 1, and 2 are used in many places in the
+ * code (especially in arithmetic operations to find the other side's index
+ * or to compute a relevant mask), but sometimes these enum names are used
+ * to aid code clarity.
+ *
+ * See also 'filemask' and 'dirmask' in struct conflict_info; the "ith side"
+ * referred to there is one of these three sides.
+ */
+enum merge_side {
+	MERGE_BASE = 0,
+	MERGE_SIDE1 = 1,
+	MERGE_SIDE2 = 2
+};
+
 struct merge_options_internal {
 	/*
 	 * paths: primary data structure in all of merge ort.
@@ -184,12 +201,128 @@ static int err(struct merge_options *opt, const char *err, ...)
 	return -1;
 }
 
+static int collect_merge_info_callback(int n,
+				       unsigned long mask,
+				       unsigned long dirmask,
+				       struct name_entry *names,
+				       struct traverse_info *info)
+{
+	/*
+	 * n is 3.  Always.
+	 * common ancestor (mbase) has mask 1, and stored in index 0 of names
+	 * head of side 1  (side1) has mask 2, and stored in index 1 of names
+	 * head of side 2  (side2) has mask 4, and stored in index 2 of names
+	 */
+	struct merge_options *opt = info->data;
+	struct merge_options_internal *opti = opt->priv;
+	struct conflict_info *ci;
+	struct name_entry *p;
+	size_t len;
+	char *fullpath;
+	unsigned filemask = mask & ~dirmask;
+	unsigned mbase_null = !(mask & 1);
+	unsigned side1_null = !(mask & 2);
+	unsigned side2_null = !(mask & 4);
+
+	/* n = 3 is a fundamental assumption. */
+	if (n != 3)
+		BUG("Called collect_merge_info_callback wrong");
+
+	/*
+	 * A bunch of sanity checks verifying that traverse_trees() calls
+	 * us the way I expect.  Could just remove these at some point,
+	 * though maybe they are helpful to future code readers.
+	 */
+	assert(mbase_null == is_null_oid(&names[0].oid));
+	assert(side1_null == is_null_oid(&names[1].oid));
+	assert(side2_null == is_null_oid(&names[2].oid));
+	assert(!mbase_null || !side1_null || !side2_null);
+	assert(mask > 0 && mask < 8);
+
+	/*
+	 * Get the name of the relevant filepath, which we'll pass to
+	 * setup_path_info() for tracking.
+	 */
+	p = names;
+	while (!p->mode)
+		p++;
+	len = traverse_path_len(info, p->pathlen);
+
+	/* +1 in both of the following lines to include the NUL byte */
+	fullpath = xmalloc(len + 1);
+	make_traverse_path(fullpath, len + 1, info, p->path, p->pathlen);
+
+	/*
+	 * TODO: record information about the path other than all zeros,
+	 * so we can resolve later in process_entries.
+	 */
+	ci = xcalloc(1, sizeof(struct conflict_info));
+	strmap_put(&opti->paths, fullpath, ci);
+
+	/* If dirmask, recurse into subdirectories */
+	if (dirmask) {
+		struct traverse_info newinfo;
+		struct tree_desc t[3];
+		void *buf[3] = {NULL, NULL, NULL};
+		const char *original_dir_name;
+		int i, ret;
+
+		ci->match_mask &= filemask;
+		newinfo = *info;
+		newinfo.prev = info;
+		newinfo.name = p->path;
+		newinfo.namelen = p->pathlen;
+		newinfo.pathlen = st_add3(newinfo.pathlen, p->pathlen, 1);
+
+		for (i = MERGE_BASE; i <= MERGE_SIDE2; i++) {
+			const struct object_id *oid = NULL;
+			if (dirmask & 1)
+				oid = &names[i].oid;
+			buf[i] = fill_tree_descriptor(opt->repo, t + i, oid);
+			dirmask >>= 1;
+		}
+
+		original_dir_name = opti->current_dir_name;
+		opti->current_dir_name = fullpath;
+		ret = traverse_trees(NULL, 3, t, &newinfo);
+		opti->current_dir_name = original_dir_name;
+
+		for (i = MERGE_BASE; i <= MERGE_SIDE2; i++)
+			free(buf[i]);
+
+		if (ret < 0)
+			return -1;
+	}
+
+	return mask;
+}
+
 static int collect_merge_info(struct merge_options *opt,
 			      struct tree *merge_base,
 			      struct tree *side1,
 			      struct tree *side2)
 {
-	die("Not yet implemented.");
+	int ret;
+	struct tree_desc t[3];
+	struct traverse_info info;
+	const char *toplevel_dir_placeholder = "";
+
+	opt->priv->current_dir_name = toplevel_dir_placeholder;
+	setup_traverse_info(&info, toplevel_dir_placeholder);
+	info.fn = collect_merge_info_callback;
+	info.data = opt;
+	info.show_all_errors = 1;
+
+	parse_tree(merge_base);
+	parse_tree(side1);
+	parse_tree(side2);
+	init_tree_desc(t + 0, merge_base->buffer, merge_base->size);
+	init_tree_desc(t + 1, side1->buffer, side1->size);
+	init_tree_desc(t + 2, side2->buffer, side2->size);
+
+	ret = traverse_trees(NULL, 3, t, &info);
+
+	return ret;
 }
 
 static int detect_and_process_renames(struct merge_options *opt,
-- 
gitgitgadget

