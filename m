Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDCF8C433EF
	for <git@archiver.kernel.org>; Fri, 29 Apr 2022 19:05:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380242AbiD2TJG (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Apr 2022 15:09:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380220AbiD2TIz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Apr 2022 15:08:55 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 309C35BD2E
        for <git@vger.kernel.org>; Fri, 29 Apr 2022 12:05:36 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id t3-20020a656083000000b0039cf337edd6so4149908pgu.18
        for <git@vger.kernel.org>; Fri, 29 Apr 2022 12:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=RaAdmI2LGai9dui+hF7C0y5LScWXyZrEjj4Fk+9di9c=;
        b=a2bmNiPRCVW2xFrqV6BPkyM+BbYyprVlv6OFvUbToIYxuSRTX2V3BaZ83iL3YNSzbb
         xw6zbmQwl+PQPY6AfsFaJifk0VpA3m0eXN4UxV7n9cJZrL0NYz3hcGJea0Fss63MCM4G
         h5stH2mcBHHHCh9aHq2Y50n7KGmHFE6IlIDNd/7juj+ltT0+ibPpayPdN4CK12tkKWuc
         SRJUWTZhD0JdYg2SV//fMdK2WG+LSTN7Ydff4PvZZLfnDuM2S1ZZ2x88NURiM23V7J4x
         7M3SsWPuZr+A5nGnMtep92ju1pXedXrT1lIbqd7Vh+QgMn7ATu24yDYAvBUgq0TIEbjh
         MPeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=RaAdmI2LGai9dui+hF7C0y5LScWXyZrEjj4Fk+9di9c=;
        b=bU9yYFKd3jV+4Yf6tOTTsfQWd6qM6Bm2FGG8R7SFXLfcn8ddnM16OhEUt9+P9KR/Cp
         A9mp/N6za8RWKzzIjETCxavP3IHfULwpLfhIfIQLuAxhJJ42/bdwYDjVORlvr9TBGnNz
         MacbunVKiIuP7yRsWuaQHf0fHB6cE7DbqnfQdc9WwlRpwant+JTVZ37nJBq84mOReWDg
         fsoQJbmS4zKQlkfQ7ZC3h5fVjZiga5EbOpJRwwsJ+mP5LfRZIYWmXD8JSrCB11yTEKAV
         Peotyg+P3g8C9jtAgGL0+EdTPDBX+5iOrPnof8ay4J/eMFg9Hj2UMIbylpLk/sf8d4R/
         y6EA==
X-Gm-Message-State: AOAM532E+AIY3KhQV+ytHIoSRWRM9yLC+Wo+e4lMRuKnHTK/Y0+IuF00
        4cdgj38zPTkc+6hAJwMTVq8aNUb4GbBflA==
X-Google-Smtp-Source: ABdhPJwWcc8NEncozJVH9Bivoi583INZFErWFmZz9+vEXdowzvvEYxGFLQyObNCBAP7L6frJO1Olq0rQ9UexjA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90a:c986:b0:1d9:56e7:4e83 with SMTP
 id w6-20020a17090ac98600b001d956e74e83mr435861pjt.1.1651259135302; Fri, 29
 Apr 2022 12:05:35 -0700 (PDT)
Date:   Fri, 29 Apr 2022 12:05:26 -0700
In-Reply-To: <xmqqczgzdc1r.fsf@gitster.g>
Message-Id: <kl6l4k2bpv61.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <CAN8jHOgwVF5g=jM_KYT0Oh+j+Lk3qvdyA4zNRbzf8e1Xp5WAUw@mail.gmail.com>
 <xmqqczgzdc1r.fsf@gitster.g>
Subject: Re: Bugreport - submodules are fetched twice in some cases
From:   Glen Choo <chooglen@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Benedek Kozma <cyberbeni@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> A simple and concrete reproduction 
>
>     git init top
>     cd top
>     date >file1
>     git init sub
>     cd sub
>     date >subfile1
>     git add .
>     git commit -m subinitial
>     cd .. ;# back to top
>     git submodule add ./sub sub
>     git add file1
>     git commit -m initial
>     cd .. ;# out of top
>     git clone --recurse-submodules top copy
>     cd copy
>     git config submodule.recurse true
>     git config fetch.parallel 0
>     GIT_TRACE2=$(pwd)/trace git fetch --all --prune --prune-tags
>
> This throws the three lines to the output.
>
> Fetching origin
> Fetching submodule sub
> Fetching submodule sub
>
> The two "Fetching submodule" messages are coming from two separate
> calls to get_fetch_task_from_index(), and the trace does show that
> the code is doing "git-upload-pack" three times (one for the top
> level, twice for the same top/sub).  We can see it by grepping
> for "git-upload-pack" in the resulting 'trace' file above.

 
Thanks for the reproduction recipe and findings, that'll be very helpful
:)

> Glen, as submodule.c::fetch_submodules() was created in your heavy
> refactoring quite recently, I thought I'd redirect this report in
> your direction, as I expect you'd be the most clueful in this area
> ;-)

Hm, this does look like something that I probably introduced. But even
if it turns out to be older than that, I think I am the right person to
fix it, yes.

I'm a little caught up with the embedded bare repo work, but I think I
can find time to debug this within the next 2 working days or so.
