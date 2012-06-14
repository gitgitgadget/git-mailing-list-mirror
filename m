From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCHv5 1/5] Scripts to install, delete and clear a MediaWiki
Date: Thu, 14 Jun 2012 18:17:39 +0200
Message-ID: <vpqbokl6f6k.fsf@bauges.imag.fr>
References: <1339607025-22725-1-git-send-email-simon.cathebras@ensimag.imag.fr>
	<1339664243-31952-1-git-send-email-Matthieu.Moy@imag.fr>
	<4FD9ACC6.50307@ensimag.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Julien.Khayat@ensimag.imag.fr,
	Simon.Perrat@ensimag.imag.fr, Charles.Roussel@ensimag.imag.fr,
	Guillaume.Sasdy@ensimag.imag.fr
To: Simon.Cathebras@ensimag.imag.fr
X-From: git-owner@vger.kernel.org Thu Jun 14 18:17:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SfCk3-0008Je-Gn
	for gcvg-git-2@plane.gmane.org; Thu, 14 Jun 2012 18:17:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756342Ab2FNQRr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 Jun 2012 12:17:47 -0400
Received: from mx1.imag.fr ([129.88.30.5]:33921 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756062Ab2FNQRq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jun 2012 12:17:46 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q5EGHdDC029290
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 14 Jun 2012 18:17:40 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1SfCjs-0007yG-QC; Thu, 14 Jun 2012 18:17:40 +0200
In-Reply-To: <4FD9ACC6.50307@ensimag.imag.fr> (Simon Cathebras's message of
	"Thu, 14 Jun 2012 11:20:06 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 14 Jun 2012 18:17:41 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q5EGHdDC029290
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1340295462.8573@k1Ww6MnLNWLmqyxZpK4/cQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200015>

"Simon.Cathebras" <Simon.Cathebras@ensimag.imag.fr> writes:

> Appears to be a local problem. Did you managed to run the script when
> this was fixed ?
>
> Anyway, please check out with the following wiki page if you have all
> required package.

Indeed, installing php5-cgi did it. I can now run the testsuite. But
that would have been nice to get explicit error messages about this.

> url: https://github.com/Fafinou/git/wiki

This documentation should actually appear in the README file of your
test environment. Wikis are nice to work collaboratively on a draft, bu=
t
this kind of doc should really end up as close to the code as possible
(currently, the code doesn't give a way to find the page above ...).

While testing/reviewing, I fixed a few more issues (patch below).

One thing I wanted to do was to let "install-wiki.sh" be launched from
any directory, like "./t/install-wiki.sh install", but it's still not
there, there are relative paths here and there that break it. Maybe we
should just run cd "$WIKI_TEST_DIR" at the top. Or error out asking the
user to cd himself.

=46rom 084babd650376437d0fb4697d680d3c325316b7c Mon Sep 17 00:00:00 200=
1
=46rom: Matthieu Moy <Matthieu.Moy@imag.fr>
Date: Thu, 14 Jun 2012 18:13:20 +0200
Subject: [PATCH] More fixups

---
 contrib/mw-to-git/t/Makefile                |  7 +++++--
 contrib/mw-to-git/t/t9362-mw-to-git-utf8.sh |  8 ++++----
 contrib/mw-to-git/t/test-gitmw-lib.sh       | 20 +++++++++++---------
 3 files changed, 20 insertions(+), 15 deletions(-)

diff --git a/contrib/mw-to-git/t/Makefile b/contrib/mw-to-git/t/Makefil=
e
index 752fd1f..0212b85 100644
--- a/contrib/mw-to-git/t/Makefile
+++ b/contrib/mw-to-git/t/Makefile
@@ -17,10 +17,13 @@ T =3D $(wildcard t[0-9][0-9][0-9][0-9]-*.sh)
=20
 help:
 	@echo 'Run "$(MAKE) test" to launch test scripts'
-	@echo 'Run "$(MAKE)" clean to remove trash folders'
+	@echo 'Run "$(MAKE) clean" to remove trash folders'
=20
 test:
-	for t in $(T); do "./$$t"; done
+	@for t in $(T); do \
+		echo "$$t"; \
+		"./$$t" || { echo "$$t failed"; exit 1; } \
+	done
=20
 clean:
 	$(RM) -r 'trash directory'.*
diff --git a/contrib/mw-to-git/t/t9362-mw-to-git-utf8.sh b/contrib/mw-t=
o-git/t/t9362-mw-to-git-utf8.sh
index ee7cc9e..0add2d5 100755
--- a/contrib/mw-to-git/t/t9362-mw-to-git-utf8.sh
+++ b/contrib/mw-to-git/t/t9362-mw-to-git-utf8.sh
@@ -101,7 +101,7 @@ test_expect_success 'Git push works with a wiki wit=
h accents' '
 	test_diff_directories mw_dir_6 ref_page_6
 '
=20
-test_expect_success 'Git clone works with accentsand spaces' '
+test_expect_success 'Git clone works with accents and spaces' '
 	wiki_reset &&
 	wiki_editpage "=E9 =E0 =EE" "this page must be d=E9l=E9t=E9 before th=
e clone" false &&
 	git clone mediawiki::http://'"$SERVER_ADDR:$PORT/$WIKI_DIR_NAME"' mw_=
dir_7 &&
@@ -166,7 +166,7 @@ test_expect_failure 'special character at the begin=
ing of file name from mw to g
 	test -f mw_dir_11/[char_2
 '
=20
-test_expect_success 'test of correct formating for file name from mw t=
o git' '
+test_expect_success 'correct formating for file name from mw to git' '
 	wiki_reset &&
 	git clone mediawiki::http://'"$SERVER_ADDR:$PORT/$WIKI_DIR_NAME"' mw_=
dir_12 &&
 	wiki_editpage char_%_7b_1 "expect to be renamed char{_1" false &&
@@ -184,7 +184,7 @@ test_expect_success 'test of correct formating for =
file name from mw to git' '
 '
=20
=20
-test_expect_failure 'test of correct formating for file name begining =
with special character' '
+test_expect_failure 'correct formating for file name begining with spe=
cial character' '
 	wiki_reset &&
 	git clone mediawiki::http://'"$SERVER_ADDR:$PORT/$WIKI_DIR_NAME"' mw_=
dir_13 &&
 	(
@@ -203,7 +203,7 @@ test_expect_failure 'test of correct formating for =
file name begining with speci
 '
=20
=20
-test_expect_success 'test of correct formating for file name from git =
to mw' '
+test_expect_success 'correct formating for file name from git to mw' '
 	wiki_reset &&
 	git clone mediawiki::http://'"$SERVER_ADDR:$PORT/$WIKI_DIR_NAME"' mw_=
dir_14 &&
 	(
diff --git a/contrib/mw-to-git/t/test-gitmw-lib.sh b/contrib/mw-to-git/=
t/test-gitmw-lib.sh
index 36ac654..f444d1f 100644
--- a/contrib/mw-to-git/t/test-gitmw-lib.sh
+++ b/contrib/mw-to-git/t/test-gitmw-lib.sh
@@ -10,8 +10,12 @@
 # CONFIGURATION VARIABLES
 # You might want to change these ones
 #
+if test -z "$WIKI_TEST_DIR"
+then
+	WIKI_TEST_DIR=3D.
+fi
=20
-. ./test.config
+. "$WIKI_TEST_DIR"/test.config
=20
 export CURR_DIR=3D$(pwd)
 export TEST_DIRECTORY=3D"$CURR_DIR"/../../../t
@@ -87,7 +91,7 @@ test_diff_directories () {
 #
 # Check that <dir> contains exactly <N> files
 test_contains_N_files () {
-	test `ls "$1" | wc -l` -eq "$2";
+	test `ls -- "$1" | wc -l` -eq "$2"
 }
=20
=20
@@ -101,8 +105,7 @@ wiki_check_content () {
 	#replacement of forbidden character in file name
 	page_name=3D$(printf "%s\n" "$2" | sed -e "s/\//%2F/g")
=20
-	diff -b "$1" wiki_tmp/"$page_name".mw
-	if test $? -ne 0
+	if ! diff -b "$1" wiki_tmp/"$page_name".mw
 	then
 		rm -rf wiki_tmp
 		error "ERROR: file $2 not found on wiki"
@@ -268,9 +271,9 @@ start_lighttpd() {
 		stop_lighttpd
 	fi
 	config_lighttpd
-	$LIGHTTPD_DIR/lighttpd -f $WEB/lighttpd.conf
-
-	if test $? -ne 0 ; then
+=09
+	if ! $LIGHTTPD_DIR/lighttpd -f $WEB/lighttpd.conf
+	then
 		echo "Could not execute http deamon lighttpd"
 		exit 1
 	fi
@@ -280,9 +283,8 @@ start_lighttpd() {
 #
 # Kill daemon lighttpd and removes files and folders associated.
 stop_lighttpd () {
-
 	test -f "$WEB_TMP/pid" && kill $(cat "$WEB_TMP/pid")
-	rm -rf $WEB
+	rm -rf "$WEB"
 }
=20
 # Create the SQLite database of the MediaWiki. If the database file al=
ready
--=20
1.7.11.rc0.57.g84a04c7

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
