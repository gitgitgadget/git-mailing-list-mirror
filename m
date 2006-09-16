From: Matthias Lederhofer <matled@gmx.net>
Subject: [PATCH/current master] gitweb: do not use 'No such directory' error message
Date: Sun, 17 Sep 2006 00:30:27 +0200
Message-ID: <20060916223027.GA32679@moooo.ath.cx>
References: <20060916192750.GA27008@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun Sep 17 00:30:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GOigC-0001Fa-Sm
	for gcvg-git@gmane.org; Sun, 17 Sep 2006 00:30:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964788AbWIPWaa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Sep 2006 18:30:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964796AbWIPWaa
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Sep 2006 18:30:30 -0400
Received: from moooo.ath.cx ([85.116.203.178]:5299 "EHLO moooo.ath.cx")
	by vger.kernel.org with ESMTP id S964788AbWIPWa3 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 16 Sep 2006 18:30:29 -0400
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20060916192750.GA27008@moooo.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27139>

undef $project; to prevent a file named description to be read.
---
Sorry, I patched an old version.  Here is the patch for the current
master/next.
---
 gitweb/gitweb.perl |   11 ++++-------
 1 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index a81c8d4..07ea1ea 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -203,13 +203,10 @@ if (defined $project) {
 	$project = undef unless $project;
 }
 if (defined $project) {
-	if (!validate_input($project)) {
-		die_error(undef, "Invalid project parameter");
-	}
-	if (!(-d "$projectroot/$project")) {
-		die_error(undef, "No such directory");
-	}
-	if (!(-e "$projectroot/$project/HEAD")) {
+	if (!validate_input($project) ||
+	    !(-d "$projectroot/$project") ||
+	    !(-e "$projectroot/$project/HEAD")) {
+		undef $project;
 		die_error(undef, "No such project");
 	}
 	$git_dir = "$projectroot/$project";
-- 
1.4.2.g0ea2
