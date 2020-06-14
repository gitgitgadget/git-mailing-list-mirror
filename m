Return-Path: <SRS0=22YV=73=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34700C433DF
	for <git@archiver.kernel.org>; Sun, 14 Jun 2020 11:26:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2BB220714
	for <git@archiver.kernel.org>; Sun, 14 Jun 2020 11:26:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G+uuxa8j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbgFNL0G (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Jun 2020 07:26:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbgFNL0F (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Jun 2020 07:26:05 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A1C1C05BD43
        for <git@vger.kernel.org>; Sun, 14 Jun 2020 04:26:04 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d8so5617831plo.12
        for <git@vger.kernel.org>; Sun, 14 Jun 2020 04:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:cc:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dFOxwMtwk6UNMEDgQ77tuH5FG0n8xGKEhmyaagswd+c=;
        b=G+uuxa8j/UsTIn2qjo8NQQBbMYc/KECQ5YxZHaOi6wBTeVJsE2yZ8DpoP7Jg2iGsL1
         6+qRtOhahqmAqg7L3gPsLR+yNStYdnIrkq8hANaxhHwvTuwa4tjVrUkJj9KBw+rLeyzh
         ti9g+rMk9P51z48ASbuEjPt5q6UfzHj6793uFbB4WOoPIaMmG/WUEl7r5letGMmMdBvQ
         eZDK0+Vy8Vz7XeKzElEmk9vOQp11vvDidTNoEZgScdcT+78J6pvoMmwahSjc9TPiKvaF
         LMPZgrgt7SF+MaiX31JpS/tUzQZu5I7M2VUJlD6YgUTq40Os3Gz7SiqK5Tclc7JTyq6A
         oL2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:cc:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dFOxwMtwk6UNMEDgQ77tuH5FG0n8xGKEhmyaagswd+c=;
        b=dJz9ve7R4Om9celg3a+aDvVZU4elN1nytWbQBxWt7Q8S1K4zCLTff1LoNMelWd1fWo
         P9S7to+f8lytF9gLJ7TNKebaM+OE8Y6hm9cb3cn1sgyuXadRW0NmuZTKuSta09J3Cz+t
         HkKo0QYQavunB7krm9po3InI1B8lh3mrM/E4NoRck8BXnwdy0OoZrAsjIr/Rhz0YuJMw
         D64ajD0Im0rYcAWVibOAqfAIOir/iJoor4yFMNl+3sjb7J0ESQVPqmRSWmadPhm6yOpp
         PZhLD9A8fMj2xgf8I7tvr5f3FTb9kYA7Ms+9Tlc63dXtYVj8nUBxAAODk75sFHF02hqo
         vVsw==
X-Gm-Message-State: AOAM532LiiCIpbL9P9SZ7G+oINNEhQlrQJMIvxfZZUm4lTUxrx+QmEd9
        RyOgePAjLEtAYHRQPcBXnPUB9RnU
X-Google-Smtp-Source: ABdhPJw5xnf5uTC0q6Ftq2HA0vORqLXRow2nx7XoOc6zfGoMDMKz/hGRWrnuB+jI/upOMNed2z3m5w==
X-Received: by 2002:a17:90a:8901:: with SMTP id u1mr7462128pjn.71.1592133963936;
        Sun, 14 Jun 2020 04:26:03 -0700 (PDT)
Received: from [192.168.208.37] ([49.207.132.252])
        by smtp.gmail.com with ESMTPSA id b6sm10943646pfp.24.2020.06.14.04.26.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Jun 2020 04:26:03 -0700 (PDT)
Subject: Re: A note from the maintainer
To:     Junio C Hamano <gitster@pobox.com>
References: <xmqq7dwqvj7v.fsf@gitster.c.googlers.com>
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc:     git@vger.kernel.org
Message-ID: <a696f9ea-b678-5f43-96a5-10a228567223@gmail.com>
Date:   Sun, 14 Jun 2020 16:56:00 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <xmqq7dwqvj7v.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On 01-06-2020 22:03, Junio C Hamano wrote:
> 
> There is a volunteer-run newsletter to serve our community ("Git Rev
> News" http://git.github.io/rev_news/rev_news.html).
>

It seems the Rev News page has moved to:

    https://git.github.io/rev_news/index.html

The following works too:

    https://git.github.io/rev_news

> 
> * Reporting bugs
> 
> When you think git does not behave as you expect, please do not stop
> your bug report with just "git does not work".  "I used git in this
> way, but it did not work" is not much better, neither is "I used git
> in this way, and X happend, which is broken".  It often is that git is
> correct to cause X happen in such a case, and it is your expectation
> that is broken. People would not know what other result Y you expected
> to see instead of X, if you left it unsaid.
> 
> Please remember to always state
> 
>  - what you wanted to achieve;
> 
>  - what you did (the version of git and the command sequence to reproduce
>    the behavior);
> 
>  - what you saw happen (X above);
> 
>  - what you expected to see (Y above); and
> 
>  - how the last two are different.
> 
> See http://www.chiark.greenend.org.uk/~sgtatham/bugs.html for further
> hints.
> 

I wonder if it might be worth mentioning `git bugreport` somewhere here.

> When sending proposed updates and fixes to these parts of the system,
> please base your patches on these trees, not git.git (the former two
> even have different directory structures).
> 

Thanks for routinely sending these informative notes! :)

-- 
Sivaraam
