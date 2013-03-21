From: Jeff King <peff@peff.net>
Subject: [PATCH 4/4] transport: drop "int cmp = cmp" hack
Date: Thu, 21 Mar 2013 07:13:33 -0400
Message-ID: <20130321111333.GD18819@sigill.intra.peff.net>
References: <20130321110338.GA18552@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 21 12:14:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UIdRf-0008W0-U7
	for gcvg-git-2@plane.gmane.org; Thu, 21 Mar 2013 12:14:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756104Ab3CULNk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Mar 2013 07:13:40 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:33671 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754606Ab3CULNk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Mar 2013 07:13:40 -0400
Received: (qmail 20877 invoked by uid 107); 21 Mar 2013 11:15:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 21 Mar 2013 07:15:24 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 21 Mar 2013 07:13:33 -0400
Content-Disposition: inline
In-Reply-To: <20130321110338.GA18552@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218711>

According to 47ec794, this initialization is meant to
squelch an erroneous uninitialized variable warning from gcc
4.0.1.  That version is quite old at this point, and gcc 4.1
and up handle it fine, with one exception. There seems to be
a regression in gcc 4.6.3, which produces the warning;
however, gcc versions 4.4.7 and 4.7.2 do not.

Signed-off-by: Jeff King <peff@peff.net>
---
We probably _don't_ want to apply this one right now. The regression in
4.6 means some people on reasonably modern systems probably would still
see the warning. Debian stable ships with 4.4, and testing/unstable
defaults to 4.7 (though you can install a gcc-4.6 compatibility
package). But I have no clue if other distros made releases with 4.6.

 transport.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/transport.c b/transport.c
index 886ffd8..87b8f14 100644
--- a/transport.c
+++ b/transport.c
@@ -106,7 +106,7 @@ static void insert_packed_refs(const char *packed_refs, struct ref **list)
 		return;
 
 	for (;;) {
-		int cmp = cmp, len;
+		int cmp, len;
 
 		if (!fgets(buffer, sizeof(buffer), f)) {
 			fclose(f);
-- 
1.8.2.rc2.8.g2161951
