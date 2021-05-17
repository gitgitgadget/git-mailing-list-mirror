Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17540C43461
	for <git@archiver.kernel.org>; Mon, 17 May 2021 16:48:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDB77611BF
	for <git@archiver.kernel.org>; Mon, 17 May 2021 16:48:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238229AbhEQQtd (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 May 2021 12:49:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236177AbhEQQtE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 May 2021 12:49:04 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE16AC0560D1
        for <git@vger.kernel.org>; Mon, 17 May 2021 09:25:04 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id q10so6322145qkc.5
        for <git@vger.kernel.org>; Mon, 17 May 2021 09:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yN+QKx6Flu5A3hZGtJOZDoYk1wqEHE8+squH5FFOpd8=;
        b=Az3JT1T20iDLzPh9VDWzIpLlr9Sgqhsi8xLFOVMbxAvrubzNSo5jOnwrqfWpmJ//jT
         nYHGTIcKhO4jMhbZLi4tIBWWoFeYoFFT2guqKxvSA5j0tJU7zuW3qWWLq4a8367YPjZC
         +BJygsicB+I5DGQpdWfKeYeaxuc92B3Bhafvf67kI5HJkgvd7V747nxPsNDvGBjBngwg
         AQCCBvYiwzMVLScC+Yeix0rqWqGqyHe8DUZK78lI3zDCJU55CeipLKC4S8mcs6fDxdK7
         BURYqVd8Z6mkDkxgh3RaqHz+khJdy8bvcaAGqniaRmLn13bnU8qNWpjR7WUSiBT19YoE
         UOmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yN+QKx6Flu5A3hZGtJOZDoYk1wqEHE8+squH5FFOpd8=;
        b=Lvl0xMw8OHJqmTCupcSYkw10PWga0rbSK+VgCi2IAnDF7Mj5jcAEl9igSYGBuEDdZj
         boHVQ2B7PMVzWZZmoqYuUNNoBCvfmhkkQo9cXWP1mnZxohG1pY/JGvnn7TJQiC0e+kBQ
         lr+v1jkB4SdFfUXSj2nTvIYzqsU+92rk048vX8d/WTxvoLAzyRpXNK8B6if1qgrQcXl9
         X9mdPTPKTXjSm0J1AmPs+ARi/5adJB8c6DziBdWSMDyncMjiepwdn86BedKClh0t6nea
         HihN1KhKKnWsK4homDlrK5wPwWT0HdH7ak8fLLEn+u7WYJBupEfdZBSlqIUGh+hpQ7XW
         r05w==
X-Gm-Message-State: AOAM533slD4BtUk2g6G68pUxWrD0YvzU58z8WiYnNtOWAaYCwYHO9FAs
        R4TnH/lqjxs3OJrBusgfnis=
X-Google-Smtp-Source: ABdhPJzcRcan96DgZUN2eIF0YpGiTUFNcgbGufppsJtZ0gJ6R+KJbu47U8eV6V6NcI3Crcyb7tMA3A==
X-Received: by 2002:a05:620a:c8f:: with SMTP id q15mr650215qki.400.1621268703893;
        Mon, 17 May 2021 09:25:03 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:68e5:b0b1:d7d3:e820? ([2600:1700:e72:80a0:68e5:b0b1:d7d3:e820])
        by smtp.gmail.com with ESMTPSA id z30sm10775234qtm.11.2021.05.17.09.25.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 May 2021 09:25:03 -0700 (PDT)
Subject: Re: "bad revision" fetch error when fetching missing objects from
 partial clones
To:     Jeff King <peff@peff.net>, Jeff Hostetler <git@jeffhostetler.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Patrick Steinhardt <ps@pks.im>, Taylor Blau <me@ttaylorr.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Git Users <git@vger.kernel.org>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
References: <6422f505-29c4-bee9-e28c-b77dd831c246@gmail.com>
 <ba5a0574-c71c-709c-a13c-bf6d5981545c@jeffhostetler.com>
 <YJz4JTsFjTtL7mE2@coredump.intra.peff.net>
 <YJ0FL3zr/SnWN7t6@coredump.intra.peff.net>
 <YJ4mUJ+EEAnudI3G@coredump.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <32e5852f-f94b-e169-de1c-8cc9a534c93c@gmail.com>
Date:   Mon, 17 May 2021 12:25:02 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <YJ4mUJ+EEAnudI3G@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/14/2021 3:27 AM, Jeff King wrote:
> [+cc Jonathan Tan for partial clone wisdom]
> 
> On Thu, May 13, 2021 at 06:53:36AM -0400, Jeff King wrote:
> 
>>> So I think it will require some digging. My _guess_ is that it has to do
>>> with the "never filter out an object that was explicitly requested" rule
>>> not being consistently followed. But we'll see.
>>
>> OK, I think I've unraveled the mysteries.
> 
> Nope. This part is wrong:
> 
>> It is indeed a problem with the "never filter out an object that was
>> explicitly requested" rule. But really, that rule is stronger: it is
>> "always include an explicitly requested object". I.e., it must override
>> even the usual "you said commit X was uninteresting, so we did not
>> include objects reachable from X" logic.
> 
> The rule really is the softer "don't filter out explicitly-requested
> objects". It's just that the non-bitmap traversal code is way less
> careful about finding uninteresting objects.
> 
> Here's the same scenario failing without using bitmaps at all:
> 
...
>   # ...and then we fetch both the object we need _and_ that second
>   # commit. That causes pack-objects to traverse from base..more.
>   # The boundary is at "base", so we mark its tree and blob as
>   # UNINTERESTING, and thus we _don't_ send them.
>   cd clone
>   git fetch origin $(git rev-parse HEAD:file) HEAD

This is the critical reason why this isn't failing in practice: it
is very rare to ask for a commit and a blob at the same time. Usually,
a blob request comes when something like 'git checkout' is actually
navigating to a commit, and then it only asks for missing blobs.

> So I guess the first question is: is this supposed to work? Without
> bitmaps, it often will. Because we walk commits first, and then only
> mark trees uninteresting at the boundary; so if there were more commits
> here, and we were asking to get a blob from one of the middle ones, it
> would probably work. But fundamentally the client is lying to the server
> here (as all partial clones must); it is saying "I have that first
> commit", but of course we don't have all of the reachable objects.

It _should_ work. We should be specifying the blob:none filter, so when
we say "we have these commits" it should apply that filter to those
commits for the "haves".

If there was room to adjust the protocol more, it would perhaps be
helpful to annotate the haves in this way ("have-filtered" or something,
similar to how the "shallow" advertisement works).

> If this is supposed to work, I think we need to teach the traversal code
> to "add back" all of the objects that were explicitly given when a
> filter is in use (either explicitly, or perhaps just clearing or
> avoiding the UNINTERESTING flag on user-given objects in the first
> place). And my earlier patch does that for the bitmap side, but not the
> regular traversal.

This gets more complicated if we were in a treeless clone, for example.
We could explicitly ask for a tree and really need all of its reachable
trees and blobs. It's not enough to just isolate that single object.

I wouldn't spend too much time optimizing for the treeless clone case,
as I believe the client will self-recover by asking for those reachable
trees when it walks to them.

> Alternatively, part of that fundamental "partial clones are lying about
> their reachability" property is that we assume they can fetch the
> objects they need on-demand. And indeed, the on-demand fetch we'd do
> will use the noop negotiation algorithm, and will succeed. So should we,
> after receiving an empty pack from the other side (because we claimed to
> have objects reachable from the commit), then do a follow-up on-demand
> fetch? If so, then why isn't that kicking in (I can guess there might be
> some limits to on-demand fetching during a fetch itself, in order to
> avoid infinite recursion)?

The client has an opportunity to be more robust here, especially in
the case of a promisor remote. A simple retry would be a good band-aid
for now.

A more involved case might be to isolate objects that we have
identified as reachable from a local object, and set those aside
for a separate request. Here, we could ask for the blob in a
different request than for the remote's HEAD reference.

Thanks,
-Stolee

