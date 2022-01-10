Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96935C433F5
	for <git@archiver.kernel.org>; Mon, 10 Jan 2022 20:38:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240243AbiAJUiW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Jan 2022 15:38:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239773AbiAJUiV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jan 2022 15:38:21 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E57EAC06173F
        for <git@vger.kernel.org>; Mon, 10 Jan 2022 12:38:20 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id r139so16525988qke.9
        for <git@vger.kernel.org>; Mon, 10 Jan 2022 12:38:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=u5GbJOBgJUY6IJlF829RbwHtZhJ5ULcyizOpyDyRJG8=;
        b=hKKwOYgIAg+gq6RD4bW4I/3SuOdT38ByG5cHVgR9HzW7QOesRgHQ4rY6U6MbQdC5/L
         8xnHIDTOm/HMRXwrRcUopjpFlJg/vBV2fG/v30Q0QiPU5gIOnrHxzxhmeu/N0NaXvmgz
         ImWOekHFiKPDHKEzQ+bukG7Yhb3QOcrZuMpS2EKIuN230TbpYuf9CPWav+PbalaJFDkf
         3t0FTnQFZgAzHW9Sh0YMykpAW15dcbqGXgnjbF/iZvqXmU041Nodw0RR5etY9TMd4t2K
         DFN+xREkYy1h9xtI7BOQKnDTjhsW9Nvnq2xmXuq3uUJkam1jjWHIJRnePPJhsOKWd7p9
         6n4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=u5GbJOBgJUY6IJlF829RbwHtZhJ5ULcyizOpyDyRJG8=;
        b=tSsMjj9hztzANrbGVSiDz+6mwL/DlSzgeqXO7dtMuFtioz92zcMXLoxBnDG4oI5JWX
         8G7AIsCGedAte00LdINlb1c6ugUcL9HbJ7jjw0+8GA8qx5Ay+WYq0Cw6Q9LEdh9nc9YD
         v34r/NSOostl20mWJyijq9rpr+ECuDuBmIm+Km/HGUMG0/VEI9Wq2VwJ4Rt7WrRhlVzK
         tfhrgaAqfzdjomMt0+pATo36k1lAjndYcb7mUpn1MORKWRBmhb3FajibIMLZa284ESjY
         86MlAv4Q9KAqClNVDLKdyOcsx1LQbdFdTLnnGmIVzKB65yR/m0clhpAAI3hjFmwpe4xK
         CL8A==
X-Gm-Message-State: AOAM530Cy9vR1g2Ol1Qv6Njt+sC+UPVJgf4sMnBzxJ9yxjt5ouNO72yO
        qfRJBSfUS6ilrs3Po/u+q/n1
X-Google-Smtp-Source: ABdhPJxtyz8cOeudbrDwZeBSj0oPd7eqB78hG+ElYCgPnnsdxoD8p7QVwgsXJydRZnbX4dXrfQNEPA==
X-Received: by 2002:a05:620a:4451:: with SMTP id w17mr1132941qkp.622.1641847099718;
        Mon, 10 Jan 2022 12:38:19 -0800 (PST)
Received: from [192.168.0.105] (70.15.20.152.res-cmts.sm.ptd.net. [70.15.20.152])
        by smtp.gmail.com with ESMTPSA id r15sm4980680qtm.55.2022.01.10.12.38.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jan 2022 12:38:19 -0800 (PST)
Message-ID: <38b69b5e-b461-23cc-155e-26fd58e5f714@github.com>
Date:   Mon, 10 Jan 2022 15:38:18 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.1
Subject: Re: [RFC PATCH 3/5] repo_read_index: ensure SKIP_WORKTREE means skip
 worktree
Content-Language: en-US
To:     Elijah Newren <newren@gmail.com>, git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        Lessley Dennington <lessleydennington@gmail.com>
References: <20220109045732.2497526-1-newren@gmail.com>
 <20220109045732.2497526-4-newren@gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <20220109045732.2497526-4-newren@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren wrote:
