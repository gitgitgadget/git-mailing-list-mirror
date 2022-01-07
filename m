Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06C32C433F5
	for <git@archiver.kernel.org>; Fri,  7 Jan 2022 18:23:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240720AbiAGSXF (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Jan 2022 13:23:05 -0500
Received: from mout.gmx.net ([212.227.17.21]:34347 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240395AbiAGSXF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jan 2022 13:23:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1641579782;
        bh=orkwxo3DjV52RLF3CZgHYO6oqUpuKJomfI7ECQuC8fU=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=PLuwmfkyFbJs0NbKRLCzpFELcxWgPlzfraWsgu34QpzcQ2hvxV+mLsO5WDzJUCgVz
         dG++DcooyCh1qT+2dd2rlWsy7F/AT9FmoPkZda9jtI6aFIbi67tmXZERoA5CYt73Mq
         BunUkyFN4WLu8sGBZE/IzV1cdgnPcXgfVqImIHMk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.25.133.218] ([89.1.215.56]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MPokN-1mkoXW3N0F-00MpSA; Fri, 07
 Jan 2022 19:23:01 +0100
Date:   Fri, 7 Jan 2022 19:22:57 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Elijah Newren <newren@gmail.com>
cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Altmanninger <aclopte@gmail.com>
Subject: Re: [PATCH v2 4/8] merge-tree: implement real merges
In-Reply-To: <CABPp-BFUJ6pU_CKM7ccnFvi0nkeeGfd2GETdksKLaz=B_=BZAQ@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2201071915290.339@tvgsbejvaqbjf.bet>
References: <pull.1114.git.git.1640927044.gitgitgadget@gmail.com> <pull.1114.v2.git.git.1641403655.gitgitgadget@gmail.com> <1710ba4a9e432e2a854579c4c929e7f2cfc92211.1641403655.git.gitgitgadget@gmail.com> <nycvar.QRO.7.76.6.2201071602110.339@tvgsbejvaqbjf.bet>
 <CABPp-BFUJ6pU_CKM7ccnFvi0nkeeGfd2GETdksKLaz=B_=BZAQ@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:yaNkTTgGNpUEhTjdm9+VjCoYkionvikm/h7oYqDUdXGGlhN3zAh
 5BhHfU37HGwUQrbKCD3PdBPLUL3UBTgk4T1HeYcp6KteHqhnkv9wYw8e5K1RJKHT2tz3DPI
 V22Q+0blfLHQ9MZjWTB9jOPfLLWJwa9wUmFHb8AAmcALrhRIytD5NoM6E1k36raE/ZWOnOs
 a86KQ9FIw25r0n6chFhnw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:d6H2XYLNkvI=:KO95rHOvaLIGIo4zloDxRU
 WtsywtpzpBAmeh5dGYEv7I0hrBFP4G7Jr55K60z64SSHaHhMkBP6qlTKGC3J2daMdMXz4IbkR
 sruIYI3BLWq03bXiihxBScYLYKYKce/1m2rWgdobX5heY/xhsz8fk9VrGu2Ny99ZQbA02WIDX
 gkFZi/F7nM2nIGSk5CXk+PLmlf/TgXETL8RWDMYs9jzHtB6w9lf0wTMIByWvrIIi+UvTxEwIJ
 cQmDIbwgJtXRwKSYmm29d6f6iIkE3lqSi0iBhuin/ZnagfCv1rDEvKDOxGgWP8nJ3fc2Cp4I0
 5Kt5AHjAMiNsBnJYei8bf1RNWYQpAs09IE8/JUqfAwbobTDhrrV9yznKr/VhfbSGfJLcniya4
 k2P+X+R8B5OmgfI5y70yNaCIzoXc6/GhXncu/FsvNfa/7f1hH3XWs/R4Q3TwwT5zlqouGS4ko
 S24ciMNKsxvrBiUqEpMR4UOzvRTmARwEr0TlW5UB+NGEkcTGJpb8HbbYgLdcCg0KU9Z36E83u
 awuUAKMULiDKy9FwnZpox8ET6UgEjyKZJ9LpNoUEnFzsq/leDmRoz3HETwUDSGKa6TQiXHXsz
 JxkPoZtDCGol+cSwE7YI6xB7lYnHeOyYBSdGL8adu6kMV/iIM7n8Y3XWO4otvR3S+1G+GWALn
 kLy+gio69FwmEZhNoPVwmx4vXNe8FXxSLsdfRRJ4JUbMGf8URghees5tqyVPCftEz2hlaq+fb
 ZejRRY11FO32Uz/D3Yi3eu/x5zU/JCRg9t34WcOhfDDZ5sjlC4vfK5SBzrKm8TSFasxJpTFkz
 Kd94/htn5fLCArZSr5dilfIjjUseaqFfgW9qYzyMhndTioPkVniHo4eKS6Fgyog7ZXmD4WyrC
 P2MPIMRJyTxIWR1GKmqa5qBHcqBDTkYBjgPrzHTq8MflyQuzFornAQtawV6o+E+AcPPZegyN5
 d8xSho4vdQadHzrqfbaptRIbrslCBEZODYXszF8nO6B3rn7Mtn1F9aMEmflOz2H6YlOhkne4S
 V/Gsn2VBY7ZUlaM2L832g36UAAJxX1ej805ZMgDEUQ1Us8aBjsSEdIMP29Or/sZSD2upKV8zp
 Ao+6H/X6ddHG4g=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,


On Fri, 7 Jan 2022, Elijah Newren wrote:

> On Fri, Jan 7, 2022 at 7:30 AM Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >
> > On Wed, 5 Jan 2022, Elijah Newren via GitGitGadget wrote:
> >
> > >  SYNOPSIS
> > >  --------
> > >  [verse]
> > > +'git merge-tree' --real <branch1> <branch2>
> > >  'git merge-tree' <base-tree> <branch1> <branch2>
> >
> > Here is an idea: How about aiming for this synopsis instead, exploitin=
g
> > the fact that the "real" mode takes a different amount of arguments?
>
> My turn on the grammar thing: s/amount/number/.   :-)

See? I know why I'm refraining from nitpicking. It's just not good for
anyone involved.

> > > diff --git a/t/t4301-merge-tree-real.sh b/t/t4301-merge-tree-real.sh
> > > new file mode 100755
> > > index 00000000000..f7aa310f8c1
> > > --- /dev/null
> > > +++ b/t/t4301-merge-tree-real.sh
> > > @@ -0,0 +1,81 @@
> > > +#!/bin/sh
> > > +
> > > +test_description=3D'git merge-tree --real'
> > > +
> > > +. ./test-lib.sh
> > > +
> > > +# This test is ort-specific
> > > +GIT_TEST_MERGE_ALGORITHM=3Dort
> > > +export GIT_TEST_MERGE_ALGORITHM
> >
> > It might make sense to skip the entire test if the user asked for
> > `recursive` to be tested:
> >
> >         test "${GIT_TEST_MERGE_ALGORITHM:-ort}" =3D ort ||
> >                 skip_all=3D"GIT_TEST_MERGE_ALGORITHM !=3D ort"
> >                 test_done
> >         }
>
> The idea makes sense, but it took me a bit to understand this code
> block.  I think you're just missing an opening left curly brace right
> after the '||'?

