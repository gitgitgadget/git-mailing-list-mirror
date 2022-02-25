Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50B63C433F5
	for <git@archiver.kernel.org>; Fri, 25 Feb 2022 20:16:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236079AbiBYUQe (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Feb 2022 15:16:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231247AbiBYUQ3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Feb 2022 15:16:29 -0500
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01F0E20239D
        for <git@vger.kernel.org>; Fri, 25 Feb 2022 12:15:56 -0800 (PST)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3573A117527;
        Fri, 25 Feb 2022 15:15:54 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=iUo1OtlAx2Si4H6Mjh5POeWaJ1FufixIBlvAIS
        pqbew=; b=hXi8fVIpeR3CvxH4a2XfxUKypQwrQFajBWleVsgqGTDIcdcVo9Y+87
        lvl54OnXIXX9P/apq7O+kB0GRuLciLXmD4yjOaXRYfMLzCmpaB6N4xJaTNBR5LL1
        PT7grj7G/2DhIJO95jYtA5neFLrqa6BR+vaJ+JniUxUZ1NPuPnR3U=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 269A7117526;
        Fri, 25 Feb 2022 15:15:54 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 697D6117525;
        Fri, 25 Feb 2022 15:15:53 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Tao Klerks via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Tao Klerks <tao@klerks.biz>
Subject: Re: [PATCH v2 1/2] merge: new autosetupmerge option 'simple' for
 matching branches
References: <pull.1161.git.1645695940.gitgitgadget@gmail.com>
        <pull.1161.v2.git.1645815142.gitgitgadget@gmail.com>
        <890e016bfc0809d25a4ae8ae924b23895f520810.1645815142.git.gitgitgadget@gmail.com>
Date:   Fri, 25 Feb 2022 12:15:52 -0800
In-Reply-To: <890e016bfc0809d25a4ae8ae924b23895f520810.1645815142.git.gitgitgadget@gmail.com>
        (Tao Klerks via GitGitGadget's message of "Fri, 25 Feb 2022 18:52:21
        +0000")
Message-ID: <xmqqczjaaeiv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BB9C83F0-9677-11EC-A139-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Tao Klerks via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Tao Klerks <tao@klerks.biz>
>
> This commit introduces a new option to the branch.autosetupmerge
> setting, "simple", which is intended to be consistent with and
> complementary to the push.default "simple" option.

Documentation/SubmittingPatches.

We do not say "This commit does this".  Instead, we say "Add a new
option that does X".  Usually that is done after the explanation of
the status quo is finished to make readers understand what the
problem the change is trying to solve is.  So...

> The push.defaut option "simple" helps produce
> predictable/understandable behavior for beginners, where they don't
> accidentally push to the "wrong" branch in centralized workflows. If
> they create a local branch with a different name and then try to do a
> plain push, it will helpfully fail and explain why.

... this would be a better first paragraph to start the proposed log
message with.

	With push.default set to "simple", the users fork from a
	local branch from a remote-tracking branch of the same name,
	and are protected from a mistake to push to a wrong branch.
	If they create a ... and explain why.

> However, such users can often find themselves confused by the behavior
> of git after they first branch, and before they push. At that stage,

Depending on how they "branch", they may or may not be confused.  Be
more specific to illustrate what problem you are solving, e.g.

	... after they create a new local branch from a
	remote-tracking branch with a different name.

> their upstream tracking branch is the original remote branch, and pull
> will be bringing in "upstream changes" - eg all changes to "main", in
> a typical project where that's where they branched from.

OK.  So "pull" tries to grab from the upstream (which is most likely
an integration branch with bland name like 'master', 'main' or
'trunk'), while "push" does not allow the work on a branch (which is
named after the theme of the work and not a bland name suitable for
integration branches) to be pushed to the upstream.

It may probably not be so clear why it is a problem to many readers,
I suspect.  Isn't that what happens in a typical triangular workflow
to work with a project with a centralized repository?  You fork from
the integration branch shared among project participants, you work on
your own branch, occasionally rebasing on top of the updated upstream,
and when you are done, try to push it out to the integration branch,
and that final leg needs to be explicit to make sure you won't push
out to a wrong branch (in this case, a new branch at the remote with
the same name as your local topic branch) by mistake?

> On the other hand, once they push their new branch (dealing with the
> initial error, following instructions to push to the right name),
> subsequent "pull" calls will behave as expected, only bring in any
> changes to that new branch they pushed.

Is that because the upstream for this local branch is updated?
The "following instructions..." part may want to clarify.

It somehow feels that a better solution might be to suggest
updating the push.default to 'upstream' when it happens?  I dunno.

In any case, now we have explained what happens with today's code,
here is a good place to propose a solution.  Do so in imperative,
e.g.

    Allow branch.autosetupmerge to take a new value, 'simple', which 
    sets the upstream of the new branch only when the local branch
    being created has the same name as the remote-tracking branch it
    was created out of.  Otherwise the new local branch will not get
    any tracking information and 

or something, perhaps?

> +	/*
> +	 * This check does not apply to the BRANCH_TRACK_INHERIT
> +	 * option; you can inherit one or more tracking entries
> +	 * and the tracking.matches counter is not incremented.
> +	 */
>  	if (tracking.matches > 1)
>  		die(_("not tracking: ambiguous information for ref %s"),
>  		    orig_ref);

> +	if (track == BRANCH_TRACK_SIMPLE) {
> +		/*
> +		 * Only track if remote branch name matches.
> +		 * Reaching into items[0].string is safe because
> +		 * we know there is at least one and not more than
> +		 * one entry (because not BRANCH_TRACK_INHERIT).
> +		 */

OK, because in the pre-context of this hunk, we would have jumped to
cleanup: if there were no .matches; so we know there should at least
be one, and we rejected ambiguous matches already, so we know there
is only one.

> +		const char *tracked_branch;
> +		if (!skip_prefix(tracking.srcs->items[0].string,
> +				 "refs/heads/", &tracked_branch) ||
> +		    strcmp(tracked_branch, new_ref))
> +			return;
> +	}

That looks sensible.  Sometimes we do not set tracking information
and just return.
