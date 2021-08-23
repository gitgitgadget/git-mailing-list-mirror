Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9C48C4338F
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 22:30:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B969261368
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 22:30:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233038AbhHWWbA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Aug 2021 18:31:00 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:53681 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbhHWWa7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Aug 2021 18:30:59 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 695DB149226;
        Mon, 23 Aug 2021 18:30:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Q1QWfVvAKweQ
        jC/+KtwpWmIPlmtajCvGJMDJNGQsx/Q=; b=H5VHVQBWXLeFYeB8J7XAZP3pYPMM
        bxZ+3djzaZyEc5seSXz3c1uRIXHC+og5D5ND8wukv7/DUWk6zPjMa9kalvx9gnY7
        b5WfBxwTKp4AmIBTQBC+gf24u+63JeFxl6OH3BrrJpXyiNDvr6aCkmqdc8LTg0jl
        0epLaSTQHVAEVIs=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5FE2E149225;
        Mon, 23 Aug 2021 18:30:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A1D2D149224;
        Mon, 23 Aug 2021 18:30:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?TMOpbmHDr2M=?= Huard <lenaic@lhuard.fr>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>,
        Derrick Stolee <stolee@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v7 2/3] maintenance: `git maintenance run` learned
 `--scheduler=<scheduler>`
References: <20210612165043.165579-1-lenaic@lhuard.fr>
        <20210702142556.99864-3-lenaic@lhuard.fr>
        <87h7h75hzz.fsf@evledraar.gmail.com>
        <3218082.ccbTtk1zYS@coruscant.lhuard.fr>
Date:   Mon, 23 Aug 2021 15:30:11 -0700
In-Reply-To: <3218082.ccbTtk1zYS@coruscant.lhuard.fr> (=?utf-8?B?IkzDqW5h?=
 =?utf-8?B?w69j?= Huard"'s
        message of "Mon, 23 Aug 2021 22:06:15 +0200")
Message-ID: <xmqqk0kbpzf0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: AF0C951A-0461-11EC-87D0-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

L=C3=A9na=C3=AFc Huard <lenaic@lhuard.fr> writes:

> Is the suggestion to replace
>
> +#ifdef __APPLE__
> +	return 1;
> +#else
> +	return 0;
> +#endif
> +}
>
> by
>
> + return IS_LAUNCHCTL_AVAILABLE;
>
> and to add
>
> #ifdef __APPLE__
> #define IS_LAUNCHCTL_AVAILABLE 1
> #else
> #define IS_LAUNCHCTL_AVAILABLE 0
> #endif
>
> somewhere else like at the top of builtin/gc.c ?

I wasn't the one who suggested it, but the suggestion reads as such
to me.

> Also, do we agree this shouldn=E2=80=99t be defined in cache.h=E2=80=AF=
? I=E2=80=99m a little bit=20
> confused.

The audience of "cache.h" (or more precisely, "git-compat-util.h" is
where these come from by including system headers) is much wider
than those narrow users who care about launchtrl or cron, so
limiting it in builtin/gc.c would make more sense, I would think.

Thanks.



