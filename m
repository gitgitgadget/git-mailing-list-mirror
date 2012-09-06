From: Jan-Marek Glogowski <glogow@fbihome.de>
Subject: =?UTF-8?q?=5BPATCH=5D=20Prefix=20shell=20test=20output=20messages=20with=20test=20id?=
Date: Thu,  6 Sep 2012 13:45:21 +0200
Message-ID: <1346931921-5901-1-git-send-email-glogow@fbihome.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jan-Marek Glogowski <glogow@fbihome.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 06 13:51:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T9acj-0003Mq-5d
	for gcvg-git-2@plane.gmane.org; Thu, 06 Sep 2012 13:51:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750998Ab2IFLvq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 6 Sep 2012 07:51:46 -0400
Received: from ironman.h-da.de ([141.100.10.250]:35460 "EHLO ironman.h-da.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750792Ab2IFLvo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Sep 2012 07:51:44 -0400
X-Greylist: delayed 362 seconds by postgrey-1.27 at vger.kernel.org; Thu, 06 Sep 2012 07:51:44 EDT
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Av0EALeLSFCNZChB/2dsb2JhbAA7CoYGtRiBB4JKDwEUMjUCJgJyiBEHp2CDb48SgSGKAIUjgRIDpXOCZQ
Received: from mail.fbihome.de ([141.100.40.65])
  by ironman.h-da.de with ESMTP/TLS/DHE-RSA-AES256-SHA; 06 Sep 2012 13:45:40 +0200
Received: from localhost (localhost [127.0.0.1])
	by mail.fbihome.de (Postfix) with ESMTP id E6995932BD;
	Thu,  6 Sep 2012 13:45:40 +0200 (CEST)
Received: from mail.fbihome.de ([127.0.0.1])
	by localhost (stud1 [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 17841-16; Thu, 6 Sep 2012 13:45:40 +0200 (CEST)
Received: from kvm-sbuild.tvc.muenchen.de (unknown [194.113.41.246])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.fbihome.de (Postfix) with ESMTP id 9E081932BC;
	Thu,  6 Sep 2012 13:45:40 +0200 (CEST)
X-Mailer: git-send-email 1.7.11.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204875>

This adds the test ID (tXXXX) prefix to the test result message of
all shell tests.  This is especially useful when doing a parallel
check run, where it's currently quite hard to identify the actual
failing test case.

Signed-off-by: Jan-Marek Glogowski <glogow@fbihome.de>
---
 t/t0000-basic.sh        | 28 ++++++++++++++--------------
 t/test-lib-functions.sh | 11 +++++++----
 t/test-lib.sh           | 10 ++++++----
 3 Dateien ge=C3=A4ndert, 27 Zeilen hinzugef=C3=BCgt(+), 22 Zeilen entf=
ernt(-)

diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index ccb5435..1bbf5b8 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -58,7 +58,7 @@ test_expect_failure 'pretend we have a known breakage=
' '
 test_expect_success 'pretend we have fixed a known breakage (run in su=
b test-lib)' "
 	mkdir passing-todo &&
 	(cd passing-todo &&
-	cat >passing-todo.sh <<-EOF &&
+	cat >0000t05-passing-todo.sh <<-EOF &&
 	#!$SHELL_PATH
=20
 	test_description=3D'A passing TODO test
@@ -77,14 +77,14 @@ test_expect_success 'pretend we have fixed a known =
breakage (run in sub test-lib
=20
 	test_done
 	EOF
-	chmod +x passing-todo.sh &&
-	./passing-todo.sh >out 2>err &&
+	chmod +x 0000t05-passing-todo.sh &&
+	./0000t05-passing-todo.sh >out 2>err &&
 	! test -s err &&
 	sed -e 's/^> //' >expect <<-\\EOF &&
-	> ok 1 - pretend we have fixed a known breakage # TODO known breakage
-	> # fixed 1 known breakage(s)
-	> # passed all 1 test(s)
-	> 1..1
+	> 0000t05: ok 1 - pretend we have fixed a known breakage # TODO known=
 breakage
+	> 0000t05: # fixed 1 known breakage(s)
+	> 0000t05: # passed all 1 test(s)
+	> 0000t05: 1..1
 	EOF
 	test_cmp expect out)
 "
@@ -141,7 +141,7 @@ test_expect_success 'tests clean up even on failure=
s' "
 	(
 	cd failing-cleanup &&
=20
-	cat >failing-cleanup.sh <<-EOF &&
+	cat >0000t12-failing-cleanup.sh <<-EOF &&
 	#!$SHELL_PATH
=20
 	test_description=3D'Failing tests with cleanup commands'
@@ -162,23 +162,23 @@ test_expect_success 'tests clean up even on failu=
res' "
=20
 	EOF
=20
-	chmod +x failing-cleanup.sh &&
-	test_must_fail ./failing-cleanup.sh >out 2>err &&
+	chmod +x 0000t12-failing-cleanup.sh &&
+	test_must_fail ./0000t12-failing-cleanup.sh >out 2>err &&
 	! test -s err &&
 	! test -f \"trash directory.failing-cleanup/clean-after-failure\" &&
 	sed -e 's/Z$//' -e 's/^> //' >expect <<-\\EOF &&
-	> not ok - 1 tests clean up even after a failure
+	> 0000t12: not ok 1 - tests clean up even after a failure
 	> #	Z
 	> #	touch clean-after-failure &&
 	> #	test_when_finished rm clean-after-failure &&
 	> #	(exit 1)
 	> #	Z
-	> not ok - 2 failure to clean up causes the test to fail
+	> 0000t12: not ok 2 - failure to clean up causes the test to fail
 	> #	Z
 	> #	test_when_finished \"(exit 2)\"
 	> #	Z
-	> # failed 2 among 2 test(s)
-	> 1..2
+	> 0000t12: # failed 2 among 2 test(s)
+	> 0000t12: 1..2
 	EOF
 	test_cmp expect out
 	)
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 9bc57d2..c81ad7f 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -24,6 +24,9 @@
 #
 # In particular, quoting isn't enough, as the path may contain the sam=
e quote
 # that we're using.
+
+TID=3D$(basename ${0%%-*})
+
 test_set_editor () {
 	FAKE_EDITOR=3D"$1"
 	export FAKE_EDITOR
@@ -434,7 +437,7 @@ test_external_without_stderr () {
 test_path_is_file () {
 	if ! [ -f "$1" ]
 	then
-		echo "File $1 doesn't exist. $*"
+		echo "$TID: File $1 doesn't exist. $*"
 		false
 	fi
 }
@@ -442,7 +445,7 @@ test_path_is_file () {
 test_path_is_dir () {
 	if ! [ -d "$1" ]
 	then
-		echo "Directory $1 doesn't exist. $*"
+		echo "$TID: Directory $1 doesn't exist. $*"
 		false
 	fi
 }
@@ -450,7 +453,7 @@ test_path_is_dir () {
 test_path_is_missing () {
 	if [ -e "$1" ]
 	then
-		echo "Path exists:"
+		echo "$TID: Path exists:"
 		ls -ld "$1"
 		if [ $# -ge 1 ]; then
 			echo "$*"
@@ -476,7 +479,7 @@ test_line_count () {
 		error "bug in the test script: not 3 parameters to test_line_count"
 	elif ! test $(wc -l <"$3") "$1" "$2"
 	then
-		echo "test_line_count: line count for $3 !$1 $2"
+		echo "$TID: test_line_count: line count for $3 !$1 $2"
 		cat "$3"
 		return 1
 	fi
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 78c4286..6fccbe9 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -31,6 +31,8 @@ done,*)
 	;;
 esac
=20
+TID=3D$(basename ${0%%-*})
+
 # Keep the original TERM for say_color
 ORIGINAL_TERM=3D$TERM
=20
@@ -185,7 +187,7 @@ if test -n "$color"; then
 			*) test -n "$quiet" && return;;
 		esac
 		shift
-		printf "%s" "$*"
+		printf "$TID: %s" "$*"
 		tput sgr0
 		echo
 		)
@@ -194,12 +196,12 @@ else
 	say_color() {
 		test -z "$1" && test -n "$quiet" && return
 		shift
-		echo "$*"
+		echo "$TID: $*"
 	}
 fi
=20
 error () {
-	say_color error "error: $*"
+	say_color error "$TID: error: $*"
 	GIT_EXIT_OK=3Dt
 	exit 1
 }
@@ -262,7 +264,7 @@ test_ok_ () {
=20
 test_failure_ () {
 	test_failure=3D$(($test_failure + 1))
-	say_color error "not ok - $test_count $1"
+	say_color error "not ok $test_count - $1"
 	shift
 	echo "$@" | sed -e 's/^/#	/'
 	test "$immediate" =3D "" || { GIT_EXIT_OK=3Dt; exit 1; }
--=20
1.7.11.5
