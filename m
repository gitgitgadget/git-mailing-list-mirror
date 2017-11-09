Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 83A5C1F43C
	for <e@80x24.org>; Thu,  9 Nov 2017 05:08:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751114AbdKIFIz (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Nov 2017 00:08:55 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61706 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751096AbdKIFIy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Nov 2017 00:08:54 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 31E6CA0825;
        Thu,  9 Nov 2017 00:08:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=WCrldS9ztYcBsaA4EgAvwwjZKko=; b=D7qTte
        r2XnHJF+PPz2rOsk7++bYb+5STAsQkrQHWJ2AmhVTJAxOgLrqt9vtvTUAnLkT38e
        SzWfAf4Baacleu3zJLaJ7FUfhGG8484CgUdOIB9IxuDipkMwhy5rfNvTa54ypRzf
        PB+WTkyzXTDed9k4Dd/bQpPa/I6t7JJfrV89w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=GwkZWiAfpixeq8IZx/N+oa7qnK48dsI6
        kQbvbvzmX/aX2m1Tc/fpFxra9zIBlVO3TgcTZhkNYut3SRQMGKUY1qBfayyab2SS
        5mSw1s+pwMgpU+14ps29vF5Vz8Pt43gRD4UvSVFkIPs4LnnEMm56QRc/cEGX84Na
        zM/skBpEYyk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 192C3A0823;
        Thu,  9 Nov 2017 00:08:53 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 71F9EA0822;
        Thu,  9 Nov 2017 00:08:52 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     jonathantanmy@google.com, git@vger.kernel.org
Subject: Re: [RFD] Long term plan with submodule refs?
References: <20171108143646.2e1870a82360072557094e01@google.com>
        <20171109001007.11894-1-sbeller@google.com>
Date:   Thu, 09 Nov 2017 14:08:51 +0900
In-Reply-To: <20171109001007.11894-1-sbeller@google.com> (Stefan Beller's
        message of "Wed, 8 Nov 2017 16:10:07 -0800")
Message-ID: <xmqqbmkcjaxo.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 140DAF4C-C50C-11E7-A1CC-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

>> The relationship is indeed currently useful, but if the long term plan
>> is to strongly discourage detached submodule HEAD, then I would think
>> that these patches are in the wrong direction. (If the long term plan is
>> to end up supporting both detached and linked submodule HEAD, then these
>> patches are fine, of course.) So I think that the plan referenced in
>> Junio's email (that you linked above) still needs to be discussed.
>
> This email presents different approaches.
>
> Objective
> =========
> This document should summarize the current situation of Git submodules
> and start a discussion of where it can be headed long term.
> Show different ways in which submodule refs could evolve.
>
> Background
> ==========
> Submodules in Git are considered as an independet repository currently.
> This is okay for current workflows, such as utilizing a library that is
> rarely updated. Other workflows that require a tighter integration between
> submodule and superproject are possible, but cumbersome as there is an
> additional step that has to be performed, which is the update of the gitlink
> pointer in the superproject.

I do not think "rarely updaed" is an issue.

The problem is that we may want to make it easier to use a
superproject and its submodules as if the combined whole were a
single project, which currently is not easy, primarily because
submodules are separate entities with different set of branches that
can be checked out independently from what branch the superproject
is working on.

> Workflows
> =========
> * Obtaining a copy of the Superproject tightly coupled with submodules
>   solved via git clone --recurse-submodules=<pathspec>
> * Changing the submodule selection
>   solved via submodule.active flags
> * Changing the remote / Interacting with a different remote for all submodules
>   -> need to be solved, not core issue of this discussion
> * Syncing to the latest upstream
>   solved via git pull --recurse  
> * Working on a local feature in one submodule
>   -> How do refs work spanning superproject/submodule?
> * Working on a feature spanning multiple submodules
>   -> How do refs work spanning multiple repos?
> * Working on a bug fix (Changing the feature that you currently work on, branches)
>   -> How does switching branches in the superproject affect submodules

These are good starting points for copying such a combined whole to
your local machine and start working on it.  The more interesting,
important, and potentially difficult part is how the result of such
work is shared back to where you started from.  "push --recursive"
may be a simple phrase, but a sensible definition of how it should
work won't be that simple.

> Possible data models and workflow implications
> ==============================================
> In the following different data models are presented, which aid a submodule
> heavy workflow each giving pros and cons.
>
> Keep everything as is, superproject and submodule have their own refs
> ---------------------------------------------------------------------
> ...
> Cons:
>  * Current tools that manage multiple repositories (e.g. repo, git-slave)
>    have "branches in parallel", i.e. each repo has a branch of the same
>    name, instead of using a superproject to manage the state of all repos
>    involved. So users of such tools may be confused by submodules.
>  * when using a detached HEAD in the submodule, we may run into git-gc issues.

We should make detached HEAD safe against gc if it is not,
regardless of the use of submodules.  I thought it already was made
safe long time ago.

> Use replicate refs in submodules
> --------------------------------
> This approach will replicate the superproject refs into the submodule
> ref namespace, e.g. git-branch learns about --recurse-submodules, which
> creates a branch of a given name in all submodules. These (topic) branches
> should be kept in sync with the superproject
>
> Pros:
>  * This seemed intuitive to Gerrit users
>  * 'quick' to implement, most of the commands are already there,
>    just git-branch is needed to have the workflows mentioned above complete.
> Cons:
>  * What does "git checkout -b A B" mean? (special case: B == HEAD)

The command ran at which level?  In the superproject, or in a single
submodule?

>    Is the branch name replicated as a string into the submodule operation,
>    or do we dereference the superprojects gitlink and walk from there?

If they are "kept in sync with the superproject", then there should
be no difference between the two, so I do not see any room for
wondering about that.  In other words, if there is need to worry
about the differences between the above two, then it probably is
fundamentally impossible to keep these in sync, and a design that
assumes it is possible would have to expose glitches to the end-user
experience.

I do not know if glitches resulting from there would be so severe to
be show-stoppers, though.  It might be possible to paper them over.

> No submodule refstore at all
> ----------------------------
> Use refs and commits in the superproject to stitch submodule changes
> together. Disallow branches in the submodule. This is only restricted
> to the working tree inside the superproject, such that the output of git-branch
> changes depending whether the working tree is in- or outside the superproject
> working tree.

This would need enhancement for reachability code, but it feels the
cleanest from the philosophical standpoint---if you want to treat a
superproject and its submodules as if it were a single project,
ability to check out a branch in a submodule that does not match
that of the superproject would only get in the way of preserving the
illusion of "single project"-ness.

> New type of symbolic refs
> =========================
> A symbolic ref can currently only point at a ref or another symbolic ref.
> This proposal showcases different scenarios on how this could change in the
> future.
>
> HEAD pointing at the superprojects index
> ----------------------------------------

This looks to me a mere implementation detail for a (part of)
necessary component to realize the above "No submodule refstore".

> Superproject operations spanning index and worktree
>   E.g. git reset --mixed
> As the submodules HEAD is defined in the index, we would reset it to the
> version in the last commit. As --mixed promises to not touch the working tree,
> the submodules worktree would not be touched. git reset --mixed in the
> superproject is the same as --soft in the submodule.

I am not sure if you want to take these promises low-level "single
repository" plumbing operations make too literally.  "reset --mixed"
may promise not to touch the working tree, but it also promises not
to touch submodules at all.  If you are breaking the latter anyway,
it would make more sense not to be afraid of breaking the former if
it makes sense in the context of allowing the command to do more by
breaking the latter.

