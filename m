Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5877DC433B4
	for <git@archiver.kernel.org>; Tue,  4 May 2021 18:48:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30440610C8
	for <git@archiver.kernel.org>; Tue,  4 May 2021 18:48:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231432AbhEDStA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 May 2021 14:49:00 -0400
Received: from mout.web.de ([212.227.15.14]:33319 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231234AbhEDSs7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 May 2021 14:48:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1620154077;
        bh=NY8deMV6+S5bNdlV++6mT5jdOJPg2C//9pb+0djObWM=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=R7ISyI0Fx7qUzMNPrsyo/vspio9Ag0W5wn3rRftIrRpmEeaUzAHAMENxoRFFx7hxc
         fiIRSFOUKPT5nOIHrIBMjTnXZVu/mV+N4qeUv1l/3GWmFRrH3ezarx4mYR+A7CNkIN
         UZqQZq85Ak5/LOWUNK/O7o9j2UR2pFNzKtt5JT2I=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([79.203.31.60]) by smtp.web.de
 (mrweb006 [213.165.67.108]) with ESMTPSA (Nemesis) id
 1MZB01-1lzoKa1WfB-00VDFn; Tue, 04 May 2021 20:47:57 +0200
Subject: Re: [PATCH 3/5] pack-objects: clamp negative window size to 0
To:     Jeff King <peff@peff.net>, Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, Yiyuan guo <yguoaz@gmail.com>
References: <YI1fbERSuS7Y3LKh@coredump.intra.peff.net>
 <YI1fubjvQQlrPz9D@coredump.intra.peff.net>
 <3d77d70b-2cc5-4ca9-8753-fa9af5111842@gmail.com>
 <YJAOzTIXkO2lhxSs@coredump.intra.peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <02a66bfb-aac0-c05e-dab3-366bc312d900@web.de>
Date:   Tue, 4 May 2021 20:47:56 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <YJAOzTIXkO2lhxSs@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0iFS1muLkkDM5yYP2Ho/QjwLNqcpi2aB1COIXzzP94qrEjLTA5m
 vO2/5hAcfdSpGQPHi5Dhu2f1rpD/2ZhNLvRCLnHpcQEWeagr/1STRaGsOmiVflQruhTOzuH
 acUaAh6NGrJHF9FmpImPRQ9eZgMuZOKg/+Td7vAjnhAiObOKVswIF5mbWkNrKFztrB3k+f/
 NiSVwrtP4Omf2CJJFmBEw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:gHSLV+DnLBA=:Oe/4HawMqkb9QC36SjUS+9
 z8jKo70aFyI/bgQWS2SDqQlZv93/dk6sMYfJh1MIPT7H0JIKt+Y29OGsRz7VgnAPNye9ilE+Y
 8fmDvVQ3Z+MdCiieE/J+R+LsJkTm3Dd/w3cg/EGEb/mTR0rt8T4ALsrq0hphPyaUm3NP1vsTL
 0QwEZTvHWuzg3iXdw0Mt9OYEJ4AyjD5yZEqbL+NrfetpkHg8X0w12Z32g/vNisVxP/8nVh1GA
 6hopfiDtVkUee+6EykC50w9cbLI8DBK5OZorZGzny6snDsWd9ZDgHFQyGW1hpIHm/MCLhf4re
 pn4EDiSiR1xdk8oVqdQ3sRox+yCQH18R8ybrevZ61/CPYNJ1E5fRuyxGBn2gmTnFiMRDoV1EU
 v76oM7N8YWVouKfB/EK+cGRbrVXmoFZCdW2nLyy3nK4qCpbDYrOEiT/hpmXzJpKmuUrgRhIXW
 s9CnVFIAs9oF1ucYU7IPjATUx4j2FRL1RqHqsvFq1cAz+ZVeC20NxUz7//3oYYzakPCrml8Z3
 1COafHbMEaO+B5cHtjd5nVARHJN8Pp8Ks6SstdrnAVujjgv/wVTsgRYKQkjscB/bc7bSpmJAP
 8xui1oeoIPtnJe6KVaUPUGuX9yx+n7DaZwjPd4HTocQAzpJzm5wQB9sYcFtTiZcFea4qKDrxn
 +2PoQtvFgZ5K48+vHanGEaEEI7M7nR1msrYxgAqclULDqjMx6n1ux7Yu3uMOwIIxPv0W8kg/o
 NBkC1yTqe7bhMXlkGpKjg8F/vMwaOFQ3mJSaHvNSD5UuqGtLneVpYNReokLm5CaMSGe2dwhlc
 WKa4M8VeUddajYQJDLCZ0+j3aF7piZDpWzQ7RrZq8Wxg52jLd7SHjJErNU+EeUcB19+u7AX4P
 5em2n2yi6hSeB4Hyyi+97lYNg+1XQQtl2l0Vd+i9+Gh7rAMP9Ink+7hfh0hr/x3lb4ZsupsHq
 RrKaMOQsGZQpW/ZvF3ZntWMoeQnV+MS0BvbHsMVRfjsuQ+BwxQZv0WNtR/+C7ox9PHqy3hLxa
 SsIwSoJorI8rdmd0RG3EqF7B3GxNQK+g/seaMDMlwAKjYeOH8ZBW3Ysjs07IM4eM2gLj6B1La
 8pFgo85MBDrfGm8eCHcdP5LxBixxDEi//PKRetIvVTegHZvfPWfiQJwoODDaWRrBiQHJNfHzN
 o2C9IaMSftVeFH3lL1th1t+PONbSaKy5GnO3iRc79x+Ku4ccm2uSbgvmYwzt8z54640Hk=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 03.05.21 um 16:55 schrieb Jeff King:
> On Mon, May 03, 2021 at 08:10:24AM -0400, Derrick Stolee wrote:
>
>> On 5/1/2021 10:03 AM, Jeff King wrote:
>>> A negative window size makes no sense, and the code in find_deltas() i=
s
>>> not prepared to handle it. If you pass "-1", for example, we end up
>>> generate a 0-length array of "struct unpacked", but our loop assumes i=
t
>>> has at least one entry in it (and we end up reading garbage memory).
>>>
>>> We could complain to the user about this, but it's more forgiving to
>>> just clamp it to 0, which means "do not find any deltas at all". The
>>> 0-case is already tested earlier in the script, so we'll make sure thi=
s
>>> does the same thing.
>>
>> This seems like a reasonable approach. It takes existing "undefined"
>> behavior and turns it into well-understood, "defined" behavior.
>
> I was on the fence on doing that, or just:
>
>   if (window < 0)
> 	die("sorry dude, negative windows are nonsense");
>
> So if anybody has a strong preference, I could be easily persuaded. Part
> of what led me to being forgiving was that we similarly clamp too-large
> depth values (with a warning; I didn't think it was really necessary
> here, though).

There's another option: Mapping -1 or all negative values to the
maximum:

	if (window < 0)
		window =3D INT_MAX;
	if (depth < 0)
		depth =3D (1 << OE_DEPTH_BITS) - 1;

That's allows saying "gimme all you got" without knowing or being
willing to type out the exact maximum value, which may change between
versions.  Not all that useful for --window, I guess.  That convention
has been used elsewhere I'm sure, but can't point out a concrete
example.  $arr[-1] get the last item of the array $arr in PowerShell,
though, which is kind of similar.

Sure, you get the same effect in both cases by typing 2147483647, but
-1 is more convenient.

Not a strong preference, but I thought it was at least worth
mentioning that particular bike shed color. :)

Ren=C3=A9
