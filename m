From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: Consolidate SHA1 object file close
Date: Wed, 11 Jun 2008 09:43:09 +0200
Message-ID: <20080611074309.GB28629@artemis.madism.org>
References: <alpine.LFD.1.10.0806101842460.3101@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="TRYliJ5NKNqkz5bu";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Denis Bueno <dbueno@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Jun 11 09:44:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6L04-00079w-6o
	for gcvg-git-2@gmane.org; Wed, 11 Jun 2008 09:44:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753122AbYFKHnN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jun 2008 03:43:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753175AbYFKHnN
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jun 2008 03:43:13 -0400
Received: from pan.madism.org ([88.191.52.104]:46986 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753098AbYFKHnM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jun 2008 03:43:12 -0400
Received: from madism.org (APuteaux-103-1-3-109.w217-128.abo.wanadoo.fr [217.128.49.109])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 67F9119CC4;
	Wed, 11 Jun 2008 09:43:10 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 7C12D4D33DD; Wed, 11 Jun 2008 09:43:09 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Denis Bueno <dbueno@gmail.com>
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.10.0806101842460.3101@woody.linux-foundation.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84597>


--TRYliJ5NKNqkz5bu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 11, 2008 at 01:47:18AM +0000, Linus Torvalds wrote:
>=20
> This consolidates the common operations for closing the new temporary fil=
e=20
> that we have written, before we move it into place with the final name.=
=20
>=20
> There's some common code there (make it read-only and check for errors on=
=20
> close), but more importantly, this also gives a single place to add an=20
> fsync_or_die() call if we want to add a safe mode.
>=20
> This was triggered due to Denis Bueno apparently twice being able to=20
> corrupt his git repository on OS X due to an unlucky combination of kerne=
l=20
> crashes and a not-very-robust filesystem.

  Could this be the source of a problem we often meet at work ? Let me
try to describe it.

  We work with our git repositories (storages I should say) on NFS
homes, with workdirs on a local directory (NFS homes are backuped daily,
hence everything commited get backuped, and developers have shorter
compilation times thanks to the local FS). I don't think the workdir use
is relevant because I use it almost the same without NFS and haven't any
issues, but I mention it just in case.

  Quite often, when people commit, they have corrupt repositories. The
symptom is a `cannot read <sha1>` error message (or many at times). The
usual way to "fix" it is to git fsck, and git reset (because after the
fsck the index is totally screwed and all local files are marked new),
and usually everything is fine then.

  This is not really a hard corruption, and it's really hard to
reproduce, I don't know why it happens, and I wonder if this patch could
help, or if it's unrelated. I can only bring speculations as it's really
hard to reproduce, and it quite depends on the load of the NFS server :/

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--TRYliJ5NKNqkz5bu
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkhPgg0ACgkQvGr7W6Hudhz3vQCeI/lYNiu+LwHeXX3cpSxgHD05
oTkAniUrU0FamXa+ZBhCWB+x7A5OVyr9
=3a97
-----END PGP SIGNATURE-----

--TRYliJ5NKNqkz5bu--
