From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 05/12] Do not expose internal scaling to diff-helper.
Date: Fri, 27 May 2005 15:53:31 -0700
Message-ID: <7vll6046xg.fsf_-_@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0505261731050.17207@ppc970.osdl.org>
	<7vsm091887.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505270848220.17402@ppc970.osdl.org>
	<7vk6lk5lxt.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat May 28 00:52:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dbnft-00024G-9u
	for gcvg-git@gmane.org; Sat, 28 May 2005 00:51:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262643AbVE0Wxi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 May 2005 18:53:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262645AbVE0Wxi
	(ORCPT <rfc822;git-outgoing>); Fri, 27 May 2005 18:53:38 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:43228 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S262643AbVE0Wxd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 May 2005 18:53:33 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050527225333.OUBY550.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 27 May 2005 18:53:33 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7vk6lk5lxt.fsf_-_@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Fri, 27 May 2005 15:43:58 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Instead we can normalize what diff-raw records at the diffcore
side.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

diff-helper.c |    2 --
diff.c        |    2 +-
2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/diff-helper.c b/diff-helper.c
--- a/diff-helper.c
+++ b/diff-helper.c
@@ -4,7 +4,6 @@
 #include "cache.h"
 #include "strbuf.h"
 #include "diff.h"
-#include "diffcore.h" /* just for MAX_SCORE */
 
 static const char *pickaxe = NULL;
 static int line_termination = '\n';
@@ -78,7 +77,6 @@ int main(int ac, const char **av) {
 			if (status == 'R' || status == 'C') {
 				two_paths = 1;
 				sscanf(cp, "%d", &score);
-				score = score * MAX_SCORE / 100;
 				if (line_termination) {
 					cp = strchr(cp,
 						    inter_name_termination);
diff --git a/diff.c b/diff.c
--- a/diff.c
+++ b/diff.c
@@ -886,7 +886,7 @@ void diff_helper_input(unsigned old_mode
 	if (new_mode)
 		fill_filespec(two, new_sha1, new_mode);
 	dp = diff_queue(&diff_queued_diff, one, two);
-	dp->score = score;
+	dp->score = score * MAX_SCORE / 100;
 	dp->status = status;
 }
 
------------------------------------------------

