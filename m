Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77EE4C6FA8E
	for <git@archiver.kernel.org>; Sat, 25 Feb 2023 01:48:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229379AbjBYBsJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Feb 2023 20:48:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjBYBsI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2023 20:48:08 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80E7B671D7
        for <git@vger.kernel.org>; Fri, 24 Feb 2023 17:48:05 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-536b7eb9117so19585917b3.14
        for <git@vger.kernel.org>; Fri, 24 Feb 2023 17:48:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=p6Sto1QBrukR1ONjZQUTnWTkNDVHryaWq5xnx2E4tYU=;
        b=ARfeWRjX4uDZtIuUrj5k68V1vIb2lJVMCDD0eufOA/HSrhZJmuab1iMwPKMHHfFxVp
         CYR+avGcODXjnDmhNajYxJcFZo123WDdGHGluzq60YM7I8Akm3q/aDi/sMZ0LBdDPPpM
         KQtgTU0U5SmOJqMOU9D7ZJ/1ZIKy7/0of32rpPdMZ/MjZP3bgwkHf56aZLwUFPBVfaob
         rVZ5y9kNN7zBhyKdUIX4a/JEki7ZEgL5Uuh97fECf0C15j58H7NWVnxR5OURhIZHrIf5
         atPLRmvfTGPYwJfJhm7lVA8J9vuq3elod+5iIVzaUXpL7s+ZMJLu/KmRixmKR9PzYJ0P
         65xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p6Sto1QBrukR1ONjZQUTnWTkNDVHryaWq5xnx2E4tYU=;
        b=trnQRYZraxC782J1xdCyb1CCIOK87paJNh84hcxG/sPm9Qb1r0uzFQr0p/yImg4HZZ
         3RacqOli/7+aX2q4xiVeIV9xM5iUscKIIcvBae9ZZtAmiB5y5305XxvE60gV28FtjBK+
         fjTHrKQCRpPeVTTC6GpEKN7gd4nhrpv/s0ICRQoaJu2jxS+MYtXBWHlklvzSQLHJQZ9z
         AJ3Jo8APqv2KwhxaxUHkttrF6lqRlvjTPlfZBi96M8OwXctbCsoTcKrE20PqsZPGYBby
         NWVJZ7CRd/mWu0pyZ+hBLZ0NHEe7H021YD7AN5Sd8RfGYHZnL8Zo8RxdL6w9R2Sc+2WS
         NxyA==
X-Gm-Message-State: AO0yUKVjvFtShgLh29Y2b/S5Bm227IzcanqVQrELc+U5iTkKxNOqV4NU
        lYSXTG4TsF/RRa047EhYZOlpYf4650XxZZVwEM8b
X-Google-Smtp-Source: AK7set/dw/BexEidBIPo71TyQO0NMwHxQlwnfxs1cWVepWAZG48D+aGmMvv8iKuk2HmRrhHWyx0ijUA7AHGZTD5gsxmN
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:202:60fb:bc56:6979:1f96])
 (user=jonathantanmy job=sendgmr) by 2002:a81:7555:0:b0:52f:2abb:3323 with
 SMTP id q82-20020a817555000000b0052f2abb3323mr1527279ywc.572.1677289684639;
 Fri, 24 Feb 2023 17:48:04 -0800 (PST)
Date:   Fri, 24 Feb 2023 17:48:02 -0800
In-Reply-To: <86e7f589-7576-5ed3-3dc9-5dec9ca346eb@github.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
Message-ID: <20230225014802.2064597-1-jonathantanmy@google.com>
Subject: Re: Proposal/Discussion: Turning parts of Git into libraries
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Victoria Dye <vdye@github.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Emily Shaffer <nasamuffin@google.com>,
        Git List <git@vger.kernel.org>,
        Jonathan Nieder <jrn@google.com>,
        Jose Lopes <jabolopes@google.com>,
        Aleksandr Mikhailov <avmikhailov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Victoria Dye <vdye@github.com> writes:
> Emily Shaffer wrote:
> > Hi folks,
> > 
> > As I mentioned in standup this week[1], my colleagues and I at Google
> > have become very interested in converting parts of Git into libraries
> > usable by external programs. In other words, for some modules which
> > already have clear boundaries inside of Git - like config.[ch],
> > strbuf.[ch], etc. - we want to remove some implicit dependencies, like
> > references to globals, and make explicit other dependencies, like
> > references to other modules within Git. Eventually, we'd like both for
> > an external program to use Git libraries within its own process, and
> > for Git to be given an alternative implementation of a library it uses
> > internally (like a plugin at runtime).
> 
> I see why you've linked these two objectives (there could be some shared
> infrastructure between them), but they're ultimately separate concerns, with
> separate needs & tradeoffs. 

