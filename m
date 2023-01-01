Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93D26C4332F
	for <git@archiver.kernel.org>; Sun,  1 Jan 2023 10:45:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbjAAKpt (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 1 Jan 2023 05:45:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjAAKps (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Jan 2023 05:45:48 -0500
Received: from mout.web.de (mout.web.de [212.227.15.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37B7638C
        for <git@vger.kernel.org>; Sun,  1 Jan 2023 02:45:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1672569942; bh=F7leMB7+DzcaNjFPcaKRUfFSZm8Z3kaJHmSGdVdoh8U=;
        h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
        b=UZKvS8rod4+d6R0iwFNBwdYv72uH4qJTIltItkVRcNiIy4EleWrx3GdFEVqKvopNj
         f3+KOQVWikzb/13ciJ2HD63L5el0fWfTt4JLYNMV07z3z7Lu9imCfq6xX2cI8hk1zF
         b9v4F1ocV/kM90TrWltKThjK2w0+qKZb2YW+87k/wHY5weaw2e7JGpokbQqFf9MRc0
         FXL6CpCeZEMDfS7EVPGNXmMc1srivH+FjxSf9pC3R+9lmXpIZJ669Aqvzue41nBVKE
         TO7NBF81CGaeZD5nULMXUAloXQ6z1HPRE6Z3JA9qAh9Lu5FaMFyqUcENegkXub9Sk/
         ir3tJH69ByGhw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.151.35]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M6091-1pA2Ig3ykV-007UNA; Sun, 01
 Jan 2023 11:45:41 +0100
Message-ID: <bf4e6798-c687-270d-1344-37bacb403e13@web.de>
Date:   Sun, 1 Jan 2023 11:45:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH 1/3] do full type check in COPY_ARRAY and MOVE_ARRAY
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>
References: <efe7ec20-201e-a1c1-8e16-2f714a0aee8e@web.de>
 <f3b9e9be-06ef-3773-a496-da5e479f9d49@web.de> <xmqq8rinhs7t.fsf@gitster.g>
 <xmqqsfguhplc.fsf@gitster.g> <220515b3-3924-c8d2-ff20-7017caa7dead@web.de>
In-Reply-To: <220515b3-3924-c8d2-ff20-7017caa7dead@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/+iYQxMNLlNsBGTKT/987YhHo47J4mpHjLVA0PiiCWpBbHSjX5k
 LwJmqv9X2u9TehEqUNZHVoh1Cjb29/u1xVDXGjj5I+TML0QtiJkSN3bc7OA9TJ4DhBlSuF9
 NOdIQO0lOUYuVbmY57c3ktxm2Yd48Nt5CPchL8LXUe2bl7pYkPdcC2SZQwOcT8qtXgmJanx
 jHid1pKU3VBRLxGiJAwbg==
UI-OutboundReport: notjunk:1;M01:P0:6t7Usu96zOo=;tzftm4qNMtQJlmSRiLhSLvfDuW0
 M9BV8S5PzB8B2bU1uWM6ynVnL4bgrHElAxnggx5LSRUW9QcesH4Veo7JYCVyC5PjgpjZYXY1l
 JD83Mt5oi1ldcgbKh+nnMIlF/AN47zNBYR2d/UymmFFx7NG99jhkll7v8HcHIFkUMpjahCAUs
 xlXK6m/jCiwxgBvu3+EDRFWm+ra7O1MTjzQcamfgaWv88eKouPPTetguLPupNoNxnHQmIR+UC
 FnPmW37IWO2Nto8zHRb6Bjto98GXS+b6AGz7XMks8Chac3IWslWxqDoa/UkoAy88Kfq2sSK3+
 tpsbZrQdYIr2sA7PLqs4o1f0lc/zpF9+xF8Sgj6HyHhgU9xgcX6msJiQQnJ0j7gS9Nilzhaeu
 27qdPp6gmjeKQwq143J+J38ojWLB1HmDgH9iibE/JFIED/xpiHDQso5AzLjJfKbRRuLHl6P3c
 uEM1LCRKIIBxdZ2TXpz9xv5JjOnN4pTt8Ohi6P3aq9BTgsbLiRHA7xY4qTpBT+zyBFGPIr7uY
 jw6ZNEUgSJyNoFcJxgyauPmb7fMfXPkYmwJpMeUuslQBsLK+PJXNlzItzFP095JcRUPyZ86DU
 cpRNixthozKznHmxHQ9PCU2hYDWP5L+feJ02xu50v3Nju7vxvTjGneYdHa2EdgwW+IE4f/u6A
 xb3qjetoPsReXhVMIC9161BXrcleZP/piIHpiFWWZz1S/1lvm8xI+GyB3JANUHlwP4DoEV1zN
 z7SoXiUSDf1fqOuVzM0+AATXEQqr7YbteEEchtHx+kHkK8/L3LuTb/ven0gmEq1XcuUY3Qlz6
 Yhwjd//PmKW5VQNopBZnoGqX/iF4hjhp/fDUKuAM+fyF7Ni3lf2Wh3USt/Uu5r9y/28AzY3w/
 ZXmaFMQrfVkmfuEidIFzH8xeZhjY1FPaN8iWn/jybT+0bRdWWpKl1N0fY++8plKCsPatLMa6k
 UXZ+4RsJ5Atr+anREj7X1NfI+QY=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 01.01.23 um 08:41 schrieb Ren=C3=A9 Scharfe:
> Am 01.01.23 um 04:59 schrieb Junio C Hamano:
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>> ...  I think what you ideally want to enforce is that
>>> typeof(dst) is exactly typeof(src), or typeof(src) sans constness
>>> (i.e. you can populate non-const array from a const template)?
>
> Yes.
>
> Moving the type check shared between COPY_ARRAY and MOVE_ARRAY to a new
> macro is a good idea.
>
> Using compiler extensions when available, as we already do for other
> purposes, is a good idea as well.  I managed to ignore the existing use
> somehow.

On second thought, what do we gain by using __builtin_types_compatible_p
here?  Does it catch cases that the assignment check plus the element
size check wouldn't?

>
>>
>> IOW, I am wondering if something like this is an improvement.
>>
>>  git-compat-util.h | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git c/git-compat-util.h w/git-compat-util.h
>> index a76d0526f7..be435615f0 100644
>> --- c/git-compat-util.h
>> +++ w/git-compat-util.h
>> @@ -97,8 +97,13 @@ struct strbuf;
>>  # define BARF_UNLESS_AN_ARRAY(arr)						\
>>  	BUILD_ASSERT_OR_ZERO(!__builtin_types_compatible_p(__typeof__(arr), \
>>  							   __typeof__(&(arr)[0])))
>> +# define ARRAYS_COPYABLE_OR_ZERO(src,dst) \
>> +	(BUILD_ASSERT_OR_ZERO(!__builtin_types_compatible_p(__typeof__(src), =
\
>> +							    __typeof__(dst))) + \

We actually need to compare the types of the elements here, because
otherwise we'd disallow copies between arrays (int arr[7]) and pointers
(int *p), which would be unnecessarily strict.

>> +			      (0 ? *(dst) =3D *(src) : 0))

You dropped the ", 0" after the assignment, but we need it to make the
type of this expression int instead of whatever type *dst and *src have.

>>  #else
>>  # define BARF_UNLESS_AN_ARRAY(arr) 0
>> +# define ARRAYS_COPYABLE_OR_ZERO(src,dst) (0 ? *(dst) =3D *(src) : 0))
>>  #endif
>>  /*
>>   * ARRAY_SIZE - get the number of elements in a visible array
