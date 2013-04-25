From: Torsten =?utf-8?q?B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH] check-non-portable-shell: export X=Y usage
Date: Thu, 25 Apr 2013 20:48:44 +0200
Message-ID: <201304252048.45137.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 25 20:48:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVRDy-0008Fn-Si
	for gcvg-git-2@plane.gmane.org; Thu, 25 Apr 2013 20:48:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758861Ab3DYSsu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 25 Apr 2013 14:48:50 -0400
Received: from mout.web.de ([212.227.17.11]:52124 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758843Ab3DYSst convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Apr 2013 14:48:49 -0400
Received: from appes.localnet ([195.67.191.23]) by smtp.web.de (mrweb001) with
 ESMTPA (Nemesis) id 0MhlT9-1U9cyh3OGh-00MwGZ for <git@vger.kernel.org>; Thu,
 25 Apr 2013 20:48:48 +0200
X-Provags-ID: V02:K0:W7rmJtkkpYrDZE1kSQjqNbvToVWrpleKIbD0jT2x0Zf
 h+HftMeDctoMIF2N/SynK7ZvnBJDpw8wyXyEvbMTcIc7yaP07d
 Rc/z200P4yuMkZ1uuXn6yoZ/3RFZRxjb1POdmSPMyEjcHZXIlA
 zU9OLX4T+oB4ezEUslYp2YGV2Lmj0yk4WLSMwZgaqNeSOId8eY
 p5LqRQk1Kivj3eI2oteHA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222412>

The make test-lint could check for lines like
export X=3DY

This is bash syntax and should be written in 2 lines:
X=3DY
export X

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---
 t/check-non-portable-shell.pl | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/check-non-portable-shell.pl b/t/check-non-portable-shell=
=2Epl
index 1ca8c8b..6a11b02 100755
--- a/t/check-non-portable-shell.pl
+++ b/t/check-non-portable-shell.pl
@@ -11,7 +11,7 @@ my $bashmode=3D0;
=20
 sub err {
 	my $msg =3D shift;
-	print "$ARGV:$.: error: (bashmode=3D$bashmode) $msg: $_\n";
+	print "$ARGV:$.: error: $msg: $_\n";
 	$exit_code =3D 1;
 }
=20
@@ -25,6 +25,7 @@ while (<>) {
 	/^\s*declare\s+/ and err 'arrays/declare not portable';
 	/^\s*[^#]\s*which\s/ and err 'which is not portable (please use type)=
';
 	$bashmode=3D=3D0 and /test\s+[^=3D]*=3D=3D/ and err '"test a =3D=3D b=
" is not portable (please use =3D)';
+	$bashmode=3D=3D0 and /^\s*export\s+\S+=3D\S+/ and err '"export X=3DY"=
 is not portable (please split into 2 lines)';
 	# this resets our $. for each file
 	close ARGV if eof;
 	$bashmode=3D0 if eof;
--=20
1.8.2.1.614.g66d7af5
