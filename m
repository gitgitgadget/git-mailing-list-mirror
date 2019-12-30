Return-Path: <SRS0=o5qA=2U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CB90C2D0C2
	for <git@archiver.kernel.org>; Mon, 30 Dec 2019 16:05:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1875B206DB
	for <git@archiver.kernel.org>; Mon, 30 Dec 2019 16:05:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rY8iPrtC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727468AbfL3QEz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Dec 2019 11:04:55 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:43915 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727461AbfL3QEz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Dec 2019 11:04:55 -0500
Received: by mail-qv1-f67.google.com with SMTP id p2so12481407qvo.10
        for <git@vger.kernel.org>; Mon, 30 Dec 2019 08:04:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ic/7Dr0Njj2DdDceEvbi/HZlrlYUju9qSOJobLJkMrI=;
        b=rY8iPrtCUkXqdkZEEKknULpYft1QnZBrPqN8IPuOaCivZPK6du6LMdicpbJCefGNzF
         NfUdFy8+4hs9k9E+CZtMCVg2woISAWkENCz4tk1U40x9+Y70mvsmD7URGSRYFfWm2ael
         6AN9NLIUEuhXpM7OyhAlNMOk/aG92ISJu7rAOR+jMya3f5IqE1YlIlUgyHYPVhtigctb
         +PfLBNoXUVe5e1NoElpzvrjxokYxAjgyQ686tIiBNkXM2b5cWbaidE0M1OTgbrYEVvWS
         ha9CQmcFww9y+rXAyCRPgVP248jbCxvqedFjibKEkiKy08K84SbUfQ9r7+UgyhVhnepW
         v4eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ic/7Dr0Njj2DdDceEvbi/HZlrlYUju9qSOJobLJkMrI=;
        b=mTocCAC7B5v4CT3T+1cVwKIGkfa+gwu8YGymwAg0C845A+QMVuAGuhxaHCszTgYDBz
         UMMuyHJ0Tyoe9n83PMexiHXqUopOGKzeJLZrmCeGvaca4RouJM8g6VWCnDkj8w3OPuAN
         8ap0bs5P0AYBkCZ2GeoUix+timMMiifr7qL1mLRN2QdFqAbGIpgN/qLd3xsPItyPqlmQ
         dLd5SBsCeTDIrwNPg1Fyfau2QEItbaz/niPZ3pPd3zBHZEvbEJiPsXrDLYl5vctgx/dQ
         NkQm2oeoKwuo6+SkVmcm1MsKHhY8AozZhYeApBLGnstdoEwyuvnvhFhjkFfRX5qmRU9I
         kYrw==
X-Gm-Message-State: APjAAAUASiTlilTejK9aFzodhiLt4dBI8mb792+xlAnSgeO+gTEOBuXj
        np4PfoP8nOhuLEA+TC/CW1c=
X-Google-Smtp-Source: APXvYqxNfBWpSRwW3DsZ3WxvdJa/fZPA0nPUaxpKS3GPkdZIxED0MKk9Nw7ziwcEHHGWTebbLkD3kQ==
X-Received: by 2002:a05:6214:bc6:: with SMTP id ff6mr50145959qvb.133.1577721893915;
        Mon, 30 Dec 2019 08:04:53 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:58a9:3b9:96c0:ccb8? ([2001:4898:a800:1012:9dd:3b9:96c0:ccb8])
        by smtp.gmail.com with ESMTPSA id g18sm14038996qtc.83.2019.12.30.08.04.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Dec 2019 08:04:53 -0800 (PST)
Subject: Re: [PATCH 0/9] [RFC] Changed Paths Bloom Filters
To:     Jeff King <peff@peff.net>
Cc:     Garima Singh via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, szeder.dev@gmail.com,
        jonathantanmy@google.com, jeffhost@microsoft.com, me@ttaylorr.com,
        Junio C Hamano <gitster@pobox.com>
References: <pull.497.git.1576879520.gitgitgadget@gmail.com>
 <20191222093036.GA3449072@coredump.intra.peff.net>
 <e9a4e4ff-5466-dc39-c3f5-c9a8b8f2f11d@gmail.com>
 <20191229062414.GC220034@coredump.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <6d20f568-9681-3e66-b892-8f076e20dc63@gmail.com>
Date:   Mon, 30 Dec 2019 11:04:53 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:72.0) Gecko/20100101
 Thunderbird/72.0
