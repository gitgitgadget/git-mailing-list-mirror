From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-commit: allow From: line to be entered in commit message
Date: Thu, 12 Jan 2006 12:13:52 -0800
Message-ID: <7vzmm1mcfz.fsf@assigned-by-dhcp.cox.net>
References: <BAYC1-PASMTP117A18814EAAFACFE0F31DAE270@CEZ.ICE>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 12 21:14:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ex8pb-0001IR-2n
	for gcvg-git@gmane.org; Thu, 12 Jan 2006 21:13:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161241AbWALUNz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Jan 2006 15:13:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161242AbWALUNz
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jan 2006 15:13:55 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:32679 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1161241AbWALUNy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jan 2006 15:13:54 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060112201125.KBRC17437.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 12 Jan 2006 15:11:25 -0500
To: sean <seanlkml@sympatico.ca>
In-Reply-To: <BAYC1-PASMTP117A18814EAAFACFE0F31DAE270@CEZ.ICE>
	(seanlkml@sympatico.ca's message of "Thu, 12 Jan 2006 09:37:00 -0500")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14583>

sean <seanlkml@sympatico.ca> writes:

> Mostly just for comment to see if there is any support
> for this feature....
>
> Sean
>
> ---
> Use the author name and email information given as the 
> first line of the commit message in the form of:
>
> From: name <email>
>
> as the author's name and email address in the resulting
> commit object.  This makes committing foreign patches
> a little less cumbersome to handle for some workflows.

Actually, I've considered this a couple of times in the past,
but I ended up saying no.

If the workflow is driving "git commit" from a script (i.e. your
own Porcelain), the script can set GIT_AUTHOR_* environment
variables, so this is a non issue.

Which means that this 'From: ' thing is coming from the end
user.  Either you as the end user pasted it from some text file,
or typed that line because you knew that the change was made by
that person, not by you.

If you pasted that line from somewhere else, I wonder what that
"somewhere else" file is -- and what else that file contained.
If the change came in an e-mail message, we already have tools
for that (am/applymbox), and they do not lose the author-date
information as your change to git-commit does, so I think it is
a non issue.

And I do not think of anything else that would have author name
but does not have a patch text that you can feed git-apply with.
Pasting from your address book just to save typing does not
count as "pasting" --- that is still typing in this context.

If you typed that line, why somebody else's change ended up in
your working tree is a mystery to me, but let's say an
office-mate edited things for you and said "this should work.
test it out and if it is OK commit it for me."  I have seen this
kind of thing done in real life.

If that is what happened, then what you are adding is a more
convenient way than setting two GIT_AUTHOR_* environment
variables.  Maybe you forgot about preserving author date, in
which case you would add 'Date: ' as well to your patch, and
that would save your user from setting three environment
variables.

So the matter really is how much this patch is better than
setting GIT_AUTHOR_* environment variables, unless it simplifies
things for other programs (one possibility I have not looked
into is that we _might_ be able to use "git commit" with this
modification from "git am/applimbox/revert/cherry-pick").
