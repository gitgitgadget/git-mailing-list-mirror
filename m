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
	by dcvr.yhbt.net (Postfix) with ESMTP id 0ADEA1F731
	for <e@80x24.org>; Thu,  8 Aug 2019 07:07:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731109AbfHHHHw (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Aug 2019 03:07:52 -0400
Received: from mout.web.de ([212.227.17.12]:36775 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728167AbfHHHHv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Aug 2019 03:07:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1565248063;
        bh=WcwnlI2cjmeKV/DQfsU+FfPEUgTg0xofsJaksSNCn0A=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=AL90wJIKLLTdTsD0L+fMJ6Ojm0iDYj1UChVUUSTN+14XfEOghl+DL4FVdcunuvsMQ
         x9jUwveCKn2ncgHAa3GJ83ChgHdTxBXaSxVBefjnNlpARd8sddY2WU/RORendvzceR
         hKxMZL+nQfy7R4wfVD3fycMp6kN6/dYK6alqG5ak=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.23] ([79.203.24.71]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LwYnz-1iOKlk1LVn-018Gb3; Thu, 08
 Aug 2019 09:07:43 +0200
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
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <f6056e0c-fe7f-30b3-c2d7-bba2b44d6888@web.de>
Date:   Thu, 8 Aug 2019 09:07:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAPUEspj4CrEk6u4+8a5UBisxWsXcwOrOPQ5s9TktA6dZx5s+uQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:AiS24I4jN35EubTjlBcF8lgS6YAWvEIZ+2xWNKwa5YQ8yMOJ0ZZ
 P3MjEe6gjtHbZ2UGzkJpBjDEM2b9idXyyRs99pgAW4PsVVwdNSHJXvCPAKocsGXCTiNsdtI
 DNMn5woM3m9z42Fl8cD1QvczWgqYEOl/X5xK28Ex8E25zX/1Bpm6EWCj0mOrBRNW/JCrD64
 jNXuJbtm9dvGM3N0VCzsw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Z30d/K9Hll4=:CGn55257uwHvdrDfrqhWmr
 GCS63hcFT/OryPDOqyawbXKGj1tm7sg9GL0sv8Fo82G13ijFTddQYjWD4V6M4q/ZrCwCBuVck
 TdX4rv1PLVmfcOuR9fC8e1yX4Ru6K+irPt8mPwIT6+Af4MyMDL0YLXSSGcQ9f4vK6W7NgZisp
 Xgt5/2urFRm26V0ZFbr67xuk33BSHLhFBc0aVkT76l9ke5wVkTPnhWXXvbgNovKuulKPVgW4l
 gq5Tq9TDRSBkMKC8E9a0lGhrp2lT64BcVnSBZG877Q1ZzO4qV3gRCueoFQqBLOTVaCOixnkVJ
 yIt6koYFnRNgZ6Js23m1qEw9QZ2r5UoPG68UJwByRlYwOzgQZ3vANXXjW0zy693NFqZ9ImtOm
 um7fkYIfykNm40oIWRb4GZJZbL81ZyG4h/s6G+aLJG6mqmXko4XEcMqbLr4g9NpUmmtxUqLGA
 hw7cStvu9uBR/+Fr1RQ3yB5CJIvBR7BAkeMLbf36hYWSSmcB4wmG3aFop1RcnoGc1eNO1j+/K
 BbPYSfIxb//DrGzihlkvnZ36QSP0YrPscuzIFSkR9gKTARLR1KKyl30GmdoV1xlQMx4V3TuGf
 6alRWp7PL/4Gmdj57rV14KMnM163C+OAdMMZ5DtQG8UX/eTe7sRpegjJyBl5j5x6JFmPh8QlS
 BKWFvrFOemYGd7CGLWTJPIVJ+ep2C57inty8jT9rq9xvP+yV2bHZmiQ3m8g9DI1+ZYphqIynB
 z+f2+IV+Jca55LMgtHZiRS8LolxWnNYFBrs7U9jI81u/OAorn+4Bq3xlTmQkANSv2vTmbPJ/Z
 t99QeeqerA8f0WGzIYtQQBUoqNYtg5iLXWvKlS9Wu8qVvS5SAWDP1OdP61yoj3RMEw5pat54n
 j36BSeBUkNSz6DQsHbnQHAbDowuwp7LBMAdxk1O/MKDd2KXDTNA6ZutnYpdUCKuVCCjvORudk
 hjW6o9/n/h0AHNjkufgnphNSF1ap/D+JZy3ccQKrPcjEIaWoPRQT6c22o/hrGLmESfXPXmuTn
 4Acaro81bYmeuFcAeTSXa/OgdahVK+JRiUzsnEh4pcCu5KJvF381p//f1gbqd69nIqT63ceRR
 bhjoD14bHJDXPAwV+fFIjlOAUJkU2OItk9m8DhTcNaYsyz0HGSOrCdWEUsl7TTKvTqioeOjF5
 yJdCc=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 08.08.19 um 04:35 schrieb Carlo Arenas:
> On Wed, Aug 7, 2019 at 6:03 AM Ren=C3=A9 Scharfe <l.s.r@web.de> wrote:
>>
>> Am 07.08.19 um 11:49 schrieb Carlo Arenas:
>>> was hoping will perform better but it seems that testing can be done
>>> only in windows
>>
>> nedmalloc works on other platforms as well.
>
> I meant[1] it works reliably enough to be useful for performance testing=
.

You mentioned being concerned about performance several times and I
wondered why each time.  I'd expect no measurable difference between
using a custom global context and the internal one of PCRE2 -- setting
two function pointers surely can't take very long, can it?  But
measuring is better than guessing, of course.

> goes without saying that the fact that I am using a virtualbox with 2
> CPUs running Debian 10 on top of macOS (a macbook pro with 4 cores)
> and the test uses by default 8 threads, doesn't help,

nedmalloc is supposed to run on macOS as well.

> but to share my
> pain here is the result of running p7820 with my last reroll on top of
> pu, comparing a build of the same code without NED (this tree) with
> one with it (HEAD)
>
> Test                                               this tree
> HEAD
> ------------------------------------------------------------------------=
-------------------
> 7820.1: basic grep -i 'how.to'                     0.89(1.12+0.46)
> 0.95(1.23+0.49) +6.7%
> 7820.2: extended grep -i 'how.to'                  0.90(1.12+0.49)
> 0.92(1.19+0.46) +2.2%
> 7820.3: perl grep -i 'how.to'                      0.54(0.30+0.52)
> 0.53(0.39+0.52) -1.9%
> 7820.5: basic grep -i '^how to'                    0.89(1.13+0.47)
> 0.91(1.13+0.49) +2.2%
> 7820.6: extended grep -i '^how to'                 0.84(1.04+0.49)
> 0.94(1.27+0.47) +11.9%
> 7820.7: perl grep -i '^how to'                     0.49(0.34+0.47)
> 0.51(0.36+0.49) +4.1%
> 7820.9: basic grep -i '[how] to'                   1.51(2.31+0.51)
> 1.55(2.38+0.51) +2.6%
> 7820.10: extended grep -i '[how] to'               1.50(2.20+0.59)
> 1.56(2.30+0.62) +4.0%
> 7820.11: perl grep -i '[how] to'                   0.67(0.50+0.52)
> 0.62(0.50+0.55) -7.5%
> 7820.13: basic grep -i '\(e.t[^ ]*\|v.ry\) rare'   2.58(4.39+0.56)
> 2.64(4.45+0.60) +2.3%
> 7820.14: extended grep -i '(e.t[^ ]*|v.ry) rare'   2.60(4.41+0.56)
> 2.66(4.58+0.56) +2.3%
> 7820.15: perl grep -i '(e.t[^ ]*|v.ry) rare'       1.17(1.66+0.53)
> 1.23(1.84+0.45) +5.1%
> 7820.17: basic grep -i 'm\(=C3=BA\|u\)lt.b\(=C3=A6\|y\)te'   1.12(1.54+0=
.51)
> 1.14(1.70+0.44) +1.8%
> 7820.18: extended grep -i 'm(=C3=BA|u)lt.b(=C3=A6|y)te'      1.09(1.54+0=
.48)
> 1.14(1.62+0.49) +4.6%
> 7820.19: perl grep -i 'm(=C3=BA|u)lt.b(=C3=A6|y)te'          0.87(1.09+0=
.46)
> 0.90(1.20+0.43) +3.4%
>
> and here one comparing two builds (both with NED)
>
> Test                                               origin/pu
> HEAD
> ------------------------------------------------------------------------=
-------------------
> 7820.1: basic grep -i 'how.to'                     1.00(1.24+0.55)
> 0.94(1.19+0.52) -6.0%
> 7820.2: extended grep -i 'how.to'                  0.90(1.15+0.49)
> 0.93(1.23+0.44) +3.3%
> 7820.3: perl grep -i 'how.to'                      0.52(0.37+0.51)
> 0.59(0.34+0.53) +13.5%
> 7820.5: basic grep -i '^how to'                    0.89(1.16+0.48)
> 0.90(1.17+0.47) +1.1%
> 7820.6: extended grep -i '^how to'                 0.92(1.17+0.50)
> 0.92(1.20+0.45) +0.0%
> 7820.7: perl grep -i '^how to'                     0.45(0.33+0.42)
> 0.54(0.29+0.57) +20.0%
> 7820.9: basic grep -i '[how] to'                   1.60(2.46+0.52)
> 1.61(2.39+0.62) +0.6%
> 7820.10: extended grep -i '[how] to'               1.71(2.67+0.56)
> 1.57(2.41+0.54) -8.2%
> 7820.11: perl grep -i '[how] to'                   0.66(0.61+0.51)
> 0.59(0.44+0.51) -10.6%
> 7820.13: basic grep -i '\(e.t[^ ]*\|v.ry\) rare'   2.69(4.49+0.66)
> 2.67(4.49+0.60) -0.7%
> 7820.14: extended grep -i '(e.t[^ ]*|v.ry) rare'   2.67(4.49+0.64)
> 2.64(4.54+0.54) -1.1%
> 7820.15: perl grep -i '(e.t[^ ]*|v.ry) rare'       1.23(1.80+0.47)
> 1.25(1.89+0.46) +1.6%
> 7820.17: basic grep -i 'm\(=C3=BA\|u\)lt.b\(=C3=A6\|y\)te'   1.13(1.64+0=
.47)
> 1.14(1.64+0.48) +0.9%
> 7820.18: extended grep -i 'm(=C3=BA|u)lt.b(=C3=A6|y)te'      1.16(1.68+0=
.46)
> 1.20(1.60+0.60) +3.4%
> 7820.19: perl grep -i 'm(=C3=BA|u)lt.b(=C3=A6|y)te'          0.90(1.16+0=
.48)
> 0.88(1.17+0.45) -2.2%
>
> with the only relevant line (for my code) being 7820.19 where it would
> seem it performs almost the same (eventhough just adding NED made it
> initially worst)
>
> note though that the fact there are 20% swings in parts of the code
> that hasn't changed
> or that where explicitly #ifdef out of my code changes doesn't give me
> much confidence, but since the windows guys seem to be using NED by
> default, I am hoping it works better there.

These measurement results are quite noisy, so I wouldn't trust them too
much.  nedmalloc being slower than the one from a recent glibc version
is not very surprising given this statement from its home page,
https://www.nedprod.com/programs/portable/nedmalloc/:

   "Windows 7, Linux 3.x, FreeBSD 8, Mac OS X 10.6 all contain
    state-of-the-art allocators and no third party allocator is
    likely to significantly improve on them in real world results"

In particular I don't think that these results justify coupling the use
of nedmalloc to the choice of using a custom global context for PCRE2.

I'd expect:
- Without USE_NED_ALLOCATOR: xmalloc() should be used for all
  allocations, including for PCRE2.  Some special exceptions use
  malloc(3) directly, but for most uses we want the consistent
  out-of-memory handling that xmalloc() brings.
- With USE_NED_ALLOCATOR: malloc() and xmalloc() use nedmalloc
  behind the scenes and free() is similarly overridden, so all
  allocations are affected.
- If USE_NED_ALLOCATOR performs worse than the system allocator on
  some system then it's the problem of those that turn on that flag.

Makes sense?

Ren=C3=A9
