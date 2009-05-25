From: Thomas Spura <tomspur@fedoraproject.org>
Subject: [PATCH] speed: reuse char instead of recreation in loop
Date: Mon, 25 May 2009 19:44:10 +0000 (UTC)
Message-ID: <pan.2009.05.25.19.44.10@fedoraproject.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 25 21:55:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M8gGM-0004kH-Cv
	for gcvg-git-2@gmane.org; Mon, 25 May 2009 21:55:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753167AbZEYTzE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 May 2009 15:55:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752961AbZEYTzD
	(ORCPT <rfc822;git-outgoing>); Mon, 25 May 2009 15:55:03 -0400
Received: from main.gmane.org ([80.91.229.2]:59140 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752451AbZEYTzB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 May 2009 15:55:01 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1M8gGE-0007bh-HA
	for git@vger.kernel.org; Mon, 25 May 2009 19:55:02 +0000
Received: from p5b20e9ac.dip.t-dialin.net ([91.32.233.172])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 25 May 2009 19:55:02 +0000
Received: from tomspur by p5b20e9ac.dip.t-dialin.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 25 May 2009 19:55:02 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: p5b20e9ac.dip.t-dialin.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119960>

Move a char and a char * outside of a for loop for speed improvements

Signed-off-by: Thomas Spura <tomspur@fedoraproject.org>
---
Comments?

 transport.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/transport.c b/transport.c
index 17891d5..e350937 100644
--- a/transport.c
+++ b/transport.c
@@ -263,11 +263,10 @@ static int write_refs_to_temp_dir(struct strbuf 
*temp_dir,
 		int refspec_nr, const char **refspec)
 {
 	int i;
+	unsigned char sha1[20];
+	char *ref;
 
 	for (i = 0; i < refspec_nr; i++) {
-		unsigned char sha1[20];
-		char *ref;
-
 		if (dwim_ref(refspec[i], strlen(refspec[i]), sha1, &ref) !
= 1)
 			return error("Could not get ref %s", refspec[i]);
 
@@ -275,8 +274,8 @@ static int write_refs_to_temp_dir(struct strbuf 
*temp_dir,
 			free(ref);
 			return -1;
 		}
-		free(ref);
 	}
+	free(ref);
 	return 0;
 }
 
-- 
1.6.0.6
