Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A595C61DA4
	for <git@archiver.kernel.org>; Wed, 22 Feb 2023 08:24:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbjBVIYD (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Feb 2023 03:24:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbjBVIYC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Feb 2023 03:24:02 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 351C212049
        for <git@vger.kernel.org>; Wed, 22 Feb 2023 00:24:01 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id t14so4211412ljd.5
        for <git@vger.kernel.org>; Wed, 22 Feb 2023 00:24:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=e9mu47qa3aBg5D9UZvZk/rZBncFPhAarDDZHmXv8cJM=;
        b=UTplJni9vGxY7XZCjMBWuI8Va06118mvutxp9auC5RPBk8lCXDbjvJ2Vd5eWDjW/SZ
         zc7ze9Zr3UVMdEDa4Jc5m0ZnbIhFreBC2bOYAItt6Ugrphf3gSjB2FOtjZXykMWQ1TbE
         fhHKXYrpXTIGrr8pjTTGhBB/E7k8+XyyM41fsRI+5lh2pvnnNU7jM0bYj+n+1oeD44Ur
         XOGBoPPZTdfMThlgXRNgoYPGfJ+/pka8ELGxdsTNNDRD4sYQaJ6xqGe+KH2NwhXn2T7j
         lyK+qldcduAOwyXYnsp1M/gXDK+dI7lIkav505oBVC+F8/xySNmTcCtcC6JAgAtv/c52
         iGGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e9mu47qa3aBg5D9UZvZk/rZBncFPhAarDDZHmXv8cJM=;
        b=Yja7CvRrO6YaEwllWdSCmk6is1euFx/7cpIb+hipl/K7Z4HUffIBhBKPaj6QLF1eEo
         vHYQegrC5/yZi/MPeeMck7H0xegWnF1CkojwW9DH1J27uK1sV7LYuhsVtTh2jL8t4yoi
         QRFd8DCBx1xgdWksUfftRYZWGPo/AwMl0S2Qky3nsueK4GaVHrGr+29pagtWpoQuuyG1
         vyy+Ew/IaTwcN+rvQ4xpT0a/8f2WVG/6THWWiZ6biYRt0WRQqEB+L5GytNpI90llJeUM
         NRSO7KcC258LpPoVzSgg3A1+/FtkU7REU2lNktROmpUAYiBWohJ2V5+uPulj3J2obPt6
         g9+Q==
X-Gm-Message-State: AO0yUKVUrdc+fEajlGOc3FvOtgK/VqDprfndRdkBuuHgIBguyvjT4jTv
        xzT/HNaqfaPRZEA0Nb63LkjTlpThRG+qpPRoLg4fpFQMtYk=
X-Google-Smtp-Source: AK7set+nC1cotUXxijlTDNVvjDD6MWlpdkt96v207qtm9IdZ4m5s2mPLYUtXysdHGXyI3z1wXx5lsqIh/iPvQycYDlo=
X-Received: by 2002:a2e:b4b6:0:b0:293:4fd1:cbd1 with SMTP id
 q22-20020a2eb4b6000000b002934fd1cbd1mr2500478ljm.6.1677054239122; Wed, 22 Feb
 2023 00:23:59 -0800 (PST)
MIME-Version: 1.0
References: <CAJoAoZ=Cig_kLocxKGax31sU7Xe4==BGzC__Bg2_pr7krNq6MA@mail.gmail.com>
 <CABPp-BE6EA+vXLXJtn8CHO9pHJgLH_uh7_t7AYBRN2gAAA5C+Q@mail.gmail.com> <CAJoAoZm+TkCL0Jpg_qFgKottxbtiG2QOiY0qGrz3-uQy+=waPg@mail.gmail.com>
In-Reply-To: <CAJoAoZm+TkCL0Jpg_qFgKottxbtiG2QOiY0qGrz3-uQy+=waPg@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 22 Feb 2023 00:23:46 -0800
Message-ID: <CABPp-BFohpW6y1piVDYPbQx_vL1jbD0PZjkiAHcj_p-EiDoJXg@mail.gmail.com>
Subject: Re: Proposal/Discussion: Turning parts of Git into libraries
To:     Emily Shaffer <nasamuffin@google.com>
Cc:     Git List <git@vger.kernel.org>, Jonathan Nieder <jrn@google.com>,
        Jose Lopes <jabolopes@google.com>,
        Aleksandr Mikhailov <avmikhailov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 21, 2023 at 2:07 PM Emily Shaffer <nasamuffin@google.com> wrote:
>
> On Fri, Feb 17, 2023 at 8:05 PM Elijah Newren <newren@gmail.com> wrote:
> >
> > On Fri, Feb 17, 2023 at 1:45 PM Emily Shaffer <nasamuffin@google.com> wrote:
[...]
> > > So what's next? Naturally, I'm looking forward to a spirited
> > > discussion about this topic - I'd like to know which concerns haven't
> > > been addressed and figure out whether we can find a way around them,
> > > and generally build awareness of this effort with the community.
> >
> > I'm curious whether clarifying scope/layering and cleaning up
> > interfaces might mean you'd be interested in things like:
> >   * https://github.com/newren/git/commits/header-cleanups (which was
> > still WIP; I paused working on it because I figured people would see
> > it as big "cleanup" patches with no practical benefit)
> >   * https://github.com/gitgitgadget/git/pull/1149 (which has been
> > ready to submit for a _long_ time, but I just haven't yet)
> > or if these two things are orthogonal to what you have in mind.
>
> Extremely yes. :) Even "small" stuff like the need for header cleanups
> have already come up for Glen and Calvin working on config and strbuf.

