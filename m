Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCEF8ECAAA1
	for <git@archiver.kernel.org>; Fri, 28 Oct 2022 11:15:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbiJ1LO7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Oct 2022 07:14:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiJ1LO4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Oct 2022 07:14:56 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FF1E31ED1
        for <git@vger.kernel.org>; Fri, 28 Oct 2022 04:14:54 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id n12so12091248eja.11
        for <git@vger.kernel.org>; Fri, 28 Oct 2022 04:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ht0/3u6pv5ZzKSyt7brSaZ27AneC6JmlUB4MiLUMUBw=;
        b=FfPR7NQ+aVOrLK2t0kUZETUWLsEs67SDWTGmDmefBKbjeCSy7MkErx4UwafdkeYRns
         948vHY8QEIQrvyxmSdFuUSHE0bSBOG761GtK3vILXigLlBr14SuyjLOhCbnLdI4X0xQd
         nFhVztBfqt3GxKgOOiQ1P3mkPHm9O1fNFB18DXLvW24re2ffIjykbYLJ55pDiiW5fYs0
         CS5lSUDSkfNTvVb/hNBerAPVm6irEtmv4GkZEl+u/Y2/0QcwUZX/hfw5WNbfOxDbKCLD
         qs+b7qrVnXEQnsNANK4xX8ebpqyC1LMpXbaCAuEsu/SPOJC64cVcXgyznfrInziR4OFn
         KVmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ht0/3u6pv5ZzKSyt7brSaZ27AneC6JmlUB4MiLUMUBw=;
        b=xk4L7KfRBV7dyKPJb/vPhR4Kzxl265x2RpTvwwvsq1To3rrxsJjI8ay9nKaxH0+LS0
         8fo6MMM18NgayujjRCJ94B3dhkk4wce5cDY22dgEYs642pyhbdwQ3lpa7ZExxt+wthh8
         V3oTI87YZl5TfPKj/DkjnCkXixoBJsOeJmz09yTNGUm9VP0nUrLMcMuqQqqxik5G8rCQ
         OyEfYj/J1vK5owT2HdyZNgvx5nn1+qWKAHBGw5jObdWLvyn8595aKdzcYezAqyQZ8y9k
         zfvdOAJnZaRoHZ8y/UnrmdZ7GzgouKODDdJ/2qgYTRFQxgjfkwXLjwIxq8dmfG7MrYuR
         1ABQ==
X-Gm-Message-State: ACrzQf01sDBBW6wEtwpmwEwilZAEXcXdoYfHh1HzAzN4oXDzyLdURNlH
        UQ7wlyM6GY8PTlfPe+KLeW4=
X-Google-Smtp-Source: AMsMyM7m4Vniutrk/IWAHtY2h5jsjtp5Re9efBqYqeK2ZBL38r8+e/W6uDP7nlG7X1D+uvMVlVyeVA==
X-Received: by 2002:a17:907:320b:b0:780:280:7b72 with SMTP id xg11-20020a170907320b00b0078002807b72mr48141350ejb.146.1666955692364;
        Fri, 28 Oct 2022 04:14:52 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id q2-20020a50c342000000b00459cf672a65sm2477330edb.71.2022.10.28.04.14.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 04:14:51 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1ooNK6-009pvp-2H;
        Fri, 28 Oct 2022 13:14:50 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        John Cai <johncai86@gmail.com>
Subject: Re: [PATCH v3 4/4] Documentation: add lint-fsck-msgids
Date:   Fri, 28 Oct 2022 12:41:58 +0200
References: <pull.1369.v2.git.git.1666667864.gitgitgadget@gmail.com>
 <20221025224224.2352979-1-gitster@pobox.com>
 <20221025224224.2352979-5-gitster@pobox.com>
 <221026.867d0ncncu.gmgdl@evledraar.gmail.com>
 <Y1jG8p1aARb9+CV+@coredump.intra.peff.net>
 <221026.8635badbz5.gmgdl@evledraar.gmail.com>
 <Y1su99Kc0ex1W7bX@coredump.intra.peff.net>
 <221028.86sfj88xdq.gmgdl@evledraar.gmail.com>
 <Y1tpVqWn5yMYbE21@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <Y1tpVqWn5yMYbE21@coredump.intra.peff.net>
Message-ID: <221028.86fsf88aj9.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Oct 28 2022, Jeff King wrote:

> On Fri, Oct 28, 2022 at 04:04:12AM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
>> > I think this particular case is tricky in that direction, because it's=
 a
