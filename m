Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07564C433DB
	for <git@archiver.kernel.org>; Mon,  4 Jan 2021 03:03:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC4A6207B7
	for <git@archiver.kernel.org>; Mon,  4 Jan 2021 03:03:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727985AbhADDCp (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 3 Jan 2021 22:02:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726610AbhADDCp (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Jan 2021 22:02:45 -0500
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 111B5C061793
        for <git@vger.kernel.org>; Sun,  3 Jan 2021 19:02:05 -0800 (PST)
Received: by mail-ot1-x32b.google.com with SMTP id a109so24835859otc.1
        for <git@vger.kernel.org>; Sun, 03 Jan 2021 19:02:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VsCSIgT8DFbv5Jwl55YiqVVFx0b5AHv37/4alZjkLmQ=;
        b=h94oHqYopWBFFrm0lwsrOdB5xDfPnW+KI18bACXlwJTFrWW8+1BdKGHVnxgVRi6o2g
         UK1Zrdk/ksSqFMqTz1Cli8X25cimU39mpiOHeHK2sDo7zwRbD3F+rQpyxP3N9XHqoamr
         5iEDJZWX463X3gmaXIyRxU1HkEucNgeVXzuQIogpmlKp/1OakfmaujZgINDIB8qVkKt2
         +wavjsjVsuWe50mcdAT7cDaf9ScjDEM3dT55yqdSZ7s6+vaTXM5qmhrsOV/Up80Gn+j3
         y0YnqV5zSCh5i70KNqboCxBJ2HerFpmBkOLR5XgCcbe1elqZroOn2qI2tp08DOhf+5Fb
         45KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VsCSIgT8DFbv5Jwl55YiqVVFx0b5AHv37/4alZjkLmQ=;
        b=jNDAqMLri0GALxE1UCir2iwaAekz0ISy0SUl8YcJr4tQh27FSVHp1WCmPoWZd47Uo+
         ECl6M60dm7n63A2Jp1NAtDZsYkp8vyRRpaL5sGpZOPEIX2DUd9EW4iDvBfAPmtUVoj/F
         bW1/Vfx75XVmhOFYWLLIe20ICDbWbZj/QyDnf9YPzsOtqr8wBeu4y2z7cYYHkWO+FXmL
         Igzl/PKWBNP9EbeaSOC+I0Okb6ejHMBwbaYcKsHMzs3rpf75EAoNEqucgFREc1VpcRq7
         SmrCew7MEBa81TX51XyMALER4YidGsh2nzvb8AcjnJKuRn1w8isf5ZL5DfGFq/A9UGui
         SlnA==
X-Gm-Message-State: AOAM532mT9QAaQoh0VmAk+WuSE6uA2B+6+KTdTw6tqtVX9lZM13iHNhF
        LsuDR/iKDMx7SH/vEErkmgM=
X-Google-Smtp-Source: ABdhPJzWp9IIITzWL/LUwQSME3i1t/w+Q/8913sl8AReunk0UFi4OINKCVvKLkqYoe/cB+S8Wbtrxg==
X-Received: by 2002:a9d:7a4b:: with SMTP id z11mr51241114otm.305.1609729323802;
        Sun, 03 Jan 2021 19:02:03 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:605d:243e:92dd:9289? ([2600:1700:e72:80a0:605d:243e:92dd:9289])
        by smtp.gmail.com with UTF8SMTPSA id c204sm12828456oob.44.2021.01.03.19.02.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Jan 2021 19:02:02 -0800 (PST)
Subject: Re: sparse-checkout questions and proposals [Was: Re: [PATCH] rm:
 honor sparse checkout patterns]
To:     Elijah Newren <newren@gmail.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
References: <9f2135f90ffea7f4ccb226f506bf554deab324cc.1605205427.git.matheus.bernardino@usp.br>
 <xmqqeekt83fl.fsf@gitster.c.googlers.com>
 <CABPp-BHvZyb4cF29HqDYgMHTMEr2LdvKYATWqADRyhqJzB=Liw@mail.gmail.com>
 <CABPp-BGMX3wb7LiS1HkJpGveoW3J1oR0vVHbKTF5+qYLRF+59g@mail.gmail.com>
 <CABPp-BGJ_Nvi5TmgriD9Bh6eNXE2EDq2f8e8QKXAeYG3BxZafA@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <1a1e33f6-3514-9afc-0a28-5a6b85bd8014@gmail.com>
Date:   Sun, 3 Jan 2021 22:02:02 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:85.0) Gecko/20100101
 Thunderbird/85.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BGJ_Nvi5TmgriD9Bh6eNXE2EDq2f8e8QKXAeYG3BxZafA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/31/2020 3:03 PM, Elijah Newren wrote:
> Sorry for the long delay...

Thanks for bringing us all back to the topic.

>   sparse-checkout's purpose is not fully defined.  Does it exist to:
>     A) allow working on a subset of the repository?
>     B) allow working with a subset of the repository checked out?
>     C) something else?

