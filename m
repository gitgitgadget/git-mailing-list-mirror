From: Jeff King <peff@peff.net>
Subject: [PATCH 33/67] read_branches_file: replace strcpy with xstrdup
Date: Tue, 15 Sep 2015 11:49:50 -0400
Message-ID: <20150915154950.GG29753@sigill.intra.peff.net>
References: <20150915152125.GA27504@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 15 17:50:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZbsUY-0003iS-Q9
	for gcvg-git-2@plane.gmane.org; Tue, 15 Sep 2015 17:49:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754210AbbIOPtz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Sep 2015 11:49:55 -0400
Received: from cloud.peff.net ([50.56.180.127]:59367 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753955AbbIOPtx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Sep 2015 11:49:53 -0400
Received: (qmail 12566 invoked by uid 102); 15 Sep 2015 15:49:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 15 Sep 2015 10:49:53 -0500
Received: (qmail 7377 invoked by uid 107); 15 Sep 2015 15:50:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 15 Sep 2015 11:50:02 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 15 Sep 2015 11:49:50 -0400
Content-Disposition: inline
In-Reply-To: <20150915152125.GA27504@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277934>

This code is exactly replicating strdup, so let's just use
that. It's shorter, and eliminates some confusion (such as
whether "p - s" is really enough to hold the result; it is,
because we write NULs as we shrink "p").

Signed-off-by: Jeff King <peff@peff.net>
---
 remote.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/remote.c b/remote.c
index 5ab0f7f..1b69751 100644
--- a/remote.c
+++ b/remote.c
@@ -297,7 +297,6 @@ static void read_branches_file(struct remote *remote)
 	int n = 1000;
 	FILE *f = fopen(git_path("branches/%.*s", n, remote->name), "r");
 	char *s, *p;
-	int len;
 
 	if (!f)
 		return;
@@ -313,9 +312,7 @@ static void read_branches_file(struct remote *remote)
 	p = s + strlen(s);
 	while (isspace(p[-1]))
 		*--p = 0;
-	len = p - s;
-	p = xmalloc(len + 1);
-	strcpy(p, s);
+	p = xstrdup(s);
 
 	/*
 	 * The branches file would have URL and optionally
-- 
2.6.0.rc2.408.ga2926b9
