From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] git-svn: don't allow globs to match regular files
Date: Wed, 18 Apr 2007 00:17:33 -0700
Message-ID: <20070418071733.GA10627@muzzle>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Apr 18 09:17:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1He4Q6-0002wN-J5
	for gcvg-git@gmane.org; Wed, 18 Apr 2007 09:17:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932771AbXDRHRf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Apr 2007 03:17:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932778AbXDRHRf
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Apr 2007 03:17:35 -0400
Received: from hand.yhbt.net ([66.150.188.102]:55300 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932771AbXDRHRe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Apr 2007 03:17:34 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 3160C7DC09F;
	Wed, 18 Apr 2007 00:17:33 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Wed, 18 Apr 2007 00:17:33 -0700
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44865>

git only tracks the histories of full directories, not
that of individual files.  Sometimes, SVN users will
place[1] a regular file in the directory designated
for subdirectories of branches or tags.

Thanks to jrockway on #git for pointing this out.

[1] mistakenly or otherwise, such as a README

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---

 Junio: this can go in maint

 git-svn.perl |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 4d3c453..efc4c88 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -3162,6 +3162,8 @@ sub match_globs {
 			my $p = $1;
 			my $pathname = $g->{path}->full_path($p);
 			next if $exists->{$pathname};
+			next if ($self->check_path($pathname, $r) !=
+			         $SVN::Node::dir);
 			$exists->{$pathname} = Git::SVN->init(
 			                      $self->{url}, $pathname, undef,
 			                      $g->{ref}->full_path($p), 1);
-- 
Eric Wong
