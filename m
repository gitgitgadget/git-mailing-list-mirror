From: Nick Hengeveld <nickh@reactrix.com>
Subject: [PATCH] http-push cleanup
Date: Tue, 29 Nov 2005 09:33:36 -0800
Message-ID: <20051129173336.GA3809@reactrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue Nov 29 18:41:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eh9MK-0003qZ-LH
	for gcvg-git@gmane.org; Tue, 29 Nov 2005 18:33:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932112AbVK2Rdi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 29 Nov 2005 12:33:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932265AbVK2Rdi
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Nov 2005 12:33:38 -0500
Received: from 195.37.26.69.virtela.com ([69.26.37.195]:8838 "EHLO
	teapot.corp.reactrix.com") by vger.kernel.org with ESMTP
	id S932112AbVK2Rdh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Nov 2005 12:33:37 -0500
Received: from teapot.corp.reactrix.com (localhost.localdomain [127.0.0.1])
	by teapot.corp.reactrix.com (8.12.11/8.12.11) with ESMTP id jATHXbOH005981
	for <git@vger.kernel.org>; Tue, 29 Nov 2005 09:33:37 -0800
Received: (from nickh@localhost)
	by teapot.corp.reactrix.com (8.12.11/8.12.11/Submit) id jATHXaYv005979
	for git@vger.kernel.org; Tue, 29 Nov 2005 09:33:36 -0800
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12949>

The malloc patch from Jan Andres fixed the problem that was causing a
segfault when freeing the lock token, and Johannes Schindelin found
and fixed a problem when no URL is specified on the command line.

Signed-off-by: Nick Hengeveld <nickh@reactrix.com>


---

 http-push.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

applies-to: 39ddd76c46b92ac971b2325acf9efecf443fbe6b
1510a5b7deec93abcf010aa867adf27ad7750293
diff --git a/http-push.c b/http-push.c
index bbb5118..56c2bb5 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1009,9 +1009,7 @@ static int unlock_remote(struct active_l
 	if (lock->owner != NULL)
 		free(lock->owner);
 	free(lock->url);
-/* Freeing the token causes a segfault...
 	free(lock->token);
-*/
 	free(lock);
 
 	return rc;
@@ -1274,6 +1272,9 @@ int main(int argc, char **argv)
 		break;
 	}
 
+	if (!remote->url)
+		usage(http_push_usage);
+
 	memset(remote_dir_exists, 0, 256);
 
 	http_init();
---
0.99.9.GIT
