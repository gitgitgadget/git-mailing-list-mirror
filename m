Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D96EBC433FE
	for <git@archiver.kernel.org>; Tue,  1 Feb 2022 18:35:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238965AbiBASfW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Feb 2022 13:35:22 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:62537 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbiBASfW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Feb 2022 13:35:22 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E42FB173D5B;
        Tue,  1 Feb 2022 13:35:21 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4JXpyziAZs94msBt31ZuFxV1xzHTZtlaUIVJT3
        BojG8=; b=FuF8tVM+rq+hyicW/SbBgxWl3qSjkdvdxihtYQHYZUf1gKkDrRG50/
        3Pc+qNAZ7L0fk2YvxEyWUez1Qthj1Dgd7UwzhqfJ3HYHukWKWv/7Fr1oU9V3vU6A
        0XeRfw4pTib0qPhqCVTgBODtFO1dLFGyOaKcYDgDsB8yVkYm+YYis=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id DCCFA173D5A;
        Tue,  1 Feb 2022 13:35:21 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 5C286173D59;
        Tue,  1 Feb 2022 13:35:19 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v3 3/3] repo-settings: name the default
 fetch.negotiationAlgorithm 'consecutive'
References: <pull.1131.v2.git.1643478692337.gitgitgadget@gmail.com>
        <pull.1131.v3.git.1643734828.gitgitgadget@gmail.com>
        <7b28c527a907c81c3d3d8a6a54d5c713cef4f2a0.1643734828.git.gitgitgadget@gmail.com>
Date:   Tue, 01 Feb 2022 10:35:18 -0800
In-Reply-To: <7b28c527a907c81c3d3d8a6a54d5c713cef4f2a0.1643734828.git.gitgitgadget@gmail.com>
        (Elijah Newren via GitGitGadget's message of "Tue, 01 Feb 2022
        17:00:28 +0000")
Message-ID: <xmqqleyue8pl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B51E4F92-838D-11EC-8373-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Elijah Newren <newren@gmail.com>
>
> Give the default fetch.negotiationAlgorithm the name 'consecutive' and
> update the documentation accordingly.  Since there may be some users
> using the name 'default' for this behavior, retain that name for now.
> We do not want to use that name indefinitely, though, because if
> 'skipping' becomes the default, then the "default" behavior will not be
> the default behavior, which would be confusing.

This is probably where we still disagree after the review exchange
for the previous round.

I view the act of setting this variable to 'default' by the user as
saying "let Git choose whatever is appropriate for me, which may
change over time as the Git project gains more insight".  In that
world view, 'default' that changes the behaviour with newer versions
of Git, or when 'feature.experimental' is set/unset, is a desirable
outcome.

>  fetch.negotiationAlgorithm::
> +	Control how information about the commits in the local repository
> +	is sent when negotiating the contents of the packfile to be sent by
> +	the server.  Set to "consecutive" to use an algorithm that walks
> +	over consecutive commits checking each one.  Set to "skipping" to
> +	use an algorithm that skips commits in an effort to converge
> +	faster, but may result in a larger-than-necessary packfile; or set
> +	to "noop" to not send any information at all, which will almost
> +	certainly result in a larger-than-necessary packfile, but will skip
> +	the negotiation step.  The default is normally "consecutive", but
> +	if `feature.experimental` is true, then the default is "skipping".

So, in my worldview, this statement is needed:

    Set to "default" to override settings made previously and use
    the default behaviour.

but of course if you do not want to allow a "dear Git, please choose
for me appropriately" setting, such a statement contradicts with it.

And with the design in the patch, next person who notices the code
accepts another value that is not documented will suggest an update
to the documentation:

    The default is "consecutive" but "skipping" is used when
    feature.experimental is set.  Setting it to "default" is the
    same as setting it to "consecutive".

which looks quite confusing, no?

> diff --git a/repo-settings.c b/repo-settings.c
> index 41e1c30845f..e984075df12 100644
> --- a/repo-settings.c
> +++ b/repo-settings.c
> @@ -26,7 +26,7 @@ void prepare_repo_settings(struct repository *r)
>  	/* Defaults */
>  	r->settings.index_version = -1;
>  	r->settings.core_untracked_cache = UNTRACKED_CACHE_KEEP;
> -	r->settings.fetch_negotiation_algorithm = FETCH_NEGOTIATION_DEFAULT;
> +	r->settings.fetch_negotiation_algorithm = FETCH_NEGOTIATION_CONSECUTIVE;
>  
>  	/* Booleans config or default, cascades to other settings */
>  	repo_cfg_bool(r, "feature.manyfiles", &manyfiles, 0);
> @@ -85,8 +85,9 @@ void prepare_repo_settings(struct repository *r)
>  			r->settings.fetch_negotiation_algorithm = FETCH_NEGOTIATION_SKIPPING;
>  		else if (!strcasecmp(strval, "noop"))
>  			r->settings.fetch_negotiation_algorithm = FETCH_NEGOTIATION_NOOP;
> -		else if (!strcasecmp(strval, "default"))
> -			r->settings.fetch_negotiation_algorithm = FETCH_NEGOTIATION_DEFAULT;
> +		else if (!strcasecmp(strval, "consecutive") ||
> +			 !strcasecmp(strval, "default"))
> +			r->settings.fetch_negotiation_algorithm = FETCH_NEGOTIATION_CONSECUTIVE;
>  		else
>  			die("unknown fetch negotiation algorithm '%s'", strval);
>  	}

So, I am not sure this is a good idea.
