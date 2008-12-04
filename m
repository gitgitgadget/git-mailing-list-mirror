From: Junio C Hamano <gitster@pobox.com>
Subject: [RFC/PATCH] Document "git-reset --merge"
Date: Wed, 03 Dec 2008 18:00:12 -0800
Message-ID: <7vprk87l8z.fsf_-_@gitster.siamese.dyndns.org>
References: <alpine.LFD.2.00.0812010908120.3256@nehalem.linux-foundation.org>
 <7vr64oc30p.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.2.00.0812031634520.3256@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Dec 04 03:01:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L83XE-00020Q-Lt
	for gcvg-git-2@gmane.org; Thu, 04 Dec 2008 03:01:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753340AbYLDCAV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Dec 2008 21:00:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752328AbYLDCAV
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Dec 2008 21:00:21 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:43704 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750773AbYLDCAU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Dec 2008 21:00:20 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 3238D84728;
	Wed,  3 Dec 2008 21:00:19 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 3103E84726; Wed,
  3 Dec 2008 21:00:16 -0500 (EST)
In-Reply-To: <alpine.LFD.2.00.0812031634520.3256@nehalem.linux-foundation.org> (Linus
 Torvalds's message of "Wed, 3 Dec 2008 16:39:49 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 4D5287CC-C1A7-11DD-9FC9-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102319>

The commit log message for the feature made it sound as if this is a saner
version of --mixed, but the use case presented makes it clear that it is a
better variant of --hard when your changes and somebody else's changes are
mixed together.

Perhaps we would want to rewrite the example that shows the use of --hard
not to talk about recovering from a failed merge?  

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-reset.txt |   29 ++++++++++++++++++++++++++++-
 1 files changed, 28 insertions(+), 1 deletions(-)

diff --git c/Documentation/git-reset.txt i/Documentation/git-reset.txt
index 52aab5e..c542b0c 100644
--- c/Documentation/git-reset.txt
+++ i/Documentation/git-reset.txt
@@ -8,7 +8,7 @@ git-reset - Reset current HEAD to the specified state
 SYNOPSIS
 --------
 [verse]
-'git reset' [--mixed | --soft | --hard] [-q] [<commit>]
+'git reset' [--mixed | --soft | --hard | --merge] [-q] [<commit>]
 'git reset' [-q] [<commit>] [--] <paths>...
 
 DESCRIPTION
@@ -45,6 +45,11 @@ OPTIONS
 	switched to. Any changes to tracked files in the working tree
 	since <commit> are lost.
 
+--merge::
+	Resets the index to match the tree recorded by the named commit,
+	and updates the files that are different between the named commit
+	and the current commit in the working tree.
+
 -q::
 	Be quiet, only report errors.
 
@@ -152,6 +157,28 @@ tip of the current branch in ORIG_HEAD, so resetting hard to it
 brings your index file and the working tree back to that state,
 and resets the tip of the branch to that commit.
 
+Undo a merge or pull inside a dirty work tree::
++
+------------
+$ git pull                         <1>
+Auto-merging nitfol
+Merge made by recursive.
+ nitfol                |   20 +++++----
+ ...
+$ git reset --merge ORIG_HEAD      <2>
+------------
++
+<1> Even if you may have local modifications in your
+working tree, you can safely say "git pull" when you know
+that the change in the other branch does not overlap with
+them.
+<2> After inspecting the result of the merge, you may find
+that the change in the other branch is unsatisfactory.  Running
+"git reset --hard ORIG_HEAD" will let you go back to where you
+were, but it will discard your local changes, which you do not
+want.  "git reset --merge" keeps your local changes.
+
+
 Interrupted workflow::
 +
 Suppose you are interrupted by an urgent fix request while you
