From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/2] mailmap: fix bogus for() loop that happened to be safe by accident
Date: Fri,  7 Dec 2007 17:32:52 -0800
Message-ID: <1197077573-14945-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 08 02:33:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0oZ9-0000Hp-UN
	for gcvg-git-2@gmane.org; Sat, 08 Dec 2007 02:33:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754132AbXLHBcz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Dec 2007 20:32:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754113AbXLHBcz
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Dec 2007 20:32:55 -0500
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:60318 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754079AbXLHBcz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Dec 2007 20:32:55 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20071208013254.RRIG16731.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Fri, 7 Dec 2007 20:32:54 -0500
Received: from localhost ([68.225.240.77])
	by fed1rmimpo02.cox.net with bizsmtp
	id N1Yu1Y00K1gtr5g0000000; Fri, 07 Dec 2007 20:32:54 -0500
X-Mailer: git-send-email 1.5.3.7-2182-g108b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67492>

The empty loop pretended to have an empty statement as its body by a
phony indentation, but in fact was slurping the next statement into it.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 mailmap.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/mailmap.c b/mailmap.c
index 8714167..f017255 100644
--- a/mailmap.c
+++ b/mailmap.c
@@ -42,9 +42,10 @@ int read_mailmap(struct path_list *map, const char *filename, char **repo_abbrev
 			continue;
 		if (right_bracket == left_bracket + 1)
 			continue;
-		for (end_of_name = left_bracket; end_of_name != buffer
-				&& isspace(end_of_name[-1]); end_of_name--)
-			/* keep on looking */
+		for (end_of_name = left_bracket;
+		     end_of_name != buffer && isspace(end_of_name[-1]);
+		     end_of_name--)
+			; /* keep on looking */
 		if (end_of_name == buffer)
 			continue;
 		name = xmalloc(end_of_name - buffer + 1);
-- 
1.5.3.7-2182-g108b
