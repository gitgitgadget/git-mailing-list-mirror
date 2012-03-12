From: =?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
Subject: [PATCH 1/2] t0303: set reason for skipping tests
Date: Mon, 12 Mar 2012 13:05:06 +0100
Message-ID: <1331553907-19576-2-git-send-email-zbyszek@in.waw.pl>
References: <1331553907-19576-1-git-send-email-zbyszek@in.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>,
	=?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Mar 12 13:05:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S740i-0002i4-DL
	for gcvg-git-2@plane.gmane.org; Mon, 12 Mar 2012 13:05:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754695Ab2CLMFw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 12 Mar 2012 08:05:52 -0400
Received: from kawka.in.waw.pl ([178.63.212.103]:55718 "EHLO kawka.in.waw.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752723Ab2CLMFu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Mar 2012 08:05:50 -0400
Received: from optyk25.fuw.edu.pl ([193.0.81.79] helo=ameba.fuw.edu.pl)
	by kawka.in.waw.pl with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <zbyszek@in.waw.pl>)
	id 1S740b-0005xL-H4; Mon, 12 Mar 2012 13:05:49 +0100
X-Mailer: git-send-email 1.7.9.3.467.g8f1c7
In-Reply-To: <1331553907-19576-1-git-send-email-zbyszek@in.waw.pl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192860>

t0300-credential-helpers.sh runs two sets of tests. Each set is
controlled by an environment variable and is skipped if the variable
is not defined. If both sets are skipped, prove will say:
  ./t0303-credential-external.sh .. skipped: (no reason given)
which isn't very nice.

Use skip_all=3D"..." to set the reason when both sets are skipped.

Signed-off-by: Zbigniew J=C4=99drzejewski-Szmek <zbyszek@in.waw.pl>
---
 t/t0303-credential-external.sh |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/t/t0303-credential-external.sh b/t/t0303-credential-extern=
al.sh
index 267f4c8..f1e0e75 100755
--- a/t/t0303-credential-external.sh
+++ b/t/t0303-credential-external.sh
@@ -21,7 +21,7 @@ post_test() {
 }
=20
 if test -z "$GIT_TEST_CREDENTIAL_HELPER"; then
-	say "# skipping external helper tests (set GIT_TEST_CREDENTIAL_HELPER=
)"
+	say "# skipping external helper tests (GIT_TEST_CREDENTIAL_HELPER not=
 set)"
 else
 	pre_test
 	helper_test "$GIT_TEST_CREDENTIAL_HELPER"
@@ -29,11 +29,16 @@ else
 fi
=20
 if test -z "$GIT_TEST_CREDENTIAL_HELPER_TIMEOUT"; then
-	say "# skipping external helper timeout tests"
+	say "# skipping external helper timeout tests (GIT_TEST_CREDENTIAL_HE=
LPER_TIMEOUT not set)"
 else
 	pre_test
 	helper_test_timeout "$GIT_TEST_CREDENTIAL_HELPER_TIMEOUT"
 	post_test
 fi
=20
+if test -z "$GIT_TEST_CREDENTIAL_HELPER" \
+    -o -z "$GIT_TEST_CREDENTIAL_HELPER_TIMEOUT"; then
+    skip_all=3D"used to test external credential helpers"
+fi
+
 test_done
--=20
1.7.9.3.467.g8f1c7
