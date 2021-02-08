Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55D0DC433E0
	for <git@archiver.kernel.org>; Mon,  8 Feb 2021 11:35:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03E5F64EA4
	for <git@archiver.kernel.org>; Mon,  8 Feb 2021 11:35:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231969AbhBHLfN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Feb 2021 06:35:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233320AbhBHLcU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Feb 2021 06:32:20 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F7F1C06174A
        for <git@vger.kernel.org>; Mon,  8 Feb 2021 03:31:16 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id c1so10054994qtc.1
        for <git@vger.kernel.org>; Mon, 08 Feb 2021 03:31:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=PLZDdDZEoZiLIeJjjAbFQevBxswW4K8SM9qb4FE6T3U=;
        b=oOCSDK8RXeXCouCByTHWnBcIiRVZ05svcQuRFIFOdfpKWAO6ab6N8BBTbN6Z2ZNhSa
         TWWFArLV3yL4XFAybltSvKPflXu2q9AuNrbV//8q3rry4o906WR05lTyKKqZwJS6D0xx
         hpxyFOPlDCr9CqoLtZ+HgwwipzPwbcGmw+Al/Ag5TEWWbqGWEH8xVTjoA8LdVFd+XtSK
         h0cM8hNoa5U0j7fY8UWXJm04SOVLJ9j4/hyRf1N8FqWtJ54ZgYPWBOgW16E8Il4Iq5ev
         BMMTr+aNczWkbbbAsEQzgCj9k6FgQZea99iGRJ/lrd5DBi8u+N4TJu8FI/18hS0PMjCo
         gJcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=PLZDdDZEoZiLIeJjjAbFQevBxswW4K8SM9qb4FE6T3U=;
        b=T5ifX+9U5FXvJrBaloGKdFDDrPvWYn2bUOULiV7KVyZxx7gtIJiSjs3yCsDb8JVnGk
         vpSyF9sCFQYyTJZL17mJbG+wHA3Fm+dYqnd11V/ZD6csMnMlJ0Y9NjDhpPzGDfawVDHX
         jpnjTVquJcMhUdnBy7O0aya4339H+nzQ7BdamlwFCQ9YmRLz63rqU/Fadf1QYs73245s
         R/kjSedt1wqPPVgfOHMm6Dmz40/7fu3wvHH1oTMXQJorqw/P/2KK8JtgAxa/+zLJQXlT
         Lb54mbFVVPv5R/OUS6y3bWe6HdLcCSaFXOUPT7uZS6J9x54ijUI60uZy2d4YeHfbLNEH
         0oWg==
X-Gm-Message-State: AOAM531Wo8ZiJhpPDNn6UN00Vy64i74yBEHPOqBrPo+INiM6ngeAN5Mu
        qdDyrQcqp8ofhO87OQJnt1o=
X-Google-Smtp-Source: ABdhPJx0dtv8MpqPJWaCON9LMf73KhWYbezgI7Ogd34Qi7aNpIzBZPv0akA1NUHrSFidDWVc5PPieg==
X-Received: by 2002:ac8:718b:: with SMTP id w11mr612429qto.92.1612783875674;
        Mon, 08 Feb 2021 03:31:15 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:b91a:dd2f:a591:6ed1? ([2600:1700:e72:80a0:b91a:dd2f:a591:6ed1])
        by smtp.gmail.com with UTF8SMTPSA id l7sm2576381qtu.13.2021.02.08.03.31.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Feb 2021 03:31:15 -0800 (PST)
Message-ID: <b4eeb6a1-a801-e984-d245-f291a0cf9727@gmail.com>
Date:   Mon, 8 Feb 2021 06:31:13 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101
 Thunderbird/86.0
Subject: Re: [PATCH 3/3] diffcore-rename: guide inexact rename detection based
 on basenames
Content-Language: en-US
To:     Elijah Newren <newren@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
References: <pull.843.git.1612651937.gitgitgadget@gmail.com>
 <1d941c35076e8d515c8ff7ef01d6b9d8c092aaa9.1612651937.git.gitgitgadget@gmail.com>
 <9fbed0f9-032e-3f99-8467-f8a9cfa2d8f1@gmail.com>
 <CABPp-BHPgUHFFzTd7suhqj=zEXQ61vxKU6X9gZvow5a=TLg3iw@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <CABPp-BHPgUHFFzTd7suhqj=zEXQ61vxKU6X9gZvow5a=TLg3iw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/8/2021 3:27 AM, Elijah Newren wrote:
