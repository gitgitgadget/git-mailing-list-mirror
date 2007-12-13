From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] git-svn: unlink internal index files after operations
Date: Thu, 13 Dec 2007 08:27:34 -0800
Message-ID: <20071213162734.GA18433@soma>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 13 17:28:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2qun-0002rC-Gk
	for gcvg-git-2@gmane.org; Thu, 13 Dec 2007 17:28:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754058AbXLMQ1h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Dec 2007 11:27:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755379AbXLMQ1h
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Dec 2007 11:27:37 -0500
Received: from hand.yhbt.net ([66.150.188.102]:59007 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752895AbXLMQ1h (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Dec 2007 11:27:37 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id CC3317DC025;
	Thu, 13 Dec 2007 08:27:35 -0800 (PST)
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68170>

Being git, we can generate these very quickly on the fly as
needed, so there's no point in wasting space for these things
for large projects.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 git-svn.perl |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 54d7844..fde39e2 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -396,6 +396,7 @@ sub cmd_set_tree {
 	}
 	$gs->set_tree($_) foreach @revs;
 	print "Done committing ",scalar @revs," revisions to SVN\n";
+	unlink $gs->{index};
 }
 
 sub cmd_dcommit {
@@ -514,6 +515,7 @@ sub cmd_dcommit {
 			$last_rev = $cmt_rev;
 		}
 	}
+	unlink $gs->{index};
 }
 
 sub cmd_find_rev {
@@ -1374,6 +1376,7 @@ sub fetch_all {
 
 	($base, $head) = parse_revision_argument($base, $head);
 	$ra->gs_fetch_loop_common($base, $head, \@gs, \@globs);
+	unlink $_->{index} foreach @gs;
 }
 
 sub read_all_remotes {
-- 
Eric Wong
