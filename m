From: Jan Hudec <bulb@ucw.cz>
Subject: Re: [Qgit RFC] commit --amend
Date: Mon, 2 Jul 2007 20:03:09 +0200
Message-ID: <20070702180309.GA4400@efreet.light.src>
References: <20070610150839.GG4084@efreet.light.src> <e5bfff550706101510x6d685944ja70c9d9dbb3668f6@mail.gmail.com> <20070611044258.GJ4084@efreet.light.src> <e5bfff550706102245p27aea579w65ee96161630a624@mail.gmail.com> <20070701122625.GC26243@efreet.light.src> <e5bfff550707010909p4eba184ekff2025fb158a4aee@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oyUTqETQ0mS9luUI"
Cc: git@vger.kernel.org
To: Marco Costalba <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 02 20:03:21 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5QF7-00054X-8h
	for gcvg-git@gmane.org; Mon, 02 Jul 2007 20:03:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752802AbXGBSDS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 Jul 2007 14:03:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752566AbXGBSDS
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jul 2007 14:03:18 -0400
Received: from ns1.bluetone.cz ([212.158.128.13]:32834 "EHLO ns1.bluetone.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751822AbXGBSDR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jul 2007 14:03:17 -0400
Received: from localhost (spamhole.bluetone.cz [192.168.13.2])
	by ns1.bluetone.cz (Postfix) with ESMTP id B2297572B8;
	Mon,  2 Jul 2007 20:03:15 +0200 (CEST)
Received: from ns1.bluetone.cz ([192.168.13.1])
	by localhost (spamhole.bluetone.cz [192.168.13.2]) (amavisd-new, port 10026)
	with ESMTP id BMD7fSBXJbIb; Mon,  2 Jul 2007 20:03:13 +0200 (CEST)
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145])
	by ns1.bluetone.cz (Postfix) with ESMTP id F052257298;
	Mon,  2 Jul 2007 20:03:12 +0200 (CEST)
Received: from bulb by efreet.light.src with local (Exim 4.67)
	(envelope-from <bulb@ucw.cz>)
	id 1I5QEv-0001kp-P7; Mon, 02 Jul 2007 20:03:09 +0200
Content-Disposition: inline
In-Reply-To: <e5bfff550707010909p4eba184ekff2025fb158a4aee@mail.gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51390>


--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 01, 2007 at 18:09:37 +0200, Marco Costalba wrote:
> [...]
> QGit::run() and QGit::runAsync()
> [...]
>
> A bool is the only flag returned, because error detect is done at
> lower level, in MyProcess::sendErrorMsg() in file myprocess.cpp that
> handles the low level of running an external process and is called by
> run().
>
> In case of an error MyProcess::sendErrorMsg() is called to inform the
> GUI (a popup dialog box) about the error and the stderr output
> received.

Thanks. That's the bit I didn't see in MyProcess. Ok, so I'll simply return
=66rom the function when some of the run()s return false.

> [...]
> Hope this helps.

Thanks.

> P.S: Why 'git-commit --amend -F' it's explicitely forbidden?

The logic for preparing the commit message seems to be incompatible in
git-commit.sh for some reason and whoever wrote it fobode those flags
together instead of making it compatible. In any case, the error is reported
in git-commit.sh:291-296:

case "$log_given" in
tt*)
	die "Only one of -c/-C/-F/--amend can be used." ;;
*tm*|*mt*)
	die "Option -m cannot be combined with -c/-C/-F/--amend." ;;
esac

And in any case the git policy is, that frontends should not be using
porcelain commands. What I would really like to see is something between
git-commit and git-commit-tree, that would:
 - run pre-commit hook
 - write-tree
 - commit-tree
 - update-ref
 - rerere
 - run post-commit hook
But it does not exist and git-gui obviously does that manually, so I did it
manually as well. Now I have to test it.

The other thing that didn't work (or at least from reading the code it seems
it couldn't) is commiting merges, because when commiting merge, filename
arguments are forbidden on git-commit.

Commiting merges will require some special handling, because you have to at
least commit all files that were merged. And you can't re-create pristine
index with read-tree the way normal commit does it either.

Unfortunately I don't fully understand -- and remember the right commands f=
or
working with it -- the multi-stage index.

--=20
						 Jan 'Bulb' Hudec <bulb@ucw.cz>

--oyUTqETQ0mS9luUI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGiT3dRel1vVwhjGURAjzoAKCaGh4REh8X680hyYRrlwr6VOZflQCfX347
tOnTmp+9Inp7jj4s5NCtPgc=
=/Iy8
-----END PGP SIGNATURE-----

--oyUTqETQ0mS9luUI--
