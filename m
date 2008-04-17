From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH 3/5] Steal more test-lib.sh updates from git
Date: Thu, 17 Apr 2008 23:12:58 +0200
Message-ID: <20080417211258.12809.75008.stgit@yoghurt>
References: <20080417210137.12809.88457.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 17 23:33:40 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JmbQZ-00054T-TI
	for gcvg-git-2@gmane.org; Thu, 17 Apr 2008 23:13:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753030AbYDQVNM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Apr 2008 17:13:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753208AbYDQVNK
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Apr 2008 17:13:10 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4509 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753022AbYDQVNI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Apr 2008 17:13:08 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1JmbPd-0003dp-00; Thu, 17 Apr 2008 22:12:57 +0100
In-Reply-To: <20080417210137.12809.88457.stgit@yoghurt>
User-Agent: StGIT/0.14.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79832>

This patch incorporates the updates that were made to git's
test-lib.sh from revision v1.2.2-66-g6643688 up to revision
v1.5.5-67-g9a49e00. A few manual adjustments had to be made -- for
example, the StGit tests assume that the repository starts out with an
initial commit, and there's no need to try to get hold of a git binary
other than the one reachable via $PATH. And the test_must_fail helper
function is not that useful to us, since a crashing Python program
won't kill the entire Python interpreter.

The main improvement is that the test script output is now in color!

Shortlog of the imported changes:

  Alex Riesen (2):
        Fix permissions on test scripts
        Do no colorify test output if stdout is not a terminal

  Christian Couder (1):
        Trace into a file or an open fd and refactor tracing code.

  Clemens Buchacher (1):
        http-push: add regression tests

  Eric Wong (3):
        tests: Set EDITOR=3D: and VISUAL=3D: globally
        test-lib: quiet down init-db output for tests
        Update tests to use test-chmtime

  Gerrit Pape (1):
        Set $HOME for selftests

  Jeff King (3):
        fix config reading in tests
        use build-time SHELL_PATH in test scripts
        add test_cmp function for test scripts

  Johannes Schindelin (2):
        Introduce GIT_TEMPLATE_DIR
        Make tests independent of global config files

  Johannes Sixt (1):
        test-lib.sh: A command dying due to a signal is an unexpected f=
ailure.

  Josh Triplett (1):
        Fall back to $EMAIL for missing GIT_AUTHOR_EMAIL and GIT_COMMIT=
TER_EMAIL

  Junio C Hamano (26):
        Perl interface: make testsuite work again.
        Perly Git: make sure we do test the freshly built one.
        test-lib: unset GIT_TRACE
        Merge branch 'ml/trace'
        Merge branch 'master' into pb/gitpm
        Deprecate merge-recursive.py
        Merge branch 'jc/gitpm'
        remove merge-recursive-old
        fix testsuite: make sure they use templates freshly built from =
the source
        Revert "fix testsuite: make sure they use templates freshly bui=
lt from the source"
        GIT_SKIP_TESTS: allow users to omit tests that are known to bre=
ak
        t5400 send-pack test: try a bit more nontrivial transfer.
        Fix timestamp for test-tick
        t/test-lib.sh: Protect ourselves from common misconfiguration
        War on whitespace
        Merge branch 'ei/worktree+filter'
        Unset GIT_EDITOR while running tests.
        Sane use of test_expect_failure
        test: reword the final message of tests with known breakages
        tests: introduce test_must_fail
        Merge branch 'cb/http-test'
        tests: introduce test_must_fail
        test-lib: fix TERM to dumb for test repeatability
        Merge branch 'maint'
        Test: catch if trash cannot be removed
        test_must_fail: 129 is a valid error code from usage()

  Martin Waitz (1):
        test-lib: separate individual test better in verbose mode.

  Matthias Lederhofer (1):
        introduce GIT_WORK_TREE to specify the work tree

  Michele Ballabio (2):
        test-lib.sh: move error line after error() declaration
        Fix typo in a comment in t/test-lib.sh

  Nicolas Pitre (1):
        use 'init' instead of 'init-db' for shipped docs and tools

  Petr Baudis (1):
        Use $GITPERLLIB instead of $RUNNING_GIT_TESTS and centralize @I=
