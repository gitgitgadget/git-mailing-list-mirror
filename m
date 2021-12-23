Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8B99C433F5
	for <git@archiver.kernel.org>; Thu, 23 Dec 2021 18:37:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349853AbhLWShC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Dec 2021 13:37:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240342AbhLWShB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Dec 2021 13:37:01 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15E19C061401
        for <git@vger.kernel.org>; Thu, 23 Dec 2021 10:37:01 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id q14so17057475edi.3
        for <git@vger.kernel.org>; Thu, 23 Dec 2021 10:37:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/E4mbEizUsFRnrbDewe7z9bQE4tS88JkgLCz9rWDROY=;
        b=OX3bxc2kqUUs192C2gss6yhrJgea1jq7a+LEJQjHZYoLTFyTl9Orypv04q/4Gaybcd
         mY7bN9Ca3EJvQ6QHtHT4nctEc5tqOi64SLWrgof91IMuUeXdd9lEi7GR46ZqXH2O8bgo
         +DwZs2Lg9e0YpD3tf6WjNeVn2ZcK4J0qvXepFH8FT0Gxvs7nq4+xTSRfLtAV11oz41zY
         oi+sDwUw9UAX24K1nR5zSr5h1R4l2cQTmwZQQyvPL8xewa/q4cqJIyGr7ExYABt1m3MS
         iod1llE5JO5H6SVEE0G/zkxjy4EX+5S0WvsDzrPlGAf4NBdUFiQO8i5AAixaPYpFJkrS
         HStQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/E4mbEizUsFRnrbDewe7z9bQE4tS88JkgLCz9rWDROY=;
        b=x15ElzafDjI9YcajnnFMCR5DsqSzj88H6e/WOHEAZJj7QHGdzTuoCyiPrCIX8dbMpb
         gkHhdJ1K2n4oSsmaRw9WuaA/FkWZhXT9C3Q4BTl6sWSKvKs4CHcQPZNcKDF9ZDanmqDA
         nOMv0xdOGRnTkBMCA3LwWgskIrj9/XS+banl6tqj52aPAjO0CyDGD8LR75U3zpD11dSz
         5am810CU21nUli92LNoCf3uOl5ZLiesdd/Mxch2/4uQoukjaO8vsxaSnyjit0i3rPMit
         7UtYQWw0H/atYVl6hDWSJuzf9LWidhV+0rTA9MLCy3/wcWslJZV70FVfOMZfrgnWMZ8K
         RfCQ==
X-Gm-Message-State: AOAM530g4ymNm1ArkkYxHMWOYCJ2ouaa0YyMcdLAgOHFG6Km0/bPb2am
        eewEUGCXff9x2j4A1Hn1fJmwq55UF5tA1ecQhuA=
X-Google-Smtp-Source: ABdhPJyf9LMz9O6JDNOvxxaYwpZyct9mwVSIFtfpWrBoSBg5BV2t333+DxQ0yHycWXh+0UXf1VZjj4YbXgcmP7xltOY=
X-Received: by 2002:a05:6402:350b:: with SMTP id b11mr3055665edd.228.1640284619638;
 Thu, 23 Dec 2021 10:36:59 -0800 (PST)
MIME-Version: 1.0
References: <pull.1103.git.1640109948.gitgitgadget@gmail.com>
 <f36395fdee044a077a640bd3031a7a8da8a39657.1640109948.git.gitgitgadget@gmail.com>
 <xmqq5yrho6f3.fsf@gitster.g>
In-Reply-To: <xmqq5yrho6f3.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 23 Dec 2021 10:36:48 -0800
Message-ID: <CABPp-BEqrB4cKb7QimJz9umKTcfLOrskkGBOYXnUDX36YyhROA@mail.gmail.com>
Subject: Re: [PATCH 3/9] merge-ort: capture and print ll-merge warnings in our
 preferred fashion
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Neeraj Singh <nksingh85@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 21, 2021 at 4:00 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: Elijah Newren <newren@gmail.com>
> >
> > Instead of immediately printing ll-merge warnings to stderr, we save
> > them in our output strbuf.  Besides allowing us to move these warnings
> > to a special file for --remerge-diff, this has two other benefits for
> > regular merges done by merge-ort:
> >
> >   * The deferral of messages ensures we can print all messages about
> >     any given path together (merge-recursive was known to sometimes
> >     intersperse messages about other paths, particularly when renames
> >     were involved).
>
> I would imagine that with something like this, we can show such a
> warning message differently when it happens during an inner
> "synthesizing a virtual common ancestor" merge (the most likely
> value for "show differently" would be to "squelch"), which may be a
> good thing.

Yes, that is a possibility that opens up after this.  Which reminds
me, merge-recursive nicely nested conflict/warnings messages from
inner merges by adding 2*call_depth space characters before messages.
I lost that in merge-ort (which becomes more problematic since
merge-ort tries to group messages about the same path together, thus
mixing inner merge messages with outer ones and providing no way to
differentiate the two).  I've got a patch to fix that up, but of
course it conflicts with this series, so I'll be submitting it after
this one settles.

> >       if (merge_status == LL_MERGE_BINARY_CONFLICT)
> > -             warning("Cannot merge binary files: %s (%s vs. %s)",
> > -                     path, name1, name2);
> > +             path_msg(opt, path, 0,
> > +                      "warning: Cannot merge binary files: %s (%s vs. %s)",
> > +                      path, name1, name2);
> >
>
> Nice.
