From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] git fetch-pack: do not complain about "no common commits"
 in an empty repo
Date: Wed, 2 Jul 2008 18:06:56 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0807021806250.9925@racer>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Steffen Prohaska <prohaska@zib.de>, gitster@pobox.com,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 02 19:09:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KE5q3-0006iU-4r
	for gcvg-git-2@gmane.org; Wed, 02 Jul 2008 19:09:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753218AbYGBRIv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jul 2008 13:08:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753078AbYGBRIv
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Jul 2008 13:08:51 -0400
Received: from mail.gmx.net ([213.165.64.20]:35984 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752790AbYGBRIu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jul 2008 13:08:50 -0400
Received: (qmail invoked by alias); 02 Jul 2008 17:08:48 -0000
Received: from grape.st-and.ac.uk (EHLO grape.st-and.ac.uk) [138.251.155.28]
  by mail.gmx.net (mp061) with SMTP; 02 Jul 2008 19:08:48 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+LZq9Bf2yL4jwgFgCgrdpLCIjBQEmVX9kBlTcdqB
	LALH5cFP5lFWVy
X-X-Sender: gene099@racer
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.61
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87162>


If the repo is empty, it is obvious that there are no common commits
when fetching from _anywhere_.

So there is no use in saying it in that case, and it can even be
annoying.  Therefore suppress the message unilaterally if the repository
is empty prior to the fetch.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	This patch was originally developed in the 4msysgit branch.

 builtin-fetch-pack.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/builtin-fetch-pack.c b/builtin-fetch-pack.c
index f4dbcf0..2175c6d 100644
--- a/builtin-fetch-pack.c
+++ b/builtin-fetch-pack.c
@@ -309,7 +309,8 @@ done:
 		}
 		flushes--;
 	}
-	return retval;
+	/* it is no error to fetch into a completely empty repo */
+	return count ? retval : 0;
 }
 
 static struct commit_list *complete;
-- 
1.5.6.1.300.gca3f
