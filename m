Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BE38C433F5
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 19:49:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BD2C61106
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 19:49:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346043AbhIGTvB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Sep 2021 15:51:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243859AbhIGTvA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Sep 2021 15:51:00 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D431C061575
        for <git@vger.kernel.org>; Tue,  7 Sep 2021 12:49:53 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id j13so15472131edv.13
        for <git@vger.kernel.org>; Tue, 07 Sep 2021 12:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=f+0l8Ryt5zjWLEbga+qWZXlmrVNbhUbSlJkpv4q1m6Q=;
        b=QCxNJAUN/CGZJjfvz/NoqvMJSBnGHsL4WR8G9isEwuKQY9GYefrspJwmS95FFw9wAG
         KSY4XrOuP+G200+82yzH/hlFzm1WVl7Y11DIPLnNJjvFBp+yIR0f2/tiGGKBbstOQW0N
         nMeSZ4t2pOxw7s4hCw8Q9NkHGE/gu46y4X4kU2NZDYcA1hTSeGb4FOGWbUlgSxjRzzWr
         qNCkPy/4FXBBM5rf0/IH6cq48yk1IZ06yapgMCLaXrYdkH+SoZiskvkw/VdPm16BL4Ia
         /pfDUOONg7VeR8Zzej8ND+KWsRM68NayWIKEmje532V4pMeUwo5vVYIWrnrcVS2W0WMX
         g+Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=f+0l8Ryt5zjWLEbga+qWZXlmrVNbhUbSlJkpv4q1m6Q=;
        b=KWYxN7a/Sm54Monm6Ac5bqCPtzndlxhzWwvPJbNgU5tKMlwj7Z8Xa1kSyVpjO9w6+T
         bZpB7uP+A7Q4rpf/5SjK79fA59eaHdR9w9DiksyT8ailNt3WyEMh0iE5YxBn3CAmBSB0
         ev6syLB/BFuIVRgJ19tBoqQLtqObbo4L6LUCtZ+zHck8c0FC6EDZUmQtKK614I5Alcwi
         wdwjfxDmruFI+tz3VBT7BA+SnUHSGRZqYvm1KPqXwIVb39aDd3H12AJgHg6Rw8bTmo0D
         PXHAXZNjxemc0zw9plTpi3H5EFAyk/W8HTk0fRvwkQYFEzQMr4QOgiNT3+2ABlaacbN/
         OQoA==
X-Gm-Message-State: AOAM531P4p/gLrSzCMo6bNrbkf/8tsu4scT05aJQKAEAQdyNsQCo0zfQ
        sbgC05kSCZHi2P99Mohosjc=
X-Google-Smtp-Source: ABdhPJyhZWSfHc0cOVEJXNkP3LC8WvwHmnEFCZhwOWWbvoTRo+gsPVyp89lAr6CEnBFGzE8+kMokbA==
X-Received: by 2002:a05:6402:c90:: with SMTP id cm16mr1222073edb.170.1631044192157;
        Tue, 07 Sep 2021 12:49:52 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id f26sm14959eds.90.2021.09.07.12.49.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 12:49:51 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH 0/2] pack-write,repack: prevent opening packs too early
Date:   Tue, 07 Sep 2021 21:48:05 +0200
References: <cover.1630461918.git.me@ttaylorr.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <cover.1630461918.git.me@ttaylorr.com>
Message-ID: <877dfskvxc.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Aug 31 2021, Taylor Blau wrote:

> This pair of patches fixes a race where the .idx is moved into place
> before the .rev file, allowing the pack to be in a state where it
> appears a .rev file wasn't generated.
>
> This can cause Git to inadvertently take the slow "generate the
> reverse index on-the-fly", which does not impact correctness, but is
> unnecessarily slow when compared to reading the .rev file.
>
> The race is fixed by moving the .idx into place only after all other
> pack-related files have already been written. The first patch fixes
> the direct `pack-objects` case, and the second patch fixes `repack`
> (which also renames pack files around).
>
> Thanks in advance for your review.
>
> Taylor Blau (2):
>   pack-write.c: rename `.idx` file into place last
>   builtin/repack.c: move `.idx` files into place last
>
>  builtin/repack.c |  2 +-
>  pack-write.c     | 12 ++++++------
>  2 files changed, 7 insertions(+), 7 deletions(-)

I've reviewed this to the point of coming up with my own series on top
of it, but it can be considered separately:
https://lore.kernel.org/git/cover-0.3-00000000000-20210907T193600Z-avarab@g=
mail.com/

The only change (if any) would be to perhaps update the commit
message(s) to note that the *.bitmap case is left, and that the promise
of "closing the race" is still subject to the vagaries of our non-use of
fsync() here, so pedantically speaking the race is still there.

But even without those suggested changes:

Reviewed-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
