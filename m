X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: [PATCH] Documentation: clarify tutorial pull/merge discussion
Date: Sat, 25 Nov 2006 22:45:02 -0500
Message-ID: <20061126034502.GA3782@fieldses.org>
References: <20061123203950.5d47421f@paolo-desktop> <20061124161144.GA19708@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sun, 26 Nov 2006 03:45:25 +0000 (UTC)
Cc: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <20061124161144.GA19708@fieldses.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32322>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GoAxE-0001hf-Ic for gcvg-git@gmane.org; Sun, 26 Nov
 2006 04:45:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S967283AbWKZDpI (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 25 Nov 2006
 22:45:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967257AbWKZDpI
 (ORCPT <rfc822;git-outgoing>); Sat, 25 Nov 2006 22:45:08 -0500
Received: from mail.fieldses.org ([66.93.2.214]:26553 "EHLO
 pickle.fieldses.org") by vger.kernel.org with ESMTP id S967283AbWKZDpF (ORCPT
 <rfc822;git@vger.kernel.org>); Sat, 25 Nov 2006 22:45:05 -0500
Received: from bfields by pickle.fieldses.org with local (Exim 4.63)
 (envelope-from <bfields@fieldses.org>) id 1GoAww-0001Nr-Qn; Sat, 25 Nov 2006
 22:45:02 -0500
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Attempt to clarify somewhat the difference between pull and merge,
and give a little more details on the pull syntax.

I'm still not happy with this section: the explanation of the origin
branch isn't great, but maybe that should be left alone pending the
use-separate-remotes change; and we need to explain how to set up a
public repository and push to it.

Signed-off-by: J. Bruce Fields <bfields@citi.umich.edu>
---
 Documentation/tutorial.txt |   41 ++++++++++++++++++++++++++---------------
 1 files changed, 26 insertions(+), 15 deletions(-)

diff --git a/Documentation/tutorial.txt b/Documentation/tutorial.txt
index 1e4ddfb..35af81a 100644
--- a/Documentation/tutorial.txt
+++ b/Documentation/tutorial.txt
@@ -209,29 +209,28 @@ at /home/bob/myrepo.  She does this with
 
 ------------------------------------------------
 $ cd /home/alice/project
-$ git pull /home/bob/myrepo
+$ git pull /home/bob/myrepo master
 ------------------------------------------------
 
-This actually pulls changes from the branch in Bob's repository named
-"master".  Alice could request a different branch by adding the name
-of the branch to the end of the git pull command line.
+This merges the changes from Bob's "master" branch into Alice's
+current branch.  If Alice has made her own changes in the meantime,
+then she may need to manually fix any conflicts.  (Note that the
+"master" argument in the above command is actually unnecessary, as it
+is the default.)
 
-This merges Bob's changes into her repository; "git log" will
-now show the new commits.  If Alice has made her own changes in the
-meantime, then Bob's changes will be merged in, and she will need to
-manually fix any conflicts.
+The "pull" command thus performs two operations: it fetches changes
+from a remote branch, then merges them into the current branch.
 
-A more cautious Alice might wish to examine Bob's changes before
-pulling them.  She can do this by creating a temporary branch just
-for the purpose of studying Bob's changes:
+You can perform the first operation alone using the "git fetch"
+command.  For example, Alice could create a temporary branch just to
+track Bob's changes, without merging them with her own, using:
 
 -------------------------------------
 $ git fetch /home/bob/myrepo master:bob-incoming
 -------------------------------------
 
 which fetches the changes from Bob's master branch into a new branch
-named bob-incoming.  (Unlike git pull, git fetch just fetches a copy
-of Bob's line of development without doing any merging).  Then
+named bob-incoming.  Then
 
 -------------------------------------
 $ git log -p master..bob-incoming
@@ -240,8 +239,8 @@ $ git log -p master..bob-incoming
 shows a list of all the changes that Bob made since he branched from
 Alice's master branch.
 
-After examining those changes, and possibly fixing things, Alice can
-pull the changes into her master branch:
+After examining those changes, and possibly fixing things, Alice
+could pull the changes into her master branch:
 
 -------------------------------------
 $ git checkout master
@@ -251,6 +250,18 @@ $ git pull . bob-incoming
 The last command is a pull from the "bob-incoming" branch in Alice's
 own repository.
 
+Alice could also perform both steps at once with:
+
+-------------------------------------
+$ git pull /home/bob/myrepo master:bob-incoming
+-------------------------------------
+
+This is just like the "git pull /home/bob/myrepo master" that we saw
+before, except that it also stores the unmerged changes from bob's
+master branch in bob-incoming before merging them into Alice's
+current branch.  Note that git pull always merges into the current
+branch, regardless of what else is given on the commandline.
+
 Later, Bob can update his repo with Alice's latest changes using
 
 -------------------------------------
-- 
1.4.4.rc1.g83ee9
