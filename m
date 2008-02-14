From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 2/3] http-push: do not get confused by submodules
Date: Thu, 14 Feb 2008 23:25:54 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802142325400.30505@racer.site>
References: <alpine.LSU.1.00.0802142319340.30505@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, gitster@pobox.com, mh@glandium.org
X-From: git-owner@vger.kernel.org Fri Feb 15 00:26:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPnTN-0000zZ-JK
	for gcvg-git-2@gmane.org; Fri, 15 Feb 2008 00:26:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758027AbYBNXZ6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Feb 2008 18:25:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758020AbYBNXZ6
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Feb 2008 18:25:58 -0500
Received: from mail.gmx.net ([213.165.64.20]:38372 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757849AbYBNXZ5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Feb 2008 18:25:57 -0500
Received: (qmail invoked by alias); 14 Feb 2008 23:25:55 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp014) with SMTP; 15 Feb 2008 00:25:55 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+bYCMB/gObOFaMhmSfRzXQn14tq4hw94v+6nX0f6
	feGd+TwiVaGGND
X-X-Sender: gene099@racer.site
In-Reply-To: <alpine.LSU.1.00.0802142319340.30505@racer.site>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73925>


When encountering submodules in a tree, http-push should not try sending
the respective object.  Instead, it should ignore it.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 http-push.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/http-push.c b/http-push.c
index 7a6c669..93bd87d 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1637,7 +1637,7 @@ static struct object_list **process_tree(struct tree *tree,
 	while (tree_entry(&desc, &entry)) {
 		if (S_ISDIR(entry.mode))
 			p = process_tree(lookup_tree(entry.sha1), p, &me, name);
-		else
+		else if (!S_ISGITLINK(entry.mode))
 			p = process_blob(lookup_blob(entry.sha1), p, &me, name);
 	}
 	free(tree->buffer);
-- 
1.5.4.1.1353.g0d5dd
