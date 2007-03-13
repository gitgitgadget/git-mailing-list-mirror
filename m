From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: [PATCH] cvsserver: Be more chatty
Date: Tue, 13 Mar 2007 18:25:22 +0100
Message-ID: <11738067233199-git-send-email-frank@lichtenheld.de>
Cc: Frank Lichtenheld <frank@lichtenheld.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 13 18:40:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HRAzC-0000iN-5S
	for gcvg-git@gmane.org; Tue, 13 Mar 2007 18:40:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752579AbXCMRk3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Mar 2007 13:40:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752577AbXCMRkM
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Mar 2007 13:40:12 -0400
Received: from mail.lenk.info ([217.160.134.107]:61354 "EHLO mail.lenk.info"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752575AbXCMRkK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Mar 2007 13:40:10 -0400
X-Greylist: delayed 871 seconds by postgrey-1.27 at vger.kernel.org; Tue, 13 Mar 2007 13:40:08 EDT
Received: from p54b0dfde.dip.t-dialin.net ([84.176.223.222] helo=goedel.djpig.de)
	by mail.lenk.info with esmtpsa 
	(Cipher TLS-1.0:RSA_AES_256_CBC_SHA:32) (Exim 4.63 1)
	id 1HRAp5-0001an-8S; Tue, 13 Mar 2007 18:30:07 +0100
Received: from djpig by goedel.djpig.de with local (Exim 4.63)
	(envelope-from <frank@lichtenheld.de>)
	id 1HRAkV-0003l9-QG; Tue, 13 Mar 2007 18:25:23 +0100
X-Mailer: git-send-email 1.5.0.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42139>

Submit some additional messages to the client on commit and update.
Inspired by the standard CVS server though a little more terse.

Signed-off-by: Frank Lichtenheld <frank@lichtenheld.de>
---
 git-cvsserver.perl |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/git-cvsserver.perl b/git-cvsserver.perl
index 65fcc84..f21f2f1 100755
--- a/git-cvsserver.perl
+++ b/git-cvsserver.perl
@@ -947,6 +947,7 @@ sub req_update
 
             # we need to merge with the local changes ( M=successful merge, C=conflict merge )
             $log->info("Merging $file_local, $file_old, $file_new");
+            print "M Merging differences between 1.$oldmeta->{revision} and 1.$meta->{revision} into $filename\n";
 
             $log->debug("Temporary directory for merge is $dir");
 
@@ -973,6 +974,7 @@ sub req_update
             elsif ( $return == 1 )
             {
                 $log->info("Merged with conflicts");
+                print "E cvs update: conflicts found in $filename\n";
                 print "M C $filename\n";
 
                 # Don't want to actually _DO_ the update if -n specified
@@ -1207,9 +1209,15 @@ sub req_ci
 
         if ( defined $meta->{filehash} && $meta->{filehash} eq "deleted" )
         {
+            print "M new revision: delete\n";
             print "Remove-entry $dirpart\n";
             print "$filename\n";
         } else {
+            if ($meta->{revision} == 1) {
+	        print "M initial revision: 1.1\n";
+            } else {
+	        print "M new revision: 1.$meta->{revision}\n";
+            }
             print "Checked-in $dirpart\n";
             print "$filename\n";
             my $kopts = kopts_from_path($filepart);
-- 
1.5.0.3
