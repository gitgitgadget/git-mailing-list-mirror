Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 31C121F462
	for <e@80x24.org>; Fri, 14 Jun 2019 21:24:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbfFNVYm (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Jun 2019 17:24:42 -0400
Received: from avasout04.plus.net ([212.159.14.19]:50260 "EHLO
        avasout04.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725809AbfFNVYm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jun 2019 17:24:42 -0400
Received: from [10.0.2.15] ([87.115.253.20])
        by smtp with ESMTPA
        id btgeh2LMhticRbtgfhqBBT; Fri, 14 Jun 2019 22:24:41 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1560547481; bh=ACSAmKlo0BzGk30bIWzH3hwoofFpYSErMceGRifc6nU=;
        h=Subject:From:To:Cc:References:Date:In-Reply-To;
        b=imMjv3Xpu38YXOHejYLM2tmvYwlWxiP91LTAtDacLaUrCOm1ibtZvlqDLFDcVeRMK
         t/m+h5ppsvoyyXQq0yvXaHCsiQUdczup4IohIl+09zvQRke8EUrS1mFcdcRDlZ+QaS
         3RzILCj9Si2uytfANZuquUcNTDk4bFqMLfKTZirtV8yxVLYZqi0LDd6N+YoaXa+lvX
         sNXsQuj1Z+LmNEwWzd8DCTjjGwj6iWYObIyyTb0PTMmATU4eFDKLbZAMV8js3XYVxn
         k6iTCsDsUOJy5RMIvtPFQOVHAANOETRD6VGKcr8MeBsyxnIZ7+HGS3zXTL/0PGH3Bz
         brMfvtdvWj1Kg==
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=Gs88BX9C c=1 sm=1 tr=0
 a=ceBz2RPxfYaxgFK6o8vNfQ==:117 a=ceBz2RPxfYaxgFK6o8vNfQ==:17
 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=IkcTkHD0fZMA:10 a=aZOItpVjSPw9JRwNCycA:9
 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: [RFC/PATCH v1 0/4] compat/obstack: update from upstream
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <20190614095308.GG31952@szeder.dev>
 <20190614100059.13540-1-szeder.dev@gmail.com>
 <bd955bb3-626e-345d-550e-562027c2f7e6@ramsayjones.plus.com>
Message-ID: <b99ab7c9-63e3-6f2d-979b-d24a2670f9d5@ramsayjones.plus.com>
Date:   Fri, 14 Jun 2019 22:24:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <bd955bb3-626e-345d-550e-562027c2f7e6@ramsayjones.plus.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfMaBGmIF1aWQN3SkBfavkhIPyi6OgCDrT/LcUoI6XY7sCuYNLgvPq84onb4bwi2EdkwnRk0Gss1BBuNINOGqjRW6IO0BV0BQcoqNkWf9lW+FNsC8b1Ym
 QYrWg1Cn4zhYrKmN4B+AOvykVYL8IAXWegg5g2crrF2e0EK2FlJymQ4m3PKXsMQlsLtbyhCH4WLtAw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 14/06/2019 21:30, Ramsay Jones wrote:
> 
> 
> On 14/06/2019 11:00, SZEDER Gábor wrote:
>> Update 'compat/obstack.{c,h}' from upstream, because they already use
>> 'size_t' instead of 'long' in places that might eventually end up as
>> an argument to malloc(), which might solve build errors with GCC 8 on
>> Windows.
>>
>> The first patch just imports from upstream and doesn't modify anything
>> at all, and, consequently, it can't be compiled because of a screenful
>> or two of errors.  This is bad for future bisects, of course.
>>
>> OTOH, adding all the necessary build fixes right away makes review
>> harder...
>>
>> I'm not sure how to deal with this situation, so here is a series with
>> the fixes in separate patches for review, for now.  If there's an
>> agreement that this is the direction to take, then I'll squash in the
>> fixes in the first patch and touch up the resulting commit message.
>>
>>
>> Ramsay, could you please run sparse on top of these patch series to
>> make sure that I caught and converted all "0 instead of NULL" usages
>> in the last patch?  Thanks.
> 
> I applied your patches to current master (@0aae918dd9) and, since
> you dropped the final hunk of commit 3254310863 ("obstack.c: Fix
> some sparse warnings", 2011-09-11), sparse complains, thus:
> 
>   $ diff sp-out sp-out1
>   27a28,30
>   > compat/obstack.c:331:5: warning: incorrect type in initializer (different modifiers)
>   > compat/obstack.c:331:5:    expected void ( *[addressable] [toplevel] obstack_alloc_failed_handler )( ... )
>   > compat/obstack.c:331:5:    got void ( [noreturn] * )( ... )
>   $ 
> 
> So, yes you did catch all "using plain integer as NULL pointer"
> warnings! :-D

Sorry for being a bit slow here, but I just realized that
I should not have seen that on Linux (and should have tested
on cygwin), because the obstack code gets elided on Linux ...

Oh, wait:

  $ diff sc sc1
  3a4,7
  > compat/obstack.o	- _obstack_allocated_p
  > compat/obstack.o	- obstack_alloc_failed_handler
  > compat/obstack.o	- _obstack_begin_1
  > compat/obstack.o	- _obstack_memory_used
  $ 

Hmm, so on master, this code is totally elided on Linux, but
that is no longer the case with your patches applied. I guess
you need to look at the definition of the {_OBSTACK_}ELIDE_CODE
preprocessor variable(s).

HTH.

ATB,
Ramsay Jones

