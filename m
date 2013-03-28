From: Jeff King <peff@peff.net>
Subject: [PATCH 3/6] dir.c::match_pathname(): adjust patternlen when shifting
 pattern
Date: Thu, 28 Mar 2013 17:47:47 -0400
Message-ID: <20130328214747.GC10936@sigill.intra.peff.net>
References: <20130328214358.GA10685@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, pclouds@gmail.com, avila.jn@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 28 22:48:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ULKgI-0006mr-JN
	for gcvg-git-2@plane.gmane.org; Thu, 28 Mar 2013 22:48:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754330Ab3C1Vrz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Mar 2013 17:47:55 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:44054 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754243Ab3C1Vry (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Mar 2013 17:47:54 -0400
Received: (qmail 30753 invoked by uid 107); 28 Mar 2013 21:49:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 28 Mar 2013 17:49:41 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 28 Mar 2013 17:47:47 -0400
Content-Disposition: inline
In-Reply-To: <20130328214358.GA10685@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219465>

If we receive a pattern that starts with "/", we shift it
forward to avoid looking at the "/" part. Since the prefix
and patternlen parameters are counts of what is in the
pattern, we must decrement them as we increment the pointer.

We remembered to handle prefix, but not patternlen. This
didn't cause any bugs, though, because the patternlen
parameter is not actually used. Since it will be used in
future patches, let's correct this oversight.

Signed-off-by: Jeff King <peff@peff.net>
---
New in this iteration.

 dir.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/dir.c b/dir.c
index fac82c1..cc4ce8b 100644
--- a/dir.c
+++ b/dir.c
@@ -597,6 +597,7 @@ int match_pathname(const char *pathname, int pathlen,
 	 */
 	if (*pattern == '/') {
 		pattern++;
+		patternlen--;
 		prefix--;
 	}
 
-- 
1.8.2.13.g0f18d3c
