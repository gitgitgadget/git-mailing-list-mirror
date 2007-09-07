From: Michael Smith <msmith@cbnco.com>
Subject: [RFC] svnimport/cvsimport: force creation of tags that already exist.
Date: Fri, 7 Sep 2007 11:42:22 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0709071125090.6203@juice.ott.cti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 07 18:12:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITgRV-0003cr-PC
	for gcvg-git@gmane.org; Fri, 07 Sep 2007 18:12:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757448AbXIGQMU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Sep 2007 12:12:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757089AbXIGQMU
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Sep 2007 12:12:20 -0400
Received: from mail1.cbnco.com ([207.164.182.72]:46274 "EHLO smtp.cbnco.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757409AbXIGQMS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Sep 2007 12:12:18 -0400
X-Greylist: delayed 1794 seconds by postgrey-1.27 at vger.kernel.org; Fri, 07 Sep 2007 12:12:18 EDT
Received: from localhost (localhost [127.0.0.1])
	by smtp.cbnco.com (Postfix) with ESMTP id ED4411E58BE
	for <git@vger.kernel.org>; Fri,  7 Sep 2007 11:42:22 -0400 (EDT)
Received: from smtp.cbnco.com ([127.0.0.1])
 by localhost (mail.cbnco.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 08791-05 for <git@vger.kernel.org>;
 Fri,  7 Sep 2007 11:42:22 -0400 (EDT)
Received: from juice.ott.cti.com (auriga-dmzgw.cbnco.com [207.164.182.65])
	by smtp.cbnco.com (Postfix) with ESMTP id C50C61E57ED
	for <git@vger.kernel.org>; Fri,  7 Sep 2007 11:42:22 -0400 (EDT)
X-X-Sender: michael@juice.ott.cti.com
X-Virus-Scanned: amavisd-new at cbnco.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58046>

Hi all,

git-svnimport was changed recently to use git-tag to make tags (47ee8ed2). 
I've had to add the "-f" option to import a repository where a tag was 
moved. I think git-cvsimport would have the same problem.

I understand moving tags is frowned upon in Git. I don't know how common 
the practise is in Subversion and CVS, or whether it makes sense to 
make the import scripts force tag creation by default.

Mike

---
 git-cvsimport.perl |    2 +-
 git-svnimport.perl |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-cvsimport.perl b/git-cvsimport.perl
index ba23eb8..2954fb8 100755
--- a/git-cvsimport.perl
+++ b/git-cvsimport.perl
@@ -779,7 +779,7 @@ sub commit {
 		$xtag =~ tr/_/\./ if ( $opt_u );
 		$xtag =~ s/[\/]/$opt_s/g;
 
-		system('git-tag', $xtag, $cid) == 0
+		system('git-tag', '-f', $xtag, $cid) == 0
 			or die "Cannot create tag $xtag: $!\n";
 
 		print "Created tag '$xtag' on '$branch'\n" if $opt_v;
diff --git a/git-svnimport.perl b/git-svnimport.perl
index 8c17fb5..d3ad5b9 100755
--- a/git-svnimport.perl
+++ b/git-svnimport.perl
@@ -873,7 +873,7 @@ sub commit {
 
 		$dest =~ tr/_/\./ if $opt_u;
 
-		system('git-tag', $dest, $cid) == 0
+		system('git-tag', '-f', $dest, $cid) == 0
 			or die "Cannot create tag $dest: $!\n";
 
 		print "Created tag '$dest' on '$branch'\n" if $opt_v;
-- 
1.5.2.1
