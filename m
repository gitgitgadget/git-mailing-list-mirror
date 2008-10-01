From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Make maximum surf time really per day
Date: Wed, 1 Oct 2008 22:41:30 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0810012239030.22125@pacific.mpi-cbg.de.mpi-cbg.de>
References: <alpine.LFD.2.00.0810011240390.3575@nehalem.linux-foundation.org> <alpine.DEB.1.00.0810012229390.22125@pacific.mpi-cbg.de.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Oct 01 22:36:37 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kl8Qw-0004IH-Uu
	for gcvg-git-2@gmane.org; Wed, 01 Oct 2008 22:36:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753951AbYJAUfQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Oct 2008 16:35:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753946AbYJAUfQ
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Oct 2008 16:35:16 -0400
Received: from mail.gmx.net ([213.165.64.20]:50873 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753938AbYJAUfP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Oct 2008 16:35:15 -0400
Received: (qmail invoked by alias); 01 Oct 2008 20:35:13 -0000
Received: from pacific.mpi-cbg.de (EHLO [141.5.10.38]) [141.5.10.38]
  by mail.gmx.net (mp053) with SMTP; 01 Oct 2008 22:35:13 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19ib+grlI9i6yYNPrPvXF0aM+zPiCw8l6V+BhD7hm
	/R35Z/kRYKrLZc
X-X-Sender: schindelin@pacific.mpi-cbg.de.mpi-cbg.de
In-Reply-To: <alpine.DEB.1.00.0810012229390.22125@pacific.mpi-cbg.de.mpi-cbg.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.52
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97265>


Earlier, when the maximum time was reached, we would block for 8 hours.
The program description suggested that the maximum time should be per
day instead, however.  So rather check that.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	I am sure your kids will hate me.  Now the trick to surf before 
	school, after school, and then late at night does not work 
	anymore.  :-(

	Well, the "late at night" would have interfered with next day's 
	"before school" anyway.

 tracker.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/tracker.c b/tracker.c
index 1b26e7e..faa4a91 100644
--- a/tracker.c
+++ b/tracker.c
@@ -12,6 +12,9 @@
 
 #define TRACKER_FILE "/var/log/tracker/%s"
 
+/* Define this, just in case it changes some day */
+#define SECS_PER_DAY 86400
+
 enum state {
 	no_user, old_user, new_user
 };
@@ -43,7 +46,7 @@ static void update_fd(struct user *user, int fd, unsigned int s)
 	cur += s;
 
 	/* Has the user been logged out more than 8 hours? */
-	if (user->last - last >= 8*60*60)
+	if (user->last / SECS_PER_DAY != last / SECS_PER_DAY)
 		cur = 0;
 
 	left = max - cur;
-- 
1.6.0.2.GIT
