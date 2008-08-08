From: Andrew Wason <rectalogic@rectalogic.com>
Subject: [PATCH] Reinstate SIGCHILD handler, signals on Solaris are reset when handled
Date: Fri, 8 Aug 2008 17:43:55 +0000 (UTC)
Message-ID: <loom.20080808T174216-369@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 08 19:56:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KRWCC-0006ET-My
	for gcvg-git-2@gmane.org; Fri, 08 Aug 2008 19:56:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752912AbYHHRzL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Aug 2008 13:55:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752703AbYHHRzK
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Aug 2008 13:55:10 -0400
Received: from main.gmane.org ([80.91.229.2]:51363 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752166AbYHHRzJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Aug 2008 13:55:09 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1KRWB5-0004j7-3O
	for git@vger.kernel.org; Fri, 08 Aug 2008 17:55:03 +0000
Received: from 63.251.25.201 ([63.251.25.201])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 08 Aug 2008 17:55:03 +0000
Received: from rectalogic by 63.251.25.201 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 08 Aug 2008 17:55:03 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 63.251.25.201 (Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.5; en-US; rv:1.9.0.1) Gecko/2008070206 Firefox/3.0.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91701>

git-daemon only reaps the first forked child on Solaris. Solaris signal handlers
have to be reset each time the signal is handled.


Signed-off-by: Andrew Wason <rectalogic@rectalogic.com>
---
 daemon.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/daemon.c b/daemon.c
index 4540e8d..47ad8ab 100644
--- a/daemon.c
+++ b/daemon.c
@@ -794,6 +794,8 @@ static void child_handler(int signo)
 		}
 		break;
 	}
+	/* Signal handlers must be reinstated on Solaris */
+	signal(SIGCHLD, child_handler);
 }
 
 static int set_reuse_addr(int sockfd)
-- 
1.5.6.2
