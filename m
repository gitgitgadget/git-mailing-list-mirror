Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D218C433F5
	for <git@archiver.kernel.org>; Wed, 24 Nov 2021 14:29:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354805AbhKXOdB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Nov 2021 09:33:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354495AbhKXOc5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Nov 2021 09:32:57 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D28BC061A1D
        for <git@vger.kernel.org>; Wed, 24 Nov 2021 05:05:32 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id l25so9961094eda.11
        for <git@vger.kernel.org>; Wed, 24 Nov 2021 05:05:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=unity3d.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=N90LvH80/5LL+LFhYiCTUX3g9vR+gsZboSM58GVgyWw=;
        b=Ssx4Os5gRCwaJ4OqJ+oHr/lUPDEGx6/27tDyae6i4yCr0wGkC9J7h0cxfkgKaBjO6Y
         mKvswEiDaVM9LFN5G6OiV9vdGn6Qg5GLe3e2JBWg1Br7rxkVrFQWLNGBGQQB1exc9QbD
         djFehdRiFaCvpP3JG7tT3UmBvsifg27Q/nQY9CAmghZjpL3pzJfbnXLULbzLsjJMQsdd
         OzNPMEfgyA8FB92SmbDtkc5JGqmXPbyIXqHvDjiHQhEEAK/EAgYswRAj9a4dUfuIu0r/
         FEENZmtiKYTazilDhtqB1T7sjVpA5CTBHmMb/aBE0aT97oXxiuPYWsav5jNaMKxK1Nlb
         b+5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=N90LvH80/5LL+LFhYiCTUX3g9vR+gsZboSM58GVgyWw=;
        b=sLFpREmQYvcQ1FLVdsHucvj9WR64Pw59hHebrJz94cG58woxnJl9mVvR10v5/C32Ja
         xZOcON81WrEyHFW3QCAPh7GIqPv9rhZeFi5bvmZLif9OFq9DdK9CV1gD/4naqed9bjvF
         evyAfFBOiVZy76HuJUOQHn/oRV/R97vOwXt/rVV/b9zxSMcsBtXHa/NZvtB5Xelg8CjW
         LJeh7RCacHQCZeUukArkv7BaLYAm7zMg8e9cjsQEzxegRYbs0MqMnR6vz0vTSdsqd+rW
         A5mZIGp7HkDma93WXjnYx3rr6CxAoFNWsoyEJgYrgsT8IZCRtCt6WnHnyD6BFzRkr9Bi
         hZog==
X-Gm-Message-State: AOAM532IXGw0f4NhgD3Ll2BUBtjKJ2kRfor/oWtukUa4R2J6mjbcoRTj
        Jq2DbeHfTC3rYo4IY38hQI5m6w==
X-Google-Smtp-Source: ABdhPJwVoF7LrLtP6Z/hhtaN4Kr0uqMZ/4RXL4ZVtTokHuFaykuk0BB3g8Z8+l9DjK29AoaAA7mXmQ==
X-Received: by 2002:a17:906:e103:: with SMTP id gj3mr19979522ejb.456.1637759130148;
        Wed, 24 Nov 2021 05:05:30 -0800 (PST)
Received: from [10.45.33.40] ([80.80.14.217])
        by smtp.gmail.com with ESMTPSA id hp3sm6876825ejc.61.2021.11.24.05.05.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Nov 2021 05:05:29 -0800 (PST)
Message-ID: <96bba3dd-589c-dc37-012a-6c827cafacb8@unity3d.com>
Date:   Wed, 24 Nov 2021 14:05:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.2
Subject: Re: [PATCH] fast-export: fix surprising behavior with --first-parent
Content-Language: en-US
To:     Elijah Newren <newren@gmail.com>,
        William Sprent via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <pull.1084.git.1637666927224.gitgitgadget@gmail.com>
 <CABPp-BGm0VtU=z0r0oGc48J020Meh_xdibnagNeDmBGQ-RVu+g@mail.gmail.com>
From:   William Sprent <williams@unity3d.com>
In-Reply-To: <CABPp-BGm0VtU=z0r0oGc48J020Meh_xdibnagNeDmBGQ-RVu+g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 23/11/2021 20.14, Elijah Newren wrote:
> On Tue, Nov 23, 2021 at 5:25 AM William Sprent via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>>
>> From: William Sprent <williams@unity3d.com>
>> ...
> 
> Wow, interesting.  I did some related work that I never submitted at
> https://github.com/newren/git/commit/08f799b4667de1c755c78e1ea1657f946b588556
> -- in that commit, I also noticed that fast-export did not seem
> careful enough about making sure to process all commits, and came up
> with a much different fix.  However, in my case, I didn't know how to
> trigger the problems in fast-export without some additional changes I
> was trying to make, and since I never got those other changes working,
> I didn't think it was worth submitting my fix.  My solution is more
> complex, in part because it was designed to handle ordering
> requirements & recommendations other than just ancestry.  However, we
> don't currently have any additional ordering requirements (the current
> code only considers ancestry), so your solution is much simpler.  If I
> do at some point get my other changes working, I'd need to
> re-introduce the queue and handle_tail() and my changes to these, but
> that can always be done later if and when I get those other changes
> working.
> 

Ah that is interesting. Good to know. I was happy that I could make 
fast-export rely on revision.c for ordering. At surface level, with the 
minimal amount of insight I have, that seems like an alright separation 
of concerns.

> Interestingly, Dscho added both the --reverse ability to revision.c
> and the commits object_array and the handle_tail() stuff in
> fast-export.c.  Both were done in the same year, and --reverse came
> first.  See 9c5e66e97da8 (Teach revision machinery about --reverse,
> 2007-01-20) and f2dc849e9c5f (Add 'git fast-export', the sister of
> 'git fast-import', 2007-12-02).  It's not clear why revs.reverse = 1
> wasn't used previously, although it certainly didn't occur to me
> either and I think it would have been an alternative solution to my
> first ever git.git contribution -- 784f8affe4df (fast-export: ensure
> we traverse commits in topological order, 2009-02-10).  (Though
> rev.reverse = 1 wouldn't have provided the same speedups that
> rev.topo_order=1 provided.)

Ah. Thanks for the insight.

> I can't think of any cases where this would cause any problems, and it
> seems like using rev.reverse is a pretty clean solution.  Just in case
> I'm missing something, though, it would be nice to get Dscho to also
> comment on this.  I'm cc'ing him.

Thanks. Good idea.

