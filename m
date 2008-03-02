From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Fix make_absolute_path() for parameters without a slash
Date: Sun, 2 Mar 2008 07:17:49 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0803020717060.22527@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Mar 02 08:19:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JViTp-0007fv-Bc
	for gcvg-git-2@gmane.org; Sun, 02 Mar 2008 08:19:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751920AbYCBHSd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Mar 2008 02:18:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751886AbYCBHSd
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Mar 2008 02:18:33 -0500
Received: from mail.gmx.net ([213.165.64.20]:54359 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751869AbYCBHSd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Mar 2008 02:18:33 -0500
Received: (qmail invoked by alias); 02 Mar 2008 07:18:31 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp048) with SMTP; 02 Mar 2008 08:18:31 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19/GEN+kjx/5I6DTLsiGPPt8WRjDBKV/HtPCicvH4
	siY5g/85fvvjmt
X-X-Sender: gene099@racer.site
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75735>


When passing "xyz" to make_absolute_path(), make_absolute_path()
erroneously tried to chdir("xyz"), and then append "/xyz".  Instead,
skip the chdir() completely when no slash was found.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	I should add a test, but I am simply too tired now.  Will do so 
	tomorrow.

 path.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/path.c b/path.c
index 4260952..bf3e469 100644
--- a/path.c
+++ b/path.c
@@ -311,8 +311,10 @@ const char *make_absolute_path(const char *path)
 			if (last_slash) {
 				*last_slash = '\0';
 				last_elem = xstrdup(last_slash + 1);
-			} else
+			} else {
+				*buf = '\0';
 				last_elem = xstrdup(buf);
+			}
 		}
 
 		if (*buf) {
-- 
1.5.4.3.446.gbe8932

