From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] filter-branch: fix remnants of old syntax in documentation
Date: Fri, 31 Aug 2007 17:42:33 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708311742150.28586@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Aug 31 18:42:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IR9a1-0007zj-Hw
	for gcvg-git@gmane.org; Fri, 31 Aug 2007 18:42:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760576AbXHaQml (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 31 Aug 2007 12:42:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760503AbXHaQml
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Aug 2007 12:42:41 -0400
Received: from mail.gmx.net ([213.165.64.20]:48963 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1760467AbXHaQmk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Aug 2007 12:42:40 -0400
Received: (qmail invoked by alias); 31 Aug 2007 16:42:38 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp019) with SMTP; 31 Aug 2007 18:42:38 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+dNOMYdXedQBBCT5yV0IHJfI+YBCuKZtXvQJrbkE
	owTI8TTd97DQwQ
X-X-Sender: gene099@racer.site
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57187>


Some time ago, filter-branch's syntax changed so that more than one
ref can be rewritten at the same time.  This involved the removal of
the ref name for the result; instead, the refs are rewritten in-place.

This updates the last leftovers in the documentation to reflect the
new behavior.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/git-filter-branch.txt |   32 ++++++++++++++++++--------------
 1 files changed, 18 insertions(+), 14 deletions(-)

diff --git a/Documentation/git-filter-branch.txt b/Documentation/git-filter-branch.txt
index ae03514..4f89c04 100644
--- a/Documentation/git-filter-branch.txt
+++ b/Documentation/git-filter-branch.txt
@@ -17,19 +17,19 @@ SYNOPSIS
 
 DESCRIPTION
 -----------
-Lets you rewrite git revision history by creating a new branch from
-your current branch, applying custom filters on each revision.
+Lets you rewrite git revision history by rewriting the branches mentioned
+in the <rev-list options>, applying custom filters on each revision.
 Those filters can modify each tree (e.g. removing a file or running
 a perl rewrite on all files) or information about each commit.
 Otherwise, all information (including original commit times or merge
 information) will be preserved.
 
-The command takes the new branch name as a mandatory argument and
-the filters as optional arguments.  If you specify no filters, the
-commits will be recommitted without any changes, which would normally
-have no effect.  Nevertheless, this may be useful in the future for
-compensating for some git bugs or such, therefore such a usage is
-permitted.
+The command will only rewrite the _positive_ refs mentioned in the
+command line (i.e. if you pass 'a..b', only 'b' will be rewritten).
+If you specify no filters, the commits will be recommitted without any
+changes, which would normally have no effect.  Nevertheless, this may be
+useful in the future for compensating for some git bugs or such,
+therefore such a usage is permitted.
 
 *WARNING*! The rewritten history will have different object names for all
 the objects and will not converge with the original branch.  You will not
@@ -43,8 +43,8 @@ if different from the rewritten ones, will be stored in the namespace
 'refs/original/'.
 
 Note that since this operation is extensively I/O expensive, it might
-be a good idea to redirect the temporary directory off-disk, e.g. on
-tmpfs.  Reportedly the speedup is very noticeable.
+be a good idea to redirect the temporary directory off-disk with the
+'-d' option, e.g. on tmpfs.  Reportedly the speedup is very noticeable.
 
 
 Filters
@@ -112,6 +112,9 @@ OPTIONS
 As a special extension, the commit filter may emit multiple
 commit ids; in that case, ancestors of the original commit will
 have all of them as parents.
++
+Note that the 'map' function is not available in the commit filter yet.
+This will be changed in a future version.
 
 --tag-name-filter <command>::
 	This is the filter for rewriting tag names. When passed,
@@ -186,8 +189,8 @@ order to paste the other history behind the current history:
 git filter-branch --parent-filter 'sed "s/^\$/-p <graft-id>/"' HEAD
 -------------------------------------------------------------------
 
-(if the parent string is empty - therefore we are dealing with the
-initial commit - add graftcommit as a parent).  Note that this assumes
+(if the parent string is empty - which happens when we are dealing with
+the initial commit - add graftcommit as a parent).  Note that this assumes
 history with a single root (that is, no merge without common ancestors
 happened).  If this is not the case, use:
 
@@ -232,11 +235,12 @@ range in addition to the new branch name.  The new branch name will
 point to the top-most revision that a 'git rev-list' of this range
 will print.
 
-Note that the changes introduced by the commits, and not reverted by
-subsequent commits, will still be in the rewritten branch. If you want
+*NOTE* the changes introduced by the commits, and which are not reverted
+by subsequent commits, will still be in the rewritten branch. If you want
 to throw out _changes_ together with the commits, you should use the
 interactive mode of gitlink:git-rebase[1].
 
+
 Consider this history:
 
 ------------------
-- 
1.5.3.rc7.18.gc9b59
