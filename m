From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 5/3], was Re: [PATCH 4/3] provide a nice @{...} syntax to
 always mean the current branch reflog
Date: Fri, 2 Feb 2007 00:07:24 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702020006220.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.64.0702011231300.3021@xanadu.home>
 <20070201191323.GA18608@spearce.org> <7vmz3xoas9.fsf@assigned-by-dhcp.cox.net>
 <45C25BA6.1000301@fs.ei.tum.de> <Pine.LNX.4.64.0702011710120.3021@xanadu.home>
 <20070201221758.GA15213@moooo.ath.cx> <Pine.LNX.4.64.0702011725150.3021@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	Matthias Lederhofer <matled@gmx.net>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Fri Feb 02 00:07:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCl1e-0005tb-Ea
	for gcvg-git@gmane.org; Fri, 02 Feb 2007 00:07:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932998AbXBAXH1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Feb 2007 18:07:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933149AbXBAXH1
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Feb 2007 18:07:27 -0500
Received: from mail.gmx.net ([213.165.64.20]:52952 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933141AbXBAXH0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Feb 2007 18:07:26 -0500
Received: (qmail invoked by alias); 01 Feb 2007 23:07:25 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp033) with SMTP; 02 Feb 2007 00:07:25 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <Pine.LNX.4.64.0702011725150.3021@xanadu.home>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38424>

Also bring the '@{...}' notation to git-log -g

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

 reflog-walk.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/reflog-walk.c b/reflog-walk.c
index 8262160..653ec95 100644
--- a/reflog-walk.c
+++ b/reflog-walk.c
@@ -165,6 +165,14 @@ void add_reflog_for_walk(struct reflog_walk_info *info,
 	if (item)
 		reflogs = item->util;
 	else {
+		if (*branch == '\0') {
+			unsigned char sha1[20];
+			const char *head = resolve_ref("HEAD", sha1, 0, NULL);
+			if (!head)
+				die ("No current branch");
+			free(branch);
+			branch = xstrdup(head);
+		}
 		reflogs = read_complete_reflog(branch);
 		if (!reflogs || reflogs->nr == 0)
 			die("No reflogs found for '%s'", branch);
