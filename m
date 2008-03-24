From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] init: show "Reinit" message even in an (existing) empty
 repository
Date: Mon, 24 Mar 2008 16:14:52 +0100 (CET)
Message-ID: <alpine.LSU.1.00.0803241613480.4353@racer.site>
References: <alpine.LSU.1.00.0803230310500.4353@racer.site> <alpine.OSX.1.00.0803230943500.7541@cougar> <alpine.LSU.1.00.0803231200010.4353@racer.site> <alpine.OSX.1.00.0803231326290.11994@cougar> <alpine.LSU.1.00.0803231404390.4353@racer.site>
 <alpine.OSX.1.00.0803231428220.13789@cougar> <20080323235610.GB25381@dpotapov.dyndns.org> <alpine.LSU.1.00.0803240101220.4353@racer.site> <20080324002302.GD25381@dpotapov.dyndns.org> <alpine.LSU.1.00.0803241155300.4353@racer.site> <20080324122153.GF25381@dpotapov.dyndns.org>
 <alpine.LSU.1.00.0803241611200.4353@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junio@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 24 16:15:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdoOf-00065U-M9
	for gcvg-git-2@gmane.org; Mon, 24 Mar 2008 16:15:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760914AbYCXPOu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Mar 2008 11:14:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760340AbYCXPOt
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Mar 2008 11:14:49 -0400
Received: from mail.gmx.net ([213.165.64.20]:51542 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1760914AbYCXPOt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Mar 2008 11:14:49 -0400
Received: (qmail invoked by alias); 24 Mar 2008 15:14:47 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp058) with SMTP; 24 Mar 2008 16:14:47 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18lau8Hsl0llgyZyByGJI93QqbRwWUnIh6l8S/bVW
	6V4TjyRfhybBwV
X-X-Sender: gene099@racer.site
In-Reply-To: <alpine.LSU.1.00.0803241611200.4353@racer.site>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78052>


Earlier, git-init tested for a valid HEAD ref, but if the repository
was empty, there was none.  Instead, test for the existence of
the file $GIT_DIR/HEAD.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	I realised this while testing the core.initHook patch.

 builtin-init-db.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/builtin-init-db.c b/builtin-init-db.c
index 1975910..ceb4727 100644
--- a/builtin-init-db.c
+++ b/builtin-init-db.c
@@ -168,10 +168,9 @@ static int create_default_files(const char *git_dir, const char *template_path)
 {
 	unsigned len = strlen(git_dir);
 	static char path[PATH_MAX];
-	unsigned char sha1[20];
 	struct stat st1;
 	char repo_version_string[10];
	int reinit;
 	int filemode;
 
 	if (len > sizeof(path)-50)
@@ -220,7 +219,7 @@ static int create_default_files(const char *git_dir, const char *template_path)
 	 * branch, if it does not exist yet.
 	 */
 	strcpy(path + len, "HEAD");
-	reinit = !read_ref("HEAD", sha1);
+	reinit = !access(path, R_OK);
 	if (!reinit) {
 		if (create_symref("HEAD", "refs/heads/master", NULL) < 0)
 			exit(1);
-- 
1.5.5.rc1.178.gd799d
