From: Junio C Hamano <junkio@cox.net>
Subject: Re: documentation issues
Date: Thu, 01 Dec 2005 13:34:55 -0800
Message-ID: <7v64q8fqm8.fsf@assigned-by-dhcp.cox.net>
References: <438F5D05.4080101@citi.umich.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 01 22:37:52 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ehw5C-0004NE-Jk
	for gcvg-git@gmane.org; Thu, 01 Dec 2005 22:35:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932487AbVLAVe6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Dec 2005 16:34:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932489AbVLAVe5
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Dec 2005 16:34:57 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:48012 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S932487AbVLAVe5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Dec 2005 16:34:57 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051201213410.YYWY20441.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 1 Dec 2005 16:34:10 -0500
To: cel@citi.umich.edu
In-Reply-To: <438F5D05.4080101@citi.umich.edu> (Chuck Lever's message of "Thu,
	01 Dec 2005 15:28:53 -0500")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13075>

Chuck Lever <cel@citi.umich.edu> writes:

> in the man page for git-diff-index (posted here):
>
>   http://www.kernel.org/pub/software/scm/git/docs/git-diff-tree.html

You mean git-diff-index.html, not diff-tree.html, I suppose.

> there are several references to "git-diff-tree" where it seems like 
> "git-diff-index" is really meant.

    Non-cached Mode
    ---------------
    The "non-cached" mode takes a different approach, and is potentially
    the more useful of the two in that what it does can't be emulated with
    a "git-write-tree" + "git-diff-tree". Thus that's the default mode.
    ...
    The non-cached version asks the question:

      show me the differences between HEAD and the currently checked out
      tree - index contents _and_ files that aren't up-to-date

    which is obviously a very useful question too, since that tells you what
    you *could* commit. Again, the output matches the "git-diff-tree -r"
    output to a tee, but with a twist.

Linus does mean diff-tree here.

We had diff-files and diff-tree back then, but diff-index came
much later under the name diff-cache.  He is explaining what
git-diff-index does in terms of git-diff-tree in this paragraph.

He could have said:

    You *could* emulate it with first copying the index file
    into a temporary file, git-update-index all the modified
    paths in the working tree into that temporary index file and
    git-write-tree that, and then run git-diff-tree.

but that is not practical.

> also, git-diff-index supports a "-r" option, but that doesn't seem to be 
> documented on this page.

What Chris Shoemaker said is right.

But we could do this instead if you want.  I am neutral myself.

-- >8 --
[PATCH] Documentation: mention -r for all commands from the diff family.

We did not mention 'git-diff-index' and friends take '-r' but
silently ignore it, because they always operate on the whole tree.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---
diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 6b496ed..7299903 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -58,5 +58,11 @@
 	Swap two inputs; that is, show differences from index or
 	on-disk file to tree contents.
 
+-r::
+        Recurse into sub-trees.  Note that this makes difference
+        only with `git-diff-tree`.  Other commands in the `git-diff-\*`
+        family always operate on the whole project tree and this
+        option is a no-op to them.
+
 For more detailed explanation on these common options, see also
 link:diffcore.html[diffcore documentation].
diff --git a/Documentation/git-diff-tree.txt b/Documentation/git-diff-tree.txt
index 9a2947e..8f66119 100644
--- a/Documentation/git-diff-tree.txt
+++ b/Documentation/git-diff-tree.txt
@@ -33,9 +33,6 @@ include::diff-options.txt[]
 	Note that this parameter does not provide any wildcard or regexp
 	features.
 
--r::
-        recurse into sub-trees
-
 -t::
 	show tree entry itself as well as subtrees.  Implies -r.
 
