From: Junio C Hamano <junkio@cox.net>
Subject: [RFC/PATCH 1/2] git-push reports the URL after failing.
Date: Fri, 06 Apr 2007 23:04:55 -0700
Message-ID: <7vfy7cg1o8.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 07 08:05:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ha42l-0000JK-2r
	for gcvg-git@gmane.org; Sat, 07 Apr 2007 08:04:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752169AbXDGGE5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Apr 2007 02:04:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752191AbXDGGE5
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Apr 2007 02:04:57 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:35588 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752169AbXDGGE4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Apr 2007 02:04:56 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070407060455.WYQC1606.fed1rmmtao104.cox.net@fed1rmimpo01.cox.net>;
          Sat, 7 Apr 2007 02:04:55 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id k64v1W00A1kojtg0000000; Sat, 07 Apr 2007 02:04:56 -0400
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43962>

This came up on #git when somebody was getting 'unable to create
./objects/tmp_oXXXX' but sweared he had write permission to that
directory.  It turned out that the repository URL was changed
and he was accessing a repository he does not have a write
permission anymore.

I am not sure how much this would have helped somebody who
believed he was accessing location when the permission of that
location was changed while he was looking the other way, though.
But giving more information on the error path would be better,
and the next change would be helped with this as well.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 builtin-push.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/builtin-push.c b/builtin-push.c
index 70b1168..23143be 100644
--- a/builtin-push.c
+++ b/builtin-push.c
@@ -339,6 +339,8 @@ static int do_push(const char *repo)
 		err = run_command_v_opt(argv, RUN_GIT_CMD);
 		if (!err)
 			continue;
+
+		error("failed to push to '%s'", uri[i]);
 		switch (err) {
 		case -ERR_RUN_COMMAND_FORK:
 			die("unable to fork for %s", sender);
