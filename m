Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 480CAC433DB
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 18:29:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16A2964E13
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 18:29:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230317AbhBPS3Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Feb 2021 13:29:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbhBPS3T (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Feb 2021 13:29:19 -0500
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89DA7C061574
        for <git@vger.kernel.org>; Tue, 16 Feb 2021 10:28:39 -0800 (PST)
Received: by mail-oo1-xc2b.google.com with SMTP id n19so2490268ooj.11
        for <git@vger.kernel.org>; Tue, 16 Feb 2021 10:28:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=IAivIpZ+NNrorlcan3/lR8rVoM7gKWYtufPzP0TEnEA=;
        b=MkruU/R9Mu8gueWRhRNj7mKkALdOTilc76iZ6Qp1tV/woDMUUNdeHh05FUlVBYG8E+
         GO9EMc6VnZ2j8Z0K2nutt0Z2hytp67y4JHW1FI8q1ZkXSh31R9k4j91xEwZfaU5ZMvwB
         kSynn//271h9UU3fJDpAjCaj2OXPRB+zffnnXFJmUgHXkxdvxopAOhN+3C9mTZqLj21e
         J69dScuEutJpCbWtQFyuxTZjc04dIydfsJpkpAFN+WWEbwiqqbVyMZKxUYrwf02xepti
         MCSez9+XI7QCLfveITWFtHr1boc639X8hUJL4TTd+cn61QoAvwdLITza1UHMYQhEd2jD
         k1rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=IAivIpZ+NNrorlcan3/lR8rVoM7gKWYtufPzP0TEnEA=;
        b=LL/hchZkVWWNaWexohLQ3LZjciBP5oppnmLU4wm6dtCN0k5WsICmnd9ra8y2vClGQm
         08/ybiWfVzF8cqoHb7a92cza1GF5M+hH4ak6Zv9OZ3rfN51LP9QBZUEmZrDQyBRoUjaK
         LYnH3HF3YVhP6qNuy1wojCFEJMJ0FWz2GmcU7k5xSCE4wyJa06aZlBKuoOWWFlauXHP0
         ap4kEdE5KHkWltgom+yIORooUlSjFNF33D2NS1+LOak8zxhUW0cabgTKEpC+U5nr82YV
         jV5rSf55a6wVkEWD9sE0nP2RZVOqllydEJ6XDrnYteHQrf1S2btDr1O2C9fenpfF7+o8
         MnXA==
X-Gm-Message-State: AOAM530gdsjEZPP6FVhHPoJWE81FnFQNQV9m/+qbU4zlKGQ8mkPf9p8p
        LE1smgNDGP3sK+VqH7Z5br0=
X-Google-Smtp-Source: ABdhPJxiivry+XZooR2yJAojUrvFmC9C2835/gHAvLjMHZzsunthxLVV2B+zdKhsBvmFRsYyULFkWg==
X-Received: by 2002:a4a:1bc2:: with SMTP id 185mr11553816oop.58.1613500118881;
        Tue, 16 Feb 2021 10:28:38 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:bccc:aed3:3481:8d68? ([2600:1700:e72:80a0:bccc:aed3:3481:8d68])
        by smtp.gmail.com with UTF8SMTPSA id 18sm4324319oti.30.2021.02.16.10.28.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Feb 2021 10:28:38 -0800 (PST)
Message-ID: <35448e9d-5054-43be-5dc8-beb6eb1d8339@gmail.com>
Date:   Tue, 16 Feb 2021 13:28:37 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101
 Thunderbird/86.0
Subject: Re: [PATCH 4/5] commit-graph: refactor dispatch loop for style
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>, dstolee@microsoft.com,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        peff@peff.net
References: <87r1lhb6z7.fsf@evledraar.gmail.com>
 <20210215184118.11306-5-avarab@gmail.com> <YCrDGhIq7kU57p1s@nand.local>
 <4d0bd095-5593-33cc-4eec-24f06cc3cf2e@gmail.com>
 <87sg5w9q64.fsf@evledraar.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <87sg5w9q64.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/16/2021 7:02 AM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Tue, Feb 16 2021, Derrick Stolee wrote:
>> The other patches solve real readability problems or reorganize the code
>> to use other concepts within the codebase. This one is much more optional.
> 
> What do you think about
> https://lore.kernel.org/git/874kidapv7.fsf@evledraar.gmail.com/ ? :)

Using a 'goto' is a fine way to avoid a nesting level, but I'm not sure
it "improves readability." Having the tab level makes it clear that that
code is executed only when some condition is met, in this case "if (argc),"
while with the 'goto' we need to know that execution was redirected.

I don't feel too strongly either way. If the code was presented one way or
the other, I probably wouldn't recommend changing to the other mode. In
that sense, the change isn't necessary and causes me to break the tie in
favor of leaving it where it is.

Of course, if someone else says "I like this and would prefer it be used
as an example for future contributors" then the tie is broken in the other
way.

Thanks,
-Stolee
