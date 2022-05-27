Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E5E4C433EF
	for <git@archiver.kernel.org>; Fri, 27 May 2022 09:47:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350460AbiE0JrR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 May 2022 05:47:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233600AbiE0JrQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 May 2022 05:47:16 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CFAA106342
        for <git@vger.kernel.org>; Fri, 27 May 2022 02:47:14 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id gh17so7718017ejc.6
        for <git@vger.kernel.org>; Fri, 27 May 2022 02:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=bZDVCAw/5b7G/IQNG9Ime2redwy/cowABnvzm+/XzBA=;
        b=P+wO+tY5Z28utrqVPSPdsjVzQwmdrJaN3I3+abEytzp7umXeqXo7zl8vhHwhzxdcDn
         QwEM0NNcIXPO39notuD2DrjgGgukSutIxlJJdM6X9axfXIXw78+ii/PbCzK6+3gFINvi
         OUl4PbDpdhJQlm9Pg1ReTfkMJC1P0qzDnI+rl0adGCiDTDE3oMf9BCcy84D5Bm1DpCh1
         +yka7DsyhMy6yh0vD3AN5ENVnaodzZMYuqICSavICpMyVqVfOprklYxP5ByBvl0tELJF
         wM5eoiYOnqAUB1hCVLkzdCJxrT3Rlb78nHIHPvr5uGZ5ltBNHibuh4Gq9GqqNe2yAoWp
         JcNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=bZDVCAw/5b7G/IQNG9Ime2redwy/cowABnvzm+/XzBA=;
        b=tzX4nNPm1xapgtcCx+yUnKzEHVTcWQ4eehT8ShtDaKtUeZzhe35x0TPZFIca8iEyuS
         jxGLUoLv+TGGDYeWEz6SRBTfWp9iWCASnn0eRN0rAa2M+BCSwmdzPEYF9RBq53f5HVPj
         bGYfZROQeGKxUtlhSnURnukLcJB9wSm1XRSF9Z+/CDX+9ykkBYdIsh5pW1uCxcfKwreT
         IZIuNPv9JXsIeTHpwZc1ut/HDTqA4ItATn7jDaV4zKYjzU9inrfYbptbmHXiPqnGut5c
         rDgeWJTgpTMTyjKA6NKV5RSXc7KQQLcfbJgDvEQtOvdo2VDdAcQz7SzskdmGP7a4yF1I
         W3QA==
X-Gm-Message-State: AOAM531uUH1h08BMlLmO3l+SU42q8uHEoDr/f31v02mNkp1132pKQCAd
        s6D4qHYiBETWUPyFGeJ9mGUqPLacof9eDw==
X-Google-Smtp-Source: ABdhPJzW6BUZSiVWhF2sPo3uHbK7czCwhwDMFv87b+Oa9UlZ9idVCJYWDO3Rpa4YKNqsYk5S4duQOg==
X-Received: by 2002:a17:906:4787:b0:6ff:34ea:d811 with SMTP id cw7-20020a170906478700b006ff34ead811mr2427991ejc.461.1653644832704;
        Fri, 27 May 2022 02:47:12 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id j20-20020a1709062a1400b006f3ef214dcdsm1293377eje.51.2022.05.27.02.47.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 May 2022 02:47:12 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nuWYp-000NOF-CQ;
        Fri, 27 May 2022 11:47:11 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] Makefile: build 'gitweb' in the default target
Date:   Fri, 27 May 2022 11:23:29 +0200
References: <20220525205651.825669-1-szeder.dev@gmail.com>
 <220526.86k0a96sv2.gmgdl@evledraar.gmail.com>
 <20220526213305.GA1707@szeder.dev>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <20220526213305.GA1707@szeder.dev>
Message-ID: <220527.861qwf489s.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, May 26 2022, SZEDER G=C3=A1bor wrote:

