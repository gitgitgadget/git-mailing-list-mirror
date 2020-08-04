Return-Path: <SRS0=W4Po=BO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25FB1C433DF
	for <git@archiver.kernel.org>; Tue,  4 Aug 2020 19:30:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB865206DA
	for <git@archiver.kernel.org>; Tue,  4 Aug 2020 19:30:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="FAFMPtMm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727015AbgHDTaT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Aug 2020 15:30:19 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:62968 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbgHDTaR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Aug 2020 15:30:17 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 99F11D58F7;
        Tue,  4 Aug 2020 15:30:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=JdKwJRnoIeAjT4ePNu6DuSi1Axc=; b=FAFMPt
        MmXYwziDWnIB9GxH5F+BDXvX98CY1I8f1gKo0HarvbUZ4IwKglrR05DRVBWg8+RU
        UYrchaLPNAKsgq5/C+nxJNG/dUjZOva14T8nyXpOqmH2HeeiHrTmGhTT++pP4urf
        GI/RMLfbIvzOD7hW0ML/4CiRdC9vjx6X2k5lo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=s0FBJNULPUQfoWWl5wSPj2+Bo08JIKFN
        lCuYFeR6bSUtyeJrvqA4oTtvf1OuezyjMWmzL7Xl6eta+vx4Y2eXiwa9h8TZpAUj
        iLNLbz6n+FTj6mCHOqknXVWMmGCpsJpmz5clQLwvkC1QAdT4DBLK4WxpoYH0XpxW
        jAP0OPGv/U4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 938F9D58F6;
        Tue,  4 Aug 2020 15:30:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D492CD58ED;
        Tue,  4 Aug 2020 15:30:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Raymond E. Pasco" <ray@ameretat.dev>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] apply: Allow "new file" patches on i-t-a entries
References: <20200804163320.61167-1-ray@ameretat.dev>
Date:   Tue, 04 Aug 2020 12:30:09 -0700
In-Reply-To: <20200804163320.61167-1-ray@ameretat.dev> (Raymond E. Pasco's
        message of "Tue, 4 Aug 2020 12:33:20 -0400")
Message-ID: <xmqqlfiuryym.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E974C09A-D688-11EA-A0AB-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Raymond E. Pasco" <ray@ameretat.dev> writes:

> Subject: Re: [PATCH] apply: Allow "new file" patches on i-t-a entries

Please downcase "A"llow.

> diff-files recently changed to treat "intent to add" entries as new file
> diffs rather than diffs from the empty blob. However, apply refuses to
> apply new file diffs on top of existing index entries, except in the
> case of renames. This causes "git add -p", which uses apply, to fail
> when attempting to stage hunks from a file when intent to add has been
> recorded.
>
> This adds an additional check to check_to_create() which tests if the
> CE_INTENT_TO_ADD flag is set on an existing index entry, and allows the
> apply to proceed if so.
> ---

Please sign-off your patch (see Documentation/SubmittingPatches)

> cf. <5BDF4B85-7AC1-495F-85C3-D429E3E51106@gmail.com>
>  apply.c | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)
>
> diff --git a/apply.c b/apply.c
> index 8bff604dbe..b31bd0e866 100644
> --- a/apply.c
> +++ b/apply.c
> @@ -3747,10 +3747,20 @@ static int check_to_create(struct apply_state *state,
>  {
>  	struct stat nst;
>  
> -	if (state->check_index &&
> -	    index_name_pos(state->repo->index, new_name, strlen(new_name)) >= 0 &&
> -	    !ok_if_exists)
> -		return EXISTS_IN_INDEX;
> +	if (state->check_index) {
> +		struct cache_entry *ce = NULL;
> +		int intent_to_add;
> +		int pos = index_name_pos(state->repo->index, new_name, strlen(new_name));
> +		if (pos >= 0)
> +			ce = state->repo->index->cache[pos];
> +		if (ce && (ce->ce_flags & CE_INTENT_TO_ADD))
> +			intent_to_add = 1;
> +		else
> +			intent_to_add = 0;
> +		if (pos >= 0 && !intent_to_add && !ok_if_exists)
> +			return EXISTS_IN_INDEX;
> +	}
> +

I think the new logic looks sound.  When we are applying a patch
that adds a new path, we do not want the path to already exist, so
we used to see if there is an existign cache entry with that name
and barfed if there is.  The spirit of the new code is the same,
except that we want to treat an i-t-a entry as "not yet exist".

How often do we pass ok_if_exists, I have to wonder.  If it is often
enough, then we can check that first way before we even check to see
if a cache entry for the path even exists or what its i-t-a flag
says.  Something along the lines of this untested code:

	if (state->check_index && !ok_if_exists) {
		int pos = index_name_pos(state->repo->index, new_name, strlen(new_name));
		if (pos >= 0 &&
		    !(state->repo->index->cache[pos]->ce_flags & CE_INTENT_TO_ADD))
			return EXISTS_IN_INDEX;
	}

That is, only if we are told to make sure the path does not already exist,
we see if the path is in the index, and if the cache entry for the
path in the index is a real entry (as opposed to i-t-a aka "not
added yet"), we complain.  Otherwise we'd happily take the patch.

Whether ok_if_exists is frequently used or not, the resulting code
may be easier to understand, but I am of course biased, as I just
wrote it ;-)

Hmm?

Thanks.

>  	if (state->cached)
>  		return 0;
