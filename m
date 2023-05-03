Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81BF7C77B78
	for <git@archiver.kernel.org>; Wed,  3 May 2023 23:50:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbjECXuz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 May 2023 19:50:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbjECXur (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2023 19:50:47 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AA57903E
        for <git@vger.kernel.org>; Wed,  3 May 2023 16:50:46 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-55a44a2637bso63099857b3.2
        for <git@vger.kernel.org>; Wed, 03 May 2023 16:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1683157846; x=1685749846;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q+dp9sa/BXQxsGAUG5WmyYhe4WIktLj+tGyWWQv+qKg=;
        b=T/65kaPKuf+WhiVhnSqAjVJWTp0QbIEcvGaKN9QTKNck88Gr2Mc9HUYT8ZcaJltAS5
         ZMwXUqjDyJtV6/gMx/mY9fR/DLfRHHg7ygFIX/3T1skeqHstzipZV1Y7J29UYJMni1n1
         ELcBF3jjh3nYcUY4YkG2yrChIHNOMKqBku5kweJkasOY+sjHvqN8K0FUQ0bPIsCWE+xp
         ZAmH9bNc1JAcbXVEsQbxtkGcKOfuCFgJeVV5CftSTJc42JcPxPqIXvabEceZnhwm6XiY
         B/r9hrIqG0jyYO3BfDAJGTjndesn0TfyaNDDf59vvnRW0ZEguL4Wt7NUJipGViVIOT7v
         5wkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683157846; x=1685749846;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q+dp9sa/BXQxsGAUG5WmyYhe4WIktLj+tGyWWQv+qKg=;
        b=gJfSPY7cB8qK324k2gx2q/EfZmCHR6MwXmEIXJ3tzYkIgK6vMW2/lRXafdDBHWxR93
         cMZqacH+/CnBzzsGwf5MuVPlFecypKFPpo/67D+8bPwA6FX0as0rFd7kRg9IkBpjx7A8
         S4oMhRCJ94PotdfUlVpjQqmWYEiscErqHnpurrGyqNWnU9QhytrPszSUcp0xfmcDMFCO
         u1bnphZDvr6VCLhftc313oJBpZCDwu6himLnaQWKQ2SCYRUT9U9U6iUpb5yHGrjtVijy
         TMKNt7Ic89txZpvSYUk9gmAFCEkAI2sKoxHbOy/x4QScYkdCKg0X6kbg2T34Cywlh892
         fLMQ==
X-Gm-Message-State: AC+VfDwMKR03l/mYoLhDnPuccemJjlhTBtRhZ13nK++UVG7zeej+8H3m
        /6aEDq+bR37eg49k4LfF/W1FCQ==
X-Google-Smtp-Source: ACHHUZ75Js+lsbqSz9BKeeX/EhHoXs4UeV7bNcvjzTjlHRt9pyjSyk7QFJR0hrUyLhicfF2u9fkLyA==
X-Received: by 2002:a0d:cc06:0:b0:55a:9b56:acee with SMTP id o6-20020a0dcc06000000b0055a9b56aceemr329545ywd.38.1683157845719;
        Wed, 03 May 2023 16:50:45 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id x134-20020a0dd58c000000b0055bf09909c5sm775583ywd.39.2023.05.03.16.50.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 16:50:34 -0700 (PDT)
Date:   Wed, 3 May 2023 19:50:30 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v3] builtin/pack-objects.c: introduce
 `pack.extraCruftTips`
Message-ID: <ZFLzC1slvOAD6udn@nand.local>
References: <8af478ebe34539b68ffb9b353bbb1372dfca3871.1682011600.git.me@ttaylorr.com>
 <27a7f16aab35b5cac391d9831aadb0f2e2146313.1683151485.git.me@ttaylorr.com>
 <xmqqv8h9m2az.fsf@gitster.g>
 <xmqqjzxpm172.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqjzxpm172.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 03, 2023 at 04:42:41PM -0700, Junio C Hamano wrote:
> Storing them inside cruft packs may be a reasonable choice to make
> today, in the sense that among various object storage mechansim, the
> cruft pack mechanism may be the best fit in today's system, but it
> does not have to stay that way.  Naming the variable to specify the
> hooks with name "cruft" in them would make it hard to explain once
> we find an even better storage mechanism to store such a "not really
> used but want to keep" objects.

I dunno. I thought about this too, and I get your argument, but I am not
convinced that a future mechanism would lend itself well to keeping
around additional sets of objects in the same way cruft packs do. In
that case, we would prefer having called this `pack.extraCruftTips` and
relegating it to the cruft pack system.

We could make this more generic, and extend support to the legacy
prune-via-loose mechanism. But like I said to Peff, I have a hard time
imagining anybody using it.

So, I'm torn. I see what you're saying, but I think I still tend to fall
on the side of leaving it as-is.

Thanks,
Taylor
