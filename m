Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AD60C4332F
	for <git@archiver.kernel.org>; Tue, 28 Dec 2021 10:56:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236323AbhL1K4U (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Dec 2021 05:56:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236312AbhL1K4T (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Dec 2021 05:56:19 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4820C061574
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 02:56:18 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id c66so11327384wma.5
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 02:56:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SlWpA+Iin3ejQN4rsiUAWRIbjYlPUA03kSg3UtTIgDI=;
        b=jjySQ6eSpa3kPYvte3p9WjUL5ItHeXvWu4HRSKLY9ErNQD02ucpPkm0U0Ma5Viea2f
         G/w2s2agC5FtqrsJUCQarwZIx2nOvOVsZ3rzO+O3rowYw5MoN+teNK/E15y8W89ivBQ6
         UIPHokQNAv6R1jINLwU2ycklLw/do9vgAdOyGfwZQLDySf3OURKKeWOobVDB0M/ovYYo
         9ctDwmcNckPu8BRh3fBtspb1YKdD89wqmL5eqcGb51hEEaR3ZhfifT/OIuQVJiXZ3VPU
         rJ7cxR4WJpg5AwvzE9v+lqCmVWs7dtsN9leWb6x3TcxnzV1jSMWyr4oU1W+vLuesU/xK
         vmWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SlWpA+Iin3ejQN4rsiUAWRIbjYlPUA03kSg3UtTIgDI=;
        b=FVMLsIymqhQzUNPIEV9I1fb9tFGWu+xPgrbnwYKJfm6Sp+1ZSg03JoILh5dVhYqWnX
         ieIVyFNIkAWsJrE2rO0u1LhXld6jAoGN9+TCEmhhYfyWDomUvvtSuPTIkZ3JDui+3vAh
         f1yef1x9Cqa+Ix5QEdqgB5NustfPxgpytUWpuaUUmlAz0d0jzsATkZ2cei9JL6/LH5Bx
         H3EI+U8qPvaXBhixeuQcDsZYZ0GSB6/NUlc4hB9zOh7v0UVKc4koYjBf+BtBII4HRZqV
         8zGKQ670VkRUKXkOhVCVEoKNHwkzD992jmmFS0TilObHa2ixlQeA6GidrGcmFIpi3T+4
         u5Dg==
X-Gm-Message-State: AOAM530QyXRWdeW0zGkj2cuXXbN9c5yAojQH/wgGEVVoUkbawaBwtlJK
        aPJlIFrEXm89l2am/GvIUtYB7koA6fJCgQ==
X-Google-Smtp-Source: ABdhPJxOIetTGALGA/qBLU1YfheW+WJNkyTkqFPM28Cee4BQJsxmk31cM2f4SKaAxPCJm1A644ciww==
X-Received: by 2002:a05:600c:4f13:: with SMTP id l19mr16914951wmq.152.1640688977264;
        Tue, 28 Dec 2021 02:56:17 -0800 (PST)
Received: from gmail.com (62-47-14-33.adsl.highway.telekom.at. [62.47.14.33])
        by smtp.gmail.com with ESMTPSA id m35sm42057017wms.1.2021.12.28.02.56.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Dec 2021 02:56:16 -0800 (PST)
Date:   Tue, 28 Dec 2021 11:56:14 +0100
From:   Johannes Altmanninger <aclopte@gmail.com>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Neeraj Singh <nksingh85@gmail.com>
Subject: Re: [PATCH v2 3/8] ll-merge: make callers responsible for showing
 warnings
Message-ID: <20211228105614.qzmm3hglabtlcsx4@gmail.com>
References: <pull.1103.git.1640109948.gitgitgadget@gmail.com>
 <pull.1103.v2.git.1640419159.gitgitgadget@gmail.com>
 <d5566f5d13605f30be6fd221fc624479cbbd0392.1640419159.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d5566f5d13605f30be6fd221fc624479cbbd0392.1640419159.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Dec 25, 2021 at 07:59:14AM +0000, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
> 
> Since some callers may want to send warning messages to somewhere other
> than stdout/stderr, stop printing "warning: Cannot merge binary files"
> from ll-merge and instead modify the return status of ll_merge() to
> indicate when a merge of binary files has occurred.
> 
> This commit continues printing the message as-is; future changes will
> start handling the new commit differently in the merge-ort codepath.

"the new commit" looks like a typo, do you mean "binary conflicts"?

> 
> Note that my methodology included first modifying ll_merge() to return
> a struct, so that the compiler would catch all the callers for me and
> ensure I had modified all of them.  After modifying all of them, I then
> changed the struct to an enum.

Heh, this is a clever way to work around C's weak typing.

The language server I'm using (clangd) supports the Call Hierarchy feature,
which is intended to list callers or callees of the function at the editor's
cursor. If I ask the server for callers of ll_merge I get this response
(on 510f9eba9 plus this series)

	ll-merge.h:98:1: ll_merge - list of callers
	  builtin/checkout.c:242:12: checkout_merged
	    builtin/checkout.c:279:17: 	merge_status = ll_merge(&result_buf, path, &ancestor, "base",
	  rerere.c:943:12: handle_cache
	    rerere.c:984:2: 	ll_merge(&result, path, &mmfile[0], NULL,
	  notes-merge.c:342:12: ll_merge_in_worktree
	    notes-merge.c:353:11: 	status = ll_merge(&result_buf, oid_to_hex(&p->obj), &base, NULL,
	  merge-recursive.c:1035:12: merge_3way
	    merge-recursive.c:1090:17: 	merge_status = ll_merge(result_buf, a->path, &orig, base,
	  merge-ort.c:1763:12: merge_3way
	    merge-ort.c:1816:17: 	merge_status = ll_merge(result_buf, path, &orig, base,
	  merge-blobs.c:32:14: three_way_filemerge
	    merge-blobs.c:48:17: 	merge_status = ll_merge(&res, path, base, NULL,
	  apply.c:3491:12: three_way_merge
	    apply.c:3511:11: 	status = ll_merge(&result, path,
	  rerere.c:608:12: try_merge
	    rerere.c:623:9: 		ret = ll_merge(result, path, &base, NULL, cur, "", &other, "",

So there are 8 callers in total; but only 7 print the warning (including the
one in merge-ort which will change in the next commit). I think you missed
the call at rerere.c:984 because we ignore its return value.

> 
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  apply.c            |  5 ++++-
>  builtin/checkout.c | 12 ++++++++----
>  ll-merge.c         | 40 ++++++++++++++++++++++------------------
>  ll-merge.h         |  9 ++++++++-
>  merge-blobs.c      |  5 ++++-
>  merge-ort.c        |  5 ++++-
>  merge-recursive.c  |  5 ++++-
>  notes-merge.c      |  5 ++++-
>  rerere.c           | 12 ++++++++----
>  9 files changed, 66 insertions(+), 32 deletions(-)
> 
> diff --git a/apply.c b/apply.c
> index 43a0aebf4ee..8079395755f 100644
> --- a/apply.c
> +++ b/apply.c
> @@ -3492,7 +3492,7 @@ static int three_way_merge(struct apply_state *state,
>  {
>  	mmfile_t base_file, our_file, their_file;
>  	mmbuffer_t result = { NULL };
> -	int status;
> +	enum ll_merge_result status;
>  
>  	/* resolve trivial cases first */
>  	if (oideq(base, ours))
> @@ -3509,6 +3509,9 @@ static int three_way_merge(struct apply_state *state,
>  			  &their_file, "theirs",
>  			  state->repo->index,
>  			  NULL);
> +	if (status == LL_MERGE_BINARY_CONFLICT)
> +		warning("Cannot merge binary files: %s (%s vs. %s)",
> +			path, "ours", "theirs");
>  	free(base_file.ptr);
>  	free(our_file.ptr);
>  	free(their_file.ptr);
> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index cbf73b8c9f6..3a559d69303 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -237,6 +237,7 @@ static int checkout_merged(int pos, const struct checkout *state,
>  	struct cache_entry *ce = active_cache[pos];
>  	const char *path = ce->name;
>  	mmfile_t ancestor, ours, theirs;
> +	enum ll_merge_result merge_status;
>  	int status;
>  	struct object_id oid;
>  	mmbuffer_t result_buf;
> @@ -267,13 +268,16 @@ static int checkout_merged(int pos, const struct checkout *state,
>  	memset(&ll_opts, 0, sizeof(ll_opts));
>  	git_config_get_bool("merge.renormalize", &renormalize);
>  	ll_opts.renormalize = renormalize;
> -	status = ll_merge(&result_buf, path, &ancestor, "base",
> -			  &ours, "ours", &theirs, "theirs",
> -			  state->istate, &ll_opts);
> +	merge_status = ll_merge(&result_buf, path, &ancestor, "base",
> +				&ours, "ours", &theirs, "theirs",
> +				state->istate, &ll_opts);
>  	free(ancestor.ptr);
>  	free(ours.ptr);
>  	free(theirs.ptr);
> -	if (status < 0 || !result_buf.ptr) {
> +	if (merge_status == LL_MERGE_BINARY_CONFLICT)
> +		warning("Cannot merge binary files: %s (%s vs. %s)",
> +			path, "ours", "theirs");
> +	if (merge_status < 0 || !result_buf.ptr) {
>  		free(result_buf.ptr);
>  		return error(_("path '%s': cannot merge"), path);
>  	}
> diff --git a/ll-merge.c b/ll-merge.c
> index 261657578c7..669c09eed6c 100644
> --- a/ll-merge.c
> +++ b/ll-merge.c
> @@ -14,7 +14,7 @@
>  
>  struct ll_merge_driver;
>  
> -typedef int (*ll_merge_fn)(const struct ll_merge_driver *,
> +typedef enum ll_merge_result (*ll_merge_fn)(const struct ll_merge_driver *,
>  			   mmbuffer_t *result,
>  			   const char *path,
>  			   mmfile_t *orig, const char *orig_name,
> @@ -49,7 +49,7 @@ void reset_merge_attributes(void)
>  /*
>   * Built-in low-levels
>   */
> -static int ll_binary_merge(const struct ll_merge_driver *drv_unused,
> +static enum ll_merge_result ll_binary_merge(const struct ll_merge_driver *drv_unused,
>  			   mmbuffer_t *result,
>  			   const char *path,
>  			   mmfile_t *orig, const char *orig_name,
> @@ -58,6 +58,7 @@ static int ll_binary_merge(const struct ll_merge_driver *drv_unused,
>  			   const struct ll_merge_options *opts,
>  			   int marker_size)
>  {
> +	enum ll_merge_result ret;
>  	mmfile_t *stolen;
>  	assert(opts);
>  
> @@ -68,16 +69,19 @@ static int ll_binary_merge(const struct ll_merge_driver *drv_unused,
>  	 */
>  	if (opts->virtual_ancestor) {
>  		stolen = orig;
> +		ret = LL_MERGE_OK;
>  	} else {
>  		switch (opts->variant) {
>  		default:
> -			warning("Cannot merge binary files: %s (%s vs. %s)",
> -				path, name1, name2);
> -			/* fallthru */
> +			ret = LL_MERGE_BINARY_CONFLICT;
> +			stolen = src1;
> +			break;
>  		case XDL_MERGE_FAVOR_OURS:
> +			ret = LL_MERGE_OK;
>  			stolen = src1;
>  			break;
>  		case XDL_MERGE_FAVOR_THEIRS:
> +			ret = LL_MERGE_OK;
>  			stolen = src2;
>  			break;
>  		}
> @@ -87,16 +91,10 @@ static int ll_binary_merge(const struct ll_merge_driver *drv_unused,
>  	result->size = stolen->size;
>  	stolen->ptr = NULL;
>  
> -	/*
> -	 * With -Xtheirs or -Xours, we have cleanly merged;
> -	 * otherwise we got a conflict.
> -	 */
> -	return opts->variant == XDL_MERGE_FAVOR_OURS ||
> -	       opts->variant == XDL_MERGE_FAVOR_THEIRS ?
> -	       0 : 1;
> +	return ret;
>  }
>  
> -static int ll_xdl_merge(const struct ll_merge_driver *drv_unused,
> +static enum ll_merge_result ll_xdl_merge(const struct ll_merge_driver *drv_unused,
>  			mmbuffer_t *result,
>  			const char *path,
>  			mmfile_t *orig, const char *orig_name,
> @@ -105,7 +103,9 @@ static int ll_xdl_merge(const struct ll_merge_driver *drv_unused,
>  			const struct ll_merge_options *opts,
>  			int marker_size)
>  {
> +	enum ll_merge_result ret;
>  	xmparam_t xmp;
> +	int status;
>  	assert(opts);
>  
>  	if (orig->size > MAX_XDIFF_SIZE ||
> @@ -133,10 +133,12 @@ static int ll_xdl_merge(const struct ll_merge_driver *drv_unused,
>  	xmp.ancestor = orig_name;
>  	xmp.file1 = name1;
>  	xmp.file2 = name2;
> -	return xdl_merge(orig, src1, src2, &xmp, result);
> +	status = xdl_merge(orig, src1, src2, &xmp, result);
> +	ret = (status > 1 ) ? LL_MERGE_CONFLICT : status;

" (status > 1 )" has an extra space

I'm not sure it's wise to handle status=1 and status=2 in two different code paths.
Both mean the same (the only difference is the number of conflicts).
status=1 coincides with LL_MERGE_CONFLICT but that's purely coincidental

	ret = (status > 0) ? LL_MERGE_CONFLICT : status;

> +	return ret;
>  }
>  
> -static int ll_union_merge(const struct ll_merge_driver *drv_unused,
> +static enum ll_merge_result ll_union_merge(const struct ll_merge_driver *drv_unused,
>  			  mmbuffer_t *result,
>  			  const char *path,
>  			  mmfile_t *orig, const char *orig_name,
> @@ -178,7 +180,7 @@ static void create_temp(mmfile_t *src, char *path, size_t len)
>  /*
>   * User defined low-level merge driver support.
>   */
> -static int ll_ext_merge(const struct ll_merge_driver *fn,
> +static enum ll_merge_result ll_ext_merge(const struct ll_merge_driver *fn,
>  			mmbuffer_t *result,
>  			const char *path,
>  			mmfile_t *orig, const char *orig_name,
> @@ -194,6 +196,7 @@ static int ll_ext_merge(const struct ll_merge_driver *fn,
>  	const char *args[] = { NULL, NULL };
>  	int status, fd, i;
>  	struct stat st;
> +	enum ll_merge_result ret;
>  	assert(opts);
>  
>  	sq_quote_buf(&path_sq, path);
> @@ -236,7 +239,8 @@ static int ll_ext_merge(const struct ll_merge_driver *fn,
>  		unlink_or_warn(temp[i]);
>  	strbuf_release(&cmd);
>  	strbuf_release(&path_sq);
> -	return status;
> +	ret = (status > 1) ? LL_MERGE_CONFLICT : status;

same here, I'd test for "status > 0" because that's the convention for
external programs

> +	return ret;
>  }
>  
>  /*
> @@ -362,7 +366,7 @@ static void normalize_file(mmfile_t *mm, const char *path, struct index_state *i
>  	}
>  }
>  
> -int ll_merge(mmbuffer_t *result_buf,
> +enum ll_merge_result ll_merge(mmbuffer_t *result_buf,
>  	     const char *path,
>  	     mmfile_t *ancestor, const char *ancestor_label,
>  	     mmfile_t *ours, const char *our_label,
> diff --git a/ll-merge.h b/ll-merge.h
> index aceb1b24132..e4a20e81a3a 100644
> --- a/ll-merge.h
> +++ b/ll-merge.h
> @@ -82,13 +82,20 @@ struct ll_merge_options {
>  	long xdl_opts;
>  };
>  
> +enum ll_merge_result {
> +	LL_MERGE_ERROR = -1,
> +	LL_MERGE_OK = 0,
> +	LL_MERGE_CONFLICT,
> +	LL_MERGE_BINARY_CONFLICT,
> +};
> +
>  /**
>   * Perform a three-way single-file merge in core.  This is a thin wrapper
>   * around `xdl_merge` that takes the path and any merge backend specified in
>   * `.gitattributes` or `.git/info/attributes` into account.
>   * Returns 0 for a clean merge.
>   */
> -int ll_merge(mmbuffer_t *result_buf,
> +enum ll_merge_result ll_merge(mmbuffer_t *result_buf,
>  	     const char *path,
>  	     mmfile_t *ancestor, const char *ancestor_label,
>  	     mmfile_t *ours, const char *our_label,
> diff --git a/merge-blobs.c b/merge-blobs.c
> index ee0a0e90c94..8138090f81c 100644
> --- a/merge-blobs.c
> +++ b/merge-blobs.c
> @@ -36,7 +36,7 @@ static void *three_way_filemerge(struct index_state *istate,
>  				 mmfile_t *their,
>  				 unsigned long *size)
>  {
> -	int merge_status;
> +	enum ll_merge_result merge_status;
>  	mmbuffer_t res;
>  
>  	/*
> @@ -50,6 +50,9 @@ static void *three_way_filemerge(struct index_state *istate,
>  				istate, NULL);
>  	if (merge_status < 0)
>  		return NULL;
> +	if (merge_status == LL_MERGE_BINARY_CONFLICT)
> +		warning("Cannot merge binary files: %s (%s vs. %s)",
> +			path, ".our", ".their");
>  
>  	*size = res.size;
>  	return res.ptr;
> diff --git a/merge-ort.c b/merge-ort.c
> index 0342f104836..c24da2ba3cb 100644
> --- a/merge-ort.c
> +++ b/merge-ort.c
> @@ -1743,7 +1743,7 @@ static int merge_3way(struct merge_options *opt,
>  	mmfile_t orig, src1, src2;
>  	struct ll_merge_options ll_opts = {0};
>  	char *base, *name1, *name2;
> -	int merge_status;
> +	enum ll_merge_result merge_status;
>  
>  	if (!opt->priv->attr_index.initialized)
>  		initialize_attr_index(opt);
> @@ -1787,6 +1787,9 @@ static int merge_3way(struct merge_options *opt,
>  	merge_status = ll_merge(result_buf, path, &orig, base,
>  				&src1, name1, &src2, name2,
>  				&opt->priv->attr_index, &ll_opts);
> +	if (merge_status == LL_MERGE_BINARY_CONFLICT)
> +		warning("Cannot merge binary files: %s (%s vs. %s)",
> +			path, name1, name2);
>  
>  	free(base);
>  	free(name1);
> diff --git a/merge-recursive.c b/merge-recursive.c
> index d9457797dbb..bc73c52dd84 100644
> --- a/merge-recursive.c
> +++ b/merge-recursive.c
> @@ -1044,7 +1044,7 @@ static int merge_3way(struct merge_options *opt,
>  	mmfile_t orig, src1, src2;
>  	struct ll_merge_options ll_opts = {0};
>  	char *base, *name1, *name2;
> -	int merge_status;
> +	enum ll_merge_result merge_status;
>  
>  	ll_opts.renormalize = opt->renormalize;
>  	ll_opts.extra_marker_size = extra_marker_size;
> @@ -1090,6 +1090,9 @@ static int merge_3way(struct merge_options *opt,
>  	merge_status = ll_merge(result_buf, a->path, &orig, base,
>  				&src1, name1, &src2, name2,
>  				opt->repo->index, &ll_opts);
> +	if (merge_status == LL_MERGE_BINARY_CONFLICT)
> +		warning("Cannot merge binary files: %s (%s vs. %s)",
> +			a->path, name1, name2);
>  
>  	free(base);
>  	free(name1);
> diff --git a/notes-merge.c b/notes-merge.c
> index b4a3a903e86..01d596920ea 100644
> --- a/notes-merge.c
> +++ b/notes-merge.c
> @@ -344,7 +344,7 @@ static int ll_merge_in_worktree(struct notes_merge_options *o,
>  {
>  	mmbuffer_t result_buf;
>  	mmfile_t base, local, remote;
> -	int status;
> +	enum ll_merge_result status;
>  
>  	read_mmblob(&base, &p->base);
>  	read_mmblob(&local, &p->local);
> @@ -358,6 +358,9 @@ static int ll_merge_in_worktree(struct notes_merge_options *o,
>  	free(local.ptr);
>  	free(remote.ptr);
>  
> +	if (status == LL_MERGE_BINARY_CONFLICT)
> +		warning("Cannot merge binary files: %s (%s vs. %s)",
> +			oid_to_hex(&p->obj), o->local_ref, o->remote_ref);
>  	if ((status < 0) || !result_buf.ptr)
>  		die("Failed to execute internal merge");
>  
> diff --git a/rerere.c b/rerere.c
> index d83d58df4fb..b1f8961ed9e 100644
> --- a/rerere.c
> +++ b/rerere.c
> @@ -609,19 +609,23 @@ static int try_merge(struct index_state *istate,
>  		     const struct rerere_id *id, const char *path,
>  		     mmfile_t *cur, mmbuffer_t *result)
>  {
> -	int ret;
> +	enum ll_merge_result ret;
>  	mmfile_t base = {NULL, 0}, other = {NULL, 0};
>  
>  	if (read_mmfile(&base, rerere_path(id, "preimage")) ||
> -	    read_mmfile(&other, rerere_path(id, "postimage")))
> -		ret = 1;
> -	else
> +	    read_mmfile(&other, rerere_path(id, "postimage"))) {
> +		ret = LL_MERGE_CONFLICT;
> +	} else {
>  		/*
>  		 * A three-way merge. Note that this honors user-customizable
>  		 * low-level merge driver settings.
>  		 */
>  		ret = ll_merge(result, path, &base, NULL, cur, "", &other, "",
>  			       istate, NULL);
> +		if (ret == LL_MERGE_BINARY_CONFLICT)
> +			warning("Cannot merge binary files: %s (%s vs. %s)",
> +				path, "", "");

With the next patch, 7/8 callers of ll_merge (almost) immediately print
that warning.  Looks fine as is, but does it make sense to introduce a helper
function for the common case, or add a flag to ll_merge_options?

> +	}
>  
>  	free(base.ptr);
>  	free(other.ptr);
> -- 
> gitgitgadget
> 
