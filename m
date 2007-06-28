From: Gerrit Pape <pape@smarden.org>
Subject: [PATCH] git-cvsimport: force checkout of working tree after initial import
Date: Thu, 28 Jun 2007 11:12:07 +0000
Message-ID: <20070628111207.28276.qmail@a0ecab5969a5b1.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: 430903@bugs.debian.org
To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 28 13:15:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I3rxv-0005U2-SW
	for gcvg-git@gmane.org; Thu, 28 Jun 2007 13:15:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759724AbXF1LPK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Jun 2007 07:15:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759034AbXF1LPJ
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Jun 2007 07:15:09 -0400
Received: from a.ns.smarden.org ([212.42.242.37]:55208 "HELO a.mx.smarden.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758242AbXF1LPI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jun 2007 07:15:08 -0400
Received: (qmail 28277 invoked by uid 1000); 28 Jun 2007 11:12:07 -0000
Mail-Followup-To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	430903@bugs.debian.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51097>

When creating a brand new git repository through git-cvsimport (not
incremental import), force a checkout of HEAD of master as working tree
after successful import using the -f switch to git checkout.  Otherwise
the working tree is empty, and all files are reported as 'deleted' by
git status.

This was noticed and reported by Cameron Dale through
 http://bugs.debian.org/430903

Signed-off-by: Gerrit Pape <pape@smarden.org>
---
 git-cvsimport.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-cvsimport.perl b/git-cvsimport.perl
index 69ccb88..ba23eb8 100755
--- a/git-cvsimport.perl
+++ b/git-cvsimport.perl
@@ -1007,7 +1007,7 @@ if ($orig_branch) {
 		if ($opt_r && $opt_o ne 'HEAD');
 	system('git-update-ref', 'HEAD', "$orig_branch");
 	unless ($opt_i) {
-		system('git checkout');
+		system('git checkout -f');
 		die "checkout failed: $?\n" if $?;
 	}
 }
-- 
1.5.2.1
