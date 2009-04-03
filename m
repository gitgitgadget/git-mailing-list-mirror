From: Jeff King <peff@peff.net>
Subject: [PATCH 2/4] tests: remove exit after test_done call
Date: Fri, 3 Apr 2009 15:31:10 -0400
Message-ID: <20090403193110.GB5547@coredump.intra.peff.net>
References: <20090403192700.GA14965@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Robin H. Johnson" <robbat2@gentoo.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 03 21:33:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lpp8P-0003yP-2P
	for gcvg-git-2@gmane.org; Fri, 03 Apr 2009 21:33:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932747AbZDCTb2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Apr 2009 15:31:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932603AbZDCTb1
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Apr 2009 15:31:27 -0400
Received: from peff.net ([208.65.91.99]:50425 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760473AbZDCTb0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Apr 2009 15:31:26 -0400
Received: (qmail 1093 invoked by uid 107); 3 Apr 2009 19:31:43 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 03 Apr 2009 15:31:43 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 03 Apr 2009 15:31:10 -0400
Content-Disposition: inline
In-Reply-To: <20090403192700.GA14965@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115556>

test_done always exits, so this line is never executed.

Signed-off-by: Jeff King <peff@peff.net>
---
A cleanup I noticed while adding more test skipping. Technically these
lines were not hurting anything, but I think it prevents a reader from
wondering why some test_done instances are followed by exit and some are
not.

And just look at that diffstat line count. It _must_ be an improvement!

 t/lib-git-svn.sh                       |    4 ----
 t/lib-httpd.sh                         |    3 ---
 t/t4004-diff-rename-symlink.sh         |    1 -
 t/t4011-diff-symlink.sh                |    1 -
 t/t4023-diff-rename-typechange.sh      |    1 -
 t/t4114-apply-typechange.sh            |    1 -
 t/t4115-apply-symlink.sh               |    1 -
 t/t4122-apply-symlink-inside.sh        |    1 -
 t/t5503-tagfollow.sh                   |    1 -
 t/t5522-pull-symlink.sh                |    1 -
 t/t5540-http-push.sh                   |    1 -
 t/t7005-editor.sh                      |    1 -
 t/t9200-git-cvsexportcommit.sh         |    1 -
 t/t9400-git-cvsserver-server.sh        |    2 --
 t/t9401-git-cvsserver-crlf.sh          |    2 --
 t/t9500-gitweb-standalone-no-errors.sh |    1 -
 t/t9600-cvsimport.sh                   |    3 ---
 17 files changed, 0 insertions(+), 26 deletions(-)

diff --git a/t/lib-git-svn.sh b/t/lib-git-svn.sh
index de384e6..cdd7ccd 100644
--- a/t/lib-git-svn.sh
+++ b/t/lib-git-svn.sh
@@ -7,7 +7,6 @@ if test -n "$NO_SVN_TESTS"
 then
 	say 'skipping git svn tests, NO_SVN_TESTS defined'
 	test_done
-	exit
 fi
 
 GIT_DIR=$PWD/.git
@@ -19,7 +18,6 @@ if test $? -ne 1
 then
     say 'skipping git svn tests, svn not found'
     test_done
-    exit
 fi
 
 svnrepo=$PWD/svnrepo
@@ -43,7 +41,6 @@ then
 	fi
 	say "$err"
 	test_done
-	exit
 fi
 
 rawsvnrepo="$svnrepo"
@@ -144,7 +141,6 @@ require_svnserve () {
     then
         say 'skipping svnserve test. (set $SVNSERVE_PORT to enable)'
         test_done
-        exit
     fi
 }
 
diff --git a/t/lib-httpd.sh b/t/lib-httpd.sh
index 589aaf8..cde659d 100644
--- a/t/lib-httpd.sh
+++ b/t/lib-httpd.sh
@@ -8,7 +8,6 @@ then
 	say "skipping test, network testing disabled by default"
 	say "(define GIT_TEST_HTTPD to enable)"
 	test_done
-	exit
 fi
 
 HTTPD_PARA=""
@@ -36,7 +35,6 @@ if ! test -x "$LIB_HTTPD_PATH"
 then
 	say "skipping test, no web server found at '$LIB_HTTPD_PATH'"
 	test_done
-	exit
 fi
 
 HTTPD_VERSION=`$LIB_HTTPD_PATH -v | \
@@ -50,7 +48,6 @@ then
 		then
 			say "skipping test, at least Apache version 2 is required"
 			test_done
-			exit
 		fi
 
 		LIB_HTTPD_MODULE_PATH="$DEFAULT_HTTPD_MODULE_PATH"
diff --git a/t/t4004-diff-rename-symlink.sh b/t/t4004-diff-rename-symlink.sh
index 3db7444..a4da119 100755
--- a/t/t4004-diff-rename-symlink.sh
+++ b/t/t4004-diff-rename-symlink.sh
@@ -16,7 +16,6 @@ if ! test_have_prereq SYMLINKS
 then
 	say 'Symbolic links not supported, skipping tests.'
 	test_done
-	exit
 fi
 
 test_expect_success \
diff --git a/t/t4011-diff-symlink.sh b/t/t4011-diff-symlink.sh
index 3a81309..d7e327c 100755
--- a/t/t4011-diff-symlink.sh
+++ b/t/t4011-diff-symlink.sh
@@ -13,7 +13,6 @@ if ! test_have_prereq SYMLINKS
 then
 	say 'Symbolic links not supported, skipping tests.'
 	test_done
-	exit
 fi
 
 cat > expected << EOF
diff --git a/t/t4023-diff-rename-typechange.sh b/t/t4023-diff-rename-typechange.sh
index 5099862..9bdf659 100755
--- a/t/t4023-diff-rename-typechange.sh
+++ b/t/t4023-diff-rename-typechange.sh
@@ -8,7 +8,6 @@ if ! test_have_prereq SYMLINKS
 then
 	say 'Symbolic links not supported, skipping tests.'
 	test_done
-	exit
 fi
 
 test_expect_success setup '
diff --git a/t/t4114-apply-typechange.sh b/t/t4114-apply-typechange.sh
index 7dc35de..99ec13d 100755
--- a/t/t4114-apply-typechange.sh
+++ b/t/t4114-apply-typechange.sh
@@ -13,7 +13,6 @@ if ! test_have_prereq SYMLINKS
 then
 	say 'Symbolic links not supported, skipping tests.'
 	test_done
-	exit
 fi
 
 test_expect_success 'setup repository and commits' '
diff --git a/t/t4115-apply-symlink.sh b/t/t4115-apply-symlink.sh
index 1a3aea3..b852e58 100755
--- a/t/t4115-apply-symlink.sh
+++ b/t/t4115-apply-symlink.sh
@@ -13,7 +13,6 @@ if ! test_have_prereq SYMLINKS
 then
 	say 'Symbolic links not supported, skipping tests.'
 	test_done
-	exit
 fi
 
 test_expect_success setup '
diff --git a/t/t4122-apply-symlink-inside.sh b/t/t4122-apply-symlink-inside.sh
index 8aad20b..0d3c1d5 100755
--- a/t/t4122-apply-symlink-inside.sh
+++ b/t/t4122-apply-symlink-inside.sh
@@ -7,7 +7,6 @@ if ! test_have_prereq SYMLINKS
 then
 	say 'Symbolic links not supported, skipping tests.'
 	test_done
-	exit
 fi
 
 lecho () {
diff --git a/t/t5503-tagfollow.sh b/t/t5503-tagfollow.sh
index e75ccbc..d5db75d 100755
--- a/t/t5503-tagfollow.sh
+++ b/t/t5503-tagfollow.sh
@@ -8,7 +8,6 @@ case $(uname -s) in
 *MINGW*)
 	say "GIT_DEBUG_SEND_PACK not supported - skipping tests"
 	test_done
-	exit
 esac
 
 # End state of the repository:
diff --git a/t/t5522-pull-symlink.sh b/t/t5522-pull-symlink.sh
index d887eb6..86bbd7d 100755
--- a/t/t5522-pull-symlink.sh
+++ b/t/t5522-pull-symlink.sh
@@ -8,7 +8,6 @@ if ! test_have_prereq SYMLINKS
 then
 	say 'Symbolic links not supported, skipping tests.'
 	test_done
-	exit
 fi
 
 # The scenario we are building:
diff --git a/t/t5540-http-push.sh b/t/t5540-http-push.sh
index c46592f..5fe479e 100755
--- a/t/t5540-http-push.sh
+++ b/t/t5540-http-push.sh
@@ -17,7 +17,6 @@ if git http-push > /dev/null 2>&1 || [ $? -eq 128 ]
 then
 	say "skipping test, USE_CURL_MULTI is not defined"
 	test_done
-	exit
 fi
 
 . "$TEST_DIRECTORY"/lib-httpd.sh
diff --git a/t/t7005-editor.sh b/t/t7005-editor.sh
index e83bc8f..b647957 100755
--- a/t/t7005-editor.sh
+++ b/t/t7005-editor.sh
@@ -92,7 +92,6 @@ if ! echo 'echo space > "$1"' > "e space.sh"
 then
 	say "Skipping; FS does not support spaces in filenames"
 	test_done
-	exit
 fi
 
 test_expect_success 'editor with a space' '
diff --git a/t/t9200-git-cvsexportcommit.sh b/t/t9200-git-cvsexportcommit.sh
index 995f607..3665692 100755
--- a/t/t9200-git-cvsexportcommit.sh
+++ b/t/t9200-git-cvsexportcommit.sh
@@ -11,7 +11,6 @@ if test $? -ne 1
 then
     say 'skipping git cvsexportcommit tests, cvs not found'
     test_done
-    exit
 fi
 
 CVSROOT=$(pwd)/cvsroot
diff --git a/t/t9400-git-cvsserver-server.sh b/t/t9400-git-cvsserver-server.sh
index 466240c..39185db 100755
--- a/t/t9400-git-cvsserver-server.sh
+++ b/t/t9400-git-cvsserver-server.sh
@@ -15,12 +15,10 @@ if test $? -ne 1
 then
     say 'skipping git-cvsserver tests, cvs not found'
     test_done
-    exit
 fi
 perl -e 'use DBI; use DBD::SQLite' >/dev/null 2>&1 || {
     say 'skipping git-cvsserver tests, Perl SQLite interface unavailable'
     test_done
-    exit
 }
 
 unset GIT_DIR GIT_CONFIG
diff --git a/t/t9401-git-cvsserver-crlf.sh b/t/t9401-git-cvsserver-crlf.sh
index 8882230..12e0e50 100755
--- a/t/t9401-git-cvsserver-crlf.sh
+++ b/t/t9401-git-cvsserver-crlf.sh
@@ -51,12 +51,10 @@ if test $? -ne 1
 then
     say 'skipping git-cvsserver tests, cvs not found'
     test_done
-    exit
 fi
 perl -e 'use DBI; use DBD::SQLite' >/dev/null 2>&1 || {
     say 'skipping git-cvsserver tests, Perl SQLite interface unavailable'
     test_done
-    exit
 }
 
 unset GIT_DIR GIT_CONFIG
diff --git a/t/t9500-gitweb-standalone-no-errors.sh b/t/t9500-gitweb-standalone-no-errors.sh
index 9ec5030..0bd332c 100755
--- a/t/t9500-gitweb-standalone-no-errors.sh
+++ b/t/t9500-gitweb-standalone-no-errors.sh
@@ -68,7 +68,6 @@ gitweb_run () {
 perl -MEncode -e 'decode_utf8("", Encode::FB_CROAK)' >/dev/null 2>&1 || {
     say 'skipping gitweb tests, perl version is too old'
     test_done
-    exit
 }
 
 gitweb_init
diff --git a/t/t9600-cvsimport.sh b/t/t9600-cvsimport.sh
index d2379e7..33eb519 100755
--- a/t/t9600-cvsimport.sh
+++ b/t/t9600-cvsimport.sh
@@ -14,7 +14,6 @@ if ! type cvs >/dev/null 2>&1
 then
 	say 'skipping cvsimport tests, cvs not found'
 	test_done
-	exit
 fi
 
 cvsps_version=`cvsps -h 2>&1 | sed -ne 's/cvsps version //p'`
@@ -24,12 +23,10 @@ case "$cvsps_version" in
 '')
 	say 'skipping cvsimport tests, cvsps not found'
 	test_done
-	exit
 	;;
 *)
 	say 'skipping cvsimport tests, unsupported cvsps version'
 	test_done
-	exit
 	;;
 esac
 
-- 
1.6.2.2.569.g2d4b2
