From: Junio C Hamano <junkio@cox.net>
Subject: Re: RFE: git rm
Date: Mon, 24 Oct 2005 15:11:16 -0700
Message-ID: <7vr7aalg57.fsf@assigned-by-dhcp.cox.net>
References: <435D2FE0.3060307@pobox.com>
	<7virvmodhz.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0510241725370.25300@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 25 00:12:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EUAXR-0006ve-K4
	for gcvg-git@gmane.org; Tue, 25 Oct 2005 00:11:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750716AbVJXWLW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 24 Oct 2005 18:11:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751106AbVJXWLU
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Oct 2005 18:11:20 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:29400 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1750897AbVJXWLS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Oct 2005 18:11:18 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051024221059.BOAH9394.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 24 Oct 2005 18:10:59 -0400
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.64.0510241725370.25300@iabervon.org> (Daniel
	Barkalow's message of "Mon, 24 Oct 2005 17:38:25 -0400 (EDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10564>

Daniel Barkalow <barkalow@iabervon.org> writes:

> I often do "git add something" when I happen to think of it, not 
> necessarily right before committing, which means that I have these files 
> changed in my index while working. I may quit this, however, now that git 
> status lists the ones I missed.

Oh, I do 'git add' myself; otherwise I'd surely forget by the
time I commit.

And I did not mean to tell you to quit doing it.  If any of you
took what I said as "Linus does not do it, I do not do it, so
you should not be doing update-index in the middle", then that
was not my intention and I apologize for causing confusion.

I think update-index in the middle is a valid workflow.  The
only drawback I can think of is that you cannot merge or apply
others' patches once you do it until you commit.  I was just
curious how people use git, weighing the pros and cons of that
(pros: git-diff-files is easier to read and the index gives you
a good anchoring point; cons: you cannot do merge or patch
application).

> Incidentally, the new git status entry for --others really ought to say 
> something different from "Ignored files", like "Exist but not tracked", 
> since it doesn't include the contents of .gitignore, which you'd expect to 
> be "Ignored". (And, of course, any files it lists are hardly being 
> ignored.)

Good point.  Something like this?

 ------------
Clarify git status output.

What we list as "Ignored files" are not "ignored".  Rather, it
is the list of "not listed in the to-be-ignored files, but
exists -- you may be forgetting to add them".

Pointed out by Daniel.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---
diff --git a/git-status.sh b/git-status.sh
index 29c2b11..62a24a9 100755
--- a/git-status.sh
+++ b/git-status.sh
@@ -90,7 +90,7 @@ perl -e '$/ = "\0";
 		s|\n|\\n|g;
 		s/^/#	/;
 		if (!$shown) {
-			print "#\n# Ignored files:\n";
+			print "#\n# Untracked files:\n";
 			print "#   (use \"git add\" to add to commit)\n#\n";
 			$shown = 1;
 		}
