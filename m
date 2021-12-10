Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E407C433F5
	for <git@archiver.kernel.org>; Fri, 10 Dec 2021 22:02:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344577AbhLJWGW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Dec 2021 17:06:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239516AbhLJWGW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Dec 2021 17:06:22 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90F98C061746
        for <git@vger.kernel.org>; Fri, 10 Dec 2021 14:02:46 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id t5so33746543edd.0
        for <git@vger.kernel.org>; Fri, 10 Dec 2021 14:02:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=moTSyN49eoG9rYs8nNFo/b+PvZgYcqYHpYhRlicHGnc=;
        b=aqeF/NMUb7PXGuVQK7CzSknDx8JXhgyXkuYMAAyFA+RdjQm8pRjNP9XKqHuYKZJETb
         qL7911YMqs0/yy7F8POTbYyrNIEJt8AGo2nlDnkbwNcXFTIIkgBSkKM8B5sN2pLpMDke
         3vvWjiMH8AkYpdTDiGijR16ln85SnTSaeO+jQ0mlky4dw7uYvXe0M/R4E+9bOVBpTCX0
         hGoF/N8OXq5iYqNgkRWugIooPsVZHMWYL6+GkuY/BqoWAC0teW9zk4/SWVfGD4d9pcmO
         p+cUN+T14ZUDDDkmMqcxPqLf1v0AYQZtS0KAsNPyFQbQx4VuAC8c3Prf7SbT6/2izdig
         CGog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=moTSyN49eoG9rYs8nNFo/b+PvZgYcqYHpYhRlicHGnc=;
        b=v8x6oDm+nX+hnCWqvYts0HXns8TBHMaGDXOp0+9MmM4l8zMgzYr7HpdZjfhBElDJaL
         2Wb6pSvf1a9BX2lRpQWmd8uUt8Xxwg8xG8tSzZ4daOD+fLWPZCeBLpT75y4lAr2NhkL0
         NKIWw2BZF4d6TYUyDgVWNIuGNSvX1IOYfdPFGwcZkzGsLsortBbEt10UNQW/syS00XkC
         Ivdt0pkDIyVbH8EsF5Foh6lFfkNbzrc/F3XDJm029IgY83GHWG4jvRv13io41eco5plI
         t8HeqSDff3ZNvWTDqOSL+JNf/XTDOsAYTK1rNlfzioBFCsl4F+HdoQCw0yNf94sEwzPL
         sBOw==
X-Gm-Message-State: AOAM530pPGTRwNqg/ats7liC6DAJfq7f273WTM7B4bi2O7eLHfVWPn6/
        XxjyhF+p2I7tdXquAAwTNASkltteyLEjs7+UcD8=
X-Google-Smtp-Source: ABdhPJwZ5mPmVOUZAJZfdGxMEl4MeVECzOFqA/0hL308XWDdtY2xMO0pLCO/RaOvtc7OEVQ+65ht2IusgWPtQ6dtFmU=
X-Received: by 2002:a05:6402:5cb:: with SMTP id n11mr42685546edx.279.1639173765013;
 Fri, 10 Dec 2021 14:02:45 -0800 (PST)
MIME-Version: 1.0
References: <pull.1084.git.1637666927224.gitgitgadget@gmail.com>
 <pull.1084.v2.git.1639037637231.gitgitgadget@gmail.com> <CABPp-BGdCizEGcwPS+0VB_vvYLpGCWKLqx-nbZtJ16QkVxzbGQ@mail.gmail.com>
 <xmqqee6km8ez.fsf@gitster.g>
In-Reply-To: <xmqqee6km8ez.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 10 Dec 2021 14:02:33 -0800
Message-ID: <CABPp-BEU2pbfa6CSSMe9Dw7YQCaw+uU1rNMJn1YRraHKJ5D_8g@mail.gmail.com>
Subject: Re: [PATCH v2] fast-export: fix surprising behavior with --first-parent
To:     Junio C Hamano <gitster@pobox.com>
Cc:     William Sprent via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        William Sprent <williams@unity3d.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 10, 2021 at 1:55 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> > ...  Here's what I think are the relevant points
> > (and yeah, it's lengthy):
> >
> >
> > The revision traversal machinery typically processes and returns all
> > children before any parent.  fast-export needs to operate in the
> > reverse fashion, handling parents before any of their children in
> > order to build up the history starting from the root commit(s).  This
> > would be a clear case where we could just use the revision traversal
> > machinery's "reverse" option to achieve this desired affect.
> >
> > However, this wasn't what the code did.  It added its own array for
> > queuing.  The obvious hand-rolled solution would be to just push all
> > the commits into the array and then traverse afterwards, but it didn't
> > quite do that either.  It instead attempted to process anything it
> > could as soon as it could, and once it could, check whether it could
> > process anything that had been queued.  As far as I can tell, this was
> > an effort to save a little memory in the case of multiple root commits
> > since it could process some commits before queueing all of them.  This
> > involved some helper functions named has_unshown_parent() and
> > handle_tail().  For typical invocations of fast-export, this
> > alternative essentially amounted to a hand-rolled method of reversing
> > the commits -- it was a bunch of work to duplicate the revision
> > traversal machinery's "reverse" option.
> >
> > This hand-rolled reversing mechanism is actually somewhat difficult to
> > reason about.  It takes some time to figure out how it ensures in
> > normal cases that it will actually process all traversed commits
> > (rather than just dropping some and not printing anything for them).
> >
> > And it turns out there are some cases where the code does drop commits
> > without handling them, and not even printing an error or warning for
> > the user.  Due to the has_unshown_parent() checks, some commits could
> > be left in the array at the end of the "while...get_revision()" loop
> > which would be unprocessed.  This could be triggered for example with
> >     git fast-export main -- --first-parent
> > or non-sensical traversal rules such as
> >     git fast-export main -- --grep=Merge --invert-grep
> >
> > While most traversals that don't include all parents should likely
> > trigger errors in fast-export (or at least require being used in
> > combination with --reference-excluded-parents), the --first-parent
> > traversal is at least reasonable and it'd be nice if it didn't just
> > drop commits.  It'd also be nice to have a simpler "reverse traversal"
> > mechanism.  Use the "reverse" option of the revision traversal
> > machinery to achieve both.
>
> The above is a very helpful and understandable explanation of what
> is going on.  I am a bit puzzled by the very last part, though. By
> "It'd also be nice to have a simpler 'reverse traversal' mechanism",
> do you mean that the end users have need to control the direction
> the traversal goes (in other words, they use "git fast-export" for
> some thing, and "git fast-export --reverse" to achieve some other
> things)?  Or do you just mean that we need to do a reverse traversal
> but that is already available in the revision traversal machinery,
> and not using it and rolling our own does not make sense?

Sorry, yeah, I meant the latter.  I do not think end users should have
control of the direction.  Perhaps if that was reworded to "...It'd
also be nice for future readers of the code to have a simpler..." it'd
be clearer?

> > Even for the non-sensical traversal flags like the --grep one above,
> > this would be an improvement.  For example, in that case, the code
> > previously would have silently truncated history to only those commits
> > that do not have an ancestor containing "Merge" in their commit
> > message.  After this code change, that case would would include all
>
> "would would" -> "would"

Good catch.

> > commits without "Merge" in their commit message -- but any commit that
> > previously had a "Merge"-mentioning parent would lose that parent
> > (likely resulting in many new root commits).  While the new behavior
> > is still odd, it is at least understandable given that
> > --reference-excluded-parents is not the default.
>
> Nicely written.

Thanks.  :-)
