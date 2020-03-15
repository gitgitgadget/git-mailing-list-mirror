Return-Path: <SRS0=FHek=5A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B22AFC10DCE
	for <git@archiver.kernel.org>; Sun, 15 Mar 2020 18:17:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 585E9206B1
	for <git@archiver.kernel.org>; Sun, 15 Mar 2020 18:17:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lhIAEcVq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728637AbgCOSR6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 15 Mar 2020 14:17:58 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:34944 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726444AbgCOSR6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Mar 2020 14:17:58 -0400
Received: by mail-ot1-f68.google.com with SMTP id k26so15580770otr.2
        for <git@vger.kernel.org>; Sun, 15 Mar 2020 11:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=s9UBqsSTU4jJbyCKCnBukzC3ttDhrl/YM2a2rQs1q6M=;
        b=lhIAEcVq9Wl3G6ye0+b+Q7WK/LxMgHABN9qk2LqJ35+wlGxbMcUz7Ox7OSGCrHlG4J
         W0lmQdyNGrzIAUW0GM3WognpRjdwxh3ofJlb9NP+Lsr3IGurvZCpDXE9LOGUCydJGmso
         wfJrawUmS/zgsm7YcypDuf8cAFG6n3VczCThXWr/wVS5WaQQxliPRJrStZxFeUwzt7IU
         mCGfbXoGH1auv1Zgi/+/pPH8EuKC4xznMHiNqv8cxwdbkuaxLUuB503Tj+xr9KSQ9nZ8
         Xn4S08RPDsgKuzhPYT/FBm27Gvf2fn/9EXy3m3AR32Z1JSXwaQKArRg3B1/9NspMceBs
         LWYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=s9UBqsSTU4jJbyCKCnBukzC3ttDhrl/YM2a2rQs1q6M=;
        b=DMKAMTOFuaKvG4uLxYij1z7fwY9CtfSN9d06vqlylmVoKeNlZwXWsS62jC4HxUW/Zp
         B4u07Lcs9f3cw+nQ44HjHP/MwmOkyYkj6/8WBCXfR2nDd6brx0N21gGQE8VTLbOHZPYi
         qlDv5m4/RYOM/Jqj1JiQ5JW/tGogsjDMXK7JmY2V74oIBi5K3/LHAtsoJmwcBJ2J3Yon
         jCVhhsmkVb7x38Da623/K3G5nzEWu6RktFgHJNe53sh9sDfMvEd9L4pwPiZcBCh/QW8R
         pn/bxC1M0owDXx5FD/HosxSe7NPgOEMlWnKGY90XT16KSiEW1N4umcltRZhvwUeHfuOO
         okng==
X-Gm-Message-State: ANhLgQ2TEO+8+B+NNBXjSa6d8VgBj3WCk2Ac1dKypRpuUL6HspQvvpfX
        lzbUB9TH2Npmkc4SBM6WWE8=
X-Google-Smtp-Source: ADFU+vuq0MNdiPEHC6YN6805iZvetj+qHB6OPBaBQP+xBn4+5QoU+QcqLHgQln+nBMhiCMgXzuXhVA==
X-Received: by 2002:a9d:282:: with SMTP id 2mr19487107otl.178.1584296276571;
        Sun, 15 Mar 2020 11:17:56 -0700 (PDT)
Received: from [192.168.1.83] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id u18sm8592720otg.43.2020.03.15.11.17.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Mar 2020 11:17:56 -0700 (PDT)
Subject: Re: [PATCH 5/7] unpack-trees: add a new update_sparsity() function
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Elijah Newren <newren@gmail.com>
References: <pull.726.git.git.1584169893.gitgitgadget@gmail.com>
 <9f13a2e8c64d47a5b3a4a2a96451decaf548ca4e.1584169893.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <a2189235-d16a-cccc-a529-08cb854616b3@gmail.com>
Date:   Sun, 15 Mar 2020 14:17:55 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:74.0) Gecko/20100101
 Thunderbird/74.0
MIME-Version: 1.0
In-Reply-To: <9f13a2e8c64d47a5b3a4a2a96451decaf548ca4e.1584169893.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/14/2020 3:11 AM, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
> 
> Previously, the only way to update the SKIP_WORKTREE bits for various
> paths was invoking `git read-tree -mu HEAD` or calling the same code
> that this codepath invoked.  This however had a number of problems.
> Let's look at all the various cases:
> 
>   Flipping SKIP_WORKTREE -> !SKIP_WORKTREE (materializing files):
>     A) There is no file in the way
>     B) There is an untracked file in the way
>   Flipping !SKIP_WORKTREE -> SKIP_WORKTREE (removing files):
>     C) The path is clean
>     D) The path is unmerged
>     E) The path has unstaged changes
>     F) The path has staged changes (differs from HEAD)

Please also note that cases D, E, and F can appear in any combination.
The lack of any of D, E, and F is case "C".

Perhaps instead we should think of the following independent
states that can toggle orthogonally on a path:

  i. Current SKIP_WORKTREE value
 ii. Intended SKIP_WORKTREE value
