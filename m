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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC053C4361B
	for <git@archiver.kernel.org>; Fri, 18 Dec 2020 05:52:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C70D23A57
	for <git@archiver.kernel.org>; Fri, 18 Dec 2020 05:52:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732146AbgLRFww (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Dec 2020 00:52:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725290AbgLRFwv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Dec 2020 00:52:51 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AF82C061248
        for <git@vger.kernel.org>; Thu, 17 Dec 2020 21:51:35 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id r3so824044wrt.2
        for <git@vger.kernel.org>; Thu, 17 Dec 2020 21:51:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=5nRPYtOpZEu778+nvTAeqzOIXuhD9jlfLfk7n+GwGJM=;
        b=b3WVzoHoGXcO8tex62ZawtOx0tAiaBodJKk4jRC1dr1xpDxcYiai3BJGIyc/g7zaAy
         usTsy00Bb5/KAmtyRQPDLXll6Hj2y9PByxT3HKlRVUfPRkKWTJRm4bodYhSYiOshx2QG
         naV2nkUiW0amIPHNqS8ORUfLPgakLcKiHr+coplLuHGqk9ZJS2TQSpdwPzX+t3Gqj3qU
         zh8o+tl1mquqqPEI0+PEARgYybqQci/Wao5qwFsQivTg6+oEGCOseRhsHx85SLwx43qJ
         CkaWvWVPPpYQ9G8PI2Oi25UfpB4qozSCkwLC3wfPFNgdiN5MIAxLotNBs2MA0icUO7q8
         AHAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=5nRPYtOpZEu778+nvTAeqzOIXuhD9jlfLfk7n+GwGJM=;
        b=WQCUrVUJOfi8FNGompVAzIraA+zMq4JePWZI0tmDTkmwPeCyI4i94XLW7yEda1vsIU
         jqcv2zJLf38w+M0eH+Ump4gvJ1n8OSsMyXVH3CirMl2GQ/J2p5ZH0fWMFJ8LQNT7grpH
         riIn048WyR7L2IX+IY0jweNnqhXrbDqCGkXEnazjiD4FHoz0mPycaHhYT26i9L16a/zv
         ZYHROx6KlhdYXFjwZdmIrNPRTKZBqG60IZjtEcgO3y2TaxzQlwKqaaW463BKfQNRssmo
         HisQt/IwktdQHUNUJA/e++V2cNmVxIdkxyZa3X5QIB0JRg361WuTtGjYQVMuCLOp82MF
         VGiA==
X-Gm-Message-State: AOAM53102nc4frxxDbcpIzy2MS8cAdW/BM5fd2tEhGppO+VcmN6UYo8B
        1BqX+xcB4PGOYSAoeeZ2G6PVx+oRKlY=
X-Google-Smtp-Source: ABdhPJytog6dhhC+U05IaQRCvqcBWgcBGqeYCiB+6E/2FY6H1aJMrrn6dAaXW2bpkUc2pa1JWoU7Jw==
X-Received: by 2002:adf:f344:: with SMTP id e4mr2370161wrp.25.1608270693372;
        Thu, 17 Dec 2020 21:51:33 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m18sm12060604wrw.43.2020.12.17.21.51.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Dec 2020 21:51:32 -0800 (PST)
Message-Id: <0e7321e67f83c197e84ad7b281ab2ce79c90b784.1608270687.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.815.git.1608270687.gitgitgadget@gmail.com>
References: <pull.815.git.1608270687.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 18 Dec 2020 05:51:22 +0000
Subject: [PATCH 05/10] merge-ort: flesh out implementation of
 handle_content_merge()
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

This implementation is based heavily on merge_mode_and_contents() from
merge-recursive.c, though it has some fixes for recursive merges (i.e.
when call_depth > 0), and has a number of changes throughout based on
slight differences in data structures and in how the functions are
called.

It is, however, based on two new helper functions -- merge_3way() and
merge_submodule -- for which we only provide die-not-implemented stubs
at this point.  Future commits will add implementations of these
functions.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 149 +++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 143 insertions(+), 6 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index 47e230fe341..2cfb7ffa3b0 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -631,6 +631,28 @@ static int collect_merge_info(struct merge_options *opt,
 
 /*** Function Grouping: functions related to threeway content merges ***/
 
+static int merge_submodule(struct merge_options *opt,
+			   const char *path,
+			   const struct object_id *o,
+			   const struct object_id *a,
+			   const struct object_id *b,
+			   struct object_id *result)
+{
+	die("Not yet implemented.");
+}
+
+static int merge_3way(struct merge_options *opt,
+		      const char *path,
+		      const struct object_id *o,
+		      const struct object_id *a,
+		      const struct object_id *b,
+		      const char *pathnames[3],
+		      const int extra_marker_size,
+		      mmbuffer_t *result_buf)
+{
+	die("Not yet implemented.");
+}
+
 static int handle_content_merge(struct merge_options *opt,
 				const char *path,
 				const struct version_info *o,
@@ -640,14 +662,129 @@ static int handle_content_merge(struct merge_options *opt,
 				const int extra_marker_size,
 				struct version_info *result)
 {
-	int clean = 0;
 	/*
-	 * TODO: Needs a two-way or three-way content merge, but we're
-	 * just being lazy and copying the version from HEAD and
-	 * leaving it as conflicted.
+	 * path is the target location where we want to put the file, and
+	 * is used to determine any normalization rules in ll_merge.
+	 *
+	 * The normal case is that path and all entries in pathnames are
+	 * identical, though renames can affect which path we got one of
+	 * the three blobs to merge on various sides of history.
+	 *
+	 * extra_marker_size is the amount to extend conflict markers in
+	 * ll_merge; this is neeed if we have content merges of content
+	 * merges, which happens for example with rename/rename(2to1) and
+	 * rename/add conflicts.
 	 */
-	result->mode = a->mode;
-	oidcpy(&result->oid, &a->oid);
+	unsigned clean = 1;
+
+	/*
+	 * handle_content_merge() needs both files to be of the same type, i.e.
+	 * both files OR both submodules OR both symlinks.  Conflicting types
+	 * needs to be handled elsewhere.
+	 */
+	assert((S_IFMT & a->mode) == (S_IFMT & b->mode));
+
+	/* Merge modes */
+	if (a->mode == b->mode || a->mode == o->mode)
+		result->mode = b->mode;
+	else {
+		/* must be the 100644/100755 case */
+		assert(S_ISREG(a->mode));
+		result->mode = a->mode;
+		clean = (b->mode == o->mode);
+		/*
+		 * FIXME: If opt->priv->call_depth && !clean, then we really
+		 * should not make result->mode match either a->mode or
+		 * b->mode; that causes t6036 "check conflicting mode for
+		 * regular file" to fail.  It would be best to use some other
+		 * mode, but we'll confuse all kinds of stuff if we use one
+		 * where S_ISREG(result->mode) isn't true, and if we use
+		 * something like 0100666, then tree-walk.c's calls to
+		 * canon_mode() will just normalize that to 100644 for us and
+		 * thus not solve anything.
+		 *
+		 * Figure out if there's some kind of way we can work around
+		 * this...
+		 */
+	}
+
+	/*
+	 * Trivial oid merge.
+	 *
+	 * Note: While one might assume that the next four lines would
+	 * be unnecessary due to the fact that match_mask is often
+	 * setup and already handled, renames don't always take care
+	 * of that.
+	 */
+	if (oideq(&a->oid, &b->oid) || oideq(&a->oid, &o->oid))
+		oidcpy(&result->oid, &b->oid);
+	else if (oideq(&b->oid, &o->oid))
+		oidcpy(&result->oid, &a->oid);
+
+	/* Remaining rules depend on file vs. submodule vs. symlink. */
+	else if (S_ISREG(a->mode)) {
+		mmbuffer_t result_buf;
+		int ret = 0, merge_status;
+		int two_way;
+
+		/*
+		 * If 'o' is different type, treat it as null so we do a
+		 * two-way merge.
+		 */
+		two_way = ((S_IFMT & o->mode) != (S_IFMT & a->mode));
+
+		merge_status = merge_3way(opt, path,
+					  two_way ? &null_oid : &o->oid,
+					  &a->oid, &b->oid,
+					  pathnames, extra_marker_size,
+					  &result_buf);
+
+		if ((merge_status < 0) || !result_buf.ptr)
+			ret = err(opt, _("Failed to execute internal merge"));
+
+		if (!ret &&
+		    write_object_file(result_buf.ptr, result_buf.size,
+				      blob_type, &result->oid))
+			ret = err(opt, _("Unable to add %s to database"),
+				  path);
+
+		free(result_buf.ptr);
+		if (ret)
+			return -1;
+		clean &= (merge_status == 0);
+		path_msg(opt, path, 1, _("Auto-merging %s"), path);
+	} else if (S_ISGITLINK(a->mode)) {
+		int two_way = ((S_IFMT & o->mode) != (S_IFMT & a->mode));
+		clean = merge_submodule(opt, pathnames[0],
+					two_way ? &null_oid : &o->oid,
+					&a->oid, &b->oid, &result->oid);
+		if (opt->priv->call_depth && two_way && !clean) {
+			result->mode = o->mode;
+			oidcpy(&result->oid, &o->oid);
+		}
+	} else if (S_ISLNK(a->mode)) {
+		if (opt->priv->call_depth) {
+			clean = 0;
+			result->mode = o->mode;
+			oidcpy(&result->oid, &o->oid);
+		} else {
+			switch (opt->recursive_variant) {
+			case MERGE_VARIANT_NORMAL:
+				clean = 0;
+				oidcpy(&result->oid, &a->oid);
+				break;
+			case MERGE_VARIANT_OURS:
+				oidcpy(&result->oid, &a->oid);
+				break;
+			case MERGE_VARIANT_THEIRS:
+				oidcpy(&result->oid, &b->oid);
+				break;
+			}
+		}
+	} else
+		BUG("unsupported object type in the tree: %06o for %s",
+		    a->mode, path);
+
 	return clean;
 }
 
-- 
gitgitgadget

