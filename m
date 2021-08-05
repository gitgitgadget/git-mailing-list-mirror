Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15CEDC4338F
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 22:08:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECAE760462
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 22:08:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231537AbhHEWIY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Aug 2021 18:08:24 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:61521 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230445AbhHEWIX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Aug 2021 18:08:23 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 964BC13BABA;
        Thu,  5 Aug 2021 18:08:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=D7cNovbwW7wTI1DiR0p7XGIhIpx81631O9e+sQ
        qy62Y=; b=cBpxvbLDalZPFAGetKz+3Il1iruiggOwpNjd8VsexpPUzWM/sgwjTe
        9R3QI4XkGpYdW7uTIa1lD8wQFggnaMDp4zkizFnOuhDJLglYKLuPHSfcqDk50FQ+
        eNu+J2OcdbseEg6IMTraAucFNwF5FABURTMPmJInUiyvq+9L3ijco=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8313613BAB5;
        Thu,  5 Aug 2021 18:08:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.71.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A9B3113BA80;
        Thu,  5 Aug 2021 18:08:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>, git@vger.kernel.org
Subject: Re: [PATCH] diff: drop unused options parameter from
 cmp_in_block_with_wsd()
References: <YQxOevw7Q+NYX2YF@coredump.intra.peff.net>
Date:   Thu, 05 Aug 2021 15:08:04 -0700
In-Reply-To: <YQxOevw7Q+NYX2YF@coredump.intra.peff.net> (Jeff King's message
        of "Thu, 5 Aug 2021 16:47:54 -0400")
Message-ID: <xmqqa6lvk0jf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9C1474C2-F639-11EB-B247-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> When 8e809cbb2f (diff --color-moved-ws=allow-indentation-change:
> simplify and optimize, 2021-07-20) stopped looking at o->emitted_symbols
> and instead took the symbol as a parameter, we no longer need to look at
> the diff_options struct at all.
>
> Dropping the unused parameter makes it clear that the function is
> independent of the diff options.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> Just a small cleanup on top of pw/diff-color-moved-fix, which is now in
> 'next'. I noticed due to my -Wunused-parameters patches (which one day
> I'll finally clean up enough to send to the list).

Nice.

>
>  diff.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/diff.c b/diff.c
> index 2956c8f710..164af13b4f 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -863,8 +863,7 @@ static int compute_ws_delta(const struct emitted_diff_symbol *a,
>  	return a_width - b_width;
>  }
>  
> -static int cmp_in_block_with_wsd(const struct diff_options *o,
> -				 const struct moved_entry *cur,
> +static int cmp_in_block_with_wsd(const struct moved_entry *cur,
>  				 const struct emitted_diff_symbol *l,
>  				 struct moved_block *pmb)
>  {
> @@ -1016,7 +1015,7 @@ static void pmb_advance_or_null(struct diff_options *o,
>  		if (o->color_moved_ws_handling &
>  		    COLOR_MOVED_WS_ALLOW_INDENTATION_CHANGE)
>  			match = cur &&
> -				!cmp_in_block_with_wsd(o, cur, l, &pmb[i]);
> +				!cmp_in_block_with_wsd(cur, l, &pmb[i]);
>  		else
>  			match = cur && cur->es->id == l->id;
