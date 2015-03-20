From: Jeff King <peff@peff.net>
Subject: [PATCH 22/25] t0050: appease --chain-lint
Date: Fri, 20 Mar 2015 06:13:25 -0400
Message-ID: <20150320101325.GV12543@peff.net>
References: <20150320100429.GA17354@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 20 11:13:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYtvq-0005zp-7D
	for gcvg-git-2@plane.gmane.org; Fri, 20 Mar 2015 11:13:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752073AbbCTKNb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2015 06:13:31 -0400
Received: from cloud.peff.net ([50.56.180.127]:35727 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751385AbbCTKN2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Mar 2015 06:13:28 -0400
Received: (qmail 5943 invoked by uid 102); 20 Mar 2015 10:13:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 20 Mar 2015 05:13:28 -0500
Received: (qmail 21722 invoked by uid 107); 20 Mar 2015 10:13:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 20 Mar 2015 06:13:40 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 20 Mar 2015 06:13:25 -0400
Content-Disposition: inline
In-Reply-To: <20150320100429.GA17354@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265891>

Some of the symlink tests check an either-or case using the
"||". This is not wrong, but fools --chain-lint into
thinking the &&-chain is broken (in fact, there is no &&
chain here).

We can solve this by wrapping the "||" inside a {} block.
This is a bit more verbose, but this construct is rare, and
the {} block helps call attention to it.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t0050-filesystem.sh | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/t/t0050-filesystem.sh b/t/t0050-filesystem.sh
index 988c392..b29d749 100755
--- a/t/t0050-filesystem.sh
+++ b/t/t0050-filesystem.sh
@@ -33,16 +33,20 @@ test_expect_success "detection of case insensitive filesystem during repo init"
 '
 else
 test_expect_success "detection of case insensitive filesystem during repo init" '
-	test_must_fail git config --bool core.ignorecase >/dev/null ||
-	test $(git config --bool core.ignorecase) = false
+	{
+		test_must_fail git config --bool core.ignorecase >/dev/null ||
+			test $(git config --bool core.ignorecase) = false
+	}
 '
 fi
 
 if test_have_prereq SYMLINKS
 then
 test_expect_success "detection of filesystem w/o symlink support during repo init" '
-	test_must_fail git config --bool core.symlinks ||
-	test "$(git config --bool core.symlinks)" = true
+	{
+		test_must_fail git config --bool core.symlinks ||
+		test "$(git config --bool core.symlinks)" = true
+	}
 '
 else
 test_expect_success "detection of filesystem w/o symlink support during repo init" '
-- 
2.3.3.520.g3cfbb5d
