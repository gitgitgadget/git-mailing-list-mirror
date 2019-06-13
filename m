Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB5EF1F462
	for <e@80x24.org>; Thu, 13 Jun 2019 17:56:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbfFMR4h (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jun 2019 13:56:37 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56605 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbfFMR4h (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jun 2019 13:56:37 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D7B3E15A385;
        Thu, 13 Jun 2019 13:56:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=2+Np/Xgi7o93ahGb6wvE3HmnuPQ=; b=LWfKae
        0ZwN86zkALA2eBdB6KsUD9f9XmGUfYqAH5Mtsfugc5tRIKXRcZf2ogqJkx/q0eoV
        UgqiMwx4BjkZP4QNfDUaMkrWEFViAaEEmTiTmvvn/0VzPvABe6upR4gr6ULTJE0h
        oySIWIbIFdCmNqQDQ9jejN2iIdwfipbwxv9kw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=j9QvaGqtcNlCfncDbpdKTLm74Z6yVQAa
        +ty4p2/u3QEKWYOHJD9QfPnbv6z2F/zrnDEefrqWwuOBSIxQDrzg9zQh+hZecDNP
        nJx3uM+qnhUOi/5W4IgYLDjNkQTV4LHT6ZXJzJDqRwZJEBAdLqB9xk4/7kIbag/5
        L6Gw1RzGOVE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CEDDA15A384;
        Thu, 13 Jun 2019 13:56:27 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3EDBA15A382;
        Thu, 13 Jun 2019 13:56:27 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Cc:     git@vger.kernel.org, newren@gmail.com, t.gummerer@gmail.com,
        phillip.wood123@gmail.com
Subject: Re: [GSoC][PATCH v3 2/3] cherry-pick/revert: add --skip option
References: <20190608191958.4593-1-rohit.ashiwal265@gmail.com>
        <20190613040504.32317-1-rohit.ashiwal265@gmail.com>
        <20190613040504.32317-3-rohit.ashiwal265@gmail.com>
Date:   Thu, 13 Jun 2019 10:56:26 -0700
In-Reply-To: <20190613040504.32317-3-rohit.ashiwal265@gmail.com> (Rohit
        Ashiwal's message of "Thu, 13 Jun 2019 09:35:03 +0530")
Message-ID: <xmqqa7elwer9.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 90DA29B6-8E04-11E9-B119-46F8B7964D18-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rohit Ashiwal <rohit.ashiwal265@gmail.com> writes:

> diff --git a/Documentation/git-cherry-pick.txt b/Documentation/git-cherry-pick.txt
> index 754b16ce0c..955880ab88 100644
> --- a/Documentation/git-cherry-pick.txt
> +++ b/Documentation/git-cherry-pick.txt
> @@ -10,9 +10,7 @@ SYNOPSIS
>  [verse]
>  'git cherry-pick' [--edit] [-n] [-m parent-number] [-s] [-x] [--ff]
>  		  [-S[<keyid>]] <commit>...
> -'git cherry-pick' --continue
> -'git cherry-pick' --quit
> -'git cherry-pick' --abort
> +'git cherry-pick' --continue | --skip | --abort | --quit

Is this correct, or do we need to enclose these choices inside (),
i.e.

	'git cherry-pick' ( --continue | --skip | --abort | --quit )

?  

> -static int rollback_single_pick(struct repository *r)
> +static int rollback_single_pick(struct repository *r, unsigned int is_skip)
>  {
>  	struct object_id head_oid;
>  
>  	if (!file_exists(git_path_cherry_pick_head(r)) &&
> -	    !file_exists(git_path_revert_head(r)))
> +	    !file_exists(git_path_revert_head(r)) && !is_skip)
>  		return error(_("no cherry-pick or revert in progress"));
>  	if (read_ref_full("HEAD", 0, &head_oid, NULL))
>  		return error(_("cannot resolve HEAD"));
> -	if (is_null_oid(&head_oid))
> +	if (is_null_oid(&head_oid) && !is_skip)
>  		return error(_("cannot abort from a branch yet to be born"));
>  	return reset_for_rollback(&head_oid);
>  }

It is unclear *why* the function (and more importantly, its callers)
would want to omit two sanity checks when is_skip is in effect.

Before this patch introduced such conditional behaviour, the name
was descriptive enough for this single-purpose function that is a
file-local helper, but it is no longer a case.  The function needs a
bit of commentary before it.

When &&-chaining error checks that are optional, check the condition
that makes the error checks optional first, i.e.

	if (!is_skip &&
		!file_exists(...) && !file_exists(...))
		return error(...);

The same comment applies to the "do not barf by checking is-null-oid
under is-skip mode, as that is a sign that we are on an unborn
branch and reset-for-rollback knows how to handle it now".

It may even be a good idea to group the checks that are guarded by
the condition for readability, i.e.

	if (!is_skip &&
		(!file_exists(...) && !file_exists(...)))
		return error(...);

> +int sequencer_skip(struct repository *r, struct replay_opts *opts)
> +{
> +	enum replay_action action = -1;
> +	sequencer_get_last_command(r, &action);
> +
> +	switch (opts->action) {
> +	case REPLAY_REVERT:
> +		if (!file_exists(git_path_revert_head(r))) {
> +			if (action == REPLAY_REVERT) {
> +				if (!rollback_is_safe())
> +					goto give_advice;
> +				else
> +					break;
> +			}
> +			return error(_("no revert in progress"));
> +		}

This part probably deserves a bit of in-code comment.  

    The Git subcommand (i.e. opts->action) tells us that we are
    asked to "git revert --skip".  When REVERT_HEAD is not there, we
    look at the last command of the sequencer state and make sure it
    is 'revert'; all other cases we barf.

That much we can read from the code.  But what are "all other cases"?
Do we cover a single-revert case (i.e. "git revert <commit>" got
conflict and the user is saying "git revert --skip")?  Was the user
in the middle of "git rebase -i" and the last command before we gave
the control back was 'pick'?

> +		break;
> +	case REPLAY_PICK:
> +		if (!file_exists(git_path_cherry_pick_head(r))) {
> +			if (action == REPLAY_PICK) {
> +				if (!rollback_is_safe())
> +					goto give_advice;
> +				else
> +					break;
> +			}
> +			return error(_("no cherry-pick in progress"));
> +		}
> +		break;
> +	default:
> +		BUG("the control must not reach here");
> +	}
> +
> +	if (rollback_single_pick(r, 1))
> +		return error(_("failed to skip the commit"));

And this takes us back to the previous comment.  By passing '1'
here, this caller is asking the callee to omit certain sanity check
the original version of the callee used to do.  What makes it an
appropriate thing to do so here?  "Because we reach at this point
under such and such condition, we would never have CHERRY_PICK_HEAD
or REVERT_HEAD---we do not want it to barf" is a good answer (and
no, do not merely give answer to me in your response---write the
answer as in-code comment to help future readers of the code).

"Because when we come here, sometimes the XXX_HEAD must exist but
some other times XXX_HEAD may not exist, so insisting that either
exists would make the function fail" is *NOT* a good answer, on the
other hand.  Somebody must still check that the necessary file
exists when it must exist.

Thanks.
