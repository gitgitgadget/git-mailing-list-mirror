Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DD63C433F5
	for <git@archiver.kernel.org>; Fri,  3 Sep 2021 20:32:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4EB25610A1
	for <git@archiver.kernel.org>; Fri,  3 Sep 2021 20:32:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350692AbhICUdj (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Sep 2021 16:33:39 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:59743 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350575AbhICUdj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Sep 2021 16:33:39 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id AE8B515FFA0;
        Fri,  3 Sep 2021 16:32:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=mj4OR6FsmDPg
        +6YS7w8/vS8Wh8G2XvuTyqr8MI1oU6k=; b=vco7u1guQuGtfXlAqQOEOqqfZdqp
        rLrXEj3tFo6LH70zyjIn0FfvvR/qLnul0hhm659yIjM6PWGykIJVqoapTflxxkse
        t4nbOru22nuCZmb5HId6hac6in+b4WMbT82nhFroviFtIqCy75xLV0u0MK0l9f6T
        y7BwvcbV9hBw3PQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A724E15FF9F;
        Fri,  3 Sep 2021 16:32:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id EB92E15FF9D;
        Fri,  3 Sep 2021 16:32:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>, git@vger.kernel.org,
        peff@peff.net, avarab@gmail.com, phillip.wood@dunelm.org.uk,
        sunshine@sunshineco.com
Subject: Re: [PATCH v3 2/3] win32: allow building with pedantic mode enabled
References: <20210901091941.34886-1-carenas@gmail.com>
        <20210903170232.57646-1-carenas@gmail.com>
        <20210903170232.57646-3-carenas@gmail.com>
        <bc4789a0-ae80-c1dd-35b1-86949a807490@web.de>
        <YTKBzi3z5AotirNO@carlos-mbp.lan>
Date:   Fri, 03 Sep 2021 13:32:34 -0700
In-Reply-To: <YTKBzi3z5AotirNO@carlos-mbp.lan> ("Carlo Marcelo Arenas
 =?utf-8?Q?Bel=C3=B3n=22's?=
        message of "Fri, 3 Sep 2021 13:13:02 -0700")
Message-ID: <xmqq7dfxfli5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 12E016D8-0CF6-11EC-8197-9BA3EF469F85-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com> writes:

>> A slightly shorter fix would be to replace "tck" with "mem".  Not as
>> obvious without further context, though.
>
> so something like this on top?

> Carlo
> ---- > 8 ----
> diff --git a/compat/nedmalloc/nedmalloc.c b/compat/nedmalloc/nedmalloc.=
c
> index edb438a777..14e8c4df4f 100644
> --- a/compat/nedmalloc/nedmalloc.c
> +++ b/compat/nedmalloc/nedmalloc.c
> @@ -510,7 +510,15 @@ static void threadcache_free(nedpool *p, threadcac=
he *tc, int mymspace, void *me
>  	assert(idx<=3DTHREADCACHEMAXBINS);
>  	if(tck=3D=3D*binsptr)
>  	{
> -		fprintf(stderr, "Attempt to free already freed memory block %p - abo=
rting!\n", (void *)tck);
> +		/*
> +		 * Original code used tck instead of mem, but that was changed
> +		 * to workaround a pedantic warning from mingw64 gcc 10.3 that
> +		 * requires %p to have a explicit (void *) as a parameter.
> +		 *
> +		 * This might seem to be a compiler bug or limitation that
> +		 * should be changed back if fixed for maintanability.
> +		 */
> +		fprintf(stderr, "Attempt to free already freed memory block %p - abo=
rting!\n", mem);
>  		abort();
>  	}

The new comment explains why the original (i.e. unadorned 'tck'),
which should work fine, needs to be changed.  The reason is because
a version of compiler wants an explict (void *) cast to go with the
placeholder "%p".

Given that, it would be much better to pass (void *)tck instead of
mem, no?  Especially since the comment does not say tck and mem have
the same pointer value.

Having said lal that, I have to wonder if how much help the
developer who is hunting for allocation bug is getting out of a raw
pointer value in this message, though.

