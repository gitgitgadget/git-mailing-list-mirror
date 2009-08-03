From: "Wesley J. Landaker" <wjl@icecavern.net>
Subject: Re: git for pushing local subdir to website
Date: Mon, 3 Aug 2009 15:48:40 -0600
Organization: icecavern.net
Message-ID: <200908031548.45112.wjl@icecavern.net>
References: <13f0168a0908031011odd98c03ye08a1b0774fca523@mail.gmail.com> <200908031258.13787.wjl@icecavern.net> <13f0168a0908031213r59a9ea61m824ca7e5209962fc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3464888.qn3bEhek9H";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Matt Di Pasquale <pasquale@fas.harvard.edu>
X-From: git-owner@vger.kernel.org Mon Aug 03 23:49:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MY5Ow-0006oV-Qh
	for gcvg-git-2@gmane.org; Mon, 03 Aug 2009 23:49:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753601AbZHCVsy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Aug 2009 17:48:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752717AbZHCVsy
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Aug 2009 17:48:54 -0400
Received: from rinoa.icecavern.net ([92.243.7.152]:51185 "EHLO icecavern.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752006AbZHCVsx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Aug 2009 17:48:53 -0400
Received: from tonberry.icecavern.net (c-76-113-110-228.hsd1.nm.comcast.net [76.113.110.228])
	by icecavern.net (Postfix) with ESMTPSA id 211FC35B4C;
	Mon,  3 Aug 2009 23:48:51 +0200 (CEST)
User-Agent: KMail/1.11.2 (Linux/2.6.29-2-amd64; KDE/4.2.2; x86_64; ; )
In-Reply-To: <13f0168a0908031213r59a9ea61m824ca7e5209962fc@mail.gmail.com>
X-Face: #;qMWg=Msk*d]z]X1P2-t9]~6+RoGF$nJo89f%|Y`^whfl3Wj$X2Q_1u)ZAW@Hx|g)J]!)
 =?utf-8?q?=0A=09Br0=3FK3Imj?=)np=]r*QN,Q8].V99^Og'xl-d9FM~$yaSGB"mfXb>x[QNi[()
 =?utf-8?q?oob=60/4M42=26We=0A=09cC1jq=3DQ=5CS?=@ck\>H@
 =?utf-8?q?t=26Y7Y=3Apub=3DHOWqY=7D-d=5CwrCxvsTo7k1Ek=7DqQO=5D5=7EngK=5E=25?=
 =?utf-8?q?cT5IzmmG=5BQ=0A=09Nha=7D=5DAmI=60R-6m84VcWT4=236c?=)1`>t{$~l6:gZMtv18ge'!d[Yk-/?T3>C5O-|6On4(
 =?utf-8?q?N=7BAV=23=0A=094Eyw52=5B=3A=25Z?=>#"c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124723>

--nextPart3464888.qn3bEhek9H
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Monday 03 August 2009 13:13:43 Matt Di Pasquale wrote:
> wow. thanks. that gave me some good ideas.
> i think u were right about rsync. it was pretty easy to set up.
> assuming the name of my app is myapp, i just put the following alias
> in my ~/.bash_profile on my local machine.
>
> alias mapush=3D'rsync -e ssh -av --exclude=3D".DS_Store"
> ~/Projects/myapp/myapp.com/
> matt@mattdipasquale.com:projects/myapp.com/'

Okay, looks like you've got rsync figured out!

> btw, is there a way to make aliases that are local to certain
> directories? like typing mapush works from any directory. what if i
> just wanted the alias to be push and only work from within
> ~/Projects/myapp? is that possible?

The typical way to do this is to make a "bin" or "scripts" subdirectory of=
=20
your project, then make a shell script and call it via ./bin/push or=20
=2E/scripts/push or whatever. You can also do pretty much anything by using=
=20
shell functions instead of aliases. They work just like shell aliases but=20
are defined differently (man bash, then search for FUNCTIONS).

Since the topic is git, I should also mention that you can also set up=20
repository hooks that make things happen when triggered, e.g. automatically=
=20
rsync to the server when you commit to "production" for example. Do a man=20
githooks for more info on that.

> it's pretty fast. but will rsync be okay if i decide to move files
> around a bit? i know git is pretty good about that. and what if i
> delete certain files? will rsync delete them... like git does? guess
> i'll figure those questions out in time.

Rsync will not delete anything unless you add "--delete". If you use that,=
=20
you probably also want "--delete-after" for a website, which makes sure tha=
t=20
deletes are only done after everything else is copied over. The default is=
=20
the same as "--delete-before", which does deletes before copying things=20
(e.g. to save disk space).

As far as raw network transfer performance, git and rsync are probably=20
pretty comparible, as they both are passing just changes instead of complet=
e=20
files around. Obviously they work very differently internally so e.g. I=20
imagine that git will perform much better in some cases because it tracks=20
content instead of files.

--nextPart3464888.qn3bEhek9H
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkp3WzgACgkQ8KmKTEzW49J6EQCdFGz061lQm5CZxjMMKRATCKxO
hQsAni9u5r6JhLwjvEApDh9W95BUiSk8
=n0vT
-----END PGP SIGNATURE-----

--nextPart3464888.qn3bEhek9H--
