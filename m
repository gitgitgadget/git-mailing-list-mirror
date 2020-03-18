Return-Path: <SRS0=hWrV=5D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5515C4332B
	for <git@archiver.kernel.org>; Wed, 18 Mar 2020 20:41:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8024E2076F
	for <git@archiver.kernel.org>; Wed, 18 Mar 2020 20:41:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tZ6AXWNF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbgCRUlg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Mar 2020 16:41:36 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:38297 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726647AbgCRUlg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Mar 2020 16:41:36 -0400
Received: by mail-oi1-f195.google.com with SMTP id k21so282423oij.5
        for <git@vger.kernel.org>; Wed, 18 Mar 2020 13:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B5XlyrDIx/tt77K66/EUx8Z/nEqwFnU07tcGzoh5424=;
        b=tZ6AXWNFrY2to5U/+QMjgzV2JiwLcCjq7I4ozshz3GheiNw2BJAmIzPqr5+nNvFSaH
         cnTnEKcMHhevR76WCqjXZQ2U0a1vY0fEHYkxAuHUl8lR71qGLp2ZWFczl+BD6CHe9FXv
         k94e/Urmf7qxFy4DtA9sMuLkuuA9qkTISeWlJxMrboBRwRIL8cgc9DRhzy62nJVKmZf3
         z5ua3V7msGgyQzD+N35WikylNJ4Lgo7dpti+pbEkL4GiYvmvjlFKmg6f+DgH0TvZPnDK
         1sShCDmjZy3Uo2p2VhktZbOrEGliIvW6GzCDidamB1ttJ7hg2WEuglMVhulX1fgEVJl2
         hi9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B5XlyrDIx/tt77K66/EUx8Z/nEqwFnU07tcGzoh5424=;
        b=SDjWoIL3hpPd47kVE6exD7ZhB/yrfB9xaVX7DXkWLH1QgXDQjhOv4aQ06eTpgE5MUZ
         20SM3Nr2LqSXJdlbnreyDUFARo5+2DMLJ2UGwLHSbFBVyscKpGm1TlNJa0tk0eguY85h
         6jmLyzWqfwST54p2UvOYB4sSJxpimv1yqfMshMLB7+XnSNPPql3dHg89sYQ0yDBi33F3
         44TjNSTbjYQSx706BvwFnpJbjbI85rtZCu9EHPHwfUZLj14+OdqSUhPHoKp0daocvCjD
         mVZanpJP33U981Q2ooN4XqI+u4i8U3MX5LYEkfL+f9GwynANZPVGIZjtGtAIvf5YuoJz
         +eXQ==
X-Gm-Message-State: ANhLgQ3NvuKbdfnKr/UyqRozl67zOiKqgnm7cJa4LN+RNJM7JPyKNAMa
        qoJNRGM1FyqKciZ4vqR6UlxXykcR5i13S+Q3B0k=
X-Google-Smtp-Source: ADFU+vs/Pgu7hSzQOyQaMLtOu+586DHXZwN0eS5I7P0k5Ziuzxr+t73m5tWKFu3kEmOeFPTQPzY2NLLi5GjRSMXMehg=
X-Received: by 2002:aca:dc45:: with SMTP id t66mr4829787oig.39.1584564094867;
 Wed, 18 Mar 2020 13:41:34 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqpnd9fql0.fsf@gitster.c.googlers.com> <20200318192821.43808-1-jonathantanmy@google.com>
 <xmqqd099fnfm.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqd099fnfm.fsf@gitster.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 18 Mar 2020 13:41:23 -0700
