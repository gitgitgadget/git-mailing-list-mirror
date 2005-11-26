From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 2/4] Check repository format version in enter_repo().
Date: Fri, 25 Nov 2005 17:15:11 -0800
Message-ID: <7vd5kogqg0.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Nov 26 02:15:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Efoez-0004aa-4I
	for gcvg-git@gmane.org; Sat, 26 Nov 2005 02:15:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932379AbVKZBPO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 25 Nov 2005 20:15:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932418AbVKZBPO
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Nov 2005 20:15:14 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:12164 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S932379AbVKZBPN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Nov 2005 20:15:13 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051126011403.WAAT26964.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 25 Nov 2005 20:14:03 -0500
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12757>

After daemon, upload-pack and receive-pack find out where the
git directory is and chdir() there, make sure that repository is
in a format we understand, after putenv("GIT_DIR=.") so that it
knows to pick up the configuration file from there.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 path.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

applies-to: 936ce54dedc7c7cfcf8f83a742325b3329eb95a1
ed2f604235d7f400ee5fa01a591158cdabd65197
diff --git a/path.c b/path.c
index 4d88947..2c077c0 100644
--- a/path.c
+++ b/path.c
@@ -199,6 +199,7 @@ char *enter_repo(char *path, int strict)
 	if(access("objects", X_OK) == 0 && access("refs", X_OK) == 0 &&
 	   validate_symref("HEAD") == 0) {
 		putenv("GIT_DIR=.");
+		check_repository_format();
 		return current_dir();
 	}
 
---
0.99.9.GIT
