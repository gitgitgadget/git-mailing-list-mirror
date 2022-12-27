Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6210C4332F
	for <git@archiver.kernel.org>; Tue, 27 Dec 2022 14:40:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231835AbiL0OkD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Dec 2022 09:40:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231793AbiL0OkA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Dec 2022 09:40:00 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB339B1E
        for <git@vger.kernel.org>; Tue, 27 Dec 2022 06:39:58 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id u9so32472748ejo.0
        for <git@vger.kernel.org>; Tue, 27 Dec 2022 06:39:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZS6r2ytg5UCBeRMpXTMKhLJxXVOz9+odk6zmgHnMB8g=;
        b=Rd864sKrA0gfPNR4JNcpTP9nLkOqKUhSnhi1flZXo0NWSHC49wMQICY2qJkF04SThL
         e97CLt0tVJmqHthBmXtcfGtpdFO4s73CidVgSHC1mEqFEoOT2nrVR9ixx/1dNRALOG+Y
         NjqIJJ3nOpUeLEnYYJDKXvv9c6TguOHLMiCN2brPyyoPqwY0aHtBLPQqDz6Hmx0jctIh
         dVWMC1mZw4FAGl9IaicFfB22xrHWs+iPdQGljcZEC3sJH6ryRBX36iy/+kSGjw+pFbXl
         3vAPCBA/mTXD3dnm7gCCWSyskULBwVdNTHGgb+wcBxkLgZT+6t0MeXytocVWz4Ud5tjF
         SWFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZS6r2ytg5UCBeRMpXTMKhLJxXVOz9+odk6zmgHnMB8g=;
        b=h++qhagE9Dq/QoU1mYWI4bvIW3bkvvTs+iJy7BJX956lVZYooE7ZaUQ+4ctiaXe5EW
         0mbr+KDSFd7kUXqDvZBJX/+XncQ54kYxWCU5HxJMytWPGredTFt5mitn8sHc9h+1AxPd
         wrQjCTNg86KxcGYl8T+sJ07LrGVzOdtXyKW1PN5Y3MKhKzDBcoivUQpD+GOuMoVK5a2i
         Ead0T3wYycgx2BzKt4ia7dTBCGqOp/xtMdEW2AwrRbVeNJvEaJfs0b2WyjuzZuu2ZF0y
         7pTSV5sS3NYFJJQK128BJycibXLivEVaxxA+nJbSPPuoYxwW1tTXhupkG0DySuVx9Z/T
         NCkQ==
X-Gm-Message-State: AFqh2koND3NVbtB/TyGQsU6OsTYo1hl5kwErem6GucbRQB9Ge1Rk2Gf0
        6WGr9N9Df/bCXC6FZ7Wo1Xc=
X-Google-Smtp-Source: AMrXdXu2tHVJTlkoi4gyIRdMiFs3CY6l43PE8qb5p+J9WhhsG+u2RhxV1r/gtvpbi8r9MXZ37YVM5g==
X-Received: by 2002:a17:907:7e84:b0:7a4:bbce:ddae with SMTP id qb4-20020a1709077e8400b007a4bbceddaemr23595128ejc.59.1672151997415;
        Tue, 27 Dec 2022 06:39:57 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id q27-20020a170906145b00b007ad69e9d34dsm6158806ejc.54.2022.12.27.06.39.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Dec 2022 06:39:56 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1pAB7U-009FHw-0w;
        Tue, 27 Dec 2022 15:39:56 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: cmake topics & js/ci-disable-cmake-by-default
Date:   Tue, 27 Dec 2022 14:59:20 +0100
References: <xmqqcz86n8bn.fsf@gitster.g>
 <221226.86y1quv1gw.gmgdl@evledraar.gmail.com> <xmqqilhxv5eg.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <xmqqilhxv5eg.fsf@gitster.g>