NC munging

  Pierre Habouzit (2):
        Add some fancy colors in the test library when terminal support=
s it.
        Support a --quiet option in the test-suite.

  Robin Rosenberg (1):
        Quote arguments to tr in test-lib

  Shawn O. Pearce (1):
        Default GIT_MERGE_VERBOSITY to 5 during tests.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

 t/test-lib.sh |  179 ++++++++++++++++++++++++++++++++++++++++++++-----=
--------
 1 files changed, 139 insertions(+), 40 deletions(-)


diff --git a/t/test-lib.sh b/t/test-lib.sh
index 5e4c7a1..87c143a 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -4,14 +4,19 @@
 # Copyright (c) 2006 Yann Dirson - tuning for stgit
 #
=20
+# Keep the original TERM for say_color
+ORIGINAL_TERM=3D$TERM
+
 # For repeatability, reset the environment to known value.
 LANG=3DC
 LC_ALL=3DC
 PAGER=3Dcat
 TZ=3DUTC
-export LANG LC_ALL PAGER TZ
+TERM=3Ddumb
+export LANG LC_ALL PAGER TERM TZ
 EDITOR=3D:
 VISUAL=3D:
+unset GIT_EDITOR
 unset AUTHOR_DATE
 unset AUTHOR_EMAIL
 unset AUTHOR_NAME
@@ -27,6 +32,7 @@ GIT_COMMITTER_EMAIL=3Dcommitter@example.com
 GIT_COMMITTER_NAME=3D'C O Mitter'
 unset GIT_DIFF_OPTS
 unset GIT_DIR
+unset GIT_WORK_TREE
 unset GIT_EXTERNAL_DIFF
 unset GIT_INDEX_FILE
 unset GIT_OBJECT_DIRECTORY
@@ -37,6 +43,7 @@ export GIT_MERGE_VERBOSITY
 export GIT_AUTHOR_EMAIL GIT_AUTHOR_NAME
 export GIT_COMMITTER_EMAIL GIT_COMMITTER_NAME
 export EDITOR VISUAL
+GIT_TEST_CMP=3D${GIT_TEST_CMP:-diff -u}
=20
 # Protect ourselves from common misconfiguration to export
 # CDPATH into the environment
@@ -57,19 +64,15 @@ esac
 # This test checks if command xyzzy does the right thing...
 # '
 # . ./test-lib.sh
-
-error () {
-	echo "* error: $*"
-	trap - exit
-	exit 1
-}
-
-say () {
-	echo "* $*"
-}
-
-test "${test_description}" !=3D "" ||
-error "Test script did not set test_description."
+[ "x$ORIGINAL_TERM" !=3D "xdumb" ] && (
+		TERM=3D$ORIGINAL_TERM &&
+		export TERM &&
+		[ -t 1 ] &&
+		tput bold >/dev/null 2>&1 &&
+		tput setaf 1 >/dev/null 2>&1 &&
+		tput sgr0 >/dev/null 2>&1
+	) &&
+	color=3Dt
=20
 while test "$#" -ne 0
 do
@@ -79,16 +82,63 @@ do
 	-i|--i|--im|--imm|--imme|--immed|--immedi|--immedia|--immediat|--imme=
diate)
 		immediate=3Dt; shift ;;
 	-h|--h|--he|--hel|--help)
-		echo "$test_description"
-		exit 0 ;;
+		help=3Dt; shift ;;
 	-v|--v|--ve|--ver|--verb|--verbo|--verbos|--verbose)
 		export STGIT_DEBUG_LEVEL=3D"-1"
 		verbose=3Dt; shift ;;
