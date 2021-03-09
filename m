Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE98EC433DB
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 21:11:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A25F765253
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 21:11:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231807AbhCIVKz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Mar 2021 16:10:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230173AbhCIVKe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Mar 2021 16:10:34 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9CC5C06174A
        for <git@vger.kernel.org>; Tue,  9 Mar 2021 13:10:33 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id w65so16533256oie.7
        for <git@vger.kernel.org>; Tue, 09 Mar 2021 13:10:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QJF0giyxRFgHm7XpHC8BoQItOrC90M3gUgpeUOGHPpc=;
        b=MlI+NvaaPHKVBq/utUln4+rzqoE3urFIgnAAcMZegLjN7edVkpAVn/KL+DtXHhry8W
         l9e52h9XpFpxI/unlFDLWHt5/ezny0r+VR2rSixYdiaC57MfjvTR6W6U3MlSH4n7PQEh
         zN8CHURfx84KOjd0hYzD7e0HulIhCEGj5rbaQpinTtcMhQ1BtZstxbnj8/1NkleR0Wyo
         xjg8BPTv6w6b0jUtZ9ppciWya+BHhyy2zPMacW6Y0cEeiDrI82fdjR6RQNFSa1CoL9Lx
         716S1tNCOFUlBst/teOoxQemQ33MTycnjceQ7+ZnOp5wu5oZymSuDRQHEOjcXgudpCJX
         gqqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QJF0giyxRFgHm7XpHC8BoQItOrC90M3gUgpeUOGHPpc=;
        b=Kaho+KLY6+9kFhd7ETGZZm+c83sWCPQhyc5Kmwb4R5djc5wkHFTTrP856hIAPMrgVE
         XY7CRpZf/xsqB9tupr86GoYgBQ6lY7dPU/8oWEcU4Xxe0sRbczucys98oxEJc/Wau9zu
         Xnk0v8MLrChQo3NgYU8Wc/LQI/f7TTXF93yX1aUKlvomezllZ9OwrMSq5B0Tpqnt3gD2
         P0TXdYRp3V0KwcG0617iL//W+gr3ftrxprVj6Oh68XuWTaqnCQlwSpiDZ+UsCQVq0oMp
         /NA5K40T4Kjjpy94XODHrh0bawiU7XjHAfPr4yk70dWZ8BAoL7Sp7o41Zv0/5E7RTm4S
         OXJA==
X-Gm-Message-State: AOAM530d6MzzWhaAgwbo//bZzXmfGy25hmo08ErmesYH8Plt2H7Kmofk
        4aQHPJfpEfuC/1sfncVdCsw=
X-Google-Smtp-Source: ABdhPJyUQEp1ldkq61s/SH0iCzOdj4fmSTs087cQMf9xw7Pbo1DiACRmzLdNxPtf/peYdp1mSs4SJg==
X-Received: by 2002:a05:6808:148f:: with SMTP id e15mr79983oiw.120.1615324233203;
        Tue, 09 Mar 2021 13:10:33 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:88a7:dd04:71df:86ee? ([2600:1700:e72:80a0:88a7:dd04:71df:86ee])
        by smtp.gmail.com with ESMTPSA id i21sm3694325otj.33.2021.03.09.13.10.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Mar 2021 13:10:32 -0800 (PST)
Subject: Re: [PATCH 16/20] sparse-checkout: toggle sparse index from builtin
To:     Elijah Newren <newren@gmail.com>
Cc:     =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Jonathan Nieder <jrnieder@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.883.git.1614111270.gitgitgadget@gmail.com>
 <6d6b230e3318007150aebefebc16dfb8b9b6c401.1614111270.git.gitgitgadget@gmail.com>
 <CAN0heSqPTASn61KKGvWEA3ronaWEPWGP23LUg36JiMxxHEd0zQ@mail.gmail.com>
 <466cb063-0481-cfa6-cc3e-8ca26d73c8fb@gmail.com>
 <CABPp-BG8Jox=tgVihxOvHXWC2t2wDvDr8BN2VLBmHrJ-r9B3Pg@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <ca080280-2f35-60fd-cafa-43b18d06cb1b@gmail.com>
Date:   Tue, 9 Mar 2021 16:10:29 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BG8Jox=tgVihxOvHXWC2t2wDvDr8BN2VLBmHrJ-r9B3Pg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/9/2021 4:03 PM, Elijah Newren wrote:
> On Tue, Mar 9, 2021 at 12:52 PM Derrick Stolee <stolee@gmail.com> wrote:
>>
>> On 2/24/2021 2:11 PM, Martin Ågren wrote:
>>> There are several "layers" here, for lack of a better term. "Enabling foo
>>> enables bar which may cause baz. If you fail due to baz, try dropping
>>> bar by dropping foo." If I remove any mention of the config variable from
>>> your text, I get the following.
>>>
>>>  Enabling sparse index might cause other tools to stop working with your
>>>  repository. If you have trouble with this compatibility, then run `git
>>>  sparse-checkout sparse-index disable` to rewrite your index to not be
>>>  sparse.
>>>
>>> I'm tempted to suggest such a rewrite to relieve readers of knowing of
>>> the middle step, which you could say is more of an implementation
>>> detail. But if we think that the symptoms / error messages might involve
>>> "extensions.sparseIndex" or, as would be the case with an older Git
>>> installation,
>>>
>>>   fatal: unknown repository extensions found:
>>>           sparseindex
>>>
>>> maybe there is some value in mentioning the config item by name. Just
>>> thinking out loud, really, and I don't have any strong opinion. I only
>>> came here to point out the typo in the docs.
>>
>> I agree that the layers are confusing. We could rearrange and have
>> a similar flow to what you recommend by mentioning the extension at
>> the end:
>>
>> **WARNING:** Using a sparse index requires modifying the index in a way
>> that is not completely understood by other tools. If you have trouble with
>> this compatibility, then run `git sparse-checkout sparse-index disable` to
>> rewrite your index to not be sparse. Older versions of Git will not
>> understand the `sparseIndex` repository extension and may fail to interact
>> with your repository until it is disabled.
>>
>> Thanks,
>> -Stolee
> 
> This looks pretty good to me, but could we change the first sentence
> to read "...modifying the index in a way that may not yet be
> understood by external tools." ?  I'm worried "other tools" might make
> people worry about different builtin commands (e.g. fast-export, log).
> I also prefer "may" and "yet" because I suspect most external tools
> (e.g. git filter-repo just to name a personal example) won't need to
> read an index format and will thus be unaffected, and any tools that
> do read the index format will probably eventually learn how to work
> with the new format.

I can make the change, but I do want to point out that the current
use of a repository extension _does_ mean that tools that (correctly)
interact with a Git repository should fail even if they don't try to
access the index file. This is only something to make this work until
we introduce a new index file format version and then can drop the
extension.

"git filter-repo" _should_ be safe because it's really just shelling
to Git, right? I'm more concerned about tools like libgit2.

Thanks,
-Stolee
