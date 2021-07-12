Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EC1FC07E99
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 13:46:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 822E36101D
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 13:46:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234706AbhGLNtD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jul 2021 09:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbhGLNtB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jul 2021 09:49:01 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2586C0613DD
        for <git@vger.kernel.org>; Mon, 12 Jul 2021 06:46:12 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id i12-20020a05683033ecb02903346fa0f74dso18864016otu.10
        for <git@vger.kernel.org>; Mon, 12 Jul 2021 06:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KMOH5j/6tWPnx9pevoq+xxPubd+GajbYblYNPL89gLU=;
        b=UfxnzetqzQnAxarmEpDhxfBQ/bm6oXlJR6dCSSXTonhD4BVQWgXj7/uoXiUZ6pzYyG
         /N/WPKZWKwhQ7Wl10cf3S8FpZu2dyOi2szLE73muDYWuoK1PHOLsg/3M6F3fDE5NuW36
         UE9/F4PisWROvYFUh6VfwuJJu2nQ54O21EzkWGY3OS0FMxlGfcn659Dnwxi/+gJJzZXG
         qTyNnW1XFWt9j0yCq+d42jDXLrOtJLEoBPPbATnZ895P1nZ7s+jgRsXJGr0mREYVaLPU
         mETth5VKy9ybmT/K7p9wgZcRD3lpFYRolIYotF3E0IUJHK5PVwNQOisTotnehmzd+HUf
         dsQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KMOH5j/6tWPnx9pevoq+xxPubd+GajbYblYNPL89gLU=;
        b=kNPvm3fIuLJqc4a2la+2IZqRzaZCOI3Nq1yaaCgydICiOGqA/CMJSKszF1atbiBRyb
         JfLE7Y9lBpq5aOoYjNINC8lOnB/iQHtFmaroirVbMg33mCLaPC3d/nwi1t8KOf9Pe+Qm
         NEuRs3/MXEYSxN/15EU7LA0xdmwOl9k3fgz8hFfsWj9Qs21ou94FDPAI+o026qP58CjD
         lJUXqJmEW5o4ENP2VjCudEq7r/LxqPyPTSeObBLfB0uDbPt2WX7h+l2XL/7BvV4yWXPD
         binVnIAKY3tk+6HoB4sUi1+VhABkrB14h2Ee4DZsCkteuzn1aBFbzWQ3cgK2qQjVUZtU
         +z2g==
X-Gm-Message-State: AOAM532lSE5G907jB/fH6skpDx5Ikx27OYMesjJS9KFuLKiLwSeGG/yS
        Y3Wa2IGwwqtPh+8GpW7Uvog=
X-Google-Smtp-Source: ABdhPJwg3kS+YG7DGBPTu1IvW6kBeUumSb4ziZr9b2QCaMJlZLVCNkdoEfzSz7IOfTWxrNKTT0ChNg==
X-Received: by 2002:a9d:19c1:: with SMTP id k59mr40508900otk.172.1626097572292;
        Mon, 12 Jul 2021 06:46:12 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:91f8:61a:4701:b6c? ([2600:1700:e72:80a0:91f8:61a:4701:b6c])
        by smtp.gmail.com with ESMTPSA id 81sm711208otv.10.2021.07.12.06.46.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jul 2021 06:46:11 -0700 (PDT)
Subject: Re: [PATCH v7 10/16] unpack-trees: handle dir/file conflict of sparse
 entries
To:     Elijah Newren <newren@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.932.v6.git.1624931502.gitgitgadget@gmail.com>
 <pull.932.v7.git.1624932293.gitgitgadget@gmail.com>
 <9f31c691af6780f0ea48bdcb5ff6d56b628f1a81.1624932294.git.gitgitgadget@gmail.com>
 <CABPp-BEcELkxaVT1nPca7VL=OcWaMQ4XYsbjNBuw6xbUw9x42w@mail.gmail.com>
 <CABPp-BHwTAKwFiWQ0-2P=_g+7HLK5FfOAz-uujRjLou1fXT3zw@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <84b045bc-2c00-7516-5796-7812af77c8dc@gmail.com>
Date:   Mon, 12 Jul 2021 09:46:08 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BHwTAKwFiWQ0-2P=_g+7HLK5FfOAz-uujRjLou1fXT3zw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/8/2021 8:58 PM, Elijah Newren wrote:
> On Wed, Jul 7, 2021 at 4:19 PM Elijah Newren <newren@gmail.com> wrote:
>>
>> On Mon, Jun 28, 2021 at 7:05 PM Derrick Stolee via GitGitGadget
>> <gitgitgadget@gmail.com> wrote:
...
>>> +               } else if (current && !oldtree && newtree &&
>>> +                          S_ISSPARSEDIR(current->ce_mode) != S_ISSPARSEDIR(newtree->ce_mode))
>>> +                       return merged_entry(newtree, current, o);
>>> +               else
>>>                         return reject_merge(current, o);
>>>         }
>>>         else if (newtree) {
> 
> t1092 still passes if you replace the
>     return merged_entry(newtree, current, o);
> line with
>     die("This line is never hit.");
> 
> Is it possible that you thought you needed this block but further
> refactoring removed the need?  Or that it is only needed by the later
> ds/commit-and-checkout-with-sparse-index topic (which I haven't yet
> reviewed, because I was reviewing this topic first)?  It seems this
> code change should either be dropped, or moved out to the relevant
> series that uses it.

I have been working with the whole stack of patches (including the
ones that update 'git add') and trying to make the necessary changes
in this series, especially when updating the test data shape or
modifying methods that were necessary for 'git status'.

It is likely I was just overcautious thinking this was necessary so
early. It might also have been necessary due to some strange case
that is only exposed in a Scalar functional test. I'll try moving it
to the next series and double check those tests.

>> This seems wrong to me but I'm having a hard time nailing down a
>> testcase to prove it.  The logic looks to me like "if the old tree as
>> nothing in the index at the given path, and the newtree has something,
>> and the index had something staged, but the newtree and staged index
>> entry disagree on the type of the object, do some weird merged_entry()
>> logic on both types of trees that tends to just take the newer I
>> thought but who knows what functions like verify_uptodate(entry) do
>> when entry is a sparse directory...".
>>
>> So, I'm not so sure about this.  Could you explain this a bit more?

The most important point is that 'current' and 'newtree' are both
present but have different types (blob and tree) and the tree is
necessarily at the edge of the sparse-checkout cone. In the cases
where I was able to trigger this logic in the debugger, 'oldtree'
was NULL, so I added as a condition to be extra cautious around
unexpected initialization. It is possible that the '!oldtree'
condition is unnecessary. I will investigate.

As for verify_uptodate(), it ignores the sparse directory unless
o->skip_sparse_checkout is set. I wonder if it is possible to
have that set and hit this case.

>> However, I did find a testcase that aborts with a fatal error...though
>> I can't tell if it's even triggering the above logic; I think it isn't
>> because I have an "ignoreme" on both sides of the history.  Here's the
>> testcase:
>>
...
>> # Run a command that aborts with a fatal error
>> git checkout -m master

Thank you for finding an interesting test!

> It turns out that this testcase I provided still triggers the same
> fatal error if you omit the --sparse-index flag, so it's not a
> sparse-index-specific bug.
> 
> So, perhaps it shouldn't hold up this series, but given that a lot of
> your correctness verification in t1092 relies on comparisons between
> sparse checkouts and sparse indexes, it might be worth trying to get
> to the root of this.
 
I have some upcoming thoughts on changing how sparse-checkout works
for other complicated cases, so I will add this to that pile.

Thanks,
-Stolee