>> > big set of dependencies that aren't necessarily one-to-one. E.g.,
>> > builtin/log.c needs to depend on git-log.txt, but also on git-show.txt
>> > and git-format-patch.txt.
>>=20
>> I was thinking of just a generated usage-strings.c or whatever. I.e. one
>> file with every usage string in it. Then you don't need to hunt down
>> which thing goes in which file. We'll just have a variable named
>> "builtin_format_patch_usage". Include it in "builtin.h" and it doesn't
>> matter if that's in builtin/log.c or builtin/format-patch.c.
>
> Yes, though you have the opposite problem, then: what are the source
> files that can produce that usage-strings.c? If your answer is
> "Documentation/git-*.txt", then that is a recipe for flaky dependencies.

First, you're not telling me anything new here :) I've looked at
literally all of these special-cases recently for t0450*.

> We already have one such for config-list.h. Try this:
>
>   # introduce a new file
>   printf 'foo.bar::\n\ta fake config var\n' \
>     >Documentation/config/foo.txt
>
>   # it shows up in the output, as expected
>   make
>   ./git help --config-for-completion | grep foo
>
>   # now drop it
>   rm Documentation/config/foo.txt
>
>   # oops; make won't rebuild anything, and it's still there
>   make
>   ./git help --config-for-completion | grep foo

Yes, much of the dependency graph in Documentation/Makefile is simply
broken, and that's not the worst offender.

