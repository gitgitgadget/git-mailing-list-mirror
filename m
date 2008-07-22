From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: regression in  92392b4
Date: Wed, 23 Jul 2008 01:37:16 +0200
Message-ID: <20080722233716.GE11831@artemis.madism.org>
References: <20080722231745.GD11831@artemis.madism.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="47eKBCiAZYFK5l32";
	protocol="application/pgp-signature"; micalg=SHA1
To: spearce@spearce.org, Git ML <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 23 01:39:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLRRo-00050Z-I5
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 01:39:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758898AbYGVXhX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jul 2008 19:37:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758201AbYGVXhW
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jul 2008 19:37:22 -0400
Received: from pan.madism.org ([88.191.52.104]:38352 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758875AbYGVXhT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jul 2008 19:37:19 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 510D53954E;
	Wed, 23 Jul 2008 01:37:18 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id B85731426D2; Wed, 23 Jul 2008 01:37:16 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	spearce@spearce.org, Git ML <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
Content-Disposition: inline
In-Reply-To: <20080722231745.GD11831@artemis.madism.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89568>


--47eKBCiAZYFK5l32
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 22, 2008 at 11:17:45PM +0000, Pierre Habouzit wrote:
>   Hi, here is a manual painful down-secting (opposed to a bisect ;P) I
> did, since git in next cannot fetch on a regular basis for me. The
> culprit seems to be commit  92392b4:
>=20
>     =E2=94=8C=E2=94=80(1:11)=E2=94=80=E2=94=80<~/dev/scm/git 92392b4...>=
=E2=94=80=E2=94=80
>     =E2=94=94[artemis] git fetch
>     remote: Counting objects: 461, done.
>     remote: Compressing objects: 100% (141/141), done.
>     remote: Total 263 (delta 227), reused 155 (delta 121)
>     Receiving objects: 100% (263/263), 95.55 KiB, done.
>     fatal: Out of memory, malloc failed
>     fatal: index-pack failed
>     [2]    16674 abort (core dumped)  git fetch
>=20
>     =E2=94=8C=E2=94=80(1:12)=E2=94=80=E2=94=80<~/dev/scm/git 92392b4...>=
=E2=94=80=E2=94=80
>     =E2=94=94[artemis] git checkout -m HEAD~1; make git-index-pack
>     Previous HEAD position was 92392b4... index-pack: Honor core.deltaBas=
eCacheLimit when resolving deltas
>     HEAD is now at 03993e1... index-pack: Track the object_entry that cre=
ates each base_data
>     GIT_VERSION =3D 1.5.6.3.3.g03993
> 	CC index-pack.o
> 	LINK git-index-pack
>=20
>     =E2=94=8C=E2=94=80(1:12)=E2=94=80=E2=94=80<~/dev/scm/git 03993e1...>=
=E2=94=80=E2=94=80
>     =E2=94=94[artemis] git fetch
>     remote: Counting objects: 461, done.
>     remote: Compressing objects: 100% (141/141), done.
>     remote: Total 263 (delta 227), reused 155 (delta 121)
>     Receiving objects: 100% (263/263), 95.55 KiB, done.
>     Resolving deltas: 100% (227/227), completed with 153 local objects.
>     From git://git.kernel.org/pub/scm/git/git
>        5ba2c22..0868a30  html       -> origin/html
>        2857e17..abeeabe  man        -> origin/man
>        93310a4..95f8ebb  master     -> origin/master
>        559998f..e8bf351  next       -> origin/next
>=20
> You can see the commit sha's in the prompt. 03993e1 is fine, 92392b4 is
> broken, I've absolutely no clue about what happens.
>=20
> All I can say is that at some point in get_data_from_pack, obj[1].idx
> points to something that is *not* a sha so it's probably corrupted.
> (from index-pack.c).

  Though reading the code, we trust c->data NULL-iness to mean we have
no data, and there is one code path that fails to reset it. The problem
is I'm not able to reproduce the bug, because I foolishly didn't
backuped the git repository that exhibited the failure, so I cannot know
if that can be the problem:

--- snip ---
=46rom c3749f7bc50c642c5d437b2746d4ba589b7d9739 Mon Sep 17 00:00:00 2001
=46rom: Pierre Habouzit <madcoder@debian.org>
Date: Wed, 23 Jul 2008 01:35:11 +0200
Subject: [PATCH] index-pack: missing pointer reset to NULL.

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---
 index-pack.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/index-pack.c b/index-pack.c
index ac20a46..19c39e5 100644
--- a/index-pack.c
+++ b/index-pack.c
@@ -257,6 +257,7 @@ static void unlink_base_data(struct base_data *c)
 		base_cache =3D NULL;
 	if (c->data) {
 		free(c->data);
+		c->data =3D NULL;
 		base_cache_used -=3D c->size;
 	}
 }
--=20
1.6.0.rc0.153.ge8bf3.dirty


--47eKBCiAZYFK5l32
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkiGbywACgkQvGr7W6Hudhx8QwCfbtLy1sZ1SfupR5ksI9U/YVZk
bjIAni7Lu6FO3MDZ5/iUZGV36UNW7B1M
=peYy
-----END PGP SIGNATURE-----

--47eKBCiAZYFK5l32--
