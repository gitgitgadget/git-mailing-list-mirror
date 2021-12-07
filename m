Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7071C433F5
	for <git@archiver.kernel.org>; Tue,  7 Dec 2021 07:14:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbhLGHSW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Dec 2021 02:18:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbhLGHSU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Dec 2021 02:18:20 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1532C061746
        for <git@vger.kernel.org>; Mon,  6 Dec 2021 23:14:50 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1muUgY-0001mI-Ax; Tue, 07 Dec 2021 08:14:46 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1muUgY-003B3K-9w; Tue, 07 Dec 2021 08:14:45 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1muUgX-0001hu-3s; Tue, 07 Dec 2021 08:14:45 +0100
Date:   Tue, 7 Dec 2021 08:14:42 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?utf-8?B?QmrDtnJuIEzDpHNzaWc=?= <b.laessig@pengutronix.de>
Subject: Re: Regression in 8d92fb292706 ("dir: replace exponential algorithm
 with a linear one")
Message-ID: <20211207071442.ajkcl5hpwwbze2lx@pengutronix.de>
References: <20211206121639.o4a4tdzlijnhnjqz@pengutronix.de>
 <CABPp-BEEpboXxs6dghCagj2oXkXKX9aNQGLmUmQRa5m3jj2--w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="iett5ubrmf2b7xdn"
Content-Disposition: inline
In-Reply-To: <CABPp-BEEpboXxs6dghCagj2oXkXKX9aNQGLmUmQRa5m3jj2--w@mail.gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--iett5ubrmf2b7xdn
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

first of all thanks for addressing my report, also to brian.

On Mon, Dec 06, 2021 at 09:29:59PM -0800, Elijah Newren wrote:
> On Mon, Dec 6, 2021 at 4:16 AM Uwe Kleine-K=F6nig
> <u.kleine-koenig@pengutronix.de> wrote:
> > I admit this is somewhat of a corner case, still it happens in the
> > reality of our admin team ...
> > Initially this was noticed after upgrading the OS from Debian buster
> > (with git 2.20.1) to Debian bullseye (with git 2.30.2).
> >
> > (wgit is just a wrapper for git to call it from my ~/src/git.)
> >
> > This is the good ("old") case:
> >
> >         uwe@taurus:~/tmp/8d92fb29270$ wgit version
> >         git version 2.25.2.7.g0bbd0e8b5233
> >
> >         uwe@taurus:~/tmp/8d92fb292706$ wgit init
> >         Initialized empty Git repository in /home/uwe/tmp/8d92fb292706/=
=2Egit/
> >
> >         uwe@taurus:~/tmp/8d92fb292706$ mkdir subdir
> >         uwe@taurus:~/tmp/8d92fb292706$ cd subdir/
> >         uwe@taurus:~/tmp/8d92fb292706/subdir$ wgit init
> >         Initialized empty Git repository in /home/uwe/tmp/8d92fb292706/=
subdir/.git/
> >         uwe@taurus:~/tmp/8d92fb292706/subdir$ cd ..
> >
> >         uwe@taurus:~/tmp/8d92fb292706$ echo content > subdir/somefile
> >         uwe@taurus:~/tmp/8d92fb292706$ wgit add subdir/somefile
> >         uwe@taurus:~/tmp/8d92fb292706$ wgit status
> >         On branch master
> >
> >         No commits yet
> >
> >         Changes to be committed:
> >           (use "git rm --cached <file>..." to unstage)
> >                 new file:   subdir/somefile
>=20
> Eek, that's bad.  I think there's a number of dragons going down that rou=
te.

Yes, as soon as you start to checkout files in one of the involved
repositories you implicitly change the other one. In this case git is
only used to track files in /etc and elsewhere, and there are two
mechanisms to track them. (Don't ask for the reasons, I don't know them.
:-) In this setup (I think) the dragons should be well fixed to their
chains.

> > with 8d92fb292706, the following happens:
> >
> >         uwe@taurus:~/tmp/8d92fb292706$ wgit version
> >         git version 2.25.2.8.g8d92fb292706
> >         uwe@taurus:~/tmp/8d92fb292706$ wgit init
> >         Initialized empty Git repository in /home/uwe/tmp/8d92fb292706/=
=2Egit/
> >         uwe@taurus:~/tmp/8d92fb292706$ mkdir subdir
> >         uwe@taurus:~/tmp/8d92fb292706$ cd subdir/
> >         uwe@taurus:~/tmp/8d92fb292706/subdir$ wgit init
> >         Initialized empty Git repository in /home/uwe/tmp/8d92fb292706/=
subdir/.git/
> >         uwe@taurus:~/tmp/8d92fb292706/subdir$ cd ..
> >         uwe@taurus:~/tmp/8d92fb292706$ echo content > subdir/somefile
> >         uwe@taurus:~/tmp/8d92fb292706$ wgit add subdir/somefile
>=20
> Not optimal; more on this below.
>=20
> >         uwe@taurus:~/tmp/8d92fb292706$ wgit status
> >         On branch master
> >
> >         No commits yet
> >
> >         Untracked files:
> >           (use "git add <file>..." to include in what will be committed)
> >                 subdir/
> >
> >         nothing added to commit but untracked files present (use "git a=
dd" to track)
>=20
> This part looks good to me.
>=20
> > So git after 8d92fb292706 doesn't add files from a subdirectory if
> > said subdirectory is tracked in git, too.
> >
> > While I'm not sure which of the two behaviours is the bogus one, this is
> > a change in behaviour that I guess wasn't intended in 8d92fb292706.
>=20
> I put some effort separate from that commit into avoiding accidentally
> recursing into nested git dirs; see e.g. commit 09487f2cba ("clean:
> avoid removing untracked files in a nested git repository",
> 2019-09-17).  So, I was slightly surprised that some other commit
> hadn't fixed this.
>=20
> However, it's not all that surprising to me that 8d92fb292706 affected
> this.  Prior to that commit, we visited untracked paths which were n
> directories deep a ridiculous 2^n times.  But what made it even more
> fun was that the status returned for any given path (tracked, ignored,
> not interesting to the traversal, etc.) was not always the same; later
> traversals might return something different than earlier traversals.
> That confusion made it real "fun" trying to ensure no regressions when
> reducing the number of visits to any given path from 2^n down to 1.
> The fact that side effects of the traversals (the population of the
> dir.entries and dir.ignored) could have essentially functioned to
> override a later traversal's return status certainly didn't help; it
> was such a mess.
>=20
> But, interestingly, the fixed behavior here also depends pretty
> strongly on commit b9670c1f5e ("dir: fix checks on common prefix
> directory", 2019-12-19) which came months earlier.  This is
> particularly important in combination with the following comment from
> dir.h:
>     /**
>      * If set, recurse into a directory that looks like a Git directory.
>      * Otherwise it is shown as a directory.
>      */
>     DIR_NO_GITLINKS =3D 1<<3,
> which suggests that cmd_add() (which didn't set this flag) should have
> never been recursing into a Git-tracked directory.  In other words,
> this was a bug all along.
>=20
> > Is this something that needs fixing?
>=20
> I agree with brian elsewhere in this thread that not adding the file
> is correct.  However, two points:
>=20
> * I would prefer to see a warning/error from git add when it doesn't
> add a path  (Any takers?  #leftoverbits maybe?)

Agreed, also maybe return an exit code !=3D 0?

> * It is possible that one might want to be able to force the addition
> of files to an outer repository despite existing within a directory
> tracked by an inner git repository, perhaps with a double `--force`
> being passed to git-add (much like git-clean allows).  If so, that
> could be implemented via the addition of
>     dir.flags |=3D DIR_NO_GITLINKS;
> to cmd_add() when the double force is detected.

I think this would be good.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--iett5ubrmf2b7xdn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmGvCd4ACgkQwfwUeK3K
7AkToQgAneUodj/UByAgQ5T18AUPITsoJE0U1OOyvfSBdVmYwbaKxHnD6FQI4f7b
d4u5etCUGSwWfjP2wdWI22V5oSu7Mt3OPK2AK6qzUH7ktwsZq/bkCyIH9Eq1VQWa
VXty+U1+7u/+9u0vmTtbfS0kMFqRqClX1D4CogjHMkG1abWXZyutsLDQdFOBH97b
o7z8RwgHFJ/GRMTiFeulWagP3aT/y+hgN08zXuZVXoun+35ka5ILNSAqEFDsEeuA
3Va4yybFjb60n17+STJWIIB0tsDVUY9Fyk6/1akQ/Bo0cCZ/N2fAoHFG7SCuLao1
gyXPipZ8vJLgjjrrUI7gJVXEu3TCMQ==
=aaZs
-----END PGP SIGNATURE-----

--iett5ubrmf2b7xdn--
