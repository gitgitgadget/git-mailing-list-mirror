From: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: [PATCH] Add option --path to allow to run tests with real systems
Date: Wed, 5 Dec 2007 20:45:22 +0700
Message-ID: <20071205134522.GA24617@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 05 14:47:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzuaS-0007kb-D0
	for gcvg-git-2@gmane.org; Wed, 05 Dec 2007 14:46:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751988AbXLENps convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 5 Dec 2007 08:45:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751978AbXLENps
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Dec 2007 08:45:48 -0500
Received: from an-out-0708.google.com ([209.85.132.247]:59681 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751963AbXLENpq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Dec 2007 08:45:46 -0500
Received: by an-out-0708.google.com with SMTP id d31so1024804and
        for <git@vger.kernel.org>; Wed, 05 Dec 2007 05:45:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:from:to:subject:message-id:mime-version:content-type:content-disposition:content-transfer-encoding:user-agent;
        bh=p1uBsr2lyrMy0VwNhfEebJwuy14Y6CVd9vyQxCa3+Fw=;
        b=C3zdR1niu9PDhZL69bA9iPw/aBz7YteTlfnl97nDan8bt7ER6iqmhEVZDDsLd1QGPjn4zWOSSguz85ouNN9KOOqORZKdiaSmzoCVXyCMtywGxIAYCAeBVD5qJMcsgAxyPoCWPe0+kNGI95DDZzvQYwMv7TF1IpoZ/fxPcBC4ea8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:date:from:to:subject:message-id:mime-version:content-type:content-disposition:content-transfer-encoding:user-agent;
        b=i3eII4pwAbDc8yV3kto6gpweyoji8sYFIJlT3B9JjNzZyHJObP0sQ9x055BOxaGPKuuS/RSDZ3p7HzE/1kLWnfO29ZDb/br23UrNWS+ODIQKPLj/A12AA0pBpxIMtaz335yJ+YXBon/UCSZXafn+yAwTJbRPSTjRwQyyHtXRPS4=
Received: by 10.100.190.15 with SMTP id n15mr4169224anf.1196862345952;
        Wed, 05 Dec 2007 05:45:45 -0800 (PST)
Received: from pclouds@gmail.com ( [117.5.1.36])
        by mx.google.com with ESMTPS id c2sm269756ana.2007.12.05.05.45.35
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 05 Dec 2007 05:45:45 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed,  5 Dec 2007 20:45:22 +0700
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67153>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 As we have decided to move git-* to gitexecdir, we should
 make sure it works.

 I'm running tests with --path now and saw some errors. Some
 of them could be from bugs of this patch. I haven't looked into
 them yet.

 t/lib-git-svn.sh          |    2 +-
 t/t0000-basic.sh          |    6 +++---
 t/t0040-parse-options.sh  |   16 ++++++++--------
 t/t4200-rerere.sh         |    8 ++++----
 t/t5301-sliding-window.sh |    2 +-
 t/t5302-pack-index.sh     |    4 ++--
 t/test-lib.sh             |   18 ++++++++++++++----
 7 files changed, 33 insertions(+), 23 deletions(-)

diff --git a/t/lib-git-svn.sh b/t/lib-git-svn.sh
index 8d4a447..fd60ebc 100644
--- a/t/lib-git-svn.sh
+++ b/t/lib-git-svn.sh
@@ -46,7 +46,7 @@ rawsvnrepo=3D"$svnrepo"
 svnrepo=3D"file://$svnrepo"
=20
 poke() {
-	test-chmtime +1 "$1"
+	$GIT_TEST_PATH/test-chmtime +1 "$1"
 }
=20
 SVN_HTTPD_MODULE_PATH=3D${SVN_HTTPD_MODULE_PATH-'/usr/lib/apache2/modu=
les'}
diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index 4e49d59..f809163 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -289,12 +289,12 @@ test_expect_success 'absolute path works as expec=
ted' '
 	mkdir third &&
 	dir=3D"$(cd .git; pwd -P)" &&
 	dir2=3Dthird/../second/other/.git &&
-	test "$dir" =3D "$(test-absolute-path $dir2)" &&
+	test "$dir" =3D "$($GIT_TEST_PATH/test-absolute-path $dir2)" &&
 	file=3D"$dir"/index &&
-	test "$file" =3D "$(test-absolute-path $dir2/index)" &&
+	test "$file" =3D "$($GIT_TEST_PATH/test-absolute-path $dir2/index)" &=
&
 	ln -s ../first/file .git/syml &&
 	sym=3D"$(cd first; pwd -P)"/file &&
-	test "$sym" =3D "$(test-absolute-path $dir2/syml)"
+	test "$sym" =3D "$($GIT_TEST_PATH/test-absolute-path $dir2/syml)"
 '
=20
 test_done
diff --git a/t/t0040-parse-options.sh b/t/t0040-parse-options.sh
index 462fdf2..ca1cc9f 100755
--- a/t/t0040-parse-options.sh
+++ b/t/t0040-parse-options.sh
@@ -23,7 +23,7 @@ string options
 EOF
=20
 test_expect_success 'test help' '
-	! test-parse-options -h > output 2> output.err &&
+	! $GIT_TEST_PATH/test-parse-options -h > output 2> output.err &&
 	test ! -s output &&
 	git diff expect.err output.err
 '
@@ -35,7 +35,7 @@ string: 123
 EOF
=20
 test_expect_success 'short options' '
-	test-parse-options -s123 -b -i 1729 -b > output 2> output.err &&
+	$GIT_TEST_PATH/test-parse-options -s123 -b -i 1729 -b > output 2> out=
put.err &&
 	git diff expect output &&
 	test ! -s output.err
 '
@@ -46,7 +46,7 @@ string: 321
 EOF
=20
 test_expect_success 'long options' '
-	test-parse-options --boolean --integer 1729 --boolean --string2=3D321=
 \
+	$GIT_TEST_PATH/test-parse-options --boolean --integer 1729 --boolean =
--string2=3D321 \
 		> output 2> output.err &&
 	test ! -s output.err &&
 	git diff expect output
@@ -62,7 +62,7 @@ arg 02: --boolean
 EOF
=20
 test_expect_success 'intermingled arguments' '
-	test-parse-options a1 --string 123 b1 --boolean -j 13 -- --boolean \
+	$GIT_TEST_PATH/test-parse-options a1 --string 123 b1 --boolean -j 13 =
-- --boolean \
 		> output 2> output.err &&
 	test ! -s output.err &&
 	git diff expect output
@@ -75,19 +75,19 @@ string: (not set)
 EOF
=20
 test_expect_success 'unambiguously abbreviated option' '
-	test-parse-options --int 2 --boolean --no-bo > output 2> output.err &=
&
+	$GIT_TEST_PATH/test-parse-options --int 2 --boolean --no-bo > output =
2> output.err &&
 	test ! -s output.err &&
 	git diff expect output
 '
=20
 test_expect_success 'unambiguously abbreviated option with "=3D"' '
-	test-parse-options --int=3D2 > output 2> output.err &&
+	$GIT_TEST_PATH/test-parse-options --int=3D2 > output 2> output.err &&
 	test ! -s output.err &&
 	git diff expect output
 '
=20
 test_expect_failure 'ambiguously abbreviated option' '
-	test-parse-options --strin 123;
+	$GIT_TEST_PATH/test-parse-options --strin 123;
         test $? !=3D 129
 '
=20
@@ -98,7 +98,7 @@ string: 123
 EOF
=20
 test_expect_success 'non ambiguous option (after two options it abbrev=
iates)' '
-	test-parse-options --st 123 > output 2> output.err &&
+	$GIT_TEST_PATH/test-parse-options --st 123 > output 2> output.err &&
 	test ! -s output.err &&
 	git diff expect output
 '
diff --git a/t/t4200-rerere.sh b/t/t4200-rerere.sh
index cfcdb69..ddbae1d 100755
--- a/t/t4200-rerere.sh
+++ b/t/t4200-rerere.sh
@@ -149,16 +149,16 @@ just_over_15_days_ago=3D$((-1-15*86400))
 almost_60_days_ago=3D$((60-60*86400))
 just_over_60_days_ago=3D$((-1-60*86400))
=20
-test-chmtime =3D$almost_60_days_ago $rr/preimage
-test-chmtime =3D$almost_15_days_ago $rr2/preimage
+$GIT_TEST_PATH/test-chmtime =3D$almost_60_days_ago $rr/preimage
+$GIT_TEST_PATH/test-chmtime =3D$almost_15_days_ago $rr2/preimage
=20
 test_expect_success 'garbage collection (part1)' 'git rerere gc'
=20
 test_expect_success 'young records still live' \
 	"test -f $rr/preimage && test -f $rr2/preimage"
=20
-test-chmtime =3D$just_over_60_days_ago $rr/preimage
-test-chmtime =3D$just_over_15_days_ago $rr2/preimage
+$GIT_TEST_PATH/test-chmtime =3D$just_over_60_days_ago $rr/preimage
+$GIT_TEST_PATH/test-chmtime =3D$just_over_15_days_ago $rr2/preimage
=20
 test_expect_success 'garbage collection (part2)' 'git rerere gc'
=20
diff --git a/t/t5301-sliding-window.sh b/t/t5301-sliding-window.sh
index 073ac0c..8327051 100755
--- a/t/t5301-sliding-window.sh
+++ b/t/t5301-sliding-window.sh
@@ -12,7 +12,7 @@ test_expect_success \
      for i in a b c
      do
          echo $i >$i &&
-         test-genrandom "$i" 32768 >>$i &&
+         $GIT_TEST_PATH/test-genrandom "$i" 32768 >>$i &&
          git update-index --add $i || return 1
      done &&
      echo d >d && cat c >>d && git update-index --add d &&
diff --git a/t/t5302-pack-index.sh b/t/t5302-pack-index.sh
index 2a2878b..0ae9cd8 100755
--- a/t/t5302-pack-index.sh
+++ b/t/t5302-pack-index.sh
@@ -15,11 +15,11 @@ test_expect_success \
      do
 		 i=3D`printf '%03i' $i`
          echo $i >file_$i &&
-         test-genrandom "$i" 8192 >>file_$i &&
+         $GIT_TEST_PATH/test-genrandom "$i" 8192 >>file_$i &&
          git update-index --add file_$i &&
 		 i=3D`expr $i + 1` || return 1
      done &&
-     { echo 101 && test-genrandom 100 8192; } >file_101 &&
+     { echo 101 && $GIT_TEST_PATH/test-genrandom 100 8192; } >file_101=
 &&
      git update-index --add file_101 &&
      tree=3D`git write-tree` &&
      commit=3D`git commit-tree $tree </dev/null` && {
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 90b6844..50a3551 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -84,6 +84,8 @@ do
 	--no-python)
 		# noop now...
 		shift ;;
+	--path=3D*)
+		path=3D"${1#*=3D}"; shift ;;
 	*)
 		break ;;
 	esac
