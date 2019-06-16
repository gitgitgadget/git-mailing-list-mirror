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
	by dcvr.yhbt.net (Postfix) with ESMTP id B70CE1F462
	for <e@80x24.org>; Sun, 16 Jun 2019 14:01:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727231AbfFPOBn (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Jun 2019 10:01:43 -0400
Received: from mout.web.de ([212.227.15.4]:56179 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727229AbfFPOBm (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Jun 2019 10:01:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1560693695;
        bh=+5+0fqUjZf/XBhjuL9RGKwHdkuZKwIKznU2iaj1WPzQ=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
        b=aUTwwGh62Je5bE8FscepbTTaM9FEjsnM6mI4JqG5DQQOF0sXsEv/uaoCusMHGUbVw
         2pRKc7r7TGV59fWa6hXsgss9pe1HZ06uVNNH88q17cVV9EaU0y4KDTBxMAKTeqO4uA
         FzKaRtKnMSEu6/ch/hQ0rqcBCi9s5isVlN/8TTRc=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.23] ([79.203.26.169]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MDjw6-1hqIwz3CwQ-00H4ck; Sun, 16
 Jun 2019 16:01:35 +0200
Subject: Re: [PATCH 4/4] config: avoid calling `labs()` on too-large data type
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.265.git.gitgitgadget@gmail.com>
 <9613c88849e53e00e1f7ade49c6c9056309ef0b9.1560426581.git.gitgitgadget@gmail.com>
 <03a68560-8058-7436-6edb-38e276a37190@web.de>
 <f22599d4-148f-212c-282c-790f5bde1706@web.de>
Message-ID: <90ef3797-78a6-f6d9-443b-387c0ab7cbe7@web.de>
Date:   Sun, 16 Jun 2019 16:01:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <f22599d4-148f-212c-282c-790f5bde1706@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:pty+fZ6cE0+8s75M+J10nMRhzibg3l5E2ljyq09hGWACsaubJB3
 Gax0IZ9nFK9gx8/w6p6YYjpCC9wKJLkcZYNgfWeQS6OmixACE3tlmpHsMlLRFPzQrcVORcy
 VjaZov/sa3aZvYd8B+69lX/eT8130dDAaR0b9+7gKhY2LYPCKLHFUh8W6UKkzY/ec4LZBxA
 OIvE04NVBEqpnnWpj1mFw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0jTLRlGwcKI=:9Ziaeg0W7TStBIJt1DOrBj
 6p2DOebemJoAJWBzRpaEVm8v8SlN0lkyl8r9PUCH1zRhiDsl9N0a/FWjhVlRmQhmIvj7+TJE/
 9hMegcrGZa68SjHvuM/Af2ZC89fpVBAk29k1bWejKBaE1N/+kEzjMW0xjUpRnZ9yXW36C4/0T
 ZWfJbSD6xu7wBVJKC7BL/5CvcYkuIQOqEfxipJe0TIGfriEFMeO2a30+STByC9sBrR0tTS6kr
 7PA7JgSn72UBnwCgNx/zSyLgjAqglyYXCpenZS0TKoH6C9oKCYxXT2oNfTQs7n3MGcAfX7S3S
 LwCJCi+m7b9wCvmyyi3ghM9nZGBVfU3PvocvJWOCCFQuQUeOE6sKErGQ8vf8/gy4h3ZboUMRw
 hdXgJzBcWR+NRtuy4naq/30Drc6S4Uj+aW92s0rkC+XGqp4J2xUbglc2rjfolIeuamOuh2Sig
 tMRmEZnCL+S+aomzW5AA+poRcAgLH0KqqDGWveGSNwwjpId7yIXTDjtcxWB9ZxzgoLw6/E1Uu
 1SUPZgHTpXHVIXJmM/uUZaCJM+2dnA0r8rLuQ2i2KpfLmhDzmSLomZ5sszS+tNH9hIjlhFLHI
 yi/VaeOW+SkM+ZFakTVhKz2KQR85aLcGLyPv0A1LSTqqEn1/dUEgijN3NwsaNjvWSobxFaodx
 C1FJQWQlz2/OxSLXh44K6GfuErjcvpX8DEQ5mzFlBwuFy+WS+nTQnJaDHY5zStLilZHla7wcd
 dsPJgWL70gAR6ces1Cv/tDg19Twv16uZWMplvxzElcZX5qidoQFzwcx0CMdKJgEULB0H4XHc9
 zfTpo3Lk65SjWC6j2f97i+HLFIC1fagaTqrXw5CIb5w7BbwT3LMzTOCs4fLpUemWtVzMUIsH9
 iPSHIxnt6+uLwoOyX5C87K06JcQ6aSCtvEk6AlDBUsQq3HKM0rlW7lg09nJP1Xz1RxyxW1HW7
 sahsx4pLnkb0OhYZq8kU8tYVjymn65/U=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 16.06.19 um 10:24 schrieb Ren=C3=A9 Scharfe:
> Am 16.06.19 um 08:48 schrieb Ren=C3=A9 Scharfe:
>> Am 13.06.19 um 13:49 schrieb Johannes Schindelin via GitGitGadget:
>>> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>>>
>>> The `labs()` function operates, as the initial `l` suggests, on `long`
>>> parameters. However, in `config.c` we tried to use it on values of typ=
e
>>> `intmax_t`.
>>>
>>> This problem was found by GCC v9.x.
>>>
>>> To fix it, let's just "unroll" the function (i.e. negate the value if =
it
>>> is negative).
>>
>> There's also imaxabs(3).
>>
>>>
>>> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>>> ---
>>>  config.c | 4 ++--
>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/config.c b/config.c
>>> index 296a6d9cc4..01c6e9df23 100644
>>> --- a/config.c
>>> +++ b/config.c
>>> @@ -869,9 +869,9 @@ static int git_parse_signed(const char *value, int=
max_t *ret, intmax_t max)
>>>  			errno =3D EINVAL;
>>>  			return 0;
>>>  		}
>>> -		uval =3D labs(val);
>>> +		uval =3D val < 0 ? -val : val;
>>>  		uval *=3D factor;
>>> -		if (uval > max || labs(val) > uval) {
>>> +		if (uval > max || (val < 0 ? -val : val) > uval) {
>>>  			errno =3D ERANGE;
>>>  			return 0;
>>>  		}
>>
>> So this check uses unsigned arithmetic to find out if the multiplicatio=
n
>> overflows, right?  Let's say value is "4G", then val will be 4 and
>> factor will be 2^30.  Multiplying the two yields 2^32.  On a 32-bit
>> system this will wrap around to 0, so that's what we get for uval there=
.
>> The range check will then pass unless max is negative, which is wrong.
>
> No, this example is wrong.  (I need to remember to take baby steps while
> carrying numbers. o_O)
>
> So value =3D "5G", then val =3D 5 and factor =3D 2^30.  After multiplica=
tion
> uval =3D 2^32 + 2^30, on 32-bit machines this is 2^30 due to wrap-around=
.

Yeah, except that in the real world uintmax_t is 8 bytes wide
everywhere, even on x86 and ARM.  So the code should be fine as-is.  It
would be in trouble if we introduced bigger units, like T for 2^40 etc.,
though.

Anyway, the code would be easier to read and ready for any units if it
used unsigned_mult_overflows; would have saved me time spent painfully
wading through the math at least.  (Hopefully that's just my problem,
though.)

Ren=C3=A9
