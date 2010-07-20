From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH] t/t3700: convert two uses of negation operator '!' to use test_must_fail
Date: Tue, 20 Jul 2010 10:24:47 -0500
Message-ID: <tMTpk3TmiYV54AYDiNJMBdnlXhSooJQQ1gRoAEsSwmcSwJ9ROgOpr75wpEQNx6_kZkqBtD71_QU@cipher.nrlssc.navy.mil>
Cc: git@vger.kernel.org, Jens.Lehmann@web.de,
	Brandon Casey <drafnel@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Jul 20 17:26:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ObEi1-000728-O5
	for gcvg-git-2@lo.gmane.org; Tue, 20 Jul 2010 17:26:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932384Ab0GTP0K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Jul 2010 11:26:10 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:39673 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932295Ab0GTP0J (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jul 2010 11:26:09 -0400
Received: by mail.nrlssc.navy.mil id o6KFOvF5013872; Tue, 20 Jul 2010 10:24:58 -0500
X-OriginalArrivalTime: 20 Jul 2010 15:24:57.0729 (UTC) FILETIME=[B6456710:01CB281F]
X-Virus-Scanned: clamav-milter 0.95.3 at mail1
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151316>

From: Brandon Casey <drafnel@gmail.com>

These two lines use the negation '!' operator to negate the result of a
simple command.  Since these commands do not contain any pipes or other
complexities, the test_must_fail function can be used and is preferred
since it will additionally detect termination due to a signal.

This was noticed because the second use of '!' does not include a space
between the '!' and the opening parens.  Ksh interprets this as follows:

   !(pattern-list)
      Matches anything except one of the given patterns.

Ksh performs a file glob using the pattern-list and then tries to execute
the first file in the list.  If a space is added between the '!' and the
open parens, then Ksh will not interpret it as a pattern list, but in this
case, it is preferred to use test_must_fail, so lets do so.

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---
 t/t3700-add.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t3700-add.sh b/t/t3700-add.sh
index 47fbf53..d03495d 100755
--- a/t/t3700-add.sh
+++ b/t/t3700-add.sh
@@ -268,7 +268,7 @@ test_expect_success 'git add --dry-run of existing changed file' "
 
 test_expect_success 'git add --dry-run of non-existing file' "
 	echo ignored-file >>.gitignore &&
-	! (git add --dry-run track-this ignored-file >actual 2>&1) &&
+	test_must_fail git add --dry-run track-this ignored-file >actual 2>&1 &&
 	echo \"fatal: pathspec 'ignored-file' did not match any files\" | test_cmp - actual
 "
 
@@ -281,7 +281,7 @@ add 'track-this'
 EOF
 
 test_expect_success 'git add --dry-run --ignore-missing of non-existing file' '
-	!(git add --dry-run --ignore-missing track-this ignored-file >actual 2>&1) &&
+	test_must_fail git add --dry-run --ignore-missing track-this ignored-file >actual 2>&1 &&
 	test_cmp expect actual
 '
 
-- 
1.6.6.2
