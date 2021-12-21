Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B506AC433EF
	for <git@archiver.kernel.org>; Tue, 21 Dec 2021 18:05:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240826AbhLUSF4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Dec 2021 13:05:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234986AbhLUSFx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Dec 2021 13:05:53 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56CFAC061574
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 10:05:53 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id a83-20020a1c9856000000b00344731e044bso11920wme.1
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 10:05:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=JKgkxATVt3nFf9uUVvcrWx0GcG7RL3rPwsw2CdQtvBQ=;
        b=fQ044iFciTjUA+SFAm2W+ZTiqLu3WreaZLtrZTZ9xH5Xereqi205Orr68uJp50G8Yj
         r07OLk8aa9B7pPKbuRW3PZnpwEiHibs+5IK7CHTMkzVVo45pQWlCxrHRikvmlWJ0NitH
         ITZhpyrNx4WxgrxBz5eN09hTG6w7jVRvYSezmQRa1GOi7G36a+joWX9f+AjgMbIjRY4W
         JwRaihULrV9opYK0bpde3s3vejVYpQFzqaiOC3apyeNwklreGCHQQrUlCzhKPBAJ6XQk
         4hu8SL5vs/hf7WalJV7K5VoYmlYussPGX8OOyadSY1Wv9YN/kMSL61//Yc4pNgyJ4Oe5
         nHzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=JKgkxATVt3nFf9uUVvcrWx0GcG7RL3rPwsw2CdQtvBQ=;
        b=ReyLveJvDlQK/gLelIp07f3gSJ9Wx8/gScxqhfGCMYYMQI0yP4TKhKLM5OEnXoCSqJ
         G6+2evlls5g9ROh7EZj8VEqVZp4zaE46zIUUKHMYJY6NdSaP4rO+P44VSCkHrdViKg2V
         P/vXSNcIu7gvOExSIkOg8qqAIipjTtxrj+eFsrpgoLulnlB/uCYtOdIcvq9HWV5nO5fR
         1g1kbqEb+VN8AaKQHt1T2PizqbG+dY/UvuFf/c1EnkQ6UQ5Fpe0490oWdShWZGjHiRGb
         Rg/7C/oGwAjAMtEy2HWMHKoOIfSsTPxJdrnSZn2k9vVU09sWC7tpFHXgS7IoDzb2HUrU
         ghUg==
X-Gm-Message-State: AOAM532In1YPxdW/dSKDBxgHsxDSOVN4Fy0defl5xdS1e7zUgFpX4GKI
        +Iv5vKTYyJpQCOx1fOSBh1PndfQudlA=
X-Google-Smtp-Source: ABdhPJzL/tJTGbVBBZc4Uq5ZOMSRVK5YFkI8fhGO5WpiKCHVLPFmqMYy79TJfY5phw3YnOXGkm46mQ==
X-Received: by 2002:a7b:c017:: with SMTP id c23mr3673047wmb.137.1640109951552;
        Tue, 21 Dec 2021 10:05:51 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b10sm19378262wrg.19.2021.12.21.10.05.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 10:05:51 -0800 (PST)
Message-Id: <d022176618d76943743940da0787291d51c9b4f0.1640109948.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1103.git.1640109948.gitgitgadget@gmail.com>
References: <pull.1103.git.1640109948.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 21 Dec 2021 18:05:41 +0000
Subject: [PATCH 2/9] ll-merge: make callers responsible for showing warnings
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Neeraj Singh <nksingh85@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Since some callers may want to send warning messages to somewhere other
than stdout/stderr, stop printing "warning: Cannot merge binary files"
from ll-merge and instead modify the return status of ll_merge() to
indicate when a merge of binary files has occurred.

Note that my methodology included first modifying ll_merge() to return
a struct, so that the compiler would catch all the callers for me and
ensure I had modified all of them.  After modifying all of them, I then
changed the struct to an enum.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 apply.c            |  5 ++++-
 builtin/checkout.c | 12 ++++++++----
 ll-merge.c         | 40 ++++++++++++++++++++++------------------
 ll-merge.h         |  9 ++++++++-
 merge-blobs.c      |  5 ++++-
 merge-ort.c        |  5 ++++-
 merge-recursive.c  |  5 ++++-
 notes-merge.c      |  5 ++++-
 rerere.c           | 10 +++++++---
 9 files changed, 65 insertions(+), 31 deletions(-)

