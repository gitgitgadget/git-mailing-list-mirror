From: Jeff King <peff@peff.net>
Subject: [PATCH 20/68] compat/hstrerror: convert sprintf to snprintf
Date: Thu, 24 Sep 2015 17:06:48 -0400
Message-ID: <20150924210648.GQ30946@sigill.intra.peff.net>
References: <20150924210225.GA23624@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 24 23:07:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZfDjL-0001Ak-SW
	for gcvg-git-2@plane.gmane.org; Thu, 24 Sep 2015 23:07:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752610AbbIXVGx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Sep 2015 17:06:53 -0400
Received: from cloud.peff.net ([50.56.180.127]:35946 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752655AbbIXVGv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Sep 2015 17:06:51 -0400
Received: (qmail 11916 invoked by uid 102); 24 Sep 2015 21:06:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 24 Sep 2015 16:06:51 -0500
Received: (qmail 29111 invoked by uid 107); 24 Sep 2015 21:07:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 24 Sep 2015 17:07:03 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 Sep 2015 17:06:48 -0400
Content-Disposition: inline
In-Reply-To: <20150924210225.GA23624@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278582>

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
2.6.0.rc3.454.g204ad51
