From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: [PATCH] use uppercase POSIX compliant signals for the 'trap' command
Date: Tue, 20 Jan 2009 00:43:26 +0100
Message-ID: <200901200043.26209.markus.heidelberg@web.de>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 20 00:44:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LP3nY-0005we-RT
	for gcvg-git-2@gmane.org; Tue, 20 Jan 2009 00:44:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754407AbZASXn3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Jan 2009 18:43:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754009AbZASXn2
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Jan 2009 18:43:28 -0500
Received: from fmmailgate01.web.de ([217.72.192.221]:34240 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753394AbZASXn1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Jan 2009 18:43:27 -0500
Received: from smtp06.web.de (fmsmtp06.dlan.cinetic.de [172.20.5.172])
	by fmmailgate01.web.de (Postfix) with ESMTP id B40CAFBF9A55;
	Tue, 20 Jan 2009 00:43:25 +0100 (CET)
Received: from [89.59.93.106] (helo=pluto)
	by smtp06.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1LP3m9-0004k2-00; Tue, 20 Jan 2009 00:43:25 +0100
User-Agent: KMail/1.9.9
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX1+pUp3whSulHntGtx6cDV3AULJs+Qe8o+W8Y0oi
	SZeGdH+yHor+6OI/vq3qeKvqcpsY8QPLYs5CpYVDZwGyQW1bI5
	4Xx6Inm1O6VpJTLctYMw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106409>

In 'man 1p trap' there is written:

    "Implementations may permit names with the SIG prefix or ignore case
    in signal names as an extension."

So change the lowercase signals to uppercase, which is POSIX compliant
instead of being an extension.

There wasn't anybody claiming that it doesn't work, but there was a bug
with using a signal with the SIG prefix, which is an extension as well.
So let's play it safe and change it, since it doesn't hurt anyone.

While at it, also convert 8 indentation spaces to 1 tab character.

Signed-off-by: Markus Heidelberg <markus.heidelberg@web.de>
---
 t/lib-httpd.sh |   10 +++++-----
 t/test-lib.sh  |   10 +++++-----
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/t/lib-httpd.sh b/t/lib-httpd.sh
index 6ac312b..3824020 100644
--- a/t/lib-httpd.sh
+++ b/t/lib-httpd.sh
@@ -20,9 +20,9 @@ HTTPD_DOCUMENT_ROOT_PATH=$HTTPD_ROOT_PATH/www
 
 if ! test -x "$LIB_HTTPD_PATH"
 then
-        say "skipping test, no web server found at '$LIB_HTTPD_PATH'"
-        test_done
-        exit
+	say "skipping test, no web server found at '$LIB_HTTPD_PATH'"
+	test_done
+	exit
 fi
 
 HTTPD_VERSION=`$LIB_HTTPD_PATH -v | \
@@ -84,7 +84,7 @@ prepare_httpd() {
 start_httpd() {
 	prepare_httpd
 
-	trap 'stop_httpd; die' exit
+	trap 'stop_httpd; die' EXIT
 
 	"$LIB_HTTPD_PATH" -d "$HTTPD_ROOT_PATH" \
 		-f "$TEST_PATH/apache.conf" $HTTPD_PARA \
@@ -92,7 +92,7 @@ start_httpd() {
 }
 
 stop_httpd() {
-	trap 'die' exit
+	trap 'die' EXIT
 
 	"$LIB_HTTPD_PATH" -d "$HTTPD_ROOT_PATH" \
 		-f "$TEST_PATH/apache.conf" -k stop
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 22ed448..41d5a59 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -127,7 +127,7 @@ fi
 
 error () {
 	say_color error "error: $*"
-	trap - exit
+	trap - EXIT
 	exit 1
 }
 
@@ -163,7 +163,7 @@ die () {
 	exit 1
 }
 
-trap 'die' exit
+trap 'die' EXIT
 
 # The semantics of the editor variables are that of invoking
 # sh -c "$EDITOR \"$@\"" files ...
@@ -208,7 +208,7 @@ test_failure_ () {
 	say_color error "FAIL $test_count: $1"
 	shift
 	echo "$@" | sed -e 's/^/	/'
-	test "$immediate" = "" || { trap - exit; exit 1; }
+	test "$immediate" = "" || { trap - EXIT; exit 1; }
 }
 
 test_known_broken_ok_ () {
@@ -416,7 +416,7 @@ test_create_repo () {
 }
 
 test_done () {
-	trap - exit
+	trap - EXIT
 	test_results_dir="$TEST_DIRECTORY/test-results"
 	mkdir -p "$test_results_dir"
 	test_results_path="$test_results_dir/${0%-*}-$$"
@@ -493,7 +493,7 @@ fi
 test="trash directory.$(basename "$0" .sh)"
 test ! -z "$debug" || remove_trash="$TEST_DIRECTORY/$test"
 rm -fr "$test" || {
-	trap - exit
+	trap - EXIT
 	echo >&5 "FATAL: Cannot prepare test area"
 	exit 1
 }
-- 
1.6.1.216.g3acd