iii. Path has staged changes.
 iv. Path has unstaged changes.
  v. Path is unmerged.

with the additional conditional case of:

 vi. There is a collision when changing from SKIP_WORKTREE to
     !SKIP_WORKTREE. This could be file content difference or
     a file/directory type conflict.

I believe the intention when refreshing or changing the sparse-
checkout definition is to:

 0. If a merge conflict happens outside the sparse cone, then
    the conflicting files are created with the conflict markers.
    This puts those paths in the state of having unstaged changes.

 1. If the path exists and we intend to set SKIP_WORKTREE, then
    delete the file only if there are no unstaged changes.

 2. If the path does not exist and we intend to remove SKIP_WORKTREE,
    then check for case (vi). Fail with a helpful error if any such
    case exists, and do not update any other paths.

(This is all before I read the rest, so I'm sorry if I repeat what
you have already described.)

> For `git read-tree -mu HEAD`, the behavior is as follows:
>     A) Materialize the file, as expected
>     B) Refuse to make *any* changes (to this path or any others)
>     C) Remove the file, as expected
>     D) Refuse to make *any* changes (to this path or any others)
>     E) Refuse to make *any* changes (to this path or any others)
>     F) Removes the file from the working copy AND resets the index
>        to match HEAD

This case F is particularly bad, as we lose a staged change and
its copy on disk. I believe that was the case that convinced me
to put in the requirement of a clean status before changing the
sparse-checkout definition.

> Refusing to modify files that could result in data loss as in cases B,
> D, and E is good, but refusing to work on any other paths is very
> problematic for users.  If they are in the middle of a rebase or have
> made modifications to files that bring in more dependencies, then for
> their build to work they need to update the sparse paths -- which they
> are prevented from doing.  Sometimes they stage the files and re-try,
> at which point they run into case F and believe that their changes are
> lost.  (Even if they come ask an expert, they have to trawl through
> their loose objects looking for which ones match which files.)
> 
> Add a new update_sparsity() function which behaves as follows in these
> cases:
>     A) Materialize the file, as expected
>     B) Leave the file in the working copy alone, clear the SKIP_WORKTREE
>        bit, and print a warning (thus leaving them in a state where
>        status will report the file as modified, which seems logical).
>     C) Remove the file, as expected
>     D) Do NOT mark this path as SKIP_WORKTREE, but allow others paths
>        to be updated.
>     E) Do NOT mark this path as SKIP_WORKTREE and print a warning about
>        the dirty path, but allow other paths to be updated.
>     F) Mark the path as SKIP_WORKTREE, but do not revert the version
>        stored in the index to match HEAD; leave the contents alone.
> 
> I tried a different behavior for B (leave the SKIP_WORKTREE bit set),
> but found it very surprising and counter-intuitive (e.g. the user sees
> it is present along with all the other files in that directory, tries to
> stage it, but git add ignores it since the SKIP_WORKTREE bit is set).

That sounds bad! I think you picked the right approach here.

> A, B, C, and E all seem like optimal behavior to me.  D may be as well,
> though I wonder if printing a warning would be an improvement.  Some
> might be slightly surprised by F at first, but given that it does the
> right thing with `git commit` and even `git commit -a` (add ignores
> entries that are marked SKIP_WORKTREE and thus doesn't delete them, and
> commit -a is similar), it seems logical to me.

The established usage pattern is that a user can create "colliding"
directories and files outside of the sparse cone and Git is expected
to ignore them. The problem happens when the user adds those paths
to the sparse cone. I think you handle the situations quite well with
this plan.

> +/*
> + * display all the "error" messages as warnings
> + */
> +static void display_warning_msgs(struct unpack_trees_options *o)
> +{
> +	int e, i;
> +	for (e = 0; e < NB_UNPACK_TREES_ERROR_TYPES; e++) {
> +		struct string_list *rejects = &o->unpack_rejects[e];
> +		if (rejects->nr > 0) {
> +			struct strbuf path = STRBUF_INIT;

nit: Define 'i' within the inner-most scope that it matters.

> +			for (i = 0; i < rejects->nr; i++)
> +				strbuf_addstr(&path, rejects->items[i].string);
> +			warning(ERRORMSG(o, e), super_prefixed(path.buf));
> +			strbuf_release(&path);
> +		}
> +		string_list_clear(rejects, 0);
> +	}
> +}
> +/*
> + * Update SKIP_WORKTREE bits according to sparsity patterns, and update
> + * working directory to match.
> + *
> + * Returns
> + *   0: success with no warnings
> + *   1: success with warnings (warnings come either from (a) dirty changes
> + *           present in which case we avoid marking those paths as
> + *           SKIP_WORKTREE, or (b) from untracked files being in the way us
> + *           checking a file out of the index, in which case we leave the file
> + *           in the working tree alone while clearing SKIP_WORKTREE)
> + *   -1: failure to manipulate the resulting index
> + *   -2: failure to reflect the changes to the work tree.
> + *
> + * CE_NEW_SKIP_WORKTREE is used internally.
> + */

