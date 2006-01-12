From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH - maint review] show-branch: handle [] globs as well.
Date: Wed, 11 Jan 2006 16:04:56 -0800
Message-ID: <7v64oql39z.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Jan 12 01:05:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ewpy6-0002Bo-9i
	for gcvg-git@gmane.org; Thu, 12 Jan 2006 01:05:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964809AbWALAFA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Jan 2006 19:05:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751225AbWALAFA
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jan 2006 19:05:00 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:1683 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1751224AbWALAE5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jan 2006 19:04:57 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060112000229.SJAO17437.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 11 Jan 2006 19:02:29 -0500
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14530>

Earlier only '?' and '*' signalled the command that what the
user has given is a glob pattern.  This prevented us to say:

	$ git show-branch 'v0.99.[0-3]'

Now we notice '[' as well, so the above would work.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---
 * For 1.0.10 and 1.1.2

 show-branch.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

87758f975b04233ba058750f7ea8ce63bb67297f
diff --git a/show-branch.c b/show-branch.c
index 15b1968..1935c44 100644
--- a/show-branch.c
+++ b/show-branch.c
@@ -492,7 +492,7 @@ static void append_one_rev(const char *a
 		append_ref(av, revkey);
 		return;
 	}
-	if (strchr(av, '*') || strchr(av, '?')) {
+	if (strchr(av, '*') || strchr(av, '?') || strchr(av, '[')) {
 		/* glob style match */
 		int saved_matches = ref_name_cnt;
 		match_ref_pattern = av;
-- 
1.1.1-g8ecb
