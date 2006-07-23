From: Martin Waitz <tali@admingilde.org>
Subject: [PATCH] support cover letter before commit log, using "+++"
Date: Sun, 23 Jul 2006 23:45:25 +0200
Message-ID: <20060723214524.GC20068@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun Jul 23 23:45:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G4llX-0003dB-3h
	for gcvg-git@gmane.org; Sun, 23 Jul 2006 23:45:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751321AbWGWVp2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 23 Jul 2006 17:45:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751325AbWGWVp2
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Jul 2006 17:45:28 -0400
Received: from admingilde.org ([213.95.32.146]:11407 "EHLO mail.admingilde.org")
	by vger.kernel.org with ESMTP id S1751321AbWGWVp1 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 23 Jul 2006 17:45:27 -0400
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1G4llN-0006L4-3q
	for git@vger.kernel.org; Sun, 23 Jul 2006 23:45:25 +0200
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24108>

We already have a "---" separator to end the commit log.
But writing the cover letter after this separator looks strange.
Now it is possible to put the cover letter and comments both before
or after the commit log, as the author sees fit.

Just put the commit log between lines starting with "+++" and "---".

Signed-off-by: Martin Waitz <tali@admingilde.org>
---
 builtin-mailinfo.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/builtin-mailinfo.c b/builtin-mailinfo.c
index ac53f76..a1cfc81 100644
--- a/builtin-mailinfo.c
+++ b/builtin-mailinfo.c
@@ -690,6 +690,13 @@ static int handle_commit_msg(int *seen)
 			return 1;
 		}
 
+		/* check for separator between cover-letter and commit log */
+		if (!memcmp("+++", line, 3)) {
+			rewind(cmitmsg);
+			ftruncate(fileno(cmitmsg), 0);
+			continue;
+		}
+
 		/* Unwrap transfer encoding and optionally
 		 * normalize the log message to UTF-8.
 		 */
-- 
1.4.1.gd3582

-- 
Martin Waitz