@@ -296,11 +298,19 @@ test_done () {
=20
 # Test the binaries we have just built.  The tests are kept in
 # t/ subdirectory and are run in trash subdirectory.
-PATH=3D$(pwd)/..:$PATH
-GIT_EXEC_PATH=3D$(pwd)/..
+if [ -n "$path" ]; then
+	[ -x "$path/git" ] || error "git not found in $path"
+	PATH=3D"$path":$PATH
+	export PATH
+	GIT_EXEC_PATH=3D"$(git --exec-path)"
+else
+	PATH=3D$(pwd)/..:$PATH
+	GIT_EXEC_PATH=3D$(pwd)/..
+fi
+GIT_TEST_PATH=3D$(pwd)/..
 GIT_TEMPLATE_DIR=3D$(pwd)/../templates/blt
 GIT_CONFIG=3D.git/config
-export PATH GIT_EXEC_PATH GIT_TEMPLATE_DIR GIT_CONFIG
+export PATH GIT_EXEC_PATH GIT_TEMPLATE_DIR GIT_CONFIG GIT_TEST_PATH
=20
 GITPERLLIB=3D$(pwd)/../perl/blib/lib:$(pwd)/../perl/blib/arch/auto/Git
 export GITPERLLIB
@@ -308,7 +318,7 @@ test -d ../templates/blt || {
 	error "You haven't built things yet, have you?"
 }
=20
-if ! test -x ../test-chmtime; then
+if ! test -x $GIT_TEST_PATH/test-chmtime; then
 	echo >&2 'You need to build test-chmtime:'
 	echo >&2 'Run "make test-chmtime" in the source (toplevel) directory'
 	exit 1
--=20
1.5.3.6.2040.gcdff-dirty