> The fix is short (~30 lines), but the description is not.  Sorry.
> 
> There is a set of problems caused by files in what I'll refer to as the
> "present-despite-SKIP_WORKTREE" state.  This commit aims to not just fix
> these problems, but remove the entire class as a possibility -- for
> those using sparse checkouts.  But first, we need to understand the
> problems this class presents.  A quick outline:
> 
>    * Problems
>      * User facing issues
>      * Problem space complexity
>      * Maintenance and code correctness challenges
>    * SKIP_WORKTREE expectations in Git
>    * Suggested solution
>    * Pros/Cons of suggested solution
>    * Notes on testcase modifications
> 
> === User facing issues ===
> 
> There are various ways for users to get files to be present in the
> working copy despite having the SKIP_WORKTREE bit set for that file in
> the index.  This may come from:
>   * various git commands not really supporting the SKIP_WORKTREE bit[1,2]
>   * users grabbing files from elsewhere and writing them to the worktree
>     (perhaps even cached in their editor)
>   * users attempting to "abort" a sparse-checkout operation with a
>     not-so-early Ctrl+C (updating $GIT_DIR/info/sparse-checkout and the
>     working tree is not atomic)[3].
> 
> Once users have present-despite-SKIP_WORKTREE files, any modifications
> users make to these files will be ignored, possibly to users' confusion.
> 
> Further:
>   * these files will not be updated by by standard commands
>     (switch/checkout/pull/merge/rebase will leave them alone unless
>     conflicts happen -- and even then, the conflicted file may be
>     written somewhere else to avoid overwriting the SKIP_WORKTREE file
>     that is present and in the way)
>   * there is nothing in Git that users can use to discover such
>     files (status, diff, grep, etc. all ignore it)
>   * there is no reasonable mechanism to "recover" from such a condition
>     (neither `git sparse-checkout reapply` nor `git reset --hard` will
>     correct it).
> 

Just to add to this, files like these always force sparse index expansion in
`git status` (and probably some other commands?), ruining a lot of the
performance gains of using sparse index in the first place.