I think I mentioned using an enum for this function in another patch, and
reading the documentation here makes that even more clear. Anything other
than {-1,0,1} return types really could use stronger typing. Even using
{-1,0,1} instead of just {0,1} is debatable if it should use an enum instead.

I wonder if this patch could benefit a split where we first return
{-2, -1, 0} and don't include any warnings, followed by a patch where
the warnings are added (and tested).

> +int update_sparsity(struct unpack_trees_options *o)
> +{
> +	struct pattern_list pl;
> +	int i, empty_worktree, ret = 0;
> +	unsigned old_show_all_errors;
> +
> +	old_show_all_errors = o->show_all_errors;
> +	o->show_all_errors = 1;
> +
> +	/* Sanity checks */
> +	if (!o->update || o->index_only || o->skip_sparse_checkout)
> +		BUG("update_sparsity() is for reflecting sparsity patterns in working directory");
> +	if (o->src_index != o->dst_index || o->fn)
> +		BUG("update_sparsity() called wrong");

I was going to add something about split indexes at the end,
but I think this precondition has it covered.

> +
> +	trace_performance_enter();
> +
> +	if (!o->pl) {
> +		char *sparse = git_pathdup("info/sparse-checkout");
> +		memset(&pl, 0, sizeof(pl));
> +		pl.use_cone_patterns = core_sparse_checkout_cone;
> +		if (add_patterns_from_file_to_list(sparse, "", 0, &pl, NULL) < 0) {
> +			/* FIXME: Skip to check_updates()?? */
> +			o->skip_sparse_checkout = 1;
> +			goto skip_sparse_checkout;
> +		} else
> +			o->pl = &pl;
> +		free(sparse);
> +	}

Outside of the goto, this part looks identical to other parts
of the same file where we "fallback" to the sparse-checkout file.
Perhaps that could be extracted to a helper method? It could
return failure when there is no in-memory pattern and the
sparse-checkout file fails to load, and in response we can do
the goto.

> +	/* Set NEW_SKIP_WORKTREE on existing entries. */
> +	mark_all_ce_unused(o->src_index);
> +	mark_new_skip_worktree(o->pl, o->src_index, 0,
> +			       CE_NEW_SKIP_WORKTREE, o->verbose_update);
> +
> +	/* Then loop over entries and update/remove as needed */
> +	ret = 0;
> +	empty_worktree = 1;
> +	for (i = 0; i < o->src_index->cache_nr; i++) {
> +		struct cache_entry *ce = o->src_index->cache[i];
> +
> +		if (apply_sparse_checkout(o->src_index, ce, o))
> +			ret = 1;

So here, we report that at least one path has a warning.

> +		if (!ce_skip_worktree(ce))
> +			empty_worktree = 0;
> +
> +	}
> +
> +	/*
> +	 * Sparse checkout is meant to narrow down checkout area
> +	 * but it does not make sense to narrow down to empty working
> +	 * tree. This is usually a mistake in sparse checkout rules.
> +	 * Do not allow users to do that.
> +	 */
> +	if (o->src_index->cache_nr && empty_worktree) {
> +		ret = unpack_failed(o, "Sparse checkout leaves no entry on working directory");

Interesting that we are using the result of unpack_failed() here.
I suppose that could be an argument for using an int instead of
an enum, but perhaps we translate the result of unpack_failed()
here? What sorts of values could it be, anyway? Is this a case
where unpack_failed() could return either -1 or -2? Or should
we simply set 'ret' to the "-1" case ourselves?

> +		goto done;
> +	}
> +
> +skip_sparse_checkout:
> +	if (check_updates(o, o->src_index))
> +		ret = -2;
> +
> +done:
> +	display_warning_msgs(o);
> +	o->show_all_errors = old_show_all_errors;
> +	trace_performance_leave("update_sparsity");
> +	return ret;
> +}
> +
>  /* Here come the merge functions */
>  
>  static int reject_merge(const struct cache_entry *ce,
> diff --git a/unpack-trees.h b/unpack-trees.h
> index ae1557fb804..5d1a77ae249 100644
> --- a/unpack-trees.h
> +++ b/unpack-trees.h
> @@ -90,6 +90,8 @@ struct unpack_trees_options {
>  int unpack_trees(unsigned n, struct tree_desc *t,
>  		 struct unpack_trees_options *options);
>  
> +int update_sparsity(struct unpack_trees_options *options);
> +

Would it not be the pattern to include the documentation comment
here in the header file?

In some ways, your update_sparsity() repeats some of the patterns
of unpack_trees(), especially with its order of mark_all_ce_unused(),
mark_new_skip_worktree(), and unpack_failed(). I think there may be
some benefits to adding some of the performance tracing patterns from
that method, too. These could be added as follow-up patches.

I'm happy that you decided to create a new method instead of adding
yet another mode to unpack_trees(), especially because your version
does not involve calling traverse_trees().

After careful inspection of your patch, I cannot find anything wrong.
I'm pretty happy with your organization and the approach seems clear.
Hopefully my comments in the commit message could help improve that
part of the discussion.

At this point, the only thing we really need are tests that demonstrate
as many of these cases as possible.

Thanks,
-Stolee