Try adding a new category to command-list.txt, then remove it, and watch
your entire build fail until you 'git clean -dxf' (because
Documentation/Makefile will only remove the generated cmds-*.txt it
knows about, but another part includes things based on a wildcard.

> The bug is that config-list.h depends on a glob. So we notice when a
> file changes, but not when one goes away. And this isn't just
> hypothetical. Files come and go as you "git checkout" around history (or
> bisect). I don't remember the details, but I'm pretty sure I've gotten
> false positive test failures out of this before (maybe a topic branch
> with a bogus entry that broke t0012 or t9902, and then moving back to
> master doesn't fix it?).
>
> So I'd prefer to avoid introducing more flakiness if we can. You might
> be able to piggy back on command-list.txt in this case (that's what
> makes command-list.h not flaky).

I'm in violent agreement with you that this problem sucks, but it's also
trivial to solve: Just don't create such crappy dependency graphs in our
Makefiles.

So, in this case (and keep in mind this is off the cuff, and I'm not
advocating for doing this now) is:

 1. We already have an exhaustive list of built-ins in the top-level
    Makefile
 2. Turn those into corresponding Documentation/git-*.txt dependencies,
    e.g. builtin/rebase.o to Documentation/git-rebase.txt.
 3. Some won't exist on the other side, we have no
    builtin/cherry-pick.o, but a Documentation/git-cherry-pick.txt etc. I
    know, keep reading... :)
 4. Slurp up the *.txt, parse it (this code's mostly in t0450 already),
    spew out a generated *.c or *.h.

Critically this is based on an exhaustive known list at this point, if
we add/remove built-ins we *will* re-generate it. It's not using a
wildcard dependency.

At this point we have e.g. variables like:

 - git_builtin_bundle_usage
 - git_builtin_log_usage

But because we're not smart enough and/or it doesn't correspond to our
*.txt structure we don't have e.g.:

 - git_builtin_bundle_create_usage (a sub-command)
 - git_builtin_fsck_objects_usage

But that's fine.

We can just handle remaining special-cases by not removing the cases we
didn't handle from the C sources, we'll still need to maintain those on
both sides, and have t0450 hopefully catch them drifting.

I.e. a subsequent change to the C code would be something like:
=09
	diff --git a/builtin/bundle.c b/builtin/bundle.c
	index e80efce3a42..557e00be5a2 100644
	--- a/builtin/bundle.c
	+++ b/builtin/bundle.c
	@@ -11,14 +11,7 @@
	  * bundle supporting "fetch", "pull", and "ls-remote".
	  */
=09=20
	-static const char * const builtin_bundle_usage[] =3D {
	-  N_("git bundle create [<options>] <file> <git-rev-list args>"),
	-  N_("git bundle verify [<options>] <file>"),
	-  N_("git bundle list-heads <file> [<refname>...]"),
	-  N_("git bundle unbundle <file> [<refname>...]"),
	-  NULL
	-};
	-
	+/* too dumb for these still... */
	 static const char * const builtin_bundle_create_usage[] =3D {
	   N_("git bundle create [<options>] <file> <git-rev-list args>"),
	   NULL

We didn't handle everything, but that's OK. Perfect shouldn't be the
enemy of the good.

We have on the order of 150 built-ins, by far the majority of them are
relativtely easy to correlate to their docs & scrape them out.

The goal here would be to mostly get rid of the maintenance burden of
maintaining these in two places, if we still need to do that in 10-30
cases instead of 150-200 we've solved most of the problem.

>> It does mean you need to rebuild the C code for other built-ins every
>> time one of the SYNOPSIS sections changes, but doesn't happen too often.
>
> If it's a c/h combo that only makes the variable names public (not the
> contents of the strings they point to), then it would only trigger a
> rebuild when a command is added or removed.

Yeah, and if we didn't like that we can make it a file per variable
(which I think sucks), but a full re-build every time we add a built-in
isn't too bad. And we *way* worse now, every time some utility function
is added to a few common headers we basically do a re-build.

>> I think I either did or was planning to take it out of cache.h as part
>> of that, we put way too much in cache.h.
>>=20
>> Even advice.c depends on cache.h for its advice.h *sigh*.
>>=20
>> Trying it just now putting advice.h in builtin.h instead leaves 10
>> top-level files not-compiling (and they just need the header).
>>=20
>> I think it's fine to include common utilties in our "included by
>> everything" headers, but if we've got ~500 *.c files and something is
>> only needed by ~20 of them (as in this case) we should probably just
>> include it in those 20.
>
> Oh, definitely, we should be shrinking cache.h, and not adding more to
> it. Especially not generated stuff.

*more violent agreement noises* :)

FWIW I have some patches to make headway on that stuff, which I've kept
unsubmitted because I thought nobody was interested...

I.e. a *very large* part of cache.h and friends is stuff that maybe 3-5
files here and there need, not "nearly everything", as one might assume.

We should still have e.g. gettext.h and the like in there,
probably.

Although for those we should probably split them off into builtin.h and
e.g. a new libs.h, so that we don't get translations added in
t/helper/*.c and the like, so maybe ...

>> >> 	make file-that-does-not-use-generated-header.o
>> >>=20
>> >>    It sucks a bit to have e.g. every *.o depend on command-list.h, wh=
en
>> >>    we only use it in 1-2 places, ditto the other headers.
>> > But that is already true of non-generated headers. If your system
>> > doesn't support computed deps, then all objects depend on all headers.
>>=20
>> ... this does not build e.g. command-list.h:
>>=20
>> 	make clean
>> 	make grep.o
>>=20
>> But this does:
>>=20
>> 	make clean
>> 	make help.o
>>=20
>> Because we've manually declared that.
>
> Right, but...does grep.o actually need command-list.h? If it doesn't
> (and that seems to be the case), then all is working as intended. If
> grep included some other header that included command-list.h, then yeah,
> that would be a bug. But that is true whether grep.c includes it
> directly or not. Any Makefile dependency needs to take into account
> recursive includes.

Yes, it doesn't need it, and it shouldn't build it. I'm saying that this
is the reason we've needed manually maintained dependencies of these
generated headers.

I.e. if you take the easy way out and say that we have no generated deps
yet, let's build all of it you would build that stuff with grep.o for no
reason.

And yes, I'm aware that that's what we do right now. I'm saying that
it's probably OK because we've had 3-4 of these headers, but people
might mind if it's more, or a lot more...

>> > Yes, that sucks for you. But almost nobody actively develops on such a
>> > system, and people building Git to use rarely notice (because they are
>> > doing an initial build, or jumping versions, both of which generally
>> > require recompilation anyway).
>>=20
>> I guess I'm "almost nobody" :) Not because I don't use computed deps,
>> but because I tend to e.g. do large interactive rebases with:
>>=20
>> 	git rebase -i 'make grep.o'
>>=20
>> Or some other subset of our built assets/objects.
>
> I do that all the time, too. But with computed deps, it works (by which
> I mean it rebuilds only stuff needed by grep.o).
>
> I'm not even sure what we're talking about anymore. If you are saying
> that no, we don't want to just say "everything depends on foo.h that is
> generated", I agree. That is wrong to do, and we should specify the
> minimal dependencies where appropriate (and take care to keep that set
> as small as is feasible using small C interfaces).
>
> If you're saying "for people without computed dependencies, everything
> will want to rebuild shell scripts", then I don't care. We decided long
> ago that maintaining a manual list of header dependencies was not worth
> doing, and people with sub-par compilers will have to suffer.
>
> In the email you're replying to, I was trying to express the second one.
> But it sounds like you thought I was trying to argue against the first
> one.

I'm saying there's a large chasm between using generated dependencies,
and using them all the time.

Maybe my dev setup is just different, but I do most of my development in
a primary development tree where I've generally built things already, so
all the incremental compilation we support works out nicely.

But I also do things like spin up different workrtees for different
revisions, build some subset, and destroy them afterwards. Those don't
benefit from computed dependencies, so it's nice that we're not
over-building things.

Anyway:

All I was trying to get across with the upthread was that I had further
patches in this area that might be useful, but that part of the reason I
hadn't submitted them was because I didn't want to introduce suckage
with them.

We don't make a lot of use of generated code, and the uses we have now
are really isolated (one header used by one *.c file, mostly).

If we make that a one<->many we should be careful, and there's some
dragons lurking e.g. for generated *.h's used by other *.h's (all our
use is by *.c's at this point).
