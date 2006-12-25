From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] git-add: warn when adding an ignored file with an explicit request.
Date: Mon, 25 Dec 2006 10:39:51 -0800
Message-ID: <7vodprizuw.fsf_-_@assigned-by-dhcp.cox.net>
References: <7vbqlskz2u.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0612251443230.19693@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vslf3khsc.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 25 19:40:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GyukW-00021f-K4
	for gcvg-git@gmane.org; Mon, 25 Dec 2006 19:40:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752633AbWLYSjx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Dec 2006 13:39:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752647AbWLYSjx
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Dec 2006 13:39:53 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:39562 "EHLO
	fed1rmmtao07.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752633AbWLYSjx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Dec 2006 13:39:53 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20061225183952.XWTH3976.fed1rmmtao07.cox.net@fed1rmimpo01.cox.net>;
          Mon, 25 Dec 2006 13:39:52 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 36f81W00F1kojtg0000000; Mon, 25 Dec 2006 13:39:09 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <7vslf3khsc.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Mon, 25 Dec 2006 09:27:15 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35393>

We allow otherwise ignored paths to be added to the index by
spelling its path out on the command line, but we would warn the
user about them when we do so.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 * This is on top of what I sent out last night.

 builtin-add.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/builtin-add.c b/builtin-add.c
index 822075a..c54c694 100644
--- a/builtin-add.c
+++ b/builtin-add.c
@@ -37,6 +37,9 @@ static void prune_directory(struct dir_struct *dir, const char **pathspec, int p
 			free(entry);
 			continue;
 		}
+		if (entry->ignored_entry)
+			fprintf(stderr, "warning: '%s' is an ignored path.\n",
+				entry->name);
 		*dst++ = entry;
 	}
 	dir->nr = dst - dir->entries;
-- 
1.4.4.3.g71b5