I think it's all of the above!

My main focus for sparse-checkout is a way for users who care about a
small fraction of a repository's files to only do work on those files.
This saves time because they are asking Git to do less, but also they
can use tools like IDEs that with "Open Folder" options without falling
over. Writing fewer files also affects things like their OS indexing
files for search or antivirus scanning written files.

Others use sparse-checkout to remove a few large files unless they
need them. I'm less interested in this case, myself.

Both perspectives get better with partial clone because the download
size shrinks significantly. While partial clone has a sparse-checkout
style filter, it is hard to compute on the server side. Further, it
is not very forgiving of someone wanting to change their sparse
definition after cloning. Tree misses are really expensive, and I find
that the extra network transfer of the full tree set is a price that is
worth paying.

I'm also focused on users that know that they are a part of a larger
whole. They know they are operating on a large repository but focus on
what they need to contribute their part. I expect multiple "roles" to
use very different, almost disjoint parts of the codebase. Some other
"architect" users operate across the entire tree or hop between different
sections of the codebase as necessary. In this situation, I'm wary of
scoping too many features to the sparse-checkout definition, especially
"git log," as it can be too confusing to have their view of the codebase
depend on your "point of view."

(In case we _do_ start changing behavior in this way, I'm going to use
the term "sparse parallax" to describe users being confused about their
repositories because they have different sparse-checkout definitions,
changing what they see from "git log" or "git diff".)
 