+	-q|--q|--qu|--qui|--quie|--quiet)
+		quiet=3Dt; shift ;;
+	--no-color)
+		color=3D; shift ;;
 	*)
 		break ;;
 	esac
 done
=20
+if test -n "$color"; then
+	say_color () {
+		(
+		TERM=3D$ORIGINAL_TERM
+		export TERM
+		case "$1" in
+			error) tput bold; tput setaf 1;; # bold red
+			skip)  tput bold; tput setaf 2;; # bold green
+			pass)  tput setaf 2;;            # green
+			info)  tput setaf 3;;            # brown
+			*) test -n "$quiet" && return;;
+		esac
+		shift
+		echo "* $*"
+		tput sgr0
+		)
+	}
+else
+	say_color() {
+		test -z "$1" && test -n "$quiet" && return
+		shift
+		echo "* $*"
+	}
+fi
+
+error () {
+	say_color error "error: $*"
+	trap - exit
+	exit 1
+}
+
+say () {
+	say_color info "$*"
+}
+
+test "${test_description}" !=3D "" ||
+error "Test script did not set test_description."
+
+if test "$help" =3D "t"
+then
+	echo "$test_description"
+	exit 0
+fi
+
 exec 5>&1
 if test "$verbose" =3D "t"
 then
@@ -99,8 +149,15 @@ fi
=20
 test_failure=3D0
 test_count=3D0
