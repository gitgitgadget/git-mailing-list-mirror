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
	by dcvr.yhbt.net (Postfix) with ESMTP id B126E1F462
	for <e@80x24.org>; Tue, 30 Jul 2019 16:52:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728192AbfG3Qwt (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Jul 2019 12:52:49 -0400
Received: from mout.web.de ([212.227.15.14]:55139 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725889AbfG3Qwt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jul 2019 12:52:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1564505567;
        bh=JzoiqbApvybIuoUaLk4Xr5QFPioKwB6GrdBjk8xvP0g=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=GYselbhMhHvfT/2ptEmiQLjE7q9nwSlkk6A/TBBF1kiA4ujsdJI8oAdq+Gq/oBCJt
         Cbme/gFUcEdFU6B9jc5oOWIBq4+nvicLkGPjUr80zN7nEjtNDVWPMPsHFvDF6W6Kax
         TSsZnvniBBLftqxGOQ218rxNHfbK6Rau8o+o3J+4=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.23] ([79.203.24.71]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0M4qcP-1iI8Fm1GyT-00z0tF; Tue, 30
 Jul 2019 18:52:47 +0200
Subject: Re: [PATCH 3/3] grep: plug leak of pcre chartables in PCRE2
To:     Carlo Arenas <carenas@gmail.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
References: <20190727202759.22310-1-carenas@gmail.com>
 <20190727202759.22310-4-carenas@gmail.com>
 <874l376nud.fsf@evledraar.gmail.com>
 <CAPUEspgowrhj56SzW8cPKjZL28nPTkX-RScKrSAai8i0YkwFaA@mail.gmail.com>
 <7ec60d57-9940-35f2-f7b5-c87d4dc7cdd5@web.de>
 <CAPUEspgRUymY0Tm0zvfoSsYm0dKh8fy=fW-jN4Roid6oZVY86Q@mail.gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <dff4a832-e8a8-789f-04cd-b11fd1671c52@web.de>
Date:   Tue, 30 Jul 2019 18:52:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAPUEspgRUymY0Tm0zvfoSsYm0dKh8fy=fW-jN4Roid6oZVY86Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:EQ2xqYX1vL47mnvjpd+m7Txpz7FO1jFgmvujQtWbHK8IIBVjvNO
 vix9XHQ4LjEA3+N72wkMmh4Z9TMwPm2FCZCn1y6PlFQ9R5+G1D+FLg2xnIFnO/gMjFqUli6
 mZU5C2B+Vml7MH7bbxa6RH8yEAlInPXLb3gDaMv62vJwXwg0OFJ66Xd9t8Mumq+sx56wjJV
 l+2ht5XpHzRxlzGlx8sxQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6CsawnKY4OE=:XPrbJ1G9c/jHk3ZPoqVCZk
 GzshF57Jo94YBTizZSZXQJOXYH4eEUX4UKudatIJ4vjX3Hz1n9EaPR4gadPsc+5seGSy0q9Wl
 DBAFunYbymqFdyxdA8QmG74yjUzxp8tCuPII5yRiKAV44d9mmIVzmVetNyTvLUm/LbwFGjf6L
 6Su97FJh0Po1UULa1iwXheVS/Emv7/hlWhvN/42KeKzZpd+CGWez4+uRzup+LWk/CzmOE4WGj
 SAluEGGabMcqfU6eAaZ/G8sB1sTXGXozQxyTsBjo8pSNBNcRjURiY5e23oC1RwTwl2CWxzNrd
 KpkVPIvw3Vpj9OF1aPArOIggc1RrABG0yM3pAEX97Ftae6E7S67apN0P+EKHFTOb0/SmJJi5M
 5OxM8/+vjQseNAEeRr5/OTQ8r2u5xBVLLW01H75xUZx+K2/fya3ZbwvQK7RZE5ijnbYNqxo3y
 NQvVKJjMMCfAYlrMbqlvSV9ceLOFdBPN8X33NzXnQlM3t4qUSBXHvKvltNL9GuwXB6m4PxaIY
 LsirE5PsbipP6/JtoYPvZFBr1fguJ2A6bBzFftF7v57DAyyr+OaJsIK55xXQ+hmmdoTH3HH+M
 soctGCJzBFM8z26Xu4Bdfm6oxI4r2p6ln7PgPC7W2Xfq0OCc2kK5Pjq5bVE3W1VvrSQd7NjTq
 WQ5QYh+fD9q1oremgRVCEK9MkPik+keKCvCGv/S/thwuJFkKaws9VreK+xL1EW4EodxCOACVF
 /JQlcDbZlxsfCKrlUBEnskGrLAFsrXpDPVUwEbrBtS9AP6PB/2qe9I3YtvtsXzTK/Hnt9GBvP
 c4RRqcsc/Ty5MTSJygyflf+L0iOyBAorQmUJRtoTf1T//eQ1poB9M2R4TM+hwJEA33nkUkazV
 x/Vv4410RTF9c7YvTDZ1XetMIe0XqvIJ9vns5XDKzUWv1wEFS6V75DeZRRtIbhcJKgQL640Za
 doJq0h2wyvgGGvsTYG9jAsM/PmNBfSvSMuqMuB4OXNyA0RTWpHgPDlCpX4mB76ur0OSoSzg1t
 wBIx8yrY5n3mJDwdWrGNE/HUuoYs91vEw+vwozur+IVPkwLoq/ZnHwGpvk3N9ypX7+e1jr7ST
 WAwQQNu1ZL+eUg=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 30.07.19 um 02:08 schrieb Carlo Arenas:
> On Mon, Jul 29, 2019 at 1:35 PM Ren=C3=A9 Scharfe <l.s.r@web.de> wrote:
>>
>> Am 28.07.19 um 03:41 schrieb Carlo Arenas:
>>> On Sat, Jul 27, 2019 at 4:48 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
>>> <avarab@gmail.com> wrote:
>>>>> +     free((void *)p->pcre_tables);
>>>>
>>>> Is the cast really needed? I'm rusty on the rules, removing it from t=
he
>>>> pcre_free() you might have copied this from produces a warning for me=
,
>>>> but not for free() itself. This is on GCC 8.3.0. How about for you &
>>>> what compiler(s)?
>>>
>>> both will trigger warnings for the same reason
>>> (-Wincompatible-pointer-types-discards-qualifiers)
>>> with Apple LLVM version 10.0.1 (clang-1001.0.46.4)
>>>
>>> gcc-9 in macOS triggers 2 "warnings"; one for discarding the const
>>> qualifier (-Wdiscarded-qualifiers)
>>> and another for mismatching parameter to free():
>>>
>>> note: expected 'void *' but argument is of type 'const uint8_t *' {aka
>>> 'const unsigned char *'}
>>
>> Right: pcre_maketables() returns a const pointer, and you have to cast
>> away this const'ness at some point if you want to free(3) that memory.
>> Returning a non-const pointer would be more fitting, but I guess the
>> idea is that users of the library are not supposed to change the
>> contents of the table.
>
> note that this pointer was generated by pcre2_maketables() instead
> which is actually "const uint8_t *", but yes these tables are meant to
> be inmutable and that is why they are "cost".

Only the const'ness matters in regards to the need for casting a pointer
to feed to free(3).

Doing the cast in a library function or using an opaque pointer type
instead of a fake const pointer would be nicer ways on the part of PCRE2
to keep callers from messing with the table.  Forcing users to cast
const away or leak is not very nice..  Nothing we can do about it,
except perhaps adding a wish list item for PCRE3, I guess.

https://pcre.org/current/doc/html/pcre2_maketables.html says that
pcre2_maketables() returns const unsigned char *, by the way.  I don't
get the PCRE2_SUFFIX business in pcre2.h ("Define macros that generate
width-specific names from generic versions."), though.

>> But wouldn't it be more correct to use pcre_free()?  As long as we keep
>> pcre_malloc() and pcre_free() at their default values it doesn't matter
>> in practice, but using free(3) directly is a layering violation, no?
>
> yes, but that is the only option PCRE2 gives when not using a global
> context which is what the comment in the commit refers to.
>
> FWIW pcre_free() doesn't exist anymore in PCRE2.

OK, and while https://pcre.org/original/doc/html/pcreapi.html#TOC1
says that pcre_malloc() is used by pcre_maketables() (and thus the
result should be passed to pcre_free() after use),
https://pcre.org/current/doc/html/pcre2_maketables.html says
pcre2_maketables() uses malloc(3), so that pointer needs to go to
free(3) at the end.  Missed the second part in my earlier reply.

>> Perhaps just UNLEAK that thing?  There is only a single way to build it
>> and we can reuse it throughout the lifetime of the program, so there is
>> no real need to clean it up before the OS does.
>
> That would be a better fit if it would be created once in cmd_grep and
> then shared with all worker threads (which I thought would be nice to
> do in the future anyway), but this change was trying to be conservative
> and just to the minimum to close the leak.

Sure.  I wonder how sharing between threads would influence performance..

Ren=C3=A9
