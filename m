Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F682C636CC
	for <git@archiver.kernel.org>; Sat, 18 Feb 2023 04:15:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbjBREFT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Feb 2023 23:05:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjBREFR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Feb 2023 23:05:17 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D159627CF
        for <git@vger.kernel.org>; Fri, 17 Feb 2023 20:05:14 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id t4so3162618lfr.7
        for <git@vger.kernel.org>; Fri, 17 Feb 2023 20:05:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=odeSSvB881MYwUmcREG0J27yJ7THsZEhmyBmgtaS92U=;
        b=BXPI+0w8j5Q7fM+ozXm6mMju9WtdPmWu9wy/+5dKw2tS9aoV4bJ3cCXXIxvhAWWyB6
         pPR942DAdLjmWznVCxhOkndJ6rJjm/ChOouwkYjr0Q8MoIUq5FWUh7uYbjZm1L/688TC
         98cZJf5mbtT4RXFs8bOG/etH0RVAPOLpICylbPklJTX7cHmb6eGxqTiQ73ptR/+qQnSt
         JaVI6h/2frbJQ9AtsiVG18rtRCmYKJWxOaFMOywp7WT2aWUv312U7FX0lAlgrQQYZDoW
         DnSTBy9EzpXNVZ6iig5LoTYdEco42RrjqgmlOOIL5q3if9yWt24VzXNULJUNzvE4n2OO
         sXmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=odeSSvB881MYwUmcREG0J27yJ7THsZEhmyBmgtaS92U=;
        b=tre8jFIfRP3JXx+OdYrZEZTVD3/kZlywH7N3qFT3eLboRZ++C/BLptIYimy7kHfCut
         8fCggjxP82J9aTV1LFkgOp2oqaBpU2+R1Qf9uwGOAFl7pvywA8Ne/rhEqQMT51VW0BVH
         cS+WNPcXuR9pmaRBg9Q7m9UsXS+uXbrpf4CctAaP19rOzCkpj2WQYi6Sd0EC04HhpP2W
         cETVhmdsu0gvuL/zGf7As7yPxPlm4q5A5ihH5vdWAKYzbzXppEK5PFnv6/t1+cS5uyid
         Bvrwy7UXdvcfC5g6dzNwsb1lDhVIgThkJcd35PkFpu4Spjf9HPO5E48/WxcbjXJnfewK
         DjDA==
X-Gm-Message-State: AO0yUKVZWEOlLNoKDmwvkQTTCx+TdKnTxQ04a4KbOupMVKgmdIeKhw4M
        Q0855Ko5xD4av4c50TfE4Vk0Lga6wQlLz/0CiSSJWTavo20=
X-Google-Smtp-Source: AK7set/MRJew/m2tsX7NuQwbG9SImA4OxtvMTVzzsjgn/ZghJkQSc/LCwR6bZ3OrQjW2zBjvDxV/QYDvgCRZyDX/fD0=
X-Received: by 2002:ac2:4c10:0:b0:4db:1326:79b4 with SMTP id
 t16-20020ac24c10000000b004db132679b4mr1000807lfq.2.1676693112547; Fri, 17 Feb
 2023 20:05:12 -0800 (PST)
MIME-Version: 1.0
References: <CAJoAoZ=Cig_kLocxKGax31sU7Xe4==BGzC__Bg2_pr7krNq6MA@mail.gmail.com>
In-Reply-To: <CAJoAoZ=Cig_kLocxKGax31sU7Xe4==BGzC__Bg2_pr7krNq6MA@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 17 Feb 2023 20:05:00 -0800
Message-ID: <CABPp-BE6EA+vXLXJtn8CHO9pHJgLH_uh7_t7AYBRN2gAAA5C+Q@mail.gmail.com>
Subject: Re: Proposal/Discussion: Turning parts of Git into libraries
To:     Emily Shaffer <nasamuffin@google.com>
Cc:     Git List <git@vger.kernel.org>, Jonathan Nieder <jrn@google.com>,
        Jose Lopes <jabolopes@google.com>,
        Aleksandr Mikhailov <avmikhailov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 17, 2023 at 1:45 PM Emily Shaffer <nasamuffin@google.com> wrote:
>
[...]
> This turned out pretty long-winded, so a quick summary before I dive in:
>
> - We want to compile parts of Git as independent libraries
> - We want to do it by making incremental code quality improvements to Git
> - Let's avoid promising stability of the interfaces of those libraries
> - We think it'll let Git do cool stuff like unit tests and allowing
> purpose-built plugins
> - Hopefully by example we can convince the rest of the project to join
> in the effort

Seems like quite reasonable high-level goals.

[...]
> The good news is that for practical near-term purposes, "libification"
> mostly means cleanups to the Git codebase, and continuing code health
> work that the project has already cared about doing:
>
> - Removing references to global variables and instead piping them
> through arguments
> - Finding and fixing memory leaks, especially in widely-used low-level code

Does removing memory leaks also mean converting UNLEAK to free()?
Thinking of things in a library context probably pushes us in that
direction (though, alternatively, it might just highlight the question
of what is considered "low-level" instead).

