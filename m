From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Use git-for-each-ref to check whether the origin branch
 exists.
Date: Wed, 23 May 2007 12:13:21 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0705231153000.4113@racer.site>
References: <Pine.LNX.4.64.0705230909310.25524@lar.bfw.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Stephan Springl <springl-git@bfw-online.de>
X-From: git-owner@vger.kernel.org Wed May 23 13:14:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HqonO-0001PZ-C3
	for gcvg-git@gmane.org; Wed, 23 May 2007 13:14:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758879AbXEWLOM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 23 May 2007 07:14:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758892AbXEWLOM
	(ORCPT <rfc822;git-outgoing>); Wed, 23 May 2007 07:14:12 -0400
Received: from mail.gmx.net ([213.165.64.20]:38532 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758879AbXEWLOL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 May 2007 07:14:11 -0400
Received: (qmail invoked by alias); 23 May 2007 11:14:09 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp056) with SMTP; 23 May 2007 13:14:09 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/1000flO71Q5jdGQ4EQ5yp948kBLZ6gPj9709GU6
	eWNgirahrCuI+5
X-X-Sender: gene099@racer.site
In-Reply-To: <Pine.LNX.4.64.0705230909310.25524@lar.bfw.de>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48151>

From: Stephan Springl <springl-git@bfw-online.de>

This works in repositories that have their refs packed by
"git-pack-refs --all --prune" whereas testing the file
$git_dir/refs/heads/$opt_o does not.

Acked-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

	On Wed, 23 May 2007, Stephan Springl wrote:
	
	> This helps us to use git-cvsimport on our ref-packed 
	> repositories.

	Default for ref-packed repositories is to pack only the tags, 
	therefore you usually do not need this patch. However, it looks 
	obviously correct to me. A cursory test also showed that it does 
	not break anything.

	> Maybe you want to use this or a similar solution to be 
	> integrated in stock git.
	
	Unfortunately your patch is white-space corrupted (it has an extra 
	space on all lines starting with a space, it seems). Therefore I 
	redid it with this email.

	It would be nice to follow Documentation/SubmittingPatches next 
	time. For example, I guess that you want to sign off on it...

 git-cvsimport.perl |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/git-cvsimport.perl b/git-cvsimport.perl
index ac74bc5..f68afe7 100755
--- a/git-cvsimport.perl
+++ b/git-cvsimport.perl
@@ -559,11 +559,6 @@ unless (-d $git_dir) {
 	$last_branch = $opt_o;
 	$orig_branch = "";
 } else {
-	-f "$git_dir/refs/heads/$opt_o"
-		or die "Branch '$opt_o' does not exist.\n".
-		       "Either use the correct '-o branch' option,\n".
-		       "or import to a new repository.\n";
-
 	open(F, "git-symbolic-ref HEAD |") or
 		die "Cannot run git-symbolic-ref: $!\n";
 	chomp ($last_branch = <F>);
@@ -588,6 +583,11 @@ unless (-d $git_dir) {
 		$branch_date{$head} = $1;
 	}
 	close(H);
+        if (!exists $branch_date{$opt_o}) {
+		die "Branch '$opt_o' does not exist.\n".
+		       "Either use the correct '-o branch' option,\n".
+		       "or import to a new repository.\n";
+        }
 }
 
 -d $git_dir
-- 
1.5.2.2527.ga2df
