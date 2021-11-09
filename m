Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FD2DC433F5
	for <git@archiver.kernel.org>; Tue,  9 Nov 2021 01:40:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65A7361104
	for <git@archiver.kernel.org>; Tue,  9 Nov 2021 01:40:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238619AbhKIBmx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Nov 2021 20:42:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230441AbhKIBms (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Nov 2021 20:42:48 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4473FC069598
        for <git@vger.kernel.org>; Mon,  8 Nov 2021 17:28:44 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id f4so69733163edx.12
        for <git@vger.kernel.org>; Mon, 08 Nov 2021 17:28:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=0G+0U0qmG3NzjpMKucuUF46Uc3oV90WssDzQDgBWCw0=;
        b=Q1Lxinp1URIw/MZOFTx3rk/N1p5a8WuroWRMJWohmNz6BTWhVqCgSp1kP6+Wog6DP0
         NH0+GaJN5/FSg0x3o8x36W+FQUd06aA2xAo1lcOSDjHfr9+ejkqzGGOZwxkxMz7zT1B0
         GWkJvpTWWld6DSp2JxU7po0tnCmsJC8BYTdlggkjuWXRdKNKfH+WeF/e9hTAZJFaYqNN
         YofmBt+3CSyz6XBcRNHl+rFJASLoMhcWMSusOw2+xiKk3OLrF8TjUAKxToUpKrqP62bv
         PP4LizMOIdt9i5tieagoIy5c8AjN6ifsNEtDQX+SKpYFFMETLqIJobKKAQjB0h1m2pfc
         bhLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=0G+0U0qmG3NzjpMKucuUF46Uc3oV90WssDzQDgBWCw0=;
        b=zFIno08MQmshLElFT9gQlSGI6o6kVnsExJnaV5zu4eWVATueNNStJ4t0SPtPvUbUxf
         22QyRp3s5xinIx1sA9YvQJ14j+2QSD+0tQ0kZmhZHHm1mQqnTPSAb6qvTsJ7IJjvMGfr
         +ZetZuLfyJB03Pno4kkMfm+gAkekNXVLRbYPy/DzBREGBm1eEeZZgPYnzN3aslysDJ5q
         aGKusZUvqWp3GWg7bzlP5Ya81PwTQ+LH9UrsqYCLRLco0ycowWYyznmBnW++WHjaUk1C
         OJ1c31gdgUBA6mLHtEqKdz8C1hFa9UqKTtYMCoyB002nVrc6u/ipI3N0TKcWfnh5d9oZ
         s9lQ==
X-Gm-Message-State: AOAM530sFdpjVX3CqNJn4uo/pHNO30wwjeT63jyv1mRYf9VJL0/20lEQ
        VfTfH2b983stYFZAdujhOif8XYB/k2k=
X-Google-Smtp-Source: ABdhPJzPM/+98CB649yPAfij43h6Tv7unyOrl/ePt8ZKXM703iWjTZco9QMdolU+ESGCa0O/Hee1og==
X-Received: by 2002:a17:906:12db:: with SMTP id l27mr4736977ejb.244.1636421322763;
        Mon, 08 Nov 2021 17:28:42 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id bx27sm10333307edb.7.2021.11.08.17.28.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 17:28:42 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mkFwH-001Ia5-Pf;
        Tue, 09 Nov 2021 02:28:41 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org, Atharva Raykar <raykar.ath@gmail.com>
Subject: Re: [PATCH v5 4/4] submodule: record superproject gitdir during
 'update'
Date:   Tue, 09 Nov 2021 02:12:24 +0100
References: <20211104234942.3473650-1-emilyshaffer@google.com>
 <20211104234942.3473650-5-emilyshaffer@google.com>
 <211105.86wnlngebr.gmgdl@evledraar.gmail.com>
 <YYmxSptSDRPWJJ3t@google.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.6
In-reply-to: <YYmxSptSDRPWJJ3t@google.com>
Message-ID: <211109.86r1bqdsmu.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Nov 08 2021, Emily Shaffer wrote:

> On Fri, Nov 05, 2021 at 09:51:12AM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>>=20
>>=20
>> On Thu, Nov 04 2021, Emily Shaffer wrote:
>>=20
>> > A recorded hint path to the superproject's gitdir might be added during
>> > 'git submodule add', but in some cases - like submodules which were
>> > created before 'git submodule add' learned to record that info - it mi=
ght
>> > be useful to update the hint. Let's do it during 'git submodule
>> > update', when we already have a handle to the superproject while calli=
ng
>> > operations on the submodules.
>> >
>> > Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
>> > ---
>> >  git-submodule.sh            | 14 ++++++++++++++
>> >  t/t7406-submodule-update.sh | 12 ++++++++++++
>> >  2 files changed, 26 insertions(+)
>> >
>> > diff --git a/git-submodule.sh b/git-submodule.sh
>> > index 652861aa66..873d64eb99 100755
>> > --- a/git-submodule.sh
>> > +++ b/git-submodule.sh
>> > @@ -449,6 +449,20 @@ cmd_update()
>> >  			;;
>> >  		esac
>> >=20=20
>> > +		# Cache a pointer to the superproject's common dir. This may have
>> > +		# changed, unless it's a fresh clone. Writes it to worktree
>> > +		# if applicable, otherwise to local.
>> > +		if test -z "$just_cloned"
>> > +		then
>> > +			sm_gitdir=3D"$(git -C "$sm_path" rev-parse --absolute-git-dir)"
>> > +			relative_gitdir=3D"$(git rev-parse --path-format=3Drelative \
>> > +							 --prefix "${sm_gitdir}" \
>> > +							 --git-common-dir)"
>> > +
>> > +			git -C "$sm_path" config --worktree \
>> > +				submodule.superprojectgitdir "$relative_gitdir"
>> > +		fi
>> > +
>>=20
>> Aside from the "is this really needed anymore?" comment on this caching
>> strategy in general I had in [1] does this really need to be adding new
>> shell code to git-submodule.sh given that we're actively trying to get
>> rid of it entirely and move it over to C.
>>=20
>> I.e. here we've just called "git submodule--helper
>> run-update-procedure", and we pass it "$sm_path" (but not "$recursive",
>> but could easily do so).
>>=20
>> It needs to clone this new submodule, so presumably it already has a
>> "$sm_gitdir" equivalent, and we can turn that into the same relative
>> path, no?
>>=20
>> Can't we call this with a git_config_set*() somewhere in that code?
>>=20
>> *investigates a bit*
>>=20
>> Okey, so I see that [2] is part of a series that Atharva Raykar had a
>> version of (including this new git-submodule.sh code above) [3] rebased
>> on top of an older version of this topic. I.e. this bit is that part of =
that patch:
>>=20
>> +       git_config_set_in_file(config_path, "submodule.superprojectGitdi=
r",
>> +                              relative_path(get_git_dir(),
>> +                                            update_data->sm_path, &sb));
>>=20
>> I also vaguely recall that Junio ejected his topic to make room for this
>> topic first.
>>=20
>> Maybe I've missed some update on this but is his [2][3] broken in
>> combination with your topic here? And re[1] is whatever "caching" is
>> being done here still beneficial once this is all moved to C?
>>=20
>> In your [4] there seems to be an agreement to do it the other way
>> around, but as noted in the mail linked from [1] maybe the caching isn't
>> needed anymore then?
>
> I answered vs. your other mail; yes, it's still needed, [...]

