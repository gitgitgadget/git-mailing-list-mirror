Return-Path: <SRS0=EnZj=DB=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 560F0C4363D
	for <git@archiver.kernel.org>; Thu, 24 Sep 2020 22:03:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE44523AA3
	for <git@archiver.kernel.org>; Thu, 24 Sep 2020 22:03:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="X4WEPvz7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726478AbgIXWDJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Sep 2020 18:03:09 -0400
Received: from mout.web.de ([212.227.17.11]:49457 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726205AbgIXWDI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Sep 2020 18:03:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1600984975;
        bh=EEVrsLhm+pljwrDdLfa6Zv5mD+9DVOOxIAU/RHK2Fcw=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=X4WEPvz7TfroFbE2+fittU5YND+cn6/qiSZxfFsgYFlnczUHf4EV4GjNK1Tg46fKk
         sCeaa10RBeZ9Hq6SH9BMILNp+yV7s7QiG39KWJVllD0FX0opvqqQSTPlW21VRm+lUa
         bWQyTRfrzfVhhF/S2IqAywIrXIrxsp+x5LPDjjD8=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([91.47.149.245]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LcPf8-1kla9Z2o7y-00jnVr; Fri, 25
 Sep 2020 00:02:55 +0200
Subject: Re: [PATCH 1/2] bswap.h: drop unaligned loads
To:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Cc:     Han-Wen Nienhuys <hanwen@google.com>, git <git@vger.kernel.org>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
References: <20200924191638.GA2528003@coredump.intra.peff.net>
 <20200924192111.GA2528225@coredump.intra.peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <b4b9475f-9c84-1889-835d-9f6e81198e5b@web.de>
Date:   Fri, 25 Sep 2020 00:02:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200924192111.GA2528225@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Xn+dqB8zRnP8Jja2ZHXPjFtrCJf2W/N1qPxGM/qUYvn8+t7mpuV
 mOBOuiNf2+Go37XvbBU7IDSv678jvbeJcwoTov7R2AQepHDPHbtW85ftDQl0itwnVwXr/fk
 rcFCuGZqQUS1qnOUbK/+lgGeJP+Z1hcxMTslQiaV/7mO3c74iZSlUf2+YxtY8yZ0/TdkZ35
 ZsZIHsQC3QIniqWwLQ7ew==
X-UI-Out-Filterresults: notjunk:1;V03:K0:gztNnLeYFkU=:5s1icKCc8s3tZC0/eUVKaA
 loHNJ48TnIXsbYwa9+lfWLvxCUXeDRXwFHZoOvibq66TBp5mDFV1AWif+bm9y5/1b88bwNsgJ
 UghuRXTRPhSi0dtRAGAqbKKQq76kv93+5xXVXcOsD+7aJFCARnGXugYuQZGLppCIUSZLQjTcj
 B39HLdlJol6vS/i5eL670NJ7NghGW3lRRCW31cAbvJI5ncvCR9mdxda8G1lbtHXvfs7FC6QIc
 ZeS1hW9hGhIozFhQXhv7pB3uCYYHvktJevCJwBbGfn7r5nYlgN4JH0IYtvScIHRugMx7Ty03W
 Ce3TLRtRpUAT617pLS5lZMkMK6PR91TRiucqqXK8/mJRtAbGiVe2uNoUI/j9ZDhjTBLD31NGU
 IgemxnxdFYPaeW5IBPg6BvE4Eitfe2gE9LOHh8UGFOPFjVSXBJPHa7FxEbL1TjtK69flGrJUb
 9EDlwyJscHFSPOe8FLhLgh4qxFk6ooSPs6qh93DBzXHv7b616tBQaVl2wFt5gg6mq8gmrM2EG
 j/ZL5Q7+3cyCZW2zFjZ6333W3YbeePELkXrNb2u8WefkZT66mN/2Rb5kknD+GiBKz64ZTzoYP
 M2e42XlW57fU4swVr4cx1tg5wltnDoUNPUve+kLzEdCndzYS4ycxZK/ZX5VRnFNa4N7Z15BGD
 rnaFulJuXKva7c/H/48V2V7gD5fbVDm8y+V+ub4cCLeUbv9WV4nWMDt8AoAazAFfbGcJrxOkV
 TFaYuDbvbx2D83+kTTSZ8YKCvRCD0IC+/7ULvKXCaFRafIOBrjuAzIQTmOSDqTAHXCR8LWGPw
 zDdXWZMi3H0gQWmt6s+UQfepF9wAgtl8DVnPt8ame9II+AfXhPkNapocZGZ7Iv2UYBV5avWtf
 lpi3weMc0FslN3m7SDBMyVmUD+ufVjuyx6c2FViSa2HY67U0+k7DJCgMfzlO6bWpRiQqCtaZg
 YA4ziMB8cDVO3e9ZOpsM0h5q9XYrrR9AmgxWzp130G3KpzP2IHpjNKaRMzCZS3rzAFNhlnX7E
 l/TwbXS+r0OUe4xIaXlUjWGCF25jedr9F3E1kJ6mBF9vShZZwvuGHG2yhDdkEBosSjXLWScwY
 9JtbwNLTJXbTx/TdG9AY0hTIo4aku5pdzJFx+dvthgKMqSJZ7zgTlX+zD4+osSzbZAtjKgKAD
 rbADb4dex7wVdklM1GP6PoGsn0rlGdR8QCzl5ypjhmmW2WqIVK4D1yxoJ4zMgJiTGPL8rSehx
 kLXDOs3BDN/1aFqVo
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 24.09.20 um 21:21 schrieb Jeff King:
> Our put_be32() routine and its variants (get_be32(), put_be64(), etc)
> has two implementations: on some platforms we cast memory in place and
> use nothl()/htonl(), which can cause unaligned memory access. And on
> others, we pick out the individual bytes using bitshifts.
>
> This introduces extra complexity, and sometimes causes compilers to
> generate warnings about type-punning. And it's not clear there's any
> performance advantage.
>
> This split goes back to 660231aa97 (block-sha1: support for
> architectures with memory alignment restrictions, 2009-08-12). The
> unaligned versions were part of the original block-sha1 code in
> d7c208a92e (Add new optimized C 'block-sha1' routines, 2009-08-05),
> which says it is:
>
>    Based on the mozilla SHA1 routine, but doing the input data accesses =
a
>    word at a time and with 'htonl()' instead of loading bytes and shifti=
ng.
>
> Back then, Linus provided timings versus the mozilla code which showed a
> 27% improvement:
>
>   https://lore.kernel.org/git/alpine.LFD.2.01.0908051545000.3390@localho=
st.localdomain/
>
> However, the unaligned loads were either not the useful part of that
> speedup, or perhaps compilers and processors have changed since then.
> Here are times for computing the sha1 of 4GB of random data, with and
> without -DNO_UNALIGNED_LOADS (and BLK_SHA1=3D1, of course). This is with
> gcc 10, -O2, and the processor is a Core i9-9880H.
>
>   [stock]
>   Benchmark #1: t/helper/test-tool sha1 <foo.rand
>     Time (mean =C2=B1 =CF=83):      6.638 s =C2=B1  0.081 s    [User: 6.=
269 s, System: 0.368 s]
>     Range (min =E2=80=A6 max):    6.550 s =E2=80=A6  6.841 s    10 runs
>
>   [-DNO_UNALIGNED_LOADS]
>   Benchmark #1: t/helper/test-tool sha1 <foo.rand
>     Time (mean =C2=B1 =CF=83):      6.418 s =C2=B1  0.015 s    [User: 6.=
058 s, System: 0.360 s]
>     Range (min =E2=80=A6 max):    6.394 s =E2=80=A6  6.447 s    10 runs
>
> And here's the same test run on an AMD A8-7600, using gcc 8.
>
>   [stock]
>   Benchmark #1: t/helper/test-tool sha1 <foo.rand
>     Time (mean =C2=B1 =CF=83):     11.721 s =C2=B1  0.113 s    [User: 10=
.761 s, System: 0.951 s]
>     Range (min =E2=80=A6 max):   11.509 s =E2=80=A6 11.861 s    10 runs
>
>   [-DNO_UNALIGNED_LOADS]
>   Benchmark #1: t/helper/test-tool sha1 <foo.rand
>     Time (mean =C2=B1 =CF=83):     11.744 s =C2=B1  0.066 s    [User: 10=
.807 s, System: 0.928 s]
>     Range (min =E2=80=A6 max):   11.637 s =E2=80=A6 11.863 s    10 runs

Yay, benchmarks!  GCC 10.2 with -O2 on an i5-9600K without NO_UNALIGNED_LO=
ADS:

  Benchmark #1: t/helper/test-tool sha1 <foo.rand
    Time (mean =C2=B1 =CF=83):      6.547 s =C2=B1  0.015 s    [User: 6.12=
7 s, System: 0.395 s]
    Range (min =E2=80=A6 max):    6.531 s =E2=80=A6  6.583 s    10 runs

... and with NO_UNALIGNED_LOADS set:

  Benchmark #1: t/helper/test-tool sha1 <foo.rand
    Time (mean =C2=B1 =CF=83):      6.496 s =C2=B1  0.011 s    [User: 6.13=
5 s, System: 0.360 s]
    Range (min =E2=80=A6 max):    6.486 s =E2=80=A6  6.519 s    10 runs

clang 10 without NO_UNALIGNED_LOADS:

  Benchmark #1: t/helper/test-tool sha1 <foo.rand
    Time (mean =C2=B1 =CF=83):      6.697 s =C2=B1  0.028 s    [User: 6.34=
3 s, System: 0.354 s]
    Range (min =E2=80=A6 max):    6.675 s =E2=80=A6  6.754 s    10 runs

... and with NO_UNALIGNED_LOADS set:

  Benchmark #1: t/helper/test-tool sha1 <foo.rand
    Time (mean =C2=B1 =CF=83):      6.714 s =C2=B1  0.049 s    [User: 6.32=
0 s, System: 0.375 s]
    Range (min =E2=80=A6 max):    6.651 s =E2=80=A6  6.791 s    10 runs

> +cc Ren=C3=A9 because I know he is going to feed the two of them into
>     godbolt; I could do that, too, but he will provide much better analy=
sis
>     on top ;)

Weeell, I don't know about that, but I couldn't resist taking a quick
look at what some compilers do with the 32-bit functions, which are the
ones used in block-sha1: https://www.godbolt.org/z/rhKMTM.

Older versions of gcc and clang didn't see through the shifting
put_be32() implementation.  If you go back further there are also
versions that didn't optimize the shifting get_be32().  And the latest
icc still can't do that.

gcc 10.2 just optimizes all functions to a bswap and a mov.  Can't do
any better than that, can you?

But why do we then see a difference in our benchmark results?  Not sure,
but https://www.godbolt.org/z/7xh8ao shows that gcc is shuffling some
instructions around depending on the implementation.  Switch to clang if
you want to see more vigorous shuffling.

The performance of bigger pieces of code seems to be a matter of luck
to some extent. :-/

Ren=C3=A9
