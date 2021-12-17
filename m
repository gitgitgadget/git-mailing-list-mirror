Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2C6EC433EF
	for <git@archiver.kernel.org>; Fri, 17 Dec 2021 05:26:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232983AbhLQF0K (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Dec 2021 00:26:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231703AbhLQF0H (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Dec 2021 00:26:07 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C3FBC061574
        for <git@vger.kernel.org>; Thu, 16 Dec 2021 21:26:07 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id y12so3374678eda.12
        for <git@vger.kernel.org>; Thu, 16 Dec 2021 21:26:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=0I70gggHFloensV0QeqNsyyG+lU8wN5CJYWexxwaLRk=;
        b=VEleXltB35nedm6X6yCqPznSnFoDzQzowtLklfKdy0HOU9thsDUJ25asXKsgiB1t1y
         G65JhrpC/Cap/gCy6cjOexb/Yl3U3fXRayiA21h0EUl/y+CefAJK4feJonALZAkgftXY
         A45dq3X7WL/iA1ZY57sWsxk8l3VBr+676OYvYIZtmSCR7CjX+V4SWe8oYlf9cEcJkcyM
         p5L1bocd2ECI3obje/MR20jAM8+0qk2A9Fkwq3mP/2Ntn1tYdyVsLzz/ASweQCpfVxdH
         43vOfjOA7zMJCQtyWlmFhbsqHHd0o2k/4CAXgeK2zL8Tx2kpZldcU/caIjFiyp6deiIt
         NTnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=0I70gggHFloensV0QeqNsyyG+lU8wN5CJYWexxwaLRk=;
        b=dQfmtOoB3BpDDNXEjmsz2V9mewEhyO2pYD37DgVeD8+F0skdkTqBfgYXIL4Dq0EoJC
         4+iNVOqGwvVQyEFguB/yqWDeu+fvtq0eOvIarMVNnokLBESRfRr4TUoHUVwFqk5inkdF
         wq/+IWVFGg4D/vfowE0TqH3HMJg9C7MbSNmx3Jaio6n8EOKzDuBExT0IM27h9ZNZJtxk
         mss4TlZHf6c4AnLq6Mp6QP+d5j1o8l4qTv9fEL5gjbB10ZsZYkaKbfqJsIN5jliPSlZz
         rPXZysTYGd3ddeasx0B2so7YilaWXsQdKocmEePReXOathXpd1fswZVNQJqccHjO39fu
         tD0Q==
X-Gm-Message-State: AOAM533TBT43QUTg6wJexO1ZWZ8miT7LyKCGYZiwqnkPvI3waaVO8yHM
        bY776aI3P/mLs7ZduBNclXI=
X-Google-Smtp-Source: ABdhPJwn8qNnN9KJVdSkLm24dgwKK/cUoRHu/1UOEtQZHOjozspIt2MrUB8eza/zcQsGsWtlAy8lDw==
X-Received: by 2002:a17:906:314f:: with SMTP id e15mr1206591eje.658.1639718765507;
        Thu, 16 Dec 2021 21:26:05 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id b4sm2424917ejl.206.2021.12.16.21.26.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 21:26:05 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1my5kq-000kTa-De;
        Fri, 17 Dec 2021 06:26:04 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>,
        Andriy Makukha via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Andriy Makukha <andriy.makukha@gmail.com>
Subject: Re: [PATCH] strlcpy(): safer and faster version
Date:   Fri, 17 Dec 2021 06:22:30 +0100
References: <pull.1097.git.1639675881065.gitgitgadget@gmail.com>
 <YbuB8xeHLNSYnv/a@coredump.intra.peff.net> <xmqqy24k6v1a.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <xmqqy24k6v1a.fsf@gitster.g>
Message-ID: <211217.86sfur9503.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Dec 16 2021, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
>
>> On Thu, Dec 16, 2021 at 05:31:20PM +0000, Andriy Makukha via GitGitGadget wrote:
>>
>>> Original strlcpy() has a significant disadvantage of being both unsafe
>>> and inefficient. It unnecessarily calculates length of `src` which may
>>> result in a segmentation fault if `src` is not terminated with a
>>> NUL-character.
>>
>> I think any code that passes such a "src" is still broken after your
>> code. If the length of "src" is less than "size", then the result in
>> "dest" will contain garbage we read from the memory after "src".
>>
>> Likewise in that case using strnlen() isn't any faster, since it has to
>> look at the same number of bytes either way (it may even be slower since
>> its loop has two conditions to check).
>>
>>> In this fix, if `src` is too long, strlcpy() returns `size`. This
>>> allows to still detect an error while fixing the mentioned
>>> vulnerabilities. It deviates from original strlcpy(), but for a good
>>> reason.
>>
>> This could potentially break callers of strlcpy(), though, because it's
>> changing the semantics of the return value. For example, if they use the
>> return value to expand a buffer to hold the result.
>>
>> I do think the proposed semantics are better (I have actually fixed a
>> real overflow bug where somebody assumed strlcpy() returned the number
>> of bytes written). But we probably should not call it strlcpy(), because
>> that's has well-known behavior that we're not meeting.
>>
>> I don't think any of the current code would be broken by this (most does
>> not even look at the return value at all). It just seems like an
>> accident waiting to happen.
>>
>> Personally, I don't love strlcpy() in the first place. Avoiding heap
>> overflows is good, but unexpected truncation can also be buggy. That's
>> why try to either size buffers automatically (strbuf, xstrfmt,
>> FLEX_ALLOC, etc) or assert that we didn't truncate (xsnprintf).
>>
>> Some cases could probably be converted away from strlcpy(). For
>> instance, the color stuff in add-interactive.c should be using
>> xsnprintf(), since the point of COLOR_MAXLEN is to hold the
>> longest-possible color. The ones in difftool.c probably ought to be
>> strbufs. There are definitely some that want the truncation semantics
>> (e.g., usernames in archive-tar.c). We might be better off providing a
>> function whose name makes it clear that truncation is OK.
>>
>>>  size_t gitstrlcpy(char *dest, const char *src, size_t size)
>>>  {
>>> -	size_t ret = strlen(src);
>>> +	/*
>>> +	 * NOTE: original strlcpy returns full length of src, but this is
>>> +	 * unsafe. This implementation returns `size` if src is too long.
>>> +	 * This behaviour is faster and still allows to detect an issue.
>>> +	 */
>>> +	size_t ret = strnlen(src, size);
>>
>> Also, strnlen() isn't portable, so we'd need a solution there (open
>> coding or yet another compat wrapper).
>
> Thanks for saying everything I wanted to say ;-)

Isn't strlcpy() an OpenBSD-initiated effort? So if we're going to update
this at all shouldn't be be aiming for picking an "upstream" here?
E.g. [1]?

But yeah, just getting rid of it in one form or another is probably
better.

1. https://github.com/libressl-portable/openbsd/blob/master/src/lib/libc/string/strlcpy.c
