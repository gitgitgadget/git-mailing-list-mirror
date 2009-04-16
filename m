From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv2] remote.c: use shorten_unambiguous_ref
Date: Thu, 16 Apr 2009 10:20:44 +0200
Message-ID: <1239870044-7990-1-git-send-email-git@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 16 10:22:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LuMrb-0002pW-RG
	for gcvg-git-2@gmane.org; Thu, 16 Apr 2009 10:22:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751383AbZDPIU4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Apr 2009 04:20:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751255AbZDPIUy
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Apr 2009 04:20:54 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:38000 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751169AbZDPIUx (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 16 Apr 2009 04:20:53 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 75F7631DF18;
	Thu, 16 Apr 2009 04:20:51 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Thu, 16 Apr 2009 04:20:51 -0400
X-Sasl-enc: TS65mCw0axglMpocWGCL8yD2FrFuPCjybJq5idihTc5G 1239870050
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id DD92A3C0B6;
	Thu, 16 Apr 2009 04:20:50 -0400 (EDT)
X-Mailer: git-send-email 1.6.2.2.646.gb214
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116684>

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

v2 rebases onto current next containing Bert's patch which changes the
signature of shorten_unambiguous_ref().

I take it that applying that patch to next means an end to the
discussion about changing the signature ;)

 remote.c |    6 +-----
 1 files changed, 1 insertions(+), 5 deletions(-)

diff --git a/remote.c b/remote.c
index a06761a..54230ad 100644
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
+	base = shorten_unambiguous_ref(base, 0);
 	if (!num_theirs)
 		strbuf_addf(sb, "Your branch is ahead of '%s' "
 			    "by %d commit%s.\n",
-- 
1.6.3.rc0.201.gcd60.dirty
