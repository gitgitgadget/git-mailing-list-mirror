From: Ismail =?utf-8?q?D=C3=B6nmez?= <ismail@pardus.org.tr>
Subject: [PATCH] Use perl builtin class utf8 for UTF-8 decoding
Date: Wed, 5 Dec 2007 12:26:30 +0200
Organization: Pardus / KDE
Message-ID: <200712051226.30162.ismail@pardus.org.tr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Martin Koegler <mkoegler@auto.tuwien.ac.at>, git@vger.kernel.org,
	Alexandre Julliard <julliard@winehq.org>,
	Benjamin Close <Benjamin.Close@clearchain.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 05 11:26:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzrSu-00064x-1N
	for gcvg-git-2@gmane.org; Wed, 05 Dec 2007 11:26:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753069AbXLEKZq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 5 Dec 2007 05:25:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754590AbXLEKZp
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Dec 2007 05:25:45 -0500
Received: from ns2.uludag.org.tr ([193.140.100.220]:55730 "EHLO uludag.org.tr"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752948AbXLEKZn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Dec 2007 05:25:43 -0500
Received: from ninjamobile.local (unknown [85.102.220.209])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by uludag.org.tr (Postfix) with ESMTP id 0E49261C28D6;
	Wed,  5 Dec 2007 12:25:35 +0200 (EET)
User-Agent: KMail/1.9.6 (enterprise 0.20071123.740460)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67132>

Junio it would be very nice to get this in 1.5.4, fixes multiple proble=
ms and=20
tested with many distros with success.

Use perl builtin class utf8 for UTF-8 decoding, this fixes Encode probl=
ems=20
with older Encode and avoids problems on UTF-8 locales.

Signed-off-by: =C4=B0smail D=C3=B6nmez <ismail@pardus.org.tr>
Acked-by: Jakub Narebski <jnareb@gmail.com>
Tested-by: Martin Koegler <mkoegler@auto.tuwien.ac.at>
Tested-by: Wincent Colaiuta <win@wincent.com>

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index ff5daa7..db255c1 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -695,10 +695,9 @@ sub validate_refname {
 # in utf-8 thanks to "binmode STDOUT, ':utf8'" at beginning
 sub to_utf8 {
 	my $str =3D shift;
-	my $res;
-	eval { $res =3D decode_utf8($str, Encode::FB_CROAK); };
-	if (defined $res) {
-		return $res;
+        if (utf8::valid($str)) {
+                utf8::decode($str);
+                return $str;
 	} else {
 		return decode($fallback_encoding, $str, Encode::FB_DEFAULT);
 	}


--=20
Never learn by your mistakes, if you do you may never dare to try again=
=2E
