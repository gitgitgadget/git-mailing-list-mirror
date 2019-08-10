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
	by dcvr.yhbt.net (Postfix) with ESMTP id 446531F731
	for <e@80x24.org>; Sat, 10 Aug 2019 07:57:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725888AbfHJH5G (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Aug 2019 03:57:06 -0400
Received: from mout.web.de ([217.72.192.78]:38159 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725763AbfHJH5G (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Aug 2019 03:57:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1565423818;
        bh=z7cz9ZnD1ymPmv7cB0/TBlgvD4bgs3BkgBsLDIMWfkU=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=S8uoVbjRKpsJqcf84UZ+Zw80Z5hJUvTIxWqV0P8tIQ0012jDc/r/gKLuHxUfKSgvZ
         PUcrUr6OWdZ7KRi62fS6olnS30CNiRod9RaOhwpYtZ+ak5r8/mxM0bg2/V+mn45xJa
         CAf+hJLMCtdc+AGyN8bXDPjhsoeq5POIwZQrEvw4=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.23] ([79.203.24.71]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LsyZi-1iK28e0eU6-012UtG; Sat, 10
 Aug 2019 09:56:58 +0200
Subject: Re: [RFC PATCH v5 0/3] grep: almost no more leaks, hopefully no
 crashes
To:     Carlo Arenas <carenas@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, avarab@gmail.com, gitster@pobox.com,
        michal.kiedrowicz@gmail.com
References: <20190807213945.10464-1-carenas@gmail.com>
 <20190809030210.18353-1-carenas@gmail.com>
 <CAPUEspiK7MTZPMktbU=_C_GPOH9vQiBmVUZp7GuR97RZS3onRQ@mail.gmail.com>
 <d239326e-11c3-5875-13a8-f4123baea6eb@web.de>
 <nycvar.QRO.7.76.6.1908092325480.46@tvgsbejvaqbjf.bet>
 <CAPUEspjVMbjdgBrW3qS3jwbd2ZfqMinfgGiasEZGwyZB-1c+QA@mail.gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <d8e55007-27bd-fcac-c918-bb712ec1bb8b@web.de>
Date:   Sat, 10 Aug 2019 09:56:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAPUEspjVMbjdgBrW3qS3jwbd2ZfqMinfgGiasEZGwyZB-1c+QA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:VSduGeUFx6P27CELS4gaSN36c9Yh+yl/p9HWrPO2i1lN/v3quBj
 EcHgB3kj/I2J8wWavuFDVNHWYYAGRtDldNDpqVWAZ9z9l3MvWcpcvkdnLNa4cqc+jCte++Y
 7YOUvyfJ7b71mW07rxtMey4/ioWc0OzIu0VtsxA7GFQ9wjFtfHtNjJQu2Lgpey570DfltJv
 Rt2HxzpKXJz0rmRe6m5kQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:fUHOax2LaAo=:rDYHTjVE/rUrv7KYX4HKy0
 yQfrD6lzRLTqv29VXjoLCBk0g23KABXIxAydD+vbmJm0Djx6LluQ6qpIoe43aFdcDtK8NZe1a
 K6T11TUlZlYBDL6QbKt/RKuaQk6UeXA8Glg9wdXWPKoGq0I1+5N/VEnaEkDewD1FouqMCnAvb
 RUx47QvKmulu43tEb8tLXqD7CnCcLwbn2f0Q+lju7dWquW7aEz4BUGHkMy6MPHblNa3MgMWVl
 kf1IYtqqMWLYm/iomUi+elHd9lABTM9SQXTCPcVGztl7jeAFU3/Ta0it41/3sshvSx7HP4iGH
 +iRylwU7oqJJgR3HixNkznWCOotnRDlGywYICaGsqkUHBUPasBqSbbZfPN5arBB/grTfqCbJB
 qJrt0XOHliCxRSfVwXBi0qTsM1EkSzLJLKbFh/OGb4X4FK8azRACEehX9zzn3z3IYTWgztt/a
 nZfK3yG+c40Y4xlhZ9AmYNFo2WHxvVWcjEAErxg5FO/4tz3InteCk2QnqCbe2z65L66jE9Qe6
 H2gZ0lvNZeQBd+N+llaxkYxonz+og2h3W8xbuLpxYPOUvq2BAZOUUMgWOCqmOH8qPDYH+Yjj4
 ZCldQlaoJOeWucZlBmjFd3QM60m8JMJ89a7C0Zz8pDdBoQhpD7LSFSO37+F21viku2fyA5CcF
 HuM/BpFetMs8KUTDjQwaxpOFYecVxSRPS4HkVtudhmmOm5gfE8g1wiMQUbBRQ8wrHOqJyz0FR
 T3i8g4bX6/0kqeZAM4ZQ8gDLfbrYXvAzQpQ3I88YuxDqTc8T2Y2myaD6bZyW5nbAVefZ7u0Tg
 po1iIIyG5vAj9hmJCqG2l5dLdFRubqaLe0dT6j+OaUK6pndtoG94aT1QfjmL/nDuz3ekJtioJ
 DN4HLkqXvGOa0vrZjqFu8UR0AGtmuTsCC/dTHOpSN6uSGbTT2yiwSxewPLXmnqPcqKHAbVKSL
 01r2MK8JW1eh/RLhRT3G3YtGxYUIet3mAtyy4pAyQCC/F/PDQb4JUNRbogP/Tngn3G49ZNyTo
 3kmDB+0FZKD7Op9/AGdtO2fVs8Stpz1SQjqTmprZVEceW5Lb943OAUK5VHD40I/roXDCvEIB4
 aqdUmGSxbWtQOhwx5RH8+LbhIeRR0ZXVv9d6e6S7pIEsrrDFJUC56LzJom4lhse5hCEiLmTpu
 PzZ1c=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 10.08.19 um 05:05 schrieb Carlo Arenas:
> in macOS (obviously testing without NED) the following is the output
> of (a hacked version) of p7801 for maint (against chromium's
> repository), with Ren=C3=A9's patch on top

Do you mean p7820?  And what did you change?  Looking at the results you
removed basic and extended from the list of regex engines, right?

Ugh, cloning https://chromium.googlesource.com/chromium/src.git sends
more than 16GB across the wire.  Is that even the right repository?  Not
sure if my machine can keep the relevant parts cached while grepping --
I/O times could drown out any difference due to context allocation and
memory allocator choice.  Let's see...

>
> Test                                       HEAD^               HEAD
> ------------------------------------------------------------------------=
--------------
> 7820.1: perl grep 'how.to'                 0.51(0.35+1.11)
> 0.48(0.33+1.16) -5.9%
> 7820.2: perl grep '^how to'                0.47(0.33+1.08)
> 0.45(0.34+1.11) -4.3%
> 7820.3: perl grep '[how] to'               0.49(0.40+1.11)
> 0.53(0.41+1.13) +8.2%
> 7820.4: perl grep '(e.t[^ ]*|v.ry) rare'   68.72(68.77+1.14)
> 72.10(72.15+1.20) +4.9%
> 7820.5: perl grep 'm(=C3=BA|u)lt.b(=C3=A6|y)te'      0.48(0.35+1.12)
> 0.50(0.40+1.23) +4.2%
>
> and this is with my squashed[2] changed on top of that :
>
> Test                                       HEAD^               HEAD
> ------------------------------------------------------------------------=
--------------
> 7820.1: perl grep 'how.to'                 0.48(0.36+1.16)
> 0.46(0.33+1.09) -4.2%
> 7820.2: perl grep '^how to'                0.45(0.34+1.12)
> 0.42(0.29+0.99) -6.7%
> 7820.3: perl grep '[how] to'               0.48(0.40+1.13)
> 0.52(0.43+1.16) +8.3%
> 7820.4: perl grep '(e.t[^ ]*|v.ry) rare'   69.12(69.10+1.07)
> 69.19(69.19+1.18) +0.1%
> 7820.5: perl grep 'm(=C3=BA|u)lt.b(=C3=A6|y)te'      0.49(0.38+1.17)
> 0.46(0.35+1.13) -6.1%
>
> the degenerate case is not something we can't fix anyway, since it is
> likely a locking issue inside PCRE2 (I see at most 1 CPU doing work),
> and the numbers are noisy because of the other problems I mentioned
> before (hardcoded to 8 threads, running in a laptop with low number of
> cores), which is why testing for performance regressions in windows is
> strongly encouraged, regardless
>
> Carlo
>
> [1] https://public-inbox.org/git/CAPUEspgH1v1zo7smzQWCV4rX9pKVKLV84gDSfC=
PdT7LffQxUWw@mail.gmail.com/
> [2] https://public-inbox.org/git/20190810030315.7519-1-carenas@gmail.com=
/
>

So I pointed GIT_PERF_LARGE_REPO to the monster mentioned above, ran the
test once for warmup and here are the results of the second run:

Test                                            origin/master       pcre2-=
xmalloc             pcre2-xmalloc+nedmalloc
=2D-----------------------------------------------------------------------=
---------------------------------------------
7820.1: basic grep 'how.to'                     1.59(2.93+1.75)     1.60(3=
.04+1.74) +0.6%     1.64(2.87+1.90) +3.1%
7820.2: extended grep 'how.to'                  1.59(2.98+1.66)     1.55(2=
.83+1.76) -2.5%     1.67(3.15+1.70) +5.0%
7820.3: perl grep 'how.to'                      1.25(1.21+2.13)     1.25(1=
.24+2.08) +0.0%     1.29(1.32+2.08) +3.2%
7820.5: basic grep '^how to'                    1.52(2.82+1.66)     1.51(2=
.68+1.77) -0.7%     1.64(3.07+1.69) +7.9%
7820.6: extended grep '^how to'                 1.57(2.84+1.75)     1.51(2=
.76+1.73) -3.8%     1.61(2.95+1.75) +2.5%
7820.7: perl grep '^how to'                     1.21(1.15+2.10)     1.22(1=
.26+1.98) +0.8%     1.27(1.22+2.09) +5.0%
7820.9: basic grep '[how] to'                   1.95(4.51+1.68)     1.96(4=
.48+1.69) +0.5%     2.00(4.66+1.65) +2.6%
7820.10: extended grep '[how] to'               1.96(4.54+1.65)     1.94(4=
.46+1.70) -1.0%     2.04(4.78+1.65) +4.1%
7820.11: perl grep '[how] to'                   1.29(1.58+1.88)     1.28(1=
.50+1.94) -0.8%     1.34(1.51+2.06) +3.9%
7820.13: basic grep '\(e.t[^ ]*\|v.ry\) rare'   8.17(13.18+1.50)    8.29(1=
3.36+1.37) +1.5%    8.31(13.33+1.60) +1.7%
7820.14: extended grep '(e.t[^ ]*|v.ry) rare'   8.13(13.03+1.59)    8.14(1=
3.12+1.47) +0.1%    8.30(13.35+1.56) +2.1%
7820.15: perl grep '(e.t[^ ]*|v.ry) rare'       34.96(35.80+1.68)   34.99(=
35.60+1.91) +0.1%   35.18(35.83+1.90) +0.6%
7820.17: basic grep 'm\(=C3=BA\|u\)lt.b\(=C3=A6\|y\)te'   1.57(3.03+1.64) =
    1.53(2.76+1.75) -2.5%     1.60(2.89+1.77) +1.9%
7820.18: extended grep 'm(=C3=BA|u)lt.b(=C3=A6|y)te'      1.52(2.83+1.69) =
    1.52(2.89+1.63) +0.0%     1.58(2.80+1.84) +3.9%
7820.19: perl grep 'm(=C3=BA|u)lt.b(=C3=A6|y)te'          1.20(1.25+2.02) =
    1.21(1.30+1.96) +0.8%     1.25(1.22+2.11) +4.2%

pcre2-xmalloc is my patch on top of master, +nedmalloc has the warning
fixes I sent earlier and sets USE_NED_MALLOC.

I don't understand why my performance is lower by factor 2.5 than yours
for all perl regex tests except 7820.15 (your 7820.4), where my system
is two times faster.  Debian Testing, GCC 9.1.0, i5-9600K, 16GB RAM.

Anyway, nedmalloc is slower across the board, but the impact of my
patch is in the noise.  Right?

Ren=C3=A9
