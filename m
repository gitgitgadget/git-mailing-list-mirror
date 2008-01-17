From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] http-push: fix double free()
Date: Thu, 17 Jan 2008 19:45:11 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0801171943360.5731@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, gitster@pobox.com, nigel.magnay@gmail.com
X-From: git-owner@vger.kernel.org Thu Jan 17 20:46:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFagp-0003hA-Tx
	for gcvg-git-2@gmane.org; Thu, 17 Jan 2008 20:46:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752564AbYAQTpT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jan 2008 14:45:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752225AbYAQTpS
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jan 2008 14:45:18 -0500
Received: from mail.gmx.net ([213.165.64.20]:37378 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752879AbYAQTpQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jan 2008 14:45:16 -0500
Received: (qmail invoked by alias); 17 Jan 2008 19:45:14 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp004) with SMTP; 17 Jan 2008 20:45:14 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX180rQIyMSQ02VZyKXTIMnupiy5v2tS0YVbu0u77uK
	q4rDKHTpcpMQFx
X-X-Sender: gene099@racer.site
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70911>


There was an extra free(url) in remote_exists() (both if clauses before 
that contain a free(url) already), which resulted in a crash on Windows.

Noticed by Nigel Magnay.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	This fixes Issue 71 of msysGit, as far as I can tell.

 http-push.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/http-push.c b/http-push.c
index 64be904..a78e0a9 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1991,7 +1991,6 @@ static int remote_exists(const char *path)
 		fprintf(stderr, "Unable to start HEAD request\n");
 	}
 
-	free(url);
 	return ret;
 }
 
-- 
1.5.3.6.2304.gbc8e45-dirty
