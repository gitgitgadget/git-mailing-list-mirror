From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Teach the revision walker to walk by reflogs with
 --walk-reflogs
Date: Thu, 11 Jan 2007 11:57:13 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701111156510.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0701111147070.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Thu Jan 11 11:57:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4xci-0002xq-Kn
	for gcvg-git@gmane.org; Thu, 11 Jan 2007 11:57:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030265AbXAKK5S (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 11 Jan 2007 05:57:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030271AbXAKK5S
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Jan 2007 05:57:18 -0500
Received: from mail.gmx.net ([213.165.64.20]:45128 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1030265AbXAKK5P (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jan 2007 05:57:15 -0500
Received: (qmail invoked by alias); 11 Jan 2007 10:57:13 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp047) with SMTP; 11 Jan 2007 11:57:13 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
In-Reply-To: <Pine.LNX.4.63.0701111147070.22628@wbgn013.biozentrum.uni-wuerzburg.de>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36581>

... and an --amend:

---

 reflog-walk.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/reflog-walk.c b/reflog-walk.c
index 658cba9..d4b49c7 100644
--- a/reflog-walk.c
+++ b/reflog-walk.c
@@ -203,14 +203,16 @@ void fake_reflog_parent(struct reflog_walk_info *info, struct commit *commit)
 
 	reflog = &commit_reflog->reflogs->items[commit_reflog->recno];
 	info->last_commit_reflog = commit_reflog;
+	commit_reflog->recno--;
 	commit_info->commit = (struct commit *)parse_object(reflog->osha1);
-	if (!commit_info->commit)
+	if (!commit_info->commit) {
+		commit->parents = NULL;
 		return;
+	}
 
 	commit->parents = xcalloc(sizeof(struct commit_list), 1);
 	commit->parents->item = commit_info->commit;
 	commit->object.flags &= ~(ADDED | SEEN | SHOWN);
-	commit_reflog->recno--;
 }
 
 void show_reflog_message(struct reflog_walk_info* info)
