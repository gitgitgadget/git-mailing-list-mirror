From: Jeff King <peff@peff.net>
Subject: [PATCH 4/8] t7701: fix ignored exit code inside loop
Date: Wed, 25 Mar 2015 01:29:10 -0400
Message-ID: <20150325052909.GD31924@peff.net>
References: <20150325052456.GA19394@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Wed Mar 25 06:29:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YadsT-0000yh-GR
	for gcvg-git-2@plane.gmane.org; Wed, 25 Mar 2015 06:29:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752469AbbCYF3N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Mar 2015 01:29:13 -0400
Received: from cloud.peff.net ([50.56.180.127]:38167 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750873AbbCYF3M (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Mar 2015 01:29:12 -0400
Received: (qmail 17446 invoked by uid 102); 25 Mar 2015 05:29:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 25 Mar 2015 00:29:12 -0500
Received: (qmail 11645 invoked by uid 107); 25 Mar 2015 05:29:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 25 Mar 2015 01:29:26 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 25 Mar 2015 01:29:10 -0400
Content-Disposition: inline
In-Reply-To: <20150325052456.GA19394@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266257>

When checking a list of file mtimes, we use a loop and break
out early from the loop if any entry does not match.
However, the exit code of a loop exited via break is always
0, meaning that the test will fail to notice we had a
mismatch. Since the loop is inside a function, we can fix
this by doing an early "return 1".

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t7701-repack-unpack-unreachable.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t7701-repack-unpack-unreachable.sh b/t/t7701-repack-unpack-unreachable.sh
index aad8a9c..b66e383 100755
--- a/t/t7701-repack-unpack-unreachable.sh
+++ b/t/t7701-repack-unpack-unreachable.sh
@@ -57,7 +57,7 @@ compare_mtimes ()
 {
 	read tref rest &&
 	while read t rest; do
-		test "$tref" = "$t" || break
+		test "$tref" = "$t" || return 1
 	done
 }
 
-- 
2.3.4.635.gd6ffcfe
