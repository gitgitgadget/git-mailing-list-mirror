Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89412C6FD20
	for <git@archiver.kernel.org>; Tue, 21 Mar 2023 20:05:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbjCUUF3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Mar 2023 16:05:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbjCUUF2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Mar 2023 16:05:28 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 436E44A1E6
        for <git@vger.kernel.org>; Tue, 21 Mar 2023 13:04:55 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id z19so6836971plo.2
        for <git@vger.kernel.org>; Tue, 21 Mar 2023 13:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679429090;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=601gygmPWllenNl+E507C8jXNtFIK/SStSvEjRxCky4=;
        b=asxuJkS8s6kbPrTz+uQaR7r42IEyFXUJ6RwSNqb544SK8HWWgkdIzV2YorSbkm/I0e
         5jGbPG6iLIwB1bTuBfT5Q6mkuO7jiYtUT6zIZ+H8KGPW+4OUam+WMvMkgCm3ZR1sfw/c
         p9367YtkixjdYIl/++IEnNyQOmRk3t8yj0OrRWalnADvcJFs+uAnkbTgH3NVssn7xS68
         9/yV2XvVeqLn706LC8XUOtFZabNAfTlTzy1U0PoIA8ISPykLs90gg+1/TlECpZHFyZti
         2MfOD9nYuC0GnP78O623b5p6FSnGq2DKek+H/8mca6gN+dvgqNJDTd5dRSd1m9w0unD+
         Qd6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679429090;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=601gygmPWllenNl+E507C8jXNtFIK/SStSvEjRxCky4=;
        b=VAjCHMVAa4rRIvf11YJMqgmWwf6SlBMv+Nj4ZOJlOlXYaaME1Sd4tBCb1OoyligC5W
         FWwl/d5Wzb6no1LREX243cy2aMMUcf8QYeIj3QB9iqrb97NdMAlyZcJCawSGbBmWUNp/
         5ehEfyg9JwKunYvcT8pRYA2zukeJRwwq8G84G2BGa+Fyae9y24kRTK8WlhovokLGDZNy
         lYYxlPR+x2m/9XWFZUb8kVX3sb4mY2g1qaY9fspnkzdiAx5krZKRbi1XxdAeOFP1UBwJ
         274gQclQj9xVU/XyOs0LpqIKAabxD2EVkH1eVFrPicK9UQVsSdBsNdFk5j9zv2bAUTbd
         SMhw==
X-Gm-Message-State: AO0yUKXCJY8CjGPDoV0DwhhfDR3X0xhDsi8b4CLirWB0iUHgrUWggUji
        6Yjf8H6FHxqICkIDXN96Kpg=
X-Google-Smtp-Source: AK7set9Yf5T2inbGnn1t/7vt0zCWlEt0ecqZyt+YfdFkCxq0o99klixh1RDfJDn4dmYaSzy5PsPYGA==
X-Received: by 2002:a17:902:e844:b0:19f:2328:beee with SMTP id t4-20020a170902e84400b0019f2328beeemr373354plg.11.1679429090247;
        Tue, 21 Mar 2023 13:04:50 -0700 (PDT)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id y6-20020a170902b48600b001a1ea1d6d6esm981039plr.290.2023.03.21.13.04.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 13:04:49 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Paul Eggert <eggert@cs.ucla.edu>,
        Eric Wong <e@80x24.org>, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2] git-compat-util: use gettimeofday(2) for time(2)
References: <20230319064353.686226-1-eggert@cs.ucla.edu>
        <20230320230507.3932018-1-gitster@pobox.com>
        <20230321182252.GJ3119834@coredump.intra.peff.net>
Date:   Tue, 21 Mar 2023 13:04:49 -0700
Message-ID: <xmqqh6udhnvi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> This looks good to me, but I wanted to mention one alternative. If we
> are declaring that time() sucks and gettimeofday() is how to do it, then
> we could just use gettimeofday() everywhere, and add time() to banned.h
> to catch stragglers.
>
> It has two mild advantages:
>
>   1. gettimeofday() gives the callers extra resolution if they want it
>      (though in practice I guess none of them really do)

True.  Many of our data structures do not have room to store the
extra resolution right now.

>   2. It more directly describes what's going on, and we'd play fewer
>      games with macros (though we may end up with a git_gettimeofday()
>      wrapper if somebody doesn't support it; I really wonder about
>      Windows here).

I think they already have a compat/ function for their use in
compat/mingw.c so that may not be an issue.

> The disadvantage is that it's longer to type, and that you have to
> declare a timeval in the caller. So maybe it's a dumb idea.

Yes, you have to declare and use a timeval, but you are already
declaring and using time_t in today's code, so if we were writing
like so from scratch, the result wouldn't have been so bad.  We just
do nto use time_t and use timeval instead consistently.

The patch noise to go from here to there may not be worth it,
though.

Also, unless we are going to actively take advantage of extra
resolution, I am not sure if it is wise to ask for extra resolution
in the first place.  If time(2), at least on some platforms whose
maintainers care, gets corrected to avoid going backwards or being
inconsistent with filesystem timestamp in the future, converting
everything that calls time(2) to call gettimeofday(2) would lose
information---we will want to know which ones need only seconds
resolution and convert them back when the world advances.

So, I am not quite sure I am sold on the idea of rewriting
everything to use gettimeofday(2).

Thanks.

