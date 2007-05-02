From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: [PATCH] cvsserver: Handle re-added files correctly
Date: Wed,  2 May 2007 02:43:14 +0200
Message-ID: <1178066594239-git-send-email-frank@lichtenheld.de>
Cc: Junio C Hamano <junkio@cox.net>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Frank Lichtenheld <frank@lichtenheld.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 02 02:43:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hj2wB-0008M5-U2
	for gcvg-git@gmane.org; Wed, 02 May 2007 02:43:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992553AbXEBAnR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 May 2007 20:43:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992578AbXEBAnR
	(ORCPT <rfc822;git-outgoing>); Tue, 1 May 2007 20:43:17 -0400
Received: from mail.lenk.info ([217.160.134.107]:1220 "EHLO mail.lenk.info"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S2992553AbXEBAnQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 May 2007 20:43:16 -0400
Received: from herkules.lenk.info
	([213.239.194.154] helo=smtp.lenk.info ident=Debian-exim)
	by mail.lenk.info with esmtpsa 
	(Cipher TLS-1.0:RSA_AES_256_CBC_SHA1:32) (Exim 4.63 1)
	id 1Hj2vH-00067P-Ma; Wed, 02 May 2007 02:42:23 +0200
Received: from p54b0f026.dip.t-dialin.net ([84.176.240.38] helo=dirac.djpig.de)
	by smtp.lenk.info with esmtpsa 
	(Cipher TLS-1.0:RSA_AES_256_CBC_SHA:32) (Exim 4.63 1)
	id 1Hj2w5-0008E2-7a; Wed, 02 May 2007 02:43:13 +0200
Received: from djpig by dirac.djpig.de with local (Exim 4.67)
	(envelope-from <frank@lichtenheld.de>)
	id 1Hj2w6-0005Z9-9s; Wed, 02 May 2007 02:43:14 +0200
X-Mailer: git-send-email 1.5.1.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45999>

We can't unconditionally assign revision 1.1 to
newly added files. In case the file did exist in the
past and was deleted we need to honor the old
revision number.

Signed-off-by: Frank Lichtenheld <frank@lichtenheld.de>
---
 git-cvsserver.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

 Found due to working on the test cases.

diff --git a/git-cvsserver.perl b/git-cvsserver.perl
index 087e3ab..3e7bf5b 100755
--- a/git-cvsserver.perl
+++ b/git-cvsserver.perl
@@ -2519,7 +2519,7 @@ sub update
                     #$log->debug("ADDED    $name");
                     $head->{$name} = {
                         name => $name,
-                        revision => 1,
+                        revision => $head->{$name}{revision} ? $head->{$name}{revision}+1 : 1,
                         filehash => $hash,
                         commithash => $commit->{hash},
                         modified => $commit->{date},
-- 
1.5.1.2
