Return-Path: <SRS0=3T2S=5I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87FE7C3F2CD
	for <git@archiver.kernel.org>; Mon, 23 Mar 2020 18:02:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 492FB2072D
	for <git@archiver.kernel.org>; Mon, 23 Mar 2020 18:02:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JyvB6v15"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727196AbgCWSC0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Mar 2020 14:02:26 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:33511 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727011AbgCWSC0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Mar 2020 14:02:26 -0400
Received: by mail-qk1-f193.google.com with SMTP id v7so6708185qkc.0
        for <git@vger.kernel.org>; Mon, 23 Mar 2020 11:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=m4Zt7BOm60W5+WDSmXfscpvlZmfaFU6iAXCnZWXmEuM=;
        b=JyvB6v15XOPgEvHMPWQ9aUDDG1nptKB8cpjB7Aczgi4T5sfKIGlAoGAK48y7n7aqYo
         zssib9w65xMkLtYAxJVfcGPfSDu4va/r8ILYKT7ux6p48nBrl0/yu2420nHI30j3hW5j
         yTill1o+Z1puSK7bcp09cKdQ+CjMSfM/HvnjJljTPB6pnrh2q8GEP1UzB/uCmYWiWnkV
         5szx9/uOhDxYPmi2yxa1zntzsc5kj+QkRWlm1BKrS7QTUqUl7o23oPcTI69xaO8YpNWU
         q6HNKjFtHUBtBxhY+CvX5R/80N7Du8eq6taXtVbflGtfU5O8x+yWfTQaOB3GoplOeEZq
         ss7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=m4Zt7BOm60W5+WDSmXfscpvlZmfaFU6iAXCnZWXmEuM=;
        b=FCcVD4nHjgQiYP4wJ5cHS8b/U6+VeA1KZeeFszDjoihFnOZKp/cuLtxZOMCAB5aLKb
         EDjqca15hN4PMmWN7FkCmwqfwLet5w4lxsz/vvVTUV8DAZdEXUgulVpPYAx/Pc8dIV9L
         qVXkPvOyz6ysasuM2Bb81Yp/vflEaRFlN5xPmBYfZE5ym/swWFDK17Di6CFvsCB7GS0k
         +Ah25KNsimM2h1w/PrBd+8fodgIYo/oo+/p7VLeN+KkxOgEmlOsbTkM5Nk9e4+DOTHRB
         yA0RKz6GEAFi8aXXtM5djun6mWH7ycVresCrc127qC9dQDWXQpTFufGaRwSi3cBPnEti
         gp4A==
X-Gm-Message-State: ANhLgQ1hiqDJ2lgIXmz05An0L9nhc4NhgXdKjzpAu/sIwlNwLa9rJnW5
        O+WEUxsK5K2CVd0INB04nzUNafE+j1Y=
X-Google-Smtp-Source: ADFU+vsMiEoOEDPNtm38YkdnvdhvVvBLfNLcYU8ITaosQOvgvJjowVy/ZI53kB3+eUVjyosnr4nflw==
X-Received: by 2002:a37:4648:: with SMTP id t69mr20744774qka.299.1584986543608;
        Mon, 23 Mar 2020 11:02:23 -0700 (PDT)
Received: from [192.168.1.83] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id f13sm12192562qti.47.2020.03.23.11.02.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Mar 2020 11:02:23 -0700 (PDT)
Subject: Re: [PATCH v2 09/18] unpack-trees: add a new update_sparsity()
 function
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Elijah Newren <newren@gmail.com>
References: <pull.726.git.git.1584169893.gitgitgadget@gmail.com>
 <pull.726.v2.git.git.1584813609.gitgitgadget@gmail.com>
 <a46439c8536f912ad4a1e1751852cf477d3d7dc7.1584813609.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <9501e018-fe87-16b8-b0d8-913e4331778d@gmail.com>
Date:   Mon, 23 Mar 2020 14:02:22 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:75.0) Gecko/20100101
 Thunderbird/75.0
