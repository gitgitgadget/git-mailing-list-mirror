From: Junio C Hamano <junkio@cox.net>
Subject: Re: What's in git.git (stable)
Date: Fri, 22 Dec 2006 12:13:59 -0800
Message-ID: <7virg3zo1k.fsf@assigned-by-dhcp.cox.net>
References: <7vodpw46zj.fsf@assigned-by-dhcp.cox.net>
	<86k60jsvh8.fsf@blue.stonehenge.com>
	<86fyb7sv9f.fsf@blue.stonehenge.com>
	<Pine.LNX.4.63.0612221902490.19693@wbgn013.biozentrum.uni-wuerzburg.de>
	<861wmrsstc.fsf@blue.stonehenge.com>
	<Pine.LNX.4.63.0612221949490.19693@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Randal L. Schwartz" <merlyn@stonehenge.com>
X-From: git-owner@vger.kernel.org Fri Dec 22 21:14:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxqmN-0000p9-JA
	for gcvg-git@gmane.org; Fri, 22 Dec 2006 21:14:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750753AbWLVUOD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Dec 2006 15:14:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752578AbWLVUOD
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Dec 2006 15:14:03 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:42956 "EHLO
	fed1rmmtao07.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750753AbWLVUOB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Dec 2006 15:14:01 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20061222201400.LJBT3976.fed1rmmtao07.cox.net@fed1rmimpo01.cox.net>;
          Fri, 22 Dec 2006 15:14:00 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 1wDH1W00T1kojtg0000000; Fri, 22 Dec 2006 15:13:18 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0612221949490.19693@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Fri, 22 Dec 2006 20:21:02 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35207>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> HOWEVER, it has been in "What's cooking in git (topics)".
>
> Having said that, we could (at least for some time) print a big red 
> warning for the specific case of "git pull" meaning "git pull origin 
> <whateveristhefirstfetchedhead>" that this will GO AWAY SOON.
>
> Of course, you would not see it. Only your script.
>
> BTW I would _never_ allow a script to rely on such a DWIM feature.

That's too strong a statement.  It is not DWIM but has been a
longstanding rule to use "the first set of branches" for the
merge.  We've merged the first set of branches since day one,
and even after branch.*.merge we've done so unless you do not
have such configuration.

The complaint (or "newbie protection") was a backward
incompatible change, and it was executed poorly.  So my
apologies go to Merlyn.

While many "new features" can be done in backward compatible
way, any "newbie protection" can break existing practices --
because the whole point of "protection" is to forbid what once
was allowed only because we did not use to check.  And when we
have something that we check now that we did not check before,
that by definition will not be backward compatible.

Some backward incompatibilities are more justfiable than others.
For example, we recently changed "git add" without argument not
to do anything.  It used to have the same effect as "git add .",
but (1) adding all files in a working tree is a rare event, (2)
just a single dot is not hard to type, (3) without argument you
will get a response "not doing anything".  On the other hand,
doing "git add" without argument by mistake and ending up with
the index with many unwanted files is more painful and more
likely to hapen -- it is more valuable to protect users against
it than saving the two keysrokes.  That's why I think that
change is a justified improvement.

I do not think this "merge complaint", at least in the form that
lived on 'master', is justifiable.  The first one that was
merged from the topic made it a requirement to have the
branch.*.merge configuration when you do not give explicit
refspecs on the command line, which was just outright WRONG.
The one currently on the public repository says if the fetch
ended up getting only one branch then not having branch.*.merge
is Ok, which arguably is an improvement, but I do not think is
good enough.  I mentioned other possibilities in my earlier
message.

I also personally think that it is not as clear cut as the "git
add" case that "the first set of branches" rule is wrong, but
the trouble I caused to Merlyn and Luben primarily comes from
the check to trigger "newbie protection", not from what the
protection is trying to do.