> On Thu, May 26, 2022 at 02:14:33AM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>>=20
>> On Wed, May 25 2022, SZEDER G=C3=A1bor wrote:
>>=20
>> > Our Makefile's default target used to build 'gitweb', though
>> > indirectly: the 'all' target depended on 'git-instaweb', which in turn
>> > depended on 'gitweb'.  Then e25c7cc146 (Makefile: drop dependency
>> > between git-instaweb and gitweb, 2015-05-29) removed the latter
>> > dependency, and for good reasons (quoting its commit message):
>> >
>> >   "1. git-instaweb has no build-time dependency on gitweb; it
>> >       is a run-time dependency
>> >
>> >    2. gitweb is a directory that we want to recursively make
>> >       in. As a result, its recipe is marked .PHONY, which
>> >       causes "make" to rebuild git-instaweb every time it is
>> >       run."
>> >
>> > Since then a simple 'make' doesn't build 'gitweb'.
>> >
>> > Luckily, installing 'gitweb' is not broken: although 'make install'
>> > doesn't depend on the 'gitweb' target, it runs 'make -C gitweb
>> > install' unconditionally, which does generate all the necessary files
>> > for 'gitweb' and installs them.  However, if someone runs 'make &&
>> > sudo make install', then those files in the 'gitweb' directory will be
>> > generated and owned by root, which is not nice.
>> >
>> > List 'gitweb' as a direct dependency of the default target, so a plain
>> > 'make' will build it.
>> >
>> > Signed-off-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
>> > ---
>> >  Makefile | 2 ++
>> >  1 file changed, 2 insertions(+)
>> >
>> > diff --git a/Makefile b/Makefile
>> > index f8bccfab5e..ee74892b33 100644
>> > --- a/Makefile
>> > +++ b/Makefile
>> > @@ -2188,6 +2188,8 @@ ifneq (,$X)
>> >  	$(QUIET_BUILT_IN)$(foreach p,$(patsubst %$X,%,$(filter %$X,$(ALL_COM=
MANDS_TO_INSTALL) git$X)), test -d '$p' -o '$p' -ef '$p$X' || $(RM) '$p';)
>> >  endif
>> >=20=20
>> > +all:: gitweb
>> > +
>> >  all::
>> >  ifndef NO_TCLTK
>> >  	$(QUIET_SUBDIR0)git-gui $(QUIET_SUBDIR1) gitexecdir=3D'$(gitexec_ins=
tdir_SQ)' all
>>=20
>> In various recent patches & some upcoming ones I plan to submit I've
>> been trying to get the runtime of a noop "make" runs down, which really
>> helps e.g. with "git rebase -x make ..." running faster on a large
>> series.
>>=20
>> While you're right that this wasn't intentional to begin with, we have
>> lacked the "gitweb" as part of the default target since v2.4.5 now, and
>> adding it back is a major performance regression on noop "make" runs:
>
> I think that generating stuff, potentially as root, during 'make
> install' is a more severe regression, than this noop make slowdown,
> which in practice tends to be lost in the noise anyway.

It really isn't lost in the noise, e.g. a common use-case of mine is to
have let's say a 10 patch series that I want to frequently run a spot
check like this on:

    git rebase -i -x 'make'

On my system before your patch (this is with my config.mak, so it has
e.g. NO_TCLTK=3DY) it's ~105ms per run, with your change ~200ms[1].
=09
So that's 1s before of "make" overhead, now 2s. Is it the end of the
world? No, but it does add up. In particular with ccache we can end up
mostly spending time on make itself deciding what it's going to do.

For comparison running EDITOR=3Dcat git rebase -i -x 'echo make' HEAD~10
takes around 100ms in total for me.

> unrealistic case (it doesn't modify any C source files explicitly, let
> alone a frequently included header file) like this:

Yeah that's fair, of course no-op runs are where it matters the
most. But e.g. for forcing a hook.c change (including re-linking "git")
it's 10% slower[2] overall if we use ccache.

>   $ git checkout fddc3b420f^
>   $ make
>   [...]
>   $ for i in {1..10} ; do git commit --allow-empty -q -m $i ; done
>   $ time git rebase -x 'make -j8 NO_TCLTK=3DY >/dev/null' HEAD~10
>   [...]
>   real	0m31.026s
>   user	0m46.897s
>   sys	0m11.492s
>   $ git checkout fddc3b420f
>   $ for i in {1..10} ; do git commit --allow-empty -q -m $i ; done
>   $ time git rebase -x 'make -j8 NO_TCLTK=3DY >/dev/null' HEAD~10
>   [...]
>   real	0m30.865s
>   user	0m48.315s
>   sys	0m12.125s
>
> Hrm, it actually ended up slightly faster.

I should have said that I create a "version" file in my checkout dir,
e.g.: 2.36.GIT-dev

Otherwise you end up with a guarnteed recompile-re-link every time HEAD
changes, so it's likely lost in that noise.