Message-ID: <CABPp-BGSvT9zu1xjHUPHBQ3jEktZ56O=m6VNH2v0E-RcfBN_tw@mail.gmail.com>
Subject: Re: [PATCH v2] rebase --merge: optionally skip upstreamed commits
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Git Mailing List <git@vger.kernel.org>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 18, 2020 at 12:55 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Jonathan Tan <jonathantanmy@google.com> writes:
>
> >> Hmph, what was it called earlier?  My gut reaction without much
> >> thinking finds --no-skip-* a bit confusing double-negation and
> >> suspect "--[no-]detect-cherry-pick" (which defaults to true for
> >> backward compatibility) may feel more natural, but I suspect (I do
> >> not recall details of the discussion on v1) it has been already
> >> discussed and people found --no-skip-* is OK (in which case I won't
> >> object)?
> >
> > It was earlier called "--{,no-}skip-already-present" (with the opposite
> > meaning, and thus, --skip-already-present is the default), so the double
> > negative has always existed. "--detect-cherry-pick" might be a better
> > idea...I'll wait to see if anybody else has an opinion.
>
> While "--[no-]detect-cherry-pick" is much better in avoiding double
> negation, it is a horrible name---we do not tell the users what we
> do after we detect cherry pick ("--[no-]skip-cherry-pick-detection"
> does not tell us, either).

I like --[no-]detect-cherry-pick.  I'm on board with using "keep"
instead of "skip" to avoid double negation.

> Compared to them, "--[no-]skip-already-present" is much better, even
> though there is double negation.

This one seems especially bad from a discoverability and
understandability viewpoint though.  It's certainly nice if options
are fully self-documenting, but sometimes that would require full
paragraphs for the option name.  Focusing on what is done with the
option at the expense of discovering which options are relevant to
your case or at the expense of enabling users to create a mental model
for when options might be meaningful is something that I think is very
detrimental to usability.  I think users who want such an option would
have a very hard time finding this based on its name, and people who
want completely unrelated features would be confused enough by it that
they feel compelled to read its description and attempt to parse it
and guess how it's related.  In contrast, --[no-]detect-cherry-pick is
a bit clearer to both groups of people for whether it is useful, and
the group who wants it can read up the description to get the details.

> How about a name along the lines of "--[no-]keep-duplicate", then?

This name is much better than --[no-]keep-already-present would be
because "duplicate" is a far better indicator than "already-present"
of the intended meaning.  But I'm still worried the name "duplicate"
isn't going to be enough of a clue to individuals about whether they
will need this options or not.  Perhaps --[no-]keep-cherry-pick?

> >> I also wonder if --detect-cherry-pick=(yes|no|auto) may give a
> >> better end-user experience, with "auto" meaning "do run patch-ID
> >> based filtering, but if we know it will be expensive (e.g. the
> >> repository is sparsely cloned), please skip it".  That way, there
> >> may appear other reasons that makes patch-ID computation expensive
> >> now or in the fiture, and the users are automatically covered.
> >
> > It might be better to have predictability, and for "auto", I don't know
> > if we can have a simple and explainable set of rules as to when to use
> > patch-ID-based filtering - for example, in a partial clone with no
> > blobs, I would normally want no patch-ID-based filtering, but in a
> > partial clone with only a blob size limit, I probably will still want
> > patch-ID-based filtering.
>
> Perhaps.  You could have something more specific than "auto".  The
> main point was instead of "--[no-]$knob", "--$knob=(yes|no|...)" is
> much easier to extend.  I simply do not know if we will see need to
> extend the vocabulary in the near future (to which you guys who are
> more interested in sparse clones would have much better insight than
> I do).

I also struggle to understand when auto would be used.  But beyond
that, I'm still a little uneasy with where we seem to be ending up
(even if no fault of this patch):

1) Behavior has long been --keep-cherry-pick, and in various cases
that behavior can reduce conflicts users have to deal with.
2) Both Junio and I independently guessed that the cherry-pick
detection logic is poorly performing and could be improved; Jonathan
confirmed with some investigative work.  We've all suggested punting
for now, though.
3) I think we can make the sequencer machinery fast enough that the
cherry-pick detection is going to be the slowest part by a good margin
even in normal cases, not just sparse clones or the cases Taylor or I
had in mind.  So I think it's going to stick out like a sore thumb for
a lot more people (though maybe they're all happy because it's faster
overall?).
4) Jonathan provided some good examples of cases where the
--keep-cherry-pick behavior isn't just slow, but leads to actually
wrong answers (a revert followed by an un-revert).

I particularly don't like the idea of something being the default when
it can both cause wrong behavior and present a huge performance
problem that folks have to learn to workaround, especially when based
only on the tradeoff of sometimes reducing the amount of work we push
back on the user.  Maybe that's just inevitable, but does anyone have
any words that will make me feel better about this?

Elijah
