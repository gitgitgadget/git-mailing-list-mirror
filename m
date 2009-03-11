From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH] Documentation: filter-branch: show --ignore-unmatch in main index-filter example
Date: Thu, 12 Mar 2009 00:00:56 +0100
Message-ID: <fc756c64020427c7bff3a9d9a41c4842b1c13acb.1236812339.git.trast@student.ethz.ch>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 12 00:28:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhXRx-0006yF-CP
	for gcvg-git-2@gmane.org; Thu, 12 Mar 2009 00:02:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752088AbZCKXB2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Mar 2009 19:01:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751905AbZCKXB2
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Mar 2009 19:01:28 -0400
Received: from xsmtp0.ethz.ch ([82.130.70.14]:55977 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750742AbZCKXB2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Mar 2009 19:01:28 -0400
Received: from xfe1.d.ethz.ch ([82.130.124.41]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 12 Mar 2009 00:01:25 +0100
Received: from localhost.localdomain ([84.75.148.224]) by xfe1.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 12 Mar 2009 00:01:25 +0100
X-Mailer: git-send-email 1.6.2.489.g51f6b7
X-OriginalArrivalTime: 11 Mar 2009 23:01:25.0182 (UTC) FILETIME=[4D9315E0:01C9A29D]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112989>

Rearrange the example usage of

  git filter-branch --index-filter 'git rm --cached ...'

so that --ignore-unmatch is in the main example block.  People keep
stumbling over the (lack of this) option to the point where it is a
FAQ, so we would want to expose the most common usage where it stands
out.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---

This actually came up once again on IRC about a week ago, but the doc
change sank somewhere deep into my todo stack.

Arguably the --tree-filter 'rm filename' example should get the same
treatment, but I can't find a nice way to do so without harming the
flow of thought in the example development.


 Documentation/git-filter-branch.txt |   17 +++++++++--------
 1 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-filter-branch.txt b/Documentation/git-filter-branch.txt
index 7ffe03f..237f85e 100644
--- a/Documentation/git-filter-branch.txt
+++ b/Documentation/git-filter-branch.txt
@@ -91,7 +91,9 @@ OPTIONS
 --index-filter <command>::
 	This is the filter for rewriting the index.  It is similar to the
 	tree filter but does not check out the tree, which makes it much
-	faster.  For hairy cases, see linkgit:git-update-index[1].
+	faster.  Frequently used with `git rm \--cached
+	\--ignore-unmatch ...`, see EXAMPLES below.  For hairy
+	cases, see linkgit:git-update-index[1].
 
 --parent-filter <command>::
 	This is the filter for rewriting the commit's parent list.
@@ -204,19 +206,18 @@ However, if the file is absent from the tree of some commit,
 a simple `rm filename` will fail for that tree and commit.
 Thus you may instead want to use `rm -f filename` as the script.
 
-A significantly faster version:
+Using `\--index-filter` with 'git-rm' yields a significantly faster
+version.  Like with using `rm filename`, `git rm --cached filename`
+will fail if the file is absent from the tree of a commit.  If you
+want to "completely forget" a file, it does not matter when it entered
+history, so we also add `\--ignore-unmatch`:
 
 --------------------------------------------------------------------------
-git filter-branch --index-filter 'git rm --cached filename' HEAD
+git filter-branch --index-filter 'git rm --cached --ignore-unmatch filename' HEAD
 --------------------------------------------------------------------------
 
 Now, you will get the rewritten history saved in HEAD.
 
-As with using `rm filename`, `git rm --cached filename` will fail
-if the file is absent from the tree of a commit.  If it is not important
-whether the file is already absent from the tree, you can use
-`git rm --cached --ignore-unmatch filename` instead.
-
 To rewrite the repository to look as if `foodir/` had been its project
 root, and discard all other history:
 
-- 
1.6.2.489.g51f6b7
