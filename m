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
	by dcvr.yhbt.net (Postfix) with ESMTP id 23FAA1F731
	for <e@80x24.org>; Wed,  7 Aug 2019 13:03:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388038AbfHGNDG (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Aug 2019 09:03:06 -0400
Received: from mout.web.de ([212.227.15.14]:51627 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387799AbfHGNDF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Aug 2019 09:03:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1565182978;
        bh=XUHnNQjKHvPHnmFq4Gk5ndAakkQGJPchxYe8PBHSFj4=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=nqIpAde1kQhIp06BPUesdXlo7IlergBCXYjpmIJOk5HLCxorNU9K5ai9cgX7+F6rp
         sticUyc08GZBy85W8seF3OeZuGzthNZkjt4D9V4+8PY4i+Gw0ICu4CdfXips26msiK
         rjnexyQ3N1RPX8ptNrW6RK2SW5h2kdSmzzyesXb4=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.23] ([79.203.24.71]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MfkOq-1hjBzy24YO-00NAAt; Wed, 07
 Aug 2019 15:02:58 +0200
Subject: Re: [RFC PATCH v3 2/3] grep: make PCRE2 aware of custom allocator
To:     Carlo Arenas <carenas@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, johannes.schindelin@gmx.de,
        avarab@gmail.com, michal.kiedrowicz@gmail.com
References: <20190806085014.47776-1-carenas@gmail.com>
 <20190806163658.66932-1-carenas@gmail.com>
 <20190806163658.66932-3-carenas@gmail.com>
 <ab8a378c-0a60-9554-b2dd-ecb3d05229cb@web.de>
 <CAPUEspip98Mq8FrKTOkEikZhaLPprZXf=E2x3d0b7=c7e5+Gyw@mail.gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <c7f08e19-88a7-ca7f-90b9-54465e621d49@web.de>
Date:   Wed, 7 Aug 2019 15:02:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAPUEspip98Mq8FrKTOkEikZhaLPprZXf=E2x3d0b7=c7e5+Gyw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1uJ6/vap3xashHIUpzw1L9ezUOpXC9FMSMirRCzu7gzR3ft2TPj
 dogrVmvUznMPISmDiQkVOWRFuJuMJgVtwHmQMppZHqi3prSPb0RWdqpyuSp4pzRnFt/LGaF
 84JmU1ZeEHcibhmZrJuC6qu8zjUnXxNKlph140ahV3CtuLnwN4oQEP72bpM1xaKJ1bjNrA2
 pspf02XpyQp88shqnFyKg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:WsnuS90CSqU=:8vVjiKRR4l2nasmqVXB/4r
 /bhWpeGWRiHrB3ub58j3LlOv4lkXkzjugc3GNSIhZm6nhoSYxj5mwCIthuz5KA4s3i5A+NlEg
 piSYsMPp6eRd4qkjqKNiEnwUShLUPjmIsNk7dPN1uIUAWtf19BUV0RmckO7qTlMr8DTvMhUja
 0hX636O4hkKgyQ5jjaiHm8e0fL9s8151KQptkys4/9b5BE6/Gpy7CFQsIJrCQEQTJGYBe2eeA
 qHDHMd7/C2a5Gl18iA9LlpE+GgcwSJr9LDyvE+A2gWbl3H+5Ougmst0JaYkAdij2caAMX2L34
 X5epGc93sJdWXUkugjM5G1UF+AYzn1LW7pBY8uCrqbYbwvR8VIPjhFNGeMR7hqOhxUt+HNou8
 BtXH4MAqMzaKVG2C5DQCH7iOs7I+2P7VE/Arca2NORdPT4gXeS742fhqVTbSTq+6byl1JZyyF
 sVDiWdmHGhLJj5zRpYyRBLbqvEZ2q+6ymoy7b60rjX1x01I6HT+hSbk0EZk8X9Zp5EJ4MK/Nk
 OTFwk1swMJSsx2ylzwZk9yX6DAH44coP3rGVpk/cHraCrS4OUcvPpPeO5hxmSS4xv41r+4Miv
 VY9I+zDUmoQFtAsTl992WGRrbAcIbuf8XYQQlxWaRAG3lFiNWWvA5KRurzfnaz46RbtIF2me7
 i1Br3lovYlL+5bC0ea+AJuKBKWKBfTYkHS+6pNuAOgVKTvFTZ5z2ShBofNwiRXyVqJBgA0mKx
 AQXsy7pkgxtODM86wsOSvjLI8KPilfr0dJ7hengyKELTJjdm6QDNeAWCV0+Yn762dIoHKmbKa
 8YabRl3bk+DziEi+1MxMei0dqlCKsh8EHdjmzjfxa+V0UNvGocnQI8b/qbbKUO5MySD1KMuoV
 Qt+sAhuuSmFaBQ2pOP7M3Z5s1zX0T0Of2uvmOx/mBZKfIucXb93oxXhWWqRp89bBLdamJ+K5y
 oTaDGPsor574naXfuKJ7PIBt/PWRqXuGvkD8uBc6wmobHjsKdt4+cktvcSEOOioJrzxsS2gxW
 MCyEh0MzGwd7unG+zDcbT0ei6bFGke5CvA2e0v6omg9PbVtdK3sVA2H81lFBaCD/A2hp2b7lW
 Dx/j/hB+BMcPreQaB9hAdFHhFfbHXHQ9uWHqkmsldvad7JVMAha3Mj4HmV9l3iHhmriD4R86Y
 MHTm0=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 07.08.19 um 11:49 schrieb Carlo Arenas:
> was hoping will perform better but it seems that testing can be done
> only in windows

nedmalloc works on other platforms as well.  On Debian Testing with GCC
9.1.0 I need two changes to suppress some compiler warnings, though.
Will post them as replies.

"make USE_NED_ALLOCATOR=3D1 test" then reports these failures:

t7816-grep-binary-pattern.sh                     (Wstat: 256 Tests: 145 Fa=
iled: 5)
  Failed tests:  48, 54, 57, 60, 63
  Non-zero exit status: 1

And the first one when running that test with --verbose and --immediate
is showing:

BUG: grep.c:510: pcre2_global_context uninitialized
Aborted
not ok 48 - LC_ALL=3D'C' git grep -P -f f -i '[=C3=A6]<NUL>=C3=B0' a
#
#				printf '[=C3=A6]Q=C3=B0' | q_to_nul >f &&
#				LC_ALL=3D'C' git grep -P -f f -i a
#
