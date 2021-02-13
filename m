Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1CD9C433E0
	for <git@archiver.kernel.org>; Sat, 13 Feb 2021 04:45:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC82064E2C
	for <git@archiver.kernel.org>; Sat, 13 Feb 2021 04:45:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232080AbhBMEoV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Feb 2021 23:44:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbhBMEoR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Feb 2021 23:44:17 -0500
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B7AFC061574
        for <git@vger.kernel.org>; Fri, 12 Feb 2021 20:43:37 -0800 (PST)
Received: by mail-oo1-xc2a.google.com with SMTP id g46so355225ooi.9
        for <git@vger.kernel.org>; Fri, 12 Feb 2021 20:43:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mUYXmSj+A7fPblQxNSfbDHCgXztY6S7ZzZDhckPxuZM=;
        b=u8p0ZcG00TpUwveyAoe+quLTVjUGeZll2XMGYKTDEOvbyFKjb0p0Vx22M2gNNOu110
         ehnUHxHw5KJZQ69QBY6imI29mEtucn4w7emSbmqIcP+I6Yw8aPTcixpKp1tOIpChs+US
         hT/2jMQZuLa40489DwChKpWI/PGAAF5QGkHgqWfumwyWgDMtZsD0boDNduTEuvCoJiGX
         cKHZMN4U+6/4Sp4s5ux5e0S2UEruM0+Gcq7hofZQYo4tMABR85V8DSHRhHGFM22F97CG
         ZzG+KymHG0T2bES+ZIROSFBjeEfk7Y7Us/US5AagiG/mfBJkid6YFtecJDEL2hYz1KnC
         c2Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mUYXmSj+A7fPblQxNSfbDHCgXztY6S7ZzZDhckPxuZM=;
        b=pXXc9NXang2qfQA3mTLyj1ZVLgKpHlrt0DyLmJBaq7guMjHY6cLTB/11EzZ9zoI6yO
         Z9yiN+AwiSdqoAt+WkWGog/LLUm2T06DQXcsiWNuOFk4B116aJPvE8npJW17N0cIyEKA
         7Ct5ul6C7cLmsx6T0UNGRPNUXZtIdLhqtbDfbSN2mnuugnF7ZN3erkR+nBxwxoHsuH4B
         TmRbWG5cCAP7D2YZe2cRKHMXfM1YRrEpOrGnJW6pEoeXciSSmX3r9SPU9NG/s4ckh/QA
         hfOuBpUfClqyry7BkJqV5aYiW0Hr3s0JgEeAamBmY7dhyPCN/V3glNwUgu/dmbU49CxV
         ntpw==
X-Gm-Message-State: AOAM531O35Uzn/+oNarQc1KiXvxb+w4B66mrvhr4/kWoouIAY51g6Kv8
        2VnK+jSztWTiKVvnDfXpBJwaDw5V4JuF2Vso0jA=
X-Google-Smtp-Source: ABdhPJwNZ62Hi2xrj/nzvuAx+TxlbJ1nK3jFX8cO54kjpkqd4r1XMm0UePzrzfazD3wYeH9ANXkscwjcbruVSh7icRQ=
X-Received: by 2002:a4a:e0d3:: with SMTP id e19mr210011oot.45.1613191416578;
 Fri, 12 Feb 2021 20:43:36 -0800 (PST)
MIME-Version: 1.0
References: <pull.842.git.1612331345.gitgitgadget@gmail.com>
 <pull.842.v2.git.1612382628.gitgitgadget@gmail.com> <7ae9460d3dba84122c2674b46e4339b9d42bdedd.1612382628.git.gitgitgadget@gmail.com>
 <xmqq8s7svkr9.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqq8s7svkr9.fsf@gitster.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 12 Feb 2021 20:43:25 -0800
Message-ID: <CABPp-BHj2k0dDwYB-F=G_aXTemSp5Hu-DK=mrX2pZf3WTH9fQg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] diffcore-rename: filter rename_src list when possible
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        Karsten Blees <blees@dcon.de>,
        Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 12, 2021 at 5:06 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > @@ -578,8 +624,7 @@ void diffcore_rename(struct diff_options *options)
> >                       struct diff_filespec *one = rename_src[j].p->one;
> >                       struct diff_score this_src;
> >
> > -                     if (one->rename_used && !want_copies)
> > -                             continue;
> > +                     assert(!one->rename_used || want_copies || break_idx);
>
> Doesn't assert becomes a no-op in production builds?  Shouldn't this
> be a BUG() instead?

I guess it depends on the reason for the line.  If we're just trying
to help others understand the code by documenting conditions that are
true (and perhaps help them when they are refactoring), then comments
like

    /* The following is true at this point: !one->rename_used ||
want_copies || break_idx */

could also be used, but it's kind of verbose.  The form

    assert(!one->rename_used || want_copies || break_idx);

is shorter, clearer, and is likely to be up-to-date because even if
most builds and users turn off assertions, some folks will build and
run with assertions on.  If it's a refactoring-aid, then the latter
form is also more likely to help the future developer (who may be
future me).


If, however, the purpose is to check for bad input or worries about
programming logic possibly have edge cases, and we're afraid that such
conditions might cause severe and hard to debug problems later in the
code, then we absolutely would rather use a BUG().

Most of my uses of assert() fall in the former category.  I use BUG()
when it's a line meant for the latter category.  There are a few that
perhaps fall in between, where I just have to make a judgement call.
I'd like to say that I'm more likely to use BUG() for those, but the
lack of a BUG_ON() does tend to make it pretty annoying to use and
certainly discourages it.

Granted, that's the way I look at it.  I'm curious if others have a
different view.  It certainly seems like the project likes to use both
forms nearly equally:
$ git grep assert\( origin/master | wc -l
468
$ git grep BUG\( origin/master | wc -l
506

so I'm curious if there are other factors that make folks pick one or the other.
