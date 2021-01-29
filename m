Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBE1FC433DB
	for <git@archiver.kernel.org>; Sat, 30 Jan 2021 00:00:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79DA064E04
	for <git@archiver.kernel.org>; Sat, 30 Jan 2021 00:00:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231202AbhA3AAk (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Jan 2021 19:00:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231138AbhA3AAN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jan 2021 19:00:13 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79B4AC061573
        for <git@vger.kernel.org>; Fri, 29 Jan 2021 15:59:33 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id lw17so7123749pjb.0
        for <git@vger.kernel.org>; Fri, 29 Jan 2021 15:59:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9uPLiEGkHq4TEpackj/nAC+wJUrt/W9mGGMXdYT/hGw=;
        b=P85Sd45i0dLTlRQv9wDGdedTbLtbXRlMPclIe0bPX084Nt30BJiJ1BAU3o13Fyxsos
         Hx8f/gxd0YDYFekFL97faK+YQaZpAKRw/WCZT4GkEEutM1VMU66PY5/kLZ8IfcczLrO6
         MS0bg6IQlPUuwpiVXe3seikyAUKRsEx/If/VVG/asB2AqLCdJ7StqH7JH0mLYjiH4F6F
         QZ34NhnJvbIX1PkAgJFD4WUNF+ybeow8nVrdF4gNiokpM3YNKHz1HAfeUkk+exTDkwmD
         ADenGHtZKONY1s/6W/O+t382BTlJbeLKn0KEngw1WkD8ildegh2trqWPy+rHSRptrELM
         tJDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9uPLiEGkHq4TEpackj/nAC+wJUrt/W9mGGMXdYT/hGw=;
        b=a4XJz21PCJ62w2JUw4I7jKXAvMfxinDaob4BX9+zmOPtcs0ABiwQeBjlgL3mCsGDTz
         IqYmf24FI0mBvJuq9/PA9TG75IoPozBx34LvBVNFgDKN9iVsetrJ4ei3EAJlrs0aKL5S
         0uAFkPTO6FTOE1UyUCnyGPTN1Cc/kAVZyKV/ZQfypcoHglYDxFfoe5pzdhL83YsLAukT
         o1jL2NvL7+8Tijixq5PYbHTGGqmPKClg7kIergAfDxpFGWH+Y4OIBu2oqu9LuIGIlAeS
         TizRq9J3KACoNCgUf4l/h8q89dUg5gxACtCUg964oAQclj9dMM9Bo6h03sHS/z0RIpUv
         pd6A==
X-Gm-Message-State: AOAM530jWk504pElrUOeQmQ+56SMry5LKiyySO/jkzlPGvn4ID0XQO7q
        OXJ155DP/q9u1ZinlMRgRrEnwAoRrZ2YNA==
X-Google-Smtp-Source: ABdhPJzZIaVOpHTm21GBSAwPZdNcgVxj5w+WpL8OYgEOXugEyRYuqQ+lDXc3hCj3QlwFc+3vi2NUjg==
X-Received: by 2002:a17:90b:1017:: with SMTP id gm23mr6624548pjb.172.1611964772553;
        Fri, 29 Jan 2021 15:59:32 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:3547:8f35:27a2:2e7e])
        by smtp.gmail.com with ESMTPSA id p68sm224650pfb.60.2021.01.29.15.59.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jan 2021 15:59:31 -0800 (PST)
Date:   Fri, 29 Jan 2021 15:59:26 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        James Ramsay <james@jramsay.com.au>,
        Jonathan Nieder <jrnieder@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Josh Steadmon <steadmon@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v7 00/17] propose config-based hooks (part I)
Message-ID: <YBShXpaDnxWKxYMf@google.com>
References: <20201205014607.1464119-1-emilyshaffer@google.com>
 <20201222000220.1491091-1-emilyshaffer@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201222000220.1491091-1-emilyshaffer@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 21, 2020 at 04:02:03PM -0800, Emily Shaffer wrote:
> 
> Since v6:
> 
>  - Converted 'enum hookdir_opt' to UPPER_SNAKE
>  - Coccinelle fix in the hook destructor
>  - Fixed a bug where builtin/hook.c wasn't running the default git config setup
>    and therefore missed hooks in core.hooksPath when it was set. (These hooks
>    would still run except when invoked by 'git hook run' as the config was
>    called by the processes which invoked the hook library.)
> 
> CI run: https://github.com/nasamuffin/git/actions/runs/436864964

Some updates on this series...

Since Jan 21 we've been running this series as picked from
gitster/git:es/config-hooks on Googler machines, with a subset of users
asked to try out putting their hooks into config instead of hookdir. So
far we haven't heard any crashes or bugs like that, although I did hear
a couple places where the user documentation is lacking. I feel
encouraged by that, and I'm hoping to improve the documentation in the
next week or so, pending $DAYJOB concerns.

We also addressed some of this series in our every-other-week review
club (me, Jonathan Tan, Jonathan Nieder, and Josh Steadmon; although in
this case I tried to be quiet :) ) and so I hope there will be some
comments from my three teammates coming to list sometime next week.

Since I feel pretty comfortable that it doesn't seem to explode
anywhere, I'm really keen to hear nitpicky reviews and try to push to
get this into 'next'; maybe I can barter my eyes on someone else's
neglected review? That sounds pretty mercenary but I think Junio is the
one who suggested it a few weeks ago... ;)

 - Emily
