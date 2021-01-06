Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E4BEC433DB
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 20:02:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B79B223138
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 20:02:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726494AbhAFUCK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Jan 2021 15:02:10 -0500
Received: from mail-ed1-f49.google.com ([209.85.208.49]:42957 "EHLO
        mail-ed1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbhAFUCJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jan 2021 15:02:09 -0500
Received: by mail-ed1-f49.google.com with SMTP id g24so5498640edw.9
        for <git@vger.kernel.org>; Wed, 06 Jan 2021 12:01:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TuuO8I+QRTjcYBeEh7O7FUsfjg8nmmaU8lW+gwmG7S0=;
        b=VhG61O2vxY4069C4xllIx2DTJqG7qCdxCR75f3/7/qfflu0x8kVC5cJAZYJpbXsVAO
         r91j4ZunD2/J30nuRQzCPj9vWWCz0acRtRkhbN5fy7ClPe5bB9bYt6TCkRy25iUnpwBj
         ynispxzt8I32q6vy8vmlzotGqqNK8ZZSxiHrh13mre3N11PnJdgg38O1zotGrqymYp7F
         aM+cwbb+NKH+fUG6/is9PlIHFVcSFGzS0KFr0EXN7ietjtBHPVZ/7hwth9ZOwzpRifXY
         2UkOOgi4Q9E42AeazhVkqtWah26OFT5z8BHwDPuBC1uDJRGQYMhq25PbKPhF5YpJn6Zm
         DMTA==
X-Gm-Message-State: AOAM531+u7dJLiOnyJgz9rLzmRQdEg8WVfGW7Lh2T5pOuEjN4iTBpNVo
        iUgUqRd18z94vM52QC1YhzA4BA6w4fKpDpFsF0g=
X-Google-Smtp-Source: ABdhPJwOmQNzvx89t/JvvKEfNdwkqeJ5UgRcrd0hJM2cNeW10mhhs6hjQTqWw/K21hKfUvdJOnUILk49Aki+hREkHEs=
X-Received: by 2002:a50:9310:: with SMTP id m16mr5172087eda.94.1609963287517;
 Wed, 06 Jan 2021 12:01:27 -0800 (PST)
MIME-Version: 1.0
References: <jwvwnwqrqwd.fsf-monnier+gmane.comp.version-control.git@gnu.org> <CABPp-BE1QXA0ohB9D-tqKpzDTok0BMsGQjotmcqMxfs9AL5noA@mail.gmail.com>
In-Reply-To: <CABPp-BE1QXA0ohB9D-tqKpzDTok0BMsGQjotmcqMxfs9AL5noA@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 6 Jan 2021 15:01:16 -0500
Message-ID: <CAPig+cRzXd+zd+xVisaW+HToSaGzAE28acGmxwRxNU4bczHXbw@mail.gmail.com>
Subject: Re: New orphan worktree?
To:     Elijah Newren <newren@gmail.com>
Cc:     Stefan Monnier <monnier@iro.umontreal.ca>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 6, 2021 at 2:41 PM Elijah Newren <newren@gmail.com> wrote:
> On Wed, Jan 6, 2021 at 8:21 AM Stefan Monnier <monnier@iro.umontreal.ca> wrote:
> > I wish I could just do something like:
> >
> >     git worktree add --orphan foo newbranch
>
> Out of curiosity, why are you frequently creating orphan branches?
> Such an option would drop the number of commands you need to run from
> four down to two, but I'm surprised this would come up enough to
> matter enough to do much more than create a personal git alias for it.

I'm also curious about a use-case in which orphaned branches are used
so frequently.

Nevertheless, I'm not at all opposed to seeing an --orphan option
added to `git worktree add`. In fact, --orphan has been on the
radar[1] from the very beginning. Although the original implementation
of `git worktree add` mimicked a small set of options from
git-checkout, the plan all along was to mimic additional options from
git-checkout as demand for them arose, and several such options have
already been added.

> Yeah, checkout --orphan is broken.  You should use switch --orphan,
> which doesn't require the extra 'git rm -rf .' step.  That bit is
> definitely cumbersome.

Yep, when/if --orphan is added to `git worktree add`, it should mimic
the behavior of --orphan in git-switch rather than git-checkout.

Patches are welcome.

[1]: https://lore.kernel.org/git/CAPig+cQiJnrnz4jsGdT0=8kYogWfsNkjq5WQCGC4Zk6res5mtg@mail.gmail.com/
