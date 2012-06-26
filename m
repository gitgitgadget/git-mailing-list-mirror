From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH 7/9] git p4 test: copy source indeterminate
Date: Mon, 25 Jun 2012 21:18:23 -0400
Message-ID: <1340673505-10551-8-git-send-email-pw@padd.com>
References: <1340673505-10551-1-git-send-email-pw@padd.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 26 03:23:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SjKVI-0004Kg-Eg
	for gcvg-git-2@plane.gmane.org; Tue, 26 Jun 2012 03:23:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757982Ab2FZBUt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jun 2012 21:20:49 -0400
Received: from honk.padd.com ([74.3.171.149]:45538 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757794Ab2FZBUt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jun 2012 21:20:49 -0400
Received: from arf.padd.com (unknown [50.55.159.91])
	by honk.padd.com (Postfix) with ESMTPSA id A95932E87;
	Mon, 25 Jun 2012 18:20:48 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 6D8FD31383; Mon, 25 Jun 2012 21:20:46 -0400 (EDT)
X-Mailer: git-send-email 1.7.11.rc2.72.gebb7ee5
In-Reply-To: <1340673505-10551-1-git-send-email-pw@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200613>

Msysgit testing showed that the source file found by copy
detection is indeterminate when there are multiple sources
to choose from.  This appears to be valid.  Adjust the test
so that it passes if it finds any of the potential copy sources.

Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 t/t9800-git-p4-basic.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t9800-git-p4-basic.sh b/t/t9800-git-p4-basic.sh
index 84676a1..60c1f57 100755
--- a/t/t9800-git-p4-basic.sh
+++ b/t/t9800-git-p4-basic.sh
@@ -547,7 +547,7 @@ test_expect_success 'detect copies' '
 		level=$(git diff-tree -r -C --find-copies-harder HEAD | sed 1d | cut -f1 | cut -d" " -f5 | sed "s/C0*//") &&
 		test -n "$level" && test "$level" -gt 0 && test "$level" -lt 98 &&
 		src=$(git diff-tree -r -C --find-copies-harder HEAD | sed 1d | cut -f2) &&
-		test "$src" = file10 &&
+		test "$src" = file10 -o "$src" = file11 &&
 		git config git-p4.detectCopies $(($level + 2)) &&
 		git p4 submit &&
 		p4 filelog //depot/file12 &&
@@ -561,7 +561,7 @@ test_expect_success 'detect copies' '
 		level=$(git diff-tree -r -C --find-copies-harder HEAD | sed 1d | cut -f1 | cut -d" " -f5 | sed "s/C0*//") &&
 		test -n "$level" && test "$level" -gt 2 && test "$level" -lt 100 &&
 		src=$(git diff-tree -r -C --find-copies-harder HEAD | sed 1d | cut -f2) &&
-		test "$src" = file10 &&
+		test "$src" = file10 -o "$src" = file11 -o "$src" = file12 &&
 		git config git-p4.detectCopies $(($level - 2)) &&
 		git p4 submit &&
 		p4 filelog //depot/file13 &&
-- 
1.7.11.rc2.72.gebb7ee5
