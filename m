Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EDC3C433EF
	for <git@archiver.kernel.org>; Fri, 10 Dec 2021 18:36:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245455AbhLJSjo (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Dec 2021 13:39:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245446AbhLJSjk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Dec 2021 13:39:40 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D971C0617A1
        for <git@vger.kernel.org>; Fri, 10 Dec 2021 10:36:05 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id b187so11377136iof.11
        for <git@vger.kernel.org>; Fri, 10 Dec 2021 10:36:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=81ZnshwWNFalTcy2q0Q00CJDkBVapPb7RNodxlKFvqk=;
        b=UA3SbPhwyCbX3+1o07fUR6kV1RA3on6fJGUL6pgtO9FTPjlj1XO06Jv9nuNlM6pzwg
         Jw+YLRvUe8oCkbw7lVOHtvZ4TY8oY3HYvyK6Mef1fXMQRI6sX9PoFm5U7GvOmojms5p3
         37Da3rl6XmU/hzYHajvltxbGcJHXpK2Sx4fETOcCcCvl52bFJxZSobLrn1WTt2jW96jw
         C2ou48Q6wozMeOZxleaowrtTBor+uBxZ1P+GPzJqP2t4RG+IixBwwlscGD0R10jmWV9N
         CXBee2GpnnifoYFmmuiVYWyN4AFZmIxnq6fmPWwaMWzSqyFAwwLjCSi2OvjNK9WaBtqJ
         g3sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=81ZnshwWNFalTcy2q0Q00CJDkBVapPb7RNodxlKFvqk=;
        b=UdsofaaTVQ1NHF6IfdDWnZMV6aFLP3ztlh9/z7n5zMA2rqRkrluHgLs7NI4FL88IUt
         RVfXJxeOYPTzE+hMaocVcrb5lKCIYXeSUnHcrDp8U/6hcFYSSehP1tVMD6+YwzQnJvr8
         Bo1IyhdmFcCl5qFIS4vRPF4zXf8V5QPaUCQAJgHnJ0IJGBJa0p/dJ6Q9klRbQUaUohQM
         xbvNw33/oZIO7UjaX8oofkJ9HqtPDGITpXgck03rtvRZQImszZACpJwP2Lwy6k8JnCyw
         8GX3u2lVfpYNEUS7WpAcG2D450yRycotEZEpd6VdMZAvosN3L7MkaVXnlyG/mi8eNvcY
         W0Xw==
X-Gm-Message-State: AOAM532dQ2t11SUPQpne866k7rFJJcfiEdRLiXBYnChxO8rBs1nQwAte
        n6sJotUOKilKKWCJnSHpyOJegpbw4CqZJhUa
X-Google-Smtp-Source: ABdhPJyMuzAmAqTezScEOI+EkrZuQjPbUFL53ES/KkGztk1JTwku9+cTzUcOpf8if2ILi0LWzY9EtQ==
X-Received: by 2002:a05:6638:2191:: with SMTP id s17mr20075895jaj.67.1639161364226;
        Fri, 10 Dec 2021 10:36:04 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id e12sm2854453ilu.3.2021.12.10.10.36.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Dec 2021 10:36:03 -0800 (PST)
Date:   Fri, 10 Dec 2021 13:36:02 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org,
        gitster@pobox.com
Subject: Re: [PATCH 0/2] midx: prevent bitmap corruption when permuting pack
 order
Message-ID: <YbOeEjNic5ETGcdy@nand.local>
References: <cover.1638991570.git.me@ttaylorr.com>
 <bf100d0c-66c7-d402-4790-9c5797e8baf3@gmail.com>
 <YbENofRtY0BPMEUd@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YbENofRtY0BPMEUd@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 08, 2021 at 02:55:13PM -0500, Jeff King wrote:
> On Wed, Dec 08, 2021 at 02:30:17PM -0500, Derrick Stolee wrote:
>
> > > Taylor Blau (2):
> > >   t5326: demonstrate bitmap corruption after permutation
> > >   midx.c: make changing the preferred pack safe
> >
> > Just chiming in to say that I reviewed an earlier version of this series
> > and the version in this submission looks good to me.
>
> Ditto. ;)

All three of us missed that this PORD chunk actually contains the
psuedo-pack position for every object in the MIDX. That is OK, but it's
definitely adding more than 4 bytes per pack to the MIDX (in practice,
it's adding 4 bytes per object).

I'm semi-OK with this direction, since it's tantamount to storing the
.rev file's contents in the MIDX itself. And even though we're not
reading from it, it is doing the thing we need it to which is causing
the MIDX to change its checksum when the object order changes.

But I'm curious what both of your thoughts are before moving forward.

Thanks,
Taylor