I replied just now (in [1], but it's not on lore yet, maybe vger ate my
mail again).

tl;dr: Ran some quick performance numbers, and can't reproduce any
slowdown at all when instrumenting the test suite to run another
setup_git_directory() that'll do a nested lookup on pretty much every
git command, and running the test suite (you mentioned a ~5x overall
slowdown).

Anyway, I think the two replies you've got here only partially address
what I pointed out, in particular in [2]:
=20=20=20=20
    But I'm a bit iffy on a series that's structured in a way as to not
    start by asserting that we should have given semantics without the
    cache, and then adds the cache later as an optional optimization.

I.e. even if it was 10x as slow I think it should still be structured in
such a way as to at least have some GIT_TEST_* knob to turn it off in
favor of a slow path.

E.g. we've got commit-graph paths that are probably 100x or 1000x faster
than the slow path, but having the cache-less ones means we can validate
their correctness.
=20=20=20=20
> and last I checked Atharva's series had been kicked out to make room
> for this one.

Indeed, but as a comment on this proposed series that doesn't really
address this in my above-quoted ([3])

    I.e. here we've just called "git submodule--helper
    run-update-procedure", and we pass it "$sm_path" (but not "$recursive",
    but could easily do so).

I.e. my understanding is that Junio ejected Atharva's because this
seemed like the smaller change, but perhaps it wasn't realized that we'd
be adding shellscript only to remove it again?

But in any case, even if we're patching git-submodule.sh not having
Atharva's go first in its entirety doesn't answer why we can't extract
the bits he/you came up with in C for this series.

I.e. that git-submodule.sh wouldn't need that shelling out (since it
just called a helper, that helper could just return this data too),
that's just a few lines above the hunk in this series.

I.e. if some remaining performance issue I couldn't reproduce in [1] is
due to the shellscript version of this v.s. calling a C function in
libgit isn't it better to focus on closing that gap than having the
caching mechanism?

(Per the above & linked mails I'm still not 100% sure this even *is* a
caching mechanism, or if we store primary data in it, but I'm just
trying to go by your commit message descriptions).

1. https://lore.kernel.org/git/211109.86v912dtfw.gmgdl@evledraar.gmail.com/
2. https://lore.kernel.org/git/87r1cnfkqx.fsf@evledraar.gmail.com/
3. https://lore.kernel.org/git/211105.86wnlngebr.gmgdl@evledraar.gmail.com/

>>=20
>> 1. https://lore.kernel.org/git/211105.861r3vhtot.gmgdl@evledraar.gmail.c=
om/
>> 2. https://lore.kernel.org/git/20211013051805.45662-8-raykar.ath@gmail.c=
om/
>> 3. https://lore.kernel.org/git/20211013051805.45662-1-raykar.ath@gmail.c=
om/
>> 4. https://lore.kernel.org/git/YWiXL+plA7GHfuVv@google.com/

