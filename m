From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH 01/19] tests: move code to run tests under bash into a helper
	library
Date: Wed,  9 May 2012 02:44:32 +0200
Message-ID: <1336524290-30023-2-git-send-email-szeder@ira.uka.de>
References: <1336524290-30023-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 09 02:45:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRv25-0004mn-3I
	for gcvg-git-2@plane.gmane.org; Wed, 09 May 2012 02:45:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755452Ab2EIApX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 May 2012 20:45:23 -0400
Received: from moutng.kundenserver.de ([212.227.126.186]:52641 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755419Ab2EIApR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 May 2012 20:45:17 -0400
Received: from localhost6.localdomain6 (p5B130353.dip0.t-ipconnect.de [91.19.3.83])
	by mrelayeu.kundenserver.de (node=mreu3) with ESMTP (Nemesis)
	id 0LftJn-1RmCME11BL-00pQZd; Wed, 09 May 2012 02:45:13 +0200
X-Mailer: git-send-email 1.7.10.1.541.gb1be298
In-Reply-To: <1336524290-30023-1-git-send-email-szeder@ira.uka.de>
X-Provags-ID: V02:K0:hoBOrS0Si+V9Wd5S7YPXQp39Zz0Bgl04F4gEk9SM7kP
 Xan6CEgHum98scfSgbv9iljIaeBXwXpMxbjokx5RwdGpXGMXKi
 IGwBrJedm7dyNZwyQKpxTO9rJl82d9cP02E4YATEuiVBZqRD1D
 pa0DZf9+KzU0oNyDstsIY9o8HfW7FMOEDxf+f9360hWZ2WoxeJ
 kmZWNEu7a5+l3m9cL0vKZBvxZ8FLLtUHNd52EZGehOr7lQAVJT
 h5CFQWMTs0jb5HGlX037XQ19xREfua8IpKnkCOAjP/xGsxF2w1
 7deufyn3ttfec0DdVHA1g4KmFR9+yMUovCv+4QJ+7+/oyWaCV0
 jVJpPWy87M94YBwuzvN4zQh5lsWaMOOhNiitgwIo3MDX/lvgJt
 D3aODMJCbPrEA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197433>

The following patch will add tests for the bash prompt functions as a
new test script, which also has to be run under bash.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 t/lib-bash.sh         | 18 ++++++++++++++++++
 t/t9902-completion.sh | 14 +-------------
 2 files changed, 19 insertions(+), 13 deletions(-)
 create mode 100755 t/lib-bash.sh

diff --git a/t/lib-bash.sh b/t/lib-bash.sh
new file mode 100644
index 00000000..11397f74
--- /dev/null
+++ b/t/lib-bash.sh
@@ -0,0 +1,18 @@
+#!/bin/sh
+#
+# Ensures that tests are run under Bash; primarily intended for runnin=
g tests
+# of the completion script.
+
+if test -n "$BASH" && test -z "$POSIXLY_CORRECT"; then
+	# we are in full-on bash mode
+	true
+elif type bash >/dev/null 2>&1; then
+	# execute in full-on bash mode
+	unset POSIXLY_CORRECT
+	exec bash "$0" "$@"
+else
+	echo '1..0 #SKIP skipping bash completion tests; bash not available'
+	exit 0
+fi
+
+. ./test-lib.sh
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 5bda6b6e..a0ea9463 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -3,21 +3,9 @@
 # Copyright (c) 2012 Felipe Contreras
 #
=20
-if test -n "$BASH" && test -z "$POSIXLY_CORRECT"; then
-	# we are in full-on bash mode
-	true
-elif type bash >/dev/null 2>&1; then
-	# execute in full-on bash mode
-	unset POSIXLY_CORRECT
-	exec bash "$0" "$@"
-else
-	echo '1..0 #SKIP skipping bash completion tests; bash not available'
-	exit 0
-fi
-
 test_description=3D'test bash completion'
=20
-. ./test-lib.sh
+. ./lib-bash.sh
=20
 complete ()
 {
--=20
1.7.10.1.541.gb1be298
