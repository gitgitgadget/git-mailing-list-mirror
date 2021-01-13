Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD6A4C433DB
	for <git@archiver.kernel.org>; Wed, 13 Jan 2021 12:07:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A528233FB
	for <git@archiver.kernel.org>; Wed, 13 Jan 2021 12:07:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726749AbhAMMHm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Jan 2021 07:07:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbhAMMHm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jan 2021 07:07:42 -0500
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FE9EC061794
        for <git@vger.kernel.org>; Wed, 13 Jan 2021 04:07:02 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id n142so1268311qkn.2
        for <git@vger.kernel.org>; Wed, 13 Jan 2021 04:07:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=A7xrCHuzFRTr+Ia9isO13gJTXnl3Mn2ANqitzdlT3hs=;
        b=TRDjEfj63ek+bfglHVjDU88vpqYKiYeHgtlgRj/tK1X7uUqNNPCmxQulNvzkswI9m9
         lO99/8ikLjMBVZKT2YJbbVTcRCxheIDyWlZflsd1pbUtfK78IHeWN7Vym4wzqHvov4gr
         ZRqvdXbbQlK0uksilNPkMFNa2TC5CJ5XMWTC7mt/Z9Np3IzLflHIbRoWNK+xT6BtmBST
         7nUUQszpsr/ZM4Lb4B4r4fEKjIdXI1kZrCJ4ZtuH6JuJkOjYKo1c9KdHdjilqP3Dc8bk
         WKxI6t+STUkPZlyCjgpjZx/6Mj9qLhFeaoikXDc8FtGsoMcvtYBdrfXnrZ2yMgT3Sc2c
         4ZzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=A7xrCHuzFRTr+Ia9isO13gJTXnl3Mn2ANqitzdlT3hs=;
        b=XwDPNw2E9Yh9Aqrr5dJDOoFB6ZtZDLdeepDxhmakoxLOb/rIWozLjU0JG8rDerAxps
         KDNWq95K1fq0pbaE8nad0OSbrRAyywChzEl/R0YE2ySmbEe1mLG+CnQWmPbECREM49Lp
         LsqxQtEUaEFOX41LyuBkDPu8ZAfK8dCUpjJPgBFN3BY3Dp5hITMJpxkPvOQeIuA1Wl4n
         gb9EvDmrQb0n3WcOkHo8aGj0MME8XGalu9rtjBvsJ8IRWqJVkjruevxiiJvMUeOnn8iO
         LdzuyLP8p2ZjTKYBZ0cKwPB8yiLc9+0kNz4XWUsQtvyddDSx8Rvce7nqWCBDvxWOHz7k
         GxiQ==
X-Gm-Message-State: AOAM530JVYREZ/8qnRunBngLdIS4vcDnBovRXFEMrSAhr/04rGtQW4HM
        gEzHBUKFucBx8BgnIEfPwjdgk7ZnhoI=
X-Google-Smtp-Source: ABdhPJxaeoGEZr8CasR2z7IDy9awmqReyKr1LSEbpWF+VWoW7cvJQLMjDOr226uqxJXKHfsp0ImClw==
X-Received: by 2002:a05:620a:12b9:: with SMTP id x25mr1569615qki.421.1610539621051;
        Wed, 13 Jan 2021 04:07:01 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:80c8:fbc9:5fb9:e8d1? ([2600:1700:e72:80a0:80c8:fbc9:5fb9:e8d1])
        by smtp.gmail.com with UTF8SMTPSA id k141sm912089qke.38.2021.01.13.04.07.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Jan 2021 04:07:00 -0800 (PST)
Subject: Re: test-tool: bloom: generate_filter for multiple string?
To:     =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org
References: <20201231035438.22533-1-congdanhqx@gmail.com>
 <X/3+PG2hi71tj/UA@nand.local> <X/7guF05a/Bb/VNp@danh.dev>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <31aec25c-07ef-b3b7-2759-494ad47bcfb1@gmail.com>
Date:   Wed, 13 Jan 2021 07:06:59 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:85.0) Gecko/20100101
 Thunderbird/85.0
MIME-Version: 1.0
In-Reply-To: <X/7guF05a/Bb/VNp@danh.dev>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/13/2021 6:59 AM, Đoàn Trần Công Danh wrote:
> On 2021-01-12 14:53:32-0500, Taylor Blau <me@ttaylorr.com> wrote:
>> On Thu, Dec 31, 2020 at 10:54:38AM +0700, Đoàn Trần Công Danh wrote:
>>> I'm reading the code for Bloom Filter to see if arXiv:2012.00472
>>> could be an improvement.
>>
>> I'm late to the party, but I'm curious to hear which part of this
>> article you think would help out the Bloom filter implementation.
> 
> Uhm, no. The article doesn't help the Bloom filter implementation.
> The article was suggesting using Bloom filter to speed-up the
> negotiation in fetch-pack and upload-pack. Which, in my own quick
> experience, doesn't help much. Maybe it's me not understand the
> article idea or I have made a naive implementation. However, I'm not
> convinced to pursued further.

I saw that idea, and was immediately skeptical. Bloom filters still
have size linear to the size of the set. By using a Bloom filter to
describe "these are ALL the objects I have" instead of "these are
the TIPS I have" the size will explode to be much larger than our
current negotiation algorithm.

Thanks,
-Stolee

