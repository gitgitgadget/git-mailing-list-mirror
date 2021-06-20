Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76A2CC48BDF
	for <git@archiver.kernel.org>; Sun, 20 Jun 2021 19:16:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C8276101D
	for <git@archiver.kernel.org>; Sun, 20 Jun 2021 19:16:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbhFTTSv (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Jun 2021 15:18:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbhFTTSt (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Jun 2021 15:18:49 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EBAAC061574
        for <git@vger.kernel.org>; Sun, 20 Jun 2021 12:16:36 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id p4-20020a17090a9304b029016f3020d867so6866427pjo.3
        for <git@vger.kernel.org>; Sun, 20 Jun 2021 12:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JrARx9bw0OmK/qndHC7ANB4NepiQ346WYe3GGEYTDvU=;
        b=nXZiCpaBGkaQ9sJEW6Uho1vIG64U89E0gtPyocjenlkwaoFAeFLn5PDwZHwEFwh3rB
         idXj5A551Wn5C1iZyOlhtCkd8uXT8P6NdcOtTff1nqFounh9l/+nuUDRZPiIWgszq9Fe
         O3hLhWJuqmxjmE1qMpEVWN6G7F6AmhKgfskttsLMdhRTTA0TYW8zdLf5HcmuCxcxiLx+
         Y6Em7KuEpgKSjwVh+KBsaZkPTBx/zmDc+dXsUB40PfvQtx8TGYXyLxlf3IuNCXGbSduX
         Muj17gyjMOXl2LoYu4aNlXaP/ZdvcT8LRQQHSvioaqgAismNlfXPbWOWZzkeVxUWEHk6
         Lftw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JrARx9bw0OmK/qndHC7ANB4NepiQ346WYe3GGEYTDvU=;
        b=iyZEzmJfPlespHmom+JBlhra6Mq7IUXLW/FZ62Yb3Unp1KoZwZ+3QIM4QAKnTqb6tC
         GPN9MySGuOmUyV45NXHli+5dYGYm/3cQNpoSOXoTxiPilWIw1iaMWA97E2qIWJ+ZILel
         scJoXTsu8eyRlzz1iNaoJ4kkrrB+s41OXo/OChZhRYrT0N+HlhxwGzS+lVSTZCLFKjwG
         AiVhl0GQV/i9amNCpfTrFr4rEjDv6byWzsMf0SythGyDoerl/d5FoOaBUdo6EVEZhtAy
         JTc/1lDmnoeYQ3fA+jkhzBNammF+WUxL6UhA10ZZkjyIkYkqkb65kJ+4U43KW3tiVJFS
         qhYg==
X-Gm-Message-State: AOAM5310wUS38P79rsT9qzzdBULtDYg5CZc7hpCsNnKq9ght/fkoTBmQ
        CDVeLwckQ+hS1LuaOsN2Lru9EodVNS8=
X-Google-Smtp-Source: ABdhPJwPKlU8uce3f4d8wHwoTntNbzR8lisD3AfZnNh89Cww5100I8/CUbbQeUn0nSRohWejpSLlJw==
X-Received: by 2002:a17:90a:890a:: with SMTP id u10mr20599324pjn.205.1624216595847;
        Sun, 20 Jun 2021 12:16:35 -0700 (PDT)
Received: from [192.168.208.38] ([183.82.190.107])
        by smtp.gmail.com with ESMTPSA id fr20sm13035336pjb.29.2021.06.20.12.16.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Jun 2021 12:16:35 -0700 (PDT)
Subject: Re: [GSoC] My Git Dev Blog - Week 5
To:     Atharva Raykar <raykar.ath@gmail.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Shourya Shukla <periperidip@gmail.com>,
        Git List <git@vger.kernel.org>
References: <D32894F5-FC76-4DD2-A2F6-E69AAE88C645@gmail.com>
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Message-ID: <ac381db1-fb14-2a23-cfee-863840b89493@gmail.com>
Date:   Mon, 21 Jun 2021 00:46:32 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <D32894F5-FC76-4DD2-A2F6-E69AAE88C645@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 19/06/21 7:02 pm, Atharva Raykar wrote:
> Here's the latest instalment of my weekly Git blog:
> http://atharvaraykar.me/gitnotes/week5
>

Nice blog.
  
> A peek at what's inside:
> 
>   * The blog starts with a summary of all the relevant things
>     that have happened so far in my time with Git, including
>     the status of my submodule-related work.
> 
>   * A question I had about reading the index into memory
>     (any kind of help would be appreciated!):
>     http://atharvaraykar.me/gitnotes/week5#some-challenges-with-the-changes-that-are-cooking
> 

I've tried to clarify this to an extent in a comment [1] on your branch.

A few other things:

> After Rafael and Eric commented on my patch, I forgot to CC them when
> I rerolled. New contributors: please check your CC’s before hitting send!

To add to that, Cc-ing people in the e-mail of all the patches in the series
and not just in the cover letter would be nice too. :) Of course, if you have
a specific reason to not do that, then it's fine.

> And my other blooper was to forget signing off one of my patches. Oops.

Are you aware of `format.signOff` [2] which could save you from issues
like these?


[1]: https://github.com/tfidfwastaken/git/commit/3c46c108a195c42edaab939ab6dd6731e52aefc3#r52396546

[2]: https://git-scm.com/docs/git-config#Documentation/git-config.txt-formatsignOff

-- 
Sivaraam
