Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BD07C433EF
	for <git@archiver.kernel.org>; Fri,  3 Jun 2022 08:30:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240300AbiFCIaE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Jun 2022 04:30:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242846AbiFCIaA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Jun 2022 04:30:00 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD74327179
        for <git@vger.kernel.org>; Fri,  3 Jun 2022 01:29:58 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id h23so3465615ejj.12
        for <git@vger.kernel.org>; Fri, 03 Jun 2022 01:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=klerks.biz; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bC73XocJkUqtrb7b+ytwOZ7emB/yz7W0aq0ULFSFrIo=;
        b=HxAA+ApOJQ4+xtdR5j5YenbnHe+ywUP7VivwSyHaurl+rompHm6foxpc3ocdNXdHPM
         seJ0H9gWq67M+teh6ld1ZF9a6OwTu1vIAoa6SSsgD4BYKw2PtQJuj04hR56YibhNz6o6
         x2snqA/3oKP60hnnszx8o4Dz/tc3gpn0oATW8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bC73XocJkUqtrb7b+ytwOZ7emB/yz7W0aq0ULFSFrIo=;
        b=7gFppu1mjqOsuzD8lp4jNwaUrKSUEyOoU96YZvwxOGN5DsMOcrWiKGtJL46ErAkNlg
         Bj3lcrhCvWDkIE7LK04y31bkKzUcH4P2CKKUNSoAXDYCs/tC0oIDpNEoDUM/naaBuDxW
         RKQ5YCvHRpeo04pP4YIk6+SL1HgGwhhNeAoWrKAfIzpT/JYUAzRCVsLM3KSEXLgppqIN
         wIaxE+BZUMqD+H5FDbQ0xBLNAYZvCKdS38KiVjlEvUeYPlFp6xO2QyR6VJR55Bz5Cq5p
         lG3qrAnKpNDTnvsDENJNh0OaB6zksLpCK6v5K6urTaNNAXlKDZugtnzPMGGbJ0Cjp0wC
         A6dQ==
X-Gm-Message-State: AOAM532eictJyrIa91UZgotx28ffDU2/qBnEBB4LxJGzDjSPsGjBj5dK
        sGSCvdB5LUVKT2PDXWJlwzLCSh1K37ZrmKYattzfEAEQFjlyKEPh
X-Google-Smtp-Source: ABdhPJzNi8z8KTbbOgQy9JhsowqiNd+c3DaoRVp1ZTB9O+1EDfuzMkYLlfyH2MUiAV36bJHYKN2norTXdlT1MlpFbdA=
X-Received: by 2002:a17:906:eb54:b0:708:99d6:83e with SMTP id
 mc20-20020a170906eb5400b0070899d6083emr7366994ejb.745.1654244997286; Fri, 03
 Jun 2022 01:29:57 -0700 (PDT)
MIME-Version: 1.0
References: <CAPMMpohvKSgcL=X=Z=Wf7zHRr_Ghex5oZ4iUTgZL7XhHSWFi8g@mail.gmail.com>
 <xmqq5ylior3l.fsf@gitster.g>
In-Reply-To: <xmqq5ylior3l.fsf@gitster.g>
From:   Tao Klerks <tao@klerks.biz>
Date:   Fri, 3 Jun 2022 10:29:45 +0200
Message-ID: <CAPMMpojDoyJ+prLHKATnH2rVBVX=x0ES__6rvAZyq7GNiwutHw@mail.gmail.com>
Subject: Re: Introduce "git stash --continue" and "git stash --abort"?
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 2, 2022 at 8:30 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Tao Klerks <tao@klerks.biz> writes:
>
> > I would expect that some sort of merge- or rebase-like "--continue or
> > --abort" facility would make this much easier to understand... but of
> > course I have no idea how one would go about doing that. I assume the
> > closest existing pattern would be "git cherry-pick", but I imagine I'm
> > missing lots of subtleties.
> > ...
> > Is this kind of direction one that's been considered before? Are there
> > reasons why it's a bad idea?
>
> I saw a few exchange on the intended use of "stash" on another
> thread in the past days, but I think the reason why the current
> set of defaults and behaviour are appropriate for "stash" is related
> to it.
>
> The intended use of "stash" is to clear the deck as quickly as
> possible to deal with "emergencies", and its behaviour comes from
> the need to support that use case effectively.

Makes sense, with you so far!

