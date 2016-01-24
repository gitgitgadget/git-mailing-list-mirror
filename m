From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 19/19] mingw: do not bother to test funny file names
Date: Sun, 24 Jan 2016 16:45:56 +0100 (CET)
Message-ID: <9f41daa9890b458e485407fb0a3ffa59e0c1ead6.1453650173.git.johannes.schindelin@gmx.de>
References: <cover.1453650173.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=X-UNKNOWN
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 24 16:46:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aNMrk-0001pG-BD
	for gcvg-git-2@plane.gmane.org; Sun, 24 Jan 2016 16:46:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754100AbcAXPqI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Jan 2016 10:46:08 -0500
Received: from mout.gmx.net ([212.227.17.20]:50680 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753967AbcAXPqG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jan 2016 10:46:06 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0M1jKo-1a8K5P26iQ-00tmKX; Sun, 24 Jan 2016 16:45:57
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <cover.1453650173.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:LdtuYtoaOjZYPRJ9+ck+KDiHexr4gQfG0kS5jd7x8U9OPZLeUXW
 PnvKOeLKDo4auwRS2eMftmcQohCRexamsdOITwdaJe6/xC1SJCqhW/gURexDK5bVCfKtIEB
 cLONPrFmmG7Q9jkWIdKNnnKPLULc6CLFhA1yULP+ov/sfilddmbGpKbb/4mw8aIiDXg+0UY
 JVAuK1gRQdXAPDoky1spQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:xqkdrmYh8yw=:HC9JWIssWZZaAlg9h8cktg
 vfHRDITcKpPumkSHp1WwBWTGJzEBi39Ha6hhMQICO/JSchxCABXh52jOzCbKuQ04maZxSqcwa
 I8ZCRYWvHEuKp4szL2lLvVBA5dqMwiZ3ZXlXKgrO3llNxUQTSd40KP6BQB4ipwZdioHQ0AcYB
 /k6DIZOxGrTctcD/pNOLzw1PGXY1Pqpc3Mq9DwzbEcCDRVnjhOMFxIpphoTv4oSD1hfBBIy96
 ldrwEYahbzwTqTrK6REh+S83TFMVBBE2D6tnFRe7aIA/JGqr5HHgGNJHwJlPhHlURb1mNMYIw
 NapJbrSoqxLfq/zn7PRcpEeDqSGoRE4Q6STv71g7h5/qTJ5EiEJvdkAx8pMImas+rJhrtIOmw
 m7TJ/GR0+R9/z2OJSuK4KyNgHfdLjk4afP4SkMVHHDo98YFSYR+2K7SEV2xxv2AvmYog4hbX0
 YGbOOIF1fjhY8U5JIEZGF6/rGIYMA7x2KY5Z8F7+3gGE4DRKnzxfDIwzWGxSiHebZli8uXBT2
 Q9GiIJ3ounpjkWS4pGTPaAMvSs440a86wTuEqFGtkosSvCWU+Jhm37VpWSXHUyTeDHnbmBEIa
 MpqguALvwJ+SMb7JhMdZEVDGEn5SnfudvVSZ2nZepUMYCfdjm43rTXAoF+lxVA4/kdo/u1rQn
 nwne6djIrpPtB52Dq3zyn0Uk/3YkfWIGpJi20luaASWKfK9Ioon9J1Toz+0wwZye0NiQvkRI8
 6BT1L0A9mO4JVq8fRJeJ0P64Zq2eoYnEn6yS5GZEUO/PulPpixpzEwh1E3Fd4C8wQreLcqr9 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284683>

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
