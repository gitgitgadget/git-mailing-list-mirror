From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH] git-svn: make git svn --version work again
Date: Thu,  4 Mar 2010 11:23:53 +0100
Message-ID: <fb196463677f8560aa490eaa137990ab2d5d6b86.1267698128.git.git@drmicha.warpmail.net>
Cc: Eric Wong <normalperson@yhbt.net>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 04 11:26:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nn8GF-0003ZU-2S
	for gcvg-git-2@lo.gmane.org; Thu, 04 Mar 2010 11:26:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754935Ab0CDK00 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Mar 2010 05:26:26 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:47987 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754559Ab0CDK0Z (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Mar 2010 05:26:25 -0500
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 351B6E2EFA;
	Thu,  4 Mar 2010 05:26:25 -0500 (EST)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Thu, 04 Mar 2010 05:26:25 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id; s=smtpout; bh=vrBhJAlXzsLUm6P27DjZIbsMkV0=; b=hKeimmpUHVhgvUrPITRz4Pusm/LVHw0Idd4w/KJmL3hbLUdGcVS8a5fLHItML/2TN2yW8l5JbPprKxuKMu1djov0b3FLYHM7UQSucB0tROruiTeYw7I6XRalxzz5n2ls3884xAsbeNZuMeM+Xf62w0GJFuJjSpRbHVl50pWhkWg=
X-Sasl-enc: kWaGAfE1a8fxHpt1nCPJazGwILObjRHMumeoPxexDHrK 1267698384
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 85FA24AEB97;
	Thu,  4 Mar 2010 05:26:24 -0500 (EST)
X-Mailer: git-send-email 1.7.0.1.300.gd855a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141521>

by requesting SVN::Core which is needed for the svn version.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
In fact, there are a few more places where seemingly a req_svn() is missing.
But the call chains are very confusing. The one seemingly missing in prop_walk()
would be covered by the recursive props test which succeeds, so the caller
must have requested SVN::Core also. I believe this applies to the other places
as well (but not to version()).

Is there any harm done by inserting a superfluous req_svn() in these cases for
good measure?

 git-svn.perl |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index bae7231..1ffb44c 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -351,6 +351,7 @@ information.
 }
 
 sub version {
+	::_req_svn();
 	print "git-svn version $VERSION (svn $SVN::Core::VERSION)\n";
 	exit 0;
 }
-- 
1.7.0.1.300.gd855a
