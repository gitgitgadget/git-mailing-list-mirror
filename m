Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA413C07E96
	for <git@archiver.kernel.org>; Tue,  6 Jul 2021 20:52:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A882361CA0
	for <git@archiver.kernel.org>; Tue,  6 Jul 2021 20:52:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbhGFUyy (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Jul 2021 16:54:54 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61366 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbhGFUyx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jul 2021 16:54:53 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3FCA1C1D7F;
        Tue,  6 Jul 2021 16:52:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=JpQ+afG8FpXS
        04KZXs7wOthbKESgYLcj5PcUYCt++UI=; b=nT4NDejnjJHkH9iDI+7XaYIV7ZOA
        qlWB5VT81tSeSOfqmvQiIZMujp3H/o7TMR+mVwEFXNsttZZFtYr9EjUVwpOAHTCO
        rGSFdOhgdYDFS0EA0PNGVvef7IdRNPXkDRhhUgnlGPp7u1ilRZqK8iusDlie8KeV
        /1lVda2zLfmudUY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 36B3BC1D7E;
        Tue,  6 Jul 2021 16:52:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A37C7C1D7D;
        Tue,  6 Jul 2021 16:52:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     =?utf-8?B?TMOpbmHDr2M=?= Huard <lenaic@lhuard.fr>,
        git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>,
        Derrick Stolee <stolee@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7Ru?= =?utf-8?B?Zw==?= Danh 
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
        <20210702142556.99864-1-lenaic@lhuard.fr>
        <20210702142556.99864-3-lenaic@lhuard.fr>
        <87h7h75hzz.fsf@evledraar.gmail.com>
Date:   Tue, 06 Jul 2021 13:52:12 -0700
In-Reply-To: <87h7h75hzz.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Tue, 06 Jul 2021 21:56:38 +0200")
Message-ID: <xmqq5yxni2rn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 0A79D674-DE9C-11EB-BC67-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Fri, Jul 02 2021, L=C3=A9na=C3=AFc Huard wrote:
>
>> + *     =E2=94=8F=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=
=E2=94=81=E2=94=B3=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=
=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=
=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=
=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=
=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=
=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=
=E2=94=81=E2=94=93
>> + *     =E2=94=83 Input =E2=94=83                     Output          =
            =E2=94=83
>> + *     =E2=94=83 *cmd  =E2=94=83 return code =E2=94=82       *cmd    =
    =E2=94=82 *is_available =E2=94=83
>> + *     =E2=94=A3=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=
=E2=94=81=E2=95=8B=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=
=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=BF=E2=94=
=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=
=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=
=94=81=E2=94=81=E2=94=BF=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=
=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=
=E2=94=81=E2=94=AB
>> + *     =E2=94=83 "foo" =E2=94=83    false    =E2=94=82 "foo" (unchang=
ed) =E2=94=82  (unchanged)  =E2=94=83
>> + *     =E2=94=97=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=
=E2=94=81=E2=94=BB=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=
=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=B7=E2=94=
=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=
=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=
=94=81=E2=94=81=E2=94=B7=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=
=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=
=E2=94=81=E2=94=9B
>
> I wonder if we have developers for whom the non-ASCII here is an issue.

I do have an issue myself ;-) but I can survive.  I do not know
about others.

> This sort of code is much more pleseant to read and work with if you us=
e
> strbuf_split_buf(). This isn't performance sensitive, so a few more
> allocations is fine.

Please do not encourage use of strbuf_split_buf().  It is a
misdesigned API as it rarely is justifyable to have an array, each
element of which can be independently tweaked by being strbuf.  We
are not implementing a text editor after all ;-)

A helper function that takes a string and returns a strvec would be
a good fit, though.

>> +#ifdef __APPLE__
>> +	return 1;
>> +#else
>> +	return 0;
>> +#endif
>> +}
>
> I see this is partially a pre-existing thing in the file, but we have a=
n
> __APPLE__ already in cache.h. Perhaps define a iLAUNCHCTL_AVAILABLE
> there. See e.g. 62e5ee81a39 (read-cache.c: remove #ifdef NO_PTHREADS,
> 2018-11-03).

Excellent suggestion.
