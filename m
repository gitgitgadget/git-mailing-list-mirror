From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] check_repository_format_version(): run git_default_config()
 again
Date: Mon, 6 Aug 2007 18:32:16 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708061831070.14781@racer.site>
References: <2BA49414-54E0-4353-B237-7799B675FAE8@silverinsanity.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>, gitster@pobox.com
To: Brian Gernhardt <benji@silverinsanity.com>
X-From: git-owner@vger.kernel.org Mon Aug 06 19:33:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1II6S9-00027D-OQ
	for gcvg-git@gmane.org; Mon, 06 Aug 2007 19:33:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754623AbXHFRc4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 6 Aug 2007 13:32:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752841AbXHFRcz
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Aug 2007 13:32:55 -0400
Received: from mail.gmx.net ([213.165.64.20]:56254 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751941AbXHFRcy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Aug 2007 13:32:54 -0400
Received: (qmail invoked by alias); 06 Aug 2007 17:32:53 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp034) with SMTP; 06 Aug 2007 19:32:53 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19fivZjqFtfXgHFrQy8zsST2teE7Yatr3RcGhIA/3
	SDq+qEyqKLS5Hz
X-X-Sender: gene099@racer.site
In-Reply-To: <2BA49414-54E0-4353-B237-7799B675FAE8@silverinsanity.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55161>


I broke this in "e90fdc39: Clean up work-tree handling".  It is
needed, for example for interpreting core.pager before starting the
pager.

Noticed by Brian Gernhardt.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	My first commit with git-gui!  Yeah!

	On Mon, 6 Aug 2007, Brian Gernhardt wrote:

	> I don't have time to look into it, but something broke the 
	> core.pager variable.  I've bisected it down to 
	> "e90fdc39b6903502192b2dd11e5503cea721a1ad: Clean up work-tree 
	> handling".

	Thanks.

 setup.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/setup.c b/setup.c
index 4945eb3..35fa031 100644
--- a/setup.c
+++ b/setup.c
@@ -355,7 +355,8 @@ int check_repository_format_version(const char *var, const char *value)
 			free(git_work_tree_cfg);
 		git_work_tree_cfg = xstrdup(value);
 		inside_work_tree = -1;
-	}
+	} else
+		return git_default_config(var, value);
 	return 0;
 }
 
-- 
1.5.3.rc4.17.gb980
