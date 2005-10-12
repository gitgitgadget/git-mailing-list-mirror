X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Martin Langhoff <martin@catalyst.net.nz>
Subject: [PATCH] cvsimport: don't pass --cvs-direct if user options contradict us
Date: Wed, 12 Oct 2005 16:18:55 +1300
Message-ID: <11290871353300-git-send-email-martin@catalyst.net.nz>
Reply-To: Martin Langhoff <martin@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
NNTP-Posting-Date: Wed, 12 Oct 2005 03:20:44 +0000 (UTC)
Cc: Martin Langhoff <martin@catalyst.net.nz>
Return-path: <git-owner@vger.kernel.org>
X-Mailer: git-send-email
In-Reply-To: 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10000>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1EPX9I-0004WU-TP for gcvg-git@gmane.org; Wed, 12 Oct
 2005 05:19:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932384AbVJLDSv (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 11 Oct 2005
 23:18:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932386AbVJLDSv
 (ORCPT <rfc822;git-outgoing>); Tue, 11 Oct 2005 23:18:51 -0400
Received: from godel.catalyst.net.nz ([202.78.240.40]:53672 "EHLO
 mail1.catalyst.net.nz") by vger.kernel.org with ESMTP id S932384AbVJLDSu
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 11 Oct 2005 23:18:50 -0400
Received: from leibniz.catalyst.net.nz ([202.78.240.7]
 helo=aporo.wgtn.cat-it.co.nz) by mail1.catalyst.net.nz with smtp (Exim 4.50)
 id 1EPX8j-0006Ag-4T; Wed, 12 Oct 2005 16:18:49 +1300
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Detecting if the user passed --no-cvs-direct and don't force the mode.
It allows us to support all the protocol that the standard cvs client
supports at the snail speed you should expect.

This only affects the rlog reading stage.

Signed-off-by: Martin Langhoff <martin@catalyst.net.nz>


---

 git-cvsimport.perl |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

applies-to: c3f42ea5a9df4c1c520b0f32d4e3808d4f000ed7
35587b31ee78ae96a54b10107c5ea3ce21eaa6b1
diff --git a/git-cvsimport.perl b/git-cvsimport.perl
index f35c0d0..f7c3a51 100755
--- a/git-cvsimport.perl
+++ b/git-cvsimport.perl
@@ -487,7 +487,10 @@ unless($pid) {
 	my @opt;
 	@opt = split(/,/,$opt_p) if defined $opt_p;
 	unshift @opt, '-z', $opt_z if defined $opt_z;
-	exec("cvsps",@opt,"-u","-A","--cvs-direct",'--root',$opt_d,$cvs_tree);
+	unless ($opt_p =~ m/--no-cvs-direct/) {
+		push @opt, '--cvs-direct';
+	}
+	exec("cvsps",@opt,"-u","-A",'--root',$opt_d,$cvs_tree);
 	die "Could not start cvsps: $!\n";
 }
 
---
0.99.8.GIT

