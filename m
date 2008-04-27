From: "Stephen R. van den Berg" <srb@cuci.nl>
Subject: [updated PATCH] Protect current tags, import tags into remote tree
Date: Sun, 27 Apr 2008 19:32:46 +0200
Message-ID: <20080427173246.10023.94820.stgit@aristoteles.cuci.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 27 19:33:51 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqAkx-0005Ea-Mz
	for gcvg-git-2@gmane.org; Sun, 27 Apr 2008 19:33:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756949AbYD0Rcz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Apr 2008 13:32:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756799AbYD0Rcw
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Apr 2008 13:32:52 -0400
Received: from aristoteles.cuci.nl ([212.125.128.18]:43459 "EHLO
	aristoteles.cuci.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755694AbYD0Rcv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Apr 2008 13:32:51 -0400
Received: by aristoteles.cuci.nl (Postfix, from userid 500)
	id 6CC43545F; Sun, 27 Apr 2008 19:32:46 +0200 (CEST)
User-Agent: StGIT/0.14.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80463>

git-cvsimport properly creates a subdir in refs/remotes to put the
branches in from the remote repository, it currently stores any tags
directly in refs/tags, which makes the imported tags overwrite current
ones.  This patch makes sure that imported tags are under the proper
refs/remotes/.../tags subdirectory as well.

Signed-off-by: Stephen R. van den Berg <srb@cuci.nl>
---

 git-cvsimport.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)


diff --git a/git-cvsimport.perl b/git-cvsimport.perl
index 95c5eec..73109d6 100755
--- a/git-cvsimport.perl
+++ b/git-cvsimport.perl
@@ -781,7 +781,7 @@ sub commit {
 		$xtag =~ tr/_/\./ if ( $opt_u );
 		$xtag =~ s/[\/]/$opt_s/g;
 
-		system('git-tag', '-f', $xtag, $cid) == 0
+		system("git-update-ref $remote/tags/$xtag $cid") == 0
 			or die "Cannot create tag $xtag: $!\n";
 
 		print "Created tag '$xtag' on '$branch'\n" if $opt_v;
