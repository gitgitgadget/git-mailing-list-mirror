From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH] Fix a false negative in t5512 when run using sh -x
Date: Mon, 10 May 2010 09:19:06 +0200
Message-ID: <1273475946-2079-1-git-send-email-j6t@kdbg.org>
Cc: git@vger.kernel.org, Tay Ray Chuan <rctay89@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 10 09:19:39 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OBNH8-00037S-UW
	for gcvg-git-2@lo.gmane.org; Mon, 10 May 2010 09:19:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755339Ab0EJHTc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 May 2010 03:19:32 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:45947 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753916Ab0EJHTa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 May 2010 03:19:30 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1OBNGx-0000ti-TC; Mon, 10 May 2010 09:19:28 +0200
Received: from srv.linz.viscovery (srv.linz.viscovery [192.168.1.4])
	by theia.linz.viscovery (Postfix) with ESMTP id A02111660F;
	Mon, 10 May 2010 09:19:27 +0200 (CEST)
Received: by srv.linz.viscovery (Postfix, from userid 1000)
	id 5158BFA49; Mon, 10 May 2010 09:19:27 +0200 (CEST)
X-Mailer: git-send-email 1.7.1.75.g68e2c
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146767>

The test compares the stderr of a git command called with test_must_fail
to some expected output. With bash (and probably other shells as well)
when run with -x turned on, command trace output ends up in the captured
output. Of course, the actual output does not match the expected output
anymore.

Use 'grep' to check for expected output.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 t/t5512-ls-remote.sh |    6 +-----
 1 files changed, 1 insertions(+), 5 deletions(-)

diff --git a/t/t5512-ls-remote.sh b/t/t5512-ls-remote.sh
index 3cf1b3d..24c8684 100755
--- a/t/t5512-ls-remote.sh
+++ b/t/t5512-ls-remote.sh
@@ -86,10 +86,6 @@ test_expect_success 'use branch.<name>.remote if possible' '
 
 '
 
-cat >exp <<EOF
-fatal: 'refs*master' does not appear to be a git repository
-fatal: The remote end hung up unexpectedly
-EOF
 test_expect_success 'confuses pattern as remote when no remote specified' '
 	#
 	# Do not expect "git ls-remote <pattern>" to work; ls-remote, correctly,
@@ -103,7 +99,7 @@ test_expect_success 'confuses pattern as remote when no remote specified' '
 	# We could just as easily have used "master"; the "*" emphasizes its
 	# role as a pattern.
 	test_must_fail git ls-remote refs*master >actual 2>&1 &&
-	test_cmp exp actual
+	grep "does not appear to be a git repository" actual
 
 '
 
-- 
1.7.1.75.g68e2c
