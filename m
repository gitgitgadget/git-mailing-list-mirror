X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] git-svn: allow SVN:: lib users to track the root of the repository (again)
Date: Sat, 25 Nov 2006 17:38:41 -0800
Message-ID: <11645051211941-git-send-email-normalperson@yhbt.net>
NNTP-Posting-Date: Sun, 26 Nov 2006 01:38:49 +0000 (UTC)
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Mailer: git-send-email 1.4.4.1.gf64d
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32316>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Go8yk-00041k-PU for gcvg-git@gmane.org; Sun, 26 Nov
 2006 02:38:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S967126AbWKZBin (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 25 Nov 2006
 20:38:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966097AbWKZBin
 (ORCPT <rfc822;git-outgoing>); Sat, 25 Nov 2006 20:38:43 -0500
Received: from hand.yhbt.net ([66.150.188.102]:61406 "EHLO hand.yhbt.net") by
 vger.kernel.org with ESMTP id S967126AbWKZBin (ORCPT
 <rfc822;git@vger.kernel.org>); Sat, 25 Nov 2006 20:38:43 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1]) by hand.yhbt.net
 (Postfix) with SMTP id 690762DC034; Sat, 25 Nov 2006 17:38:41 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Sat, 25 Nov 2006
 17:38:41 -0800
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

I broke this again in 747fa12cef73b6ca04fffaddaad7326cf546cdea.

Thanks to merlyn for pointing this out to me on IRC.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 git-svn.perl |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 0a47b1f..de4e74a 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -2919,8 +2919,12 @@ sub libsvn_fetch {
 	my $p = $SVN->{svn_path};
 	foreach my $f (keys %$paths) {
 		my $m = $paths->{$f}->action();
-		$f =~ s#^/\Q$p\E/##;
-		next if $f =~ m#^/#;
+		if (length $p) {
+			$f =~ s#^/\Q$p\E/##;
+			next if $f =~ m#^/#;
+		} else {
+			$f =~ s#^/##;
+		}
 		if ($m =~ /^[DR]$/) {
 			print "\t$m\t$f\n" unless $_q;
 			process_rm($gui, $last_commit, $f);
-- 
1.4.4.1.gf64d