Ok, I'll clean up what I've got and submit.

[...]
> > > Much, much later on, I'm expecting us to form a plan around allowing
> > > "plugins" - that is, replacing library functionality we use today with
> > > an alternative library, such as an object store relying on a
> > > distributed file store like S3. Making that work well will also likely
> > > involve us coming up with a solution for dependency injection, and to
> > > begin using vtables for some libraries. I'm hoping that we can figure
> > > out a way to do that that won't make the Git source ugly. Around this
> > > time, I think it will make sense to buy into unit tests even more and
> > > start using an approach like mocking to test various edge cases. And
> > > at some point, it's likely that we'll want to make the interfaces to
> > > various Git libraries consistent with each other, which would involve
> > > some large-scale but hopefully-mechanical refactors.
> >
> > Would these plugins resemble the pluggable merge backends that was
> > added to builtin/merge.c?  Would it replace that mechanism with a
> > different one?  Would it be more like the refs backends?
>
> I suspect that it's likely to be most similar to the refs backend
> replacement, although I investigated it only a little bit just now.
>
> The pluggable merge backends are an interesting thought - right now
> all those alternatives are built in and we decide based on config,
> right?

While we have several built in merge backends (recursive, resolve,
ort, octopus, ours, subtree), it is not limited to built-in
alternatives.  If someone creates a "git-merge-$STRATEGY" executable
and runs `git merge -s $STRATEGY` then builtin/merge.c will fork their
subcommand to try to resolve the merge.  (Users can even specify
something like `-s $STRATEGY1 -s $STRATEGY2` to have git find the best
strategy to use.)  The subcommand is then expected to update the
working tree and index and return an exit status signalling whether
the merge was clean.  It's very much built around assuming you
currently have a branch checked out and you want to merge into that
branch.

We do not know how widely used this feature is, but it's kept us from
fixing some API mistakes.  For example, a user strategy can return an
exit status of 2 signalling that it cannot even consider the merge in
question (e.g. most strategies cannot handle octopus merges).
However, the merge strategies are allowed to muck with the working
directory and index and leave them in a totally messed up state prior
to returning the "2" signalling that the given merge strategy is
inappropriate and another should be selected instead.  That means
builtin/merge.c is required after calling any given strategy and if it
does not succeed, go and "clean everything up".
