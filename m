From: Jeff King <peff@peff.net>
Subject: [PATCH 32/67] mailmap: replace strcpy with xstrdup
Date: Tue, 15 Sep 2015 11:49:03 -0400
Message-ID: <20150915154903.GF29753@sigill.intra.peff.net>
References: <20150915152125.GA27504@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 15 17:56:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zbsav-000322-Jb
	for gcvg-git-2@plane.gmane.org; Tue, 15 Sep 2015 17:56:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753608AbbIOPzv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Sep 2015 11:55:51 -0400
Received: from cloud.peff.net ([50.56.180.127]:59364 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753980AbbIOPtF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Sep 2015 11:49:05 -0400
Received: (qmail 12479 invoked by uid 102); 15 Sep 2015 15:49:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 15 Sep 2015 10:49:05 -0500
Received: (qmail 7340 invoked by uid 107); 15 Sep 2015 15:49:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 15 Sep 2015 11:49:14 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 15 Sep 2015 11:49:03 -0400
Content-Disposition: inline
In-Reply-To: <20150915152125.GA27504@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277943>

We want to make a copy of a string without any leading
whitespace. To do so, we allocate a buffer large enough to
hold the original, skip past the whitespace, then copy that.
It's much simpler to just allocate after we've skipped, in
which case we can just copy the remainder of the string,
leaving no question of whether "len" is large enough.

Signed-off-by: Jeff King <peff@peff.net>
---
 mailmap.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mailmap.c b/mailmap.c
index 9e95897..f4a0f1c 100644
--- a/mailmap.c
+++ b/mailmap.c
@@ -162,11 +162,10 @@ static void read_mailmap_line(struct string_list *map, char *buffer,
 			char *cp;
 
 			free(*repo_abbrev);
-			*repo_abbrev = xmalloc(len);
 
 			for (cp = buffer + abblen; isspace(*cp); cp++)
 				; /* nothing */
-			strcpy(*repo_abbrev, cp);
+			*repo_abbrev = xstrdup(cp);
 		}
 		return;
 	}
-- 
2.6.0.rc2.408.ga2926b9
