Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A0BFC433EF
	for <git@archiver.kernel.org>; Mon, 25 Apr 2022 10:31:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239206AbiDYKeD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Apr 2022 06:34:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241472AbiDYKdz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Apr 2022 06:33:55 -0400
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9634623B
        for <git@vger.kernel.org>; Mon, 25 Apr 2022 03:30:51 -0700 (PDT)
Received: by mail-vs1-xe2e.google.com with SMTP id m14so13887493vsp.11
        for <git@vger.kernel.org>; Mon, 25 Apr 2022 03:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ne4qa600hAHRGCjCiRJlW2aeUcGfHawsqRniUCgz8As=;
        b=hWkGcvI7a/gH+epRZcl9boBqMTt0p+seRP8P2+NbitA4e0+ALH5twj4xDk3EGaP2IT
         FWGrmDt/6NaHWS1WlLbIJ2VXd38wX23VbEn837y+5OUODKlMfPW10d5a+i14CCjCZkZF
         pLfEXCl6hxpvwhEOLc6/VNWtvjVhw0ujLf3MPJ0eNJHONuF2YeGtgz5rckHiDuxK81tt
         +FI2gXVUM4OzNO+EwMg2qQBU/K16xZQX+mrWuVDEOwwVrRkPnuYF655ZYl6BNrTb0D+g
         p8ny0egcGWZENRL2CYmXYme7B2Sa7zqWxPn8ctbZ0A9uHz5uNH3Yy4IN21+IfIfMaQmD
         ZDBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ne4qa600hAHRGCjCiRJlW2aeUcGfHawsqRniUCgz8As=;
        b=2QDjqxrBYG3xJ3rn8jEVFFUInco3BKstyO2+Sf57p2lBCqYGKKgLUCsmhiPcE2qTGR
         KG6OEmerZhAFMDAJWiCJRv61nHiluYpGwHRUulq3nbGLrhqy2bxt0dXNHqxfbnzz599V
         io5JhI5EKiWHWUdOMxcfw5IdMHakMgBz8Xu0uGNQFlsJ4gujkEN1jA7iCF02UjIWiARv
         Cybu08MR/hPoxMdIY0Papi46sIyAmqTzN8vvkZnX5Vx3SQ58p27pfDQv/ARsQPzavjSG
         26HnDrcpklr/QOC5bjpibLRsRQbO52OnsvJ8UIza4jm2AzT4QyiSNYcxVOSGvfUx9V9o
         VbXQ==
X-Gm-Message-State: AOAM532DZ6V+46Q1lew4fbmdDGl/FAkpaoNs7NYp0m/f4fLwlOOU47hW
        cUSs7XPyvnbia9IFtzqXM5SWmxCTw6k/Cn3AXafe8w==
X-Google-Smtp-Source: ABdhPJznLEm4Mr3oJwyIe4VfkpeOc3om6257sjM0vOC2kjodslu3DnOnIc7iawhMw57gZH/Suc79/AVW+ufN5i54Ahg=
X-Received: by 2002:a67:c588:0:b0:32c:d422:4038 with SMTP id
 h8-20020a67c588000000b0032cd4224038mr691943vsk.53.1650882650475; Mon, 25 Apr
 2022 03:30:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220415083058.29495-1-carenas@gmail.com> <RFC-cover-0.2-00000000000-20220415T101740Z-avarab@gmail.com>
 <RFC-patch-2.2-364d1194a95-20220415T101740Z-avarab@gmail.com>
 <4321a9dd-bb82-e2fe-5449-395f998378c5@web.de> <220415.86fsmebgds.gmgdl@evledraar.gmail.com>
 <23138e2b-436a-0990-cefc-0662674373c3@talktalk.net> <220415.86bkx2bb0p.gmgdl@evledraar.gmail.com>
 <xmqq1qxyfh8k.fsf@gitster.g>
In-Reply-To: <xmqq1qxyfh8k.fsf@gitster.g>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Mon, 25 Apr 2022 12:30:38 +0200
Message-ID: <CAFQ2z_OF5+BPxchJcydOhE5tPO2DDeuiJ0-5TzN7kTxD7TpEgA@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] reftable: don't memset() a NULL from failed malloc()
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Phillip Wood <phillip.wood@talktalk.net>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        git@vger.kernel.org,
        =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>,
        Edward Thomson <ethomson@edwardthomson.com>,
        Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 15, 2022 at 6:23 PM Junio C Hamano <gitster@pobox.com> wrote:
> >> git grep -e 'reftable_[mc]alloc' -e 'reftable_realloc' -A2 origin/master
> >>
> >> and I didn't see a single NULL check
> >
> > I think you're right, I retrieved that information from wetware. Looking
> > again I think I was confusing it with the if (x) free(x) fixes in
> > 34230514b83 (Merge branch 'hn/reftable-coverity-fixes', 2022-02-16).
>
> True.  Initially I hoped that these RFC changes gives us a better
> solution that comes from stepping back and rethinking the issues
> around the original "why are we calling memset() with NULL?", and

memset with NULL is an oversight.

The malloc routines are pluggable so the code could be reused for
libgit2. However, as use within Git itself is still not imminent, they
could just as well be removed as they are just a premature
generalization right now.

> if it were only "well, in _return_block() functions, we clear the
> block before calling _free()---that shouldn't be necessary, if the
> calling custom malloc-free pair cares, they can do the clearing, and
> plain vanilla free() certainly doesn't, so let's stop calling

The memset() calls on free() (eg. in  are there to tease out
use-after-free bugs in the unittests, but they should probably be
removed from file_return_block() as that is production code.

-- 
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
