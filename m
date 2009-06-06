From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH] builtin-remote: Make "remote show" display all urls
Date: Sat,  6 Jun 2009 17:16:30 +0200
Message-ID: <1244301390-27295-1-git-send-email-git@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 06 17:16:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCxdT-00048A-Ud
	for gcvg-git-2@gmane.org; Sat, 06 Jun 2009 17:16:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753431AbZFFPQf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Jun 2009 11:16:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753240AbZFFPQe
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Jun 2009 11:16:34 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:47626 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752835AbZFFPQd (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 6 Jun 2009 11:16:33 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by out1.messagingengine.com (Postfix) with ESMTP id AF18D357287;
	Sat,  6 Jun 2009 11:16:35 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Sat, 06 Jun 2009 11:16:35 -0400
X-Sasl-enc: uZBcUZmmmeConRN8/Ozuon+2MZwuSOMshhGzFOsjfk/h 1244301395
Received: from localhost (p548596E3.dip0.t-ipconnect.de [84.133.150.227])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 04DB62E241;
	Sat,  6 Jun 2009 11:16:34 -0400 (EDT)
X-Mailer: git-send-email 1.6.3.2.277.gd10543
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120924>

Currently, "git remote -v" lists all urls whereas "git remote show
$remote" shows only the first. Make it so that both show all.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
While looking around what I need to change in builtin-remote.c for the pushurls
I noticed the above asymmetric behaviour. While I'm not sure what multiple urls
are good for (as far as fetches are concerned) I think we should still show them
(they may all be used for push).

This is on top of maint.

 builtin-remote.c |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/builtin-remote.c b/builtin-remote.c
index fda9a54..d436412 100644
--- a/builtin-remote.c
+++ b/builtin-remote.c
@@ -1003,9 +1003,12 @@ static int show(int argc, const char **argv)
 
 		get_remote_ref_states(*argv, &states, query_flag);
 
-		printf("* remote %s\n  URL: %s\n", *argv,
-			states.remote->url_nr > 0 ?
-				states.remote->url[0] : "(no URL)");
+		printf("* remote %s\n", *argv);
+		if (states.remote->url_nr) {
+			for (i=0; i < states.remote->url_nr; i++)
+				printf("  URL: %s\n", states.remote->url[i]);
+		} else
+			printf("  URL: %s\n", "(no URL)");
 		if (no_query)
 			printf("  HEAD branch: (not queried)\n");
 		else if (!states.heads.nr)
-- 
1.6.3.2.277.gd10543
