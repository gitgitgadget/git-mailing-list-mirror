From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Fix git-update-index --again
Date: Thu, 21 Sep 2006 23:29:59 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0609212329310.19042@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Thu Sep 21 23:31:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GQW89-0005Lp-5v
	for gcvg-git@gmane.org; Thu, 21 Sep 2006 23:30:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751583AbWIUVaF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Sep 2006 17:30:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751586AbWIUVaF
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Sep 2006 17:30:05 -0400
Received: from mail.gmx.de ([213.165.64.20]:48041 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751583AbWIUVaB (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Sep 2006 17:30:01 -0400
Received: (qmail invoked by alias); 21 Sep 2006 21:29:59 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp029) with SMTP; 21 Sep 2006 23:29:59 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27503>


It called read_ref(git_path(..)..), where read_ref does the git_path()
stuff itself.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---
 builtin-update-index.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin-update-index.c b/builtin-update-index.c
index 0620e77..09214c8 100644
--- a/builtin-update-index.c
+++ b/builtin-update-index.c
@@ -404,9 +404,9 @@ static int unresolve_one(const char *pat
 
 static void read_head_pointers(void)
 {
-	if (read_ref(git_path("HEAD"), head_sha1))
+	if (read_ref("HEAD", head_sha1))
 		die("No HEAD -- no initial commit yet?\n");
-	if (read_ref(git_path("MERGE_HEAD"), merge_head_sha1)) {
+	if (read_ref("MERGE_HEAD", merge_head_sha1)) {
 		fprintf(stderr, "Not in the middle of a merge.\n");
 		exit(0);
 	}
@@ -443,7 +443,7 @@ static int do_reupdate(int ac, const cha
 	int has_head = 1;
 	const char **pathspec = get_pathspec(prefix, av + 1);
 
-	if (read_ref(git_path("HEAD"), head_sha1))
+	if (read_ref("HEAD", head_sha1))
 		/* If there is no HEAD, that means it is an initial
 		 * commit.  Update everything in the index.
 		 */
-- 
1.4.2.1.ge488
