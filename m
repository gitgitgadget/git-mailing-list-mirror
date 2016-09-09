Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3688F20710
	for <e@80x24.org>; Fri,  9 Sep 2016 18:23:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753958AbcIISXT (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Sep 2016 14:23:19 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55779 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752151AbcIISXS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Sep 2016 14:23:18 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EC63C3902D;
        Fri,  9 Sep 2016 14:23:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=TIJk9IUo16QCUbFozQDULfkXFzc=; b=CX3TCo
        7DQO03IOk6gPDvSttHSU2glkEkcR5nvje9eTRei5V7ArthISoCpq2dzSFPMMXv6v
        PoWO1ZXgREw4tLPJ0u/MLf6TqeCXDZFKZ0KoiqRT/0ph/an2PV6l/v+zEGFhgps3
        FrAFPSYvxXDz7OHe/OrVyFzgyFtEQnb3Qy5L4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=HGyOxrRW87FBbzF4S8EoCtD+Lg/zR7sF
        H2D/Y2VeSCoO5bMPZKOOSWcrzf6bjGpXXtofGKnnXNrHFkUvstqhtB2JXCxGLjcg
        7fAq9FjCPi13KxtI/hm//fdJ48pGYTy534J1ETQhvMzITMVpmIXFbyvfTFTNUeKo
        hTbfG66FExk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E5AE43902C;
        Fri,  9 Sep 2016 14:23:16 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 696723902B;
        Fri,  9 Sep 2016 14:23:16 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 16/17] lib'ify checkout_fast_forward_to()
References: <cover.1472219214.git.johannes.schindelin@gmx.de>
        <cover.1473431645.git.johannes.schindelin@gmx.de>
        <f624be21280cb2f7624ed7bb4d890903cccf1c7d.1473431645.git.johannes.schindelin@gmx.de>
Date:   Fri, 09 Sep 2016 11:23:14 -0700
In-Reply-To: <f624be21280cb2f7624ed7bb4d890903cccf1c7d.1473431645.git.johannes.schindelin@gmx.de>
        (Johannes Schindelin's message of "Fri, 9 Sep 2016 16:38:00 +0200
        (CEST)")
Message-ID: <xmqqzinhaq5p.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7A04101C-76BA-11E6-A8C4-F7BB12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> Instead of dying there, let the caller high up in the callchain
> notice the error and handle it (by dying, still).
>
> The only callers of checkout_fast_forward_to(), cmd_merge(),
> pull_into_void(), cmd_pull() and sequencer's fast_forward_to(),
> already check the return value and handle it appropriately. With this
> step, we make it notice an error return from this function.
>
> So this is a safe conversion to make checkout_fast_forward_to()
> callable from new callers that want it not to die, without changing
> the external behaviour of anything existing.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---

I'll retitle this to

    sequencer: lib'ify chckout_fast_forward()

and checkout_fast_forward_to() in the second paragraph to match the
reality.  Other than that, the above analysis matches what I see in
the code and the libification done here looks correct.

Thanks.

>  merge.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/merge.c b/merge.c
> index 5db7d56..23866c9 100644
> --- a/merge.c
> +++ b/merge.c
> @@ -57,7 +57,8 @@ int checkout_fast_forward(const unsigned char *head,
>  
>  	refresh_cache(REFRESH_QUIET);
>  
> -	hold_locked_index(lock_file, 1);
> +	if (hold_locked_index(lock_file, 0) < 0)
> +		return -1;
>  
>  	memset(&trees, 0, sizeof(trees));
>  	memset(&opts, 0, sizeof(opts));
> @@ -90,7 +91,9 @@ int checkout_fast_forward(const unsigned char *head,
>  	}
>  	if (unpack_trees(nr_trees, t, &opts))
>  		return -1;
> -	if (write_locked_index(&the_index, lock_file, COMMIT_LOCK))
> -		die(_("unable to write new index file"));
> +	if (write_locked_index(&the_index, lock_file, COMMIT_LOCK)) {
> +		rollback_lock_file(lock_file);
> +		return error(_("unable to write new index file"));
> +	}
>  	return 0;
>  }