I just run this (via a script):

    echo $(/usr/bin/git grep -h -o -P '(?<=3D^DEF_VER=3Dv).*' 'HEAD:GIT-VER=
SION-GEN')-dev

And echo it to the top-level "version". Aside from what we're discussing
here you might want to try that, your "git version" won't be correct,
but for that low cost (I do generate it for the version I actually
install) you'll get actual no-op runs in the case of e.g. only modifying
tests.

>> 	$ git hyperfine -L rev HEAD~1,HEAD~0 -L t Y, -s 'make' 'make NO_TCLTK=
=3D{t}' --warmup 1 -r 5
>> 	Benchmark 1: make NO_TCLTK=3DY' in 'HEAD~1
>> 	  Time (mean =C2=B1 =CF=83):     103.6 ms =C2=B1   1.1 ms    [User: 83.=
8 ms, System: 32.1 ms]
>> 	  Range (min =E2=80=A6 max):   102.2 ms =E2=80=A6 105.2 ms    5 runs
>>=20=09=20
>> 	Benchmark 2: make NO_TCLTK=3DY' in 'HEAD~0
>> 	  Time (mean =C2=B1 =CF=83):     191.4 ms =C2=B1   1.6 ms    [User: 151=
.0 ms, System: 60.5 ms]
>> 	  Range (min =E2=80=A6 max):   189.2 ms =E2=80=A6 193.3 ms    5 runs
>>=20=09=20
>> 	Benchmark 3: make NO_TCLTK=3D' in 'HEAD~1
>> 	  Time (mean =C2=B1 =CF=83):     272.0 ms =C2=B1   5.0 ms    [User: 206=
.3 ms, System: 83.3 ms]
>> 	  Range (min =E2=80=A6 max):   266.7 ms =E2=80=A6 277.3 ms    5 runs
>>=20=09=20
>> 	Benchmark 4: make NO_TCLTK=3D' in 'HEAD~0
>> 	  Time (mean =C2=B1 =CF=83):     358.3 ms =C2=B1   1.4 ms    [User: 282=
.7 ms, System: 104.0 ms]
>> 	  Range (min =E2=80=A6 max):   356.6 ms =E2=80=A6 360.0 ms    5 runs
>>=20=09=20
>> 	Summary
>> 	  'make NO_TCLTK=3DY' in 'HEAD~1' ran
>> 	    1.85 =C2=B1 0.02 times faster than 'make NO_TCLTK=3DY' in 'HEAD~0'
>> 	    2.63 =C2=B1 0.06 times faster than 'make NO_TCLTK=3D' in 'HEAD~1'
>> 	    3.46 =C2=B1 0.04 times faster than 'make NO_TCLTK=3D' in 'HEAD~0'
>>=20
>> I.e. this is with your patch here applied as HEAD~0 and HEAD~1 being
>> 'master'.
>>=20
>> I think given that that a better solution would be to just declare this
>> as a feature at this point
>
> As long as 'make install' installs 'gitweb', I don't think that's an
> option.

Yes, I'm not saying that we shouldn't fix this no matter what, but just
suggesting that perhaps we come up with a better solution.

>> especially as gitweb/INSTALL notes that the
>> way to install it is:
>>=20
>>         $ make prefix=3D/usr gitweb                            ;# as you=
rself
>>         # make gitwebdir=3D/var/www/cgi-bin install-gitweb     ;# as root
>
> Or are you suggesting not to install 'gitweb' during 'make install'?
> I'm fine with that, but I doubt I will argue about it convincingly in
> a commit message.

We could also:

 * $(error out if install is in MAKECMDGOALS and we don't have those
   generated files, that's a few-line ifdef change to the Makefile,
   "build it first".

 * Just fold gitweb/Makefile into the top-level Makefile

>> Or we could just fold gitweb/Makefile into the main Makefile, unlike
>> gitk and git-gui it's not externally maintained, and most of it is
>> shimmying to work around not being part of the main Makefile (which it
>> strongly inter-depends on anyway).

1.
	$ git hyperfine  -L rev HEAD~1,HEAD~0 -s 'make' 'make'
	Benchmark 1: make' in 'HEAD~1
	  Time (mean =C2=B1 =CF=83):     106.9 ms =C2=B1   1.3 ms    [User: 86.0 m=
s, System: 33.1 ms]
	  Range (min =E2=80=A6 max):   105.3 ms =E2=80=A6 110.2 ms    27 runs
=09
	Benchmark 2: make' in 'HEAD~0
	  Time (mean =C2=B1 =CF=83):     199.6 ms =C2=B1   2.5 ms    [User: 162.7 =
ms, System: 57.3 ms]
	  Range (min =E2=80=A6 max):   197.4 ms =E2=80=A6 207.4 ms    15 runs
=09
	Summary
	  'make' in 'HEAD~1' ran
	    1.87 =C2=B1 0.03 times faster than 'make' in 'HEAD~0'
2.
=09
	$ git hyperfine -L rev HEAD~1,HEAD~0 -s 'make' 'make -W hook.c NO_TCLTK=3D=
Y CC=3D"ccache cc"' --warmup 1 -r 5
	Benchmark 1: make -W hook.c NO_TCLTK=3DY CC=3D"ccache cc"' in 'HEAD~1
	  Time (mean =C2=B1 =CF=83):     742.7 ms =C2=B1   7.1 ms    [User: 1965.5=
 ms, System: 561.6 ms]
	  Range (min =E2=80=A6 max):   730.3 ms =E2=80=A6 748.2 ms    5 runs
=09=20
	Benchmark 2: make -W hook.c NO_TCLTK=3DY CC=3D"ccache cc"' in 'HEAD~0
	  Time (mean =C2=B1 =CF=83):     819.2 ms =C2=B1   7.4 ms    [User: 2013.9=
 ms, System: 583.3 ms]
	  Range (min =E2=80=A6 max):   811.0 ms =E2=80=A6 830.0 ms    5 runs
=09=20
	Summary
	  'make -W hook.c NO_TCLTK=3DY CC=3D"ccache cc"' in 'HEAD~1' ran
	    1.10 =C2=B1 0.01 times faster than 'make -W hook.c NO_TCLTK=3DY CC=3D"=
ccache cc"' in 'HEAD~0'
=09
