Return-Path: <SRS0=SopW=7V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 107C8C433DF
	for <git@archiver.kernel.org>; Mon,  8 Jun 2020 13:45:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6392206C3
	for <git@archiver.kernel.org>; Mon,  8 Jun 2020 13:45:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uwEXVayd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729771AbgFHNpQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Jun 2020 09:45:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729553AbgFHNpQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Jun 2020 09:45:16 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83057C08C5C2
        for <git@vger.kernel.org>; Mon,  8 Jun 2020 06:45:15 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id p15so8305997qvr.9
        for <git@vger.kernel.org>; Mon, 08 Jun 2020 06:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Y7qdWf9llGMfaH+bTh3mQjmF+9rR2BqBsaEXLBoiso4=;
        b=uwEXVaydtpeIAoV19W6WJ8umhXJ20SM8D2gRsF+znKlb5z/BUxO4PWPeE1M5mwU3dn
         dY9nacAe8UL/LyK48Gox9vul0Vzejvf8u5diRq6jwENYfz9pN/+rwtVIOxrRQ2hGFXV4
         hBkj9GKel6ymnFjOt0MeTjUU+A91Hbw/DW31c178WCrGkagY9A3unDEO7ydEAyBTehhc
         tLEEcDgCRYskBNO3bAs8SZzizQKZ0eE7AzLgcpYfdZ7smhySLt3i6hwF2J6Jqla4ESjc
         LSQBwmoXCFkntZ46iGoQbBPw8xOonH5bNFYMeYGwKzn6op+U184pXXmrIGo4h/4LZx80
         rroA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Y7qdWf9llGMfaH+bTh3mQjmF+9rR2BqBsaEXLBoiso4=;
        b=MWsXXgXeay/NWDbsWkF61Sh3Fu0RFHVArsMCJEsAmnErtrXmLWxq9/1ZpIh3BliF1P
         uY7DbcS52okjnkC78eTIsoUm6RrvVFLpvRf4l/ZuL6gDuSxheCY1w4zf+EHYp+eRYH3w
         ElPPJ7Z5m0xFlVgi3EK2PqkybGR010oZBO8qQ9prPXl2z/lQAxlnLln8pbOwiLKeMSaT
         Z8R0mVH42TV/LegzHD8ShkbodER8NFh1pL0PBnBj0LAACU3h3HnItuOHhAz6XQNmd1gY
         fjAQxlZAQCbbyrp14EtgBIRjt+VM/eNQww2PQb9gxxNti+SU74C7F+4X+CHmI1t509sB
         5KGQ==
X-Gm-Message-State: AOAM532zPU8bdlxml1Y9Zwj9gv+HkwBEhXXuE/3dHuPG7y2KzLQszvfV
        7XyRxuteZwC5NjBaxy0sDLL8i4ae7jE=
X-Google-Smtp-Source: ABdhPJx1nFy9yjHy+EE2jOheJ4T0U0p5q70yKQn+JDc/dSsSGIaQ6ZNITPzMahkAeGTVVtklCEVxXg==
X-Received: by 2002:a05:6214:10cb:: with SMTP id r11mr22525387qvs.203.1591623913888;
        Mon, 08 Jun 2020 06:45:13 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id j22sm7166946qke.117.2020.06.08.06.45.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jun 2020 06:45:13 -0700 (PDT)
Subject: Re: [GSoC Patch 0/3] Move generation, graph_pos to a slab
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>
Cc:     jnareb@gmail.com, git@vger.kernel.org
References: <20200604072759.19142-1-abhishekkumar8222@gmail.com>
 <b850637d-a7ca-e8f9-5009-657096ea2975@gmail.com>
 <20200607195347.GA8232@szeder.dev> <20200608054827.GA2054@Abhishek-Arch>
 <20200608083615.GD8232@szeder.dev>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <13db757a-9412-7f1e-805c-8a028c4ab2b1@gmail.com>
Date:   Mon, 8 Jun 2020 09:45:12 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:77.0) Gecko/20100101
 Thunderbird/77.0
