Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBE8CC48BD1
	for <git@archiver.kernel.org>; Fri, 11 Jun 2021 15:37:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0AC6613E9
	for <git@archiver.kernel.org>; Fri, 11 Jun 2021 15:37:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231852AbhFKPjx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Jun 2021 11:39:53 -0400
Received: from mx.kolabnow.com ([95.128.36.40]:39376 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231703AbhFKPjx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Jun 2021 11:39:53 -0400
Received: from localhost (unknown [127.0.0.1])
        by ext-mx-out003.mykolab.com (Postfix) with ESMTP id 89F4A40D74;
        Fri, 11 Jun 2021 17:37:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        content-transfer-encoding:content-language:content-type
        :content-type:in-reply-to:mime-version:date:date:message-id:from
        :from:references:subject:subject:received:received:received; s=
        dkim20160331; t=1623425871; x=1625240272; bh=15T7eidqbgobDpjchvG
        ap+H2BVwxRfOLwa+sziQ64V8=; b=IkIQ4M060yaFxt1Lc8NhrCm3YuYOLHG0nW8
        ua2exFwZeoj2n5mKfShHKegSyOBpLEexvT1qfWxZ2SQzUW88g71POfE5Ja6wTuc8
        22lWQ8+MQAvwwf1njaMQ4vYqAuvE4TJsBgVFNRx5MUkvSQ8B9asXHrOO0l0Kg5X5
        zG+kltagJksYNPwQvAMh5eR5Tg1uzmMHNn4CsTwFGabWh3gJSb0OjS3fTupt2tz6
        55h6LKrDak22D66FV7m8464xHWj9pmyhu4DDeG7B6jvr880KXuXck0G+El0BrxSX
        RN4qklx3A1eyvTlGRKwiM1y6r4QrslOto46VPqhHQls3DaS85xNdgeAkVrxvCCVL
        Hta6+jo+rLK1Pxdn4jzqK23Vw39tE7+YSfaU8RHc9E74GD8bY14uNP5SzhAhGWA0
        bSPzuwCSM6UKs7khOCFD7IgXqlOwXQQ+stk4RxOi7lukmMWyo24G2L6nKOQns/RL
        dlgQ+VkWSOh6KpEp3vPEEK3tYwjAycoX+aSMtcfU31uCw+fQZ6vQ8T1XSWmD6Oaf
        ry+Ap1JWbPVHLtT93hE73BEz/RYeGMCkcWYAsA+ENRpQ5abvqZOqR+fTzIVffFi9
        bdBqwTUEKnoMIcFLViiEwINNuhSeyhbW3p7P+v35vjnogxM7NO059liDr53tRT4n
        CuUZKdYQ=
X-Virus-Scanned: amavisd-new at mykolab.com
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out003.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id G53VwkTOwFrH; Fri, 11 Jun 2021 17:37:51 +0200 (CEST)
Received: from int-mx001.mykolab.com (unknown [10.9.13.1])
        by ext-mx-out003.mykolab.com (Postfix) with ESMTPS id 430EB4067D;
        Fri, 11 Jun 2021 17:37:51 +0200 (CEST)
Received: from ext-subm001.mykolab.com (unknown [10.9.6.1])
        by int-mx001.mykolab.com (Postfix) with ESMTPS id 33E431FEB;
        Fri, 11 Jun 2021 17:37:48 +0200 (CEST)
Subject: Re: [PATCH 3/3] builtin/checkout--worker: memset struct to avoid MSAN
 complaints
To:     Junio C Hamano <gitster@pobox.com>,
        Chris Torek <chris.torek@gmail.com>
Cc:     Andrzej Hunt via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Andrzej Hunt <ajrhunt@google.com>
References: <pull.1033.git.git.1623343712.gitgitgadget@gmail.com>
 <cd1e1f6985c77d21ec869e53dc5eb79673caf491.1623343713.git.gitgitgadget@gmail.com>
 <CAPx1GvfF7NZD4RMWWZCfny2gQOt1GY=TUm1HxvC+kwwDsc4Rgw@mail.gmail.com>
 <xmqq7dj0530s.fsf@gitster.g>
From:   Andrzej Hunt <andrzej@ahunt.org>
Message-ID: <5a7a57d8-3704-4531-44f5-4d0d48ec376c@ahunt.org>
Date:   Fri, 11 Jun 2021 17:37:40 +0200
MIME-Version: 1.0
In-Reply-To: <xmqq7dj0530s.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 11/06/2021 08:28, Junio C Hamano wrote:
> Chris Torek <chris.torek@gmail.com> writes:
> 
>> On Thu, Jun 10, 2021 at 9:49 AM Andrzej Hunt via GitGitGadget
>> <gitgitgadget@gmail.com> wrote:
>>> [snip] Therefore we add a
>>> memset to convince MSAN that this memory is safe to read - but only
>>> when building with MSAN to avoid this cost in normal usage.
>>
>> It does not seem likely to be that expensive, and would definitely
>> be shorter without all the `#if` testing:
>>
>>> diff --git a/builtin/checkout--worker.c b/builtin/checkout--worker.c
>>> index 289a9b8f89d0..02fa5285988f 100644
>>> --- a/builtin/checkout--worker.c
>>> +++ b/builtin/checkout--worker.c
>>> @@ -56,6 +56,17 @@ static void report_result(struct parallel_checkout_item *pc_item)
>>>          struct pc_item_result res;
>>
>> This could just have `= { 0 }` added.
> 
> I'd prefer that very much more than the #if testing, within which //
> comments that we do not want in our codebase are enclosed.


I'll fix this for V2 - thanks Chris and Junio!

(At the time I wasn't aware that this would include all members and 
padding, but I've learned more since reading the clang developer's 
discussion around padding and brace intialisation :) : 
https://reviews.llvm.org/D61280 . )
