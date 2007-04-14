From: Michael Spang <mspang@uwaterloo.ca>
Subject: [PATCH] git-blame: Fix overrun in fake_working_tree_commit()
Date: Sat, 14 Apr 2007 17:26:20 -0400
Message-ID: <462146FC.9060202@uwaterloo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 14 23:50:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hcq89-0001QE-8P
	for gcvg-git@gmane.org; Sat, 14 Apr 2007 23:50:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750940AbXDNVtv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 Apr 2007 17:49:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752759AbXDNVtv
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Apr 2007 17:49:51 -0400
Received: from services10.student.cs.uwaterloo.ca ([129.97.152.18]:42362 "EHLO
	services10.student.cs.uwaterloo.ca" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750940AbXDNVtu (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 14 Apr 2007 17:49:50 -0400
X-Greylist: delayed 1399 seconds by postgrey-1.27 at vger.kernel.org; Sat, 14 Apr 2007 17:49:50 EDT
Received: from [192.168.0.11] (CPE00045a842fd6-CM000a73a11526.cpe.net.cable.rogers.com [74.108.158.132])
	(authenticated bits=0)
	by services10.student.cs.uwaterloo.ca (8.13.8/8.13.8) with ESMTP id l3ELQNwU013064
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 14 Apr 2007 17:26:24 -0400 (EDT)
User-Agent: Icedove 1.5.0.10 (X11/20070329)
X-Greylist: Sender succeeded SMTP AUTH authentication, not delayed by milter-greylist-2.0 (services10.student.cs.uwaterloo.ca [129.97.152.13]); Sat, 14 Apr 2007 17:26:28 -0400 (EDT)
X-Miltered: at minos with ID 462146FF.000 by Joe's j-chkmail (http://j-chkmail.ensmp.fr)!
X-UUID: d7e15527-d6fc-4eb1-834a-738617850b54
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44470>

git-blame would overflow commit->buffer when annotating files with long paths.

Signed-off-by: Michael Spang <mspang@uwaterloo.ca>
---
 builtin-blame.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin-blame.c b/builtin-blame.c
index 60ec535..bc86bda 100644
--- a/builtin-blame.c
+++ b/builtin-blame.c
@@ -2041,7 +2041,7 @@ static struct commit *fake_working_tree_commit(const char *path, const char *con
 
 	commit->buffer = xmalloc(400);
 	ident = fmt_ident("Not Committed Yet", "not.committed.yet", NULL, 0);
-	sprintf(commit->buffer,
+	snprintf(commit->buffer, 400,
 		"tree 0000000000000000000000000000000000000000\n"
 		"parent %s\n"
 		"author %s\n"
