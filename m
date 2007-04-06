From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: [PATCH 3/5] cvsimport: Improve usage error reporting
Date: Fri,  6 Apr 2007 23:52:41 +0200
Message-ID: <11758963642149-git-send-email-frank@lichtenheld.de>
References: <11758963633237-git-send-email-frank@lichtenheld.de> <11758963634155-git-send-email-frank@lichtenheld.de> <11758963643049-git-send-email-frank@lichtenheld.de>
Cc: Junio C Hamano <junkio@cox.net>,
	Frank Lichtenheld <frank@lichtenheld.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 07 01:21:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZwN8-0006I3-C2
	for gcvg-git@gmane.org; Fri, 06 Apr 2007 23:53:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750985AbXDFVxO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Apr 2007 17:53:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751234AbXDFVxO
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Apr 2007 17:53:14 -0400
Received: from mail.lenk.info ([217.160.134.107]:59338 "EHLO mail.lenk.info"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750985AbXDFVxK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Apr 2007 17:53:10 -0400
Received: from herkules.lenk.info
	([213.239.194.154] helo=smtp.lenk.info ident=Debian-exim)
	by mail.lenk.info with esmtpsa 
	(Cipher TLS-1.0:RSA_AES_256_CBC_SHA:32) (Exim 4.63 1)
	id 1HZwN3-0006Id-0y; Fri, 06 Apr 2007 23:53:25 +0200
Received: from p54b0f96b.dip.t-dialin.net ([84.176.249.107] helo=goedel.djpig.de)
	by smtp.lenk.info with esmtpsa 
	(Cipher TLS-1.0:RSA_AES_256_CBC_SHA:32) (Exim 4.63 1)
	id 1HZwMk-0001c7-Q6; Fri, 06 Apr 2007 23:53:07 +0200
Received: from djpig by goedel.djpig.de with local (Exim 4.63)
	(envelope-from <frank@lichtenheld.de>)
	id 1HZwMO-00038C-FG; Fri, 06 Apr 2007 23:52:44 +0200
X-Mailer: git-send-email 1.5.1
In-Reply-To: <11758963643049-git-send-email-frank@lichtenheld.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43925>

Actually tell the user what he did wrong in case of usage errors
instead of only printing the general usage information.

Signed-off-by: Frank Lichtenheld <frank@lichtenheld.de>
---
 git-cvsimport.perl |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/git-cvsimport.perl b/git-cvsimport.perl
index d3fbcbc..ac74bc5 100755
--- a/git-cvsimport.perl
+++ b/git-cvsimport.perl
@@ -32,7 +32,9 @@ $ENV{'TZ'}="UTC";
 our ($opt_h,$opt_o,$opt_v,$opt_k,$opt_u,$opt_d,$opt_p,$opt_C,$opt_z,$opt_i,$opt_P, $opt_s,$opt_m,$opt_M,$opt_A,$opt_S,$opt_L, $opt_a);
 my (%conv_author_name, %conv_author_email);
 
-sub usage() {
+sub usage(;$) {
+	my $msg = shift;
+	print(STDERR "Error: $msg\n") if $msg;
 	print STDERR <<END;
 Usage: ${\basename $0}     # fetch/update GIT from CVS
        [-o branch-for-HEAD] [-h] [-v] [-d CVSROOT] [-A author-conv-file]
@@ -117,7 +119,7 @@ read_repo_config($opts);
 getopts($opts) or usage();
 usage if $opt_h;
 
-@ARGV <= 1 or usage();
+@ARGV <= 1 or usage("You can't specify more than one CVS module");
 
 if ($opt_d) {
 	$ENV{"CVSROOT"} = $opt_d;
@@ -130,7 +132,7 @@ if ($opt_d) {
 } elsif ($ENV{"CVSROOT"}) {
 	$opt_d = $ENV{"CVSROOT"};
 } else {
-	die "CVSROOT needs to be set";
+	usage("CVSROOT needs to be set");
 }
 $opt_o ||= "origin";
 $opt_s ||= "-";
@@ -149,7 +151,7 @@ if ($#ARGV == 0) {
 	chomp $cvs_tree;
 	close $f;
 } else {
-	usage();
+	usage("CVS module has to be specified");
 }
 
 our @mergerx = ();
-- 
1.5.1
