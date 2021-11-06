Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CAD9C433EF
	for <git@archiver.kernel.org>; Sat,  6 Nov 2021 04:56:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B6C5611C1
	for <git@archiver.kernel.org>; Sat,  6 Nov 2021 04:56:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230461AbhKFE6k (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 Nov 2021 00:58:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbhKFE6k (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Nov 2021 00:58:40 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65EB3C061570
        for <git@vger.kernel.org>; Fri,  5 Nov 2021 21:55:59 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id r4so39174311edi.5
        for <git@vger.kernel.org>; Fri, 05 Nov 2021 21:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=lIeZZYpUsU35k57vF+5K33Vn3CcPFv3NLQDOYqMIPtI=;
        b=pb0rLAsYFqxLgnpsqKPaYJUvYaxJG+c/NyUQxXkMUBXI/PDskDAfOujsxKv5Ricg6L
         Eamw2I4HIitCJ09NGApYYCxO/17mZx1Qj6Ra0RxEh+kRVKyZu4WbUsSNjHXRkXLhrNf5
         RqyOB4AjA3wrg1Z48jcsfUWkPSrUR8B60UrXPvtsn2b5VNPhatttDTmOSR4ehu5vNfi6
         pbCykGuRxnt98xOR3qw1AyvhghQbnW+J36SBWG+QP9fRdZNnPMXA6YGrKMDQXoIPHxnA
         yYT1+XOqux9Js0eZJlopGH6uE6M9f31Sa1/i12uHlAm38jiZQcp1FC5eYBQh8XjFMMhd
         Nphg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=lIeZZYpUsU35k57vF+5K33Vn3CcPFv3NLQDOYqMIPtI=;
        b=gayJfxZ4PvOfE80H2XUMI16Q9ekqFnjYvr+dw9ztS0zepzpQuLJmVGWQAHoJt52BP0
         NqW5Wq58HfCxLMklUK3p7cPM0xW3raBgm8hHCc61AGVNJnoaPmj0c4VUBOgSlW/0qVmu
         H/dcJVfOphc+GMBxJErpW34wgQ3kGSrgCjP29h4zYhiPuAHq8kOni/4vzIRd3sgkO0MW
         7boMsANiOjAnit9rW5o6Q1b1+6SwIc+0XjfIJKA0Lruwl+UupNYFp7H8OQJX+2IaAW2m
         X5myhJjpPIC/rps8lnFPnYsJA4THMCMAZ40mWqwnApygtzEyP07WL9Pxz+fAw6Yvsx+i
         2H5A==
X-Gm-Message-State: AOAM532rgge9rU9Z2LJq4sFpYCZ33GpINkVjkAXzM+mLA1EFgxywxX4h
        /yWcTSfewvWeCAjrCE4r9DM=
X-Google-Smtp-Source: ABdhPJw7O+LcjSboW2MsrrN+rnmTYUSopdgCbEzI+d6sIFAKLdniGa6KC1xihyR0sl0DssA7pllnPw==
X-Received: by 2002:a50:e60b:: with SMTP id y11mr65438498edm.75.1636174557640;
        Fri, 05 Nov 2021 21:55:57 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id z9sm2241761edb.50.2021.11.05.21.55.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 21:55:57 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mjDkC-000aDd-Jb;
        Sat, 06 Nov 2021 05:55:56 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        peff@peff.net, gitster@pobox.com
Subject: Re: [WIP v2 2/2] config: include file if remote URL matches a glob
Date:   Sat, 06 Nov 2021 05:41:38 +0100
References: <cover.1634077795.git.jonathantanmy@google.com>
 <cover.1635527389.git.jonathantanmy@google.com>
 <3c0d51ee39b8e149b5be57b8cd3f8cd403fe49c9.1635527389.git.jonathantanmy@google.com>
 <YYWTCcAljHQRTJQ/@google.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.6
In-reply-to: <YYWTCcAljHQRTJQ/@google.com>
Message-ID: <211106.8635o9hogz.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Nov 05 2021, Emily Shaffer wrote:

> On Fri, Oct 29, 2021 at 10:31:10AM -0700, Jonathan Tan wrote:
> [...]
>> 
>> One alternative is to rerun the config parsing mechanism upon noticing
>> the first URL-conditional include in order to find all URLs. This would
>> require the config files to be read from disk twice, though.
>
> What's the easiest way to "try it and see", to add tooling and find out
> whether the config files would be reopened during the second parse?
> Because I suspect that we won't actually reopen those files, due to the
> config cache.

strace -f?

> So couldn't we do something like....
>
> pass #1:
>  if (include)
>    if (not hasRemoteUrl)
>      open up path & parse
>  put config into in-memory cache normally
> pass #2: (and this pass would need to be added to repo_config() probably)
>  if (include)
>    if (hasRemoteUrl)
>      open up path & parse
>      insert in-order into in-memory cache
>  don't touch existing configs otherwise
>
> I think it's in practice similar to the approach you're using (getting
> around the weird ordering with a cache in memory), but we could reuse
> the existing config cache rather than creating a new and different one.

I don't know enough to say if this two-step approach is better (although
I'm slightly biased in that direction, since it seems simpler), but this
just seems like premature optimization.

I.e. let's just read the files twice, they'll be in the OS's FS cache,
which is unlikely to be a bottleneck for the amount of files involved.

That being said we do have exactly this cache already. See [1] and
3c8687a73ee (add `config_set` API for caching config-like files,
2014-07-28).

But I think that was added due to *very* frequent re-parsing of the
entire config every time someone needed a config variable, not due to
the I/O overhead (but I may be wrong).

So if we've got 100 config variables we need and 10 config files then
10*100 is probably starting to hurt, but if for whatever reason we
needed 2*10 here that's probably no big deal, and in any case would only
happen if this new include mechanism was in play.

1. https://lore.kernel.org/git/1404631162-18556-1-git-send-email-tanayabh@gmail.com/ 

