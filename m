From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: [PATCH] cvsserver: Fix handling of diappeared files on update
Date: Wed, 11 Apr 2007 22:38:19 +0200
Message-ID: <11763238991005-git-send-email-frank@lichtenheld.de>
References: <Pine.LNX.4.64.0704111158220.27922@iabervon.org>
Cc: Martin Langhoff <martin@catalyst.net.nz>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Junio C Hamano <junkio@cox.net>,
	Frank Lichtenheld <frank@lichtenheld.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 11 22:39:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HbjbI-0001cZ-5k
	for gcvg-git@gmane.org; Wed, 11 Apr 2007 22:39:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030503AbXDKUj2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Apr 2007 16:39:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030608AbXDKUj2
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Apr 2007 16:39:28 -0400
Received: from mail.lenk.info ([217.160.134.107]:2269 "EHLO mail.lenk.info"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030503AbXDKUj2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2007 16:39:28 -0400
Received: from herkules.lenk.info
	([213.239.194.154] helo=smtp.lenk.info ident=Debian-exim)
	by mail.lenk.info with esmtpsa 
	(Cipher TLS-1.0:RSA_AES_256_CBC_SHA1:32) (Exim 4.63 1)
	id 1Hbjb6-0001sv-CQ; Wed, 11 Apr 2007 22:39:20 +0200
Received: from p54b0c83b.dip.t-dialin.net ([84.176.200.59] helo=goedel.djpig.de)
	by smtp.lenk.info with esmtpsa 
	(Cipher TLS-1.0:RSA_AES_256_CBC_SHA:32) (Exim 4.63 1)
	id 1HbjbA-0003xk-NF; Wed, 11 Apr 2007 22:39:24 +0200
Received: from djpig by goedel.djpig.de with local (Exim 4.63)
	(envelope-from <frank@lichtenheld.de>)
	id 1Hbja7-0003GI-6X; Wed, 11 Apr 2007 22:38:19 +0200
X-Mailer: git-send-email 1.5.1
In-Reply-To: <Pine.LNX.4.64.0704111158220.27922@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44254>

Only send a modified response if the client sent a
"Modified" entry. This fixes the case where the
file was locally deleted on the client without
being removed from CVS. In this case the client
will only have sent the Entry for the file but nothing
else.

Signed-off-by: Frank Lichtenheld <frank@lichtenheld.de>
---
 git-cvsserver.perl |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

 We really, really need a test suite for cvsserver...
 I've tested this as good for regressions as I could
 think of but am still unsure about it.

diff --git a/git-cvsserver.perl b/git-cvsserver.perl
index 68aa752..25816c5 100755
--- a/git-cvsserver.perl
+++ b/git-cvsserver.perl
@@ -843,6 +843,7 @@ sub req_update
         if ( defined ( $wrev )
              and defined($meta->{revision})
              and $wrev == $meta->{revision}
+             and defined($state->{entries}{$filename}{modified_hash})
              and not exists ( $state->{opt}{C} ) )
         {
             $log->info("Tell the client the file is modified");
-- 
1.5.1
