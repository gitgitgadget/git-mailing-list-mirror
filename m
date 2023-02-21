Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9566C636D7
	for <git@archiver.kernel.org>; Tue, 21 Feb 2023 15:01:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234252AbjBUPBy (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Feb 2023 10:01:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234601AbjBUPBr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Feb 2023 10:01:47 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04C3983CF
        for <git@vger.kernel.org>; Tue, 21 Feb 2023 07:01:45 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id g1so18113546edz.7
        for <git@vger.kernel.org>; Tue, 21 Feb 2023 07:01:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=klerks.biz; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1oC0hBk2AAuXW4JN9mhEh74EM8qv91fwhUPvTWjflgE=;
        b=XTtZeKSMSTROy554pSztVF+yPH3AS6K2AyQ7/cy7+r1fVZWtlh+Uq4x3TdgeQXCbc/
         +9wK2WircNpuVpDusNkv8IPGfqKNOdVAhnrrhevyS8NG8uSF4OvgofcVYh/mN+nLKzHX
         9KW7H3UPJo8KvavA4LtYvTYYRNrt9ha7B4da8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1oC0hBk2AAuXW4JN9mhEh74EM8qv91fwhUPvTWjflgE=;
        b=NTdEWJKwF4M3zfeGYYsq8k/3C3oEo3MVUQyYYpm/Gf77MEhshuXQARxqUzCVVForhS
         UUZQ/TUN38agT2UUm7sLbq+PUnK9mK6VrpGm0UqiW6k3sVwOil5ru4bLYpL2O34X1rzj
         E+kih3I1qTzuGxh05XoGKPdnoqOdG/6hbnd2sGp7ZuJVkvhBeWYCIhpfZRh4G8/ikx5g
         dH71IahFivcXcE1eOG+Aitjc4cFZFHyl3n3yvmKhjRHnNHzGx2OvjTOZGCIPj+dck7lh
         zMZkDapqlFuW5/hw46Ifj335HlwsQyeDTHxI4Uth16FvHEXCnsKjRyJBlim/VVSApGYt
         zxPw==
X-Gm-Message-State: AO0yUKU3xjStxkSRCguQBl5bIMnqfu5VDvI94Q8OCh6Cm1No2iXg0sWX
        3yFXI+xwXIfTX7opeZFcsPelFQN3MeNEiGe9QByzVA==
X-Google-Smtp-Source: AK7set8sUtEBM83ko28PN9wcyje6KjlEi6u6RZYvtrR+xCP+CtXIsHvSOF/j1QQ8P86cY0VrzgEtQmijlns8Uqyc64Y=
X-Received: by 2002:a17:906:f243:b0:8e1:7bb8:bf8d with SMTP id
 gy3-20020a170906f24300b008e17bb8bf8dmr784757ejb.0.1676991703274; Tue, 21 Feb
 2023 07:01:43 -0800 (PST)
MIME-Version: 1.0
References: <pull.1474.git.1675614276549.gitgitgadget@gmail.com>
 <CAMMLpeTPEoKVTbfc17w+Y9qn7jOGmQi_Ux0Y3sFW5QTgGWJ=SA@mail.gmail.com>
 <CAPMMpogFAR6cvcR8T5fx+AoytAJ7TsPpSeOjHNzW4Gmkuq7FLQ@mail.gmail.com>
 <CAMMLpeTQ1RpsvwRdZ0G3wdvH1+LXE5tw=7Cs6Q+HxMcRU0qj5Q@mail.gmail.com>
 <CABPp-BFxGYQ_JTC5c4_S_gOK3GxWKuZ=KfvycpkBjPGyKzCJ+g@mail.gmail.com>
 <CAPMMpojCYAwwu6_BE+myFaUy6fLqVSWAyiRWr_dGAmMqqUF12Q@mail.gmail.com> <CABPp-BEtXf9ja7Ec1fZ=BZwFDa+50zSAhtm3nN_=k+Nc2c=RXw@mail.gmail.com>
In-Reply-To: <CABPp-BEtXf9ja7Ec1fZ=BZwFDa+50zSAhtm3nN_=k+Nc2c=RXw@mail.gmail.com>
From:   Tao Klerks <tao@klerks.biz>
Date:   Tue, 21 Feb 2023 16:01:31 +0100
Message-ID: <CAPMMpohrEjZQwRbRAZfPfArNxEBDBzq8yJfsOAerhQ0qr6sWjQ@mail.gmail.com>
Subject: Re: [PATCH] pull: conflict hint pull.rebase suggestion should offer
 "merges" vs "true"
To:     Elijah Newren <newren@gmail.com>
Cc:     Alex Henrie <alexhenrie24@gmail.com>,
        Tao Klerks via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 20, 2023 at 6:21 PM Elijah Newren <newren@gmail.com> wrote:
>
>
> When we teach new folks about git, and get to rebasing, there is a
> simple and easy rule to tell users: don't mix merges and rebases.
> (There's a minor exception there in that merges with the upstream
> branch are fine and rebasing can let you get rid of those otherwise
> ugly-and-frequent back-merges that users sometimes make.)

Who is "we" here? When I search for the exact text "don't mix merges
and rebases" in google, the only hit I get is this very email thread.

Without the quotes, I get a similar-looking page title, but I don't
understand whether the author's thesis is the same thing you're
getting at - I don't think so:
https://dev.to/jessekphillips/rebase-and-merge-don-t-mix-4aj

>
> Obviously, your users are ignoring that advice, and feeling pain.

"Ignoring" is a strong (and in my opinion, strange) term to use here.
They are *not seeing* that advice, and I think you can reasonably
assume that many, or most, users will not see almost any of the advice
you can possibly offer. As software designers I believe we all strive
to set things up so you need to learn as little as possible to use
something usefully, and safely.

> To
> be fair, the "RECOVERING FROM UPSTREAM REBASE" section of the rebase
> manual isn't that prominent, and perhaps your users didn't have more
> seasoned developers sharing this don't-mix-merges-and-rebases advice
> with them.  (It seemed to me to be shared pretty widely and commonly,
> but perhaps we are relying on education from others too much and
> education is never uniform if not coming from the tool itself.)

My equivalent of this is "never rebase a shared branch unless you and
your team know what you're doing". For most users I interact with,
that translates to "don't use rebase at all unless you have a git
veteran standing at your shoulder / on a screenshare with you".

This advice is, again, not necessarily something that users even *see*
before they start needing to use git. Maybe they should? Should we add
a child lock on the executable, "this is likely to do very surprising
things, please sign here that you have studied graph theory and really
understand how this stuff works before you get to use it"?

> I
> understand you want to make it easier for users to avoid accidentally
> getting into this state.  That's a valid concern and desire.  I think
> we should improve the situation.
>
> However, on what timetable and at what cost to others?
>
> You're advocating we start advertising an alternate option, one which
> has some caveats and gotchas that are not going to be so easy to
> explain to users -- neither to new users, nor to folks who have been
> using Git for years.

What I'm trying to understand is whether or how these caveats and
gotchas are *any worse than the status quo / than the current
"pull.rebase=true" behavior*. I haven't understood any clear concrete
ways in which this is true yet:
* "pull.rebase=merges" throws away your merge conflict resolutions -
so does "pull.rebase=merges", right??
* You might find it surprising that a same-merge-point branch gets
rebased with the default "-rno-rebase-cousins" behavior... but
"pull.rebase=true" will also do that!
* You might be disappointed at the fact that an interactive
--rebase-merges rebase fills your screen with stuff - but a
"flattening" rebase does that too.
* You might be disappointed at the fact that --rebase-merges takes a
long time when fast-forwarding over the merge of a large amount of
history - but a "flattening" rebase does that too.

I'm not advocating for experienced users being by any means required
to use this functionality in its less-than-perfect state - but I *am*
arguing that foisting that less-than-ideal state on people who
copy-paste a suggested command from a pull conflict hint is far better
than allowing them to accidentally "flatten the history" of
upstream-branch commits.

> We could just bite the bullet and start
> explaining, but these caveats and gotchas are completely incidental to
> the implementation, and are in no-wise fundamental to the desired
> operation.

We already *do* explain, right? We've already retired --preserve-merges!

> I believe that switching to this new option is going to
> generate an awful lot of questions and surprises by users.  It seems
> to me to be a really sad state of affairs to be recommending an option
> with known defects when (IMO) the solution is known.  Can't we fix it
> first, then recommend it?

I guess maybe I'm misunderstanding your concern:
* My main aim is to stop users shooting themselves in the foot
* If making --preserve-merges the overall default for "git rebase" is
the only or best way as Alex has proposed, great, let's do that. I
personally would like to have the "use --rebase-merges by default when
using "git rebase" option that Alex is proposing even if we don't do
this, but even that is secondary to me compared with the "stop
offering a rebase behavior that will cause users to duplicate upstream
history unknowingly, at a blocking prompt where you're forcing them to
pick *something*" objective that kicked this off.
* If there is another, better way of removing this foot-gun, I'm happy
to explore another direction

Do you have a suggestion? Or would you advocate for *eventually*
replacing the foot-gun with a more childsafe tool, when that tool is
as sophisticated as we think it should eventually become?

>
> Granted, this is a trade-off.  You have users experiencing real pain.
> You want a solution now.  I want to not recommend features with known
> implementation shortcomings and known solutions, until those solutions
> are implemented, and I know that will take a while.  What to do here
> is a judgement call, and I was merely giving my opinion on the call to
> make.  Other folks on the list might see things differently than I do.

I think there are many options, and I'd love to understand which one
you advocate for in the immediate term, with respect to the specific
issue I noted:

* Replace the pull conflict hint only, as I initially proposed
* Engage on an "asap" replacement of default "git rebase" behavior to
"--rebase-merges" by default
* Change the pull conflict hint in some other way (that removes the
copy-paste footgun)
* Do nothing, accepting that we will revise all this in some future,
and it's been like this for so long, what's wrong with a few more
people hitting the classic issues?
* Some other proposal for short-term relief of this very specific problem?

I should note here, that for "my" users, setting the new config option
Alex proposes in "rebase: add a config option for --rebase-merges" by
default, in all their repos, is sufficient for me to ensure people
will stop hurting themselves, and that's something I can easily do
if/when the patch is accepted - but the main reason I hang out here is
to try to advocate for users *like* mine, people who use git because
it's the best or only game in town, rather than people like me who
think it's so friggin awesome and are fascinated to learn all its
arcane mysteries. In my environment, that's easily a 10:1 ratio. I
suspect that's a reasonable reflection on the universe of git users
generally.