Yes. Sorry.

> > > +test_expect_success setup '
> > > +     test_write_lines 1 2 3 4 5 >numbers &&
> > > +     echo hello >greeting &&
> > > +     echo foo >whatever &&
> > > +     git add numbers greeting whatever &&
> > > +     git commit -m initial &&
> >
> > I would really like to encourage the use of `test_tick`. It makes the
> > commit consistent, just in case you run into an issue that depends on =
some
> > hash order.
>
> I've used test_tick before, but I already know this test can't depend
> on hash order.  Further, the hashes in the output are also replaced
> before comparing in order to make the tests also work as-is under
> sha256.  So the tests are explicitly ignoring precise hashes.  As
> such, I'm not sure I see the value of test_tick here.

Nevertheless. To make comparing logs of two different test runs easier, it
makes more sense to insist on consistency.

> > > +
> > > +     git branch side1 &&
> > > +     git branch side2 &&
> > > +
> > > +     git checkout side1 &&
> >
> > Please use `git switch -c side1` or `git checkout -b side1`: it is mor=
e
> > compact than `git branch ... && git checkout ...`.
>
> Yes, but less forgiving to later modification where I go and add
> additional commits on one of the sides, because...
>
> >
> > > +     test_write_lines 1 2 3 4 5 6 >numbers &&
> > > +     echo hi >greeting &&
> > > +     echo bar >whatever &&
> > > +     git add numbers greeting whatever &&
> > > +     git commit -m modify-stuff &&
> > > +
> > > +     git checkout side2 &&
> >
> > This could be written as `git checkout -b side2 HEAD^`, to make the se=
tup
> > more succinct.
>
> ...the presumption of HEAD^ is hardcoded and has to be parsed by
> readers to understand the test.  It felt like more cognitive overhead
> to me, in addition to being less malleable.

Right. Different developers, different preferences. I wish we had a
standard way in the test suite to initialize a test setup that _everybody_
could agree to be succinct and helpful. So far, we use shell scripted Git
commands to recreate an initial commit topology, but especially when
comparing to existing test suites with fixtures that are not only
well-documented but also easy to wrap your head around, I find Git's test
suite awfully lacking. Mind you, the code _I_ introduced isn't stellar in
this respect, either, not by a very far stretch.

> > > +test_expect_success 'Barf on misspelled option' '
> > > +     # Mis-spell with single "s" instead of double "s"
> > > +     test_expect_code 129 git merge-tree --real --mesages FOOBAR si=
de1 side2 2>expect &&
> > > +
> > > +     grep "error: unknown option.*mesages" expect
> > > +'
> >
> > I do not think that this test case adds much, and we already test the
> > `parse_options()` machinery elsewhere.
>
> It's more about verifying that exit codes of 0 & 1 are reserved for
> "completed with no conflicts" and "completed with conflicts".  The 129
> bit in this test is the important bit (and perhaps is well-known to
> lots of other folks, but I thought it was worth highlighting).

Fair enough.

Ciao,
Dscho
