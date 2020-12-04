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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD3A6C4361A
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 20:49:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A9EC22CF6
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 20:49:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730171AbgLDUti (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Dec 2020 15:49:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730128AbgLDUti (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Dec 2020 15:49:38 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED64AC08E860
        for <git@vger.kernel.org>; Fri,  4 Dec 2020 12:48:25 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id g185so8193713wmf.3
        for <git@vger.kernel.org>; Fri, 04 Dec 2020 12:48:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=gZA4vMNHGh9mjCJSJZpRA0igoqQutFqUbTBcYvzvJK8=;
        b=ewFl6dLwuY7nCY9XbyJ+u7N6NFGs5CW6APIMuFjGBzDOTxELbiurEmdeYsgN1dEw6j
         dIXl/cGb73OtGNS3qX2CWosrlt84oV8AKWPjx2tSWbUJyzFiggi9GLZDeLNHXkQI4hbp
         Sra20f734FWEhcizMlwg6sFHtXKb3hr+gKN8UmPo83hV2Fng2OWt4pOqoMNibMBPy2c/
         uM+sGvj0B98ZgD1sTpUkxlMqveqXqMNtvwyJ3KbGnGX2ix6L+sQe/J/Mf0SNu623aDO/
         ZI384H4aQdszStKtz7//BQHQYbUca7+yRjFTpvQKkwPnoZ7CEAm3ZiS8CENiCw7wlHNe
         5Eqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=gZA4vMNHGh9mjCJSJZpRA0igoqQutFqUbTBcYvzvJK8=;
        b=fTgWo6Huca77M6rUmqSO+qfHq5O0GnP12dKiCsnfK2kcLoYbiiyDSHjd7v8+o2bvmy
         vpwhKPesKV707SlrEgyON5fqBo49m5bdnSBJMG9dkKir9DlS+3HfyPjW65iwtE2pDqqN
         KCdJBPRXuGCPYCW5a6zcacdMqwZzQrDD25ZBGCFyDVdVAtY+ll+Nwa09baBCASxCMd2k
         TX4sKk/U4oOC/CPYsfqCGOiIBGpjy/r2yVqEVDfESlK6PoFmsz+0XGhQ35+9JVMatJO/
         mVyeaa3xZiaLK1aUG+SaBO1bGAhlrzma5pCQZ4yNpg15VfNVHlgFlC3yxpWndvIt+sQu
         T0KA==
X-Gm-Message-State: AOAM532BYMP4cOzhF+zpwgO8y4VXCa3TSoycuw03xTcFYnkkIvIKkkC5
        4qlFi2+pr0XwUahMLKf4BnrOgx2YsX8=
X-Google-Smtp-Source: ABdhPJx4OsYRx5GJY+pMDdw4yGM/KDkmM7zOoHNOOjaiZrIIwFlOQSzHUdDotEVqhsuQKi7MvY0rng==
X-Received: by 2002:a1c:80cb:: with SMTP id b194mr6141555wmd.91.1607114904402;
        Fri, 04 Dec 2020 12:48:24 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t136sm4494722wmt.18.2020.12.04.12.48.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 12:48:23 -0800 (PST)
Message-Id: <aa3b13ffd87ec5f947d1d06027f95122d7ded7a1.1607114891.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.923.v2.git.git.1607114890.gitgitgadget@gmail.com>
References: <pull.923.git.git.1606635803.gitgitgadget@gmail.com>
        <pull.923.v2.git.git.1607114890.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 04 Dec 2020 20:48:01 +0000
Subject: [PATCH v2 11/20] merge-ort: add a preliminary simple
 process_entries() implementation
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

Add a process_entries() implementation that just loops over the paths
and processes each one individually with an auxiliary process_entry()
call.  Add a basic process_entry() as well, which handles several cases
but leaves a few of the more involved ones with die-not-implemented
messages.  Also, although process_entries() is supposed to create a
tree, it does not yet have code to do so -- except in the special case
of merging completely empty trees.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 103 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 102 insertions(+), 1 deletion(-)

diff --git a/merge-ort.c b/merge-ort.c
index 2dd52ab426..fbbbde1c3f 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -465,10 +465,111 @@ static int detect_and_process_renames(struct merge_options *opt,
 	return clean;
 }
 
+/* Per entry merge function */
+static void process_entry(struct merge_options *opt,
+			  const char *path,
+			  struct conflict_info *ci)
+{
+	VERIFY_CI(ci);
+	assert(ci->filemask >= 0 && ci->filemask <= 7);
+	/* ci->match_mask == 7 was handled in collect_merge_info_callback() */
+	assert(ci->match_mask == 0 || ci->match_mask == 3 ||
+	       ci->match_mask == 5 || ci->match_mask == 6);
+
+	if (ci->df_conflict) {
+		die("Not yet implemented.");
+	}
+
+	/*
+	 * NOTE: Below there is a long switch-like if-elseif-elseif... block
+	 *       which the code goes through even for the df_conflict cases
+	 *       above.  Well, it will once we don't die-not-implemented above.
+	 */
+	if (ci->match_mask) {
+		ci->merged.clean = 1;
+		if (ci->match_mask == 6) {
+			/* stages[1] == stages[2] */
+			ci->merged.result.mode = ci->stages[1].mode;
+			oidcpy(&ci->merged.result.oid, &ci->stages[1].oid);
+		} else {
+			/* determine the mask of the side that didn't match */
+			unsigned int othermask = 7 & ~ci->match_mask;
+			int side = (othermask == 4) ? 2 : 1;
+
+			ci->merged.result.mode = ci->stages[side].mode;
+			ci->merged.is_null = !ci->merged.result.mode;
+			oidcpy(&ci->merged.result.oid, &ci->stages[side].oid);
+
+			assert(othermask == 2 || othermask == 4);
+			assert(ci->merged.is_null ==
+			       (ci->filemask == ci->match_mask));
+		}
+	} else if (ci->filemask >= 6 &&
+		   (S_IFMT & ci->stages[1].mode) !=
+		   (S_IFMT & ci->stages[2].mode)) {
+		/*
+		 * Two different items from (file/submodule/symlink)
+		 */
+		die("Not yet implemented.");
+	} else if (ci->filemask >= 6) {
+		/*
+		 * TODO: Needs a two-way or three-way content merge, but we're
+		 * just being lazy and copying the version from HEAD and
+		 * leaving it as conflicted.
+		 */
+		ci->merged.clean = 0;
+		ci->merged.result.mode = ci->stages[1].mode;
+		oidcpy(&ci->merged.result.oid, &ci->stages[1].oid);
+	} else if (ci->filemask == 3 || ci->filemask == 5) {
+		/* Modify/delete */
+		die("Not yet implemented.");
+	} else if (ci->filemask == 2 || ci->filemask == 4) {
+		/* Added on one side */
+		int side = (ci->filemask == 4) ? 2 : 1;
+		ci->merged.result.mode = ci->stages[side].mode;
+		oidcpy(&ci->merged.result.oid, &ci->stages[side].oid);
+		ci->merged.clean = !ci->df_conflict;
+	} else if (ci->filemask == 1) {
+		/* Deleted on both sides */
+		ci->merged.is_null = 1;
+		ci->merged.result.mode = 0;
+		oidcpy(&ci->merged.result.oid, &null_oid);
+		ci->merged.clean = 1;
+	}
+
+	/*
+	 * If still conflicted, record it separately.  This allows us to later
+	 * iterate over just conflicted entries when updating the index instead
+	 * of iterating over all entries.
+	 */
+	if (!ci->merged.clean)
+		strmap_put(&opt->priv->conflicted, path, ci);
+}
+
 static void process_entries(struct merge_options *opt,
 			    struct object_id *result_oid)
 {
-	die("Not yet implemented.");
+	struct hashmap_iter iter;
+	struct strmap_entry *e;
+
+	if (strmap_empty(&opt->priv->paths)) {
+		oidcpy(result_oid, opt->repo->hash_algo->empty_tree);
+		return;
+	}
+
+	strmap_for_each_entry(&opt->priv->paths, &iter, e) {
+		/*
+		 * NOTE: mi may actually be a pointer to a conflict_info, but
+		 * we have to check mi->clean first to see if it's safe to
+		 * reassign to such a pointer type.
+		 */
+		struct merged_info *mi = e->value;
+
+		if (!mi->clean)
+			process_entry(opt, e->key, e->value);
+	}
+
+	die("Tree creation not yet implemented");
 }
 
 void merge_switch_to_result(struct merge_options *opt,
-- 
gitgitgadget

