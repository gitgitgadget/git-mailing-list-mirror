From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH v2] test-lib: simplify '--option=value' parsing
Date: Fri, 22 Apr 2016 22:32:21 +0200
Message-ID: <1461357141-12417-1-git-send-email-szeder@ira.uka.de>
References: <20160422183703.GA7595@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 22 22:33:12 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1athlH-0000zK-QO
	for gcvg-git-2@plane.gmane.org; Fri, 22 Apr 2016 22:33:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752461AbcDVUdH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 22 Apr 2016 16:33:07 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:54084 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751470AbcDVUdG (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Apr 2016 16:33:06 -0400
Received: from x590e2083.dyn.telefonica.de ([89.14.32.131] helo=localhost.localdomain)
	by iramx2.ira.uni-karlsruhe.de with esmtpsa port 587 
	iface 141.3.10.81 id 1athl4-0000Ep-UT; Fri, 22 Apr 2016 22:33:00 +0200
X-Mailer: git-send-email 2.8.1.99.g5d5236f
In-Reply-To: <20160422183703.GA7595@sigill.intra.peff.net>
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de  esmtpsa 1461357180.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292264>

To get the 'value' from '--option=3Dvalue', test-lib.sh parses said
option running 'expr' with a regexp.  This involves a subshell, an
external process, and a lot of non-alphanumeric characters in the
regexp.

Use a much simpler POSIX-defined shell parameter expansion instead to
do the same.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---

>>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> I count 5 cases in my copy of test-lib.sh. I think you are missing
> "--run".

Oh, indeed, '--run' managed to hide between these
-l|--l|--lo|--lon|--long patterns.


 t/test-lib.sh | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 0b47eb6bb299..79afa8748eec 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -202,13 +202,13 @@ do
 		}
 		run_list=3D$1; shift ;;
 	--run=3D*)
-		run_list=3D$(expr "z$1" : 'z[^=3D]*=3D\(.*\)'); shift ;;
+		run_list=3D${1#--*=3D}; shift ;;
 	-h|--h|--he|--hel|--help)
 		help=3Dt; shift ;;
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
