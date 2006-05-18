From: Tilman Sauerbeck <tilman@code-monkey.de>
Subject: Re: Shipping man pages?
Date: Thu, 18 May 2006 12:57:04 +0200
Message-ID: <20060518105703.GA29482@code-monkey.de>
References: <20060518074630.GA2994@code-monkey.de> <7vac9f69la.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+xNpyl7Qekk2NvDX"
X-From: git-owner@vger.kernel.org Thu May 18 12:57:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FggBx-0008Me-Vj
	for gcvg-git@gmane.org; Thu, 18 May 2006 12:57:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751225AbWERK5I (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 18 May 2006 06:57:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751227AbWERK5I
	(ORCPT <rfc822;git-outgoing>); Thu, 18 May 2006 06:57:08 -0400
Received: from code-monkey.de ([81.169.170.126]:6068 "EHLO code-monkey.de")
	by vger.kernel.org with ESMTP id S1751225AbWERK5H (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 May 2006 06:57:07 -0400
Received: from hammerfest (bwil-d9b96247.pool.mediaWays.net [217.185.98.71])
	by code-monkey.de (Postfix) with ESMTP id 84AED78A1
	for <git@vger.kernel.org>; Thu, 18 May 2006 12:57:04 +0200 (CEST)
To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vac9f69la.fsf@assigned-by-dhcp.cox.net>
User-Agent: mutt-ng/devel-r796 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20281>


--+xNpyl7Qekk2NvDX
Content-Type: multipart/mixed; boundary="mxv5cy4qt+RJ9ypb"
Content-Disposition: inline


--mxv5cy4qt+RJ9ypb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Junio C Hamano [2006-05-18 01:06]:
> Tilman Sauerbeck <tilman@code-monkey.de> writes:
>=20
> [snip]
>=20
> Why does this have to come up so often, and everybody who asks
> for them never supplies the patch to do so?

If it comes up that often it would indicate that this is actually a
concern to many people o_O

Also, I prefer to ask whether a patch would even be accepted so I don't
waste 3 hours of my life trying to figure out how to set up asciidoc and
docbook.

> > Or maybe offer them in a separate tarball?
>=20
> Things that are buildable from the source do not belong in the
> source tarball.  If somebody wants to do this as a patch, I can
> be talked into accepting it, but the build procedure should
> build a separate tarball (or two; one for man and another for
> woman^Whtml).

I attached a patch.

Regards,
Tilman

--=20
A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing on usenet and in e-mail?

--mxv5cy4qt+RJ9ypb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="git-doc-dist.patch"
Content-Transfer-Encoding: quoted-printable

Created a dist target for Documentation/Makefile that tars up the man pages=
 and html files.

Signed-off-by: Tilman Sauerbeck <tilman@code-monkey.de>


---

 Documentation/Makefile |   16 +++++++++++++++-
 1 files changed, 15 insertions(+), 1 deletions(-)

f8b6b70c89364418724899ab5ca28aaaf3eee7dc
diff --git a/Documentation/Makefile b/Documentation/Makefile
index c1af22c..271d9e4 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -31,6 +31,7 @@ man7=3D$(mandir)/man7
 # DESTDIR=3D
=20
 INSTALL?=3Dinstall
+TAR?=3Dtar
=20
 #
 # Please note that there is a minor bug in asciidoc.
@@ -55,6 +56,18 @@ install: man
 	$(INSTALL) $(DOC_MAN1) $(DESTDIR)/$(man1)
 	$(INSTALL) $(DOC_MAN7) $(DESTDIR)/$(man7)
=20
+-include ../GIT-VERSION-FILE
+
+dist: html man
+	@mkdir -p git-doc-{html,man}-$(GIT_VERSION)
+	@cp $(DOC_HTML) git-doc-html-$(GIT_VERSION)
+	@cp $(DOC_MAN1) $(DOC_MAN7) git-doc-man-$(GIT_VERSION)
+=09
+	@for d in html man; do \
+		$(TAR) cf git-doc-$$d-$(GIT_VERSION).tar git-doc-$$d-$(GIT_VERSION) && \
+		rm -rf git-doc-$$d-$(GIT_VERSION) && \
+		gzip -f -9 git-doc-$$d-$(GIT_VERSION).tar \
+	; done
=20
 #
 # Determine "include::" file references in asciidoc files.
@@ -73,7 +86,8 @@ README: ../README
=20
=20
 clean:
-	rm -f *.xml *.html *.1 *.7 howto-index.txt howto/*.html doc.dep README
+	rm -f *.xml *.html *.1 *.7 howto-index.txt howto/*.html doc.dep README \
+	      git-doc-{html,man}-$(GIT_VERSION).tar.gz
=20
 %.html : %.txt
 	asciidoc -b xhtml11 -d manpage -f asciidoc.conf $<
--=20
1.3.3


--mxv5cy4qt+RJ9ypb--

--+xNpyl7Qekk2NvDX
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQFEbFL/27uLisrW2w8RAru8AJ4m592EsEx/7lRMn9Veikc5lCF+5wCeI1h6
Nu8rCvRrk5KV7aVy0o5p5Lo=
=Fo7y
-----END PGP SIGNATURE-----

--+xNpyl7Qekk2NvDX--
