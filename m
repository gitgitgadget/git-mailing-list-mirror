From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] alloc_ref(): allow for trailing NUL
Date: Fri, 28 Sep 2007 03:57:17 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709280356550.28395@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: gitster@pobox.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 28 04:58:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ib63n-0002v0-6A
	for gcvg-git-2@gmane.org; Fri, 28 Sep 2007 04:58:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754020AbXI1C6Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Sep 2007 22:58:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754071AbXI1C6Z
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Sep 2007 22:58:25 -0400
Received: from mail.gmx.net ([213.165.64.20]:35149 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753863AbXI1C6Y (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Sep 2007 22:58:24 -0400
Received: (qmail invoked by alias); 28 Sep 2007 02:58:22 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp053) with SMTP; 28 Sep 2007 04:58:22 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+3PT9khRK31TS0T1aACVaD34DeQg0ZSxJl6doWI4
	ZtdnLVl9GBvxLY
X-X-Sender: gene099@racer.site
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59353>


The parameter name "namelen" suggests that you pass the equivalent of
strlen() to the function alloc_ref().  However, this function did not
allocate enough space to put a NUL after the name.

Since struct ref does not have any member to describe the length of the
string, this just does not make sense.

So make space for the NUL.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 remote.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/remote.c b/remote.c
index e7d735b..7531c92 100644
--- a/remote.c
+++ b/remote.c
@@ -453,7 +453,7 @@ int remote_find_tracking(struct remote *remote, struct refspec *refspec)
 
 struct ref *alloc_ref(unsigned namelen)
 {
-	struct ref *ret = xmalloc(sizeof(struct ref) + namelen);
+	struct ref *ret = xmalloc(sizeof(struct ref) + namelen + 1);
 	memset(ret, 0, sizeof(struct ref) + namelen);
 	return ret;
 }
-- 
1.5.3.2.1102.g9487
