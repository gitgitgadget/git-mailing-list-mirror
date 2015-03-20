From: Jeff King <peff@peff.net>
Subject: [PATCH 24/25] t0005: fix broken &&-chains
Date: Fri, 20 Mar 2015 06:13:32 -0400
Message-ID: <20150320101332.GX12543@peff.net>
References: <20150320100429.GA17354@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 20 11:13:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYtvw-00064y-P1
	for gcvg-git-2@plane.gmane.org; Fri, 20 Mar 2015 11:13:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752079AbbCTKNh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2015 06:13:37 -0400
Received: from cloud.peff.net ([50.56.180.127]:35732 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752070AbbCTKNf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Mar 2015 06:13:35 -0400
Received: (qmail 5955 invoked by uid 102); 20 Mar 2015 10:13:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 20 Mar 2015 05:13:35 -0500
Received: (qmail 21754 invoked by uid 107); 20 Mar 2015 10:13:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 20 Mar 2015 06:13:47 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 20 Mar 2015 06:13:32 -0400
Content-Disposition: inline
In-Reply-To: <20150320100429.GA17354@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265898>

The ":" noop command always returns true, so it is fine to
include these lines in an &&-chain (and it appeases
--chain-lint).

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t0005-signals.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t0005-signals.sh b/t/t0005-signals.sh
index 5c5707d..e7f27eb 100755
--- a/t/t0005-signals.sh
+++ b/t/t0005-signals.sh
@@ -40,12 +40,12 @@ test_expect_success 'create blob' '
 '
 
 test_expect_success !MINGW 'a constipated git dies with SIGPIPE' '
-	OUT=$( ((large_git; echo $? 1>&3) | :) 3>&1 )
+	OUT=$( ((large_git; echo $? 1>&3) | :) 3>&1 ) &&
 	test "$OUT" -eq 141
 '
 
 test_expect_success !MINGW 'a constipated git dies with SIGPIPE even if parent ignores it' '
-	OUT=$( ((trap "" PIPE; large_git; echo $? 1>&3) | :) 3>&1 )
+	OUT=$( ((trap "" PIPE; large_git; echo $? 1>&3) | :) 3>&1 ) &&
 	test "$OUT" -eq 141
 '
 
-- 
2.3.3.520.g3cfbb5d
