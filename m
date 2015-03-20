From: Jeff King <peff@peff.net>
Subject: [PATCH 25/25] t4104: drop hand-rolled error reporting
Date: Fri, 20 Mar 2015 06:13:36 -0400
Message-ID: <20150320101336.GY12543@peff.net>
References: <20150320100429.GA17354@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 20 11:13:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYtw2-0006Aw-5z
	for gcvg-git-2@plane.gmane.org; Fri, 20 Mar 2015 11:13:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751840AbbCTKNl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2015 06:13:41 -0400
Received: from cloud.peff.net ([50.56.180.127]:35735 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751990AbbCTKNj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Mar 2015 06:13:39 -0400
Received: (qmail 5962 invoked by uid 102); 20 Mar 2015 10:13:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 20 Mar 2015 05:13:39 -0500
Received: (qmail 21770 invoked by uid 107); 20 Mar 2015 10:13:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 20 Mar 2015 06:13:51 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 20 Mar 2015 06:13:36 -0400
Content-Disposition: inline
In-Reply-To: <20150320100429.GA17354@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265896>

This use of "||" fools --chain-lint into thinking the
&&-chain is broken (and indeed, it is somewhat broken; a
failure of update-index in these tests would show the patch
file, even if we never got to the part of the test where we
fed the patch to git-apply).

The extra blocks were there to include more debugging
output, but it hardly seems worth it; the user should know
which command failed (because git-apply will produce error
messages) and can look in the trash directory themselves.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t4104-apply-boundary.sh | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/t/t4104-apply-boundary.sh b/t/t4104-apply-boundary.sh
index 497afdc..32e3b0e 100755
--- a/t/t4104-apply-boundary.sh
+++ b/t/t4104-apply-boundary.sh
@@ -95,10 +95,7 @@ do
 		test_expect_success "apply $kind-patch $with context" '
 			cat original >victim &&
 			git update-index victim &&
-			git apply --index '"$u$kind-patch.$with"' || {
-				cat '"$kind-patch.$with"'
-				(exit 1)
-			} &&
+			git apply --index '"$u$kind-patch.$with"' &&
 			test_cmp '"$kind"'-expect victim
 		'
 	done
@@ -113,10 +110,7 @@ do
 	test_expect_success "apply non-git $kind-patch without context" '
 		cat original >victim &&
 		git update-index victim &&
-		git apply --unidiff-zero --index '"$kind-ng.without"' || {
-			cat '"$kind-ng.without"'
-			(exit 1)
-		} &&
+		git apply --unidiff-zero --index '"$kind-ng.without"' &&
 		test_cmp '"$kind"'-expect victim
 	'
 done
-- 
2.3.3.520.g3cfbb5d