> Untracked cruft are
> often useful even when you do a "quick context switch" (aka "the
> boss suddenly appears and asks you to do something different real
> quick"), hence "-u" is not the default, for example.

I don't understand this statement - I would argue the exact opposite
is true in all the day-to-day usage of git that I have come across.

When I have an untracked file in my working tree, it's normally
because I've created a new script, a new java class, or something like
that. It's normally part of what I'm working on - eg I added a file,
and another might well be referencing it.

If I have "untracked cruft" that doesn't logically belong in my
working code / shouldn't be checked in / doesn't affect the
compilability of my project, then I would typically consider this a
bug in my workflow - either there's a pattern missing in my
".gitignore", or I accidentally redirected some command output into a
temp file in my working folder instead of a more sensible place. I
understand a large segment of the *test suite* relies on git's
"untracked files don't get in the way" behavior, but I don't think
that's representative of real-world usage.

Obviously this is a "personal" thing, but it seems to me that git
would benefit from supporting this worldview - *allowing* stash to
default to -u, and similarly allowing "git commit -a" to refer to
untracked files also, which it does not today.

Anyway, sorry, I'm reacting to the perspective and statement about the
role of untracked files in git working trees here, rather than
anything specific about stashes, I guess this is off-topic.

> "stash pop"
> was the primary way to go back to where you were before the
> interruption, and such going back is expected to be done after the
> crisis is over when you can be more relaxed, and was expected to be
> done _after_ you "reset --hard" and/or "git switch" out of the
> crisis mode.

Yep, makes sense - except this perspective is at odds of course with
the stashes being a stack, and with the idea of attempting to export
stashes at all. I understand these are the *primary* usecases, and
those that need to be best-served, absolutely.

> And the natural way to recover from "eh, I moved back
> to a different commit---I wanted to go to the commit I was when I
> saved the stash" was "reset --hard" that would not lose anything new
> (and "stash branch" was later added to make the last one easier to
> do), for another example.

This explains why stash was implemented to behave the way it does,
sure - it made narrow assumptions about the likely context in which a
stash would be popped; my concern with that is that it does not
enforce those assumptions, so its actual usage in the wild might well
differ significantly from those assumptions, and *when* it does, it
can leave your working tree in a messed up state (a mix of staged and
unstaged changes that had nothing to do with the stash, some staged or
unstaged changes successfully "popped" and some stash-popped conflicts
that you cannot easily "undo" without carefully picking apart the
stash-popped bits from the previously present bits).

>
> Users are better off doing any large scale "I made a mess in the
> working tree with mixed changes, and I want to take time to separate
> them out" on separate (possibly temporary) branches, instead of
> using "stash save" + "stash pop".

I agree with this, especially given that stash pop doesn't give you
any opportunity to "partially pop".

In the usecase that I describe (where you "stash pop" into a working
tree that *already* has unrelated staged or unstaged changes), the
intention is not to use stash to help resolve a mess you made - it's
just to "bring back" that stuff you stashed earlier. Stash pop isn't
being used to fix anything - it is accidentally *creating* a problem
if/when the stash pop encounters conflicts. It is this problem that I
believe could be solved with an --abort/--continue model for stash
conflicts.

> Any change that would make it
> more cumbersome for the primary intended purpose of "quick save"
> would be very much unwelcome, I would have to say.

That makes complete sense, I agree!

I believe introducing --abort/--continue on *conflictive*
stash-popping would absolutely not make those intended uses any more
cumbersome - if anything, it would make them much cleaner/smoother
with a simpler, more consistent and safer "exit" from the conflict in
either direction: if the conflict is resolved, "stash --continue" will
drop the stash without risk of dropping anything else you had in the
stash. If you reconsider, "stash --abort" gets you back to where you
were, without having to think about how safe or dangerous the
operation might be.

It might well not be worthwhile, because stash is so hard to use at
the moment that the standing advice I see around is "don't do it -
you're better off learning how to manage branches and commits in a
sufficiently agile fashion that you never worry about stash, and just
create & drop local branches instead". If stash is rarely used, or
only used by people who already know exactly when it works well and
avoid using it in situations where it causes problems, then it might
not be worth investing in. However, if stash is to graduate to a
simple to use and reasonably safe facility, then I would expect this
to make sense from a functional perspective.

On the other hand, I understand that each --abort/--continue
conflict-management flow probably requires/implies another
special/dedicated "working tree state" that tools (eg git-prompt), git
commands, third-party git libraries, and GUI clients need to know
about, so I'm guessing the overhead on something like this is
prohibitive? When was the last time something like this was done?

Thanks,
Tao
