From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH] Documentation: clarify git-mv behaviour wrt dirty files
Date: Wed, 3 Feb 2010 22:12:12 +0100
Message-ID: <c43166fa73391a40b43c27153ec142121fdb71d1.1265231310.git.trast@student.ethz.ch>
References: <ron1-A681F2.12340503022010@news.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Ron Garret <ron1@flownet.com>, Avery Pennarun <apenwarr@gmail.com>,
	Pete Harlan <pgit@pcharlan.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Feb 03 22:12:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NcmWM-0002ss-CM
	for gcvg-git-2@lo.gmane.org; Wed, 03 Feb 2010 22:12:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932920Ab0BCVMQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Feb 2010 16:12:16 -0500
Received: from gwse.ethz.ch ([129.132.178.237]:25827 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932909Ab0BCVMP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Feb 2010 16:12:15 -0500
Received: from CAS01.d.ethz.ch (129.132.178.235) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.234.1; Wed, 3 Feb
 2010 22:12:13 +0100
Received: from localhost.localdomain (84.74.100.59) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.234.1; Wed, 3 Feb
 2010 22:12:13 +0100
X-Mailer: git-send-email 1.7.0.rc1.166.g7cae7
In-Reply-To: <ron1-A681F2.12340503022010@news.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138900>

Clearly point out that the rename happens separately for worktree and
index.  This confused users, as they are apparently told that git-mv
== git-rm && mv && git-add, which it is not.

While there, move the synposis to the synopsis section, which so far
was rather useless, and reword the first sentence to eliminate the
mentions of 'script'.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---

Ron, please don't drop the Cc lists, it's customary around here to Cc
everyone involved so far.

On Wednesday 03 February 2010 21:34:05 you wrote:
> In article <4B69D897.2060908@pcharlan.com>,
>  Pete Harlan <pgit@pcharlan.com> wrote:
> > Unlike "git rm", "git mv" could still perform the operation even without
> > "-f", but the semantics of "git mv" differ enough from plain "mv" that a
> > short blurb from Git in that case might help.
> 
> I think that a simple tweak to the docs would be enough.  Right now it 
> says:
> 
> "The index is updated after successful completion, but the change must 
> still be committed."
> 
> I'm pretty sure I would have been less confused if it had said something 
> like:
> 
> "The index is updated to reflect the new name of the file, but NOT any 
> new content that file may contain.  Changed content must be added to the 
> index separately with git add, and all changes must still be commited."

How about this change instead, which formulates it in terms of what
does happen, instead of what does not.

BTW, I'm wondering whether the "move or rename" distinction is really
worth it.  Does the user care?  I always figured it was a technical
detail whether rename() works or you actually need to move anything.


 Documentation/git-mv.txt |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-mv.txt b/Documentation/git-mv.txt
index bdcb585..eff11b7 100644
--- a/Documentation/git-mv.txt
+++ b/Documentation/git-mv.txt
@@ -8,22 +8,22 @@ git-mv - Move or rename a file, a directory, or a symlink
 
 SYNOPSIS
 --------
-'git mv' <options>... <args>...
+'git mv' [-f] [-n] <source> <destination>
+'git mv' [-f] [-n] [-k] <source>... <destination directory>
 
 DESCRIPTION
 -----------
-This script is used to move or rename a file, directory or symlink.
-
- git mv [-f] [-n] <source> <destination>
- git mv [-f] [-n] [-k] <source> ... <destination directory>
+'git-mv' renames files, directories, and symlinks in worktree and
+index.
 
 In the first form, it renames <source>, which must exist and be either
 a file, symlink or directory, to <destination>.
 In the second form, the last argument has to be an existing
 directory; the given sources will be moved into this directory.
 
-The index is updated after successful completion, but the change must still be
-committed.
+For every renamed file or symlink, the worktree and index contents are
+renamed separately, preserving both staged and unstaged changes.  You
+will still have to commit the rename.
 
 OPTIONS
 -------
-- 
1.7.0.rc1.166.g7cae7
