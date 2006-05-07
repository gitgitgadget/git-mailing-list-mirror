From: Sergey Vlasov <vsu@altlinux.ru>
Subject: Re: Unresolved issues #2 (shallow clone again)
Date: Sun, 7 May 2006 12:01:49 +0400
Message-ID: <20060507120149.40e9f749.vsu@altlinux.ru>
References: <7v64lcqz9j.fsf@assigned-by-dhcp.cox.net>
	<7v4q065hq0.fsf@assigned-by-dhcp.cox.net>
	<87mzdx7mh9.wl%cworth@cworth.org>
	<7v1wv92u7o.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0605050806370.3622@g5.osdl.org>
	<e3fqb9$hed$1@sea.gmane.org>
	<Pine.LNX.4.64.0605050848230.3622@g5.osdl.org>
	<46a038f90605052323o29f8bfadr7426f97d8dfc2319@mail.gmail.com>
	<7vbqubvdbr.fsf@assigned-by-dhcp.cox.net>
	<46a038f90605062308x53995076k7bf45f0aebcae0c6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Sun__7_May_2006_12_01_49_+0400_B.DH7Akyh0zoAdwa"
Cc: "Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 07 10:02:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FceDY-0005Y4-KL
	for gcvg-git@gmane.org; Sun, 07 May 2006 10:02:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751204AbWEGICH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 7 May 2006 04:02:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751211AbWEGICH
	(ORCPT <rfc822;git-outgoing>); Sun, 7 May 2006 04:02:07 -0400
Received: from master.altlinux.org ([62.118.250.235]:35589 "EHLO
	master.altlinux.org") by vger.kernel.org with ESMTP
	id S1751204AbWEGICF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 May 2006 04:02:05 -0400
Received: from procyon.home (localhost.localdomain [127.0.0.1])
	by master.altlinux.org (Postfix) with ESMTP
	id B5A19E3267; Sun,  7 May 2006 12:01:59 +0400 (MSD)
Received: by procyon.home (Postfix, from userid 500)
	id 5CDA2E36BC5; Sun,  7 May 2006 12:01:52 +0400 (MSD)
To: "Martin Langhoff" <martin.langhoff@gmail.com>
In-Reply-To: <46a038f90605062308x53995076k7bf45f0aebcae0c6@mail.gmail.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i586-alt-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19695>

--Signature=_Sun__7_May_2006_12_01_49_+0400_B.DH7Akyh0zoAdwa
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, 7 May 2006 18:08:03 +1200 Martin Langhoff wrote:

> On 5/6/06, Junio C Hamano <junkio@cox.net> wrote:
> > "Martin Langhoff" <martin.langhoff@gmail.com> writes:
> > >
> > > It means that for a merge or checkout involving stuff we "don't have",
> > > it's trivial to know we are missing, and so we can  attempt a fetch of
> > > the missing objects or tell the user how to request them them before
> > > retrying.
> > >
> > > And in any case commits and trees are lightweight and compress well...
> >
> > Commit maybe, but is this based on a hard fact?
>=20
> No hard facts here :( but I think it's reasonable to assume that the
> trees delta/compress reasonably well, as a given commit will change
> just a few entries in each tree.
>=20
> I might try and hack a shallow local clone of the kernel and pack it
> tightly to see what it yields.

For linux v2.6.16:

7,3M commits-b41b04a36afebdba3b70b74f419fc7d97249bd7f.pack
 24M commits_trees-8397f1c2a885527acd07e2caa8c95df626451493.pack
 97M full-c7b2747a674ff55cb4a59dabebe419f191e360df.pack

For comparizon, a single version in packed form:

 51M v2.6.12-rc2-4f3526b6815eb63da6c43ed85be1494bb776e2c5.pack

Made with

git-rev-list v2.6.16 | git-pack-objects commits
git-rev-list --objects --no-blobs v2.6.16 | git-pack-objects commits_trees
git-rev-list --objects v2.6.16 | git-pack-objects full

and this hack to git-rev-list:

diff --git a/revision.c b/revision.c
index f2a9f25..b5a929e 100644
--- a/revision.c
+++ b/revision.c
@@ -636,6 +636,10 @@ int setup_revisions(int argc, const char
 				revs->blob_objects =3D 1;
 				continue;
 			}
+			if (!strcmp(arg, "--no-blobs")) {
+				revs->blob_objects =3D 0;
+				continue;
+			}
 			if (!strcmp(arg, "--objects-edge")) {
 				revs->tag_objects =3D 1;
 				revs->tree_objects =3D 1;

So trees are definitely not lightweight, and commits are rather large
too.

--Signature=_Sun__7_May_2006_12_01_49_+0400_B.DH7Akyh0zoAdwa
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.9.17 (GNU/Linux)

iD8DBQFEXalwW82GfkQfsqIRAgrgAJ94oSb7itGqN6YkqnWOkuqTnwQYqgCeILWa
cPuBoJN2FNxWeA5wlRoZpt0=
=xXpk
-----END PGP SIGNATURE-----

--Signature=_Sun__7_May_2006_12_01_49_+0400_B.DH7Akyh0zoAdwa--
