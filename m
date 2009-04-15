From: "Robin H. Johnson" <robbat2@gentoo.org>
Subject: Weird growth in packfile during initial push
Date: Wed, 15 Apr 2009 11:27:54 -0700
Message-ID: <20090415182754.GF23644@curie-int>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="E5RiUMWuxyMNPNnv"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 15 20:29:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lu9rc-00061r-L6
	for gcvg-git-2@gmane.org; Wed, 15 Apr 2009 20:29:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752474AbZDOS2E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Apr 2009 14:28:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752280AbZDOS2B
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Apr 2009 14:28:01 -0400
Received: from b01.ext.isohunt.com ([208.71.112.51]:38779 "EHLO
	mail.isohunt.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752123AbZDOS2A (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Apr 2009 14:28:00 -0400
Received: (qmail 21566 invoked from network); 15 Apr 2009 18:27:57 -0000
Received: from tsi-static.orbis-terrarum.net (HELO curie.orbis-terrarum.net) (76.10.188.108)
  (smtp-auth username robbat2@isohunt.com, mechanism login)
  by mail.isohunt.com (qpsmtpd/0.33-dev on beta01) with (AES256-SHA encrypted) ESMTPSA; Wed, 15 Apr 2009 18:27:57 +0000
Received: (qmail 21887 invoked by uid 10000); 15 Apr 2009 11:27:54 -0700
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116643>


--E5RiUMWuxyMNPNnv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I was doing a more recent conversion of the Gentoo repo, and ran into
some odd behavior in the packfile size.

For anybody else following the repo, you can now get it on the new hardware=
 at:
http://git-exp.overlays.gentoo.org/gitweb/?p=3Dexp/gentoo-x86.git;a=3Dsumma=
ry

I did the conversion with cvs2svn, packed, added the remote and pushed, onl=
y to
find that the pack on the remote side suddenly seemed to be ~60MiB larger.

$ time git repack -adf --window=3D250 --depth=3D250
real    19m59.339s
user    96m48.011s
sys     0m36.914s

$ ls -la /tmp/convert/gentoo-x86-cvs2git/.git/objects/pack
total 903804
drwxr-xr-x 2 robbat2 users       119 Apr 14 08:05 .
drwxr-xr-x 4 robbat2 users        28 Apr 14 08:05 ..
-r--r--r-- 1 robbat2 users 139155472 Apr 14 08:05 pack-f805bb448f864becfeac=
9c7f8a8ac2ef90c26787.idx
-r--r--r-- 1 robbat2 users 786336481 Apr 14 08:05 pack-f805bb448f864becfeac=
9c7f8a8ac2ef90c26787.pack

$ git remote add origin git+ssh://git@git-exp.overlays.gentoo.org/exp/gento=
o-x86.git
$ git push origin master:master
Initialized empty Git repository in /var/gitroot/exp/gentoo-x86.git/
Counting objects: 4969800, done.
Delta compression using up to 8 threads.
Compressing objects: 100% (1217809/1217809), done.
Writing objects: 100% (4969800/4969800), 810.56 MiB | 21608 KiB/s, done.
Total 4969800 (delta 3735812), reused 4969800 (delta 3735812)
To git+ssh://git@git-exp.overlays.gentoo.org/exp/gentoo-x86.git
 * [new branch]      master -> master

$ ls -la /var/gitroot/exp/gentoo-x86.git/objects/pack
total 966876
drwxr-xr-x 2 git git      4096 Apr 14 08:43 .
drwxr-xr-x 4 git git      4096 Apr 14 08:35 ..
-r--r--r-- 1 git git 139155472 Apr 14 08:43 pack-f805bb448f864becfeac9c7f8a=
8ac2ef90c26787.idx
-r--r--r-- 1 git git 849936308 Apr 14 08:43 pack-f805bb448f864becfeac9c7f8a=
8ac2ef90c26787.pack

On the client side after the initial clone, it DOES match (in size) what was
cloned.

(If you're looking for the 849MB one right now, I'll have to get it back for
you, I wanted to save that extra space so just did an rsync of the other pa=
ck
over the too-large one for now).

--=20
Robin Hugh Johnson
Gentoo Linux Developer & Infra Guy
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11AC BA4F 4778 E3F6 E4ED  F38E B27B 944E 3488 4E85

--E5RiUMWuxyMNPNnv
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.10 (GNU/Linux)
Comment: Robbat2 @ Orbis-Terrarum Networks - The text below is a digital signature. If it doesn't make any sense to you, ignore it.

iEYEARECAAYFAknmJyoACgkQPpIsIjIzwiw8BQCgpSv67czYZstOsU1820rSV1VO
xF0An1QtLmUprAab0Vk+Xlfz6fCOWOXV
=k0uK
-----END PGP SIGNATURE-----

--E5RiUMWuxyMNPNnv--
