From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH] test-lib: simplify '--option=value' parsing
Date: Fri, 22 Apr 2016 17:38:23 +0200
Message-ID: <1461339503-6854-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 22 17:52:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1atdNC-0000Bk-SX
	for gcvg-git-2@plane.gmane.org; Fri, 22 Apr 2016 17:52:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754500AbcDVPvx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 22 Apr 2016 11:51:53 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:50987 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754107AbcDVPi7 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Apr 2016 11:38:59 -0400
Received: from x590e2083.dyn.telefonica.de ([89.14.32.131] helo=localhost.localdomain)
	by iramx2.ira.uni-karlsruhe.de with esmtpsa port 587 
	iface 141.3.10.81 id 1atdAV-0007yw-Cb; Fri, 22 Apr 2016 17:38:56 +0200
X-Mailer: git-send-email 2.8.1.99.g5d5236f
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de  esmtpsa 1461339536.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292227>

To get the 'value' from '--option=3Dvalue', test-lib.sh parses said
option running 'expr' with a regexp.  This involves a subshell, an
external process, and a lot of non-alphanumeric characters in the
regexp.

Use a much simpler shell parameter expansion instead to do the same.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 t/test-lib.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 0b47eb6bb299..8373d5b5c900 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -208,7 +208,7 @@ do
 	-v|--v|--ve|--ver|--verb|--verbo|--verbos|--verbose)
 		verbose=3Dt; shift ;;
 	--verbose-only=3D*)
-		verbose_only=3D$(expr "z$1" : 'z[^=3D]*=3D\(.*\)')
+		verbose_only=3D${1#--*=3D}
 		shift ;;
 	-q|--q|--qu|--qui|--quie|--quiet)
 		# Ignore --quiet under a TAP::Harness. Saying how many tests
@@ -222,15 +222,15 @@ do
 		valgrind=3Dmemcheck
 		shift ;;
 	--valgrind=3D*)
-		valgrind=3D$(expr "z$1" : 'z[^=3D]*=3D\(.*\)')
+		valgrind=3D${1#--*=3D}
 		shift ;;
 	--valgrind-only=3D*)
-		valgrind_only=3D$(expr "z$1" : 'z[^=3D]*=3D\(.*\)')
+		valgrind_only=3D${1#--*=3D}
 		shift ;;
 	--tee)
 		shift ;; # was handled already
 	--root=3D*)
-		root=3D$(expr "z$1" : 'z[^=3D]*=3D\(.*\)')
+		root=3D${1#--*=3D}
 		shift ;;
 	--chain-lint)
 		GIT_TEST_CHAIN_LINT=3D1
--=20
2.8.1.99.g5d5236f
