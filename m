From: Sven Verdoolaege <skimo@kotnet.org>
Subject: [PATCH] git-cvsimport-script: fix branch switching
Date: Mon, 4 Jul 2005 16:06:16 +0200
Message-ID: <20050704140616.GN18608MdfPADPa@garage.linux.student.kuleuven.ac.be>
References: <pan.2005.06.28.19.23.08.307486@smurf.noris.de> <20050630150239.GA20928@pc117b.liacs.nl> <20050630152125.GO10850@kiste.smurf.noris.de> <20050630154453.GA26808@pc117b.liacs.nl> <20050630161043.GR10850@kiste.smurf.noris.de> <20050630161423.GC26808@pc117b.liacs.nl> <20050630163000.GT10850@kiste.smurf.noris.de> <Pine.LNX.4.63.0506301321350.1667@localhost.localdomain> <pan.2005.07.01.09.43.24.106822@smurf.noris.de> <20050703103517.GJ5992MdfPADPa@garage.linux.student.kuleuven.ac.be>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Jul 04 16:24:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DpRry-0000y3-La
	for gcvg-git@gmane.org; Mon, 04 Jul 2005 16:24:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261186AbVGDOXf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 4 Jul 2005 10:23:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261178AbVGDOX3
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Jul 2005 10:23:29 -0400
Received: from spoetnik.kulnet.kuleuven.ac.be ([134.58.240.46]:9177 "EHLO
	spoetnik.kulnet.kuleuven.ac.be") by vger.kernel.org with ESMTP
	id S261285AbVGDOXF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jul 2005 10:23:05 -0400
Received: from localhost (localhost [127.0.0.1])
	by spoetnik.kulnet.kuleuven.ac.be (Postfix) with ESMTP id D62C233E90
	for <git@vger.kernel.org>; Mon,  4 Jul 2005 16:23:03 +0200 (CEST)
Received: from octavianus.kulnet.kuleuven.ac.be (octavianus.kulnet.kuleuven.ac.be [134.58.240.71])
	by spoetnik.kulnet.kuleuven.ac.be (Postfix) with ESMTP id F1EB333E6D
	for <git@vger.kernel.org>; Mon,  4 Jul 2005 16:23:00 +0200 (CEST)
Received: from garage.linux.student.kuleuven.ac.be (garage.linux.student.kuleuven.be [193.190.253.84])
	by octavianus.kulnet.kuleuven.ac.be (Postfix) with ESMTP id E2F6FAED89
	for <git@vger.kernel.org>; Mon,  4 Jul 2005 16:23:00 +0200 (CEST)
Received: (qmail 23690 invoked by uid 500); 4 Jul 2005 14:06:16 -0000
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

git-cvsimport-script: fix branch switching

Previous patch broke branch switching.

---
commit 46e63efc072bc440e4c6aad33d3157b70f5172b6
tree 2c4fd7286e29e6041808d07874ef2151e3876676
parent 79ee456cf222982f7ee3f003440c57b5f7cffa8b
author Sven Verdoolaege <skimo@kotnet.org> Mon, 04 Jul 2005 15:28:36 +0200
committer Sven Verdoolaege <skimo@kotnet.org> Mon, 04 Jul 2005 15:28:36 +0200

 git-cvsimport-script |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/git-cvsimport-script b/git-cvsimport-script
--- a/git-cvsimport-script
+++ b/git-cvsimport-script
@@ -651,9 +651,10 @@ while(<CVS>) {
 		}
 		if(($ancestor || $branch) ne $last_branch) {
 			print "Switching from $last_branch to $branch\n" if $opt_v;
-			system("git-read-tree","-m","$last_branch","$branch");
+			system("git-read-tree", $branch);
 			die "read-tree failed: $?\n" if $?;
 		}
+		$last_branch = $branch if $branch ne $last_branch;
 		$state = 9;
 	} elsif($state == 8) {
 		$logmsg .= "$_\n";