+test_fixed=3D0
+test_broken=3D0
+
+die () {
+	echo >&5 "FATAL: Unexpected exit with code $?"
+	exit 1
+}
=20
-trap 'echo >&5 "FATAL: Unexpected exit with code $?"; exit 1' exit
+trap 'die' exit
=20
 test_tick () {
 	if test -z "${test_tick+set}"
@@ -119,18 +176,29 @@ test_tick () {
=20
 test_ok_ () {
 	test_count=3D$(expr "$test_count" + 1)
-	say "  ok $test_count: $@"
+	say_color "" "  ok $test_count: $@"
 }
=20
 test_failure_ () {
 	test_count=3D$(expr "$test_count" + 1)
 	test_failure=3D$(expr "$test_failure" + 1);
-	say "FAIL $test_count: $1"
+	say_color error "FAIL $test_count: $1"
 	shift
 	echo "$@" | sed -e 's/^/	/'
 	test "$immediate" =3D "" || { trap - exit; exit 1; }
 }
=20
+test_known_broken_ok_ () {
+	test_count=3D$(expr "$test_count" + 1)
+	test_fixed=3D$(($test_fixed+1))
+	say_color "" "  FIXED $test_count: $@"
+}
+
+test_known_broken_failure_ () {
+	test_count=3D$(expr "$test_count" + 1)
+	test_broken=3D$(($test_broken+1))
+	say_color skip "  still broken $test_count: $@"
+}
=20
 test_debug () {
 	test "$debug" =3D "" || eval "$1"
@@ -155,9 +223,9 @@ test_skip () {
 	done
 	case "$to_skip" in
 	t)
-		say >&3 "skipping test: $@"
+		say_color skip >&3 "skipping test: $@"
 		test_count=3D$(expr "$test_count" + 1)
-		say "skip $test_count: $1"
+		say_color skip "skip $test_count: $1"
 		: true
 		;;
 	*)
@@ -171,13 +239,13 @@ test_expect_failure () {
 	error "bug in the test script: not 2 parameters to test-expect-failur=
e"
 	if ! test_skip "$@"
 	then
-		say >&3 "expecting failure: $2"
+		say >&3 "checking known breakage: $2"
 		test_run_ "$2"
-		if [ "$?" =3D 0 -a "$eval_ret" !=3D 0 -a "$eval_ret" -lt 129 ]
+		if [ "$?" =3D 0 -a "$eval_ret" =3D 0 ]
 		then
-			test_ok_ "$1"
+			test_known_broken_ok_ "$1"
 		else
-			test_failure_ "$@"
+		    test_known_broken_failure_ "$1"
 		fi
 	fi
 	echo >&3 ""
@@ -217,7 +285,24 @@ test_expect_code () {
 	echo >&3 ""
 }
=20
-# Most tests can use the created repository, but some amy need to crea=
te more.
+# test_cmp is a helper function to compare actual and expected output.
+# You can use it like:
+#
+#	test_expect_success 'foo works' '
+#		echo expected >expected &&
+#		foo >actual &&
+#		test_cmp expected actual
+#	'
+#
+# This could be written as either "cmp" or "diff -u", but:
+# - cmp's output is not nearly as easy to read as diff -u
+# - not all diff versions understand "-u"
+
+test_cmp() {
+	$GIT_TEST_CMP "$@"
+}
+
+# Most tests can use the created repository, but some may need to crea=
te more.
 # Usage: test_create_repo <directory>
 test_create_repo () {
 	test "$#" =3D 1 ||
@@ -226,17 +311,28 @@ test_create_repo () {
 	repo=3D"$1"
 	mkdir "$repo"
 	cd "$repo" || error "Cannot setup test environment"
-	git-init >/dev/null 2>&1 ||
-	error "cannot run git-init -- have you installed git-core?"
-	mkdir .git/info
-	echo "empty start" |
-	git-commit-tree `git-write-tree` >.git/refs/heads/master 2>&4 ||
-	error "cannot run git-commit -- is your git-core functioning?"
+	git init >/dev/null 2>&1 || error "cannot run git init"
+	echo "empty start" | \
+	    git commit-tree `git write-tree` >.git/refs/heads/master 2>&4 || =
\
+	    error "cannot run git commit"
+	mv .git/hooks .git/hooks-disabled
 	cd "$owd"
 }
=20
 test_done () {
 	trap - exit
+
+	if test "$test_fixed" !=3D 0
+	then
+		say_color pass "fixed $test_fixed known breakage(s)"
+	fi
+	if test "$test_broken" !=3D 0
+	then
+		say_color error "still have $test_broken known breakage(s)"
+		msg=3D"remaining $(($test_count-$test_broken)) test(s)"
+	else
+		msg=3D"$test_count test(s)"
+	fi
 	case "$test_failure" in
 	0)
 		# We could:
@@ -247,11 +343,11 @@ test_done () {
 		# The Makefile provided will clean this test area so
 		# we will leave things as they are.
=20
-		say "passed all $test_count test(s)"
+		say_color pass "passed all $msg"
 		exit 0 ;;
=20
 	*)
-		say "failed $test_failure among $test_count test(s)"
+		say_color error "failed $test_failure among $msg"
 		exit 1 ;;
=20
 	esac
@@ -261,14 +357,17 @@ test_done () {
 # t/ subdirectory and are run in trash subdirectory.
 PATH=3D$(pwd)/..:$PATH
 HOME=3D$(pwd)/trash
-GIT_TEMPLATE_DIR=3D$(pwd)/../templates
 GIT_CONFIG=3D.git/config
-export PATH HOME GIT_TEMPLATE_DIR GIT_CONFIG
-
+export PATH HOME GIT_CONFIG
=20
 # Test repository
 test=3Dtrash
-rm -fr "$test"
+rm -fr "$test" || {
+	trap - exit
+	echo >&5 "FATAL: Cannot prepare test area"
+	exit 1
+}
+
 test_create_repo $test
 cd "$test"
=20
@@ -285,8 +384,8 @@ do
 	done
 	case "$to_skip" in
 	t)
-		say >&3 "skipping test $this_test altogether"
-		say "skip all tests in $this_test"
+		say_color skip >&3 "skipping test $this_test altogether"
+		say_color skip "skip all tests in $this_test"
 		test_done
 	esac
 done
