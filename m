From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH] remote.c: use shorten_unambiguous_ref
Date: Thu,  9 Apr 2009 17:33:02 +0200
Message-ID: <1239291182-12860-1-git-send-email-git@drmicha.warpmail.net>
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 09 17:35:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LrwHb-0005UX-UF
	for gcvg-git-2@gmane.org; Thu, 09 Apr 2009 17:35:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757642AbZDIPdN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Apr 2009 11:33:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756594AbZDIPdM
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Apr 2009 11:33:12 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:41961 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755942AbZDIPdL (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Apr 2009 11:33:11 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 8D60A31549C;
	Thu,  9 Apr 2009 11:33:08 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Thu, 09 Apr 2009 11:33:08 -0400
X-Sasl-enc: wXda6gllV10ZyQcp2WB83uqMWyEB3QNva7Vl5xrWUZtC 1239291188
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id D585F23EA3;
	Thu,  9 Apr 2009 11:33:07 -0400 (EDT)
X-Mailer: git-send-email 1.6.2.2.646.gb214
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116174>

Use the new shorten_unambiguous_ref() for simplifying the output of
upstream branch names. This affects status and checkout.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
I intentionally didn't combine the line with the previous one (see
context) to make things a bit clearer.

I haven't seen more obvious place for using shorten_unambiguous_ref().
prettify_ref() is a natural candidate but is mostly used for
prettyfying refs on the remote side. git branch is covered by Jeff's
patch already.

 remote.c |    6 +-----
 1 files changed, 1 insertions(+), 5 deletions(-)

diff --git a/remote.c b/remote.c
index a06761a..10af722 100644
--- a/remote.c
+++ b/remote.c
@@ -1461,11 +1461,7 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb)
 		return 0;
 
 	base = branch->merge[0]->dst;
-	if (!prefixcmp(base, "refs/remotes/")) {
-		base += strlen("refs/remotes/");
-	} else if (!prefixcmp(base, "refs/heads/")) {
-		base += strlen("refs/heads/");
-	}
+	base = shorten_unambiguous_ref(base);
 	if (!num_theirs)
 		strbuf_addf(sb, "Your branch is ahead of '%s' "
 			    "by %d commit%s.\n",
-- 
1.6.2.2.646.gb214
