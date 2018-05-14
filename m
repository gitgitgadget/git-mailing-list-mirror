Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6214E1F406
	for <e@80x24.org>; Mon, 14 May 2018 13:25:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753684AbeENNZu (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 May 2018 09:25:50 -0400
Received: from mail-qt0-f178.google.com ([209.85.216.178]:35086 "EHLO
        mail-qt0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752463AbeENNZt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 May 2018 09:25:49 -0400
Received: by mail-qt0-f178.google.com with SMTP id f5-v6so16036647qth.2
        for <git@vger.kernel.org>; Mon, 14 May 2018 06:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=Vpm7i/qrsv2FJMteT6gc4ebKXLT8LddGW57e/sxSJBY=;
        b=eguS0/2AwqXApIyU5SJXvafOeh6s3I5kzzvdDm6tEMxjt/hp4UTw/2i8kXu9hHnrwD
         NZmGBIpiQI+EEy9aXEe63ydUQBs3x+EtyQBNt5Pv64HewIHU5GMQ4ciQLcXeiRW7kiL4
         XnV1kDnGYQJzyo79raU0EqE8crgxLmBO5okKsi9Rszv243izazn9g4N4/94jdqm3XqTe
         tMDACsWiyRK1f1fLwYoD3WK8E41Z0kGFhmAtq7u4B512pvt6qFOWijG1rhEaX2K3HDFO
         DYeGcEhWVAy3XEcCVaTabCY3/pxwMCgrxzTme1Pylv5+QEswCt+OMsCyMdRAMqU9KMCB
         fCcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Vpm7i/qrsv2FJMteT6gc4ebKXLT8LddGW57e/sxSJBY=;
        b=ozxincvibshixLMA/5gbL1yjb6pU09obtbIOsSwieTL+VdNolvggv6/pkEuKdVElwQ
         +MR9YZhr4zi4vr3L1Za5GHHUxqZpL9bdK7BzwFtA/ehddtjks8mPVQ+ijlDGNAV5jA9Y
         cNHgXGYVsyltpLkFOenZXT1GwoWR65URjVcWjIJt+lW/N74tP71O+iG87O7ak2oOAa1S
         r1bTmoDA+SXyn+3MYctmomoG92nRSboRHGXSND0KTVxOXe0u7pPqpZftfIDuCeDjSIn9
         wn4zhMMyACx3Hag63lakeMtW8Ry67TZJihSk5jibtgN+hKqk2GHwGjcnKvwqx2E5flkK
         2GLQ==
X-Gm-Message-State: ALKqPwfK+Jo7bi9qw4wZ1FlAFfkaAxgqIchV+Rp+BSB+u36l4a+Enjd/
        Tlsv7K2WEXa67ldP5Iz0A8iB7ZPP
X-Google-Smtp-Source: AB8JxZoXEzjpgS5KgP3NasCYxv+z/wH98G+DviUTf+QF6/8kh/ymcl7r5QirIg9M2X+XfmMf7sDxlw==
X-Received: by 2002:aed:3704:: with SMTP id i4-v6mr8613011qtb.234.1526304348341;
        Mon, 14 May 2018 06:25:48 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:c4e6:7a22:56f1:df04? ([2001:4898:8010:0:ae1c:7a22:56f1:df04])
        by smtp.gmail.com with ESMTPSA id s124-v6sm1905381qke.96.2018.05.14.06.25.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 May 2018 06:25:47 -0700 (PDT)
Subject: Re: [PATCH 4/4] mark_parents_uninteresting(): avoid most allocation
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
References: <20180511180029.GA11290@sigill.intra.peff.net>
 <20180511180314.GD12543@sigill.intra.peff.net>
 <8447da69-d28a-433c-f324-a6380b6ca991@gmail.com>
 <20180514130907.GB9219@sigill.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <bacb6ac4-637d-43c8-8789-2a345097d42a@gmail.com>
Date:   Mon, 14 May 2018 09:25:46 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180514130907.GB9219@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/14/2018 9:09 AM, Jeff King wrote:
> On Mon, May 14, 2018 at 08:47:33AM -0400, Derrick Stolee wrote:
>
>> On 5/11/2018 2:03 PM, Jeff King wrote:
>>> Commit 941ba8db57 (Eliminate recursion in setting/clearing
>>> marks in commit list, 2012-01-14) used a clever double-loop
>>> to avoid allocations for single-parent chains of history.
>>> However, it did so only when following parents of parents
>>> (which was an uncommon case), and _always_ incurred at least
>>> one allocation to populate the list of pending parents in
>>> the first place.
>>>
>>> We can turn this into zero-allocation in the common case by
>>> iterating directly over the initial parent list, and then
>>> following up on any pending items we might have discovered.
>> This change appears to improve performance, but I was unable to measure any
>> difference between this commit and the one ahead, even when merging
>> ds/generation-numbers (which significantly reduces the other costs). I was
>> testing 'git status' and 'git rev-list --boundary master...origin/master' in
>> the Linux repo with my copy of master 70,000+ commits behind origin/master.
> I think you'd want to go the other way: this is marking uninteresting
> commits, so you'd want origin/master..master, which would make those 70k
> commits uninteresting.

Thanks for the tip. Running 'git rev-list origin/master..master' 100 
times gave the following times, on average (with ds/generation-numbers):

PATCH 3/4: 0.19 s
PATCH 4/4: 0.16 s
     Rel %: -16%

>
> I still doubt it will create that much difference, though. It's
> more or less saving a single malloc per commit we traverse. Certainly
> without the .commits file that's a drop in the bucket compared to
> inflating the object data, but I wouldn't be surprised if we end up with
> a few mallocs even after your patches.
>
> Anyway, thanks for poking at it. :)
>
> -Peff