Message-ID: <221227.86pmc4vrk3.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Dec 27 2022, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> I split up the previously merged to "next" ab/cmake-nix-and-ci and
>> submitted the uncontroversial parts of it as:
>
> Not gathering any interest by folks who will be affected is
> different from being uncontroversial, though.  It may not have seen
> any controversy so far, but once it reappears in my tree and
> sufficiently advances to cause trouble to other people, it would.
>
> In other words, I am saving time and energy of people by waiting for
> positive support on these changes.

These changes had made it to "next" already on the basis of the feedback
the topic already got.

Now, that's not justification in itself that a re-roll & split-up
belongs there again, but it also strikes me as a bad use of time to just
throw them away at this point now that I've submitted a version that
addresses the trouble it caused others (which I think the combined v6
also fixed, but as the topic is fairly large I think this split-up was
prudent).

>> I think whatever happens with js/ci-disable-cmake-by-default that it
>> makes sense to pick up & integrate those.
>
> I do not think so at all, at least judging by what little has been
> said so far on the list.  Comments on two among these three are
> negative ones, and the other one had no traction.

I'm assuming you're counting your own
https://lore.kernel.org/git/xmqqcz8e29d5.fsf@gitster.g/ as negative
here, I just replied at
https://lore.kernel.org/git/221227.86tu1huevt.gmgdl@evledraar.gmail.com/,
but maybe you're still not convinced.

In any case, that 1/3 topic could be discarded without the other 2/3
being affected, even though it seems to me to be a trivially correct
fix.

If you mean
https://lore.kernel.org/git/f67e0281-8a14-669d-0d1c-ed0b1351a64a@dunelm.org=
.uk/
I'm not sure what to do with that other than my reply at
https://lore.kernel.org/git/221219.86h6xrzaxd.gmgdl@evledraar.gmail.com/.

I don't see how I, having spent quite a bit of time untangling the
platform-specific parts of the CMake recipe, would be inherently
unqualified to spot and clarify the CMake docs in such a way that they
make it clear what parts are the cross-platform parts, and which are the
platform-specific parts.

>>> * js/ci-disable-cmake-by-default (2022-12-20) 1 commit
>>>  - ci: only run win+VS build & tests in Git for Windows' fork
>>>
>>>  Stop running win+VS build by default.
>>>
>>>  Will merge to 'next'?
>>>  source: <pull.1445.git.1671461414191.gitgitgadget@gmail.com>
>>
>> Per my feedback there, I still think it would make sense to at least
>> split up the "should we build with MSVC?" from the "do we use cmake, and
>> run the re-run tests we already ran with GCC with MSVC too?".
>
> Do you mean that in our primary CI jobs, you would, using Makefile,
> want to keep building the win+VS artifacts with MSVC and running the
> tests, even though Windows folks want to drive the same build
> process via CMake, and their release binaries will come from the
> latter?=20=20

I don't think "running the tests" is a good use of time, although we
might want to do so if some "extended tests" ci-config option is set,
which e.g. "next" and/or "master" might want to turn on.

