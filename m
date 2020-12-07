Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92076C4361B
	for <git@archiver.kernel.org>; Mon,  7 Dec 2020 18:44:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A0652389F
	for <git@archiver.kernel.org>; Mon,  7 Dec 2020 18:44:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726063AbgLGSoe (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Dec 2020 13:44:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726035AbgLGSoe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Dec 2020 13:44:34 -0500
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0D0EC061749
        for <git@vger.kernel.org>; Mon,  7 Dec 2020 10:43:53 -0800 (PST)
Received: by mail-qt1-x844.google.com with SMTP id y15so2586977qtv.5
        for <git@vger.kernel.org>; Mon, 07 Dec 2020 10:43:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cCY4PFgnQs6juIhSH1c1QzK9BxydwSugj4QZomTG58g=;
        b=Lw9aekt3utoxK2begpZeKhLRO9sajWXwEToC/fvryzBQL8gHFMYQLS7fUeWk72uxJS
         ybYOBq29jYhCd8QFQNfuBHkkIJCyTm8U5Sj3hLcR9N8Wi7Vwb/0LScAUwoRK4p8x81ii
         NuL/zEXJ/LSQkdkw09lLtH5FWb/ZySP9FaQWYoTVylyzq6FG2rEkxW26hYzf93MAmMdd
         bLQx+pQ5+/TTNw+3mSY1EQPTDTOi+uNHWKVanjpuCComp5MXo3M5uawQXiOyf8YXPCl8
         eTcu04onI5sDPalDsttqSCB3CuNrw9ueBRNFb3wQAvJUKLzaLYn+j6ocbaz3pC6uznOO
         Njaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cCY4PFgnQs6juIhSH1c1QzK9BxydwSugj4QZomTG58g=;
        b=BUsIUZZgQjtQb5Ns7NT40ajFEdwkodabBHTNNmuktVznIU4ipEWd6tKpSc5YCDExLP
         qQCa46ber4XTygRxsvD9twaTMJvz+whmFNMkrYCAUGdPUJd7AJi8fGPxOCEANy4tRZ94
         yWdy3uqAo1ZQIlmTu8qU9WThBUz2lrbaylDcsDnzSqpC313Smrgx5heH/+RI6VrpqBsg
         H5FgTSh61o6+WIOuHP43ElIrvGBcxl9mtOFaK5wt5WHvupWDfOY32s7ZpeT6Adh1De+X
         wNi0saI2DftEtmSrQawHkKERASAIeFbgO6FbaxuyFlg7CwCLYM7YTWNqHzGpYxj7+FI8
         m4eQ==
X-Gm-Message-State: AOAM533q9QXA47SfvaQ0gzQ/LpvIha8dlRwOqWYMirhq8oorgSlaOVXf
        zuCajnoZGEimWQxIFWhX0C36FbeZZFPw9g==
X-Google-Smtp-Source: ABdhPJwLg9HWW0Z1yLwml2bNJwHY5PD9G7L/9cXdl3fmOfdwGr+WcZGNDoEP31QX4tnxEJDTgMEEWw==
X-Received: by 2002:ac8:545a:: with SMTP id d26mr25685832qtq.390.1607366633009;
        Mon, 07 Dec 2020 10:43:53 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:8ddc:62f4:9dcc:ce02? ([2600:1700:e72:80a0:8ddc:62f4:9dcc:ce02])
        by smtp.gmail.com with UTF8SMTPSA id p58sm4447719qte.38.2020.12.07.10.43.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Dec 2020 10:43:52 -0800 (PST)
Subject: Re: [PATCH v2 23/24] pack-bitmap-write: relax unique rewalk condition
To:     Jonathan Tan <jonathantanmy@google.com>, me@ttaylorr.com
Cc:     git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com,
        peff@peff.net, martin.agren@gmail.com, szeder.dev@gmail.com
References: <X8fBHz2A82hxUzV8@nand.local>
 <20201207181909.3032039-1-jonathantanmy@google.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <2f0540e6-b4f4-ea9f-bac0-ecf92c7b764d@gmail.com>
Date:   Mon, 7 Dec 2020 13:43:51 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:84.0) Gecko/20100101
 Thunderbird/84.0
