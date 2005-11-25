From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Make git-mv work in subdirectories, too
Date: Fri, 25 Nov 2005 12:36:35 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0511251236060.30796@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Fri Nov 25 12:37:49 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Efbst-0007Nc-IT
	for gcvg-git@gmane.org; Fri, 25 Nov 2005 12:36:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751449AbVKYLgh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 25 Nov 2005 06:36:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751453AbVKYLgh
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Nov 2005 06:36:37 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:24974 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1751449AbVKYLgg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Nov 2005 06:36:36 -0500
Received: from wrzx34.rz.uni-wuerzburg.de (wrzx34.rz.uni-wuerzburg.de [132.187.3.34])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id C322013FE4A; Fri, 25 Nov 2005 12:36:35 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id A27D1B5315; Fri, 25 Nov 2005 12:36:35 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 8574EB52DA; Fri, 25 Nov 2005 12:36:35 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 64E1F13FE4A; Fri, 25 Nov 2005 12:36:35 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12738>


Turns out, all git programs git-mv uses are capable of operating in
a subdirectory just fine. So don't complain about it.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

	I am no Perl guru, so this might not be the best way to go
	about it. Also, if people agree, I would like to remove the
	extra check for GIT_DIR validity, since git-rev-parse --git-dir
	does that already.

 git-mv.perl |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

applies-to: 6b942d45a420cf8f4064f77713d9b218e7fa53cb
fa750ba9ea3a27b39c8931b18cf0e60a89bf9fd7
diff --git a/git-mv.perl b/git-mv.perl
index bf54c38..bb61add 100755
--- a/git-mv.perl
+++ b/git-mv.perl
@@ -34,7 +34,8 @@ EOT
 }
 
 # Sanity checks:
-my $GIT_DIR = $ENV{'GIT_DIR'} || ".git";
+my $GIT_DIR = `git-rev-parse --git-dir`;
+$GIT_DIR =~ s/\n$//;
 
 unless ( -d $GIT_DIR && -d $GIT_DIR . "/objects" && 
 	-d $GIT_DIR . "/objects/" && -d $GIT_DIR . "/refs") {
---
0.99.9.GIT
