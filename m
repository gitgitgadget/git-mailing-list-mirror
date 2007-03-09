From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 2/3] git-bundle: die if a given ref is not included in bundle
Date: Fri, 9 Mar 2007 03:48:46 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0703090348300.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: junkio@cox.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 09 03:48:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HPVA4-0003BA-Kt
	for gcvg-git@gmane.org; Fri, 09 Mar 2007 03:48:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992903AbXCICss (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Mar 2007 21:48:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992906AbXCICss
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Mar 2007 21:48:48 -0500
Received: from mail.gmx.net ([213.165.64.20]:43837 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S2992903AbXCICsr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Mar 2007 21:48:47 -0500
Received: (qmail invoked by alias); 09 Mar 2007 02:48:46 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO wbgn013.biozentrum.uni-wuerzburg.de) [132.187.25.13]
  by mail.gmx.net (mp037) with SMTP; 09 Mar 2007 03:48:46 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX184hYIDxQA4FUQ6fHbPIljxtbDJTMvXyhANmTno+4
	jbOY6fn6wDm5jd
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41781>


The earlier patch tried to be nice by just warning, but it seems
more likely that the user wants to adjust the parameters.

Also, it prevents a bundle containing _all_ revisions in the case
when the user only gave one ref, but also rev-list options which
excluded the ref.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	It really was a dumb idea not to error out there. Sorry.

 builtin-bundle.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/builtin-bundle.c b/builtin-bundle.c
index 33b533f..ca3de60 100644
--- a/builtin-bundle.c
+++ b/builtin-bundle.c
@@ -328,11 +328,9 @@ static int create_bundle(struct bundle_header *header, const char *path,
 		 * other limiting options could have prevented all the tips
 		 * from getting output.
 		 */
-		if (!(e->item->flags & SHOWN)) {
-			warn("ref '%s' is excluded by the rev-list options",
+		if (!(e->item->flags & SHOWN))
+			die("ref '%s' is excluded by the rev-list options",
 				e->name);
-			continue;
-		}
 		write_or_die(bundle_fd, sha1_to_hex(e->item->sha1), 40);
 		write_or_die(bundle_fd, " ", 1);
 		write_or_die(bundle_fd, ref, strlen(ref));
-- 
1.5.0.3.2601.gc1e5-dirty
