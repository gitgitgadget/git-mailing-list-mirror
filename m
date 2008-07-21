From: Jonathan Nieder <jrnieder@uchicago.edu>
Subject: [PATCH] bring description of git diff --cc up to date
Date: Mon, 21 Jul 2008 13:27:23 -0500 (CDT)
Message-ID: <Pine.GSO.4.62.0807211316530.2841@harper.uchicago.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: David Greaves <david@dgreaves.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 21 20:28:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KL07Y-0006wP-AY
	for gcvg-git-2@gmane.org; Mon, 21 Jul 2008 20:28:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751610AbYGUS12 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jul 2008 14:27:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751440AbYGUS12
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jul 2008 14:27:28 -0400
Received: from smtp02.uchicago.edu ([128.135.12.75]:36855 "EHLO
	smtp02.uchicago.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750836AbYGUS11 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jul 2008 14:27:27 -0400
Received: from harper.uchicago.edu (harper.uchicago.edu [128.135.12.7])
	by smtp02.uchicago.edu (8.13.8/8.13.8) with ESMTP id m6LIRNgB003442;
	Mon, 21 Jul 2008 13:27:23 -0500
Received: from localhost (jrnieder@localhost)
	by harper.uchicago.edu (8.12.10/8.12.10) with ESMTP id m6LIRNqj003243;
	Mon, 21 Jul 2008 13:27:23 -0500 (CDT)
X-Authentication-Warning: harper.uchicago.edu: jrnieder owned process doing -bs
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89381>

In February 2006 [1], the behavior of diff --cc was changed to
fit a more appropriate notion of "interesting hunks" in Octopus
merges.  This patch updates documentation accordingly.

[1] commit bf1c32bdec8223785c779779d0a660a099f69a63
    combine-diff: update --cc "uninteresting hunks" logic

Signed-off-by: Jonathan Nieder <jrnieder@uchicago.edu>
---
	Hello, all.  A while ago when someone was asking about the diff
	--cc output, I noticed some mistakes in the documentation but
	never got around to fixing them.  So here's a small fix.  After
	this patch, many issues remain:

	 - The user would usually look to git-diff(1) or git-log(1) for
	   an explanation of the --cc option, not git-diff-tree(1) or
	   git-rev-list(1).
	 - diff-format.txt contains the cryptic text "Note that
	   'combined diff' lists only files which were modified from
	   all parents."  I have no idea what that means.
	 - There is some duplication of text between git-diff-tree(1)
	   and git-rev-list(1) here.  I don't think that's such a big
	   deal, though.
	 - My proposed text here is not very intuitive or clear, and it
	   does not suggest very strongly what --cc is intended to do
	   (to point out "evil merges" and other merges where the
	   integrator is likely to have made a mistake).  Alternate
	   wordings welcome!

	At least this patch would not makes matters worse.

 Documentation/git-diff-tree.txt    |   12 +++++++-----
 Documentation/rev-list-options.txt |    9 +++++----
 2 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-diff-tree.txt b/Documentation/git-diff-tree.txt
index 0e45b58..5a81d5d 100644
--- a/Documentation/git-diff-tree.txt
+++ b/Documentation/git-diff-tree.txt
@@ -92,12 +92,14 @@ include::pretty-options.txt[]
 --cc::
 	This flag changes the way a merge commit patch is displayed,
 	in a similar way to the '-c' option. It implies the '-c'
-	and '-p' options and further compresses the patch output
-	by omitting hunks that show differences from only one
-	parent, or show the same change from all but one parent
-	for an Octopus merge.  When this optimization makes all
+	and '-p' options and makes the patch output
+	even more compact by omitting uninteresting hunks.  A hunk is
+	considered interesting only if either (a) it shows changes from
+	all parents or (b) in an Octopus merge, it shows different changes
+	from at least three different parents.
+	When this optimization makes all
 	hunks disappear, the commit itself and the commit log
-	message is not shown, just like in any other "empty diff" case.
+	message are not shown, just like in any other "empty diff" case.
 
 --always::
 	Show the commit itself and the commit log message even
diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index b6f5d87..a399e2b 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -111,10 +111,11 @@ options may be given. See linkgit:git-diff-files[1] for more options.
 
 --cc::
 
-	This flag implies the '-c' options and further compresses the
-	patch output by omitting hunks that show differences from only
-	one parent, or show the same change from all but one parent for
-	an Octopus merge.
+	This flag implies the '-c' option and makes the patch output
+	even more compact by omitting uninteresting hunks.  A hunk is
+	considered interesting only if either (a) it shows changes from
+	all parents or (b) in an Octopus merge, it shows different changes
+	from at least three different parents.
 
 -r::
 
-- 
1.5.6.3.549.g8ca11
