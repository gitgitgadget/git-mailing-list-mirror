From: Jeff King <peff@peff.net>
Subject: [PATCH 21/67] grep: use xsnprintf to format failure message
Date: Tue, 15 Sep 2015 11:39:52 -0400
Message-ID: <20150915153951.GU29753@sigill.intra.peff.net>
References: <20150915152125.GA27504@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 15 17:40:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZbsKt-0000vf-MC
	for gcvg-git-2@plane.gmane.org; Tue, 15 Sep 2015 17:40:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753268AbbIOPjz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Sep 2015 11:39:55 -0400
Received: from cloud.peff.net ([50.56.180.127]:59331 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752239AbbIOPjy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Sep 2015 11:39:54 -0400
Received: (qmail 11845 invoked by uid 102); 15 Sep 2015 15:39:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 15 Sep 2015 10:39:54 -0500
Received: (qmail 7155 invoked by uid 107); 15 Sep 2015 15:40:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 15 Sep 2015 11:40:03 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 15 Sep 2015 11:39:52 -0400
Content-Disposition: inline
In-Reply-To: <20150915152125.GA27504@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277923>

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
2.6.0.rc2.408.ga2926b9
