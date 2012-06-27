From: Pete Wyckoff <pw@padd.com>
Subject: [PATCHv2 07/10] git p4 test: copy source indeterminate
Date: Wed, 27 Jun 2012 08:01:00 -0400
Message-ID: <1340798463-14499-8-git-send-email-pw@padd.com>
References: <1340798463-14499-1-git-send-email-pw@padd.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 27 14:03:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sjqy7-00064b-R8
	for gcvg-git-2@plane.gmane.org; Wed, 27 Jun 2012 14:03:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756750Ab2F0MDc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jun 2012 08:03:32 -0400
Received: from honk.padd.com ([74.3.171.149]:52790 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756682Ab2F0MDb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jun 2012 08:03:31 -0400
Received: from arf.padd.com (unknown [50.55.159.91])
	by honk.padd.com (Postfix) with ESMTPSA id 132EC70BC;
	Wed, 27 Jun 2012 05:03:26 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 30FE631383; Wed, 27 Jun 2012 08:03:24 -0400 (EDT)
X-Mailer: git-send-email 1.7.11.1.130.gb957a79
In-Reply-To: <1340798463-14499-1-git-send-email-pw@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200720>

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
1.7.11.1.69.gd505fd2
