Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD231C4320A
	for <git@archiver.kernel.org>; Tue, 10 Aug 2021 18:17:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93D3860724
	for <git@archiver.kernel.org>; Tue, 10 Aug 2021 18:17:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239719AbhHJSRq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Aug 2021 14:17:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240410AbhHJSPz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Aug 2021 14:15:55 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A91DC04E08B
        for <git@vger.kernel.org>; Tue, 10 Aug 2021 10:53:19 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id k2so22208512plk.13
        for <git@vger.kernel.org>; Tue, 10 Aug 2021 10:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8VdwWecfGWTtGxS8WKxtwyIPV2LrBQ/0g91RsNGNQkg=;
        b=Pz4o3oUK6/tRrUzZn10NM2vnxk9EHgmsKeFr4M77IzaF3soLhK3tNy8n+X3PiaCxLy
         Rc9kEvXSirbmQYWGv7z55ax+LrXKMQU7zqzQnNJ84+BZgGNtT5lstYVhvwFnjlUCw0K8
         h5U2E7Rov4RF9+izGup4Y5KFGF0C8p0YP3IJ9o9CXKv+1ibzow50gZmmMpUrNbWA+J1H
         BFFD+EWdESOulVAKP2K7e569I3GoEorES7rvuY62W9rKAz7KCfJIubh0zLAtf5kQRFjQ
         V6qUmApHDw/uAqJrM5caXGTgREJoXsYyZkspF5xnwvtPoO0LN3W4Fm7yh4xSClMw8Slx
         K2Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8VdwWecfGWTtGxS8WKxtwyIPV2LrBQ/0g91RsNGNQkg=;
        b=FqJL0Uqtvba8Q0SM8fkEbMWg3gHlf4kUR0/mOEyVXLQ6WxUm1kZn73X1WP7fJYv6z+
         651OVAXpQhIsih8DgD2UNs2NBddXJi4zBVfb1w4nzoTMCir4rZJt4de1eXEJ5oVk+TWP
         Z0cPxCcY2S9ukqLOCd4klZEIFrHMkJcmKweRp9bO7A4Fzqcv0AOGmYIqT/jWREYYt8oA
         rWmxR20qnb07Z3zavbyw9hiN5wnfj4mMAXBEWeB9NZYrQUuHBbg9OzkooIsEfFKtqWdH
         M2S86+9WlE1QegKmvMuI3y0IR+OC9j/1/atasvQHNUDVcGSXMQG1Lp8maFF8xIPn1biH
         +6ew==
X-Gm-Message-State: AOAM531wclUY0KLX/vSlebJi4OIylTo1UUkBVy/3jVnEKrtzfxomdVhR
        DU6Muq/CJdYDTQyHFiyFObR1fGg5V6I2jg==
X-Google-Smtp-Source: ABdhPJy2oY2dLIboyovLZBI32FIdv6zHNn3FN31jlE9BoQxGU2cbl86wM9IUgfs7zICZaHzMw0wJBw==
X-Received: by 2002:a65:5ccd:: with SMTP id b13mr10107pgt.203.1628617999036;
        Tue, 10 Aug 2021 10:53:19 -0700 (PDT)
Received: from [192.168.208.38] ([49.205.80.154])
        by smtp.gmail.com with ESMTPSA id j23sm3853834pjn.12.2021.08.10.10.53.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Aug 2021 10:53:18 -0700 (PDT)
Subject: Re: [GSoC] [PATCH v4 4/8] dir: libify and export helper functions
 from clone.c
To:     Atharva Raykar <raykar.ath@gmail.com>
Cc:     avarab@gmail.com, christian.couder@gmail.com, congdanhqx@gmail.com,
        emilyshaffer@google.com, git@vger.kernel.org, gitster@pobox.com,
        jrnieder@gmail.com, pc44800@gmail.com, periperidip@gmail.com,
        rafaeloliveira.cs@gmail.com, sunshine@sunshineco.com
References: <20210806120147.73349-1-raykar.ath@gmail.com>
 <20210807071613.99610-1-raykar.ath@gmail.com>
 <20210807071613.99610-5-raykar.ath@gmail.com>
 <1b731c17-7284-746d-331b-d0edd5823318@gmail.com> <m21r73avvx.fsf@gmail.com>
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Message-ID: <68bb457b-9575-c2a1-6d51-fc7cd85a50b7@gmail.com>
Date:   Tue, 10 Aug 2021 23:23:13 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <m21r73avvx.fsf@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09/08/21 1:32 pm, Atharva Raykar wrote:
> 
> Kaartic Sivaraam <kaartic.sivaraam@gmail.com> writes:
> 
>> On 07/08/21 12:46 pm, Atharva Raykar wrote:
>>>> [ ... ]
>>>
>>> diff --git a/dir.h b/dir.h
>>> index b3e1a54a97..a4a6fd7371 100644
>>> --- a/dir.h
>>> +++ b/dir.h
>>> @@ -453,6 +453,16 @@ static inline int is_dot_or_dotdot(const char *name)
>>>      int is_empty_dir(const char *dir);
>>>    +/*
>>> + * Retrieve the "humanish" basename of the given Git URL.
>>> + *
>>> + * For example:
>>> + * 	/path/to/repo.git => "repo"
>>> + * 	host.xz.foo/.git => "foo"
>>> + */
>>
>> Are you sure about the examples here? I just tried and ...
>>
>>    - '/path/to/repo.git' gave me 'repo' like you said
>>
>> .. but ..
>>
>>    - 'host.xz.foo/.git' gives me 'host.xz.foo' instead of 'foo'.
>>      I think you meant to have 'host.xz/foo.git' in the example.
> 
> Yikes! I meant 'host.xz:foo/.git'. That should give us 'foo'. Thanks for
> the correction.
> 

Interesting. I've usually seen host.xz:foo like syntax in HTTP URLs. For instance,

     http://host.xz:4000/bar.baz.git

`git_url_basename` returns `bar.baz` for the above.

I wonder what real-world URL has a syntax like 'host.xz:foo/.git' for which
'foo' would be an appropriate basename to return. Does a real-world URL of
this form exist? Or is this just cooked up to demonstrate the basename that
would be returned for a hypothetical URL like this?

-- 
Sivaraam
