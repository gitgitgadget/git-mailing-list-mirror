From: Jeff King <peff@peff.net>
Subject: [PATCH 19/68] stop_progress_msg: convert sprintf to xsnprintf
Date: Thu, 24 Sep 2015 17:06:46 -0400
Message-ID: <20150924210646.GP30946@sigill.intra.peff.net>
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
	id 1ZfDjE-0001Ak-VF
	for gcvg-git-2@plane.gmane.org; Thu, 24 Sep 2015 23:06:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752724AbbIXVGv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Sep 2015 17:06:51 -0400
Received: from cloud.peff.net ([50.56.180.127]:35944 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752352AbbIXVGs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Sep 2015 17:06:48 -0400
Received: (qmail 11911 invoked by uid 102); 24 Sep 2015 21:06:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 24 Sep 2015 16:06:48 -0500
Received: (qmail 29088 invoked by uid 107); 24 Sep 2015 21:07:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 24 Sep 2015 17:07:01 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 Sep 2015 17:06:46 -0400
Content-Disposition: inline
In-Reply-To: <20150924210225.GA23624@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278580>

The usual arguments for using xsnprintf over sprintf apply,
but this case is a little tricky. We print to a fixed-size
buffer if we have room, and otherwise to an allocated
buffer. So there should be no overflow here, but it is still
good to communicate our intention, as well as to check our
earlier math for how much space the string will need.

Signed-off-by: Jeff King <peff@peff.net>
---
 progress.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/progress.c b/progress.c
index a3efcfd..353bd37 100644
--- a/progress.c
+++ b/progress.c
@@ -254,7 +254,7 @@ void stop_progress_msg(struct progress **p_progress, const char *msg)
 			throughput_string(&tp->display, tp->curr_total, rate);
 		}
 		progress_update = 1;
-		sprintf(bufp, ", %s.\n", msg);
+		xsnprintf(bufp, len + 1, ", %s.\n", msg);
 		display(progress, progress->last_value, bufp);
 		if (buf != bufp)
 			free(bufp);
-- 
2.6.0.rc3.454.g204ad51
