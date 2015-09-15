From: Jeff King <peff@peff.net>
Subject: [PATCH 20/67] compat/hstrerror: convert sprintf to snprintf
Date: Tue, 15 Sep 2015 11:39:39 -0400
Message-ID: <20150915153939.GT29753@sigill.intra.peff.net>
References: <20150915152125.GA27504@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 15 17:39:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZbsKg-0000mA-EF
	for gcvg-git-2@plane.gmane.org; Tue, 15 Sep 2015 17:39:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753184AbbIOPjm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Sep 2015 11:39:42 -0400
Received: from cloud.peff.net ([50.56.180.127]:59328 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752379AbbIOPjm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Sep 2015 11:39:42 -0400
Received: (qmail 11839 invoked by uid 102); 15 Sep 2015 15:39:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 15 Sep 2015 10:39:41 -0500
Received: (qmail 7133 invoked by uid 107); 15 Sep 2015 15:39:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 15 Sep 2015 11:39:50 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 15 Sep 2015 11:39:39 -0400
Content-Disposition: inline
In-Reply-To: <20150915152125.GA27504@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277922>

This is a trivially correct use of sprintf, as our error
number should not be excessively long. But it's still nice
to drop an sprintf call.

Note that we cannot use xsnprintf here, because this is
compat code which does not load git-compat-util.h.

Signed-off-by: Jeff King <peff@peff.net>
---
 compat/hstrerror.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/compat/hstrerror.c b/compat/hstrerror.c
index 069c555..b85a2fa 100644
--- a/compat/hstrerror.c
+++ b/compat/hstrerror.c
@@ -16,6 +16,6 @@ const char *githstrerror(int err)
 	case TRY_AGAIN:
 		return "Non-authoritative \"host not found\", or SERVERFAIL";
 	}
-	sprintf(buffer, "Name resolution error %d", err);
+	snprintf(buffer, sizeof(buffer), "Name resolution error %d", err);
 	return buffer;
 }
-- 
2.6.0.rc2.408.ga2926b9