> Hi,
> 
> On Sun, Feb 7, 2021 at 6:38 AM Derrick Stolee <stolee@gmail.com> wrote:
>>
>> On 2/6/21 5:52 PM, Elijah Newren via GitGitGadget wrote:
>>> From: Elijah Newren <newren@gmail.com>
>>>
>>> Make use of the new find_basename_matches() function added in the last
>>> two patches, to find renames more rapidly in cases where we can match up
>>> files based on basenames.
>>
>> This is a valuable heuristic.
>>
>>> For the testcases mentioned in commit 557ac0350d ("merge-ort: begin
>>> performance work; instrument with trace2_region_* calls", 2020-10-28),
>>> this change improves the performance as follows:
>>>
>>>                             Before                  After
>>>     no-renames:       13.815 s ±  0.062 s    13.138 s ±  0.086 s
>>>     mega-renames:   1799.937 s ±  0.493 s   169.488 s ±  0.494 s
>>>     just-one-mega:    51.289 s ±  0.019 s     5.061 s ±  0.017 s
>>
>> These numbers are very impressive.
>>
>> Before I get too deep into reviewing these patches, I do want
>> to make it clear that the speed-up is coming at the cost of
>> a behavior change. We are restricting the "best match" search
>> to be first among files with common base name (although maybe
>> I would use 'suffix'?). If we search for a rename among all
>> additions and deletions ending the ".txt" we might find a
>> similarity match that is 60% and declare that a rename, even
>> if there is a ".txt" -> ".md" pair that has a 70% match.
> 
> I'm glad you all are open to possible behavioral changes, but I was
> proposing a much smaller behavioral change that is quite different
> than what you have suggested here.  Perhaps my wording was poor; I
> apologize for forgetting that "basename" has different meanings in
> different contexts.  Let me try again; I am not treating the filename
> extension as special in any manner here; by "basename" I just mean the
> portion of the path ignoring any leading directories.  Thus
>     src/foo.txt
> might be a good match against
>     source/foo.txt
> but this optimization as a preliminary step would not consider
> matching src/foo.txt against any of
>     source/bar.txt
>     source/foo.md
> since the basenames ('bar.txt' and 'foo.md') do not match our original
> file's basename ('foo.txt').
> 
> Of course, if this preliminary optimization step fails to find another
> "foo.txt" to match src/foo.txt against (or finds more than one and
> thus doesn't compare against any of them), then the fallback inexact
> rename detection matrix might match it against either of those two
> latter paths, as it always has.

Thank you for making it clear that I had misunderstood what the
optimization is actually doing. A much more narrow scope makes
more sense, and avoids the quadratic problem even when many files
of the same suffix are renamed.

>> This could be documented in a test case, to demonstrate that
>> we are making this choice explicitly.

My test is thus bogus, but you could have a similar one for
your actual optimization.

>> So, in this way, we are changing the optimization function
>> that is used to determine the "best" rename available. It
>> might be good to update documentation for how we choose
>> renames:
> 
> Seems reasonable; I'll add some commentary below on the rules...

Your commentary is helpful. I look forward to reading your
carefully-written docs in the next version ;).

>>      i. among files with the same basename (trailer
>>         after final '.') select pairs with highest
>>         similarity.
> 
> This is an interesting idea, but is not what I implemented.

That's what I get for reading the commit messages quickly and
commenting on what I _think_ is going on instead of actually
reading the code carefully. Sorry about that.

>  It is
> possible that your suggestion is also a useful optimization; it'd be
> hard to know without trying.  However, as noted in optimization batch
> 8 that I'll be submitting later, I'm worried about having any
> optimization pre-steps doing more than O(1) comparisons per path (and
> here you suggest comparing each .txt file with all other .txt files);
> doing that can interact badly with optimization batch 9.
> Additionally, unless we do something to avoid re-comparing files again
> when doing the later all-unmatched-files-against-each-other check,
> then worst case behavior can approach twice as slow as the original
> code.

Right. If Git decides to reorganize all of its *.c files in one
commit, we would still get quadratic behavior in rename detection.
Maybe it's not _that_ much of an improvement.

Thanks,
-Stolee
