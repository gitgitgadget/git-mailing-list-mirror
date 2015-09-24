From: Jeff King <peff@peff.net>
Subject: [PATCH 21/68] grep: use xsnprintf to format failure message
Date: Thu, 24 Sep 2015 17:06:51 -0400
Message-ID: <20150924210650.GR30946@sigill.intra.peff.net>
References: <20150924210225.GA23624@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 24 23:07:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZfDjF-0001Ak-Qk
	for gcvg-git-2@plane.gmane.org; Thu, 24 Sep 2015 23:06:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752786AbbIXVGy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Sep 2015 17:06:54 -0400
Received: from cloud.peff.net ([50.56.180.127]:35949 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752655AbbIXVGx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Sep 2015 17:06:53 -0400
Received: (qmail 11922 invoked by uid 102); 24 Sep 2015 21:06:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 24 Sep 2015 16:06:53 -0500
Received: (qmail 29119 invoked by uid 107); 24 Sep 2015 21:07:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 24 Sep 2015 17:07:05 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 Sep 2015 17:06:51 -0400
Content-Disposition: inline
In-Reply-To: <20150924210225.GA23624@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278575>

This looks at first glance like the sprintf can overflow our
buffer, but it's actually fine; the p->origin string is
something constant and small, like "command line" or "-e
option".

Signed-off-by: Jeff King <peff@peff.net>
---
 grep.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/grep.c b/grep.c
index b58c7c6..6c68d5b 100644
--- a/grep.c
+++ b/grep.c
@@ -306,9 +306,9 @@ static NORETURN void compile_regexp_failed(const struct grep_pat *p,
 	char where[1024];
 
 	if (p->no)
-		sprintf(where, "In '%s' at %d, ", p->origin, p->no);
+		xsnprintf(where, sizeof(where), "In '%s' at %d, ", p->origin, p->no);
 	else if (p->origin)
-		sprintf(where, "%s, ", p->origin);
+		xsnprintf(where, sizeof(where), "%s, ", p->origin);
 	else
 		where[0] = 0;
 
-- 
2.6.0.rc3.454.g204ad51
