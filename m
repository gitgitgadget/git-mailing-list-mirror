From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: [PATCH] git-mv: Allow -h without repo & fix error message
Date: Wed, 1 Mar 2006 18:16:36 +0100
Message-ID: <200603011816.36981.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 01 18:16:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FEUwM-0007aH-8m
	for gcvg-git@gmane.org; Wed, 01 Mar 2006 18:16:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030206AbWCARQj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Mar 2006 12:16:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030209AbWCARQj
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Mar 2006 12:16:39 -0500
Received: from mailout1.informatik.tu-muenchen.de ([131.159.0.18]:64437 "EHLO
	mailout1.informatik.tu-muenchen.de") by vger.kernel.org with ESMTP
	id S1030206AbWCARQj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Mar 2006 12:16:39 -0500
Received: from dhcp-3s-61.lrr.in.tum.de (dhcp-3s-61.lrr.in.tum.de [131.159.35.61])
	by mail.in.tum.de (Postfix) with ESMTP id E3EE22337;
	Wed,  1 Mar 2006 18:16:37 +0100 (MET)
To: Junio C Hamano <junkio@cox.net>
User-Agent: KMail/1.9.1
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new/sophie/sophos at mailrelay1.informatik.tu-muenchen.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16992>

This fixes "git-mv -h" to output the usage without the need
to be in a git repository.
Additionally:
- fix confusing error message when only one arg was given
- fix typo in error message

Signed-off-by: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>

---

 git-mv.perl |   16 ++++++++++------
 1 files changed, 10 insertions(+), 6 deletions(-)

2f1dc137362cfa84553340a8f1310bc784e5935b
diff --git a/git-mv.perl b/git-mv.perl
index 2ea852c..8cd95c4 100755
--- a/git-mv.perl
+++ b/git-mv.perl
@@ -19,15 +19,15 @@ EOT
 	exit(1);
 }
 
-my $GIT_DIR = `git rev-parse --git-dir`;
-exit 1 if $?; # rev-parse would have given "not a git dir" message.
-chomp($GIT_DIR);
-
 our ($opt_n, $opt_f, $opt_h, $opt_k, $opt_v);
 getopts("hnfkv") || usage;
 usage() if $opt_h;
 @ARGV >= 1 or usage;
 
+my $GIT_DIR = `git rev-parse --git-dir`;
+exit 1 if $?; # rev-parse would have given "not a git dir" message.
+chomp($GIT_DIR);
+
 my (@srcArgs, @dstArgs, @srcs, @dsts);
 my ($src, $dst, $base, $dstDir);
 
@@ -46,10 +46,14 @@ if (-d $ARGV[$argCount-1]) {
 	}
 }
 else {
-    if ($argCount != 2) {
+    if ($argCount < 2) {
+	print "Error: need at least two arguments\n";
+	exit(1);
+    }
+    if ($argCount > 2) {
 	print "Error: moving to directory '"
 	    . $ARGV[$argCount-1]
-	    . "' not possible; not exisiting\n";
+	    . "' not possible; not existing\n";
 	exit(1);
     }
     @srcArgs = ($ARGV[0]);
-- 
1.2.0.g719b