MIME-Version: 1.0
In-Reply-To: <20191229062414.GC220034@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/29/2019 1:24 AM, Jeff King wrote:
> On Fri, Dec 27, 2019 at 11:11:37AM -0500, Derrick Stolee wrote:
> 
>>> So here are a few patches to reduce the CPU and memory usage. They could
>>> be squashed in at the appropriate spots, or perhaps taken as inspiration
>>> if there are better solutions (especially for the first one).
>>
>> I tested these patches with the Linux kernel repo and reported my results
>> on each patch. However, I wanted to also test on a larger internal repo
>> (the AzureDevOps repo), which has ~500 commits with more than 512 changes,
>> and generally has larger diffs than the Linux kernel repo.
>>
>> | Version  | Time   | Memory |
>> |----------|--------|--------|
>> | Garima   | 16m36s | 27.0gb |
>> | Peff 1   | 6m32s  | 28.0gb |
>> | Peff 2   | 6m48s  |  5.6gb |
>> | Peff 3   | 6m14s  |  4.5gb |
>> | Shortcut | 3m47s  |  4.5gb |
>>
>> For reference, I found the time and memory information using
>> "/usr/bin/time --verbose" in a bash script.
> 
> Thanks for giving it more exercise. My heap profiling was done with
> massif, which measures the heap directly. Measuring RSS would cover
> that, but will also include the mmap'd packfiles. That's probably why
> your linux.git numbers were slightly higher than mine.

That's interesting. I initially avoided massif because it is so much
slower than /usr/bin/time. However, the inflated numbers could be
explained by that. Also, the distinction between mem_heap and
mem_heap_extra may have interesting implications. Looking online, it
seems that large mem_heap_extra implies the heap is fragmented from
many small allocations.

Here are my findings on the Linux repo:

| Version  | mem_heap | mem_heap_extra |
|----------|----------|----------------|
| Peff 1   |  6,500mb |          913mb |
| Peff 2   |  3,100mb |          286mb |
| Peff 3   |    781mb |          235mb |

These numbers more closely match your numbers (in sum of the two
columns).

> (massif is a really great tool if you haven't used it, as it also shows
> which allocations were using the memory. But it's part of valgrind, so
> it definitely doesn't run on native Windows. It might work under WSL,
> though. I'm sure there are also other heap profilers on Windows).

I am using my Linux machine for my tests. Garima is using her Windows
machine.

>> By "Shortcut" in the table above, I mean the following patch on top of
>> Garima's and Peff's changes. It inserts a max_changes option into struct
>> diff_options to halt the diff early. This seemed like an easier change
>> than creating a new tree diff algorithm wholesale.
> 
> Yeah, I'm not opposed to a diff feature like this.
> 
> But be careful, because...
> 
>> diff --git a/diff.h b/diff.h
>> index 6febe7e365..9443dc1b00 100644
>> --- a/diff.h
>> +++ b/diff.h
>> @@ -285,6 +285,11 @@ struct diff_options {
>>  	/* Number of hexdigits to abbreviate raw format output to. */
>>  	int abbrev;
>>  
>> +	/* If non-zero, then stop computing after this many changes. */
>> +	int max_changes;
>> +	/* For internal use only. */
>> +	int num_changes;
> 
> This is holding internal state in diff_options, but the same
> diff_options is often used for multiple diffs (e.g., "git log --raw"
> would use the same rev_info.diffopt over and over again).
> 
> So it would need to be cleared between diffs. There's a similar feature
> in the "has_changes" flag, though it looks like it is cleared manually
> by callers. Yuck.

You're right about this. What if we initialize it in diff_tree_paths()
before it calls the recursive ll_difF_tree_paths()?

> This isn't a problem for commit-graph right now, but:
> 
>   - it actually could be using a single diff_options, which would be
>     slightly simpler (it doesn't seem to save much CPU, though, because
>     the initialization is relatively cheap)
> 
>   - it's a bit of a subtle bug to leave hanging around for the next
>     person who tries to use the feature
> 
> I actually wonder if this could be rolled into the has_changes and
> diff_can_quit_early() feature. This really just a generalization of that
> feature (which is like setting max_changes to "1").

I thought about this at first, but it only takes a struct diff_options
right now. It does have an internally-mutated member (flags.has_changes)
but it also seems a bit wrong to add a uint32_t of the count in this.
Changing the prototype could be messy, too.

There are also multiple callers, and limiting everything to tree-diff.c
limits the impact.

Thanks,
-Stolee
