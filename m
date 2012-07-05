From: Max Horn <max@quendi.de>
Subject: =?UTF-8?q?=5BPATCH=5D=20Change=20configure=20to=20check=20if=20pthreads=20are=20usable=20without=20any=20extra=20flags?=
Date: Fri,  6 Jul 2012 01:03:06 +0200
Message-ID: <1341529386-11589-1-git-send-email-max@quendi.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Max Horn <max@quendi.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 06 01:04:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Smv5l-00032z-IF
	for gcvg-git-2@plane.gmane.org; Fri, 06 Jul 2012 01:04:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933281Ab2GEXEE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Jul 2012 19:04:04 -0400
Received: from wp256.webpack.hosteurope.de ([80.237.133.25]:50398 "EHLO
	wp256.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933237Ab2GEXED (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Jul 2012 19:04:03 -0400
Received: from 77-22-67-26-dynip.superkabel.de ([77.22.67.26] helo=kaitain-wlan.fritz.box); authenticated
	by wp256.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	id 1Smv5Z-0000Kq-6t; Fri, 06 Jul 2012 01:03:57 +0200
X-Mailer: git-send-email 1.7.11.1.145.g4722b29.dirty
X-bounce-key: webpack.hosteurope.de;max@quendi.de;1341529442;6a428aa4;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201075>

The configure script checks whether certain flags / libraries are
required to use pthreads. But so far it did not consider the possibilit=
y
that no extra compiler flags are needed (as is the case on Mac OS X). A=
s
a result, configure would always add "-mt" to the list of flags. This i=
n
turn triggered a warning in clang about an unknown argument.
To solve this, we now first check if pthreads work without extra flags.

Signed-off-by: Max Horn <max@quendi.de>
---
 configure.ac | 2 +-
 1 Datei ge=C3=A4ndert, 1 Zeile hinzugef=C3=BCgt(+), 1 Zeile entfernt(-=
)

diff --git a/configure.ac b/configure.ac
index 4e9012f..d767ef3 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1002,7 +1002,7 @@ if test -n "$USER_NOPTHREAD"; then
 # -D_REENTRANT' or some such.
 elif test -z "$PTHREAD_CFLAGS"; then
   threads_found=3Dno
-  for opt in -mt -pthread -lpthread; do
+  for opt in "" -mt -pthread -lpthread; do
      old_CFLAGS=3D"$CFLAGS"
      CFLAGS=3D"$opt $CFLAGS"
      AC_MSG_CHECKING([Checking for POSIX Threads with '$opt'])
--=20
1.7.11.1.145.g4722b29.dirty