diff --git a/apply.c b/apply.c
index 43a0aebf4ee..12ea9c72a6b 100644
--- a/apply.c
+++ b/apply.c
@@ -3492,7 +3492,7 @@ static int three_way_merge(struct apply_state *state,
 {
 	mmfile_t base_file, our_file, their_file;
 	mmbuffer_t result = { NULL };
-	int status;
+	enum ll_merge_result status;
 
 	/* resolve trivial cases first */
 	if (oideq(base, ours))
@@ -3509,6 +3509,9 @@ static int three_way_merge(struct apply_state *state,
 			  &their_file, "theirs",
 			  state->repo->index,
 			  NULL);
+	if (status == LL_MERGE_BINARY_CONFLICT)
+		warning("Cannot merge binary files: %s (%s vs. %s)",
+			"base", "ours", "theirs");
 	free(base_file.ptr);
 	free(our_file.ptr);
 	free(their_file.ptr);
diff --git a/builtin/checkout.c b/builtin/checkout.c
index cbf73b8c9f6..3a559d69303 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -237,6 +237,7 @@ static int checkout_merged(int pos, const struct checkout *state,
 	struct cache_entry *ce = active_cache[pos];
 	const char *path = ce->name;
 	mmfile_t ancestor, ours, theirs;
+	enum ll_merge_result merge_status;
 	int status;
 	struct object_id oid;
 	mmbuffer_t result_buf;
@@ -267,13 +268,16 @@ static int checkout_merged(int pos, const struct checkout *state,
 	memset(&ll_opts, 0, sizeof(ll_opts));
 	git_config_get_bool("merge.renormalize", &renormalize);
 	ll_opts.renormalize = renormalize;
-	status = ll_merge(&result_buf, path, &ancestor, "base",
-			  &ours, "ours", &theirs, "theirs",
-			  state->istate, &ll_opts);
+	merge_status = ll_merge(&result_buf, path, &ancestor, "base",
+				&ours, "ours", &theirs, "theirs",
+				state->istate, &ll_opts);
 	free(ancestor.ptr);
 	free(ours.ptr);
 	free(theirs.ptr);
-	if (status < 0 || !result_buf.ptr) {
+	if (merge_status == LL_MERGE_BINARY_CONFLICT)
+		warning("Cannot merge binary files: %s (%s vs. %s)",
+			path, "ours", "theirs");
+	if (merge_status < 0 || !result_buf.ptr) {
 		free(result_buf.ptr);
 		return error(_("path '%s': cannot merge"), path);
 	}
diff --git a/ll-merge.c b/ll-merge.c
index 261657578c7..669c09eed6c 100644
--- a/ll-merge.c
+++ b/ll-merge.c
@@ -14,7 +14,7 @@
 
 struct ll_merge_driver;
 
-typedef int (*ll_merge_fn)(const struct ll_merge_driver *,
+typedef enum ll_merge_result (*ll_merge_fn)(const struct ll_merge_driver *,
 			   mmbuffer_t *result,
 			   const char *path,
 			   mmfile_t *orig, const char *orig_name,
@@ -49,7 +49,7 @@ void reset_merge_attributes(void)
 /*
  * Built-in low-levels
  */
-static int ll_binary_merge(const struct ll_merge_driver *drv_unused,
+static enum ll_merge_result ll_binary_merge(const struct ll_merge_driver *drv_unused,
 			   mmbuffer_t *result,
 			   const char *path,
 			   mmfile_t *orig, const char *orig_name,
@@ -58,6 +58,7 @@ static int ll_binary_merge(const struct ll_merge_driver *drv_unused,
 			   const struct ll_merge_options *opts,
 			   int marker_size)
 {
+	enum ll_merge_result ret;
 	mmfile_t *stolen;
 	assert(opts);
 
@@ -68,16 +69,19 @@ static int ll_binary_merge(const struct ll_merge_driver *drv_unused,
 	 */
 	if (opts->virtual_ancestor) {
 		stolen = orig;
+		ret = LL_MERGE_OK;
 	} else {
 		switch (opts->variant) {
 		default:
-			warning("Cannot merge binary files: %s (%s vs. %s)",
-				path, name1, name2);
-			/* fallthru */
+			ret = LL_MERGE_BINARY_CONFLICT;
+			stolen = src1;
+			break;
 		case XDL_MERGE_FAVOR_OURS:
+			ret = LL_MERGE_OK;
 			stolen = src1;
 			break;
 		case XDL_MERGE_FAVOR_THEIRS:
+			ret = LL_MERGE_OK;
 			stolen = src2;
 			break;
 		}
@@ -87,16 +91,10 @@ static int ll_binary_merge(const struct ll_merge_driver *drv_unused,
 	result->size = stolen->size;
 	stolen->ptr = NULL;
 
-	/*
-	 * With -Xtheirs or -Xours, we have cleanly merged;
-	 * otherwise we got a conflict.
-	 */
-	return opts->variant == XDL_MERGE_FAVOR_OURS ||
-	       opts->variant == XDL_MERGE_FAVOR_THEIRS ?
-	       0 : 1;
+	return ret;
 }
 
-static int ll_xdl_merge(const struct ll_merge_driver *drv_unused,
+static enum ll_merge_result ll_xdl_merge(const struct ll_merge_driver *drv_unused,
 			mmbuffer_t *result,
 			const char *path,
 			mmfile_t *orig, const char *orig_name,
@@ -105,7 +103,9 @@ static int ll_xdl_merge(const struct ll_merge_driver *drv_unused,
 			const struct ll_merge_options *opts,
 			int marker_size)
 {
+	enum ll_merge_result ret;
 	xmparam_t xmp;
+	int status;
 	assert(opts);
 
 	if (orig->size > MAX_XDIFF_SIZE ||
@@ -133,10 +133,12 @@ static int ll_xdl_merge(const struct ll_merge_driver *drv_unused,
 	xmp.ancestor = orig_name;
 	xmp.file1 = name1;
 	xmp.file2 = name2;
-	return xdl_merge(orig, src1, src2, &xmp, result);
+	status = xdl_merge(orig, src1, src2, &xmp, result);
+	ret = (status > 1 ) ? LL_MERGE_CONFLICT : status;
+	return ret;
 }
 
-static int ll_union_merge(const struct ll_merge_driver *drv_unused,
+static enum ll_merge_result ll_union_merge(const struct ll_merge_driver *drv_unused,
 			  mmbuffer_t *result,
 			  const char *path,
 			  mmfile_t *orig, const char *orig_name,
@@ -178,7 +180,7 @@ static void create_temp(mmfile_t *src, char *path, size_t len)
 /*
  * User defined low-level merge driver support.
  */
-static int ll_ext_merge(const struct ll_merge_driver *fn,
+static enum ll_merge_result ll_ext_merge(const struct ll_merge_driver *fn,
 			mmbuffer_t *result,
 			const char *path,
 			mmfile_t *orig, const char *orig_name,
@@ -194,6 +196,7 @@ static int ll_ext_merge(const struct ll_merge_driver *fn,
 	const char *args[] = { NULL, NULL };
 	int status, fd, i;
 	struct stat st;
+	enum ll_merge_result ret;
 	assert(opts);
 
 	sq_quote_buf(&path_sq, path);
@@ -236,7 +239,8 @@ static int ll_ext_merge(const struct ll_merge_driver *fn,
 		unlink_or_warn(temp[i]);
 	strbuf_release(&cmd);
 	strbuf_release(&path_sq);
-	return status;
+	ret = (status > 1) ? LL_MERGE_CONFLICT : status;
+	return ret;
 }
 
 /*
@@ -362,7 +366,7 @@ static void normalize_file(mmfile_t *mm, const char *path, struct index_state *i
 	}
 }
 
-int ll_merge(mmbuffer_t *result_buf,
+enum ll_merge_result ll_merge(mmbuffer_t *result_buf,
 	     const char *path,
 	     mmfile_t *ancestor, const char *ancestor_label,
 	     mmfile_t *ours, const char *our_label,
diff --git a/ll-merge.h b/ll-merge.h
index aceb1b24132..e4a20e81a3a 100644
--- a/ll-merge.h
+++ b/ll-merge.h
@@ -82,13 +82,20 @@ struct ll_merge_options {
 	long xdl_opts;
 };
 
+enum ll_merge_result {
+	LL_MERGE_ERROR = -1,
+	LL_MERGE_OK = 0,
+	LL_MERGE_CONFLICT,
+	LL_MERGE_BINARY_CONFLICT,
+};
+
 /**
  * Perform a three-way single-file merge in core.  This is a thin wrapper
  * around `xdl_merge` that takes the path and any merge backend specified in
  * `.gitattributes` or `.git/info/attributes` into account.
  * Returns 0 for a clean merge.
  */
-int ll_merge(mmbuffer_t *result_buf,
+enum ll_merge_result ll_merge(mmbuffer_t *result_buf,
 	     const char *path,
 	     mmfile_t *ancestor, const char *ancestor_label,
 	     mmfile_t *ours, const char *our_label,
diff --git a/merge-blobs.c b/merge-blobs.c
index ee0a0e90c94..8138090f81c 100644
--- a/merge-blobs.c
+++ b/merge-blobs.c
@@ -36,7 +36,7 @@ static void *three_way_filemerge(struct index_state *istate,
 				 mmfile_t *their,
 				 unsigned long *size)
 {
-	int merge_status;
+	enum ll_merge_result merge_status;
 	mmbuffer_t res;
 
 	/*
@@ -50,6 +50,9 @@ static void *three_way_filemerge(struct index_state *istate,
 				istate, NULL);
 	if (merge_status < 0)
 		return NULL;
+	if (merge_status == LL_MERGE_BINARY_CONFLICT)
+		warning("Cannot merge binary files: %s (%s vs. %s)",
+			path, ".our", ".their");
 
 	*size = res.size;
 	return res.ptr;
diff --git a/merge-ort.c b/merge-ort.c
index 0342f104836..c24da2ba3cb 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -1743,7 +1743,7 @@ static int merge_3way(struct merge_options *opt,
 	mmfile_t orig, src1, src2;
 	struct ll_merge_options ll_opts = {0};
 	char *base, *name1, *name2;
-	int merge_status;
+	enum ll_merge_result merge_status;
 
 	if (!opt->priv->attr_index.initialized)
 		initialize_attr_index(opt);
@@ -1787,6 +1787,9 @@ static int merge_3way(struct merge_options *opt,
 	merge_status = ll_merge(result_buf, path, &orig, base,
 				&src1, name1, &src2, name2,
 				&opt->priv->attr_index, &ll_opts);
+	if (merge_status == LL_MERGE_BINARY_CONFLICT)
+		warning("Cannot merge binary files: %s (%s vs. %s)",
+			path, name1, name2);
 
 	free(base);
 	free(name1);
diff --git a/merge-recursive.c b/merge-recursive.c
index d9457797dbb..bc73c52dd84 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1044,7 +1044,7 @@ static int merge_3way(struct merge_options *opt,
 	mmfile_t orig, src1, src2;
 	struct ll_merge_options ll_opts = {0};
 	char *base, *name1, *name2;
-	int merge_status;
+	enum ll_merge_result merge_status;
 
 	ll_opts.renormalize = opt->renormalize;
 	ll_opts.extra_marker_size = extra_marker_size;
@@ -1090,6 +1090,9 @@ static int merge_3way(struct merge_options *opt,
 	merge_status = ll_merge(result_buf, a->path, &orig, base,
 				&src1, name1, &src2, name2,
 				opt->repo->index, &ll_opts);
+	if (merge_status == LL_MERGE_BINARY_CONFLICT)
+		warning("Cannot merge binary files: %s (%s vs. %s)",
+			a->path, name1, name2);
 
 	free(base);
 	free(name1);
diff --git a/notes-merge.c b/notes-merge.c
index b4a3a903e86..01d596920ea 100644
--- a/notes-merge.c
+++ b/notes-merge.c
@@ -344,7 +344,7 @@ static int ll_merge_in_worktree(struct notes_merge_options *o,
 {
 	mmbuffer_t result_buf;
 	mmfile_t base, local, remote;
-	int status;
+	enum ll_merge_result status;
 
 	read_mmblob(&base, &p->base);
 	read_mmblob(&local, &p->local);
@@ -358,6 +358,9 @@ static int ll_merge_in_worktree(struct notes_merge_options *o,
 	free(local.ptr);
 	free(remote.ptr);
 
+	if (status == LL_MERGE_BINARY_CONFLICT)
+		warning("Cannot merge binary files: %s (%s vs. %s)",
+			oid_to_hex(&p->obj), o->local_ref, o->remote_ref);
 	if ((status < 0) || !result_buf.ptr)
 		die("Failed to execute internal merge");
 
diff --git a/rerere.c b/rerere.c
index d83d58df4fb..46fd01819b8 100644
--- a/rerere.c
+++ b/rerere.c
@@ -609,19 +609,23 @@ static int try_merge(struct index_state *istate,
 		     const struct rerere_id *id, const char *path,
 		     mmfile_t *cur, mmbuffer_t *result)
 {
-	int ret;
+	enum ll_merge_result ret;
 	mmfile_t base = {NULL, 0}, other = {NULL, 0};
 
 	if (read_mmfile(&base, rerere_path(id, "preimage")) ||
 	    read_mmfile(&other, rerere_path(id, "postimage")))
-		ret = 1;
-	else
+		ret = LL_MERGE_CONFLICT;
+	else {
 		/*
 		 * A three-way merge. Note that this honors user-customizable
 		 * low-level merge driver settings.
 		 */
 		ret = ll_merge(result, path, &base, NULL, cur, "", &other, "",
 			       istate, NULL);
+		if (ret == LL_MERGE_BINARY_CONFLICT)
+			warning("Cannot merge binary files: %s (%s vs. %s)",
+				path, "", "");
+	}
 
 	free(base.ptr);
 	free(other.ptr);
-- 
gitgitgadget

