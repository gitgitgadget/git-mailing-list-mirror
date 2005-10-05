From: Martin Langhoff <martin@catalyst.net.nz>
Subject: [PATCH] cvsimport: don't pass --cvs-direct if user options contradict us
Date: Wed, 5 Oct 2005 23:46:31 +1300
Message-ID: <11285091911785-git-send-email-martin@catalyst.net.nz>
Reply-To: Martin Langhoff <martin@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Martin Langhoff <martin@catalyst.net.nz>
X-From: git-owner@vger.kernel.org Wed Oct 05 12:47:49 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EN6nN-0006V6-B5
	for gcvg-git@gmane.org; Wed, 05 Oct 2005 12:46:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965105AbVJEKqg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Oct 2005 06:46:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965106AbVJEKqg
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Oct 2005 06:46:36 -0400
Received: from 202-0-36-112.cable.paradise.net.nz ([202.0.36.112]:23492 "HELO
	mx.nzl.com.ar") by vger.kernel.org with SMTP id S965105AbVJEKqf
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 5 Oct 2005 06:46:35 -0400
Received: (qmail 30130 invoked from network); 5 Oct 2005 10:46:24 -0000
Received: from unknown (HELO aporo.local) (192.168.0.35)
  by 202-0-36-112.cable.paradise.net.nz with SMTP; 5 Oct 2005 10:46:24 -0000
In-Reply-To: 
X-Mailer: git-send-email
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9703>

Detecting if the user passed --no-cvs-direct and don't force the mode.
It allows us to support all the protocol that the standard cvs client
supports at the snail speed you should expect.

This only affects the rlog reading stage.

Signed-off-by: Martin Langhoff <martin@catalyst.net.nz>


---

 git-cvsimport.perl |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

35587b31ee78ae96a54b10107c5ea3ce21eaa6b1
diff --git a/git-cvsimport.perl b/git-cvsimport.perl
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
 
