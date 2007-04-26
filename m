From: koreth@midwinter.com
Subject: [PATCH] Use PATH_MAX rather than a hardwired constant maximum length.
Date: Thu, 26 Apr 2007 02:12:54 -0700
Message-ID: <20070426091254.GA23586@midwinter.com>
References: <20070425232829.GA15930@midwinter.com> <81b0412b0704260120mda8a2abhe343f5c127945939@mail.gmail.com> <46306A29.4010608@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 26 11:13:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hh029-0002TA-F5
	for gcvg-git@gmane.org; Thu, 26 Apr 2007 11:13:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933741AbXDZJM4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 Apr 2007 05:12:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933751AbXDZJM4
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Apr 2007 05:12:56 -0400
Received: from tater.midwinter.com ([216.32.86.90]:54345 "HELO midwinter.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932332AbXDZJMz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Apr 2007 05:12:55 -0400
Received: (qmail 23773 invoked by uid 1001); 26 Apr 2007 09:12:54 -0000
Content-Disposition: inline
In-Reply-To: <46306A29.4010608@midwinter.com>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45626>

Signed-off-by: Steven Grimm <koreth@midwinter.com>
---

Is the +1 really needed? The existing code is doing this in other places
but I'm not sure it's necessary since we're also doing sizeof(buffer)-1
in the getcwd() call. I figured it was best to be consistent with the
existing code, e.g. setup_git_directory_gently().

 setup.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/setup.c b/setup.c
index a45ea83..84d3c4a 100644
--- a/setup.c
+++ b/setup.c
@@ -175,11 +175,11 @@ static int inside_git_dir = -1;
 int is_inside_git_dir(void)
 {
 	if (inside_git_dir < 0) {
-		char buffer[1024];
+		char buffer[PATH_MAX+1];
 
 		if (is_bare_repository())
 			return (inside_git_dir = 1);
-		if (getcwd(buffer, sizeof(buffer))) {
+		if (getcwd(buffer, sizeof(buffer)-1)) {
 			const char *git_dir = get_git_dir(), *cwd = buffer;
 			while (*git_dir && *git_dir == *cwd) {
 				git_dir++;
-- 
1.5.2.rc0.35.gf41c8