> So, not only are users modifications ignored, but the files get
> progressively more stale over time.  At some point in the future, they
> may change their sparseness specification or disable sparse-checkouts.
> At that time, all present-despite-SKIP_WORKTREE files will show up as
> having lots of modifications because they represent a version from a
> different branch or commit.  These might include user-made local changes
> from days before, but the only way to tell is to have users look through
> them all closely.
> 
> If these users come to others for help, there will be no logs that
> explain the issue; it's just a mysterious list of changes.  Users might
> adamantly claim (correctly, as it turns out) that they didn't modify
> these files, while others presume they did.
> 
> [1] https://lore.kernel.org/git/xmqqbmb1a7ga.fsf@gitster-ct.c.googlers.com/
> [2] https://lore.kernel.org/git/CABPp-BH9tju7WVm=QZDOvaMDdZbpNXrVWQdN-jmfN8wC6YVhmw@mail.gmail.com/
> [3] https://lore.kernel.org/git/CABPp-BFnFpzwGC11TLoLs8YK5yiisA5D5-fFjXnJsbESVDwZsA@mail.gmail.com/
> 
> === Problem space complexity ===
> 
> SKIP_WORKTREE has been part of Git for over a decade.  Duy did lots of
> work on it initially, and several others have since come along and put
> lots of work into it.  Stolee spent most of 2021 on the sparse-index,
> with lots of bugfixes along the way including to non-sparse-index cases
> as we are still trying to get sparse checkouts to behave reasonably.
> Basically every codepath throughout the treat needs to be aware of an
> additional type of file: tracked-but-not-present.  The extra type
> results in lots of extra testcases and lots of extra code everywhere.
> 
> But, the sad thing is that we actually have more than one extra type.
> We have tracked, tracked-but-not-present (SKIP_WORKTREE), and
> tracked-but-promised-to-not-be-present-but-is-present-anyway
> (present-despite-SKIP_WORKTREE).  Two types is a monumental amount of
> effort to support, and adding a third feels a bit like insanity[4].
> 
> [4] Some examples of which can be seen at
>     https://lore.kernel.org/git/CABPp-BGJ_Nvi5TmgriD9Bh6eNXE2EDq2f8e8QKXAeYG3BxZafA@mail.gmail.com/
> 
> === Maintenance and code correctness challenges ===
> 
> Matheus' patches to grep stalled for nearly a year, in part because of
> complications of how to handle sparse-checkouts appropriately in all
> cases[5][6] (with trying to sanely figure out how to sanely handle
> present-despite-SKIP_WORKTREE files being one of the complications).
> His rm/add follow-ups also took months because of those kinds of
> issues[7].  The corner cases with things like submodules and
> SKIP_WORKTREE with the addition of present-despite-SKIP_WORKTREE start
> becoming really complex[8].
> 
> We've had to add ugly logic to merge-ort to attempt to handle
> present-despite-SKIP_WORKTREE files[9], and basically just been forced
> to give up in merge-recursive knowing full well that we'll sometimes
> silently discard user modifications.  Despite stash essentially being a
> merge, it needed extra code (beyond what was in merge-ort and
> merge-recursive) to manually tweak SKIP_WORKTREE bits in order to avoid
> a few different bugs that'd result in an early abort with a partial
> stash application[10].
> 
> [5] See https://lore.kernel.org/git/5f3f7ac77039d41d1692ceae4b0c5df3bb45b74a.1612901326.git.matheus.bernardino@usp.br/#t
>     and the dates on the thread; also Matheus and I had several
>     conversations off-list trying to resolve the issues over that time
> [6] ...it finally kind of got unstuck after
>     https://lore.kernel.org/git/CABPp-BGJ_Nvi5TmgriD9Bh6eNXE2EDq2f8e8QKXAeYG3BxZafA@mail.gmail.com/
> [7] See for example
>     https://lore.kernel.org/git/CABPp-BHwNoVnooqDFPAsZxBT9aR5Dwk5D9sDRCvYSb8akxAJgA@mail.gmail.com/#t
>     and quotes like "The core functionality of sparse-checkout has always
>     been only partially implemented", a statement I still believe is true
>     today.
> [8] https://lore.kernel.org/git/pull.809.git.git.1592356884310.gitgitgadget@gmail.com/
> [9] See commit 66b209b86a ("merge-ort: implement CE_SKIP_WORKTREE
>     handling with conflicted entries", 2021-03-20)
> [10] See commit ba359fd507 ("stash: fix stash application in
>      sparse-checkouts", 2020-12-01)
> 
> === SKIP_WORKTREE expectations in Git ===
> 
> A couple quotes:
> 
> From [11] (before the "sparse-checkout" command existed):
>    If it needs too many special cases, hacks, and conditionals, then it
>    is not worth the complexity---if it is easier to write a correct code
>    by allowing Git to populate working tree files, it is perfectly fine
>    to do so.
> 
>    In a sense, the sparse checkout "feature" itself is a hack by itself,
>    and that is why I think this part should be "best effort" as well.
> 
> From the git-sparse-checkout manual (still present today):
> 
>    THIS COMMAND IS EXPERIMENTAL. ITS BEHAVIOR, AND THE BEHAVIOR OF OTHER
>    COMMANDS IN THE PRESENCE OF SPARSE-CHECKOUTS, WILL LIKELY CHANGE IN
>    THE FUTURE.
> 
> [11] https://lore.kernel.org/git/xmqqbmb1a7ga.fsf@gitster-ct.c.googlers.com/
> 
> === Suggested solution ===
> 
> SKIP_WORKTREE was written to allow sparse-checkouts, in particular, as
> the name of the option implies, to allow the file to NOT be in the
> worktree but consider it to be unchanged rather than deleted.
> 
> The suggests a simple solution: present-despite-SKIP_WORKTREE files
> should not exist, for those using sparse-checkouts.
> 
> Enforce this at index loading time by checking if core.sparseCheckout is
> true; if so, check files in the index with the SKIP_WORKTREE bit set to
> verify that they are absent from the working tree.  If they are present,
> unset the bit (in memory, though any commands that write to the index
> will record the update).
> 

Since this solution is specific to a sparse-checkout, should this automatic
unsetting only be done if the file is outside the sparse checkout
definition? Otherwise, the `sparse-checkout reapply` cleanup suggested below
doesn't return the original `skip-worktree` state. 

Admittedly, I imagine it's unlikely that someone is simultaneously using a
sparse checkout and manually SKIP_WORKTREE-ing files *inside* the sparse
checkout definition. But, given that you're not unsetting the flag for
non-sparse-checkout SKIP_WORKTREE files, it seems like an additional
constraint based on sparse checkout patterns would be consistent with
other parts of this patch.

> Users can, of course, can get the SKIP_WORKTREE bit back such as by
> running `git sparse-checkout reapply` (if they have ensured the file is
> unmodified and doesn't match the specified sparsity patterns).
> 

There are some performance implications of this solution in a sparse
index-enabled checkout. Any time an out-of-cone file is no longer
SKIP_WORKTREE, its parent directory lineage will be added to the sparse index,
and performance would progressively (silently) degrade as more out-of-cone
files were added.

That said, a lot of my concern would be alleviated with some kind of warning
indicating that a file just had SKIP_WORKTREE removed, including a mention
of fixing it with `git sparse-checkout reapply`. 

It would be *extra* nice if `git status` could tell a user that they have
non-SKIP_WORKTREE files outside the sparse definition, but I think that's
less critical and probably better suited as a separate series.

> === Pros/Cons of suggested solution ===
> 
> Pros:
> 
>   * Solves the user visible problems reported above, which I've been
>     complaining about for nearly a year but couldn't find a solution to.
>   * Much easier behavior in sparse-checkouts for users to reason about
>   * Very simple, ~30 lines of code.
>   * Significantly simplifies some ugly testcases, and obviates the need
>     to test an entire class of potential issues.
>   * Reduces code complexity, reasoning, and maintenance.  Avoids
>     disagreements about weird corner cases[12].
>   * It has been reported that some users might be (ab)using
>     SKIP_WORKTREE as a let-me-modify-but-keep-the-file-in-the-worktree
>     mechanism[13, and a few other similar references].  These users know
>     of multiple caveats and shortcomings in doing so; perhaps not
>     surprising given the "SKIP_WORKTREE expecations" section above.
>     However, these users use `git update-index --skip-worktree`, and not
>     `git sparse-checkout` or core.sparseCheckout=true.  As such, these
>     users would be unaffected by this change and can continue abusing
>     the system as before.
> 
> [12] https://lore.kernel.org/git/CABPp-BH9tju7WVm=QZDOvaMDdZbpNXrVWQdN-jmfN8wC6YVhmw@mail.gmail.com/
> [13] https://stackoverflow.com/questions/13630849/git-difference-between-assume-unchanged-and-skip-worktree
> 
> Cons:
> 
>   * When core.sparseCheckout is enabled, this adds a performance cost to
>     reading the index.  I'll defer discussion of this cost to a subsequent
>     patch, since I have some optimizations to add.
> 
> === Notes on testcase modifications ===
> 
> The good:
>   * t1011: Compare to two cases above it ('read-tree will not throw away
>     dirty changes, non-sparse'); since the file is present, it should
>     match the non-sparse case now
>   * t1092: sparse-index & sparse-checkout now match full-worktree
>     behavior in more cases!  Yaay for consistency!
>   * t6428, t7012: look at how much simpler the tests become!  Merge and
>     stash can just fail early telling the user there's a file in the
>     way, instead of not noticing until it's about to write a file and
>     then have to implement sudden crash avoidance.  Hurray for sanity!
>   * t7817: sparse behavior better matches full tree behavior.  Hurray
>     for sanity!
> 
> The confusing:
>   * t3705: These changes were ONLY needed on Windows, but they don't
>     hurt other platforms.  Let's discuss each individually:
> 
>     * core.sparseCheckout should be false by default.  Nothing in this
>       testcase toggles that until many, many tests later.  However,
>       early tests (#5 in particular) were testing `update-index
>       --skip-worktree` behavior in a non-sparse-checkout, but the
>       Windows tests in CI were behaving as if core.sparseCheckout=true
>       had been specified somewhere.  I do not have access to a Windows
>       machine.  But I just manually did what should have been a no-op
>       and turned the config off.  And it fixed the test.
>     * I have no idea why the leftover .gitattributes file from this
>       test was causing failures for test #18 on Windows, but only with
>       these changes of mine.  Test #18 was checking for empty stderr,
>       and specifically wanted to know that some error completely
>       unrelated to file endings did not appear.  The leftover
>       .gitattributes file thus caused some spurious stderr unrelated to
>       the thing being checked.  Since other tests did not intend to
>       test normalization, just proactively remove the .gitattributes
>       file.  I'm certain this is cleaner and better, I'm just unsure
>       why/how this didn't trigger problems before.
> 
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  repository.c                             |  7 ++++
>  sparse-index.c                           | 22 ++++++++++++
>  sparse-index.h                           |  1 +
>  t/t1011-read-tree-sparse-checkout.sh     |  2 +-
>  t/t1092-sparse-checkout-compatibility.sh | 16 ++++-----
>  t/t3705-add-sparse-checkout.sh           |  2 ++
>  t/t6428-merge-conflicts-sparse.sh        | 23 +++----------
>  t/t7012-skip-worktree-writing.sh         | 44 ++++--------------------
>  t/t7817-grep-sparse-checkout.sh          | 11 ++++--
>  9 files changed, 62 insertions(+), 66 deletions(-)
> 
> diff --git a/repository.c b/repository.c
> index 34610c5a33..dfd1911902 100644
> --- a/repository.c
> +++ b/repository.c
> @@ -301,6 +301,13 @@ int repo_read_index(struct repository *repo)
>  	if (repo->settings.command_requires_full_index)
>  		ensure_full_index(repo->index);
>  
> +	/*
> +	 * If sparse checkouts are in use, check whether paths with the
> +	 * SKIP_WORKTREE attribute are missing from the worktree; if not,
> +	 * clear that attribute for that path.
> +	 */
> +	ensure_skip_worktree_means_skip_worktree(repo->index);
> +
>  	return res;
>  }
>  
> diff --git a/sparse-index.c b/sparse-index.c
> index a1d505d50e..79d50e444c 100644
> --- a/sparse-index.c
> +++ b/sparse-index.c
> @@ -341,6 +341,28 @@ void ensure_correct_sparsity(struct index_state *istate)
>  		ensure_full_index(istate);
>  }
>  
> +void ensure_skip_worktree_means_skip_worktree(struct index_state *istate)

I can feel the frustration behind this name. :) 

However, a more descriptive one would make the code easier to follow, e.g.
'clear_skip_worktree_from_present_files' (or something else indicating what
it does to the index).

> +{
> +	int i;
> +	if (!core_apply_sparse_checkout)
> +		return;
> +
> +restart:
> +	for (i = 0; i < istate->cache_nr; i++) {
> +		struct cache_entry *ce = istate->cache[i];
> +		struct stat st;
> +
> +		if (ce_skip_worktree(ce) && !lstat(ce->name, &st)) {
> +			if (S_ISSPARSEDIR(ce->ce_mode)) {
> +				ensure_full_index(istate);
> +				goto restart;
> +			}
> +			ce->ce_flags &= ~CE_SKIP_WORKTREE;
> +		}
> +	}
> +}
> +
> +
>  /*
>   * This static global helps avoid infinite recursion between
>   * expand_to_path() and index_file_exists().
> diff --git a/sparse-index.h b/sparse-index.h
> index 656bd835b2..1007859ed4 100644
> --- a/sparse-index.h
> +++ b/sparse-index.h
> @@ -5,6 +5,7 @@ struct index_state;
>  #define SPARSE_INDEX_MEMORY_ONLY (1 << 0)
>  int convert_to_sparse(struct index_state *istate, int flags);
>  void ensure_correct_sparsity(struct index_state *istate);
> +void ensure_skip_worktree_means_skip_worktree(struct index_state *istate);
>  
>  /*
>   * Some places in the codebase expect to search for a specific path.
> diff --git a/t/t1011-read-tree-sparse-checkout.sh b/t/t1011-read-tree-sparse-checkout.sh
> index 4ed0885bf2..dd957be1b7 100755
> --- a/t/t1011-read-tree-sparse-checkout.sh
> +++ b/t/t1011-read-tree-sparse-checkout.sh
> @@ -212,7 +212,7 @@ test_expect_success 'read-tree updates worktree, dirty case' '
>  	echo sub/added >.git/info/sparse-checkout &&
>  	git checkout -f top &&
>  	echo dirty >init.t &&
> -	read_tree_u_must_succeed -m -u HEAD^ &&
> +	read_tree_u_must_fail -m -u HEAD^ &&
>  	grep -q dirty init.t &&
>  	rm init.t
>  '
> diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
> index 0863c9747c..6f8538bb4c 100755
> --- a/t/t1092-sparse-checkout-compatibility.sh
> +++ b/t/t1092-sparse-checkout-compatibility.sh
> @@ -370,7 +370,7 @@ test_expect_success 'status/add: outside sparse cone' '
>  	write_script edit-contents <<-\EOF &&
>  	echo text >>$1
>  	EOF
> -	run_on_sparse ../edit-contents folder1/a &&
> +	run_on_all ../edit-contents folder1/a &&
>  	run_on_all ../edit-contents folder1/new &&
>  
>  	test_sparse_match git status --porcelain=v2 &&
> @@ -379,8 +379,8 @@ test_expect_success 'status/add: outside sparse cone' '
>  	test_sparse_match test_must_fail git add folder1/a &&
>  	grep "Disable or modify the sparsity rules" sparse-checkout-err &&
>  	test_sparse_unstaged folder1/a &&
> -	test_sparse_match test_must_fail git add --refresh folder1/a &&
> -	grep "Disable or modify the sparsity rules" sparse-checkout-err &&
> +	test_all_match git add --refresh folder1/a &&
> +	test_must_be_empty sparse-checkout-err &&
>  	test_sparse_unstaged folder1/a &&
>  	test_sparse_match test_must_fail git add folder1/new &&
>  	grep "Disable or modify the sparsity rules" sparse-checkout-err &&
> @@ -642,11 +642,11 @@ test_expect_success 'update-index modify outside sparse definition' '
>  	run_on_sparse cp ../initial-repo/folder1/a folder1/a &&
>  	run_on_all ../edit-contents folder1/a &&
>  
> -	# If file has skip-worktree enabled, update-index does not modify the
> -	# index entry
> -	test_sparse_match git update-index folder1/a &&
> -	test_sparse_match git status --porcelain=v2 &&
> -	test_must_be_empty sparse-checkout-out &&
> +	# If file has skip-worktree enabled, but the file is present, it is
> +	# treated the same as if skip-worktree is disabled
> +	test_all_match git status --porcelain=v2 &&
> +	test_all_match git update-index folder1/a &&
> +	test_all_match git status --porcelain=v2 &&
>  
>  	# When skip-worktree is disabled (even on files outside sparse cone), file
>  	# is updated in the index
> diff --git a/t/t3705-add-sparse-checkout.sh b/t/t3705-add-sparse-checkout.sh
> index f3143c9290..61506c1d7c 100755
> --- a/t/t3705-add-sparse-checkout.sh
> +++ b/t/t3705-add-sparse-checkout.sh
> @@ -19,6 +19,7 @@ setup_sparse_entry () {
>  	fi &&
>  	git add sparse_entry &&
>  	git update-index --skip-worktree sparse_entry &&
> +	git config core.sparseCheckout false &&
>  	git commit --allow-empty -m "ensure sparse_entry exists at HEAD" &&
>  	SPARSE_ENTRY_BLOB=$(git rev-parse :sparse_entry)
>  }
> @@ -126,6 +127,7 @@ test_expect_success 'git add --chmod does not update sparse entries' '
>  '
>  
>  test_expect_success 'git add --renormalize does not update sparse entries' '
> +	test_when_finished rm .gitattributes &&
>  	test_config core.autocrlf false &&
>  	setup_sparse_entry "LINEONE\r\nLINETWO\r\n" &&
>  	echo "sparse_entry text=auto" >.gitattributes &&
> diff --git a/t/t6428-merge-conflicts-sparse.sh b/t/t6428-merge-conflicts-sparse.sh
> index 7e8bf497f8..142c9aaabc 100755
> --- a/t/t6428-merge-conflicts-sparse.sh
> +++ b/t/t6428-merge-conflicts-sparse.sh
> @@ -112,7 +112,7 @@ test_expect_success 'conflicting entries written to worktree even if sparse' '
>  	)
>  '
>  
> -test_expect_merge_algorithm failure success 'present-despite-SKIP_WORKTREE handled reasonably' '
> +test_expect_success 'present-despite-SKIP_WORKTREE handled reasonably' '
>  	test_setup_numerals in_the_way &&
>  	(
>  		cd numerals_in_the_way &&
> @@ -132,26 +132,13 @@ test_expect_merge_algorithm failure success 'present-despite-SKIP_WORKTREE handl
>  
>  		test_must_fail git merge -s recursive B^0 &&
>  
> -		git ls-files -t >index_files &&
> -		test_cmp expected-index index_files &&
> +		test_path_is_missing .git/MERGE_HEAD &&
>  
> -		test_path_is_file README &&
>  		test_path_is_file numerals &&
>  
> -		test_cmp expected-merge numerals &&
> -
> -		# There should still be a file with "foobar" in it
> -		grep foobar * &&
> -
> -		# 5 other files:
> -		#   * expected-merge
> -		#   * expected-index
> -		#   * index_files
> -		#   * others
> -		#   * whatever name was given to the numerals file that had
> -		#     "foobar" in it
> -		git ls-files -o >others &&
> -		test_line_count = 5 others
> +		# numerals should still have "foobar" in it
> +		echo foobar >expect &&
> +		test_cmp expect numerals
>  	)
>  '
>  
> diff --git a/t/t7012-skip-worktree-writing.sh b/t/t7012-skip-worktree-writing.sh
> index a1080b94e3..cb9f1a6981 100755
> --- a/t/t7012-skip-worktree-writing.sh
> +++ b/t/t7012-skip-worktree-writing.sh
> @@ -171,50 +171,20 @@ test_expect_success 'stash restore in sparse checkout' '
>  
>  		# Put a file in the working directory in the way
>  		echo in the way >modified &&
> -		git stash apply &&
> +		test_must_fail git stash apply 2>error&&
>  
> -		# Ensure stash vivifies modifies paths...
> -		cat >expect <<-EOF &&
> -		H addme
> -		H modified
> -		H removeme
> -		H subdir/A
> -		S untouched
> -		EOF
> -		git ls-files -t >actual &&
> -		test_cmp expect actual &&
> +		grep "changes.*would be overwritten by merge" error &&
>  
> -		# ...and that the paths show up in status as changed...
> -		cat >expect <<-EOF &&
> -		A  addme
> -		 M modified
> -		 D removeme
> -		 M subdir/A
> -		?? actual
> -		?? expect
> -		?? modified.stash.XXXXXX
> -		EOF
> -		git status --porcelain | \
> -			sed -e s/stash......./stash.XXXXXX/ >actual &&
> -		test_cmp expect actual &&
> +		echo in the way >expect &&
> +		test_cmp expect modified &&
> +		git diff --quiet HEAD ":!modified" &&
>  
>  		# ...and that working directory reflects the files correctly
> -		test_path_is_file    addme &&
> +		test_path_is_missing addme &&
>  		test_path_is_file    modified &&
>  		test_path_is_missing removeme &&
>  		test_path_is_file    subdir/A &&
> -		test_path_is_missing untouched &&
> -
> -		# ...including that we have the expected "modified" file...
> -		cat >expect <<-EOF &&
> -		modified
> -		tweaked
> -		EOF
> -		test_cmp expect modified &&
> -
> -		# ...and that the other "modified" file is still present...
> -		echo in the way >expect &&
> -		test_cmp expect modified.stash.*
> +		test_path_is_missing untouched
>  	)
>  '
>  
> diff --git a/t/t7817-grep-sparse-checkout.sh b/t/t7817-grep-sparse-checkout.sh
> index 590b99bbb6..eb59564565 100755
> --- a/t/t7817-grep-sparse-checkout.sh
> +++ b/t/t7817-grep-sparse-checkout.sh
> @@ -83,10 +83,13 @@ test_expect_success 'setup' '
>  
>  # The test below covers a special case: the sparsity patterns exclude '/b' and
>  # sparse checkout is enabled, but the path exists in the working tree (e.g.
> -# manually created after `git sparse-checkout init`). git grep should skip it.
> +# manually created after `git sparse-checkout init`).  Although b is marked
> +# as SKIP_WORKTREE, git grep should notice it IS present in the worktree and
> +# report it.
>  test_expect_success 'working tree grep honors sparse checkout' '
>  	cat >expect <<-EOF &&
>  	a:text
> +	b:new-text
>  	EOF
>  	test_when_finished "rm -f b" &&
>  	echo "new-text" >b &&
> @@ -126,12 +129,16 @@ test_expect_success 'grep --cached searches entries with the SKIP_WORKTREE bit'
>  '
>  
>  # Note that sub2/ is present in the worktree but it is excluded by the sparsity
> -# patterns, so grep should not recurse into it.
> +# patterns.  We also explicitly mark it as SKIP_WORKTREE in case it got cleared
> +# by previous git commands.  Thus sub2 starts as SKIP_WORKTREE but since it is
> +# present in the working tree, grep should recurse into it.
>  test_expect_success 'grep --recurse-submodules honors sparse checkout in submodule' '
>  	cat >expect <<-EOF &&
>  	a:text
>  	sub/B/b:text
> +	sub2/a:text
>  	EOF
> +	git update-index --skip-worktree sub2 &&
>  	git grep --recurse-submodules "text" >actual &&
>  	test_cmp expect actual
>  '

