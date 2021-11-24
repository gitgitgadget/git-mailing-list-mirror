Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09F62C433EF
	for <git@archiver.kernel.org>; Wed, 24 Nov 2021 22:03:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245727AbhKXWGf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Nov 2021 17:06:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231322AbhKXWGc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Nov 2021 17:06:32 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B123C061574
        for <git@vger.kernel.org>; Wed, 24 Nov 2021 14:03:22 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id y12so16579406eda.12
        for <git@vger.kernel.org>; Wed, 24 Nov 2021 14:03:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kfVMNZQtctbVDcJwnihPtcdSu2nqhvyp8yojvOHt0rI=;
        b=i8LXXh9VbNxuSsdLoMwwji1ZVeowILGW4Sjv652e9pwuxmXCX0Skq+DqRG0KBhf2JW
         65KS5hbXVOozDmDj4+pk0EV23+3RA3jddnY3vW1TAi7ASiPqwqD1sCBTokq0p2uQwQbI
         GfAYhzZp36wXnczTJ5xfYLrO07c4cHjsTJ5qKqDDRO7SgrH+Qrp1TFCVqYybM2PTwAdh
         bMCVMUMvUga2ROW7sivEuvdKbTUUtGVYRQ+1w5p2g6kwlcveurcXVVyVXgDKeDaxnLj3
         2kitkOSW/4OIAexo3CuZKeGIk2XG9ImisQ+XMzVWjXkRB/m9DoD5Xl6XfwnywNOEUSGY
         9GsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kfVMNZQtctbVDcJwnihPtcdSu2nqhvyp8yojvOHt0rI=;
        b=TK5pVpO9MjhS+0vPE+laKGCNupcduxb4beAkdyiBcXgYA9z9pE72zNVyaM9kEJFfmk
         /0iuh8rP32H28rUSdfcuJ/OlPukQD8Ily27ycqLtiKDQC4BXrO5vfBa8EOcaYo7qSOME
         bX7WsOzuPtkTWCZPM34aALJRIDLhoO+mBwrtpxGCT8pXtdKcUgE/bjGnZZE8thN8gUz8
         BnLAuvL6tZ5bxfqiyEnOkActSkR/97nL+lHsu5zEozWwNDDA/pwpmPCvAzs+nCQ4a/IO
         +A/elQ5gAAPzs1DNwrf1oC+5qL3EmYwuKil304Osdhp/SLtoPIQdUtwOXLWkGte/ClgQ
         cr8w==
X-Gm-Message-State: AOAM533hIzxN0zyPHirpwncDWAZor5bsmiLjxRSTKVHKJoBjHaulkkVG
        YjgcFcuOm1xizgXlP0063nPYsHLAVGZgZ98uPV4EMFNkL10=
X-Google-Smtp-Source: ABdhPJwpBy83c/YxkJ1/l3OqR5WHC57NoLV9it12v4lKjyKogKy+/lt86W+W1F9O2zDqsi454HFkKsqxumzGL6iksCE=
X-Received: by 2002:a05:6402:653:: with SMTP id u19mr30037585edx.106.1637791400766;
 Wed, 24 Nov 2021 14:03:20 -0800 (PST)
MIME-Version: 1.0
References: <CANiSa6iNpm6--qHpUFYhPfSi+ounGttA8=TAsep18A-=iyoFEQ@mail.gmail.com>
 <xmqqmtltz1vp.fsf@gitster.g>
In-Reply-To: <xmqqmtltz1vp.fsf@gitster.g>
From:   Martin von Zweigbergk <martinvonz@gmail.com>
Date:   Wed, 24 Nov 2021 14:03:08 -0800
Message-ID: <CANiSa6iAXAXeDCh_OK=-wLPQiFSWFxRyCSC0SVvTJ8Gp4wdQ7w@mail.gmail.com>
Subject: Re: Letting tools partially resolve conflicts in a file
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 24, 2021 at 1:21 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Martin von Zweigbergk <martinvonz@gmail.com> writes:
>
> > I've searched the list and not found anything about this topic, but I
> > figured I'd ask to be sure. The question is not specific to Git, but
> > this seems like a forum where it might have been brought up.
> >
> > You could imagine having a merge tool that was specialized for some
> > purpose and only able to resolve a particular kind of conflict. An
> > example would be a tool that resolves conflicts in `#include` lines or
> > `import` lines. It could be useful to have such tools run as part of a
> > chain of merge tools, where the final merge tool is what users
> > normally have configured (such as `meld`, or the internal "attempt
> > merge, or leave conflict markers" tool).
> >
> > Has this problem come up before?
>
> I do not recall seeing such a topic, but I am not sure how practical
> your idea is to implement from the Git side.
>
> As a zeroth order approximation, instead of such a half-auto-merge
> tool, while resolving a conflicted merge with two conflicted hunks
> in a file, if you hand edit one conflicted hunk and then run "git
> mergetool", is your "half resolution by hand" seen by the mergetool
> backend correctly?

I would guess that it doesn't and I think that's what you concluded below.

> I tried to follow from git-mergetool.sh::main() what happens.  Each
> path is given to merge_file() helper function, and three temporary
> files, $BASE, $LOCAL, and $REMOTE, are prepared from the blob object
> registered in the index at stages #1, #2 and #3.  A mergetool
> backend, e.g. mergetools/meld, looks at these three files in its
> merge_cmd() function.
>
> Notice that the contents in the working tree file after a conflicted
> auto-merge does not even get looked at by the mergetool backend in
> the above picture?  I am not sure if replacing the contents of LOCAL
> with your half-resolved contents would give us the behaviour you
> want.  If it were the case, perhaps vanilla "git mergetools" would
> have fed the current file in the working tree, which was half
> resolved by "git merge" with conflict markers, as LOCAL to the
> mergetool backend even before we started discussing this topic, so I
> am not that optimistic.

The solution I had in mind for letting merge tools communicate partial
resolution was to let them take 3 inputs (as today) and produce 3
outputs (perhaps by overwriting its 3 inputs). That way they can leave
conflicts in a conflict-marker-agnostic way. Let me illustrate with an
example. Let's say you have this input:

base:
a
b
c
d

left:
a2
b
c
d2

right:
a3
b
c
d3

The tool now has some intelligence and decides that the conflict in
the first line should be resolved with a4, but it doesn't know how to
resolve the conflict in the last line. It then produces three outputs:

base:
a4
b
c
d

left:
a4
b
c
d2

right:
a4
b
c
d3

Obviously this scheme requires cooperation from the merge tool. That
seems fine as it only seems useful for tools that are designed for
partial conflict resolution. There should always be a regular merge
tool later in the chain after any tool that might produce a partial
resolution.

> I assume that your idea is that various small "I know how to resolve
> only this kind of conflicts" tools can plug into a larger merge
> helper framework to improve end-user experience, and I find the idea
> intriguing.

Correct. My team at work hopes to create a language-aware mergetool.
The "#includes and imports" I mentioned is just one case that such a
tool could resolve. Hopefully it can also figure out cases like where
both sides modify an array (on a single line), or where an expression
is modified on one side and re-wrapped on the other. The thing is that
it will obviously not be able to handle *all* conflicts, so we want to
leave remaining conflicts for the user, so that's where this idea
comes in. I don't foresee having more than one such tool in the chain
before the user gets involved.

>  I would be surprised if such an idea has never been
> discussed by folks in projects that develop and maintain merge
> helpers, like meld and kompare.  But I am not convinced if it is a
> good idea to do that on our side, before we spawn these mergetool
> backends.
>
>
