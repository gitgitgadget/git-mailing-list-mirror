From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: [PATCH 1/5] cvsserver: Introduce new state variable 'method'
Date: Mon, 19 Mar 2007 16:55:57 +0100
Message-ID: <11743197614055-git-send-email-frank@lichtenheld.de>
References: <11743197614111-git-send-email-frank@lichtenheld.de>
Cc: Frank Lichtenheld <frank@lichtenheld.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 19 16:56:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HTKE9-0001kD-KW
	for gcvg-git@gmane.org; Mon, 19 Mar 2007 16:56:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030266AbXCSP4w (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Mar 2007 11:56:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030259AbXCSP4w
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Mar 2007 11:56:52 -0400
Received: from mail.lenk.info ([217.160.134.107]:62753 "EHLO mail.lenk.info"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030230AbXCSP4v (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Mar 2007 11:56:51 -0400
Received: from herkules.lenk.info
	([213.239.194.154] helo=smtp.lenk.info ident=Debian-exim)
	by mail.lenk.info with esmtpsa 
	(Cipher TLS-1.0:RSA_AES_256_CBC_SHA:32) (Exim 4.63 1)
	id 1HTKEP-00047D-Gg; Mon, 19 Mar 2007 16:57:09 +0100
Received: from p54b0eb28.dip.t-dialin.net ([84.176.235.40] helo=goedel.djpig.de)
	by smtp.lenk.info with esmtpsa 
	(Cipher TLS-1.0:RSA_AES_256_CBC_SHA:32) (Exim 4.63 1)
	id 1HTKE5-0005ut-MS; Mon, 19 Mar 2007 16:56:49 +0100
Received: from djpig by goedel.djpig.de with local (Exim 4.63)
	(envelope-from <frank@lichtenheld.de>)
	id 1HTKDJ-0005vj-86; Mon, 19 Mar 2007 16:56:01 +0100
X-Mailer: git-send-email 1.5.0.3
In-Reply-To: <11743197614111-git-send-email-frank@lichtenheld.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42628>

$state->{method} contains the CVS access method used,
either 'ext' or 'pserver'

Signed-off-by: Frank Lichtenheld <frank@lichtenheld.de>
---
 git-cvsserver.perl |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/git-cvsserver.perl b/git-cvsserver.perl
index 68aa752..e9d489b 100755
--- a/git-cvsserver.perl
+++ b/git-cvsserver.perl
@@ -91,7 +91,9 @@ $log->debug("Temporary directory is '$TEMP_DIR'");
 # if we are called with a pserver argument,
 # deal with the authentication cat before entering the
 # main loop
+$state->{method} = 'ext';
 if (@ARGV && $ARGV[0] eq 'pserver') {
+    $state->{method} = 'pserver';
     my $line = <STDIN>; chomp $line;
     unless( $line eq 'BEGIN AUTH REQUEST') {
        die "E Do not understand $line - expecting BEGIN AUTH REQUEST\n";
@@ -1026,7 +1028,7 @@ sub req_ci
 
     $log->info("req_ci : " . ( defined($data) ? $data : "[NULL]" ));
 
-    if ( @ARGV && $ARGV[0] eq 'pserver')
+    if ( $state->{method} eq 'pserver')
     {
         print "error 1 pserver access cannot commit\n";
         exit;
-- 
1.5.0.3
