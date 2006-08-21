From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] daemon: add upload-tar service.
Date: Sun, 20 Aug 2006 19:09:33 -0700
Message-ID: <7vsljqx2jm.fsf@assigned-by-dhcp.cox.net>
References: <7vpseyelcw.fsf@assigned-by-dhcp.cox.net>
	<1155923876.10054.205.camel@cashmere.sps.mot.com>
	<7vy7tjxdas.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Aug 21 04:09:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GEzEf-0003Cx-GK
	for gcvg-git@gmane.org; Mon, 21 Aug 2006 04:09:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751808AbWHUCJf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 Aug 2006 22:09:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751807AbWHUCJf
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Aug 2006 22:09:35 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:18603 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1751804AbWHUCJe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Aug 2006 22:09:34 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060821020933.UIIE18458.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 20 Aug 2006 22:09:33 -0400
To: git@vger.kernel.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25776>

This allows clients to ask for tarballs with:

	git tar-tree --remote=git://server/repo refname

By default, the upload-tar service is not enabled.  To enable
it server-wide, the server can be started with:

	git-daemon --enable=upload-tar

This service is by default overridable per repostiory, so
alternatively, a repository can define "daemon.uploadtar = true"
to enable it.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 daemon.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/daemon.c b/daemon.c
index 0a6cbb4..5549014 100644
--- a/daemon.c
+++ b/daemon.c
@@ -321,8 +321,15 @@ static int upload_pack(void)
 	return -1;
 }
 
+static int upload_tar(void)
+{
+	execl_git_cmd("upload-tar", ".", NULL);
+	return -1;
+}
+
 static struct daemon_service daemon_service[] = {
 	{ "upload-pack", "uploadpack", upload_pack, 1, 1 },
+	{ "upload-tar", "uploadtar", upload_tar, 0, 1 },
 };
 
 static void enable_service(const char *name, int ena) {
-- 
1.4.2.g0cac8
