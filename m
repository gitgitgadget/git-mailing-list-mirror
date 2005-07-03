From: Sven Verdoolaege <skimo@kotnet.org>
Subject: git-cvsimport-script: Honour CVS_SERVER.
Date: Sun, 3 Jul 2005 13:37:36 +0200
Message-ID: <20050703113736.GA18608MdfPADPa@garage.linux.student.kuleuven.ac.be>
References: <pan.2005.06.28.19.23.08.307486@smurf.noris.de> <20050630150239.GA20928@pc117b.liacs.nl> <20050630152125.GO10850@kiste.smurf.noris.de> <20050630154453.GA26808@pc117b.liacs.nl> <20050630161043.GR10850@kiste.smurf.noris.de> <20050630161423.GC26808@pc117b.liacs.nl> <20050630163000.GT10850@kiste.smurf.noris.de> <Pine.LNX.4.63.0506301321350.1667@localhost.localdomain> <pan.2005.07.01.09.43.24.106822@smurf.noris.de> <20050703103517.GJ5992MdfPADPa@garage.linux.student.kuleuven.ac.be>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun Jul 03 13:54:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dp33B-0006jW-DP
	for gcvg-git@gmane.org; Sun, 03 Jul 2005 13:54:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261394AbVGCLyJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 3 Jul 2005 07:54:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261392AbVGCLyJ
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Jul 2005 07:54:09 -0400
Received: from spoetnik.kulnet.kuleuven.ac.be ([134.58.240.46]:3562 "EHLO
	spoetnik.kulnet.kuleuven.ac.be") by vger.kernel.org with ESMTP
	id S261394AbVGCLx6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Jul 2005 07:53:58 -0400
Received: from localhost (localhost [127.0.0.1])
	by spoetnik.kulnet.kuleuven.ac.be (Postfix) with ESMTP id DC23633EE8
	for <git@vger.kernel.org>; Sun,  3 Jul 2005 13:53:57 +0200 (CEST)
Received: from octavianus.kulnet.kuleuven.ac.be (octavianus.kulnet.kuleuven.ac.be [134.58.240.71])
	by spoetnik.kulnet.kuleuven.ac.be (Postfix) with ESMTP id EBDF333E8B
	for <git@vger.kernel.org>; Sun,  3 Jul 2005 13:53:54 +0200 (CEST)
Received: from garage.linux.student.kuleuven.ac.be (garage.linux.student.kuleuven.be [193.190.253.84])
	by octavianus.kulnet.kuleuven.ac.be (Postfix) with ESMTP id DC72BAED85
	for <git@vger.kernel.org>; Sun,  3 Jul 2005 13:53:54 +0200 (CEST)
Received: (qmail 23008 invoked by uid 500); 3 Jul 2005 11:37:36 -0000
To: Matthias Urlichs <smurf@smurf.noris.de>, git@vger.kernel.org
Mail-Followup-To: Matthias Urlichs <smurf@smurf.noris.de>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20050703103517.GJ5992MdfPADPa@garage.linux.student.kuleuven.ac.be>
User-Agent: Mutt/1.5.9i
X-Virus-Scanned: by KULeuven Antivirus Cluster
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Honour CVS_SERVER.

---
commit 8d0ea3117597933610e02907d14b443f8996ca3b
tree 8a8aba2772a770082e7d6bd47abd42c3e239ed2c
parent a92bebe6978edaea2885a627e7bef6f7f8b208c2
author Sven Verdoolaege <skimo@kotnet.org> Sun, 03 Jul 2005 12:26:51 +0200
committer Sven Verdoolaege <skimo@kotnet.org> Sun, 03 Jul 2005 12:26:51 +0200

 git-cvsimport-script |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/git-cvsimport-script b/git-cvsimport-script
--- a/git-cvsimport-script
+++ b/git-cvsimport-script
@@ -148,6 +148,8 @@ sub conn {
 		my $pw = IO::Pipe->new();
 		my $pid = fork();
 		die "Fork: $!\n" unless defined $pid;
+		my $cvs = 'cvs';
+		$cvs = $ENV{CVS_SERVER} if exists $ENV{CVS_SERVER};
 		unless($pid) {
 			$pr->writer();
 			$pw->reader();
@@ -155,7 +157,7 @@ sub conn {
 			dup2($pr->fileno(),1);
 			$pr->close();
 			$pw->close();
-			exec("cvs","server");
+			exec($cvs,"server");
 		}
 		$pw->writer();
 		$pr->reader();
