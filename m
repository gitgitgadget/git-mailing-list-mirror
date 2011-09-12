From: "L. A. Linden Levy" <alevy@mobitv.com>
Subject: Re: git-p4.skipSubmitEdit
Date: Mon, 12 Sep 2011 10:12:19 -0700
Organization: MobiTV
Message-ID: <1315847540.10046.29.camel@uncle-pecos>
References: <1315514452.10046.0.camel@uncle-pecos>
	 <4E6DB5F0.7080303@diamand.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-EgzD5zHSnp8+IlsBXO1V"
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Mon Sep 12 19:12:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R3A3g-0001tO-7l
	for gcvg-git-2@lo.gmane.org; Mon, 12 Sep 2011 19:12:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752603Ab1ILRMa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Sep 2011 13:12:30 -0400
Received: from mxout.myoutlookonline.com ([64.95.72.241]:1223 "EHLO
	mxout.myoutlookonline.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752323Ab1ILRM3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Sep 2011 13:12:29 -0400
Received: from mxout.myoutlookonline.com (localhost [127.0.0.1])
	by mxout.myoutlookonline.com (Postfix) with ESMTP id E53647968F1;
	Mon, 12 Sep 2011 13:12:27 -0400 (EDT)
X-Virus-Scanned: by SpamTitan at mail.lan
Received: from mx1.myoutlookonline.com (unknown [10.110.2.1])
	by mxout.myoutlookonline.com (Postfix) with ESMTP id B443D796337;
	Mon, 12 Sep 2011 13:12:23 -0400 (EDT)
Received: from mx1.myoutlookonline.com ([10.9.36.14]) by mx1.myoutlookonline.com with Microsoft SMTPSVC(6.0.3790.4675);
	 Mon, 12 Sep 2011 13:12:23 -0400
Received: from [172.16.131.153] ([75.55.199.5]) by mx1.myoutlookonline.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 12 Sep 2011 13:12:22 -0400
In-Reply-To: <4E6DB5F0.7080303@diamand.org>
X-Mailer: Evolution 2.32.2 
X-OriginalArrivalTime: 12 Sep 2011 17:12:22.0281 (UTC) FILETIME=[229B3F90:01CC716F]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181224>


--=-EgzD5zHSnp8+IlsBXO1V
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I agree with almost all your points. I have answered them each in-line
below.

On Mon, 2011-09-12 at 03:34 -0400, Luke Diamand wrote:
> On 08/09/11 21:40, L. A. Linden Levy wrote:
> > Hi All,
> >
> > I have been using git-p4 for a while and it has allowed me to completel=
y
> > change the way I develop and still be able to use perforce which my
> > company has for its main VCS. One thing that was driving me nuts was
> > that "git p4 submit" cycles through all of my individual commits and
> > asks me if I want to change them. The way I develop I often am checking
> > in 20 to 50 different small commits each with a descriptive git comment=
.
> > I felt like I was doing double duty by having emacs open on every commi=
t
> > into perforce. So I modified git-p4 to have an option to skip the
> > editor. This option coupled with git-p4.skipSubmitEditCheck will make
> > the submission non-interactive for "git p4 submit".
>=20
>=20
> Sorry - I've not had a chance to look at this before now. But a couple=
=20
> of comments:
>=20
>   - Is there a line wrap problem in the patch? It doesn't seem to want=
=20
> to apply for me.

Probably. Below are the results from following the patch submission
instructions.=20

=46rom 16c4344de0047cbaf3381eca590a3e59b0d0a25c Mon Sep 17 00:00:00 2001
From: "Loren A. Linden Levy" <lindenle@gmail.com>
Date: Thu, 8 Sep 2011 13:37:22 -0700
Subject: [PATCH 1/5] changed git-p4

---
 contrib/fast-import/git-p4 |   15 ++++++++++-----
 1 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index 2f7b270..a438b3e 100755
--- a/contrib/fast-import/git-p4
+++ b/contrib/fast-import/git-p4
@@ -935,18 +935,23 @@ class P4Submit(Command, P4UserMap):
             tmpFile.write(submitTemplate + separatorLine + diff +
newdiff)
             tmpFile.close()
             mtime =3D os.stat(fileName).st_mtime
-            if os.environ.has_key("P4EDITOR"):
-                editor =3D os.environ.get("P4EDITOR")
+            if gitConfig("git-p4.skipSubmitEdit") =3D=3D "true":
+                pass
             else:
-                editor =3D read_pipe("git var GIT_EDITOR").strip()
-            system(editor + " " + fileName)
-
+                if os.environ.has_key("P4EDITOR"):
+                    editor =3D os.environ.get("P4EDITOR")
+                else:
+                    editor =3D read_pipe("git var GIT_EDITOR").strip()
+                   =20
+                    system(editor + " " + fileName)
+                   =20
             if gitConfig("git-p4.skipSubmitEditCheck") =3D=3D "true":
                 checkModTime =3D False
             else:
                 checkModTime =3D True
=20
             response =3D "y"
+
             if checkModTime and (os.stat(fileName).st_mtime <=3D mtime):
                 response =3D "x"
                 while response !=3D "y" and response !=3D "n":
--=20
1.7.7.rc0.73.g16c43

=46rom ed60bb737b89eea4b84719c458aeebebd666a2ae Mon Sep 17 00:00:00 2001
From: "Loren A. Linden Levy" <lindenle@gmail.com>
Date: Mon, 12 Sep 2011 09:52:52 -0700
Subject: [PATCH 2/5] removed white space for patch

---
 contrib/fast-import/git-p4 |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index a438b3e..edd2525 100755
--- a/contrib/fast-import/git-p4
+++ b/contrib/fast-import/git-p4
@@ -942,9 +942,7 @@ class P4Submit(Command, P4UserMap):
                     editor =3D os.environ.get("P4EDITOR")
                 else:
                     editor =3D read_pipe("git var GIT_EDITOR").strip()
-                   =20
                     system(editor + " " + fileName)
-                   =20
             if gitConfig("git-p4.skipSubmitEditCheck") =3D=3D "true":
                 checkModTime =3D False
             else:
--=20
1.7.7.rc0.73.g16c43

=46rom ee7eaf73cf52100359b08600eab1279e03ef777b Mon Sep 17 00:00:00 2001
From: "Loren A. Linden Levy" <lindenle@gmail.com>
Date: Mon, 12 Sep 2011 09:55:11 -0700
Subject: [PATCH 3/5] modified the documentation

---
 contrib/fast-import/git-p4.txt |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/contrib/fast-import/git-p4.txt
b/contrib/fast-import/git-p4.txt
index 52003ae..3dba636 100644
--- a/contrib/fast-import/git-p4.txt
+++ b/contrib/fast-import/git-p4.txt
@@ -202,10 +202,16 @@ able to find the relevant client.  This client
spec will be used to
 both filter the files cloned by git and set the directory layout as
 specified in the client (this implies --keep-path style semantics).
=20
-git-p4.skipSubmitModTimeCheck
+git-p4.skipSubmitEdit
=20
   git config [--global] git-p4.skipSubmitModTimeCheck false
=20
+If true, submit will not invoke the editor to modify the p4 change
template.
+
+git-p4.skipSubmitEditCheck=20
+
+  git config [--global] git-p4.skipSubmitEditCheck false
+
 If true, submit will not check if the p4 change template has been
modified.
=20
 git-p4.preserveUser
--=20
1.7.7.rc0.73.g16c43

=46rom ee7eaf73cf52100359b08600eab1279e03ef777b Mon Sep 17 00:00:00 2001
From: "Loren A. Linden Levy" <lindenle@gmail.com>
Date: Mon, 12 Sep 2011 09:55:11 -0700
Subject: [PATCH 3/6] modified the documentation

---
 contrib/fast-import/git-p4.txt |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/contrib/fast-import/git-p4.txt
b/contrib/fast-import/git-p4.txt
index 52003ae..3dba636 100644
--- a/contrib/fast-import/git-p4.txt
+++ b/contrib/fast-import/git-p4.txt
@@ -202,10 +202,16 @@ able to find the relevant client.  This client
spec will be used to
 both filter the files cloned by git and set the directory layout as
 specified in the client (this implies --keep-path style semantics).
=20
-git-p4.skipSubmitModTimeCheck
+git-p4.skipSubmitEdit
=20
   git config [--global] git-p4.skipSubmitModTimeCheck false
=20
+If true, submit will not invoke the editor to modify the p4 change
template.
+
+git-p4.skipSubmitEditCheck=20
+
+  git config [--global] git-p4.skipSubmitEditCheck false
+
 If true, submit will not check if the p4 change template has been
modified.
=20
 git-p4.preserveUser
--=20
1.7.7.rc0.73.g16c43

=46rom c9d3b4ea4dcf1f5fd489dfacde550dd4c648afc7 Mon Sep 17 00:00:00 2001
From: "Loren A. Linden Levy" <lindenle@gmail.com>
Date: Mon, 12 Sep 2011 10:01:08 -0700
Subject: [PATCH 4/6] changed the order a bit

---
 contrib/fast-import/git-p4 |   11 ++++++-----
 1 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index edd2525..80bcc90 100755
--- a/contrib/fast-import/git-p4
+++ b/contrib/fast-import/git-p4
@@ -935,18 +935,19 @@ class P4Submit(Command, P4UserMap):
             tmpFile.write(submitTemplate + separatorLine + diff +
newdiff)
             tmpFile.close()
             mtime =3D os.stat(fileName).st_mtime
+            if gitConfig("git-p4.skipSubmitEditCheck") =3D=3D "true":
+                checkModTime =3D False
+            else:
+                checkModTime =3D True
             if gitConfig("git-p4.skipSubmitEdit") =3D=3D "true":
-                pass
+                checkModTime =3D False
+                pass       =20
             else:
                 if os.environ.has_key("P4EDITOR"):
                     editor =3D os.environ.get("P4EDITOR")
                 else:
                     editor =3D read_pipe("git var GIT_EDITOR").strip()
                     system(editor + " " + fileName)
-            if gitConfig("git-p4.skipSubmitEditCheck") =3D=3D "true":
-                checkModTime =3D False
-            else:
-                checkModTime =3D True
=20
             response =3D "y"
=20
--=20
1.7.7.rc0.73.g16c43

=46rom de3d67a301b49e4d986e83727b822aa5fd257527 Mon Sep 17 00:00:00 2001
From: "Loren A. Linden Levy" <lindenle@gmail.com>
Date: Mon, 12 Sep 2011 10:03:03 -0700
Subject: [PATCH 5/6] cleaned up whitespace for making a patch

---
 contrib/fast-import/git-p4     |    2 +-
 contrib/fast-import/git-p4.txt |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index 80bcc90..1cd65a3 100755
--- a/contrib/fast-import/git-p4
+++ b/contrib/fast-import/git-p4
@@ -941,7 +941,7 @@ class P4Submit(Command, P4UserMap):
                 checkModTime =3D True
             if gitConfig("git-p4.skipSubmitEdit") =3D=3D "true":
                 checkModTime =3D False
-                pass       =20
+                pass
             else:
                 if os.environ.has_key("P4EDITOR"):
                     editor =3D os.environ.get("P4EDITOR")
diff --git a/contrib/fast-import/git-p4.txt
b/contrib/fast-import/git-p4.txt
index 3dba636..8291e7a 100644
--- a/contrib/fast-import/git-p4.txt
+++ b/contrib/fast-import/git-p4.txt
@@ -208,7 +208,7 @@ git-p4.skipSubmitEdit
=20
 If true, submit will not invoke the editor to modify the p4 change
template.
=20
-git-p4.skipSubmitEditCheck=20
+git-p4.skipSubmitEditCheck
=20
   git config [--global] git-p4.skipSubmitEditCheck false
=20
--=20
1.7.7.rc0.73.g16c43

=46rom 64c4878d12748daeda637b3d7d2f018c316b4239 Mon Sep 17 00:00:00 2001
From: "Loren A. Linden Levy" <lindenle@gmail.com>
Date: Mon, 12 Sep 2011 10:10:22 -0700
Subject: [PATCH 6/6] made the docs correct for the new option

---
 contrib/fast-import/git-p4.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/contrib/fast-import/git-p4.txt
b/contrib/fast-import/git-p4.txt
index 8291e7a..f1c1d0c 100644
--- a/contrib/fast-import/git-p4.txt
+++ b/contrib/fast-import/git-p4.txt
@@ -204,7 +204,7 @@ specified in the client (this implies --keep-path
style semantics).
=20
 git-p4.skipSubmitEdit
=20
-  git config [--global] git-p4.skipSubmitModTimeCheck false
+  git config [--global] git-p4.skipSubmitEdit false
=20
 If true, submit will not invoke the editor to modify the p4 change
template.
=20
--=20
1.7.7.rc0.73.g16c43



>   - needs an update to the documentation in git-p4.txt

Done. Also I think the skipSubmitEditCheck was incorrectly name
git-p4.skipSubmitModTimeCheck in the git-p4.txt file. I updated this as
well.

>   - is there any way to eliminate the slightly ugly=20
> "if/pass/else/do-stuff" construct?

I think it is logically correct and describes the situation well. We are
skipping the editor so we pass it. If you still do not agree then
perhaps a suggestion of a better logical flow would help me.=20

>   - I'd think if you turned off the editor completely then there's no=20
> point doing the submit-edit-check.

I have changed the ordering so that at the moment this happens because I
agree with you.

>   - You probably need to follow the instructions in=20
> Documentation/SubmittingPatches so that Junio will pay attention to the=
=20
> patch.

See point #1.

> Regards!
> Luke
>=20
>=20
> >
> > Below are the patch and environment results:
> >
> >
> > $ git config -l
> > ...
> > user.name=3DLoren A. Linden Levy
> > git-p4.skipsubmitedit=3Dtrue
> > git-p4.skipsubmiteditcheck=3Dtrue
> > ...
> >
> > $ git format-patch origin/master --stdout
> >
> >  From 16c4344de0047cbaf3381eca590a3e59b0d0a25c Mon Sep 17 00:00:00 2001
> > From: "Loren A. Linden Levy"<lindenle@gmail.com>
> > Date: Thu, 8 Sep 2011 13:37:22 -0700
> > Subject: [PATCH] changed git-p4
> >
> > ---
> >   contrib/fast-import/git-p4 |   15 ++++++++++-----
> >   1 files changed, 10 insertions(+), 5 deletions(-)
> >
> > diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
> > index 2f7b270..a438b3e 100755
> > --- a/contrib/fast-import/git-p4
> > +++ b/contrib/fast-import/git-p4
> > @@ -935,18 +935,23 @@ class P4Submit(Command, P4UserMap):
> >               tmpFile.write(submitTemplate + separatorLine + diff +
> > newdiff)
> >               tmpFile.close()
> >               mtime =3D os.stat(fileName).st_mtime
> > -            if os.environ.has_key("P4EDITOR"):
> > -                editor =3D os.environ.get("P4EDITOR")
> > +            if gitConfig("git-p4.skipSubmitEdit") =3D=3D "true":
> > +                pass
> >               else:
> > -                editor =3D read_pipe("git var GIT_EDITOR").strip()
> > -            system(editor + " " + fileName)
> > -
> > +                if os.environ.has_key("P4EDITOR"):
> > +                    editor =3D os.environ.get("P4EDITOR")
> > +                else:
> > +                    editor =3D read_pipe("git var GIT_EDITOR").strip()
> > +
> > +                    system(editor + " " + fileName)
> > +
> >               if gitConfig("git-p4.skipSubmitEditCheck") =3D=3D "true":
> >                   checkModTime =3D False
> >               else:
> >                   checkModTime =3D True
> >
> >               response =3D "y"
> > +
> >               if checkModTime and (os.stat(fileName).st_mtime<=3D mtime=
):
> >                   response =3D "x"
> >                   while response !=3D "y" and response !=3D "n":
>=20

--=20
Alex Linden Levy
Senior Software Engineer
MobiTV, Inc.
6425 Christie Avenue, 5th Floor, Emeryville, CA 94608
phone 510.450.5190 mobile 720.352.8394
email alevy@mobitv.com  web www.mobitv.com


--=-EgzD5zHSnp8+IlsBXO1V
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAk5uPXAACgkQlZX6YS+3ZkvE6gCbBGDUVPzVhtDPDD9+jIM4Lljo
ryUAn1WbU8JMjRWNIl/cgs3wnjcAmKPM
=TLYA
-----END PGP SIGNATURE-----

--=-EgzD5zHSnp8+IlsBXO1V--
