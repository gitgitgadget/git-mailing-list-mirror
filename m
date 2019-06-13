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
	by dcvr.yhbt.net (Postfix) with ESMTP id 75B041F462
	for <e@80x24.org>; Thu, 13 Jun 2019 21:33:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbfFMVdJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jun 2019 17:33:09 -0400
Received: from mout.web.de ([212.227.17.11]:50929 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726766AbfFMVdJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jun 2019 17:33:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1560461581;
        bh=jOYwxkoYmzyXuG5/7hZknqAiWXLqovngawnJZOfTT/c=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=l37SSCc1r+U3RdasPKXXE292amrAZYwC++NNggvnyWRRRZ/hWuBSX5RwdyyRQRxBK
         3ovlmvED4kz/gsXU1P2T1lXo7gOUQFRcnDJaj0hmYNX3sgGx6KG6dwzh8SNH2URQCG
         1VIUC4zw4C8LnrpB7mttlJQblI4ayuVCoC6C/FuI=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.23] ([79.203.26.169]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Lrazp-1ieY4021jJ-013Pu4; Thu, 13
 Jun 2019 23:33:01 +0200
Subject: Re: [PATCH] cleanup: fix possible overflow errors in binary search,
 part 2
To:     =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
References: <f0059613-d3e4-a1e2-2c01-727579e069d2@web.de>
 <CAN0heSriaQV7zd4h8gfazi0dY_Dc5qLBWfJBtZGxOtm1+cgZqw@mail.gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <1473675e-4d27-8221-0e7a-f88eb31ee11f@web.de>
Date:   Thu, 13 Jun 2019 23:33:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAN0heSriaQV7zd4h8gfazi0dY_Dc5qLBWfJBtZGxOtm1+cgZqw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XLOEUEVy86Sjj0UMf9PXaT/wvn0MJVHm1hvZ0C3tEhD3ybpiXc5
 CI2iV20bW8ayYGnZM18Nu/4Q8RhSnJxz1bwous+yFLe5fNIV4piEafxU+n7Os2d4ErrIpiE
 A/oxplGJA8KMlkAqg/z9tYjqsyDIUZxDYGU+eG/om/EapzeUm7pWOqhJgk4yL39PuBI4aBe
 UzGiabH7xW8lnFBvD22Bw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:V2/rmtHtAdE=:bUjnH0uoK1JZLpvE7Fa6bS
 qTWVXOx3qojJ+4AVwdugh3lvY7YSOS/d1HyhPxZUZO6hePFNOYY28QQE9zLQ9jOw48lkNXypo
 pwa/IUzBQ8+IonhI39KJnaUJisbUHzjIEA7m2RJrfTH8BmR2gVoG1/6qUCqg/xWj5C9k12Z5V
 4srZG1BE5kve/kt4Utu6s0gO7e4b0oIHd9ERRtNUyD23sVKeaQjVcGPquPc5J1XTDx0lv7Vid
 E/k1jy+YsL6oeKRFeGQWkzIG81E1wmyKZiDJ40MJSKrp85JeBW5mbZhpmseDmwLu/fJF3SIaI
 DTg/5eWGMDYM/uE+zIBgYa+xXNGNyVyaDMP3LYiQNRQy7wjBY6arKhJzDdgQOuixjw4H17AOq
 zdLv+Yv0sawnhZ4pDFUrtc9l8NiboxK2YK7DYXFej2LIrZMOUAiuh30UAYU61I9jKCrFtWjiw
 pzCThhV8j6dr3X6KWaRf3s3pM5quVIXQBcU9ES+6zvRIafXcMYX5Wv8+7YkW23poiucGHC6h8
 nlY82MUAdRhBdXf2hLlxVFJdAX5zL7k3z7JprpkY2sgoeUFWp0aqqFvNfWlIk6uvczyvi0Pyq
 IMkT5WXlaLF8MR45BGXHGaK2v+J9vrO2x1s+fHCW0WceP6vC+37FM2UliE3XYMsdCmywFsNGp
 3bc9p3qkyask5uJvUkRY4cZmcjd20fjRY3W7jRmPI+aRRAgXhr+Jpb2iOYMDUbEfaAJIij73M
 NUBNeZQzVJuc3CaXI1PRTaikDcmW0GDu2wd/vmGSbnhZfFRbwBhgGaKJtpltT4vhmc4C0aLCF
 vYGXhdgUUv/ipv6HF0pe86OI4Y1258WTEaxsXESGWDS9IX1+5PIvUvA9kediIq5vez2YycdbG
 PhA8LD+i7DDdzhAU+NbsrmGs4nVmmPTs2aX0iMGqKUCjS/sGBeVL1j1zZPoOr4IpAoZMWPvu/
 KSfeZ5pjpwEh147t371lpa+11ioOIws0=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 13.06.19 um 21:42 schrieb Martin =C3=85gren:
> On Thu, 13 Jun 2019 at 19:54, Ren=C3=A9 Scharfe <l.s.r@web.de> wrote:
>>
>> Calculating the sum of two array indexes to find the midpoint between
>> them can overflow, i.e. code like this is unsafe for big arrays:
>>
>>         mid =3D (first + last) >> 1;
>>
>> Make sure the intermediate value stays within the boundaries instead,
>> like this:
>>
>>         mid =3D first + ((last - first) >> 1);
>>
>> The loop condition of the binary search makes sure that 'last' is
>> always greater than 'first', so this is safe as long as 'first' is
>> not negative.  And that can be verified easily using the pre-context
>> of each change, except for name-hash.c, so add an assertion to that
>> effect there.
>
> Right, with "safe", one might mean something like "no undefined behavior
> due to shifting a signed value with the high bit set". Especially since
> we're worrying about overflows, we're obviously having large values in
> mind, so we're right to consider the sign bit. But, we're fine as you
> note.  Because we subtract, and `last` doesn't have its sign bit set,
> and `first` is non-negative and not greater than `last`, the sign bit of
> `(last - first)` is always zero.
>
> So all is well. But maybe we should write `(last - first) / 2` anyway.
> We could then drop the extra parenthesis, and we would keep future
> readers (and static analysis?) from wondering whether we might ever be
> shifting a signed value with the sign bit set. A few spots fewer to
> audit in the future...

Yes, thought about that.  When I saw Clang 8 emitting extra opcodes for
handling the sign for the version with division I decided to restrict
the patch to just do overflow prevention and leave the right shifts in
place..

Ren=C3=A9
