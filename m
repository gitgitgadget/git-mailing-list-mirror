From: "David A. Greene" <greened@obbligato.org>
Subject: [PATCH] Allow Overriding GIT_BUILD_DIR
Date: Sun, 5 Feb 2012 16:28:06 -0600
Message-ID: <87vcmu5psm.fsf@smith.obbligato.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 26 02:50:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S1TFe-0002l1-Pc
	for gcvg-git-2@plane.gmane.org; Sun, 26 Feb 2012 02:50:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752312Ab2BZBuI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Feb 2012 20:50:08 -0500
Received: from li209-253.members.linode.com ([173.255.199.253]:51997 "EHLO
	johnson.obbligato.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752080Ab2BZBuH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Feb 2012 20:50:07 -0500
Received: from c-75-73-20-8.hsd1.mn.comcast.net ([75.73.20.8] helo=smith.obbligato.org)
	by johnson.obbligato.org with esmtpsa (TLS1.2:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.77)
	(envelope-from <greened@obbligato.org>)
	id 1S1TGD-0005kL-NO
	for git@vger.kernel.org; Sat, 25 Feb 2012 19:50:51 -0600
X-Filter-Spam-Score: ()
X-Filter-Spam-Report: Spam detection software, running on the system "johnson.obbligato.org", has
 identified this incoming email as possible spam.  The original message
 has been attached to this so you can view it (if it isn't spam) or label
 similar future email.  If you have any questions, see
 @@CONTACT_ADDRESS@@ for details.
 Content preview:  Let tests override GIT_BUILD_DIR so git will work if tests
    are not at the same directory level as standard git tests. Prior to this
   change, GIT_BUILD_DIR is hardwired to be exactly one directory above where
    the test lives. A test within contrib/, for example, can now use test-lib.sh
    and set an appropriate value for GIT_BUILD_DIR. [...] 
 Content analysis details:   (1.1 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
 -1.0 ALL_TRUSTED 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191552>


Let tests override GIT_BUILD_DIR so git will work if tests are not at
the same directory level as standard git tests.  Prior to this change,
GIT_BUILD_DIR is hardwired to be exactly one directory above where the
test lives.  A test within contrib/, for example, can now use
test-lib.sh and set an appropriate value for GIT_BUILD_DIR.

Signed-off-by: David A. Greene <greened@obbligato.org>
---
 t/test-lib.sh |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletions(-)


------------------

diff --git a/t/test-lib.sh b/t/test-lib.sh
index a65dfc7..4585138 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -55,6 +55,7 @@ unset $(perl -e '
 		.*_TEST
 		PROVE
 		VALGRIND
+                BUILD_DIR
 	));
 	my @vars = grep(/^GIT_/ && !/^GIT_($ok)/o, @env);
 	print join("\n", @vars);
@@ -901,7 +902,14 @@ then
 	# itself.
 	TEST_DIRECTORY=$(pwd)
 fi
-GIT_BUILD_DIR="$TEST_DIRECTORY"/..
+
+if test -z "$GIT_BUILD_DIR"
+then
+	# We allow tests to override this, in case they want to run tests
+	# outside of t/, e.g. for running tests on the test library
+	# itself.
+        GIT_BUILD_DIR="$TEST_DIRECTORY"/..
+fi
 
 if test -n "$valgrind"
 then

--------------------
