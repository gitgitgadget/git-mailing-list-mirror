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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E810FC4361B
	for <git@archiver.kernel.org>; Fri, 18 Dec 2020 22:57:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B05B823B97
	for <git@archiver.kernel.org>; Fri, 18 Dec 2020 22:57:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726016AbgLRW44 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Dec 2020 17:56:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725957AbgLRW44 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Dec 2020 17:56:56 -0500
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24DB4C0617A7
        for <git@vger.kernel.org>; Fri, 18 Dec 2020 14:56:16 -0800 (PST)
Received: by mail-ot1-x331.google.com with SMTP id b24so3510158otj.0
        for <git@vger.kernel.org>; Fri, 18 Dec 2020 14:56:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YJUwid5EAXCwsSEzB3+yBZH5KEOAaOA/xu4iebpUMuk=;
        b=jkVPzs56KyqJH8lSPJi7HzPUDwKAz8rda9nEyOIGGSpdRfMRKGDNxLg5sDOak4ERql
         nnafK6XXcYs9ba/9G0Go0HrIzdcr5zBOVQXxiAK8l6XnAmeBkozffGQJonXZzROMYW6s
         3o+e/DsI7B2bI96Di74fsGuNKIpWAhmcdILvMZAPORooaub5Tr6JFtplz3+UBKz/IYFh
         UmuFH3WgBuR/r4v58ik/2hlyaL6i9l6IDHimEOLZ7tRBX6dSsWmIxnn4AnfS/EhkDakk
         7ss1HGhY4sD7xc2oKeyqN+HuSuUcvfxTAPrm6VqZJYPMRb7kG6j62odirH4a8Ioq/ahW
         rndQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YJUwid5EAXCwsSEzB3+yBZH5KEOAaOA/xu4iebpUMuk=;
        b=VeU4yiukziqKSezbwGw/auF7MSFDINmtBnRHpyi1NOqoMeVJE6sn6HDTh0XmMT21mC
         mRFvJZLlI5aJhFneXx3BXbTfSeQaU/RGenbQAPNMEU88GeAzL6G4MUNNIUF5sX8XNv7K
         ypClqO9g1AdZmLSWS2RXGy9HimWQgbk8deVCUTNNF59PGXWoC9NRHgmvPyytu8u/oOPq
         y0zi9sGf2r2VK/EXwxLjTStmUQ1aCXvPa8eQJKXGcnmCyK5t4VE/8wIhOj/JT1Zuj8Za
         IvqvEzT6x8qwLZA6HHHblfw/iGmbX6V0436vcqa3Al3wnSzltJYpaRxnT1MHRuxsq9Zx
         cPhA==
X-Gm-Message-State: AOAM530jhHC/P05vCEBSwT4OGmUCzdQebs9Q79aqYevl2QzdFMq7ifrJ
        UAdenhIXk/sKJj5JcWHFzeNWFqPWZzcgBXgUhH0=
X-Google-Smtp-Source: ABdhPJzRamBKkzjNuOiUmB2GSrJnaT2oCzwEbQ5QMoc65u0+euhKMfgGhynNqBtiiIv4Zwk+luSuwEDxjeBJD0uiGyQ=
X-Received: by 2002:a05:6830:10:: with SMTP id c16mr4418469otp.162.1608332175552;
 Fri, 18 Dec 2020 14:56:15 -0800 (PST)
MIME-Version: 1.0
References: <20201101193330.24775-1-sorganov@gmail.com> <20201216184929.3924-1-sorganov@gmail.com>
 <20201216184929.3924-24-sorganov@gmail.com> <CABPp-BEf2nbahjzR6aLLNy0YsHYcHqCozCe6veoZOH3LAM892g@mail.gmail.com>
 <87blercju2.fsf@osv.gnss.ru> <CABPp-BGPZiwjSzZw5PLwkctW7hnG2S6UGHmkTGCh1BqgXJ+vEQ@mail.gmail.com>
 <871rfm95b9.fsf@osv.gnss.ru>
