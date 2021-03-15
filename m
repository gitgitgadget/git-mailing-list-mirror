Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDBB3C433E9
	for <git@archiver.kernel.org>; Mon, 15 Mar 2021 16:21:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A56D064E09
	for <git@archiver.kernel.org>; Mon, 15 Mar 2021 16:21:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbhCOQVW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Mar 2021 12:21:22 -0400
Received: from mx.kolabnow.com ([95.128.36.41]:31658 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230051AbhCOQU5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Mar 2021 12:20:57 -0400
Received: from localhost (unknown [127.0.0.1])
        by ext-mx-out002.mykolab.com (Postfix) with ESMTP id EEB10E9A;
        Mon, 15 Mar 2021 17:20:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        content-transfer-encoding:content-language:content-type
        :content-type:in-reply-to:mime-version:date:date:message-id:from
        :from:references:subject:subject:received:received:received; s=
        dkim20160331; t=1615825225; x=1617639626; bh=MMdIqSlathBMXyMgG44
        aqF+uZMZPNSi1zY3htEzgEIs=; b=EfGKmKiGUz9HYPv+NJTDgVSR0eZ3UmztCc8
        Vt+ZiYGekpeH7Q/nb07+dbHlx/KqWXXuF+5rSwSzO02fWhirGZds367aYxfEl8Kv
        FAXxNXZbz86qy3+2H4epa7maB6nXnR31/L/4WaawcOR6K7jHu1WYuOJMufisRDoN
        SNzU9lyASIdtI7Bh6Tuvi4Z/KGJUAtdlOA3sCGi48noeddAOZWtSvgG/MjnbAygp
        +OZvxwZK8M7hroiWT3LvX77urk4ZGGfD9BROtTbPDNW0Ik54OtZxf0Jry5yVlVRs
        gKabrOQkTNPP3qQpvYNQhqPbgxpSJ6f5P2Ahdjyr7FONSSnB3Hkop6Wc4TD32HPp
        MoWaokK/H3gU1kLR/1GvezzWjK1HGoauORKxiKsZe4DN/3cMGZGpMLEu4MeJ6R31
        kknzAraSVPnehPZ2I4GgwRHd584Mct7IWMqNkW9cJZuQFEsLwNisLff6nhLHLLNt
        EH+c0LSgls000N5efjE4JLdnP4YFKkVFwoB7O9c0JMOmseKJi1s96LOgsAWyosVm
        OjyFIQIvOc/MQvxHewwzkQM1/QLw3Pr7SuqJNbGQ+LG4MAfUgXEBFz8ZEpXfL5Hp
        8KCYiEhw6aFjdOLU6yXcyNyWLLPg5b9Qzww5ScrZGIu6WDcQLK/tDEbY9T5zSNF7
        0Hw1TvCc=
X-Virus-Scanned: amavisd-new at mykolab.com
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out002.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id heCTb0i0jrck; Mon, 15 Mar 2021 17:20:25 +0100 (CET)
Received: from int-mx001.mykolab.com (unknown [10.9.13.1])
        by ext-mx-out002.mykolab.com (Postfix) with ESMTPS id D014ADF1;
        Mon, 15 Mar 2021 17:20:24 +0100 (CET)
Received: from ext-subm001.mykolab.com (unknown [10.9.6.1])
        by int-mx001.mykolab.com (Postfix) with ESMTPS id 545B57BA;
        Mon, 15 Mar 2021 17:20:23 +0100 (CET)
Subject: Re: [PATCH v2 7/9] parse-options: convert bitfield values to use
 binary shift
To:     =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        Andrzej Hunt via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Andrzej Hunt <ajrhunt@google.com>
References: <pull.899.git.1615228580.gitgitgadget@gmail.com>
 <pull.899.v2.git.1615747662.gitgitgadget@gmail.com>
 <2b03785bd4cb76285989aff259af57890ea9fe08.1615747662.git.gitgitgadget@gmail.com>
 <CAN0heSo_ArBrjSncvx==kw8K1DzH=0y2h-Q=B_364Ea0EURXxg@mail.gmail.com>
From:   Andrzej Hunt <andrzej@ahunt.org>
Message-ID: <66839f46-9c17-db79-ba9a-54472ed9c249@ahunt.org>
Date:   Mon, 15 Mar 2021 17:20:20 +0100
MIME-Version: 1.0
In-Reply-To: <CAN0heSo_ArBrjSncvx==kw8K1DzH=0y2h-Q=B_364Ea0EURXxg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 14/03/2021 21:25, Martin Ågren wrote:
> On Sun, 14 Mar 2021 at 20:05, Andrzej Hunt via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>>
>> From: Andrzej Hunt <ajrhunt@google.com>
>>
>> Because it's easier to read, but also likely to be easier to maintain.
>> I am making this change because I need to add a new flag in a later
>> commit.
> 
> Makes sense.
> 
>> Also add a trailing comma to the last enum entry to simplify addition of
>> new flags.
> 
> Makes sense.
> 
>> This changee was originally suggested by Peff in:
> 
> s/changee/change/
> 
>> https://public-inbox.org/git/YEZ%2FBWWbpfVwl6nO@coredump.intra.peff.net/
> 
>>   enum parse_opt_flags {
>> -       PARSE_OPT_KEEP_DASHDASH = 1,
>> -       PARSE_OPT_STOP_AT_NON_OPTION = 2,
>> -       PARSE_OPT_KEEP_ARGV0 = 4,
>> -       PARSE_OPT_KEEP_UNKNOWN = 8,
>> -       PARSE_OPT_NO_INTERNAL_HELP = 16,
>> -       PARSE_OPT_ONE_SHOT = 32
>> +       PARSE_OPT_KEEP_DASHDASH = 1 << 0,
>> +       PARSE_OPT_STOP_AT_NON_OPTION = 1 << 1,
>> +       PARSE_OPT_KEEP_ARGV0 = 1 << 2,
>> +       PARSE_OPT_KEEP_UNKNOWN = 1 << 3,
>> +       PARSE_OPT_NO_INTERNAL_HELP = 1 << 4,
>> +       PARSE_OPT_ONE_SHOT = 1 << 5,
>>   };
> 
> Straightforward.
> 
>>   enum parse_opt_option_flags {
>> -       PARSE_OPT_OPTARG  = 1,
>> -       PARSE_OPT_NOARG   = 2,
>> -       PARSE_OPT_NONEG   = 4,
>> -       PARSE_OPT_HIDDEN  = 8,
>> -       PARSE_OPT_LASTARG_DEFAULT = 16,
>> -       PARSE_OPT_NODASH = 32,
>> -       PARSE_OPT_LITERAL_ARGHELP = 64,
> 
> `PARSE_OPT_NEGHELP` is gone since acbb08c2e0b ("parse-options: remove
> PARSE_OPT_NEGHELP", 2012-02-28), which explains the jump here.
> 
>> -       PARSE_OPT_SHELL_EVAL = 256,
>> -       PARSE_OPT_NOCOMPLETE = 512,
>> -       PARSE_OPT_COMP_ARG = 1024,
>> -       PARSE_OPT_CMDMODE = 2048
>> +       PARSE_OPT_OPTARG  = 1 << 0,
>> +       PARSE_OPT_NOARG   = 1 << 1,
>> +       PARSE_OPT_NONEG   = 1 << 2,
>> +       PARSE_OPT_HIDDEN  = 1 << 3,
>> +       PARSE_OPT_LASTARG_DEFAULT = 1 << 4,
>> +       PARSE_OPT_NODASH = 1 << 5,
>> +       PARSE_OPT_LITERAL_ARGHELP = 1 << 6,
>> +       PARSE_OPT_SHELL_EVAL = 1 << 7,
>> +       PARSE_OPT_NOCOMPLETE = 1 << 8,
>> +       PARSE_OPT_COMP_ARG = 1 << 9,
>> +       PARSE_OPT_CMDMODE = 1 << 10,
>>   };
> 
> Those last few conversions close the gap and we end with 1024 rather
> than 2048. That "should" be ok, unless some piece of code relies on
> exact values here, or even their relations(!). Hopefully not? Might be
> worth calling out in the commit message that you're changing some
> values, if you're rerolling anyway. (Or you could leave 1<<8 unused to
> make this a true no-op, then use that value in the next patch. Anyway, I
> think this is safely in bikeshedding land.)

Thanks for catching this. Indeed I don't think any code relies on the 
specific values - but I don't feel comfortable making these changes 
silently or accidentally.

I will follow your suggested approach: I'll update this patch to retain 
the original values - and later on I'll grab the unused value for my new 
flag. That way *if* the new value were to cause a regression, it will be 
much more obvious where it came from.

ATB,
     Andrzej


