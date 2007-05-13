From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: [PATCH] cvsserver: Don't send mixed messages to clients
Date: Sun, 13 May 2007 19:49:05 +0200
Message-ID: <1179078545517-git-send-email-frank@lichtenheld.de>
Cc: git@vger.kernel.org, Martin Langhoff <martin.langhoff@gmail.com>,
	Frank Lichtenheld <frank@lichtenheld.de>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun May 13 19:49:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HnIC1-00012s-8J
	for gcvg-git@gmane.org; Sun, 13 May 2007 19:49:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754173AbXEMRtJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 13 May 2007 13:49:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753827AbXEMRtJ
	(ORCPT <rfc822;git-outgoing>); Sun, 13 May 2007 13:49:09 -0400
Received: from mail.lenk.info ([217.160.134.107]:3138 "EHLO mail.lenk.info"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754173AbXEMRtI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 May 2007 13:49:08 -0400
Received: from herkules.lenk.info
	([213.239.194.154] helo=smtp.lenk.info ident=Debian-exim)
	by mail.lenk.info with esmtpsa 
	(Cipher TLS-1.0:RSA_AES_256_CBC_SHA1:32) (Exim 4.63 1)
	id 1HnIAg-0006pC-13; Sun, 13 May 2007 19:47:50 +0200
Received: from p54b0dc82.dip.t-dialin.net ([84.176.220.130] helo=localhost)
	by smtp.lenk.info with esmtpsa 
	(Cipher TLS-1.0:RSA_AES_256_CBC_SHA:32) (Exim 4.63 1)
	id 1HnIBt-00030M-Lp; Sun, 13 May 2007 19:49:05 +0200
Received: from djpig by localhost with local (Exim 4.67)
	(envelope-from <frank@lichtenheld.de>)
	id 1HnIBt-0001zE-Fk; Sun, 13 May 2007 19:49:05 +0200
X-Mailer: git-send-email 1.5.1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47154>

After we send I HATE YOU we should probably exit and not happily
continue with I LOVE YOU and further communication.

Most clients will probably just exit and ignore everything we
send after the I HATE YOU and it is not a security problem
either because we don't really care about the user name anyway.

But it is still the right thing to do.

Signed-off-by: Frank Lichtenheld <frank@lichtenheld.de>
---
 git-cvsserver.perl |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/git-cvsserver.perl b/git-cvsserver.perl
index a07c725..fcfb99d 100755
--- a/git-cvsserver.perl
+++ b/git-cvsserver.perl
@@ -105,6 +105,7 @@ if (@ARGV && $ARGV[0] eq 'pserver') {
     unless ($line eq 'anonymous') {
        print "E Only anonymous user allowed via pserver\n";
        print "I HATE YOU\n";
+       exit 1;
     }
     $line = <STDIN>; chomp $line;    # validate the password?
     $line = <STDIN>; chomp $line;
-- 
1.5.1.4
