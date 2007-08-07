From: Simon Hausmann <simon@lst.de>
Subject: [PATCH] git-p4: Fix support for symlinks.
Date: Tue, 7 Aug 2007 10:25:47 +0200
Message-ID: <200708071025.47965.simon@lst.de>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart4283433.q9tEdKnTEq";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: "Han-Wen Nienhuys" <hanwen@google.com>,
	Brian Swetland <swetland@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 07 10:25:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IIKNZ-0004Xg-It
	for gcvg-git@gmane.org; Tue, 07 Aug 2007 10:25:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756214AbXHGIZW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 7 Aug 2007 04:25:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755694AbXHGIZW
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Aug 2007 04:25:22 -0400
Received: from verein.lst.de ([213.95.11.210]:60702 "EHLO mail.lst.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755571AbXHGIZU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Aug 2007 04:25:20 -0400
Received: from rhea.troll.no (nat0.troll.no [62.70.27.100])
	(authenticated bits=0)
	by mail.lst.de (8.12.3/8.12.3/Debian-7.1) with ESMTP id l778PFA5024314
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NO);
	Tue, 7 Aug 2007 10:25:16 +0200
User-Agent: KMail/1.9.7
X-Spam-Score: 0 () 
X-Scanned-By: MIMEDefang 2.39
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55232>

--nextPart4283433.q9tEdKnTEq
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Detect symlinks as file type, set the git file mode accordingly and strip o=
ff the trailing newline in the p4 print output.

Signed-off-by: Simon Hausmann <simon@lst.de>
=2D--
 contrib/fast-import/git-p4 |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index 41e86e7..9c6f911 100755
=2D-- a/contrib/fast-import/git-p4
+++ b/contrib/fast-import/git-p4
@@ -839,11 +839,15 @@ class P4Sync(Command):
             if file["action"] =3D=3D "delete":
                 self.gitStream.write("D %s\n" % relPath)
             else:
+                data =3D file['data']
+
                 mode =3D 644
                 if file["type"].startswith("x"):
                     mode =3D 755
=2D
=2D                data =3D file['data']
+                elif file["type"] =3D=3D "symlink":
+                    mode =3D 120000
+                    # p4 print on a symlink contains "target\n", so strip =
it off
+                    data =3D data[:-1]
=20
                 if self.isWindows and file["type"].endswith("text"):
                     data =3D data.replace("\r\n", "\n")
=2D-=20
1.5.3.rc3.91.g5c75


--nextPart4283433.q9tEdKnTEq
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGuCyLWXvMThJCpvIRAjPfAKCkryPzw0Ls90QVF/CegmxbraNMQgCgpZLZ
GedOUyTR7eVRhAu1+8iiZ0w=
=FdwX
-----END PGP SIGNATURE-----

--nextPart4283433.q9tEdKnTEq--
