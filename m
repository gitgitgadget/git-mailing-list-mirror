From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH 03/21] completion tests: make the $cur variable local to the test helper functions
Date: Thu, 25 Feb 2016 23:50:32 +0100
Message-ID: <1456440650-32623-4-git-send-email-szeder@ira.uka.de>
References: <1456440650-32623-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	git@vger.kernel.org,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 25 23:52:04 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZ4lP-0005nj-AF
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 23:52:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751798AbcBYWv6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 25 Feb 2016 17:51:58 -0500
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:35738 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751630AbcBYWv6 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Feb 2016 17:51:58 -0500
Received: from x590cfbb6.dyn.telefonica.de ([89.12.251.182] helo=localhost.localdomain)
	by iramx2.ira.uni-karlsruhe.de with esmtpsa port 587 
	iface 141.3.10.81 id 1aZ4lE-0007uU-6S; Thu, 25 Feb 2016 23:51:53 +0100
X-Mailer: git-send-email 2.7.2.410.g92cb358
In-Reply-To: <1456440650-32623-1-git-send-email-szeder@ira.uka.de>
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de  esmtpsa 1456440713.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287452>

The test helper functions test_gitcomp() and test_gitcomp_nl() leak
the $cur variable into the test environment.  Since this variable has
a special role in the Bash completion script (it holds the word
currently being completed) it influences the behavior of most
completion functions and thus this leakage could interfere with
subsequent tests.  Although there are no such issues in the current
tests, early versions of the new tests that will be added later in
this series suffered because of this.

It's better to play safe and declare $cur local in those test helper
functions.  'local' is bashism, of course, but the tests of the Bash
completion script are run under Bash anyway, and there are already
other variables declared local in this test script.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 t/t9902-completion.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index cec98a7e814c..9f591c361fab 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -98,7 +98,7 @@ test_gitcomp ()
 {
 	local -a COMPREPLY &&
 	sed -e 's/Z$//' >expected &&
-	cur=3D"$1" &&
+	local cur=3D"$1" &&
 	shift &&
 	__gitcomp "$@" &&
 	print_comp &&
@@ -113,7 +113,7 @@ test_gitcomp_nl ()
 {
 	local -a COMPREPLY &&
 	sed -e 's/Z$//' >expected &&
-	cur=3D"$1" &&
+	local cur=3D"$1" &&
 	shift &&
 	__gitcomp_nl "$@" &&
 	print_comp &&
--=20
2.7.2.410.g92cb358