I think the main link is that we need (or think we need) both of them
- for example, we do want external code to be able to use Git's config
parsing mechanism, and we want to be able to swap out the object store.
They indeed are separate concerns.

> By trying to design with a unified solution for
> both, though, this proposal's solution may be broader than it needs to be
> and comes with some serious developer experience ramifications.
> 
> For example, looking at the  "call libgit.so from other applications"
> objective: one way I could imagine implementing this is by creating a stable
> API wrapper around various hand-picked internal functions. If those internal
> functions change (e.g., adding a function argument to handle a new flag in a
> builtin), the API can remain stable (by setting a sane default) without
> really limiting the contributor adding a new feature. 
> 
> However, my reading of this proposal (although correct me if I'm wrong) is
> that you want to use that same external-facing API as a plugin interface for
> Git. In that case, the contributor can't just add a new argument and
> trivially modify the wrapper; they either break the API contract, or create
> a new version of the API and continue to support the old one. While that's
> technically doable, it's a pretty sizeable increase to the amount of "stuff"
> contributors need to keep track of and limits the project's flexibility. 

For now, we at Google think that Git shouldn't guarantee API backwards
compatibility (unlike for plumbing commands), and that any users of
the API should be prepared for API backwards compatibility to not be
something Git has (and thus be prepared to, say, pin a version of Git and/
or be prepared to continually update their code, which they might want
to do anyway because hopefully, the Git developer community would update
an API because there is a user need or because it will make internal
code that uses that API better: hence they might want to meet the same
user need or have the same code improvement).

But I agree that the way an API change would be handled is different in
the two cases.

> > - Having clear, modular libraries makes it easy to find the code
> > responsible for some behavior, or determine where to add something
> > new.
> 
> This is more an issue of code & repository organization, and isn't really an
> inherent outcome of lib-ifying Git. That said, like the cleanup you mention
> later, I would not be opposed to a dedicated code reorganization proposal.

Thanks. I think that Emily didn't intend to present libification as
the only way to accomplish such an organization, but more of "here's
the business need to explain why we're doing this, and here's how it
benefits the project". I do agree that there are other ways of achieving
such a reorganization.

> > - Operations recursing into submodules can be run in-process, and the
> > callsite makes it very clear which repository context is being used;
> > if we're not subprocessing to recurse, then we can lose the awkward
> > git-submodule.sh -> builtin/submodule__helper.c -> top-level Git
> > process codepath.
> 
> Interesting - I wasn't aware this was how submodules worked internally. Is
> there a specific reason this can't be refactored to perform the recursion
> in-process?

Same answer as above.

> > - Being able to test libraries in isolation via unit tests or mocks
> > speeds up determining the root cause of bugs.
> 
> The addition of unit tests is a project of its own, and one I don't believe
> is intrinsically tied to this one. More on this later.

Same answer as above.

> > - If we can swap out an entire library, or just a single function of
> > one, it's easy to experiment with the entire codebase without sweeping
> > changes.
> 
> What sort of "experiment" are you thinking of here? Anyone can make internal
> changes to Git in their own clone of the repository, then build and test it.
> Shipping a custom fork of Git doesn't seem any less complex than building a
> plugin library, shipping that, and injecting it into an existing Git
> install.

Having clearly separated out modules means that experimentation,
especially those that span several months (say), can be more easily
done, because what we would need to change can be confined to one or
several files instead of possibly needing to be distributed across many
files. This not only helps speed up development but also keeping up with
upstream changes (there will hopefully be fewer merge conflicts this
way). The way of shipping experimental builds could indeed be from a
fork of the codebase.

> > The ability to use Git as a library also makes it easier for other
> > tooling to interact with a Git repository *correctly*. As an example,
> > `repo` has a long history of abusing Git by directly manipulating the
> > gitdir[2], but if it were written in a world where Git exists as
> > easy-to-use libraries, it probably wouldn't have needed to, as it
> > could have invoked Git directly or replaced the relevant modules with
> > its own implementation. Both `repo`[3] and `git-gui[4]` have
> > reimplemented logic from git.git. Other interfaces that cooperate with
> > Git's filesystem storage layer, like `scalar` or `jj`[5], would be
> > able to interop with a Git repository without having to reimplement
> > custom logic or keep up with new Git changes.
> 
> I'd alternatively suggest that these use cases could be addressed with
> better plumbing command support and better (public) documentation of our
> on-disk data structures. In many cases, we're treating on-disk data
> structures as external-facing APIs anyway - the index [1], packfiles [2],
> etc. are versioned. We could definitely add documentation that's more 
> directly targeted at external integrators.
> 
> [1] https://git-scm.com/docs/index-format
> [2] https://git-scm.com/docs/gitformat-pack

Plumbing commands require spawning processes and serializing inputs
and outputs, and we can't do things like pass callbacks or an mmap-ped
buffer we already have. (As an aside, we did consider that approach with
git-batch [1], but that didn't get much traction.)

As for interoperability on the basis of on-disk data, I think
the workload of keeping up with Git improvements shouldn't be
underestimated. For example, I don't think many (if any) implementations
that can read Git's files support partial clone (at least on the
client), and we are still improving things, e.g. hasconfig:remote.*.url
includeIf was recently added to Git config.

[1] https://lore.kernel.org/git/20220207190320.2960362-1-jonathantanmy@google.com/

> Both of these points sound more like implementation details/quirks of the
> VFS prototype you're building than hard blockers coming from Git. For
> example, you mention 'git status' needing to populate a full worktree -
> could it instead use a mechanism similar to FSMonitor to avoid scanning for
> files you know are virtualized? While there'd likely be some Git changes
> involved (some of which might be a bit plugin-y), they'd be much more
> tightly scoped than full libification.

I think the answer to this is the same as the disadvantages of outside
code calling plumbing commands (above).

> These cleanups/best practices are a great idea regardless of any potential
> lib-ification. I'll be sure to keep them in mind in any future changes I
> make or review.

Thanks.

> > In the longer term, if Git has libraries with easily-replaced
> > dependencies, we get a few more benefits:
> > 
> > - Unit tests. We already have some in t/helper/, but if we can replace
> > all the dependencies of a certain library with simple stubs, it's
> > easier for us to write comprehensive unit tests, in addition to the
> > work we already do introducing edge cases in bash integration tests.
> 
> This doesn't really follow as a direct consequence of making libgit
> externally facing. AFAIK, there's nothing explicitly stopping us from
> writing or integrating a unit test framework now.
> 
> Like the "make libgit public" vs. "allow for custom backends in Git", I
> think this is a separate project with its own tradeoffs to evaluate.

The way we're making code in Git externally facing, at least right now,
is not to make the entirety of the Git code (perhaps minus the builtins)
consumable from the outside, but just selected .c/.h files. Being able
to say "these .c/.h files can be used independently" will make unit
tests easier, I think. But yes, there is nothing stopping us from such
an effort independent of libification.

> > - If our users can use plugins to improve performance in specific
> > scenarios (like a VFS-aware object store in the VFS case I cited
> > above), then Git works better for them without having to adopt a
> > different workflow, such as using an alternative tool or wrapper.
> 
> I'm curious as to what you want the user experience for this to look like.
> How would Git know to dynamically load a plugin? How does a user configure
> (or disable) plugins? Will a plugin need to replace all of the functions in
> a given library, or would Git be able to "fall back" on its own internal
> implementation?

Right now, it's probably going to be just recompiling the Git binary
with a few .c files swapped for others, which is why it's important
to us to have defined boundaries between .c files (even if they move
over time). I do think that converting code in Git to access other
code through a vtable is desirable (that way, for example, a single
binary can access 2 kinds of object stores, for example) but even if
the Git project decides not to do that, we can still do a lot (and just
ship, for example, some extra .c files that can do both the standard
implementation and a custom one).

> > - An easy-to-understand modular codebase makes it easy for new
> > contributors to start hacking and understand the consequences of their
> > patch.
> 
> As noted earlier, I think improving the developer experience in this way is
> independent of the development of external APIs.

Noted - same answer as earlier too.

> > Of course, we haven't maintained any guarantee about the consistency
> > of our implementation between releases. I don't anticipate that we'll
> > write the perfect library interface on our first try. So I hope that
> > we can be very explicit about refusing to provide any compatibility
> > guarantee whatsoever between versions for quite a long time. On
> > Google's end, that's well-understood and accepted. As I understand,
> > some other projects already use Git's codebase as a "library" by
> > including it as a submodule and using the code directly[6]; even a
> > breakable API seems like an improvement over that, too.
> 
> This hints at, but sidesteps, a really important aspect of the long-term
> goals of this project - are you planning on having us start guaranteeing
> consistency once there's an external-facing API available? 
> 
> If not, that sounds like an unpleasant user experience (and one prone to
> Hyrum's Law [3] at that). 
> 
> If so, Git contributors will either be much more constrained in the
> introduction of new features, or we'll end up with a mess of
> backward-compatibility APIs.
> 
> [3] https://www.hyrumslaw.com/

I answered this above.

> > So what's next? Naturally, I'm looking forward to a spirited
> > discussion about this topic - I'd like to know which concerns haven't
> > been addressed and figure out whether we can find a way around them,
> > and generally build awareness of this effort with the community.
> > 
> > I'm also planning to send a proposal for a document full of "best
> > practices" for turning Git code into libraries (and have quite a lot
> > of discussion around that document, too). My hope is that we can use
> > that document to help us during implementation as well as during
> > review, and refine it over time as we learn more about what works and
> > what doesn't. Having this kind of documentation will make it easy for
> > others to join us in moving Git's codebase towards a clean set of
> > libraries. I hope that, as a project, we can settle on some tenets
> > that we all agree would make Git nicer.
> 
> I think the use of multiple libraries is part of the potentially suboptimal
> balance between the "load Git's internals as a library" and "let Git use
> plugins in place of its own implementations" goals. The former could leave a
> user in dependency hell if there are lots of small libraries to load, while
> the latter may work better with smaller-scoped libraries (to avoid needing
> to implement more than is useful). And, the functionality that's useful to a
> program invoking Git via library may not be the same as what someone would
> want to replace via plugin. 

I don't see how we can avoid separating up Git's code with either goal
(internals as library vs. plugins), but I think that such separation
makes the code clearer anyway even if one does not need to reuse
internals or use plugins.

> As a general note, this libification project - its justification,
> milestones, organization, etc. - seems to be primarily driven by the needs
> of a VFS that is entirely opaque to the Git community you're proposing to.
> As it stands, reviewers are put in a position of needing to accept, without
> much evidence, that this is the best (or only) possible approach for meeting
> those needs. 
> 
> While I'm normally content with "scratch your own itch"-type changes, what
> you're proposing is a major paradigm shift in how Git is written,
> maintained, and used. I'm not comfortable accepting that level of impact
> without at least being able to evaluate whether the problem can be solved
> some other way.

I think that reviewers should review code based on current principles,
not just based on our (we at Google) claim that it is useful for our
VFS (although perhaps our need might show that other people might have a
similar need too).

> Implementing dependency injection (via vtable or otherwise) and unit test
> mocking is a massive undertaking on its own, let alone everything else
> described so far. You've outlined some clear, fairly unobtrusive first steps
> to the overarching proposal, but there's a lot of detail missing from the
> plans for later steps. While there's always risk of a project getting
> derailed or blocked later on due to some unforeseen issue, that risk seems
> particularly high here given the size & scope of all of these components. 

True, but even the first steps will already enable us to accomplish
quite a bit. The later steps may change based on what we learn after the
first steps.

> Intermediate milestones/goals, each of which is valuable on its own,
> outlined in the proposal would help allay those fears (for me, at least).

Noted.

> So, to summarize my thoughts into some (hopefully) actionable feedback:
> 
> - It's really important that the proposal presents a clear, concrete
>   long-term vision for this project. 
>   - What is the desired end state, in terms of what is built and installed
>     with Git?

For the intermediate step (what we want to accomplish now/soon):
 - Git will compile into the same binaries as it does now, with no
   plugin functionality. There will be no additional libraries.
 - Git will have unit tests that compile a subset of Git's .c files,
   and may possibly supply their own .c files that implement existing .h
   signatures to serve as stubs.
 - Other projects that want to use Git's code will need to include Git's
   .c/.h files in their own build systems, possibly using the lists of
   files in the unit test Makefiles for reference. They will also need
   to keep up with changes themselves.

The end step might include vtables, but we probably will revisit that
later once we learn more about the task of code reuse, aided by what
we've accomplished in the intermediate step.

>   - What will be expected of other Git contributors to support this design?

To not break the unit tests by putting functionality in the wrong
place (but hopefully this is seen as a plus, in that we have something
mechanical to check such things), and to design new code to fit with the
principles of modularity.

>     What happens if someone wants to "break" an API?

I think I already answered this above.

>   - What is the impact to users (including security implications)?

As of the intermediate step, we don't allow plugins in the standard
build of Git, so I don't think there will be much impact. In certain
environments that run patched versions of Git, .c files could be swapped
out, but the impact is similar to that of what a patch can do.

> - The scope for what you've proposed is pretty huge (which comes with a lot
>   of risk), but I think it could be broken into smaller, *independent*
>   pieces. 

I think each patch set towards this goal can be considered independently.

> - It's hard to judge or suggest adjustments to this proposal without knowing
>   the specific challenges you're facing with Git as it is.

I think Emily has already outlined a few such challenges (and hopefully
I have elaborated on them), but if there are any specific ones you'd
like more information on, feel free to let us know.

> Finally, thanks for sending this email & starting a discussion. It's an
> interesting topic and I'm looking forward to seeing everyone's perspectives
> on the matter.

Thank you for your thorough review.
