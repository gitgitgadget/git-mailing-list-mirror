From: Jeff King <peff@peff.net>
Subject: [PATCH 05/25] t: assume test_cmp produces verbose output
Date: Fri, 20 Mar 2015 06:07:52 -0400
Message-ID: <20150320100752.GE12543@peff.net>
References: <20150320100429.GA17354@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 20 11:08:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYtqR-0001Ii-L1
	for gcvg-git-2@plane.gmane.org; Fri, 20 Mar 2015 11:08:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751796AbbCTKHz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2015 06:07:55 -0400
Received: from cloud.peff.net ([50.56.180.127]:35677 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751401AbbCTKHy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Mar 2015 06:07:54 -0400
Received: (qmail 5651 invoked by uid 102); 20 Mar 2015 10:07:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 20 Mar 2015 05:07:55 -0500
Received: (qmail 21469 invoked by uid 107); 20 Mar 2015 10:08:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 20 Mar 2015 06:08:07 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 20 Mar 2015 06:07:52 -0400
Content-Disposition: inline
In-Reply-To: <20150320100429.GA17354@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265879>

Some tests call test_cmp, and if it fails show the actual
output generated. This is mostly pointless, as test_cmp will
already show a diff between the expected and actual output.
It also fools --chain-lint by putting an "||" in the middle
of the chain, so we'd rather not use this construct.

Note that these cases actually show a pre-processed version
of the data, rather than exactly what test_cmp would show.
However, test_cmp's output is generally good for pointing
the user in the right direction, and they can then dig in
the trash directory themselves if they want to see more
details.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t6012-rev-list-simplify.sh | 10 ++--------
 t/t6111-rev-list-treesame.sh |  5 +----
 2 files changed, 3 insertions(+), 12 deletions(-)

diff --git a/t/t6012-rev-list-simplify.sh b/t/t6012-rev-list-simplify.sh
index fde5e71..b89cd6b 100755
--- a/t/t6012-rev-list-simplify.sh
+++ b/t/t6012-rev-list-simplify.sh
@@ -95,10 +95,7 @@ check_outcome () {
 		git log --pretty="$FMT" --parents $param |
 		unnote >actual &&
 		sed -e "s/^.*	\([^ ]*\) .*/\1/" >check <actual &&
-		test_cmp expect check || {
-			cat actual
-			false
-		}
+		test_cmp expect check
 	'
 }
 
@@ -121,10 +118,7 @@ test_expect_success 'full history simplification without parent' '
 	git log --pretty="$FMT" --full-history E -- lost |
 	unnote >actual &&
 	sed -e "s/^.*	\([^ ]*\) .*/\1/" >check <actual &&
-	test_cmp expect check || {
-		cat actual
-		false
-	}
+	test_cmp expect check
 '
 
 test_expect_success '--full-diff is not affected by --parents' '
diff --git a/t/t6111-rev-list-treesame.sh b/t/t6111-rev-list-treesame.sh
index 45e3673..32474c2 100755
--- a/t/t6111-rev-list-treesame.sh
+++ b/t/t6111-rev-list-treesame.sh
@@ -92,10 +92,7 @@ check_outcome () {
 		git log --format="$FMT" $param |
 		unnote >actual &&
 		sed -e "$munge_actual" <actual >check &&
-		test_cmp expect check || {
-			cat actual
-			false
-		}
+		test_cmp expect check
 	'
 }
 
-- 
2.3.3.520.g3cfbb5d
