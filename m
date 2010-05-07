From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 5/6] We use TAP so the Perl test can run without scaffolding
Date: Fri,  7 May 2010 19:37:04 +0000
Message-ID: <1273261025-31523-5-git-send-email-avarab@gmail.com>
References: <1273261025-31523-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 07 21:40:30 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OATPQ-0003CZ-5z
	for gcvg-git-2@lo.gmane.org; Fri, 07 May 2010 21:40:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932125Ab0EGTkN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 May 2010 15:40:13 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:54381 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932088Ab0EGTkC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 May 2010 15:40:02 -0400
Received: by mail-fx0-f46.google.com with SMTP id 10so1043874fxm.19
        for <git@vger.kernel.org>; Fri, 07 May 2010 12:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=xoFmQhlj4/I6wUYl6OGFWITLP3kgz4a7CjTlg2E0gnQ=;
        b=K7jFEelJv31OzRifL455lj2lxepWUk8GfjLEc2RVCASTC2cLqyPmReHtGp4phfRnDA
         mbX3+La5B+D+281P+4bRxCxCkGrjohv7G43IwAhJRphy0Y6Lwxenbe33BiqE2C8bQQjk
         OTS57SpCBMW4v8sdMR+xYOnd1TKWmhj4A3FmA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=dOXhXi+44d3oyof0QO1PVerG5AtxdMK3rabTaSH80D/q5wWNlvcBOGhM4oo5507w4j
         Qoy9CXo8Hp9F0qHJpVStseRUpSYWS0Do4kSuB4eeP/wJMYHvOAC4mVfMo5u1pihlaset
         wgMWpJbFb4117OC+PAOKwYh2ZNBCb/yhdsq5A=
Received: by 10.223.127.196 with SMTP id h4mr547856fas.56.1273261201006;
        Fri, 07 May 2010 12:40:01 -0700 (PDT)
Received: from aoeu (dslb-188-098-088-194.pools.arcor-ip.net [188.98.88.194])
        by mx.google.com with ESMTPS id y12sm8000128faj.5.2010.05.07.12.39.59
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 07 May 2010 12:40:00 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.dirty
In-Reply-To: <1273261025-31523-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146568>

This removes the test_external and test_external_without_stderr
functions added by Lea Wiemann in
fb32c410087e68d650b31f68e66b3d9cbcce4a56. Nothing else used them, and
now that we're using TAP they shouldn't be necessary.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 t/t9700-perl-git.sh |    7 ++---
 t/t9700/test.pl     |    9 +++++++
 t/test-lib.sh       |   59 -------------------------------------------=
--------
 3 files changed, 12 insertions(+), 63 deletions(-)

diff --git a/t/t9700-perl-git.sh b/t/t9700-perl-git.sh
index 3999bf7..6c22dbc 100755
--- a/t/t9700-perl-git.sh
+++ b/t/t9700-perl-git.sh
@@ -46,8 +46,7 @@ test_expect_success \
      git config --add test.int 2k
      '
=20
-test_external_without_stderr \
-    'Perl API' \
-    "$PERL_PATH" "$TEST_DIRECTORY"/t9700/test.pl
+"$PERL_PATH" "$TEST_DIRECTORY"/t9700/test.pl
=20
-test_done
+# The Perl test finalizes the plan, so don't call test_done() here.
+GIT_EXIT_OK=3Dt
diff --git a/t/t9700/test.pl b/t/t9700/test.pl
index 666722d..c1ac913 100755
--- a/t/t9700/test.pl
+++ b/t/t9700/test.pl
@@ -7,6 +7,13 @@ use strict;
=20
 use Test::More qw(no_plan);
=20
+BEGIN {
+	# t9700-perl-git.sh kicks off our testing, so we have to go from
+	# there.
+	$Test::Builder::Test->{Curr_Test} =3D 1;
+	$Test::Builder::Test->{No_Ending} =3D 1;
+}
+
 use Cwd;
 use File::Basename;
=20
@@ -105,3 +112,5 @@ my $last_commit =3D $r2->command_oneline(qw(rev-par=
se --verify HEAD));
 like($last_commit, qr/^[0-9a-fA-F]{40}$/, 'rev-parse returned hash');
 my $dir_commit =3D $r2->command_oneline('log', '-n1', '--pretty=3Dform=
at:%H', '.');
 isnt($last_commit, $dir_commit, 'log . does not show last commit');
+
+printf "1..%d\n", $Test::Builder::Test->{Curr_Test};
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 282314c..b3c58f2 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -453,65 +453,6 @@ test_expect_code () {
 	echo >&3 ""
 }
=20
-# test_external runs external test scripts that provide continuous
-# test output about their progress, and succeeds/fails on
-# zero/non-zero exit code.  It outputs the test output on stdout even
-# in non-verbose mode, and announces the external script with "* run
-# <n>: ..." before running it.  When providing relative paths, keep in
-# mind that all scripts run in "trash directory".
-# Usage: test_external description command arguments...
-# Example: test_external 'Perl API' perl ../path/to/test.pl
-test_external () {
-	test "$#" =3D 4 && { prereq=3D$1; shift; } || prereq=3D
-	test "$#" =3D 3 ||
-	error >&5 "bug in the test script: not 3 or 4 parameters to test_exte=
rnal"
-	descr=3D"$1"
-	shift
-	if ! test_skip "$descr" "$@"
-	then
-		# Announce the script to reduce confusion about the
-		# test output that follows.
-		say_color "" " run $test_count: $descr ($*)"
-		# Run command; redirect its stderr to &4 as in
-		# test_run_, but keep its stdout on our stdout even in
-		# non-verbose mode.
-		"$@" 2>&4
-		if [ "$?" =3D 0 ]
-		then
-			test_ok_ "$descr"
-		else
-			test_failure_ "$descr" "$@"
-		fi
-	fi
-}
-
-# Like test_external, but in addition tests that the command generated
-# no output on stderr.
-test_external_without_stderr () {
-	# The temporary file has no (and must have no) security
-	# implications.
-	tmp=3D"$TMPDIR"; if [ -z "$tmp" ]; then tmp=3D/tmp; fi
-	stderr=3D"$tmp/git-external-stderr.$$.tmp"
-	test_external "$@" 4> "$stderr"
-	[ -f "$stderr" ] || error "Internal error: $stderr disappeared."
-	descr=3D"no stderr: $1"
-	shift
-	say >&3 "expecting no stderr from previous command"
-	if [ ! -s "$stderr" ]; then
-		rm "$stderr"
-		test_ok_ "$descr"
-	else
-		if [ "$verbose" =3D t ]; then
-			output=3D`echo; echo Stderr is:; cat "$stderr"`
-		else
-			output=3D
-		fi
-		# rm first in case test_failure exits.
-		rm "$stderr"
-		test_failure_ "$descr" "$@" "$output"
-	fi
-}
-
 # This is not among top-level (test_expect_success | test_expect_failu=
re)
 # but is a prefix that can be used in the test script, like:
 #
--=20
1.7.1.dirty
