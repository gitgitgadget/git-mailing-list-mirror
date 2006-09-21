From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] show-branch: mark active branch with a '*' again
Date: Fri, 22 Sep 2006 00:07:01 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0609220006010.19042@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Fri Sep 22 00:07:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GQWhm-0005ho-Rz
	for gcvg-git@gmane.org; Fri, 22 Sep 2006 00:07:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751669AbWIUWHG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Sep 2006 18:07:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751671AbWIUWHF
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Sep 2006 18:07:05 -0400
Received: from mail.gmx.de ([213.165.64.20]:45790 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751669AbWIUWHD (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Sep 2006 18:07:03 -0400
Received: (qmail invoked by alias); 21 Sep 2006 22:07:01 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp027) with SMTP; 22 Sep 2006 00:07:01 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27505>


This was lost in the packed-ref updates. The original test was a bit
dubious, so I cleaned that up, too. It fixes the case when the current HEAD
is refs/heads/bla/master: the original test was true for both bla/master
_and_ master.

However, it shares a hard-to-fix bug with the original test: if the current
HEAD is refs/heads/master, and there is a branch refs/heads/heads/master,
then both are marked active.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

	... and since nobody uses headlen, there is no need to fix that up.

 builtin-show-branch.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/builtin-show-branch.c b/builtin-show-branch.c
index 5d6ce56..fb1a400 100644
--- a/builtin-show-branch.c
+++ b/builtin-show-branch.c
@@ -443,6 +443,12 @@ static int rev_is_head(char *head, int h
 	if ((!head[0]) ||
 	    (head_sha1 && sha1 && hashcmp(head_sha1, sha1)))
 		return 0;
+	if (!strncmp(head, "refs/heads/", 11))
+		head += 11;
+	if (!strncmp(name, "refs/heads/", 11))
+		name += 11;
+	else if (!strncmp(name, "heads/", 6))
+		name += 6;
 	return !strcmp(head, name);
 }
 
-- 
1.4.2.1.g9797-dirty
