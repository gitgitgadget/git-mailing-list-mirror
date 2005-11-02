From: Martin Langhoff <martin@catalyst.net.nz>
Subject: [PATCH] cvsimport: catch error condition where cvs host disappears
Date: Wed, 2 Nov 2005 13:48:22 +1300
Message-ID: <11308925024013-git-send-email-martin@catalyst.net.nz>
Reply-To: Martin Langhoff <martin@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Martin Langhoff <martin@catalyst.net.nz>
X-From: git-owner@vger.kernel.org Wed Nov 02 01:45:05 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EX6jk-00061Y-8c
	for gcvg-git@gmane.org; Wed, 02 Nov 2005 01:44:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932100AbVKBAoR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 Nov 2005 19:44:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932098AbVKBAoQ
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Nov 2005 19:44:16 -0500
Received: from godel.catalyst.net.nz ([202.78.240.40]:25558 "EHLO
	mail1.catalyst.net.nz") by vger.kernel.org with ESMTP
	id S932081AbVKBAoP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Nov 2005 19:44:15 -0500
Received: from leibniz.catalyst.net.nz ([202.78.240.7] helo=mltest)
	by mail1.catalyst.net.nz with esmtp (Exim 4.50)
	id 1EX6jd-0007Kz-FR; Wed, 02 Nov 2005 13:44:13 +1300
Received: from mltest ([127.0.0.1])
	by mltest with smtp (Exim 3.36 #1 (Debian))
	id 1EX6ne-0001ed-00; Wed, 02 Nov 2005 13:48:22 +1300
In-Reply-To: 
X-Mailer: git-send-email
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10983>

Add error handling for cases where the cvs server goes away unexpectedly.
While I don't know why the cvs server is so erratic, we should definitely
exit here before committing bogus files.

Signed-off-by: Martin Langhoff <martin@catalyst.net.nz>


---

 git-cvsimport.perl |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

applies-to: 5184f41aebc18fdd90c27b76b8fb230fda58fb84
2f441d6598e78b59181a084f9db5be7993971602
diff --git a/git-cvsimport.perl b/git-cvsimport.perl
index bbb83fb..e3cad5a 100755
--- a/git-cvsimport.perl
+++ b/git-cvsimport.perl
@@ -337,6 +337,10 @@ sub file {
 	}
 	close ($fh);
 
+	if ($res eq '') {
+	    die "Looks like the server has gone away while fetching $fn $rev -- exiting!";
+	}
+
 	return ($name, $res);
 }
 
---
0.99.8.GIT
