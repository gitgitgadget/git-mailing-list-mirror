From: Martin Schlemmer <azarah@nosferatu.za.org>
Subject: Re: [patch] fixup GECOS handling
Date: Fri, 22 Apr 2005 21:06:43 +0200
Message-ID: <1114196803.29271.52.camel@nosferatu.lan>
References: <1113820589.16288.5.camel@nosferatu.lan>
	 <1113827713.5286.13.camel@localhost.localdomain>
	 <1114179795.29271.18.camel@nosferatu.lan>
	 <1114186599.31076.409.camel@axer.marchex.com>
	 <1114189105.29271.36.camel@nosferatu.lan>
	 <20050422171818.GE7173@pasky.ji.cz>
	 <1114192702.31076.428.camel@axer.marchex.com>
Reply-To: azarah@nosferatu.za.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-45YQxiRPnuDIennVkaFA"
Content-Transfer-Encoding: 8bit
Cc: Petr Baudis <pasky@ucw.cz>, GIT Mailing Lists <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Apr 22 20:59:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DP3M1-0003GT-Ou
	for gcvg-git@gmane.org; Fri, 22 Apr 2005 20:58:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262109AbVDVTCy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Apr 2005 15:02:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262110AbVDVTCy
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Apr 2005 15:02:54 -0400
Received: from ctb-mesg4.saix.net ([196.25.240.76]:11396 "EHLO
	ctb-mesg4.saix.net") by vger.kernel.org with ESMTP id S262109AbVDVTCt
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Apr 2005 15:02:49 -0400
Received: from gateway.lan (wblv-146-254-56.telkomadsl.co.za [165.146.254.56])
	by ctb-mesg4.saix.net (Postfix) with ESMTP id 0945CAA79;
	Fri, 22 Apr 2005 21:02:45 +0200 (SAST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gateway.lan (Postfix) with ESMTP id 5A6A93A241A;
	Fri, 22 Apr 2005 21:09:07 +0200 (SAST)
Received: from gateway.lan ([127.0.0.1])
 by localhost (gateway.lan [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 14873-18; Fri, 22 Apr 2005 21:09:01 +0200 (SAST)
Received: from nosferatu.lan (nosferatu.lan [192.168.0.2])
	(using TLSv1 with cipher IDEA-CBC-SHA (128/128 bits))
	(No client certificate requested)
	by gateway.lan (Postfix) with ESMTP id 9BA0E3A246F;
	Fri, 22 Apr 2005 21:09:01 +0200 (SAST)
To: kyle@marchex.com
In-Reply-To: <1114192702.31076.428.camel@axer.marchex.com>
X-Mailer: Evolution 2.2.1.1 
X-Virus-Scanned: by amavisd-new using ClamAV at nosferatu.za.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


--=-45YQxiRPnuDIennVkaFA
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2005-04-22 at 10:58 -0700, Kyle Hayes wrote:
> On Fri, 2005-04-22 at 19:18 +0200, Petr Baudis wrote:
> > Dear diary, on Fri, Apr 22, 2005 at 06:58:25PM CEST, I got a letter
> > where Martin Schlemmer <azarah@nosferatu.za.org> told me that...
> > > Meaning, if they use a ',' in one of the fields (and it is a linux
> > > system with the chfn most probably from the shadow package), then the=
y
> > > are looking for trouble.  The only reason I added the ';' was because
> > > somebody said whatever OS used it instead of a ','.
> >=20
> > What about just swapping the two tests so that ; is cut off and , only
> > when no ; is around?
>=20
> Even nicer.  I like it.  Very clean!
>=20

Right, but ';' is not cutoff on linux for one, and from what you said
freebsd as well.  How about this rather (note that I assumed that the
use of ';' as delimiter will be in the minority, but we can switch
things around if it turns out the other way):

----
(not signed off, etc, as just for comments)

Index: commit-tree.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- 5f61aecb06c2f2579bbb5951b1b53e0dedc434eb/commit-tree.c  (mode:100644 sh=
a1:c0b07f89286c3f6cceae8122b4c3142c8efaf8e1)
+++ uncommitted/commit-tree.c  (mode:100644)
@@ -96,21 +96,6 @@
                if (!c)
                        break;
        }
-
-       /*
-        * Go back, and remove crud from the end: some people
-        * have commas etc in their gecos field
-        */
-       dst--;
-       while (--dst >=3D p) {
-               unsigned char c =3D *dst;
-               switch (c) {
-               case ',': case ';': case '.':
-                       *dst =3D 0;
-                       continue;
-               }
-               break;
-       }
 }

 static const char *month_names[] =3D {
@@ -311,6 +296,17 @@
        if (!pw)
                die("You don't exist. Go away!");
        realgecos =3D pw->pw_gecos;
+       /*
+        * The GECOS fields are seperated via ',' on Linux, FreeBSD, etc,
+        * and ';' on AIX.
+        */
+#if defined(__aix__)
+       if (strchr(realgecos, ';'))
+               *strchr(realgecos, ';') =3D 0;
+#else
+       if (strchr(realgecos, ','))
+               *strchr(realgecos, ',') =3D 0;
+#endif
        len =3D strlen(pw->pw_name);
        memcpy(realemail, pw->pw_name, len);
        realemail[len] =3D '@';


--=20
Martin Schlemmer


--=-45YQxiRPnuDIennVkaFA
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBCaUtDqburzKaJYLYRAsypAJ90iEEJj8DDwy9owsAKnr+DaZl8WQCeLJqh
oxASmTn7zr/slbjbaNgRqlo=
=Eljg
-----END PGP SIGNATURE-----

--=-45YQxiRPnuDIennVkaFA--

