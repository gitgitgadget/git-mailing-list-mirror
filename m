From: Clemens Buchacher <drizzd@aon.at>
Subject: [PATCH] disallow branch names that start with a hyphen
Date: Sun, 22 Aug 2010 16:08:02 +0200
Message-ID: <20100822140801.GA6574@localhost>
Reply-To: Clemens Buchacher <drizzd@aon.at>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gBBFr7Ir9EOA20Yy"
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 22 16:08:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OnBDc-0006dQ-FN
	for gcvg-git-2@lo.gmane.org; Sun, 22 Aug 2010 16:08:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752546Ab0HVOH6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Aug 2010 10:07:58 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:38434 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752330Ab0HVOH4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Aug 2010 10:07:56 -0400
Received: by fxm13 with SMTP id 13so2519911fxm.19
        for <git@vger.kernel.org>; Sun, 22 Aug 2010 07:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:received:date:from:to
         :cc:subject:message-id:reply-to:mime-version:content-type
         :content-disposition:user-agent;
        bh=h/xaQUSzWOGHDeDonW5wsvd/DRMLk7TZTxWpiDKH/YE=;
        b=Ef05XDjzPtP8AOTMbPD+dbTiyjGuJRf/WmDWmISaTmkfIH3MwkHM0YN9iZTDC3a86M
         x00rykMR1ZL6OqAtjWVat7HlYr96u4p7aeb/ngOLhlxtTjrT4ZF4tLlt0guScJN95wgr
         XqK0Hz/ahvAxOXz3r0p9YDRWSCcyGJ07bjz8g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:reply-to:mime-version
         :content-type:content-disposition:user-agent;
        b=MG+d1uatGB4dwVy8MpoDEwqcsjs47k8FXNj5wI9wRWeUKpo4NhrQXtkwzBR3QT4E5+
         xzi6UMuTInvSzGkphM7uNoXL+MTpUiyP4aC9Hff5zH11MfudNuesZYw+PXHyhr/AR82E
         qeWd+LERQ8uvrRc/bSdyPol6RVzETod8CU5bs=
Received: by 10.223.119.198 with SMTP id a6mr3033173far.66.1282486074899;
        Sun, 22 Aug 2010 07:07:54 -0700 (PDT)
Received: from darc.lan (p549A79A2.dip.t-dialin.net [84.154.121.162])
        by mx.google.com with ESMTPS id b36sm2037217faq.11.2010.08.22.07.07.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 22 Aug 2010 07:07:54 -0700 (PDT)
Received: from drizzd by darc.lan with local (Exim 4.71)
	(envelope-from <drizzd@localhost>)
	id 1OnBDO-0001ji-0W; Sun, 22 Aug 2010 16:08:02 +0200
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154182>


--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Branch names such as "-", "--" or even "---" do
not work with git checkout. Anything that starts
with a hyphen is also potentially ambiguous with a
command option.

In order to avoid mistakes, do not allow such
branch names.

Signed-off-by: Clemens Buchacher <drizzd@aon.at>
---
 refs.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/refs.c b/refs.c
index b540067..6884dff 100644
--- a/refs.c
+++ b/refs.c
@@ -742,7 +742,7 @@ int for_each_rawref(each_ref_fn fn, void *cb_data)
  * Make sure "ref" is something reasonable to have under ".git/refs/";
  * We do not like it if:
  *
- * - any path component of it begins with ".", or
+ * - any path component of it begins with "." or "-", or
  * - it has double dots "..", or
  * - it has ASCII control character, "~", "^", ":" or SP, anywhere, or
  * - it ends with a "/".
@@ -778,7 +778,7 @@ int check_ref_format(const char *ref)
 			return CHECK_REF_FORMAT_ERROR;
=20
 		/* we are at the beginning of the path component */
-		if (ch =3D=3D '.')
+		if (ch =3D=3D '.' || ch =3D=3D '-')
 			return CHECK_REF_FORMAT_ERROR;
 		bad_type =3D bad_ref_char(ch);
 		if (bad_type) {
--=20
1.7.2.1.1.g202c


--gBBFr7Ir9EOA20Yy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQEcBAEBAgAGBQJMcS9BAAoJELKdZexG8uqMljMH/ROYYAWpNxLOKwQfmW/a6pYn
245KbPVAiQxiECRpyP/FKx1k4/fedHfUupB+se1EBO91vx57B/QzYogijYPKsGLG
hn0NHdrKYTuHKacHOJ+JZ/eh+425Aq0F7AbsxHVFRX/Ukw/Hbx9Vco0iymIiLd6u
RhhER3HrlfsiMmT6nX2MTPdd0so1fmTq47YKi8Y0Brn+8NDKcaq4PYnxEqRiMdpF
hpiCBnR3EN01bY2HlEw8BmkUrNdNIRRAxRUcGUJcTY/E0jQBIk1Z0Y5CRB4jiaNu
Fzi4aPvCNa+5M/rDPoW70e9YhyAfnyAkgqoqR+MIUIFadSEqU8hFS1q7drAH2nY=
=NFHx
-----END PGP SIGNATURE-----

--gBBFr7Ir9EOA20Yy--
