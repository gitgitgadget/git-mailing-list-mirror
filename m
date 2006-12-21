From: Sean <seanlkml@sympatico.ca>
Subject: [PATCH] Attempt to make git-checkout man page a bit more clear.
Date: Thu, 21 Dec 2006 01:53:50 -0500
Message-ID: <20061221015350.245cc964.seanlkml@sympatico.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Dec 21 07:54:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxHoS-0000US-Gr
	for gcvg-git@gmane.org; Thu, 21 Dec 2006 07:53:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422745AbWLUGxx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Dec 2006 01:53:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422765AbWLUGxx
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Dec 2006 01:53:53 -0500
Received: from bayc1-pasmtp01.bayc1.hotmail.com ([65.54.191.161]:25449 "EHLO
	BAYC1-PASMTP01.CEZ.ICE" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1422745AbWLUGxw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Dec 2006 01:53:52 -0500
X-Originating-IP: [65.93.43.74]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([65.93.43.74]) by BAYC1-PASMTP01.CEZ.ICE over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Wed, 20 Dec 2006 22:53:51 -0800
Received: from guru.attic.local ([10.10.10.28])
	by linux1.attic.local with esmtp (Exim 4.43)
	id 1GxGsG-0005ij-0a
	for git@vger.kernel.org; Thu, 21 Dec 2006 00:53:48 -0500
To: git@vger.kernel.org
X-Mailer: Sylpheed version 2.2.10 (GTK+ 2.10.4; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 21 Dec 2006 06:53:52.0206 (UTC) FILETIME=[C64AAEE0:01C724CC]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35018>

Signed-off-by: Sean Estabrooks <seanlkml@sympatico.ca>
---
 Documentation/git-checkout.txt |   40 +++++++++++++++++++++++++++-------------
 1 files changed, 27 insertions(+), 13 deletions(-)


A recent question on another list, quoted below, shows a
new git user getting stuck on something pretty simple:

>> I'm after all the source of the drm 2.3.0 release.
>>
>> How do I use git to get all the source that drm-2.3.0 tags?
>> I need the kernel drivers as well as the user land code
>> so the tarball is no use to me.
>>
>> All the git docs tell me how to create a tag, but I have not
>> found a single use show how to get a tree of files that correspond
>> to a tag.

Hopefully this patch is accurate and would help a bit.

Sean


diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index fbdbadc..97c3afe 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -8,23 +8,29 @@ git-checkout - Checkout and switch to a branch
 SYNOPSIS
 --------
 [verse]
-'git-checkout' [-f] [-b <new_branch> [-l]] [-m] [<branch>]
+'git-checkout' [-f] [-m] <branch>
+'git-checkout' [-f] [-b <new_branch> [-l]] [-m] [<commit-ish>]
 'git-checkout' [-m] [<branch>] <paths>...
 
 DESCRIPTION
 -----------
 
-When <paths> are not given, this command switches branches by
-updating the index and working tree to reflect the specified
-branch, <branch>, and updating HEAD to be <branch> or, if
-specified, <new_branch>.  Using -b will cause <new_branch> to
-be created.
-
-When <paths> are given, this command does *not* switch
-branches.  It updates the named paths in the working tree from
-the index file (i.e. it runs `git-checkout-index -f -u`).  In
-this case, `-f` and `-b` options are meaningless and giving
-either of them results in an error.  <branch> argument can be
+Checkout the given branch, populating your working tree with its
+contents.  In the first form listed above, this command only
+allows you to checkout an existing branch, not an arbitrary point
+from the history.  You can use the git-branch command to create
+such branches.
+
+The second form of the command allows you to create a new branch
+and check it out in one step.  You specify the new branch name
+with the "-b" option, followed by a reference to the commit that
+will become the HEAD of the new branch.  Note that you can specify
+this commit by tag name, an existing branch name, or any other
+reference specification git allows.
+
+With the third form, this command does *not* switch branches.
+Instead, it replaces the contents of the named paths in your
+working tree from the index.  Here, the <branch> argument can be
 used to specify a specific tree-ish to update the index for the
 given paths before updating the working tree.
 
@@ -32,7 +38,8 @@ given paths before updating the working tree.
 OPTIONS
 -------
 -f::
-	Force a re-read of everything.
+	Force a switch to the given branch even when uncommitted
+	changes in your working tree will be lost as a result.
 
 -b::
 	Create a new branch named <new_branch> and start it at
@@ -92,6 +99,13 @@ You should instead write:
 $ git checkout -- hello.c
 ------------
 
+. To create a branch based on the contents marked by a given tag
+and check it out in a single step:
++
+------------
+$ git checkout -b newbranch tag1.2.3
+------------
+
 . After working in a wrong branch, switching to the correct
 branch would be done using:
 +
-- 
1.4.4.2.g8336
