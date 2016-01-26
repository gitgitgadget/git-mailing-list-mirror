From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v2 19/19] mingw: do not bother to test funny file names
Date: Tue, 26 Jan 2016 15:35:43 +0100 (CET)
Message-ID: <47914e4ceb3ea51636dd5ae308679c9c92fcbef0.1453818790.git.johannes.schindelin@gmx.de>
References: <cover.1453650173.git.johannes.schindelin@gmx.de> <cover.1453818789.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=X-UNKNOWN
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 26 15:36:06 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aO4is-00052g-Gx
	for gcvg-git-2@plane.gmane.org; Tue, 26 Jan 2016 15:35:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966116AbcAZOfv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jan 2016 09:35:51 -0500
Received: from mout.gmx.net ([212.227.17.22]:56128 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965226AbcAZOfr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jan 2016 09:35:47 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0MSq5p-1aVbE51aab-00RoXS; Tue, 26 Jan 2016 15:35:44
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <cover.1453818789.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:UpH2qj8zza13HvTU/viVptqu4dZKtPUiJsJeibw1Imxk2NBLxra
 yowS91I0Gz/jqEjAk7pW7w9pW3W10zL8DcunidwUyhBEOuC4BGy2Dc0706H41J499QpBTVM
 pgZzr7uZGEao6Dux9Znlzt3/IQzkBQJg2eW2Nds7+gDTgufTlkhn7W+uNPg5g0jOyXG6vKn
 be061jSwaiWA3ocwiEpcA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ikKSVZpamw0=:6uYduJFolGF+6/NobwWEv8
 kvKFJlrPwUbLicqdkGwrMsj2lY41ORSIiMyI4zFX1OU/DvGuozzal4TnTcsa/TUH17VYcRNy9
 tVVG/VOy29IKApqpT4+E6O1Bcw8BWD5et8J4ICLJtW07wkRzJ2F8QbA93ksTM6zHmNbxo1mNm
 Bo4j8cGqYF1ho9EgRKIBeVEFhsvDczbSMrMegPRL59bpDVnQv/yhpOlmQXAB/8ZHhBdIc8yF/
 Kx6IoSACicdMiZuZenWQHAvs4pVaXa5ltKuF+JgPx7mSxD0EO/xpTu1z/nYEPsZaWMLRAChiE
 nII5ZuAxMjUFbNrxEyIILSX98jr4qCRlzoVsIhOjAG2Lhl+5x8Aseze268X/zymBlKx0Nd/h+
 FcrJ9Wb6bgCwJaTlW+wJmR93VvUJ94mEreoME7BALibu2K0m4rx7o971j6UA8zuhbsthUUbs1
 ic/3pSrz079zE2TsEjT+oBXPoQ6F7BGB7+nGP9N+FRaXN7/Xt1VNZv5JALijac1Hn5gsjgRRd
 /TCtdqiR0oaJ7vtNtPZs14M8bxrwtQt/R0Kn3zRqRc9tA6vjASkHEPtKgb/kxjwp26DIwZ0Mm
 NuSdmp6zxWIAkW5mo6jl1wlbkgf6YsbeEqjitaxl2/l4hdiDlsl1s1WoLP+nG3V6ggB++h+eD
 myC4I66qEFnl9Hkcef//qvbAy95ZZ+BOeJXnMMv0x6ksv+76qZMmM9JcDe1RU4i1CsNTLsi5Z
 k+RJhA6dB8uxFFP/sHziIVo2CoDjRZpJGCTyPrzHgB8s2E+ND5C6FXOKZsJzOOD37/GNC5FP 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284829>

MSYS2 actually allows to create files or directories whose names contain
tabs, newlines or colors, even if plain Win32 API cannot access them.
As we are using an MSYS2 bash to run the tests, such files or
directories are created successfully, but Git itself has no chance to
work with them because it is a regular Windows program, hence limited by
the Win32 API.

With this change, on Windows otherwise failing tests in
t3300-funny-names.sh, t3600-rm.sh, t3703-add-magic-pathspec.sh,
t3902-quoted.sh, t4016-diff-quote.sh, t4135-apply-weird-filenames.sh,
t9200-git-cvsexportcommit.sh, and t9903-bash-prompt.sh are skipped.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t3300-funny-names.sh           | 1 +
 t/t3600-rm.sh                    | 3 ++-
 t/t3703-add-magic-pathspec.sh    | 2 +-
 t/t3902-quoted.sh                | 1 +
 t/t4016-diff-quote.sh            | 1 +
 t/t4135-apply-weird-filenames.sh | 3 ++-
 t/t9200-git-cvsexportcommit.sh   | 2 +-
 t/t9903-bash-prompt.sh           | 2 +-
 8 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/t/t3300-funny-names.sh b/t/t3300-funny-names.sh
index 9a146f1..04de03c 100755
--- a/t/t3300-funny-names.sh
+++ b/t/t3300-funny-names.sh
@@ -13,6 +13,7 @@ tree, index, and tree objects.
 
 HT='	'
 
+test_have_prereq MINGW ||
 echo 2>/dev/null > "Name with an${HT}HT"
 if ! test -f "Name with an${HT}HT"
 then
diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
index 2e47a2b..5232ee9 100755
--- a/t/t3600-rm.sh
+++ b/t/t3600-rm.sh
@@ -14,7 +14,8 @@ test_expect_success \
      git add -- foo bar baz 'space embedded' -q &&
      git commit -m 'add normal files'"
 
-if touch -- 'tab	embedded' 'newline
+
+if ! test_have_prereq MINGW && touch -- 'tab	embedded' 'newline
 embedded' 2>/dev/null
 then
 	test_set_prereq FUNNYNAMES
diff --git a/t/t3703-add-magic-pathspec.sh b/t/t3703-add-magic-pathspec.sh
index 5115de7..aaff784 100755
--- a/t/t3703-add-magic-pathspec.sh
+++ b/t/t3703-add-magic-pathspec.sh
@@ -38,7 +38,7 @@ cat >expected <<EOF
 add 'sub/foo'
 EOF
 
-if mkdir ":" 2>/dev/null
+if ! test_have_prereq MINGW && mkdir ":" 2>/dev/null
 then
 	test_set_prereq COLON_DIR
 fi
diff --git a/t/t3902-quoted.sh b/t/t3902-quoted.sh
index 892f567..f528008 100755
--- a/t/t3902-quoted.sh
+++ b/t/t3902-quoted.sh
@@ -12,6 +12,7 @@ GN='???'
 HT='	'
 DQ='"'
 
+test_have_prereq MINGW ||
 echo foo 2>/dev/null > "Name and an${HT}HT"
 if ! test -f "Name and an${HT}HT"
 then
diff --git a/t/t4016-diff-quote.sh b/t/t4016-diff-quote.sh
index cd543ec..9c48e5c 100755
--- a/t/t4016-diff-quote.sh
+++ b/t/t4016-diff-quote.sh
@@ -13,6 +13,7 @@ P1='pathname	with HT'
 P2='pathname with SP'
 P3='pathname
 with LF'
+test_have_prereq !MINGW &&
 echo 2>/dev/null >"$P1" && test -f "$P1" && rm -f "$P1" || {
 	skip_all='Your filesystem does not allow tabs in filenames'
 	test_done
diff --git a/t/t4135-apply-weird-filenames.sh b/t/t4135-apply-weird-filenames.sh
index bf5dc57..6d6b96d 100755
--- a/t/t4135-apply-weird-filenames.sh
+++ b/t/t4135-apply-weird-filenames.sh
@@ -19,7 +19,8 @@ test_expect_success 'setup' '
 
 	test_when_finished "rm -f \"tab	embedded.txt\"" &&
 	test_when_finished "rm -f '\''\"quoteembedded\".txt'\''" &&
-	if touch -- "tab	embedded.txt" '\''"quoteembedded".txt'\''
+	if ! test_have_prereq MINGW &&
+		touch -- "tab	embedded.txt" '\''"quoteembedded".txt'\''
 	then
 		test_set_prereq FUNNYNAMES
 	fi
diff --git a/t/t9200-git-cvsexportcommit.sh b/t/t9200-git-cvsexportcommit.sh
index 812c9cd..5cfb9cf 100755
--- a/t/t9200-git-cvsexportcommit.sh
+++ b/t/t9200-git-cvsexportcommit.sh
@@ -197,7 +197,7 @@ if p="??/goo/a/b/c/d/e/f/g/h/i/j/k/l/m/n/o/p/q/r/s/t/u/v/w/x/y/z/??/??/??" &&
 then
 
 # This test contains UTF-8 characters
-test_expect_success \
+test_expect_success !MINGW \
      'File with non-ascii file name' \
      'mkdir -p ??/goo/a/b/c/d/e/f/g/h/i/j/k/l/m/n/o/p/q/r/s/t/u/v/w/x/y/z/??/??/?? &&
       echo Foo >??/goo/a/b/c/d/e/f/g/h/i/j/k/l/m/n/o/p/q/r/s/t/u/v/w/x/y/z/??/??/??/g??rdets??g??rdet.txt &&
diff --git a/t/t9903-bash-prompt.sh b/t/t9903-bash-prompt.sh
index af82049..2ee6564 100755
--- a/t/t9903-bash-prompt.sh
+++ b/t/t9903-bash-prompt.sh
@@ -67,7 +67,7 @@ repo_with_newline='repo
 with
 newline'
 
-if mkdir "$repo_with_newline" 2>/dev/null
+if ! test_have_prereq MINGW && mkdir "$repo_with_newline" 2>/dev/null
 then
 	test_set_prereq FUNNYNAMES
 else
-- 
2.7.0.windows.1.7.g55a05c8