MIME-Version: 1.0
In-Reply-To: <a46439c8536f912ad4a1e1751852cf477d3d7dc7.1584813609.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/21/2020 2:00 PM, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
> 
> Previously, the only way to update the SKIP_WORKTREE bits for various
> paths was invoking `git read-tree -mu HEAD` or calling the same code
> that this codepath invoked.  This however had a number of problems if
> the index or working directory were not clean.  First, let's consider
> the case:
> 
>   Flipping SKIP_WORKTREE -> !SKIP_WORKTREE (materializing files)
> 
> If the working tree was clean this was fine, but if there were files or
> directories or symlinks or whatever already present at the given path
> then the operation would abort with an error.  Let's label this case
> for later discussion:
> 
>     A) There is an untracked path in the way
> 
> Now let's consider the opposite case:
> 
>   Flipping !SKIP_WORKTREE -> SKIP_WORKTREE (removing files)
> 
> If the index and working tree was clean this was fine, but if there were
> any unclean paths we would run into problems.  There are three different
> cases to consider:
> 
>     B) The path is unmerged
>     C) The path has unstaged changes
>     D) The path has staged changes (differs from HEAD)
> 
> If any path fell into case B or C, then the whole operation would be
> aborted with an error.  With sparse-checkout, the whole operation would
> be aborted for case D as well, but for its predecessor of using `git
> read-tree -mu HEAD` directly, any paths that fell into case D would be
> removed from the working copy and the index entry for that path would be
> reset to match HEAD -- which looks and feels like data loss to users
> (only a few are even aware to ask whether it can be recovered, and even
> then it requires walking through loose objects trying to match up the
> right ones).
> 
> Refusing to remove files that have unsaved user changes is good, but
> refusing to work on any other paths is very problematic for users.  If
> the user is in the middle of a rebase or has made modifications to files
> that bring in more dependencies, then for their build to work they need
> to update the sparse paths.  This logic has been preventing them from
> doing so.  Sometimes in response, the user will stage the files and
> re-try, to no avail with sparse-checkout or to the horror of losing
> their changes if they are using its predecessor of `git read-tree -mu
> HEAD`.
> 
> Add a new update_sparsity() function which will not error out in any of
> these cases but behaves as follows for the special cases:
>     A) Leave the file in the working copy alone, clear the SKIP_WORKTREE
>        bit, and print a warning (thus leaving the path in a state where
>        status will report the file as modified, which seems logical).
>     B) Do NOT mark this path as SKIP_WORKTREE, and leave it as unmerged.
>     C) Do NOT mark this path as SKIP_WORKTREE and print a warning about
>        the dirty path.
>     D) Mark the path as SKIP_WORKTREE, but do not revert the version
>        stored in the index to match HEAD; leave the contents alone.
> 
> I tried a different behavior for A (leave the SKIP_WORKTREE bit set),
> but found it very surprising and counter-intuitive (e.g. the user sees
> it is present along with all the other files in that directory, tries to
> stage it, but git add ignores it since the SKIP_WORKTREE bit is set).  A
> & C seem like optimal behavior to me.  B may be as well, though I wonder
> if printing a warning would be an improvement.  Some might be slightly
> surprised by D at first, but given that it does the right thing with
> `git commit` and even `git commit -a` (`git add` ignores entries that
> are marked SKIP_WORKTREE and thus doesn't delete them, and `commit -a`
> is similar), it seems logical to me.
> 
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  unpack-trees.c | 78 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  unpack-trees.h |  9 ++++++
>  2 files changed, 87 insertions(+)
> 
> diff --git a/unpack-trees.c b/unpack-trees.c
> index 4733e7eaf89..6abea555929 100644
> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -1714,6 +1714,84 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
>  	goto done;
>  }
>  
> +/*
> + * Update SKIP_WORKTREE bits according to sparsity patterns, and update
> + * working directory to match.
> + *
> + * CE_NEW_SKIP_WORKTREE is used internally.
> + */
> +enum update_sparsity_result update_sparsity(struct unpack_trees_options *o)
> +{
> +	enum update_sparsity_result ret = UPDATE_SPARSITY_SUCCESS;
> +	struct pattern_list pl;
> +	int i, empty_worktree;
> +	unsigned old_show_all_errors;
> +	int free_pattern_list = 0;
> +
> +	old_show_all_errors = o->show_all_errors;
> +	o->show_all_errors = 1;
> +
> +	/* Sanity checks */
> +	if (!o->update || o->index_only || o->skip_sparse_checkout)
> +		BUG("update_sparsity() is for reflecting sparsity patterns in working directory");
> +	if (o->src_index != o->dst_index || o->fn)
> +		BUG("update_sparsity() called wrong");
> +
> +	trace_performance_enter();

I was about to say "why didn't you use the trace2 regions like in
unpack_trees()?" when I discovered that we haven't sent them [1]
upstream yet. I'll put that on my TODO list.

[1] https://github.com/microsoft/git/commit/9a04644e14fe4aeb556dfc30cb2220b799f53448

> +	/* If we weren't given patterns, use the recorded ones */
> +	if (!o->pl) {
> +		memset(&pl, 0, sizeof(pl));
> +		free_pattern_list = 1;

I notice you are using the same free_pattern_list pattern as your
earlier commit. Good.

> +		populate_from_existing_patterns(o, &pl);
> +		if (o->skip_sparse_checkout)
> +			goto skip_sparse_checkout;
> +	}
> +
> +	/* Set NEW_SKIP_WORKTREE on existing entries. */
> +	mark_all_ce_unused(o->src_index);
> +	mark_new_skip_worktree(o->pl, o->src_index, 0,
> +			       CE_NEW_SKIP_WORKTREE, o->verbose_update);
> +
> +	/* Then loop over entries and update/remove as needed */
> +	ret = UPDATE_SPARSITY_SUCCESS;
> +	empty_worktree = 1;
> +	for (i = 0; i < o->src_index->cache_nr; i++) {
> +		struct cache_entry *ce = o->src_index->cache[i];
> +
> +		if (apply_sparse_checkout(o->src_index, ce, o))
> +			ret = UPDATE_SPARSITY_WARNINGS;
> +
> +		if (!ce_skip_worktree(ce))
> +			empty_worktree = 0;
> +

nit: extra whitespace-only line

> +	}
> +
> +	/*
> +	 * Sparse checkout is meant to narrow down checkout area
> +	 * but it does not make sense to narrow down to empty working
> +	 * tree. This is usually a mistake in sparse checkout rules.
> +	 * Do not allow users to do that.
> +	 */
> +	if (o->src_index->cache_nr && empty_worktree) {
> +		unpack_failed(o, "Sparse checkout leaves no entry on working directory");
> +		ret = UPDATE_SPARSITY_INDEX_UPDATE_FAILURES;
> +		goto done;
> +	}
> +
> +skip_sparse_checkout:
> +	if (check_updates(o, o->src_index))
> +		ret = UPDATE_SPARSITY_WORKTREE_UPDATE_FAILURES;
> +
> +done:
> +	display_error_msgs(o);
> +	o->show_all_errors = old_show_all_errors;
> +	if (free_pattern_list)
> +		clear_pattern_list(&pl);
> +	trace_performance_leave("update_sparsity");
> +	return ret;
> +}
> +
>  /* Here come the merge functions */
>  
>  static int reject_merge(const struct cache_entry *ce,
> diff --git a/unpack-trees.h b/unpack-trees.h
> index d3516267f36..2c5d54cae9f 100644
> --- a/unpack-trees.h
> +++ b/unpack-trees.h
> @@ -28,6 +28,13 @@ enum unpack_trees_error_types {
>  	NB_UNPACK_TREES_ERROR_TYPES
>  };
>  
> +enum update_sparsity_result {
> +	UPDATE_SPARSITY_SUCCESS = 0,
> +	UPDATE_SPARSITY_WARNINGS = 1,
> +	UPDATE_SPARSITY_INDEX_UPDATE_FAILURES = -1,
> +	UPDATE_SPARSITY_WORKTREE_UPDATE_FAILURES = -2
> +};
> +

Is there a reason this isn't located just before
update_sparsity()?

>  /*
>   * Sets the list of user-friendly error messages to be used by the
>   * command "cmd" (either merge or checkout), and show_all_errors to 1.
> @@ -88,6 +95,8 @@ struct unpack_trees_options {
>  int unpack_trees(unsigned n, struct tree_desc *t,
>  		 struct unpack_trees_options *options);
>  
> +int update_sparsity(struct unpack_trees_options *options);
> +

This appears to not use the enum as it should.

Thanks,
-Stolee

