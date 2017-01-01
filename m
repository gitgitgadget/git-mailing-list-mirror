Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 34F0520441
	for <e@80x24.org>; Sun,  1 Jan 2017 02:32:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932081AbdAACaK (ORCPT <rfc822;e@80x24.org>);
        Sat, 31 Dec 2016 21:30:10 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:65368 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932071AbdAACaK (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 31 Dec 2016 21:30:10 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 53C715C42A;
        Sat, 31 Dec 2016 21:30:08 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=vHmy7aLZew74BUjfB6XgGqJLNz4=; b=qSHN/0
        o+M5ZyBkEi+Dqjy44+WutBdQActh+tEgoK5Qrcc7y6dzG/r4kO9XpvcKUAhNEyta
        P7IGrw2fuc3RwgHyvd/0BvS5S5JE48vT13FvXf4U2/qUHz1ELCsB+QRk4DA2DYgN
        S/8LcUV0OHAtXHU/pti7S2rpzD3jOPTcu1nCU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=hIMckTaWeGYqvIC+ez4Gu2MWUJF8dEFY
        FDKO5wln5IipgYCZ5M8owk3aeBBi0XxF8EzmJS9Qg0RiJ651MB5nDbG4AVxEwJJq
        B8gj/dRRKv3MsqK6lMZZ6kT0Rj/PoGtSeew6/IPGMUdi08znioH3WMH0LUMnC8Oc
        U1QRwJ3iu64=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 498635C428;
        Sat, 31 Dec 2016 21:30:07 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5EDE15C417;
        Sat, 31 Dec 2016 21:30:03 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        David Turner <novalis@novalis.org>
Subject: Re: [PATCH v3 21/23] try_remove_empty_parents(): don't accommodate consecutive slashes
References: <cover.1483153436.git.mhagger@alum.mit.edu>
        <c7a89febcbf7bdffb44f8fdf63a43f11339a0289.1483153436.git.mhagger@alum.mit.edu>
Date:   Sat, 31 Dec 2016 18:30:01 -0800
In-Reply-To: <c7a89febcbf7bdffb44f8fdf63a43f11339a0289.1483153436.git.mhagger@alum.mit.edu>
        (Michael Haggerty's message of "Sat, 31 Dec 2016 04:13:01 +0100")
Message-ID: <xmqqvatz4imu.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3366BA6A-CFCA-11E6-9217-06F112518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michael Haggerty <mhagger@alum.mit.edu> writes:

> "refname" has already been checked by check_refname_format(), so it
> cannot have consecutive slashes.

In the endgame state, this has two callers.  Both use what came in
the transaction->updates[] array.  Presumably "has already been
checked by check_refname_format()" says that whoever created entries
in that array must have called the function, but it would be helpful
to be more explicit here.

> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
>  refs/files-backend.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index af5a0e2..397488e 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -2294,15 +2294,14 @@ static void try_remove_empty_parents(const char *refname)
>  	for (i = 0; i < 2; i++) { /* refs/{heads,tags,...}/ */
>  		while (*p && *p != '/')
>  			p++;
> -		/* tolerate duplicate slashes; see check_refname_format() */
> -		while (*p == '/')
> +		if (*p == '/')
>  			p++;
>  	}
>  	q = buf.buf + buf.len;
>  	while (1) {
>  		while (q > p && *q != '/')
>  			q--;
> -		while (q > p && *(q-1) == '/')
> +		if (q > p && *(q-1) == '/')
>  			q--;
>  		if (q == p)
>  			break;