MIME-Version: 1.0
In-Reply-To: <20200608083615.GD8232@szeder.dev>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/8/2020 4:36 AM, SZEDER Gábor wrote:
> On Mon, Jun 08, 2020 at 11:18:27AM +0530, Abhishek Kumar wrote:
>> On Sun, Jun 07, 2020 at 09:53:47PM +0200, SZEDER Gábor wrote:
>>> On Thu, Jun 04, 2020 at 10:22:27AM -0400, Derrick Stolee wrote:
>>>> On 6/4/2020 3:27 AM, Abhishek Kumar wrote:
>>>>> The struct commit is used in many contexts. However, members generation
>>>>> and graph_pos are only used for commit-graph related operations and
>>>>> otherwise waste memory.
>>>>>
>>>>> This wastage would have been more pronounced as transistion to
>>>>> generation number v2, which uses 64-bit generation number instead of
>>>>> current 32-bits.
>>>>
>>>> Thanks! This is an important step, and will already improve
>>>> performance in subtle ways.
>>>
>>> While the reduced memory footprint of each commit object might improve
>>> performance, accessing graph position and generation numbers in a
>>> commit-slab is more expensive than direct field accesses in 'struct
>>> commit' instances.  Consequently, these patches increase the runtime
>>> of 'git merge-base --is-ancestor HEAD~50000 HEAD' in the linux
>>> repository from 0.630s to 0.940s.
>>>
>>
>> Thank you for checking performance. Performance penalty was something we
>> had discussed here [1]. 
>>
>> Caching the commit slab results in local variables helped wonderfully in v2 [2].
>> For example, the runtime of 'git merge-base --is-ancestor HEAD~50000 HEAD'
>> in the linux repository increased from 0.762 to 0.767s. Since this is a
>> change of <1%, it is *no longer* a performance regression in my opinion.
> 
> Interesting, I measured 0.870s with v2, still a notable increase from
> 0.630s.

This is an interesting point. The --is-ancestor is critical to the
performance issue (as measured on my machine).

For "git merge-base HEAD~50000 HEAD" on the Linux repo, I get

v2.27.0:
real    0m0.515s
user    0m0.467s
sys     0m0.048s

v2 series:
real    0m0.534s
user    0m0.481s
sys     0m0.053s

With "--is-ancestor" I see the following:

v2.27.0:
real    0m0.591s
user    0m0.539s
sys     0m0.052s

v2 series:
real    0m0.773s
user    0m0.733s
sys     0m0.040s

The --is-ancestor option [1] says

    Check if the first <commit> is an ancestor of the second
    <commit>, and exit with status 0 if true, or with status
    1 if not. Errors are signaled by a non-zero status that
    is not 1.

[1] https://git-scm.com/docs/git-merge-base#Documentation/git-merge-base.txt---is-ancestor

This _should_ be faster than "git branch --contains HEAD~50000",
but it is much much slower:

$ time git branch --contains HEAD~50000
real    0m0.068s
user    0m0.061s
sys     0m0.008s

So, there is definitely something going on that slows the
"--is-ancestor" path in this case. But, the solution is not
to halt the current patch (which likely has memory footprint
benefits when dealing with a lot of tree and blob objects)
and instead fix the underlying algorithm.

Let's add that to the list of things to do.

>>>  create mode 100644 contrib/coccinelle/generation.cocci
>>>  create mode 100644 contrib/coccinelle/graph_pos.cocci
>>
>> I appreciate the Coccinelle scripts to help identify
>> automatic fixes for other topics in-flight. However,
>> I wonder if they would be better placed inside the
>> existing commit.cocci file?
>
> We add Coccinelle scripts to avoid undesirable code patterns entering
> our code base.  That, however, is not the case here: this is a
> one-time conversion, and at the end of this series 'struct commit'
> won't have a 'generation' field anymore, so once it's merged the
> compiler will catch any new 'commit->generation' accesses.  Therefore
> I don't think that these Coccinelle scripts should be added at all.

I disagree. We _also_ add Coccinelle scripts when doing one-time
refactors to avoid logical merge conflicts with other topics in
flight. If someone else is working on a parallel topic that adds
references to graph_pos or generation member, then the scripts provide
an easy way for the maintainer to update those references in the merge
commit. Alternatively, the contributor could rebase on top of this
series and run the scripts themselves to fix their patches before
submission.

For example, this was done carefully in the sha->object_id
conversion using contrib/coccinelle/object_id.cocci.

Thanks,
-Stolee