> - Reducing or removing `die()` invocations in low-level code, and
> instead reporting errors back to callers in a consistent way

What delinates "low-level" code?  (A "we don't know yet but we'll
start with obvious places and plan to have good discussions on the
appropriate boundary in the future as we submit patches" is a fine
answer, I'm just curious if you already have a rough idea of where you
intend that boundary to lie.)

> - Clarifying the scope and layering of existing modules, for example
> by moving single-use helpers from the shared module's scope into the
> single user's scope
> - Making module interfaces more consistent and easier to understand,
> including moving "private" functions out of headers and into source
> files and improving in-header documentation

I think these are very positive directions.  I like the fact that your
initial plan benefits all of us, whether or not libification is
ultimately achieved.

[...]
> So what's next? Naturally, I'm looking forward to a spirited
> discussion about this topic - I'd like to know which concerns haven't
> been addressed and figure out whether we can find a way around them,
> and generally build awareness of this effort with the community.

I'm curious whether clarifying scope/layering and cleaning up
interfaces might mean you'd be interested in things like:
  * https://github.com/newren/git/commits/header-cleanups (which was
still WIP; I paused working on it because I figured people would see
it as big "cleanup" patches with no practical benefit)
  * https://github.com/gitgitgadget/git/pull/1149 (which has been
ready to submit for a _long_ time, but I just haven't yet)
or if these two things are orthogonal to what you have in mind.

> I'm also planning to send a proposal for a document full of "best
> practices" for turning Git code into libraries (and have quite a lot
> of discussion around that document, too). My hope is that we can use
> that document to help us during implementation as well as during
> review, and refine it over time as we learn more about what works and
> what doesn't. Having this kind of documentation will make it easy for
> others to join us in moving Git's codebase towards a clean set of
> libraries. I hope that, as a project, we can settle on some tenets
> that we all agree would make Git nicer.

I like the sound of this.

> After that, we're still hoping to target low-level libraries first - I
> certainly don't think it will make sense to ship a high-level `git
> commit` library in the near future, if ever - in the order that
> they're required from the VFS project we're working closely with. As
> far as I can tell right now, that's likely to cover object store and
> worktree access, as well as commit creation and pushing, but we'll see
> how planning shakes out over the next month or so. But Google's
> schedule should have no bearing on what others in the Git project feel
> is important to clean up and libify, and if there is interest in the
> rest of the project in converting other existing modules into
> libraries, my team and I are excited to participate in the review.

If we can't libify something like commit, does that prevent libifying
higher level things like merge?

I spent some time thinking about this a while back.  I tried to
carefully design merge-ort to improve the odds it could be used
elsewhere, maybe even libgit2.  (I hope it shows in the many comments
in merge-ort.h, and I think the "priv" field in particular allowing me
to hide the first ~300 lines of merge-ort.c declaring data structures
from users was really nice.)  However, I still had to accept data in
some known format.  So input parameters are things like trees and
commits.  But tree.h and commit.h both include object.h first, which
includes cache.h, which is basically all of Git.  And the functions I
call to interoperate with the system are similarly entangled.  So, the
odds of merge-ort being reused by libgit2 or otherwise used in a
library seems essentially nil, at least without some broader
libification effort.

I'd like to make that story better, time permitting (which is much
more of a challenge these days than it was a couple years ago), but
I'm curious if you or others have thoughts on something like that.

> Much, much later on, I'm expecting us to form a plan around allowing
> "plugins" - that is, replacing library functionality we use today with
> an alternative library, such as an object store relying on a
> distributed file store like S3. Making that work well will also likely
> involve us coming up with a solution for dependency injection, and to
> begin using vtables for some libraries. I'm hoping that we can figure
> out a way to do that that won't make the Git source ugly. Around this
> time, I think it will make sense to buy into unit tests even more and
> start using an approach like mocking to test various edge cases. And
> at some point, it's likely that we'll want to make the interfaces to
> various Git libraries consistent with each other, which would involve
> some large-scale but hopefully-mechanical refactors.

Would these plugins resemble the pluggable merge backends that was
added to builtin/merge.c?  Would it replace that mechanism with a
different one?  Would it be more like the refs backends?

Would this plugin scheme allow us to, for example, use gitoxide[1] as
a clone replacement to make clones 2x as fast (and with half the
memory -- although I suspect they cheated and used sha1 instead of
sha1dc, so maybe it wouldn't really be 2x)?

Oh, and it's totally okay if you don't know the answers to any or all
of my questions right now.  I'm just curious, because I've long
thought these kinds of directions would be good.  Since I've spent
time thinking about it, I have questions that I don't know the answers
to, but I figured it couldn't hurt to bounce them off others who are
thinking about this area.

Anyway, it's a large pile of work that you're undertaking, and as
Junio comments elsewhere in this thread it's unclear if libification
can be achieved for a big enough component (and you seem to admit as
much in your email as well), but I applaud the general direction and
your initial plans.


[1] https://github.com/Byron/gitoxide/discussions/579
