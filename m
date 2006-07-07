From: Peter Baumann <siprbaum@stud.informatik.uni-erlangen.de>
Subject: [BUGFIX][RESEND]git-cvsexportcommit can't handle merge commits correctly
Date: Fri, 7 Jul 2006 12:55:41 +0200
Message-ID: <20060707105541.GA17004@xp.machine.xx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Langhoff <martin@catalyst.net.nz>,
	Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Jul 07 12:56:07 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fyo09-00021p-BJ
	for gcvg-git@gmane.org; Fri, 07 Jul 2006 12:56:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932118AbWGGKzo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Jul 2006 06:55:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932124AbWGGKzo
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Jul 2006 06:55:44 -0400
Received: from matlock.hofmann.stw.uni-erlangen.de ([131.188.24.35]:44965 "HELO
	mail.hofmann.stw.uni-erlangen.de") by vger.kernel.org with SMTP
	id S932118AbWGGKzn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jul 2006 06:55:43 -0400
Received: (qmail 8869 invoked by uid 0); 7 Jul 2006 10:55:41 -0000
Received: from ho135.hofmann.stw.uni-erlangen.de (HELO localhost) (p.b@hofmann.stw.uni-erlangen.de@172.17.27.135)
  by mail.hofmann.stw.uni-erlangen.de with SMTP; 7 Jul 2006 10:55:41 -0000
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org,
	Martin Langhoff <martin@catalyst.net.nz>,
	Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23425>

git-cvsexportcommit should check if the parent (supplied on the cmdline) to use
for a merge commit is one of the real parents of the merge.

But it errors out if the _first_ parent doesn't match and never checks
the other parents.

Signed-off-by: Peter Baumann <siprbaum@stud.informatik.uni-erlangen.de>
---
This is a resend with an improved description, because my first attempt
didn't generate enough attention :-)

 git-cvsexportcommit.perl |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-cvsexportcommit.perl b/git-cvsexportcommit.perl
index d1051d0..5dcb2f9 100755
--- a/git-cvsexportcommit.perl
+++ b/git-cvsexportcommit.perl
@@ -63,15 +63,15 @@ foreach my $p (@commit) {
 }
 
 if ($parent) {
+    my $found;
     # double check that it's a valid parent
     foreach my $p (@parents) {
-	my $found;
 	if ($p eq $parent) {
 	    $found = 1;
 	    last;
 	}; # found it
-	die "Did not find $parent in the parents for this commit!";
     }
+    die "Did not find $parent in the parents for this commit!" if !$found;
 } else { # we don't have a parent from the cmdline...
     if (@parents == 1) { # it's safe to get it from the commit
 	$parent = $parents[0];
-- 
1.4.0
