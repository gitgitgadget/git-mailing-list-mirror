Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7994F1F731
	for <e@80x24.org>; Thu,  8 Aug 2019 14:29:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387769AbfHHO3n (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Aug 2019 10:29:43 -0400
Received: from mout.web.de ([212.227.17.11]:51363 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727649AbfHHO3n (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Aug 2019 10:29:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1565274574;
        bh=K2QdzE4P5K8YMJsPo/YuixfNNRuVc/La/rqZcJwcVCc=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Au+uXSafa8RjkU1awwT3EAnpKvmc1Ja80uF9VC6l7ysMo4WcOisjpxt2pk6mm8lmd
         sWnv5yqizWkdK78RetEFRyZXUB3nkoGtYI/ntdx82ZkZGeU4F0sZStiw2Xm87mMu1h
         yY+Fauqdo77zwYSmZUrHLBIrIP+yKCYCWK3AcUK4=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.23] ([79.203.24.71]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M0hfO-1iAnj62gc2-00uqDr; Thu, 08
 Aug 2019 16:29:34 +0200
Subject: Re: [RFC PATCH v3 2/3] grep: make PCRE2 aware of custom allocator
To:     Carlo Arenas <carenas@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, johannes.schindelin@gmx.de,
        avarab@gmail.com, michal.kiedrowicz@gmail.com
References: <20190806085014.47776-1-carenas@gmail.com>
 <20190806163658.66932-1-carenas@gmail.com>
 <20190806163658.66932-3-carenas@gmail.com>
 <ab8a378c-0a60-9554-b2dd-ecb3d05229cb@web.de>
 <CAPUEspip98Mq8FrKTOkEikZhaLPprZXf=E2x3d0b7=c7e5+Gyw@mail.gmail.com>
 <c7f08e19-88a7-ca7f-90b9-54465e621d49@web.de>
 <CAPUEspj4CrEk6u4+8a5UBisxWsXcwOrOPQ5s9TktA6dZx5s+uQ@mail.gmail.com>
 <f6056e0c-fe7f-30b3-c2d7-bba2b44d6888@web.de>
 <CAPUEspi2vu=7uLU19c-wcW+ji63gyeO7poAwS5_7ZhTiBWSxjg@mail.gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <7f42007f-911b-c570-17f6-1c6af0429586@web.de>
Date:   Thu, 8 Aug 2019 16:29:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAPUEspi2vu=7uLU19c-wcW+ji63gyeO7poAwS5_7ZhTiBWSxjg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:gDcs+WTECltXeK492PNfiASdlqu2lOfB0/Jp2qMUEjZD/mGaBOO
 ZVJ6NvlXLWgWLpLA1CEExHicJygNsuSNWh7NSIn8vQ/7QFZBPxKf7GZKACR3AQZhMuKvIcL
 /22xiGklnDAPy8vrNs9dPXfiw/buxMKvLGl/B/Fk3k7BJ1ZewQKGVy7fggee0p04LrnHBHy
 zbRvl8vG3n79M/uOzljRQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:dtWNq+74g7k=:MF/VJBiF34/Lbtbn6cSjcE
 pe9/jfphil8LQ8r4Oq7Q5LzoxuBB2bw8eafY1NfwmYvYkd5W9apLIx8YoQENd8RQqUM2hAG3T
 QwbwdM1NtAgiO2Cjhr6kahInusi08bRlEEw7JMxIMav5raE1r6rN9Bfd882j1c5Y4t6AaGQ/Y
 EpcYiYhqcuB225Vr1S9NFaH3wm77EOATKrURSDK88ZNXs5r/2G1n58Bvg4rip87Da7zjYyOdB
 Z1TX9RBAhiflv2/Ay6VRRHlNWe3p5b5TwTciaz2IokaEh7fKzkSjFm1JE8lufOrriG0oEPjYw
 8J7L5Mf3pMIihuC9rFsyZCq9LPb9nyvNUq5YjzOiGd6V2nkX8pg74sqUwuzpZ8qrLlqhzYoBt
 jHDDlQ/7v2a+fCjrxEsF+95wS0yjJzYdRJB1ZMv1BRUCq6Bbo03nmSWOxgHav83xvxI0yuqBA
 4Ctu/3Hfej/EboMhEab/SN+XZOk9dsHe7fktuMXBEsqbBBrihWnZnlTxpxR4TazyZrU3kZrdg
 wtXrBu5NlDBv741+1Lw9N9JRBiTirkfOoa9d34IDkebpyE6d8SQbcJbM+6XCJv27GngFSar+Z
 QcXkBSjaxgdEQgPaA0wUh+5hv4hMZZaRocqyinerUre3aVt3h1J2t33Va6UiftYPgOuM3vQQF
 yi6bp0tNW10E5y5MA6R9kmX0tnwv9eCzg2pX9hl33+U+sWXk0P7LS8Vgc5tTnVwDCcAUDF1Qi
 6bAkDQGfFGnUs+Xm0EB8T1dfzH4eErZF8xt4nia9Je2fgLrR2AZN+xz+3hUo+Cglq5eb4WW3d
 mwOSLfdfzFnTYpSkP9HmFxHf5AwwKg3X9w6hOgtM7vcOqdjrRDV0Y/htBqpWCv8xcgxfUcM7c
 XOsQJnyzJJPtqBHEXjBi0SK/wotBVN6UCIL/IcthUCMIHnAi9F9pLsmhAKvMSBtmgqJl5B+Ae
 xvFAkxpJ96h4x+H2P8GOsGz+6CUAHQ0tnBBursRUmT9ju6eI8yMTEMZLej6H3/42xcFwXWdvw
 DR1A+tQbOLfKP+kY+0liQzI3gpBm7eO6V2PR8KtWZp2kdGV1y64p3QarsiWsf6bILqnuaLQze
 L8drFSu1aP2T83FuHpnvFhbBGv7CF+6+3u+ovBamc6EFs+WvL6V+AUPk2M+vAqnUGOnAj4sXs
 s6sLI=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 08.08.19 um 14:38 schrieb Carlo Arenas:
> On Thu, Aug 8, 2019 at 12:07 AM Ren=C3=A9 Scharfe <l.s.r@web.de> wrote:
>>
>> Am 08.08.19 um 04:35 schrieb Carlo Arenas:
>>> On Wed, Aug 7, 2019 at 6:03 AM Ren=C3=A9 Scharfe <l.s.r@web.de> wrote:
>>>>
>>>> Am 07.08.19 um 11:49 schrieb Carlo Arenas:
>>>>> was hoping will perform better but it seems that testing can be done
>>>>> only in windows
>>>>
>>>> nedmalloc works on other platforms as well.
>>>
>>> I meant[1] it works reliably enough to be useful for performance testi=
ng.
>>
>> You mentioned being concerned about performance several times and I
>> wondered why each time.  I'd expect no measurable difference between
>> using a custom global context and the internal one of PCRE2 -- setting
>> two function pointers surely can't take very long, can it?  But
>> measuring is better than guessing, of course.
>
> setting the allocator is not a concern, but using it; it requires an
> extra indirect function call which is usually not very friendly to
> caches in our speculative execution CPU world.  our implementation
> also adds the wrapper call overhead, but in this case it is just the
> "cost of doing business" with PCRE2.

PCRE2 needs to allocate memory once per program run for the character
table and for each pattern compilation.  These are both rare events
compared to matching patterns against lines, and I suspect that
compilation in particular  has much more other work to do, even more so
with JIT enabled; I'd expect function call indirection to not make much
of a difference.

pcre2_compile() always calls the allocation function through a
function pointer in a context struct, by the way (see line 9695 in
https://vcs.pcre.org/pcre2/code/trunk/src/pcre2_compile.c?view=3Dmarkup
or search for "malloc" in that file).

>>> goes without saying that the fact that I am using a virtualbox with 2
>>> CPUs running Debian 10 on top of macOS (a macbook pro with 4 cores)
>>> and the test uses by default 8 threads, doesn't help,
>>
>> nedmalloc is supposed to run on macOS as well.
>
> the last version has some "fix miscompilations in macOS" fixes that
> might be relevant, and the version we have in tree says it works in
> the 32-bit version which latest macOS versions are working hard to
> deprecate (can't even build for it anymore), eitherway trying to run
> with a nedmalloc enabled git in macOS is not fun.

Importing the latest version of nedmalloc might make sense in general.
The last commit in git://github.com/ned14/nedmalloc.git was done five
years ago; is it finished?  A diffstat with -b looks like this:

 malloc.c.h  | 1193 ++++++++++++++++++++++++++++-------------
 nedmalloc.c | 1720 +++++++++++++++++++++++++++++++++++++++++++++++++++++-=
------
 nedmalloc.h | 1580 ++++++++++++++++++++++++++++++++++++++++++++++++++++--=
-
 3 files changed, 3840 insertions(+), 653 deletions(-)

Any nedmalloc fans interested in bringing the goodies hidden in there
to Git (presumably while retaining our local fixes)?

>> In particular I don't think that these results justify coupling the use
>> of nedmalloc to the choice of using a custom global context for PCRE2.
>
> neither did I either, the only reason I am holding on fully enabling
> NED with PCRE2 in my series is just because I wan't to make sure we
> have identified the bug correctly and we are fixing it (specially
> since I can't reproduce it, and therefore neither debug it)

That's a good reason against #ifdefs in general.  Sometimes they are
unavoidable, but they can make maintenance a lot harder.

> sorry for not making that clear enough, and as I said before, if we
> keep seeing segfaults even after v4 then we will have to do that or I
> might need to do a quick run to the nearest microsoft store hoping for
> a distracted rep, instead.

Asking to buy a license for Windows Vista might cause quite a bit of a
distraction in there -- Microsoft's support for that version ended two
years ago. :)  It still seems to be popular enough to be supported by
Git for Windows, however.

(You could buy Windows 10 and probably get a downgrade right, but
finding legit install media for Vista might be challenging.)

But I'd say do the easy thing: Custom global context for all.

>> I'd expect:
>> - Without USE_NED_ALLOCATOR: xmalloc() should be used for all
>>   allocations, including for PCRE2.  Some special exceptions use
>>   malloc(3) directly, but for most uses we want the consistent
>>   out-of-memory handling that xmalloc() brings.
>
> that is already in v4 and would expect to carry it forward.  this is
> also what I had in mind when I said we will need some fixes on top of
> Dscho version if we give up with these.
>
>> - With USE_NED_ALLOCATOR: malloc() and xmalloc() use nedmalloc
>>   behind the scenes and free() is similarly overridden, so all
>>   allocations are affected.
>> - If USE_NED_ALLOCATOR performs worse than the system allocator on
>>   some system then it's the problem of those that turn on that flag.
>>
>> Makes sense?
>
> completely, but note also that Dscho version would make the
> performance impacts of using a custom allocator (if any) affect
> everyone using PCRE2.

Sounds fine to me, if the performance numbers don't take too much of
a hit.  I'd be surprised if the needle moved at all (ignoring noise).

Ren=C3=A9
