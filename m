From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 1/2] git-log (internal): add approxidate.
Date: Wed, 01 Mar 2006 04:24:26 -0800
Message-ID: <7vhd6igxol.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0602281115110.22647@g5.osdl.org>
	<Pine.LNX.4.64.0602281126340.22647@g5.osdl.org>
	<Pine.LNX.4.64.0602281251390.22647@g5.osdl.org>
	<7vr75nm8cl.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0602281504280.22647@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 01 13:24:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FEQNk-0003CS-Ct
	for gcvg-git@gmane.org; Wed, 01 Mar 2006 13:24:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932274AbWCAMYd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Mar 2006 07:24:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932275AbWCAMYd
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Mar 2006 07:24:33 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:6050 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S932206AbWCAMYd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Mar 2006 07:24:33 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060301122052.MKPH17437.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 1 Mar 2006 07:20:52 -0500
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16973>

Next will be the pretty-print format.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---
  Linus Torvalds <torvalds@osdl.org> writes:

  > I didn't add the logic for --before/--after flags, but that should be 
  > pretty trivial, and is independent of this anyway.
  >
  > Perhaps more importantly, I didn't remove the tests that now start 
  > failing, nor did I remove the actual code to do --merge-order ;/

  I've done the janitorial, and have two more on top.  Here is the
  first one.  I'd appreciate comments on the second one.

 revision.c |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+), 0 deletions(-)

2eba658eaffdf4c5c9d0767b49e4c27d7281cda6
diff --git a/revision.c b/revision.c
index c84f146..4885871 100644
--- a/revision.c
+++ b/revision.c
@@ -492,6 +492,26 @@ int setup_revisions(int argc, const char
 				revs->limited = 1;
 				continue;
 			}
+			if (!strncmp(arg, "--since=", 8)) {
+				revs->max_age = approxidate(arg + 8);
+				revs->limited = 1;
+				continue;
+			}
+			if (!strncmp(arg, "--after=", 8)) {
+				revs->max_age = approxidate(arg + 8);
+				revs->limited = 1;
+				continue;
+			}
+			if (!strncmp(arg, "--before=", 9)) {
+				revs->min_age = approxidate(arg + 9);
+				revs->limited = 1;
+				continue;
+			}
+			if (!strncmp(arg, "--until=", 8)) {
+				revs->min_age = approxidate(arg + 8);
+				revs->limited = 1;
+				continue;
+			}
 			if (!strcmp(arg, "--all")) {
 				handle_all(revs, flags);
 				continue;
-- 
1.2.3.g9425
