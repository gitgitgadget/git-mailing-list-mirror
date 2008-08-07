From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v2] Documentation: filter-branch: document how to filter all refs
Date: Thu,  7 Aug 2008 16:16:03 +0200
Message-ID: <1218118563-28579-1-git-send-email-trast@student.ethz.ch>
References: <1218117841-27398-1-git-send-email-trast@student.ethz.ch>
Cc: gitster@pobox.com, Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Jan Wielemaker <J.Wielemaker@uva.nl>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 07 16:17:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KR6If-00029w-HI
	for gcvg-git-2@gmane.org; Thu, 07 Aug 2008 16:17:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751525AbYHGOQB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Aug 2008 10:16:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751469AbYHGOQB
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Aug 2008 10:16:01 -0400
Received: from xsmtp0.ethz.ch ([82.130.70.14]:12300 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751158AbYHGOQA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Aug 2008 10:16:00 -0400
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 7 Aug 2008 16:15:58 +0200
Received: from localhost.localdomain ([129.132.149.43]) by xfe0.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 7 Aug 2008 16:15:58 +0200
X-Mailer: git-send-email 1.6.0.rc1.106.g98a7
In-Reply-To: <1218117841-27398-1-git-send-email-trast@student.ethz.ch>
X-OriginalArrivalTime: 07 Aug 2008 14:15:58.0810 (UTC) FILETIME=[1D2A7BA0:01C8F898]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91584>

Document the '--' option that can be used to pass rev-list options
(not just arguments), and give an example usage of '-- --all'.  Remove
reference to "the new branch name"; filter-branch takes arbitrary
arguments to rev-list since dfd05e3.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---

At second glance, it turned out the documentation was actually older
than the code.  So rewrite the documentation of <rev-list options>.

 Documentation/git-filter-branch.txt |   21 ++++++++++++++++-----
 1 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-filter-branch.txt b/Documentation/git-filter-branch.txt
index a518ba6..31d3cae 100644
--- a/Documentation/git-filter-branch.txt
+++ b/Documentation/git-filter-branch.txt
@@ -13,7 +13,7 @@ SYNOPSIS
 	[--msg-filter <command>] [--commit-filter <command>]
 	[--tag-name-filter <command>] [--subdirectory-filter <directory>]
 	[--original <namespace>] [-d <directory>] [-f | --force]
-	[<rev-list options>...]
+	[--] [<rev-list options>...]
 
 DESCRIPTION
 -----------
@@ -168,10 +168,10 @@ to other tags will be rewritten to point to the underlying commit.
 	'refs/original/', unless forced.
 
 <rev-list options>...::
-	When options are given after the new branch name, they will
-	be passed to 'git-rev-list'.  Only commits in the resulting
-	output will be filtered, although the filtered commits can still
-	reference parents which are outside of that set.
+	Arguments for 'git-rev-list'.  All positive refs included by
+	these options are rewritten.  You may also specify options
+	such as '--all', but you must use '--' to separate them from
+	the 'git-filter-branch' options.
 
 
 Examples
@@ -196,6 +196,17 @@ git filter-branch --index-filter 'git rm --cached filename' HEAD
 
 Now, you will get the rewritten history saved in HEAD.
 
+To rewrite the repository to look as if 'foodir/' had been its project
+root, and discard all other history:
+
+-------------------------------------------------------
+git filter-branch --subdirectory-filter foodir -- --all
+-------------------------------------------------------
+
+Thus you can, e.g., turn a library subdirectory into a repository of
+its own.  Note the '--' that separates 'filter-branch' options from
+revision options, and the '--all' to rewrite all branches and tags.
+
 To set a commit (which typically is at the tip of another
 history) to be the parent of the current initial commit, in
 order to paste the other history behind the current history:
-- 
1.6.0.rc1.106.g98a7
