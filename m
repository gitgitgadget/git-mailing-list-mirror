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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86EF3C43381
	for <git@archiver.kernel.org>; Fri,  1 Jan 2021 02:35:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61FCC207A3
	for <git@archiver.kernel.org>; Fri,  1 Jan 2021 02:35:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbhAACfg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Dec 2020 21:35:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726583AbhAACfg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Dec 2020 21:35:36 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A47CC061799
        for <git@vger.kernel.org>; Thu, 31 Dec 2020 18:34:55 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id t16so21285639wra.3
        for <git@vger.kernel.org>; Thu, 31 Dec 2020 18:34:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=5nRPYtOpZEu778+nvTAeqzOIXuhD9jlfLfk7n+GwGJM=;
        b=L3EEUF/+PupvuGkVQficpJ6Wh9OA+1AWlpBW50z/A9g/bi6i4yFxBqyh13qHSp3Z7k
         KjYwtWLEiSSoTgDRnbrojWN9RpfWurx7h+XKrQwr4Uj8wI5Qh3jmH71y9lEAjoSi/juW
         nq4t5K2FRxUMJFn8Hnjo8knMajvKbynhafkHwUwaOWndCXIS+0cEMBbuk2dlhthXQCYP
         GzHO8AVpYChsABZiZOdKIXAVTms1bLd0b7gzfjqkD6BpRON9R3/cR1UHNi8N0PsJgmxJ
         TVDaIMnBQoJ7bG0d8Miw9AI5OUJFTO3AvBzdRu/aNJvtBkb/kMV5KB2oRzTAIskKiQ5F
         qANw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=5nRPYtOpZEu778+nvTAeqzOIXuhD9jlfLfk7n+GwGJM=;
        b=Tl8u4JwDQt4wAfLi4TCy09RBYPDK17+Wauq3/z6cmOT/qzFZQPkIoYu0uT1ohlfPXL
         ljr+21uPF7KGPqC42MWtVx3YCOL/F4wnH1tOogP/USBfLSp6cFmlV79uRLe4KOVSafkE
         rag9M//mPKDSAXJ2A1Ul5how1Geb3Di8ON5PpMJgXhFtNN93RMKusDZczg7veSQ1qMrE
         rDLb0MEf7Zlx3RYDVJko+EQib76rraJWXWbhWeuFYYw/YwQ1QD6CTghIad/VmgJqvEfG
         jYSBB94lqAcy/PRuGCVAG5oos8pmYR565OkuufCWSA/42wErQDsLTUFgJ86KT8kvR3tT
         BW1Q==
X-Gm-Message-State: AOAM530MaKv8vkkIu85q1S3ArmfPN13Q2EwxAgB/zWa3qUdgQ63cu1g/
        DYe30XMQomSfzT24cqfUwUhI12vUKgY=
X-Google-Smtp-Source: ABdhPJz3oYWXuKyaj1qOXHvWGVc0wnu2JheHeebrmWvVnwMl/s4GaMDoMtYxW7vQhFHvgiSAuzxUoA==
X-Received: by 2002:a5d:540f:: with SMTP id g15mr67255912wrv.397.1609468493986;
        Thu, 31 Dec 2020 18:34:53 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o7sm73236108wrw.62.2020.12.31.18.34.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Dec 2020 18:34:53 -0800 (PST)
Message-Id: <69129a20edcfb57a3278285f31584ffcc2b3bad7.1609468488.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.815.v2.git.1609468488.gitgitgadget@gmail.com>
References: <pull.815.git.1608270687.gitgitgadget@gmail.com>
        <pull.815.v2.git.1609468488.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 01 Jan 2021 02:34:43 +0000
Subject: [PATCH v2 05/10] merge-ort: flesh out implementation of
 handle_content_merge()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
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