So just like we run tests on OSX for both the git built with gcc and
clang (and yes, that isn't the only difference, we sneak in the "no
sha1dc" there too) perhaps we'd like to run the tests for the MSVC-built
git too.

> I am not sure which extra corners, which matter to us, are covered
> by doing so.  What's the upside?

Doing the *build* is relatively cheap when it comes to CI time, and
would catch some portability issues.

In any case, I'm not asserting here that js/ci-disable-cmake-by-default
must do what I'm suggesting in the last few paragraphs.

But rather that its commit message doesn't really cover what it's
actually doing, and that at least adjusting that would be
worthwhile. It's saying that it's disabling the "build and test with
cmake + MSVC" entirely because the tests are slow, and that cmake isn't
wanted in git/git.

Whereas the more obvious conclusion IMO is to then undo the later change
to that job to use "cmake" to build with "MSVC" (which was a later
development) and/or don't run the test part.

>> But now we won't even run that in CI, and "git-for-windows" will have
>> ownership of it.
>>
>> Does that mean that for such Makefile changes we should simply leave out
>> the cmake changes, and rely on git-for-windows to "catch up" with its
>> cmake contrib component?
>
> That is the natural conclusion of what has been said on the list so
> far.  We do not even "rely on"---it is up to them who chose to use
> CMake to keep it up to date or lag behind.  Among those who have
> made significant contributions and works outside Windows, we found
> nobody whowants to touch CMake.

Thanks, that's pretty much the clarification I was looking for. I do
think it's going to result in more disruption than is strictly
necessary, but *shrug*.

I do think it would be good to prominently note this at the top of
CMakeLists.txt, i.e. that the version in git/git can be expected to be
broken or out of date, I could re-roll the "cmake doc" topic I have
outstanding to add that, except...

>> Ultimately I don't mind such an arrangement, but I think that
>> js/ci-disable-cmake-by-default brings us to a weird in-between
>> state. Just removing it from the tree and having git-for-windows carry
>> it would make sense.
>
> That's fine by me personally, but somebody has to help coordinating
> such a move between two projects.

...(continuing from above). I'd be happy to do that, even though I'm
still surprised that this is the path Johannes seems to prefer going
forward.

As it's surely more work for git-for-windows to deal with whatever we
throw over the wall at them, rather than have us take them into account
(which would have been easy once we CI'd it on Ubuntu:
https://lore.kernel.org/git/patch-v6-15.15-917a884eb65-20221206T001617Z-ava=
rab@gmail.com/).

But *shrug*.

I think if we're going down this path it would make sense to first start
by removing the support for building with MSVC and generating the VS
project files from the Makefile.

There's more to it than this, but it's basically this & adjacent code
(e.g. in config.mak.uname):
=09
	$ wc -l $(git ls-files 'contrib/buildsystems/Generators*' 'compat/vcbuild/=
scripts*' compat/vcbuild/find_vs_env.bat)
	 168 compat/vcbuild/find_vs_env.bat
	 133 compat/vcbuild/scripts/clink.pl
	  26 compat/vcbuild/scripts/lib.pl
	  42 contrib/buildsystems/Generators.pm
	 189 contrib/buildsystems/Generators/QMake.pm
	 579 contrib/buildsystems/Generators/Vcproj.pm
	 402 contrib/buildsystems/Generators/Vcxproj.pm
	1539 total

This has all been bitrotting since 4c2c38e800f (ci: modification of
main.yml to use cmake for vs-build job, 2020-06-26), and it's been
broken since sometime in 2020 for DEVELOPER=3D1 builds at least (started
failing with new warnings, and then the C99 change in
git-compat-util.h).

One reason I thought keeping the CMake recipe up-to-date & in-tree is
that it's much easier to maintain it than e.g. the hack that is
compat/vcbuild/scripts/clink.pl, which we'd need (or something like it)
if we're going to support building with MSVC with the Makefile.

But I don't see how it would make sense to have CMakeLists.txt
bitrotting in-tree, and for git/git to pick up the maintenance of this
"build using MSVC with the Makefile", which git-for-windows itself seems
to have abandoned.

(The actual release versions of GfW are, as I understand it, built with
GCC, so the only "cmake with MSVC" users are those using some
lightweight version of MS development tools)

Then, as a follow-up to that, if improvements to
contrib/buildsystems/CMakeLists.txt aren't going to be accepted to
git/git.

Or rather, if they would in principle, but are going to stall because
they might impact git-for-windows. As seems to be the case with my
proposed, which have had no timely feedback from the git-for-windows
folks on "upstreaming" those (or rather, fixing "upstream").

Then shouldn't we just:

	git rm contrib/buildsystems/CMakeLists.txt

Along with the other bits in-tree which at that point would only be used
for CMake, e.g. compat/vcbuild/vcpkg_install.bat?

I could submit all of that if you agree. This would not be my first
choice, but I don't think it's good to leave this in limbo in git/git
either.

The "git-for-windows" project would then just revert the part that
removes contrib/buildsystems/CMakeLists.txt once it lands there, and
proceed to maintain contrib/buildsystems/CMakeLists.txt only in that
project, along with the diverging part of main.yml etc.

What do you think?
