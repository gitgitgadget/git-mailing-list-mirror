From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH] Improve the git-diff-tree -c/-cc documentation
Date: Sun, 9 Apr 2006 15:43:17 +0200
Message-ID: <20060409134317.GV27689@pasky.or.cz>
References: <20060326102100.GF18185@pasky.or.cz> <7vslonaxq6.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 09 15:43:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FSaCT-0003JR-NP
	for gcvg-git@gmane.org; Sun, 09 Apr 2006 15:43:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750749AbWDINnW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 9 Apr 2006 09:43:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750750AbWDINnW
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Apr 2006 09:43:22 -0400
Received: from w241.dkm.cz ([62.24.88.241]:5839 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1750749AbWDINnW (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 9 Apr 2006 09:43:22 -0400
Received: (qmail 16791 invoked by uid 2001); 9 Apr 2006 15:43:17 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vslonaxq6.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18546>

Dear diary, on Sun, Apr 09, 2006 at 11:45:37AM CEST, I got a letter
where Junio C Hamano <junkio@cox.net> said that...
> Petr Baudis <pasky@ucw.cz> writes:
> 
> >   Now, the -c option documentation says:
> >
> > 	  It shows the differences from each of the parents to the merge
> > 	result simultaneously, instead of showing pairwise diff between
> > 	a parent and the result one at a time, which '-m' option output
> > 	does.
> >
> >   This sounds as exactly what I want. Well, the only problem is that the
> > same diff command as above with -c option added produces no diff at all,
> > just the header and commit messages. Did I misunderstand the -c
> > description and does it do something different?
> 
> The --combined diff option is to show merges more sensibly than
> plain -m option.  Now, the definition of "sensible" is to say
> that a merge is not interesting if it takes a version from one
> of the parents.  The paths whose results do not match any of the
> parents' version are deemed interesting and are shown.
> 
> I think you could tweak and give an option to intersect_paths()
> in combine-diff.c, so that paths that match one of the parents
> are also included in the output.  I haven't thought about it too
> much, but my gut feeling is it would not be very involved
> change.

Aha, thanks! I actually think this is more sensible to do, so now I'm
only pondering if in cg-log -f it is more useful to show the list of
files changed relative to the first parent or the files which were
subjected to a content merge...

---
This tries to clarify the -c/-cc documentation and clean up the style and
grammar.

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 Documentation/git-diff-tree.txt |   25 ++++++++++++++++---------
 1 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-diff-tree.txt b/Documentation/git-diff-tree.txt
index 9153e4c..d7e529b 100644
--- a/Documentation/git-diff-tree.txt
+++ b/Documentation/git-diff-tree.txt
@@ -60,7 +60,8 @@ separated with a single space are given.
 -m::
 	By default, "git-diff-tree --stdin" does not show
 	differences for merge commits.  With this flag, it shows
-	differences to that commit from all of its parents.
+	differences to that commit from all of its parents. See
+	also '-c'.
 
 -s::
 	By default, "git-diff-tree --stdin" shows differences,
@@ -81,19 +82,25 @@ separated with a single space are given.
 	git-diff-tree outputs a line with the commit ID when
 	applicable.  This flag suppressed the commit ID output.
 
--c,--cc::
-	These flags change the way a merge commit is displayed
+-c::
+	This flag changes the way a merge commit is displayed
 	(which means it is useful only when the command is given
 	one <tree-ish>, or '--stdin').  It shows the differences
-	from each of the parents to the merge result
-	simultaneously, instead of showing pairwise diff between
-	a parent and the result one at a time, which '-m' option
-	output does.  '--cc' further compresses the output by
-	omiting hunks that show differences from only one
+	from each of the parents to the merge result simultaneously
+	instead of showing pairwise diff between a parent and the
+	result one at a time (which is what the '-m' option does).
+	Furthermore, it lists only files which were modified
+	in both parents.
+
+-cc::
+	This flag changes the way a merge commit patch is displayed,
+	in a similar way to the '-c' option. It implies the '-c'
+	and '-p' options and further compresses the patch output
+	by omitting hunks that show differences from only one
 	parent, or show the same change from all but one parent
 	for an Octopus merge.  When this optimization makes all
 	hunks disappear, the commit itself and the commit log
-	message is not shown, just like any other "empty diff" cases.
+	message is not shown, just like in any other "empty diff" case.
 
 --always::
 	Show the commit itself and the commit log message even


-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Right now I am having amnesia and deja-vu at the same time.  I think
I have forgotten this before.
