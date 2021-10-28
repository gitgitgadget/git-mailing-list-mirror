Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00069C433F5
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 10:15:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D19B2610E5
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 10:15:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231666AbhJ2KRd (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Oct 2021 06:17:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231564AbhJ2KRc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Oct 2021 06:17:32 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F48FC061570
        for <git@vger.kernel.org>; Fri, 29 Oct 2021 03:15:04 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id ee16so23912371edb.10
        for <git@vger.kernel.org>; Fri, 29 Oct 2021 03:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=W+H+fGLbPPmveILDI6QhcnJ/p6mAGzeeln/6VRrPYkQ=;
        b=mfFD7G+m9XvM3Dsi1i3U2MslOe1kx5kEqtr3pHhJtuKDMk3deauZRwq243idJPy4LF
         2kNJah6byczFziGXCYwboZH72rOj8b8XetzG/D6zuCKtSgZiODzDbQH4/t3jTs5/YwNU
         MIuXNp9WXDoUQn+IB3AR0bxbAF1dZBfNwm65TeAPQqbe1Vfs0hhONqErnfPsevV4e3wM
         Q+MAvHnoqtom0diTfU09e39OCXbRkI7hZc+nNBM5GpWET/+8IFwzvNybhAIXmqnMB0VT
         QPz5d91gg+IbDqj9bw3NEnEf8s8MDkn6IAf4QfzBqSt4p+6QR2yoVeyJ9SId8F792gv6
         jaNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=W+H+fGLbPPmveILDI6QhcnJ/p6mAGzeeln/6VRrPYkQ=;
        b=UgTO+88U/eGoRrAWhtqE0kxCmxCjKhKoUI7E7F6L+mUGwEYikpHiDRczWDMNt75+DV
         bUmoFpdd5psDIkN/VGc3aUWqcHDvyGnjGlo3EfPGOceinnQ1O1Xo9L9pquvRwVWaVr1O
         NmqV+gTsn3rMnUfEmPI2WoVdqI/XOucgqbgsigFez4kwopWAcHGMiGwOnCjzurCLGQuP
         Sln6Q373vY+RrO3/xlVdCKzdpEIWsv5wYvTnQlvCWc9F8crZwznaD3AgI6IyNFOaR2CZ
         4+TN16CKVAw1KBPXeI7rsCc/YsYL8OZpiTEpXVVrfDdPyISZ768qFHIH6VgOHYRTSmuF
         THfg==
X-Gm-Message-State: AOAM5304G6rsaZ0nlWqFABHeJQKGFyik1zKQebZHSMSsI7JEg0OEl1zN
        OCTcDAdSzbnDlvIMqVGzUwn6yJEdhyfrag==
X-Google-Smtp-Source: ABdhPJxZ2q3+edROFIL8WxgkyK7nRtYAPaEOvtQyg+ZwiPN5gUSCLnlDEy/o7CO71JPkzl0A+wk7yw==
X-Received: by 2002:a17:906:6089:: with SMTP id t9mr12872790ejj.323.1635502502015;
        Fri, 29 Oct 2021 03:15:02 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id j3sm2652633ejo.2.2021.10.29.03.15.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Oct 2021 03:15:01 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mgOua-0024ZX-KD;
        Fri, 29 Oct 2021 12:15:00 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Matthew John Cheetham <mjcheetham@outlook.com>,
        Victoria Dye <vdye@github.com>, Theodore Ts'o <tytso@mit.edu>
Subject: Re: [Discussion] The architecture of Scalar (and others) within Git
Date:   Thu, 28 Oct 2021 20:58:15 +0200
References: <b67bbef4-e4c3-b6a7-1c7f-7d405902ef8b@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.6
In-reply-to: <b67bbef4-e4c3-b6a7-1c7f-7d405902ef8b@gmail.com>
Message-ID: <211029.86k0hww317.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Oct 27 2021, Derrick Stolee wrote:

> I'm starting this discussion thread to create a new area to consider these
> high-level concepts. Specifically: how should a new component like Scalar
> be included in the Git codebase?

For context. I've submitted a PATCH form of the back & forth
you/me/Johannes have been having on this topic, which hopefully should
unambiguously clear up exactly what it is that I've been suggesting:
https://lore.kernel.org/git/patch-1.1-86fb8d56307-20211028T185016Z-avarab@gmail.com/

As noted there some inline comments here, to the extent that it's not
addressed by the patch in some way.

> Options for preferred end state
> -------------------------------
>
> Let's get into some concrete proposals for the location of the Scalar CLI
> within the Git codebase. These are ordered based on increasing
> responsibility on the Git community: the first option should minimize
> community responsibility and maximize responsibility on the Scalar
> maintainers. We will discuss the pros and cons of each option after fully
> describing each of them.
>
> (Please add any options that I may have missed!)

I think what I'd like to add is...[continued below]...

> **Option 1:** One-directional coupling in `contrib/scalar/`
>
> The Scalar CLI exists entirely within `contrib/scalar/`, including all code
> and test infrastructure. To opt-in to building and testing Scalar, run
> `make -C contrib/scalar test` to build Git and Scalar and run the Scalar
> test scripts.

Aside: I think anyone reading this summary might assume that this 1st
item describes the current state of the scalar patches on-list, but
that's not the case.

I.e. that coupling is thoroughly bi-directional in its integration, and
the code is built by default.

> [...]
> **Option 2:** Loose coupling in a new scalar/ directory
> [...]
> **Option 3:** Tight coupling with entire Git project
> [...]

...[continued from above]...an "Option 0: Do we care?"

I think I've been the only one who's been pointing out anything about
the location of these source files, which prompted this mail. But it's
not because I care about the location per-se.

I don't think it matters, and I think arguing about that per-se would
just amount to needless bikeshedding.

What I *have* been pointing out is to the effect of "hey, your
build/test integration is broken in <xyz> ways, it looks to me like the
easiest way out of that happens to be to move these files to the
top-level".

E.g. the scalar series is now at v6, but apparently it hasn't been
noticed that some of the tests were broken on OSX due to apparent errors
with launchctl integration. That's because the patches had the code
compiled, but didn't run the tests.

If those and other issues with the series were fixed in a way that puts
it at whatever in-tree path you & Johannes would prefer I wouldn't mind
at all, and I doubt anyone else would have much of a strong preference
either.

I think the main reason there's been resistance from you two to consider
moving it away from "contrib/*" (but correct me if I'm wrong, I'm still
unclear on this point, even after reading this E-Mail in full) is that
you think it's important to communicate a certain maintenance status for
"scalar", so that we can freely change it, and even "git rm" it one day
when it's served its purpose.

I think the patch I've linked to above should address that in a way
that's primarily aimed at communicating that to users, not just git.git
developers. I.e. we now have it listed in "man git" under a "Optional
contrib commands" section that says:
    
    The following commands are included with the git sources, but may
    not be present in your installation.
    
    These should be considered "contrib"-level when it comes to
    maintenance and stability promises. They might not even be included
    in your installation, and may either drastically change in the
    future, or go away entirely.

So I guess my preferred option is: "Option 0: Make it integrate with
git.git in a way that's not buggy". I believe the patch I've submitted
gets us to that state.

If you wanted to run with that & move it around in-tree I think that
would be fine, as long as we're not introducing bugs by doing so.

Some specific & briefer comments below:

> [...]
> **Option 1:** One-directional coupling in `contrib/scalar/`
>
> This option was our initial choice because it minimizes the responsibility
> of the Git community. While `contrib/scalar/scalar.c` depends on code in
> `libgit.a`, the implementation does not require that code to change to
> accommodate the needs of Scalar. The test suite and documentation is
> separate.
>
> This does mean that changes to `libgit.a` could break Scalar without any
> feedback to the developer that has not compiled Scalar. The Scalar
> maintainers would then need to watch for this and send separate updates to
> Scalar that fix these dependency breaks. This reduces developer friction,
> but might cause some extra burden on the Git maintainer. If these "catch
> up to dependency breaks" updates happen only after a release candidate is
> out, then maybe this isn't too much of a burden. We don't typically have
> release candidates for minor releases, so there is some risk there that
> minor releases could include breaks.
>
> If we make our CI builds include Scalar by default, then the previous
> paragraph about developer friction is negated.

Without going into exhaustive detail I'll just note as above that much
of this describes a state that's got little or nothing to do with the
contrib/scalar/* patches on-list, which are thoroughly
bi-bidirectionally integrated, build (but don't test) by default etc.

> Having Scalar in `contrib/` makes it easy to differentiate it as an
> optional component that distributors could choose to include or leave out.

Why would the FS path have anything to do with making that easy?
E.g. distributors now can:

    make install NO_REGEX=MineIsBroken

That we store the relevant sources in-tree at compat/regex/ doesn't
matter to distributors. We could just as well have them at the
top-level. The UI we present is just some Makefile knob.

Yes, the currently propoed scalar patches would do the same via a
sub-Makefile, and e.g. contrib/subtree works that way, but does it
*need* to be like that for distributers? No, they'll just read the
release notes, and copy whatever the relevant instructions are.

> Code in `contrib/` has a lower barrier to entry. In particular, the Scalar
> CLI is not intended to be up for debate for historical reasons. If we make
> an exception for Scalar but want Scalar integrated outside of `contrib/`,
> then are we setting expectations for other tools that might want to be
> included?

We're not. We can just document the status of individual logical
components, separate from in-tree FS paths.

> However, projects within `contrib/` do not currently depend on `libgit.a`
> the way Scalar does. (This is not historically true, as an older project
> ad such dependencies, but has since been ejected.).[...]

Well, we've got contrib/buildsystems/, if a thing that builds libgit.a
doesn't have an (inter-)dependency on libgit.a I don't know what would
:)

But yes, we've got no C code in contrib/ currently that links *to*
libgit.a, which is one aspect of the breakages I've pointed out with the
scalar patches.

But as contrib/buildsystems/ shows the "contrib/" directory is not some
"hands-off" directory for git.git developers, i.e. if you make certain
changes in non-contrib the vs-build CI will break, since it has a hard
dependency on that contrib component.

So in terms of placing things in that directory unambiguously
communicating some "third party" or "top-level doesn't depend on this"
intent or state, I don't think it's really doing the work you seem to
think it will.

> This option explicitly mentions that all knowledge of how to build Scalar
> lives within `contrib/scalar/` to avoid disrupting the core `Makefile`.
> This has already led to debate about some duplication in the Scalar
> `Makefile` and the one at root.

As the instigator of particularl that debate: No that's not accurate at
all.

Well, to be fair I haven't been commenting on some hypothetical
"contrib/scalar/" that's "one-directional" and that you "opt-in to
building".  

As noted above I'm rather confused by this "contrib/scalar/" summary
describing something that doesn't at all map unto the relevant posted
patches.

To the extent that I have been discussing this aspect of the actual
posted patches it's been because the opposite of "all knowledge of how
to build Scalar lives within `contrib/scalar`" is true, as a look at the
removed lines in the patch I've posted above shows.

Most of that build and test infrastructure has a thoroughly hard
dependency on Makefiles at the top-level, in a way that causes more work
for anyone who's changing any of that top-level build logic, not less.

> **Option 2:** Loose coupling in a `scalar/` directory
>
> The first issue with this option is that the Scalar CLI is established and
> is not up for modification, yet we would be contributing it in a location
> that is typically under high scrutiny for things like this.

I don't think anyone's been disputing the fundimental point that the
whole reason for having this in-tree scalar is for the convenience of
some existing users, and that any proposed changes to the CLI UI need to
keep that in mind.

How would just having it in some subdirectory change any of that? Sorry,
I just continue not to understand what a "contrib/scalar/", "scalar/" or
whatever prefix would have anything to do with that.

> This option also breaks into new territory, because even `git-gui` and
> `gitk-git` are not based on C and do not depend on `libgit.a`.

If we're running with the idea that a one-level subdirectory of
not-really-git.git sources is somehow magical then in-tree "sha1dc/"
qualifies for the first part of that.

I.e. we build it by default, it's C based, but it doesn't depend on
libgit.a.

> [...]
> Developer friction increases as changes to `libgit.a` that break Scalar
> should be fixed within the patches that cause those changes.

So again on the "hypothetical contrib/scalar/*" point: This is also true
of Johannes's "contrib/scalar/*" patches on-list.

So having read this far this "scalar/*" distinction here seems to really
be describing something like the current state (but under a different
path), and patches for "Option 1" have not been seen on-list.

> [...]
> **Option 3:** Tight coupling with the entire Git project
>
> This option removes the ability to opt-out of building the Scalar CLI.
> Distributors might need to react to remove the `scalar` executable if they
> do not want to include it.

I'm apathetic to whether we actually install it by default, but in my
patch above that's optional.

So "tight coupling" in the sense of not only building it, but also
running the tests does not need to entail that we install it by default.

> This option sets a risky precedent that new tools can be added to Git
> without a rigorous review of the CLI.

I think the changes I had to "man git" should cover this, not that the
scalar CLI couldn't do with a bit more review/polishing (some of which I
discovered recently when trying to get the CI working).

> **Phase 1.** Keep code in contrib/ while we contribute the Scalar features.
>
> Since the current patches on the mailing list are not feature complete, it
> can be beneficial to move forward with the code in `contrib/scalar/` until
> we reach feature parity. At that point, we could move the source into its
> final resting place.

Why specifically does it need to be at a different in-tree path before
it reaches feature parity?

This proposal seems to implicitly assume a lot about the necessity for
FS-path-based lifecycle management of components, without really
justifying why any of that's needed.

Let's just put things in their "final place", document their current
state for human consumption somewhere (commit messages, "man git", etc.)
and avoid the path-based churn? Why isn't that OK?

> [...]
> Depending on the final goal, we could drop some of the work that is currently
> built within the `contrib/scalar/` directory, such as `-c`/`-C` parsing or
> documentation builds. These features would be reimplemented in the new
> location, so we can prevent that duplicate effort if we have a different
> final location in mind.

Just on -c & -C parsing: It's already true that scalar uses libgit.a,
it's even true that scalar (admittedly small) parts of libgit.a that no
other caller uses directly.

So I don't see why having it in a given in-tree location and already
needing parts of libgit.a would preclude us from creating APIs
specifically for its use.

Particularly in the case of git.c where those APIs would benefit any
future "top-level program sort of like a git(1)" caller, and would/could
even benefit our own sub-commands such as "git commit-graph" et al.

E.g. if we lifted out the typo correction cmd dispatching from git.git
and could use it for those + scalar.c, that would be very nice for
existing in-tree users, and would also reduce code duplication in
scalar.c.

> [...]
> Thanks for your attention to this topic. I look forward to any new "big"
> ideas in this space.

I think that in this case a series of "small" ideas might cause any
preconceived "big" solutions to evaporate once implemented.

E.g. in [1] Johannes noted:

    "Just forget about Scalar's build process. Forget about getting its
    CI to work. I have all that figured out already. It is all working
    as well as needed."[1]

That "as well as needed" is doing a lot of work, as noted above it was
clearly broken on the OSX CI at least.

One thing my linked-to does is to fix/change that small aspect, does
anyone mind the incremental step of scalar.c not only being built but
also tested? If so let them just note their concerns in the releant
thread.

Once we address such point-by-point issues will any "big" ones remain?
Maybe, maybe not.

1. https://lore.kernel.org/git/nycvar.QRO.7.76.6.2110221734530.62@tvgsbejvaqbjf.bet/
