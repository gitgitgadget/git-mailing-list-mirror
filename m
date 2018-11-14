Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A91241F87F
	for <e@80x24.org>; Wed, 14 Nov 2018 03:53:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728066AbeKNNyq (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Nov 2018 08:54:46 -0500
Received: from avasout05.plus.net ([84.93.230.250]:48071 "EHLO
        avasout05.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727536AbeKNNyq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Nov 2018 08:54:46 -0500
Received: from [10.0.2.15] ([146.198.133.33])
        by smtp with ESMTPA
        id MmEzgTwSeb8UmMmF0gFJqU; Wed, 14 Nov 2018 03:53:22 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=cOzOTGWN c=1 sm=1 tr=0
 a=VCDsReDbrwk4B7AcQzWGLw==:117 a=VCDsReDbrwk4B7AcQzWGLw==:17
 a=IkcTkHD0fZMA:10 a=hoNKJ6UkKhrvR8pn4VsA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH v5 02/12] sha1-file: provide functions to look up hash
 algorithms
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Christian Couder <christian.couder@gmail.com>
References: <20181025024005.154208-1-sandals@crustytoothpaste.net>
 <20181104234458.139223-1-sandals@crustytoothpaste.net>
 <20181104234458.139223-3-sandals@crustytoothpaste.net>
 <06e5bc95-b901-163a-5088-888878187ca2@gmail.com>
 <000ff851-3068-36f0-4fff-1e69cd24cbec@ramsayjones.plus.com>
 <20181114021118.GN890086@genre.crustytoothpaste.net>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <79b436d4-48f9-8e38-0dbe-1831aa3fc208@ramsayjones.plus.com>
Date:   Wed, 14 Nov 2018 03:53:20 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181114021118.GN890086@genre.crustytoothpaste.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfCZNQiyX0TNOWyWgnBe7+H4Ywxq+BLn09kYEHbv1QddLRV5rLAHpAuemereIrtou5XvBMOQaHKXVMcyOfOUSlEWLDjQ6COctt+DqGPLxKBSQq7nmjW1v
 d2sNa9T3ETxkClL0pjnsKTiIGu3UIMZtkGrYa27gOBDU03iGp96KGNGy4STVBzyArhN/07nQ9+s/hw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 14/11/2018 02:11, brian m. carlson wrote:
> On Wed, Nov 14, 2018 at 12:11:07AM +0000, Ramsay Jones wrote:
>>
>>
>> On 13/11/2018 18:42, Derrick Stolee wrote:
>>> On 11/4/2018 6:44 PM, brian m. carlson wrote:
>>>> +int hash_algo_by_name(const char *name)
>>>> +{
>>>> +    int i;
>>>> +    if (!name)
>>>> +        return GIT_HASH_UNKNOWN;
>>>> +    for (i = 1; i < GIT_HASH_NALGOS; i++)
>>>> +        if (!strcmp(name, hash_algos[i].name))
>>>> +            return i;
>>>> +    return GIT_HASH_UNKNOWN;
>>>> +}
>>>> +
>>>
>>> Today's test coverage report [1] shows this method is not covered in the test suite. Looking at 'pu', it doesn't have any callers.
>>>
>>> Do you have a work in progress series that will use this? Could we add a test-tool to exercise this somehow?
>>
>> There are actually 4 unused external symbols resulting from Brian's
>> 'bc/sha-256' branch. The new unused externals in 'pu' looks like:
>>
>>     $ diff nsc psc
>>     37a38,39
>>     > hex.o	- hash_to_hex
> 
> I have code that uses this in my object-id-part15 series.  I also have
> another series coming after this one that makes heavy use of it.
> 
>>     > hex.o	- hash_to_hex_algop_r
> 
> I believe this is because it's inline, since it is indeed used just a
> few lines below its definition.  I'll drop the inline, since it's meant
> to be externally visible.

No, this has nothing to do with the 'inline', it is simply not
called outside of hex.c (at present). If you look at the assembler
(objdump -d hex.o), you will find practically all of the function
calls in that file are inlined (even those not marked with 'inline').

[I think the external declaration in cache.h forces the compiler to
add the external definition, despite the 'inline'. If you remove the
'inline' and re-compile and disassemble again, the result is identical.]

Thanks for confirming upcoming patches will add uses for all of
these functions - I suspected that would be the case.

Thanks!

ATB,
Ramsay Jones

> 
>>     > sha1-file.o	- hash_algo_by_id
> 
> This will be used when I write pack index v3, which will be in my
> object-id-part15 series.
> 
>>     > sha1-file.o	- hash_algo_by_name
> 
> This is used in my object-id-part15 series.
> 
