From: "R. Tyler Ballance" <tyler@slide.com>
Subject: Re: [PATCH/RFC] Allow writing loose objects that are corrupted in
 a pack file
Date: Wed, 07 Jan 2009 14:55:35 -0800
Organization: Slide, Inc.
Message-ID: <1231368935.8870.584.camel@starfruit>
References: <20081209093627.77039a1f@perceptron>
	 <1231282320.8870.52.camel@starfruit>
	 <alpine.LFD.2.00.0901062005290.26118@xanadu.home>
	 <1231292360.8870.61.camel@starfruit>
	 <alpine.LFD.2.00.0901062026500.3057@localhost.localdomain>
	 <1231314099.8870.415.camel@starfruit>
	 <alpine.LFD.2.00.0901070743070.3057@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-CwEFambY2vLdpkOpqsBU"
Cc: Nicolas Pitre <nico@cam.org>,
	Jan =?ISO-8859-1?Q?Kr=FCger?= <jk@jk.gs>,
	Git ML <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Jan 07 23:57:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKhKp-0005l0-FX
	for gcvg-git-2@gmane.org; Wed, 07 Jan 2009 23:57:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754540AbZAGWzq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jan 2009 17:55:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753478AbZAGWzq
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Jan 2009 17:55:46 -0500
Received: from mx0.slide.com ([208.76.68.7]:43186 "EHLO mx0.slide.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753313AbZAGWzp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jan 2009 17:55:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=slide.com; s=slideinc; h=Subject:From:To:Date:Message-Id; bh=V
	1fAmYEuh1RRYOMp0UZY4k9GI713qfW1+vUbjxq4Msg=; b=Zhf0QcCq2DaSOFKIr
	mGdwX6vSwxcEKl0ip9ClsAXPhXHSzWB2N8t20A4U2x6YXQ1ac+Ewt0G+9Qh1AShZ
	IrcuyBtzHB2kpDxnUu1oPzmRL/joL8h1kCrCqQT0oqBJNJMR8p7vwKcfvgYE1y0o
	3kSKdYYH5PwCP/SsQTO1fWRljE=
Received: from nat3.slide.com ([208.76.69.126]:35374 helo=calculon.corp.slide.com)
	by mx0.slide.com with esmtp (Exim 4.69 #1)
	id 1LKhJI-0001g2-T0; Wed, 07 Jan 2009 14:55:36 -0800
Received: from localhost (localhost.localdomain [127.0.0.1])
	by calculon.corp.slide.com (Postfix) with ESMTP id D9A1E3899037;
	Wed,  7 Jan 2009 14:55:36 -0800 (PST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -3.701
X-Spam-Level: 
X-Spam-Status: No, score=-3.701 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, AWL=-0.698, BAYES_00=-2.599,
	MIME_QP_LONG_LINE=1.396]
Received: from calculon.corp.slide.com ([127.0.0.1])
	by localhost (calculon.corp.slide.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SGoaQ4T3KQSN; Wed,  7 Jan 2009 14:55:36 -0800 (PST)
Received: from [10.10.8.190] (dhcp-10-10-8-190.corp.slide.com [10.10.8.190])
	by calculon.corp.slide.com (Postfix) with ESMTP id AB9BF3898BB3;
	Wed,  7 Jan 2009 14:55:36 -0800 (PST)
In-Reply-To: <alpine.LFD.2.00.0901070743070.3057@localhost.localdomain>
X-Mailer: Evolution 2.24.1.1 
X-Content-Bypass: Bypassed by sending host IP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104843>


--=-CwEFambY2vLdpkOpqsBU
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2009-01-07 at 08:07 -0800, Linus Torvalds wrote:
> Well, that's not necessarily "unfortunate". It does actually end up=20
> showing that the objects themselves were apparently never really corrupt.
>=20
> So there is no fundamental data structure corrupttion - because when you=20
> copy the repository, it's all good agin!
>  - it could be some _temporary_ git corruption caused internally inside a=
=20
>    git process - ie a wild pointer, or perhaps a race condition (but we=20
>    don't really use threading in 1.6.0.4 unless you ask for it, and even=20
>    then just for pack-file generation)

I have a feeling it's something like this, one of our operations guys
did some research while I was looking at code and he came across this:

        On Wed, 2009-01-07 at 14:17 -0800, Ken Brownfield wrote:
        git-merge is using too much RAM, and failing to malloc() but
        NOT =20
        > reporting it.  This is all sorts of bad:
        >=20
        >   A) using an unscalable amount of RAM
        >   B) failing to detect malloc() failure
        >   C) reporting file corruption instead
        > I was able to reproduce this.
        >
        > limit ~1.5GB -> corrupt file
        > limit ~3GB -> magically no longer corrupt.
        >
        > The false fail may be limited to git-merge, but git status also =20
        > allocates the same amount of RAM.
        >=20
        > To temporarily work around this problem, issue this once you
        log in to =20
        > a dev box:
        >=20
        > tcsh:
        >         limit vmemoryuse 3000000
        > bash:
        >         ulimit -v 3000000
        >=20
        > Be gentle.
       =20

