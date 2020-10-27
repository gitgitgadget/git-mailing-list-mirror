Return-Path: <SRS0=IAqa=EC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB276C4363A
	for <git@archiver.kernel.org>; Tue, 27 Oct 2020 21:38:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9ABD4207E8
	for <git@archiver.kernel.org>; Tue, 27 Oct 2020 21:38:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="bhdjg+kz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S374199AbgJ0ViT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Oct 2020 17:38:19 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:53342 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2506147AbgJ0ViT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Oct 2020 17:38:19 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id CDB2AF05F4;
        Tue, 27 Oct 2020 17:38:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=FUE4RjM/iFdA9o/q5LQJ93zyD2Q=; b=bhdjg+
        kzPM+BjOe44iMWkYD6L0bK/jp7et31EPoy2nE57ZzSXnhvtwvDbVwdY9O4ftWGH+
        0T/yrDpK97xId9uo6tFKz7iRFDWuHgwfE4K1sIWticOypzp7l6ExMBqm53ITTnKP
        p6+dR3GDJ9IDpbTfaU44fc1DRzgFNza1vNNz0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=tZJ5q8PzC4hqRmcRpULeqC/SNOJCv8I7
        Du+7RNAZ2j7EFHWCnv88xuM//oKvpcBh8CB8s1U9vy1PP2hAfbBi6+s+iH/mGtZK
        mygNLsAn44oWR3m/fgkvQtEF9amVg/h/8tH9x0TnXrZBjMZlH29xs5aqtLGKCFNz
        /RDXPJOSEOs=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C7C4CF05F3;
        Tue, 27 Oct 2020 17:38:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 171CDF05F0;
        Tue, 27 Oct 2020 17:38:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] sideband: diagnose more incoming packet anomalies
References: <pull.753.v2.git.1603136142.gitgitgadget@gmail.com>
        <pull.753.v3.git.1603728555.gitgitgadget@gmail.com>
        <20201027065250.GB3005508@coredump.intra.peff.net>
        <20201027071222.GC3005508@coredump.intra.peff.net>
        <xmqqblgncxap.fsf@gitster.c.googlers.com>
        <20201027204205.GA643357@coredump.intra.peff.net>
Date:   Tue, 27 Oct 2020 14:38:12 -0700
In-Reply-To: <20201027204205.GA643357@coredump.intra.peff.net> (Jeff King's
        message of "Tue, 27 Oct 2020 16:42:05 -0400")
Message-ID: <xmqqzh479wor.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B7B6C552-189C-11EB-AF99-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Does this patch seem otherwise worth doing?

Yeah.

FWIW, I do not find the "dependency" thing disturbing.  sideband is
an extension of the pkt-line mechansim, so it is natural that it
depends on pkt-line.  I'd also be happy if enums, structures and
calls defined in both headers are made available by just including
one of them (e.g. retire sideband.h, perhaps).

> An alternate patch would be to keep the behavior the same and just
> clarify the code a bit. Something like:

This also looks OK to me from readability's point of view, but it
does not as much help the end user who is puzzled as the real thing,
I am afraid.

Thanks.

> -- >8 --
> Subject: [PATCH] demultiplex_sideband(): clarify corner cases
>
> The size checks in demultiplex_sideband() are a bit subtle and
> confusing:
>
>   - we consider a zero-length packet ("0004") to be a flush packet, even
>     though it's not really one. This is perhaps wrong, but it should
>     never happen in our protocol, and we err on the side of history and
>     leniency. We'll leave a comment indicating that we expect this case.
>
>   - likewise we consider any flush-like packet (e.g., "0001" delim) to
>     be a flush. I didn't confirm whether this is necessary for normal
>     protocol usage. It may be for the everything-over-sideband mode
>     introduced by 0bbc0bc574 ({fetch,upload}-pack: sideband v2 fetch
>     response, 2019-01-16). Likewise let's leave a comment.
>
>   - we check for "len < 1" to see if there's no sideband designator.
>     That's confusing, because we already covered the "len == 0" case.
>     What is interesting is the "len < 0" case. But that's not a missing
>     sideband designator, but rather an error or EOF from the pkt-line
>     code. This should never happen, though, because our callers instruct
>     pkt-line to die() on EOF anyway. So let's make it more obvious
>     that we're looking for a negative value here, and consider it a
>     BUG() in the caller to pass us garbage.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  sideband.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
>
> diff --git a/sideband.c b/sideband.c
> index 0a60662fa6..6ba1925614 100644
> --- a/sideband.c
> +++ b/sideband.c
> @@ -130,17 +130,18 @@ int demultiplex_sideband(const char *me, char *buf, int len,
>  			suffix = DUMB_SUFFIX;
>  	}
>  
> +	if (len < 0)
> +		BUG("error/eof packet passed to demultiplex_sideband");
> +
>  	if (len == 0) {
> +		/*
> +		 * we treat all flush-like packets (flush, delim, etc) and even
> +		 * empty data packets as a flush
> +		 */
>  		*sideband_type = SIDEBAND_FLUSH;
>  		goto cleanup;
>  	}
> -	if (len < 1) {
> -		strbuf_addf(scratch,
> -			    "%s%s: protocol error: no band designator",
> -			    scratch->len ? "\n" : "", me);
> -		*sideband_type = SIDEBAND_PROTOCOL_ERROR;
> -		goto cleanup;
> -	}
> +
>  	band = buf[0] & 0xff;
>  	buf[len] = '\0';
>  	len--;
