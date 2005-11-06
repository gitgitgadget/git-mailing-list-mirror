From: Junio C Hamano <junkio@cox.net>
Subject: Re: git binary directory?
Date: Sat, 05 Nov 2005 21:37:25 -0800
Message-ID: <7vy84249re.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0511051247330.3316@g5.osdl.org>
	<7voe4y5w3v.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0511052013550.3316@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Nov 06 06:38:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EYdDe-0001Yj-5T
	for gcvg-git@gmane.org; Sun, 06 Nov 2005 06:37:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750726AbVKFFh1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 6 Nov 2005 00:37:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750737AbVKFFh1
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Nov 2005 00:37:27 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:3481 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1750726AbVKFFh0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Nov 2005 00:37:26 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051106053700.VCSG9394.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 6 Nov 2005 00:37:00 -0500
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11192>

Linus Torvalds <torvalds@osdl.org> writes:

> We have directories for a reason. You might as well argue that everybody 
> should have a flat namespace, since it should be efficient.
>
> The performance reason for directories is only secondary. The _real_ 
> reason for directories is to keep related things together, and track them 
> better. Havign a nice directory structure where programs keep their own 
> files instead of putting them all in the same place is a good thing from 
> an organization standpoint.

My point (actually, my purist half's point) is that /usr/bin is
that nice structure that keeps related things together --- the
relatedness of them being "the end user would want to run them".
Your initial hesitation that the change being discussed would
force you to say "git whatchanged" when you are so accustomed to
type git-whatchanged is valid.  Unfortunately, we have far more
commands in /usr/bin than good old V7 days, and while the
_primary_ purpose of /usr/bin is to hold "the end user would
want to run them" things together (hence, shell needs to know
only about handful places to look at), having thousands of
things in one place is inconvenient for purposes other than the
primary purpose of that grouping (i.e. running them), such as
browsing them.

You could deviate from the UNIX tradition and "keep related
things together" in different ways; you _could_ have
/usr/bin/pdf-viewers/, /usr/bin/html-viewers/, etc. to hold
xpdf, acroread, firefox and iexplorer in them if you do not like
/usr/bin/ that has many executables -- but we do not do that.

> (In fact, that PATH part of the patch is probably a bug-fix regardless: if 
> I have two different versions of "git", and I ask for the one that isn't 
> in my path explicitly, then it should use _its_ git programs, not the 
> other versions).

I think that is a valid change.

> The gnome file chooser is horrid, but even in the presense of a _nice_ 
> file manager it's actually not very pleasant to have directories with 
> thousands of files. 

Yes, but I think we should blame UNIX tradition for that ;-).

> Did you miss that part of my patch?

Sorry, my reply was prepared before I actually saw that patch
(you would notice it was a reply to your first message).  I
think what you did in your patch makes sense.  The end users
should always say 'git update-index' (or know the lib/git path
and it they want to say git-update-index), even when running the
low-level commands, and as long as they use 'git' wrapper that
approach would work.

> Yes. All porcelain would need to do the PATH thing, I think.

No, we could just say 'git commit' and 'git' is the only thing
that needs to know the PATH thing, as you did.

> But yes, you're right that right now we're not always set up for this, and 
> git-upload-pack etc that execute directly from the shell would need help.

We _could_ even invoke 'git upload-pack' from 'git-fetch'.