MIME-Version: 1.0
In-Reply-To: <20201207181909.3032039-1-jonathantanmy@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/7/2020 1:19 PM, Jonathan Tan wrote:
>>>> In an effort to discover a happy medium, this change reduces the walk
>>>> for intermediate commits to only the first-parent history. This focuses
>>>> the walk on how the histories converge, which still has significant
>>>> reduction in repeat object walks. It is still possible to create
>>>> quadratic behavior in this version, but it is probably less likely in
>>>> realistic data shapes.
>>>
>>> Would this work? I agree that the width of the commit bitmasks would go
>>> down (and there would also be fewer commit bitmasks generated, further
>>> increasing the memory savings). But intuitively, if there is a commit
>>> that is selected and only accessible through non-1st-parent links, then
>>> any bitmaps generated for it cannot be contributed to its descendants
>>> (since there was no descendant-to-ancestor walk that could reach it in
>>> order to form the reverse edge).
>>
>> s/bitmaps/bitmasks. 
> 
> I do mean bitmaps there - bitmasks are contributed to parents, but
> bitmaps are contributed to descendants, if I remember correctly.

Ah, the confusion is related around the word "contributed".

Yes, without walking all the parents, we will not populate the
reverse edges with all of the possible connections. Thus, the
step that pushes reachability bitmap bits along the reverse edges
will not be as effective.

And this is the whole point: the reverse-edges existed to get us
into a state of _never_ walking an object multiple times, but that
ended up being too expensive to guarantee. This change relaxes that
condition in a way that still works for large, linear histories.

Since "pack-bitmap-write: fill bitmap with commit history" changed
fill_bitmap_commit() to walk commits until reaching those already in
the precomputed reachability bitmap, it will correctly walk far
enough to compute the reachability bitmap for that commit. It might
just walk objects that are part of _another_, already computed bitmap
that is not reachable via the first-parent history.

The very next patch "pack-bitmap-write: better reuse bitmaps" fixes
this problem by checking for computed bitmaps during the walk in
fill_bitmap_commit().

>> We'll select commits independent of their first
>> parent histories, and so in the situation that you're describing, if C
>> reaches A only through non-1st-parent history, then A's bitmask will not
>> contain the bits from C.
> 
> C is the descendant and A is the ancestor. Yes, A's bitmask will not
> contain the bits from C.
> 
>> But when generating the reachability bitmap for C, we'll still find that
>> we've generated a bitmap for A, and we can copy its bits directly. 
> 
> Here is my contention - this can happen only if there is a reverse edge
> from A to C, as far as I can tell, but such a reverse edge has not been
> formed.

See above. This patch is completely correct given the changes to
fill_bitmap_commit() from earlier. It just needs a tweak (in the
next patch) to recover some of the performance.

>> If
>> this differs from an ancestor P that _is_ in the first-parent history,
>> then P pushed its bits to C before calling fill_bitmap_commit() through
>> the reverse edges.
>>
>>>> Here is some data taken on a fresh clone of the kernel:
>>>>
>>>>              |   runtime (sec)    |   peak heap (GB)   |
>>>>              |                    |                    |
>>>>              |   from  |   with   |   from  |   with   |
>>>>              | scratch | existing | scratch | existing |
>>>>   -----------+---------+----------+---------+-----------
>>>>     original |  64.044 |   83.241 |   2.088 |    2.194 |
>>>>   last patch |  44.811 |   27.828 |   2.289 |    2.358 |
>>>>   this patch | 100.641 |   35.560 |   2.152 |    2.224 |
>>>
>>> Hmm...the jump from 44 to 100 seems rather large.
>>
>> Indeed. It's ameliorated a little bit in the later patches. We are
>> over-walking some objects (as in we are walking them multiple times),
>> but the return we get is reducing the peak heap usage from what it was
>> in the last patch.
>>
>> In the "unfathomably large" category, this makes things tractable.
> 
> Quoting from the next patch [1]:
> 
>>              |   runtime (sec)    |   peak heap (GB)   |
>>              |                    |                    |
>>              |   from  |   with   |   from  |   with   |
>>              | scratch | existing | scratch | existing |
>>   -----------+---------+----------+---------+-----------
>>   last patch | 100.641 |   35.560 |   2.152 |    2.224 |
>>   this patch |  99.720 |   11.696 |   2.152 |    2.217 |
> 
> That is true, but it is not ameliorated much :-(
> 
> If you have steps to generate these timings, I would like to try
> comparing the performance between all patches and all-except-23.
> 
> [1] https://lore.kernel.org/git/42399a1c2e52e1d055a2d0ad96af2ca4dce6b1a0.1605649533.git.me@ttaylorr.com/

The biggest problem is that all-except-23 is an unnacceptable
final state, since it has a performance blowout on super-wide
repos such as the git/git fork network. Perhaps Taylor could
include some performance numbers on that, but I'm pretty sure
that the calculation literally OOMs instead of completing. It
might be worth an explicit mention in the patch.

It might also be better to always include a baseline from the
start of the series to ensure that the final state is better
than the initial state. With only the last/this comparison,
it doesn't look great when we backtrack in performance (even
when it is necessary to do so).

Thanks,
-Stolee
