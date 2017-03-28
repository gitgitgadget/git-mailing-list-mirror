Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EEDC61FAFB
	for <e@80x24.org>; Tue, 28 Mar 2017 19:40:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755741AbdC1Tkw (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Mar 2017 15:40:52 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50903 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755648AbdC1Tkv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2017 15:40:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BD4A777BE6;
        Tue, 28 Mar 2017 15:40:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=5Dw2JQDbX9YAivMx0aSclhimLek=; b=rKSDga
        cT1E9k/GblKETNU0jXXp0JVH1GPFSosrrkhqLZ4WpUUde40sWamBxPlMPfalEzL/
        LFIF/mydJ/EPO7nzLbW4dD07aMjg4yhYN9wWflF2UTukxwFCyeqbuzIeLmHJqLWy
        E7IT5eFzN6GadfXgRDTvHCNe1fObdlvaCbgG8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Vz/3iKD9CyGmChCoffj7cb8/wnk1hDD+
        TzEGsDOOOaNnCBU0LayI+/NxFTqRdQgGWjqjHmR/Fvu64JCV3db2v1S4K1QVal20
        0cDPkqnoa/qvlFqrKTVSmEbNpp1LVuNo9BJcaYKv1YUJvYQ13PwlfXoISSvdIs7L
        AcgRkkqCfGg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B661477BE5;
        Tue, 28 Mar 2017 15:40:34 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C370677BE4;
        Tue, 28 Mar 2017 15:40:30 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH v2 00/21] object_id part 7
References: <20170326160143.769630-1-sandals@crustytoothpaste.net>
        <20170328073159.k3xemw6auh3iedgs@sigill.intra.peff.net>
        <20170328111315.i6rhhy4pj6hhf4bs@genre.crustytoothpaste.net>
        <20170328173536.ylwesrj7jbreztcy@sigill.intra.peff.net>
        <20170328174214.t5szqndtf4bwsnhz@sigill.intra.peff.net>
Date:   Tue, 28 Mar 2017 12:40:29 -0700
In-Reply-To: <20170328174214.t5szqndtf4bwsnhz@sigill.intra.peff.net> (Jeff
        King's message of "Tue, 28 Mar 2017 13:42:14 -0400")
Message-ID: <xmqqfuhxchqq.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 66EE0EFC-13EE-11E7-8393-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Here's that minor tweak, in case anybody is interested. It's less useful
> without that follow-on that touches "eol" more, but perhaps it increases
> readability on its own.

Yup, the only thing that the original (with Brian's fix) appears to
be more careful about is it tries very hard to avoid setting boc
past eoc.  As we are not checking "boc != eoc" but doing the
comparison, that "careful" appearance does not give us any benefit
in practice, other than having to do an extra "eol ? eol+1 : eoc";
the result of this patch is easier to read.

By the way, eoc is "one past the end" of the array that begins at
boc, so setting a pointer to eoc+1 may technically be in violation.
I do not know how much it matters, though ;-)

> -- >8 --
> Subject: [PATCH] receive-pack: simplify eol handling in cert parsing
>
> The queue_commands_from_cert() function wants to handle each
> line of the cert individually. It looks for "\n" in the
> to-be-parsed bytes, and special-cases each use of eol (the
> end-of-line variable) when we didn't find one.  Instead, we
> can just set the end-of-line variable to end-of-cert in the
> latter case.
>
> For advancing to the next line, it's OK for us to move our
> pointer past end-of-cert, because our loop condition just
> checks for pointer inequality. And it doesn't even violate
> the ANSI C "no more than one past the end of an array" rule,
> because we know in the worst case we've hit the terminating
> NUL of the strbuf.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  builtin/receive-pack.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
> index 5d9e4da0a..58de2a1a9 100644
> --- a/builtin/receive-pack.c
> +++ b/builtin/receive-pack.c
> @@ -1524,8 +1524,10 @@ static void queue_commands_from_cert(struct command **tail,
>  
>  	while (boc < eoc) {
>  		const char *eol = memchr(boc, '\n', eoc - boc);
> -		tail = queue_command(tail, boc, eol ? eol - boc : eoc - boc);
> -		boc = eol ? eol + 1 : eoc;
> +		if (!eol)
> +			eol = eoc;
> +		tail = queue_command(tail, boc, eol - boc);
> +		boc = eol + 1;
>  	}
>  }
