From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] get_relative_cwd(): clarify why it handles dir == NULL
Date: Wed, 1 Aug 2007 19:26:59 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708011926200.14781@racer.site>
References: <Pine.LNX.4.64.0707300016470.14781@racer.site>
 <Pine.LNX.4.64.0708010058130.14781@racer.site> <Pine.LNX.4.64.0708010129090.14781@racer.site>
 <7vy7gvdgtn.fsf@assigned-by-dhcp.cox.net> <7vwswfbywq.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0708011624260.14781@racer.site> <7vmyxb5h0g.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, matled@gmx.net
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 01 20:28:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGIvc-0002Ec-6p
	for gcvg-git@gmane.org; Wed, 01 Aug 2007 20:28:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756175AbXHAS12 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Aug 2007 14:27:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753374AbXHAS12
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Aug 2007 14:27:28 -0400
Received: from mail.gmx.net ([213.165.64.20]:36657 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753414AbXHAS11 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Aug 2007 14:27:27 -0400
Received: (qmail invoked by alias); 01 Aug 2007 18:27:23 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp039) with SMTP; 01 Aug 2007 20:27:23 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18ML1d1Jq4Mz2GxTPHlzlzUTQozseRwnntdCpxULN
	lJbvxNYjmpwUdi
X-X-Sender: gene099@racer.site
In-Reply-To: <7vmyxb5h0g.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54462>


The comment did not make a good case why it makes sense.  It does so now.

Pointed out by Junio Hamano.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 dir.c |   11 ++++++++++-
 1 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/dir.c b/dir.c
index b3329f4..791c566 100644
--- a/dir.c
+++ b/dir.c
@@ -646,7 +646,16 @@ file_exists(const char *f)
 /*
  * get_relative_cwd() gets the prefix of the current working directory
  * relative to 'dir'.  If we are not inside 'dir', it returns NULL.
- * As a convenience, it also returns NULL if 'dir' is already NULL.
+ *
+ * As a convenience, it also returns NULL if 'dir' is already NULL.  The
+ * reason for this behaviour is that it is natural for functions returning
+ * directory names to return NULL to say "this directory does not exist"
+ * or "this directory is invalid".  These cases are usually handled the
+ * same as if the cwd is not inside 'dir' at all, so get_relative_cwd()
+ * returns NULL for both of them.
+ *
+ * Most notably, get_relative_cwd(buffer, size, get_git_work_tree())
+ * unifies the handling of "outside work tree" with "no work tree at all".
  */
 char *get_relative_cwd(char *buffer, int size, const char *dir)
 {
-- 
1.5.3.rc3.112.gf60b6
