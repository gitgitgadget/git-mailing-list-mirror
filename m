From: Junio C Hamano <junkio@cox.net>
Subject: Re: bad git pull
Date: Fri, 16 Dec 2005 18:19:09 -0800
Message-ID: <7vlkykbh42.fsf@assigned-by-dhcp.cox.net>
References: <68948ca0512151537v2d8f22c8x962c55bd507af8cf@mail.gmail.com>
	<7vzmn2kjw1.fsf@assigned-by-dhcp.cox.net>
	<7vu0d9lxx9.fsf@assigned-by-dhcp.cox.net>
	<118833cc0512161007k38fdd15w2dcdf0c93f26d29e@mail.gmail.com>
	<7vfyoshmp6.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0512161347490.3698@g5.osdl.org>
	<118833cc0512161637v1d180f9fh66a7dc6d3fe11d2b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, Don Zickus <dzickus@gmail.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 17 03:20:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EnRfY-0006ia-Pd
	for gcvg-git@gmane.org; Sat, 17 Dec 2005 03:19:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964912AbVLQCTM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Dec 2005 21:19:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751358AbVLQCTM
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Dec 2005 21:19:12 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:36574 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1751357AbVLQCTL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Dec 2005 21:19:11 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051217021713.KXQY20050.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 16 Dec 2005 21:17:13 -0500
To: Morten Welinder <mwelinder@gmail.com>
In-Reply-To: <118833cc0512161637v1d180f9fh66a7dc6d3fe11d2b@mail.gmail.com>
	(Morten Welinder's message of "Fri, 16 Dec 2005 19:37:18 -0500")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13768>

Morten Welinder <mwelinder@gmail.com> writes:

>>  - undo the last commit entirely ("hard reset to previous state"):
>>
>>  - undo the last pull ("bk unpull"): "hard reset to ORIG_HEAD":
>
> It would be outright peachy if Documentation/git-commit.txt and
> Documentation/git-pull.txt mentioned these.  That is certainly
> where I would look first to answer the "what if I screwed up?"
> question.

Yup.  Maybe one line comment at the bottom of these manual pages
pointing at git-reset manual page (which has nice examples
section) would be good enough?

-- >8 --
[PATCH] Examples of resetting.

Morten Welinder says examples of resetting is really about
recovering from botched commit/pulls.  I agree that pointers
from commands that cause a reset to be needed in the first place
would be very helpful.

Also reset examples did not mention "pull/merge" cases.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index b92cf48..8b91f22 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -66,6 +66,10 @@ OPTIONS
 	Update specified paths in the index file before committing.
 
 
+If you make a commit and then found a mistake immediately after
+that, you can recover from it with gitlink:git-reset[1].
+
+
 Author
 ------
 Written by Linus Torvalds <torvalds@osdl.org> and
diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index 0cac563..4ce799b 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -37,6 +37,11 @@ include::merge-options.txt[]
 include::merge-strategies.txt[]
 
 
+If you tried a merge which resulted in a complex conflicts and
+would want to start over, you can recover with
+gitlink:git-reset[1].
+
+
 HOW MERGE WORKS
 ---------------
 
diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
index c65ca9a..3a7d385 100644
--- a/Documentation/git-pull.txt
+++ b/Documentation/git-pull.txt
@@ -104,6 +104,11 @@ merge the remote `origin` head into the 
 local `master` branch.
 
 
+If you tried a pull which resulted in a complex conflicts and
+would want to start over, you can recover with
+gitlink:git-reset[1].
+
+
 SEE ALSO
 --------
 gitlink:git-fetch[1], gitlink:git-merge[1]
diff --git a/Documentation/git-reset.txt b/Documentation/git-reset.txt
index 0204891..c6a269b 100644
--- a/Documentation/git-reset.txt
+++ b/Documentation/git-reset.txt
@@ -111,6 +111,39 @@ remain there.
 changes still in the working tree.
 ------------
 
+Undo a merge or pull::
++
+------------
+$ git pull <1>
+Trying really trivial in-index merge...
+fatal: Merge requires file-level merging
+Nope.
+...
+Auto-merging nitfol
+CONFLICT (content): Merge conflict in nitfol
+Automatic merge failed/prevented; fix up by hand
+$ git reset --hard <2>
+
+<1> try to update from the upstream resulted in a lot of
+conflicts; you were not ready to spend a lot of time merging
+right now, so you decide to do that later.
+<2> "pull" has not made merge commit, so "git reset --hard"
+which is a synonym for "git reset --hard HEAD" clears the mess
+from the index file and the working tree.
+
+$ git pull . topic/branch <3>
+Updating from 41223... to 13134...
+Fast forward
+$ git reset --hard ORIG_HEAD <4>
+
+<3> merge a topic branch into the current branch, which resulted
+in a fast forward.
+<4> but you decided that the topic branch is not ready for public
+consumption yet.  "pull" or "merge" always leaves the original
+tip of the current branch in ORIG_HEAD, so resetting hard to it
+brings your index file and the working tree back to that state,
+and resets the tip of the branch to that commit.
+------------
 
 Author
 ------