> And quite frankly, since the corruption seems to be site-specific, I=20
> really do suspect the second case. Although it's possible, of course, tha=
t=20
> it could be some compiler issue that makes _your_ binaries have issues=20
> even when nobody else sees it.

I think you're correct insofar that our major site-specific alteration
has come up on the mailing list before (okay maybe two site-specific
things).=20
	* Our Git repo is ~7.1GB
	* ulimit -v is set to ~1.5G


I think I know how this could be failing and corrupting things (assuming
it's malloc(2)) related.


What I'm thinking is that in xmalloc() or one of the other x*)_
functions, the malloc(size) is failing because of the ulimits, and then
the potentially somewhere it's silently failing or maybe even
accidentally returning one of those "malloc(1)" pointers?

I've got two new tarred repositories from two developers the issue
happened to today, so I'm flush full of sample repositories to try stuff
on :)


>=20
> Hmm. That's actually _normal_ under some circumstances. At least with=20
> older git versions, or if your .git/index file couldn't be rewritten for=20
> some reason - your existing index file contains all the old stat=20
> information, and if git cannot (or, in the case of older git version, jus=
t=20
> will not) refresh it automatically, it will show all the files as changed=
,=20
> even if it's just the inode number that really changed.
>=20
> A _normal_ git install should have auto-refreshed the index, though.=20
> Unless the tar archive only contained the ".git" directory, and not the=20
> checkout?

I believe the issues I noticed when untarring the repo were a red
herring, I did the `git diff` after untarring and I noticed that only a
certain set of files where changed, I'm willing to go so far as to guess
that they were the files affected in the corrupted packs. Of the 32k
files in our repository, 98 were actually different after untarring
(according to git-diff(1))

> And dobody else saw it than this one person, and it was a total mystery t=
o=20
> everybody until we realized that he used this one feature that nobody els=
e=20
> was using. So as you're on OS X, I assume you don't have CRLF conversion,=
=20
> but maybe you use some other feature that we support but nobody really=20
> actually uses. Like keyword expansion or something?

The two new folks this happened to today had nothing "special" about
them other than the ulimit.


I've got the script(1) output of performing git-ls-files(1) and some
other commands that I tried, nothing they output was particular
informative or interesting, and I don't think it will help if this
really is a memory related issue, that said I'd be more than happy to
send it to a couple of you (Junio, Linus, Nico).


I'm *so* ready for this bug to die >=3D\


Cheers

--=20
-R. Tyler Ballance
Slide, Inc.

--=-CwEFambY2vLdpkOpqsBU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkllMucACgkQFCbH3D9R4W9UDQCdEP6z6nHXiRAjjSxrkWliGECk
hTUAniC0ruDQf70ltzt38qX/cCqm8/ys
=dPNX
-----END PGP SIGNATURE-----

--=-CwEFambY2vLdpkOpqsBU--