> === Why it matters ==
> 
> There are unfortunately *many* gray areas when you try to define how git
> subcommands should behave in sparse-checkouts.  (The
> implementation-level definition from a decade ago of "files are assumed
> to be unchanged from HEAD when SKIP_WORKTREE is set, and we remove files
> with that bit set from the working directory" definition from the past
> provides no clear vision about how to resolve gray areas, and also leads
> to various inconsistencies and surprises for users.)  I believe a
> definition based around a usecase (or usecases) for the purpose of
> sparse-checkouts would remove most of the gray areas.
> 
> Are there choices other than A & B that I proposed above that make
> sense?  Traditionally, I thought of B as just a partial implementation
> of A, and that A was the desired end-goal.  However, others have argued
> for B as a preferred choice (some users at $DAYJOB even want both A and
> B, meaning they'd like a simple short flag to switch between the two).
> There may be others I'm unaware of.
> 
> git implements neither A nor B.  It might be nice to think of git's
> current behavior as a partial implementation of B (enough to provide
> some value, but still feel buggy/incomplete), and that after finishing B
> we could add more work to allow A.  I'm not sure if the current
> implementation is just a subset of B, though.
> 
> Let's dig in...

I read your detailed message and I think you make some great points.

I think there are three possible situations:

1. sparse-checkout should not affect the behavior at all.

   An example for this is "git commit". We want the root tree to contain
   all of the subtrees and blobs that are out of the sparse-checkout
   definition. The underlying object model should never change.

2. sparse-checkout should change the default, but users can opt-out.

   The examples I think of here are 'git grep' and 'git rm', as we have
   discussed recently. Having a default of "you already chose to be in
   a sparse-checkout, so we think this behavior is better for you"
   should continue to be pursued.

3. Users can opt-in to a sparse-checkout version of a behavior.

   The example in this case is "git diff". Perhaps we would want to see
   a diff scoped only to our sparse definition, but that should not be
   the default. It is too risky to change the output here without an
   explicit choice by the user.

Let's get into your concrete details now:

> === behavioral proposals ===
> 
> Short term version:
> 
>   * en/stash-apply-sparse-checkout: apply as-is.
> 
>   * mt/rm-sparse-checkout: modify it to ignore sparse.restrictCmds --
>       `git rm` should be like `git add` and _always_ ignore
>       SKIP_WORKTREE paths, but it should print a warning (and return
>       with non-zero exit code) if only SKIP_WORKTREE'd paths match the
>       pathspec.  If folks want to remove (or add) files outside current
>       sparsity paths, they can either update their sparsity paths or use
>       `git update-index`.
> 
>   * mt/grep-sparse-checkout: figure out shorter flag names.  Default to
>       --no-restrict-to-sparse, for now.  Then merge it for git-2.31.

I don't want to derail your high-level conversation too much, but by the
end of January I hope to send an RFC to create a "sparse index" which allows
the index to store entries corresponding to a directory with the skip-
worktree bit on. The biggest benefit is that commands like 'git status' and
'git add' will actually change their performance based on the size of the
sparse-checkout definition and not the total number of paths at HEAD.

The other thing that happens once we have that idea is that these behaviors
in 'git grep' or 'git rm' actually become _easier_ to implement because we
don't even have an immediate reference to the blobs outside of the sparse
cone (assuming cone mode).

The tricky part (that I'm continuing to work on, hence no RFC today) is
enabling the part where a user can opt-in to the old behavior. This requires
parsing trees to expand the index as necessary. A simple approach is to
create an in-memory index that is the full expansion at HEAD, when necessary.
It will be better to do expansions in a targeted way.

(Your merge-ort algorithm is critical to the success here, since that doesn't
use the index as a data structure. I expect to make merge-ort the default for
users with a sparse index. Your algorithm will be done first.)

My point in bringing this up is that perhaps we should pause concrete work on
updating other builtins until we have a clearer idea of what a sparse index
could look like and how the implementation would change based on having one
or not. I hope that my RFC will be illuminating in this regard.

Ok, enough of that sidebar. I thought it important to bring up, but 

> Longer term version:
> 
> I'll split these into categories...
> 
> --> Default behavior
>   * Default to behavior B (--no-restrict-to-sparse from
>     mt/grep-sparse-checkout) for now.  I think that's the wrong default
>     for when we marry sparse-checkouts with partial clones, but we only
>     have patches for behavior A for git grep; it may take a while to
>     support behavior A in each command.  Slowly changing behavior of
>     commands with each release is problematic.  We can discuss again
>     after behavior A is fully supported what to make the defaults be.
> 
> --> Commands already working with sparse-checkouts; no known bugs:
>   * status
>   * switch, the "switch" parts of checkout
> 
>   * read-tree
>   * update-index
>   * ls-files
> 
> --> Enhancements
>   * General
>     * shorter flag names than --[no-]restrict-to-sparse.  --dense and
>       --sparse?  --[no-]restrict?

--full-workdir?

>   * sparse-checkout (After behavior A is implemented...)
>     * Provide warning if sparse.restrictCmds not set (similar to git
>       pull's warning with no pull.rebase, or git checkout's warning when
>       detaching HEAD)
>   * clone
>       * Consider having clone set sparse.restrictCmds based on whether
>       --partial is provided in addition to --sparse.

In general, we could use some strategies to help users opt-in to these
new behaviors more easily. We are very close to having the only real
feature of Scalar be that it sets these options automatically, and will
continue to push to the newest improvements as possible.
 
> --> Commands with minor bugs/annoyances:
>   * add
>     * print a warning if pathspec only matches SKIP_WORKTREE files (much
>       as it already does if the pathspec matches no files)
> 
>   * reset --hard
>     * spurious and incorrect warning when removing a newly added file
>   * merge, rebase, cherry-pick, revert
>     * unnecessary unsparsification (merge-ort should fix this)
>   * stash
>     * similar to merge, but there are extra bugs from the pipeline
>       design.  en/stash-apply-sparse-checkout fixes the known issues.
> 
> --> Buggy commands
>   * am
>     * should behave like merge commands -- (1) it needs to be okay for
>       the file to not exist in the working directory; vivify it if
>       necessary, (2) any conflicted paths must remain vivified, (3)
>       paths which merge cleanly can be unvivified.
>   * apply
>     * See am
>   * rm
>     * should behave like add, skipping SKIP_WORKTREE entries.  See comments
>       on mt/rm-sparse-checkout elsewhere
>   * restore
>     * with revisions and/or globs, sparsity patterns should be heeded
>   * checkout
>     * see restore
> 
> --> Commands that need no changes because commits are full-tree:
>   * archive
>   * bundle
>   * commit
>   * format-patch
>   * fast-export
>   * fast-import
>   * commit-tree
> 
> --> Commands that would change for behavior A
>   * bisect
>     * Only consider commits touching paths matching sparsity patterns
>   * diff
>     * When given revisions, only show subset of files matching sparsity
>       patterns.  If pathspecs are given, intersect them with sparsity
>       patterns.
>   * log
>     * Only consider commits touching at least one path matching sparsity
>       patterns.  If pathspecs are given, paths must match both the
>       pathspecs and the sparsity patterns in order to be considered
>       relevant and be shown.
>   * gitk
>     * See log
>   * shortlog
>     * See log
>   * grep
>     * See mt/grep-sparse-checkout; it's been discussed in detail..and is
>       implemented.  (Other than that we don't want behavior A to be the
>       default when so many commands do not support it yet.)
> 
>   * show-branch
>     * See log
>   * whatchanged
>     * See log
>   * show (at least for commits)
>     * See diff
> 
>   * blame
>     * With -C or -C -C, only detect lines moved/copied from files that match
>       the sparsity paths.
>   * annotate
>     * See blame.

this "behavior A" idea is the one I'm most skeptical about. Creating a
way to opt-in to a sparse definition might be nice. It might be nice to
run "git log --simplify-sparse" to see the simplified history when only
caring about commits that changed according to the current sparse-checkout
definitions. Expand that more when asking for diffs as part of that log,
and the way we specify the option becomes tricky.

But I also want to avoid doing this as a default or even behind a config
setting. We already get enough complains about "missing commits" when
someone does a bad merge so "git log -- file" simplifies away a commit
that exists in the full history. Imagine someone saying "on my machine,
'git log' shows the commit, but my colleague can't see it!" I would really
like to avoid adding to that confusion if possible.

> --> Commands whose behavior I'm still uncertain of:
>   * worktree add
>     * for behavior A (marrying sparse-checkout with partial clone), we
>       should almost certainly copy sparsity paths from the previous
>       worktree (we either have to do that or have some kind of
>       specify-at-clone-time default set of sparsity paths)
>     * for behavior B, we may also want to copy sparsity paths from the
>       previous worktree (much like a new command line shell will copy
>       $PWD from the previous one), but it's less clear.  Should it?

I think 'git worktree add' should at minimum continue using a sparse-
checkout if the current working directory has one. Worktrees are a
great way to scale the creation of multiple working directories for
the same repository without re-cloning all of the history. In a partial
clone case, it's really important that we don't explode the workdir in
the new worktree (or even download all those blobs).

Now, should we copy the sparse-checkout definitions, or start with the
"only files at root" default? That's a more subtle question.

>   * range-diff
>     * is this considered to be log-like for format-patch-like in
>       behavior?

If we stick with log acting on the full tree unless specified in the
command-line options, then range-diff can be the same. Seems like a
really low priority, though, because of the proximity to format-patch.

>   * cherry
>     * see range-diff
>   * plumbing -- diff-files, diff-index, diff-tree, ls-tree, rev-list
>     * should these be tweaked or always operate full-tree?
>   * checkout-index
>     * should it be like checkout and pay attention to sparsity paths, or
>       be considered special like update-index, ls-files, & read-tree and
>       write to working tree anyway?
>   * mv
>     * I don't think mv can take a glob, and I think it currently happens to
>       work.  Should we add a comment to the code that if anyone wants to
>       support mv using pathspecs they might need to be careful about
>       SKIP_WORKTREE?
> 
> --> Might need changes, but who cares?
>   * merge-file
>   * merge-index
> 
> --> Commands with no interaction with sparse-checkout:

(I agree with the list you included here.)

Thanks for starting the discussion. Perhaps more will pick it up as
they return from the holiday break.

Thanks,
-Stolee
