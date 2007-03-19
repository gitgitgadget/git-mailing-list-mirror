From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: [PATCH 2/5] cvsserver: Handle three part keys in git config correctly
Date: Mon, 19 Mar 2007 16:55:58 +0100
Message-ID: <1174319761945-git-send-email-frank@lichtenheld.de>
References: <11743197614111-git-send-email-frank@lichtenheld.de>
Cc: Frank Lichtenheld <frank@lichtenheld.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 19 17:01:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HTKHo-0003Sz-64
	for gcvg-git@gmane.org; Mon, 19 Mar 2007 17:00:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030274AbXCSQAX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Mar 2007 12:00:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030278AbXCSQAW
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Mar 2007 12:00:22 -0400
Received: from mail.lenk.info ([217.160.134.107]:62959 "EHLO mail.lenk.info"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030274AbXCSQAT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Mar 2007 12:00:19 -0400
Received: from herkules.lenk.info
	([213.239.194.154] helo=smtp.lenk.info ident=Debian-exim)
	by mail.lenk.info with esmtpsa 
	(Cipher TLS-1.0:RSA_AES_256_CBC_SHA:32) (Exim 4.63 1)
	id 1HTKEL-000472-7b; Mon, 19 Mar 2007 16:57:05 +0100
Received: from p54b0eb28.dip.t-dialin.net ([84.176.235.40] helo=goedel.djpig.de)
	by smtp.lenk.info with esmtpsa 
	(Cipher TLS-1.0:RSA_AES_256_CBC_SHA:32) (Exim 4.63 1)
	id 1HTKE1-0005ud-4B; Mon, 19 Mar 2007 16:56:45 +0100
Received: from djpig by goedel.djpig.de with local (Exim 4.63)
	(envelope-from <frank@lichtenheld.de>)
	id 1HTKDJ-0005vl-D6; Mon, 19 Mar 2007 16:56:01 +0100
X-Mailer: git-send-email 1.5.0.3
In-Reply-To: <11743197614111-git-send-email-frank@lichtenheld.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42633>

This is intended to be used in the form gitcvs.<method>.<var>
but this patch doesn't introduce any users yet.

Signed-off-by: Frank Lichtenheld <frank@lichtenheld.de>
---
 git-cvsserver.perl |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/git-cvsserver.perl b/git-cvsserver.perl
index e9d489b..4edb796 100755
--- a/git-cvsserver.perl
+++ b/git-cvsserver.perl
@@ -183,8 +183,12 @@ sub req_Root
     }
     foreach my $line ( @gitvars )
     {
-        next unless ( $line =~ /^(.*?)\.(.*?)=(.*)$/ );
-        $cfg->{$1}{$2} = $3;
+        next unless ( $line =~ /^(.*?)\.(.*?)(?:\.(.*?))?=(.*)$/ );
+        unless ($3) {
+            $cfg->{$1}{$2} = $4;
+        } else {
+            $cfg->{$1}{$2}{$3} = $4;
+        }
     }
 
     unless ( defined ( $cfg->{gitcvs}{enabled} ) and $cfg->{gitcvs}{enabled} =~ /^\s*(1|true|yes)\s*$/i )
-- 
1.5.0.3
