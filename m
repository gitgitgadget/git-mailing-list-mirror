From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH - maint review] describe: do not silently ignore indescribable commits
Date: Wed, 11 Jan 2006 16:05:05 -0800
Message-ID: <7vu0cajopa.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Jan 12 01:05:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ewpy8-0002Bo-K0
	for gcvg-git@gmane.org; Thu, 12 Jan 2006 01:05:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751230AbWALAFK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Jan 2006 19:05:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751228AbWALAFK
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jan 2006 19:05:10 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:56729 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1751234AbWALAFH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jan 2006 19:05:07 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060112000233.SVEC20050.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 11 Jan 2006 19:02:33 -0500
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14528>

We silently ignored indescribable commits without complaining.
Complain and die instead.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---
 * For 1.1.2

 describe.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

8c23b6fae2e5cd8475885b015f0bb992d19921db
diff --git a/describe.c b/describe.c
index a0180f5..5548a16 100644
--- a/describe.c
+++ b/describe.c
@@ -124,10 +124,11 @@ static void describe(struct commit *cmit
 		if (n) {
 			printf("%s-g%s\n", n->path,
 			       find_unique_abbrev(cmit->object.sha1, abbrev));
-			break;
+			clear_commit_marks(cmit, SEEN);
+			return;
 		}
 	}
-	clear_commit_marks(cmit, SEEN);
+	die("cannot describe '%s'", sha1_to_hex(cmit->object.sha1));
 }
 
 int main(int argc, char **argv)
-- 
1.1.1-g8ecb