In-Reply-To: <871rfm95b9.fsf@osv.gnss.ru>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 18 Dec 2020 14:56:04 -0800
Message-ID: <CABPp-BEZ6VqyTah7QCzkuUm-p7tA_6cnpGPWpgpQbHp_c3Wc5Q@mail.gmail.com>
Subject: Re: [PATCH v2 23/33] diff-merges: fix style of functions definitions
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 18, 2020 at 1:23 PM Sergey Organov <sorganov@gmail.com> wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> > On Fri, Dec 18, 2020 at 5:41 AM Sergey Organov <sorganov@gmail.com> wrote:
> >>
> >> Elijah Newren <newren@gmail.com> writes:
> >>
> >> > On Wed, Dec 16, 2020 at 10:50 AM Sergey Organov <sorganov@gmail.com> wrote:
> >> >>
> >> >> Put open curly brace on its own line
> >> >>
> >> >> Signed-off-by: Sergey Organov <sorganov@gmail.com>
> >> >> ---
> >> >>  diff-merges.c | 36 ++++++++++++++++++++++++------------
> >> >>  1 file changed, 24 insertions(+), 12 deletions(-)
> >> >>
> >> >> diff --git a/diff-merges.c b/diff-merges.c
> >> >> index cba391604ac7..0165fa22fcd1 100644
> >> >> --- a/diff-merges.c
> >> >> +++ b/diff-merges.c
> >> >> @@ -2,7 +2,8 @@
> >> >>
> >>
> >> [...]
> >>
> >> >>
> >> >> -void diff_merges_set_dense_combined_if_unset(struct rev_info *revs) {
> >> >> +void diff_merges_set_dense_combined_if_unset(struct rev_info *revs)
> >> >> +{
> >> >>         if (!revs->combine_merges)
> >> >>                 set_dense_combined(revs);
> >> >>  }
> >> >> --
> >> >> 2.25.1
> >> >>
> >> >
> >> > But...didn't you add all these functions yourself earlier in the
> >> > series?
> >>
> >> Yes, I did indeed and somehow picked wrong style from one of the
> >> occurrences of this style in the existing Git codebase.
> >>
> >> > Why didn't you split this patch up and squash it into the
> >> > relevant previous patches?
> >>
> >> When Junio noticed and pointed to this deficiency, I asked him if I
> >> should fix all the series from the start, or it'd be OK to use fixup
> >> commit. As he didn't answer and nobody else commented either, I opted
> >> for the latter.
> >>
> >> I can still do it if it's that essential, but I'd prefer not to, to
> >> avoid both the hand-work and causing entire series to change. The
> >> problem is that there were code movements in the series, so such a fix
> >> to earlier patches would cause conflicts down the commits chain, to be
> >> resolved by hand.
> >
> > That's what add -p and interactive rebase is for.  :-)  Code is read
> > more than it is written, so it's important to get things clean.  And
> > not just for immediate reviewers, but for people who look at it later.
>
> I do know how to do it, but I'd still prefer it to be accepted in its
> current form, as I don't see this particular case being that important
> to justify rewriting of all the series. I'll go through the pain if
> it's a show-stopper though.

Personally, I think that a really important point to keep in mind when
submitting patch series is trying to figure out the easiest way to
move the code from point A to point B, not the route you took to get
from point A to point B.  This is especially true for longer patch
series.  It's common after you've finished a series to discover there
was an easier or cleaner route to follow that would have arrived at
the same end-point.  It's not uncommon for me to spend a significant
chunk of time rebasing and restructuring a patch series to try to
highlight such a better path.  This includes not just style fixups,
but different patch orderings, alternate ways to break up functions,
using different data structures, etc.

All that said, I don't get to choose what's accepted or not, so I
can't say if it'll be required.  What I can say is I like your series
and I think it provides obvious improvements, but I'd still recommend
against its inclusion as it stands for as long as this patch is still
present.  (I have a feeling that there are other things in this series
that possibly should be squashed, restructured, or refactored, e.g.
[1]).  This is just my opinion, of course.  You are free to disagree
with me, and wait to see what others say and what Junio does.


[1] https://lore.kernel.org/git/CABPp-BESWpqska++EsfxfbncyV0kNo1RGLjF+1BiV=D6zLx2LQ@mail.gmail.com/
