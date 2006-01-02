From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] diff-tree: stop on broken output pipe
Date: Mon, 2 Jan 2006 01:17:48 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0601020116020.11331@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Mon Jan 02 01:18:07 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EtDOj-0001QU-Lb
	for gcvg-git@gmane.org; Mon, 02 Jan 2006 01:18:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932295AbWABARw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 1 Jan 2006 19:17:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932297AbWABARw
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Jan 2006 19:17:52 -0500
Received: from wrzx35.rz.uni-wuerzburg.de ([132.187.3.35]:1760 "EHLO
	wrzx35.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S932295AbWABARv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Jan 2006 19:17:51 -0500
Received: from amavis.mail (amavis2.rz.uni-wuerzburg.de [132.187.3.47])
	by wrzx35.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id BCF18E3EEF; Mon,  2 Jan 2006 01:17:48 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by amavis.mail (Postfix) with ESMTP id AFE092AB4;
	Mon,  2 Jan 2006 01:17:48 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by amavis.mail (Postfix) with ESMTP id 952D4715;
	Mon,  2 Jan 2006 01:17:48 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 6D2F4140124; Mon,  2 Jan 2006 01:17:48 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
X-Spam-Status: No, hits=0.0 tagged_above=0.0 required=8.0 tests=
X-Spam-Level: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14135>


---

	Without this, on my iBook git-whatchanged keeps running when I 
	quit "less". I have to interrupt the process a second time. No
	idea why it works on Linux.

 diff-tree.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

a3ff3aa99f1cc7d1e59563fbf22fed8a4f3f2d24
diff --git a/diff-tree.c b/diff-tree.c
index efa2b94..c06ccd3 100644
--- a/diff-tree.c
+++ b/diff-tree.c
@@ -25,8 +25,9 @@ static int call_diff_flush(void)
 		return 0;
 	}
 	if (header) {
-		if (!no_commit_id)
-			printf("%s%c", header, diff_options.line_termination);
+		if (!no_commit_id && printf("%s%c", header,
+				diff_options.line_termination) < 0)
+			die("broken output pipe");
 		header = NULL;
 	}
 	diff_flush(&diff_options);
-- 
1.0.GIT
