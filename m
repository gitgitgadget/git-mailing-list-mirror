From: Mark Bryars <git@darkskiez.co.uk>
Subject: [PATCH] git-svn: support svnmerge.py merge tickets from pre svn 1.5.0 releases
Date: Thu, 1 Apr 2010 22:54:50 +0000 (UTC)
Message-ID: <loom.20100402T005055-989@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 02 01:00:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NxTMy-0003Sv-Ee
	for gcvg-git-2@lo.gmane.org; Fri, 02 Apr 2010 01:00:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757874Ab0DAXAG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Apr 2010 19:00:06 -0400
Received: from lo.gmane.org ([80.91.229.12]:60600 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756638Ab0DAXAE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Apr 2010 19:00:04 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1NxTMp-0003P2-0V
	for git@vger.kernel.org; Fri, 02 Apr 2010 01:00:03 +0200
Received: from cpc4-broo7-2-0-cust263.know.cable.virginmedia.com ([86.30.225.8])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 02 Apr 2010 01:00:02 +0200
Received: from git by cpc4-broo7-2-0-cust263.know.cable.virginmedia.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 02 Apr 2010 01:00:02 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 86.30.225.8 (Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.6) Gecko/20091216 Iceweasel/3.5.8 (like Firefox/3.5.8))
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143759>


I currently have an SVN 1.3.x repository and am using the old svnmerge.py script
to manage merges with it, it would be nice to migrate to git without first
upgrading to SVN 1.5+, running the converter tool, and then migrating to git.
This small patch allows me to skip that step by referencing the old property
names in the repo.

Regards,
 Mark Bryars



>From 15856073779bfdd1c5367ea9e01a55242c1e7568 Mon Sep 17 00:00:00 2001
From: Mark Bryars <git@darkskiez.co.uk>
Date: Thu, 1 Apr 2010 23:30:37 +0100
Subject: [PATCH] git-svn: support svnmerge.py merge tickets from pre svn 1.5.0
releases

Pre svn 1.5.0 svnmerge.py used svnmerge-integrated properties.
Small patch to check for these and apply them.

Signed-off-by: Mark Bryars <git@darkskiez.co.uk>
---
 git-svn.perl |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 2c86ea2..79eef5d 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -3304,6 +3304,12 @@ sub make_log_entry {
 				 $props->{"svn:mergeinfo"},
 				 \@parents);
 		}
+		if ( $props->{"svnmerge-integrated"} ) {
+			$self->find_extra_svn_parents
+				($ed,
+				 $props->{"svnmerge-integrated"},
+				 \@parents);
+		}
 	}
 
 	open my $un, '>>', "$self->{dir}/unhandled.log" or croak $!;
-- 
1.7.0.3
