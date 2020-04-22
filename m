Return-Path: <SRS0=GtnF=6G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EB40C2BA19
	for <git@archiver.kernel.org>; Wed, 22 Apr 2020 01:31:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D675020722
	for <git@archiver.kernel.org>; Wed, 22 Apr 2020 01:31:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iY+YoeIN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726228AbgDVBbC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Apr 2020 21:31:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726039AbgDVBbC (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 21 Apr 2020 21:31:02 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11230C0610D5
        for <git@vger.kernel.org>; Tue, 21 Apr 2020 18:31:02 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id j26so777241ots.0
        for <git@vger.kernel.org>; Tue, 21 Apr 2020 18:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QmNfAMsJT/4UuadLkUx7liT6Y+79Nx6JuswpVvGMeHA=;
        b=iY+YoeINdeG6RNMkFJQaP4uCSHQWlILlDqxjONefwbndVhc031htGvp783/N38+l7I
         0IhF0teQUwfM9aaZRtBGo9boD7zES4NGMTfMcnUlpNeQc/TCdMWPot31MotvnCQzuYU3
         qdA871Q7wL5cdL7oTCW6JZnag6i298AQkAvmzm1ivEu3RtC9MZsd4jNbkDcvo/tSZDhb
         awY8XglRV/VL7PsxR/enTjFq4/7NZsXemSKwG1BjhOST264f1VR1xrerrwSNBlnucAI6
         bpopPLyep+ZKygpjRDQ/FFHtCTYER1e9A91q1aDx/iV888rA4FJ75nja58bJYlOM4VSE
         MgyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QmNfAMsJT/4UuadLkUx7liT6Y+79Nx6JuswpVvGMeHA=;
        b=BdDC6QOtnwDDGnRCxyFJmyh3VozCPQ+BFj+PzByRkN9I+qBo4lMnZKm9LPkx3awSyK
         bHdHhC0Vav5fdlNyPaJsaQovpFWPUezsB1CjzKmq17w2CbebeqL3ia9M+0saLNnaK4pS
         ZNXvY6mouxApnmwNPbaR7xDMtd9BjR8UvuKREe0RKX5xkTG3Lcwhs3tY1po+qUpz2YLz
         B31V9V3dplQ94hh/gaAS6iSgKlhvdRFpn/KwkNJ8NHAWKntHK+MqLa8RK/B6BKywEa3y
         e6jEocg5SvxIHhiaDmopx8+NNhjEimOTY0Nm4pyF124meP2SF8zu8pWZdO6MfsT8s1kh
         dyeQ==
X-Gm-Message-State: AGi0PubMqpDUYwtJbs87d3mrJPon1LsnPwVftZyVzrPQREyPLrpX+Jqv
        IGlaGWp60plT+UIJuPvoOAw=
X-Google-Smtp-Source: APiQypIGNWTK0f5xaiBYMHeyQP4PBKBNZ+yjQP7IphxV4eAyrfQwQbNZNUh9bkhFUv20hDa8H7p13g==
X-Received: by 2002:a9d:6e3:: with SMTP id 90mr1910616otx.261.1587519061213;
        Tue, 21 Apr 2020 18:31:01 -0700 (PDT)
Received: from [192.168.1.83] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id q206sm1181738oib.2.2020.04.21.18.31.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Apr 2020 18:31:00 -0700 (PDT)
Subject: Re: [PATCH v3 3/4] gitfaq: shallow cloning a repository
To:     "Randall S. Becker" <rsbecker@nexbridge.com>,
        'Junio C Hamano' <gitster@pobox.com>,
        'Shourya Shukla' <shouryashukla.oo@gmail.com>
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net,
        'Derrick Stolee' <dstolee@microsoft.com>,
        'Elijah Newren' <newren@gmail.com>,
        'Christian Couder' <christian.couder@gmail.com>
References: <20200421131223.29337-1-shouryashukla.oo@gmail.com>
 <20200421131223.29337-4-shouryashukla.oo@gmail.com>
 <xmqqy2qomwwl.fsf@gitster.c.googlers.com>
 <011001d6181d$97301fc0$c5905f40$@nexbridge.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <9142ccdb-6359-4936-e621-55eab980b7cd@gmail.com>
Date:   Tue, 21 Apr 2020 21:30:59 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:76.0) Gecko/20100101
 Thunderbird/76.0
MIME-Version: 1.0
In-Reply-To: <011001d6181d$97301fc0$c5905f40$@nexbridge.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/21/2020 4:43 PM, Randall S. Becker wrote:
> On April 21, 2020 4:01 PM, Junio C Hamano
>> Subject: Re: [PATCH v3 3/4] gitfaq: shallow cloning a repository
>>
>> Shourya Shukla <shouryashukla.oo@gmail.com> writes:
>>
>>> Add issue in 'Common issue' section which covers issues with cloning
>>> large repositories. Use shallow cloning to clone the repository in a
>>> smaller size.
>>>
>>> Signed-off-by: Shourya Shukla <shouryashukla.oo@gmail.com>
>>> ---
>>>  Documentation/gitfaq.txt | 14 ++++++++++++++
>>>  1 file changed, 14 insertions(+)
>>>
>>> diff --git a/Documentation/gitfaq.txt b/Documentation/gitfaq.txt index
>>> 13d37f96af..cea293cf07 100644
>>> --- a/Documentation/gitfaq.txt
>>> +++ b/Documentation/gitfaq.txt
>>> @@ -275,6 +275,20 @@ I want to change the remote of my repository.
>> How do I do that?::
>>>  One can list the remotes of a repository using `git remote -v` command.
>>>  The default name of a remote is 'origin'.
>>>
>>> +[[shallow-cloning]]
>>> +The repository I am trying to clone is too big. Is there an
>>> +alternative way of cloning it in lesser space?::
>>> +	One can clone a repository having a truncated history, meaning the
>>> +	history	will span upto a specified number of commits instead of
>>> +	the whole history of the repository. This is called 'Shallow
> Cloning'.
>>> ...
>>
>> The question is worth keeping but the answer is questionable.
>>
>> I have a feeling that --depth/shallow is deprecated/frowned upon these
> days
>> and more people recommend partial/blob-less clones instead (a few random
>> people added to Cc: to see if they want to say something here).
> 
> I rather hate to chime in as a dissenting opinion, but the --depth/shallow
> clone is very useful when git is being used as an artifact repository for
> production. 

It is important, then, to mention what the _real_ uses for shallow clones.

They are great for getting just the working directory at tip for a throwaway
action (like building an artifact, or just taking a static copy of something)
but it is a _terrible_ way to start working on source code for a project that
you intend to use for daily work.

The way this is worded in the FAQ will lead users to have a bad experience
and we should recommend partial clone (--filter=blob:none) instead.

Of course, with the speedups from reachability bitmaps, it is sometimes
_faster_ to do a partial clone than a shallow clone. (It definitely takes
less time in the "counting objects" phase, and the cost of downloading
all commits and trees might be small enough on top of the necessary blob
data to keep the total cost under a shallow clone. Your mileage may vary.)
Because the cost of a partial clone is "comparable" to shallow clone, I
would almost recommend partial clone over shallow clones 95% of the time,
even in scenarios like automated builds on cloud-hosted VMs.

Thanks,
-Stolee
