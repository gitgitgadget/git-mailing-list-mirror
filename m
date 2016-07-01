Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-7.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 579812018A
	for <e@80x24.org>; Fri,  1 Jul 2016 15:35:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752428AbcGAPfT (ORCPT <rfc822;e@80x24.org>);
	Fri, 1 Jul 2016 11:35:19 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62613 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751960AbcGAPfR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jul 2016 11:35:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id C8D7B25724;
	Fri,  1 Jul 2016 11:31:38 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MsNso2dnD6/T017aLJZMeYOUYf0=; b=gV4Iut
	qTJPgyw9nea5i5yy65Nl1P2YO58BsTHNbOSPnzlqPclwrNMI5pEwk6q6UYC8FVOb
	X810EkSzUjTPzWD3VHr6LtevgQW8+WvimHFJ5DJj4P2TrSGrnpMjNc0rfblc+6fK
	+K9nMyh0v7iibGJjow/GkiPPvIQdMm8MIv6/8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oRxfaxKlfg+NJuwOsvF9IciU0e1nqPEG
	ga/D++qsX5yLticebSzJwZiC4Z7i2lkVnOk+Y9zmhH/rgVM75tAOHXkMfQYlfP86
	c7GX3jvUfkviSYG8rWNE6M4JY1cY2VZUP77BnOKQNDk0tcgIAbZsplvqWN4JHxR8
	76ytTtPcN7Y=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id C1A9B25722;
	Fri,  1 Jul 2016 11:31:38 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4BF6A25721;
	Fri,  1 Jul 2016 11:31:38 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:	git@vger.kernel.org
Subject: Re: [PATCH 2/9] merge-recursive: clarify code in was_tracked()
References: <cover.1467199553.git.johannes.schindelin@gmx.de>
	<dd3e2cf842fd5e11e31914aa55b8b995e8d3d75c.1467199553.git.johannes.schindelin@gmx.de>
	<xmqq4m8b4zdd.fsf@gitster.mtv.corp.google.com>
	<alpine.DEB.2.20.1607011057180.12947@virtualbox>
Date:	Fri, 01 Jul 2016 08:31:36 -0700
In-Reply-To: <alpine.DEB.2.20.1607011057180.12947@virtualbox> (Johannes
	Schindelin's message of "Fri, 1 Jul 2016 11:23:47 +0200 (CEST)")
Message-ID: <xmqq7fd51ijr.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E6F0B37A-3FA0-11E6-B9E3-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> I agree that the comment is not very good currently. But I disagree that
> we are better off without any comment here.

I meant we are better off without your particular version of comment
which is misleading.  I am all for a better comment to help those
who are new to the codepath.

> I would like to propose this diff instead (it is larger, but with a net
> savings of one line):
>
> -- snipsnap --
> diff --git a/merge-recursive.c b/merge-recursive.c
> index d5a593c..0eda51a 100644
> --- a/merge-recursive.c
> +++ b/merge-recursive.c
> @@ -658,24 +658,22 @@ static int was_tracked(const char *path)
>  {
>  	int pos = cache_name_pos(path, strlen(path));
>  
> -	if (pos < 0)
> -		pos = -1 - pos;
> -	while (pos < active_nr &&
> -	       !strcmp(path, active_cache[pos]->name)) {
> +	if (pos >= 0)
> +		return pos < active_nr;
> +	/*
> +	 * cache_name_pos() looks for stage == 0, even if we did not ask for
> +	 * it. Let's look for stage == 2 now.
> +	 */

I think this keeps the same phrasing from the original that makes
the comment misleading.  It "looks for stage == 0" is not the whole
story but only half.  It looks for a place to insert the path at
stage #0" is.  Your half is used by the "if (0 <= pos)" you split
out into a separate statement above already, and the untold half is
needed to explain why this loop is correct.

It returns the place to insert stage #0 entry, so if you are looking
for stage #1 or higher, you only have to loop while the path
matches, because the entries are sorted by <path, stage>.

And with that understanding, there is no strong reason to special
case "ah, we found stage #0 entry" at all.

> +	for (pos = -1 - pos; pos < active_nr &&
> +	     !strcmp(path, active_cache[pos]->name); pos++)
>  		/*
>  		 * If stage #0, it is definitely tracked.
>  		 * If it has stage #2 then it was tracked
>  		 * before this merge started.  All other
>  		 * cases the path was not tracked.
>  		 */
> -		switch (ce_stage(active_cache[pos])) {
> -		case 0:
> -		case 2:
> +		if (ce_stage(active_cache[pos]) == 2)
>  			return 1;
> -		}
> -		pos++;
> -	}
>  	return 0;
>  }
>  
