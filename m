From: =?utf-8?Q?Santi_B=C3=A9jar?= <sbejar@gmail.com>
Subject: [PATCH] git-reset: make the output as the fetch output
Date: Wed, 17 Jan 2007 13:56:15 +0100
Message-ID: <87odox23u9.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Wed Jan 17 14:14:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H7AcW-0004zW-VD
	for gcvg-git@gmane.org; Wed, 17 Jan 2007 14:14:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751073AbXAQNO0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 17 Jan 2007 08:14:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751338AbXAQNO0
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Jan 2007 08:14:26 -0500
Received: from ifae-s0.ifae.es ([192.101.162.68]:50274 "EHLO ifae-s0.ifae.es"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751073AbXAQNO0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jan 2007 08:14:26 -0500
Received: from bela (caronte.ifae.es [192.101.162.199])
	by ifae-s0.ifae.es (8.11.6/8.11.6) with ESMTP id l0HDEMe21105
	for <git@vger.kernel.org>; Wed, 17 Jan 2007 14:14:24 +0100
To: Git Mailing List <git@vger.kernel.org>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/22.0.92 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36998>


=2E.. and only when HEAD is changed.

Signed-off-by: Santi B=C3=A9jar <sbejar@gmail.com>
---
 git-reset.sh |   19 +++++++++++++------
 1 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/git-reset.sh b/git-reset.sh
index bf2a058..acefddc 100755
--- a/git-reset.sh
+++ b/git-reset.sh
@@ -24,6 +24,7 @@ do
 		usage
 		;;
 	*)
+		commit=3D"$1"
 		rev=3D$(git-rev-parse --verify "$1") || exit
 		shift
 		break
@@ -84,14 +85,20 @@ fi
 git-update-ref -m "$GIT_REFLOG_ACTION" HEAD "$rev"
 update_ref_status=3D$?
=20
+if test $update_ref_status =3D 0 && test "$orig" !=3D "$rev"
+then
+    revshort=3D$(git-rev-parse --short $rev)
+    echo "* HEAD: reset to $commit"
+    if test "$orig" ; then
+	echo "  old..new: $(git-rev-parse --short $orig)..$revshort"
+    else
+	echo "  commit: $revshort"
+    fi
+fi
+
 case "$reset_type" in
 --hard )
-	test $update_ref_status =3D 0 && {
-		printf "HEAD is now at "
-		GIT_PAGER=3D git log --max-count=3D1 --pretty=3Doneline \
-			--abbrev-commit HEAD
-	}
-	;;
+	;; # Nothing else to do
 --soft )
 	;; # Nothing else to do
 --mixed )
--=20
1.5.0.rc1.g0dee5
