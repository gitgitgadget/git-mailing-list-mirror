Return-Path: <SRS0=4tT/=EF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17EF5C4363A
	for <git@archiver.kernel.org>; Fri, 30 Oct 2020 03:42:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2AD420796
	for <git@archiver.kernel.org>; Fri, 30 Oct 2020 03:42:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nFfdp9lV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726238AbgJ3Dmg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Oct 2020 23:42:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbgJ3Dme (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Oct 2020 23:42:34 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E4D7C0613D7
        for <git@vger.kernel.org>; Thu, 29 Oct 2020 20:41:49 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id 9so5385004oir.5
        for <git@vger.kernel.org>; Thu, 29 Oct 2020 20:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O+deo6nN5TuwCDIySNiBUkKPdHa3hRownvy8mhficaM=;
        b=nFfdp9lV8hEJTt/YT4rkeiXQrap2OAfeLowLgbyjZ0Ni1bW0E0ME6MWUd5lfHzE5Tc
         +NNW0I4DBmAZOyNghiYGGtpjbdIxLSZqNxe+nvkHO9H6xa0766lcoph/6oROzva7fiBc
         A2EJ9M/tKyrjH1RKR04bmGISxm6P+W7fSZfIzrjS27r244jSyhjXM6rO9GazbhMz7Pcz
         ZR8oBPud6mmTWIGsFQ/aS8heEu4SJYGLQWxZCuBUXjuJVK2WK75zp5QByVLnw0hjqe6X
         dsD8TT8DKGfeKOMRqM1mCfQo/Flthl9cdGWNGddYaWixb02yvXCQJHIvaQjp5mUc3vhC
         UUgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O+deo6nN5TuwCDIySNiBUkKPdHa3hRownvy8mhficaM=;
        b=rGC9SykvE+3VKMjNjpyQRnIh185IeFlhqTbd/MSm71gm+a+p6lXuxO1g1DgViU1nmk
         CrT4yQUTQmjcoXm50Enazc7gVbaCHPtAojiI7oVdTXZJ4Te1oRkzwgoZ1W6ZsVI8Yp0e
         nxy8pXqbTIcmR3acB7qWcduo01c8JTM7Hq92QF//dxn3dBQeO/mGoEZeHD0zThUub9Eh
         ZuPlCvuIpoAeYGz9KeNB8W3p9ao35pj/5efef2yBvFEXE+hi+aIF1DczZ3357JKkNHN3
         fxy+ZjSsR9B9mwjEEuTGn4HJdW3AfNXNpeX1ROYo5HZ7gzc5L2S9+WZlD/TPpkmti3+Y
         069g==
X-Gm-Message-State: AOAM530YzPAhX3Q/EfDHyFHP32VwxkgBUp43l9iDLpDrix47XLBoQ0of
        5fzBV77oN5icwXRLziPeWFAsAsUwo1Iwkg==
X-Google-Smtp-Source: ABdhPJyFVe9XwXt/SlM/CQKdoBTdDkDXFhZta54P8q+pBqZRsCzSXfkWUKhStuhLmiPvo+qZKEOD1g==
X-Received: by 2002:a54:4194:: with SMTP id 20mr271586oiy.137.1604029308779;
        Thu, 29 Oct 2020 20:41:48 -0700 (PDT)
Received: from tiger.attlocal.net ([2602:30a:2c28:20f0:7c1a:85e3:2ea9:5d7e])
        by smtp.gmail.com with ESMTPSA id x13sm1047063otg.66.2020.10.29.20.41.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 20:41:48 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Subject: [PATCH 06/20] merge-ort: implement a very basic collect_merge_info()
Date:   Thu, 29 Oct 2020 20:41:17 -0700
Message-Id: <20201030034131.1479968-7-newren@gmail.com>
X-Mailer: git-send-email 2.29.1.56.ga287c268e6.dirty
In-Reply-To: <20201030034131.1479968-1-newren@gmail.com>
References: <20201030034131.1479968-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

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
 merge-ort.c | 121 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 119 insertions(+), 2 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index ffea7ac8ea..d652f1f062 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -77,13 +77,130 @@ static int err(struct merge_options *opt, const char *err, ...)
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
+	/* Other invariant checks, mostly for documentation purposes. */
+	assert(mask == (dirmask | filemask));
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
+	fullpath = xmalloc(len+1);
+	make_traverse_path(fullpath, len+1, info, p->path, p->pathlen);
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
+		void *buf[3] = {NULL,};
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
+		for (i = 0; i < 3; i++, dirmask >>= 1) {
+			const struct object_id *oid = NULL;
+			if (dirmask & 1)
+				oid = &names[i].oid;
+			buf[i] = fill_tree_descriptor(opt->repo, t + i, oid);
+		}
+
+		original_dir_name = opti->current_dir_name;
+		opti->current_dir_name = fullpath;
+		ret = traverse_trees(NULL, 3, t, &newinfo);
+		opti->current_dir_name = original_dir_name;
+
+		for (i = 0; i < 3; i++)
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
-	/* TODO: Implement this using traverse_trees() */
-	die("Not yet implemented.");
+	int ret;
+	struct tree_desc t[3];
+	struct traverse_info info;
+	char *toplevel_dir_placeholder = "";
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
+	init_tree_desc(t+0, merge_base->buffer, merge_base->size);
+	init_tree_desc(t+1, side1->buffer, side1->size);
+	init_tree_desc(t+2, side2->buffer, side2->size);
+
+	ret = traverse_trees(NULL, 3, t, &info);
+
+	return ret;
 }
 
 static int detect_and_process_renames(struct merge_options *opt,
-- 
2.29.1.56.ga287c268e6.dirty

