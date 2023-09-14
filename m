Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01E5DEEAA66
	for <git@archiver.kernel.org>; Thu, 14 Sep 2023 19:34:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233208AbjINTfB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Sep 2023 15:35:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231476AbjINTfA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Sep 2023 15:35:00 -0400
Received: from mout.web.de (mout.web.de [212.227.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C311726B7
        for <git@vger.kernel.org>; Thu, 14 Sep 2023 12:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
 t=1694720075; x=1695324875; i=l.s.r@web.de;
 bh=kmZszoKqBvAaCrG4TwuDId9JlO42Yk7SOfOLsw6D5+Y=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=XnqWkHh2sFT3drk4FMsxr5K/ZGZCi4XVdh3lY4Hc4nVKqfQqAb7LNiBCQcFzI7xkXOdOeF9Enm9
 RM0OVI9403Pr6Zf6DZtHKDvnAjpxfOhSIpS/hFUTRxe28hbnFcAKpUvQLas7Wd/8ma4Jpq0lWAc6x
 GHulwXL2a2gDJ3efU7DP14dF+/6A2p35KngE0tYn0UKt/6s4Afj6NI6wZwLxvHyAB3bdo03X4H3EH
 SviDa1TEEm4LtPiuLMnSIyoEd1AkDA6P+zgsvp0A+TRFP+mWfzzGI6g+otHjh9TBvrQLaZgv6REpo
 RHzmHoYV1PlP09iMoRlU7nqGcxUQSIUVmgqw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.147.159]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MvKXb-1rXSnK2yaf-00rDmA; Thu, 14
 Sep 2023 21:34:35 +0200
Message-ID: <29ea79e7-87fd-fa27-e9df-d626e27c7c74@web.de>
Date:   Thu, 14 Sep 2023 21:34:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 1/1] git-grep: improve the --show-function behaviour
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Calvin Wan <calvinwan@google.com>,
        =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=c3=b3n?= <carenas@gmail.com>,
        Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mathias Krause <minipli@grsecurity.net>,
        Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        Alexey Gladkov <legion@kernel.org>
References: <20230911121126.GA17383@redhat.com>
 <20230911121211.GA17401@redhat.com> <xmqq34zktk4h.fsf@gitster.g>
 <20230911231756.GA2840@redhat.com> <20230912130429.GA9982@redhat.com>
 <20230912135124.GA11315@redhat.com>
 <df05f761-c498-6930-bfd8-265f7e23d8ee@web.de> <xmqq1qf2lxrm.fsf@gitster.g>
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqq1qf2lxrm.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:B83akIapxuo8q+J8kfp1kTS1HP/qOJxERRUXDcf7oPOqHM9lXIc
 6HkWjWKrhGO+h9W4c2ZZSn2y8BEUMrv2QGP8LzoWd9S9qsHimMbuPk8i8WmnysfVDdFMkow
 nBIwQZK6F79faTl80AEnyd4GoGnCt+wc5duzjKmbZWxuMAbFHYh4hQ2TGykinIESDeHDnVO
 LbWOX6P8Fjb//PK37aHrQ==
UI-OutboundReport: notjunk:1;M01:P0:tl5GDzZlH6I=;8N/jiXCZ7dJaXgD+T9AJlTiyjzS
 1q1nwuX8F+HVRHbyGEPgFIt7ZsU978MCB5arsxeUds/seru7WIwQeM4XRtbuBppEfvf8DP77S
 czkG9La9YrGCAd9d2PzWTxSFLqj4Wiov8+YS3Y07AKYQ2zW3nyEjjxt3htmp3Sx+m0B/08AbL
 wZjZZkJaJNBZXnXnSTcFzbQ3PRERN6EoUZMwFa7eV6KOJOJ2/wyuq52XWvfv/jwMrSSNuXWan
 rSLs8eK3YpNQu4WSv1xBunLLz/OjqNX6vpY1JLgmCz5B5qU92Lem8/I2gbWjChUOmcsuhxRFL
 biqw70U4Col6nRLvLwv/RpCCBXoTcKmSMh0GGZ19llWDrZ2dVUURXh5jlJySo9Vhp6A6c/26W
 oPgquofulYY3PFwqNsnk8cRjJH8lmmq+VxSa/jlGpedQ9cRCw4AdzJJMVx5PP8wgYUGoKSr9N
 OthUnOu6GCXBlAd0OeLvlW8QKqtcIe6equ/BAAZ6B3vB0z5pBK1/wsZQeH9TtT7mymc0WMSAO
 D6WKF17Fnrs6uHbMV3U3iu5U7FjshZ7QyToU5E91P4UfvVJfJOHMFHmRrbJ7QiDhCe9+Q6DvK
 WD3a0DCdFw9h3lQzMYuUD83IUG3F9zxXDIwbKV+5b18GGaSxOi+Gl3s87SOxrvVl2n23NvaD2
 i8xRxJwQ/ZumcoC/+g4T+8Y1Pe2vbSy6rKQJlqQpOHXItjZNpWY+uzRQzfAYT9/iR5mp6Bm4X
 XKYWExkoduwRyanPR9aQvidASF6u3L+OQgrT0eAbeT1mP/AN05ci2mlPjWZYk60OoE7SHZbOx
 5m2mPsjGJQwnlZQn677H7JloJcwvxnLHS7B91u6sbsGC0vVoNRlRHLM/5H762jePL2zW/kMgV
 /uynPOPmvdHSWw73OoVArfKDL+05KanvXj8g98Pf6w2ESYTqh28hBra84naAMPE0EsxHZM44y
 ZSLJOg==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



Am 13.09.23 um 02:31 schrieb Junio C Hamano:
> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>
>>>> To me, this behaviour looks as
>>>>
>>>> 		Show the preceding line that contains the function name of
>>>> 		the match, unless the _PREVIOUS_ matching line is a function
>>>> 		name itself.
>>
>> To me it looks like:
>>
>> 		Show the preceding line that contains the function name of
>> 		the match.
>>
>> ("Show" meaning "show once", not "show for each match again and again".=
)
>>
>> Or:
>>
>> 		Show the preceding line that contains the function name of
>> 		the match, unless it is already shown for a different
>> 		reason, e.g. as a match or as the function line of a
>> 		previous match.
>
> Wow, that was a mouthful, but matches my understanding.  I na=C3=AFvely
> thought "when showing a hit, we may add the line that matches the
> function header pattern before the hit even that header line does
> not hit the grep pattern. But if the header line does hit the grep
> pattern, we do not bother show the same thing twice." was a
> reasonable goal to have.

I agree, and that's probably why I included the "unless the matching
line is a function name itself" part.  Not sure why the code doesn't
agree.  A test for that aspect would have been nice. *ahem*

Ren=C3=A9
