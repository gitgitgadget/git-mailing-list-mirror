Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3906C1F462
	for <e@80x24.org>; Mon, 29 Jul 2019 20:35:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727922AbfG2UfF (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jul 2019 16:35:05 -0400
Received: from mout.web.de ([217.72.192.78]:49659 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726805AbfG2UfF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jul 2019 16:35:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1564432503;
        bh=gOWzdo9OeB7BVBKC5Mhfmqj4VHZEebhe4fXiFcGOKWY=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=fMmCmEziXEF4uATGmG/b4Z6zC1i+OvoojbsJ+izAC9btuXzJIeDde4p4bsvV1GSm9
         /1PxLiCpLPqTGNpe4G/f/RmUnoTY2izTl34E+Smp809oeIo+utJd8eu0v2mQ8f0tyD
         iOQhwVNtaKrESt4NSCYkTKQt2q2hpn9ZIvgzR/58=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.23] ([79.203.24.71]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MQ6LH-1hmxYi3TmN-005INa; Mon, 29
 Jul 2019 22:35:03 +0200
Subject: Re: [PATCH 3/3] grep: plug leak of pcre chartables in PCRE2
To:     Carlo Arenas <carenas@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org
References: <20190727202759.22310-1-carenas@gmail.com>
 <20190727202759.22310-4-carenas@gmail.com>
 <874l376nud.fsf@evledraar.gmail.com>
 <CAPUEspgowrhj56SzW8cPKjZL28nPTkX-RScKrSAai8i0YkwFaA@mail.gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <7ec60d57-9940-35f2-f7b5-c87d4dc7cdd5@web.de>
Date:   Mon, 29 Jul 2019 22:34:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAPUEspgowrhj56SzW8cPKjZL28nPTkX-RScKrSAai8i0YkwFaA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:QBqAJsM3JRAuTCQJBJjsM6j/56KZrD3EK7LuEYOL5mOtZ+3pJhF
 a2Wm0SUhrXFgHXzx8f1+XM4JF7FotfInJs3V1J+PQz1KavIRNm2GnMMvJHBS7skDHRKJ+oV
 48pHVuD7KRsDVD2OY+A/yb9K+HfAi7KkGaQFJgGy5paCCqmJPDVO2RliAeT4BNelJwgKtw4
 IQiMLiDgHVIr5umfqs94w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:p5psamdQvVs=:DXYH/472v7wo/GEb9Ra8i+
 iMDs+Mrk5hXdjmuHveEZtqJ3Gcc3+ieNJqm7b9wUFYXVrurdfrYCV0OE9kfg9ICWz9VREQpep
 DnwLtF1gTI7EVwRzPCeTm+zDwQGPC9wijAY2YsvHmdxkvBu3bai/Ya3hTMp2T0SqfsEQSWXBi
 7Ij6KHDuBP/hYYV7ass/Pi5NtlEDrPO0GUPceoNyb6WSQZX9wU5/oZEd+Fi/Uf0vceF/h3Ynm
 qSxSURZbyFE34MPw8A5RfyB25LnfC7leQBtBith9HKNzTNhGhFX6cGqUQLxMUs7r3hkAN6mev
 WNMnSaiW+GooAcCNdch/+Y9hklMPvKLUzGkTy2JXUh+VOSwO8EcDBi1V3tnSE4sxFtOsqth+B
 tCLJAhTA3Kr+8Mv3qD+TPMLhaVSpIbL4GASwJwjP581vQww6PiCEuK6tPVP/nOo/e3LLJRlJe
 ejKy1wtIZXY/pagvcQnVgnDRq6wDMdp3v+SyN2Chr3UAK33zDnr7y74ViAZmG468Z+UpguXlm
 ffdxsrGIvO+NRevBExT53LU90MQUbnvJ6EUk67eR/sMLXyvYXKWK3ddjc56rO1tAAqWJey7BJ
 ewRdgfpB6OwlQz/SnqGFaSiXaJuN8i2VjZ9/9lJvfBJ9KqP0ptvwhU6I84DxKg3THSHZS1ZIf
 KpvV2GgwnYhx2jz9WMhlEz/jU/zNOz7Va7++jgIuUU0GxHwLhXpcX4ds/QEpLMIuwhm/yO0gU
 htJH7vV4poG1iHLAGdSsdp6ayoMpZA9NenEELyrso3/yd7sC9057JDmWKOM0J1p7mrMSzEX81
 JOjAN3hMdBFR2vacZEvU/+S3LKDgEUzHj7cz+tTxLqvfz1wJTYKTqDAsufALcRI8XeeS50orO
 ddK+d6OR4sWyiC3fAqU44rSlkXkGwZFr7i/UVCsSrWXMyQ5np3Sc06qq0XVKPxIa1424xKfwl
 yfdxsy/jC5cIz5wN5KrKnElHvUbx9FFaM8ZI+nNfquLyFq/6rnZlFSkGksTU6A1n1tvH4Bcuk
 pIwic7cAEWD6IZPd2FX4A+Iw5EL/azPAa23VkVS0ej9gJpCS+fc2jFox8H2ZbAYqxbiUgZxUe
 sULfHat9lXmgog=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 28.07.19 um 03:41 schrieb Carlo Arenas:
> On Sat, Jul 27, 2019 at 4:48 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
>>> +     free((void *)p->pcre_tables);
>>
>> Is the cast really needed? I'm rusty on the rules, removing it from the
>> pcre_free() you might have copied this from produces a warning for me,
>> but not for free() itself. This is on GCC 8.3.0. How about for you &
>> what compiler(s)?
>
> both will trigger warnings for the same reason
> (-Wincompatible-pointer-types-discards-qualifiers)
> with Apple LLVM version 10.0.1 (clang-1001.0.46.4)
>
> gcc-9 in macOS triggers 2 "warnings"; one for discarding the const
> qualifier (-Wdiscarded-qualifiers)
> and another for mismatching parameter to free():
>
> note: expected 'void *' but argument is of type 'const uint8_t *' {aka
> 'const unsigned char *'}

Right: pcre_maketables() returns a const pointer, and you have to cast
away this const'ness at some point if you want to free(3) that memory.
Returning a non-const pointer would be more fitting, but I guess the
idea is that users of the library are not supposed to change the
contents of the table.

But wouldn't it be more correct to use pcre_free()?  As long as we keep
pcre_malloc() and pcre_free() at their default values it doesn't matter
in practice, but using free(3) directly is a layering violation, no?

Perhaps just UNLEAK that thing?  There is only a single way to build it
and we can reuse it throughout the lifetime of the program, so there is
no real need to clean it up before the OS does.

Ren=C3=A9
