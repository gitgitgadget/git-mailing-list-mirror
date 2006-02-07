From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-commit: revamp the git-commit semantics.
Date: Tue, 07 Feb 2006 09:50:08 -0800
Message-ID: <7vfymvvz1r.fsf@assigned-by-dhcp.cox.net>
References: <7vpsm2hzng.fsf@assigned-by-dhcp.cox.net>
	<e5bfff550602050536j73f1091dq9afae232f574d0b4@mail.gmail.com>
	<7v64ntindq.fsf@assigned-by-dhcp.cox.net> <43E67745.2080302@gmail.com>
	<7voe1le71b.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0602071135110.5397@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 07 18:51:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F6Wyr-0005fh-86
	for gcvg-git@gmane.org; Tue, 07 Feb 2006 18:50:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932216AbWBGRuM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 7 Feb 2006 12:50:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932275AbWBGRuL
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Feb 2006 12:50:11 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:46498 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S932216AbWBGRuJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Feb 2006 12:50:09 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060207174843.IRHZ6244.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 7 Feb 2006 12:48:43 -0500
To: Nicolas Pitre <nico@cam.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15701>

Nicolas Pitre <nico@cam.org> writes:

> What has happened to the "least surprise" principle?  That clearly 
> favorize the former IMHO.

Please see below.

> Maybe being too intimate with git doesn't make it obvious to you,...

I think you are looking at this with a bit shortsighted view.
We are aiming for the same end results.

Let's say you have a git-commit that does --only semantics by
default "some day", and everybody knows that is going to happen
on that "some day" for a long time (say, a month), because we
are discussing about it right now in this thread.

And a newcomer comes.  He's never used git before.  When he
types "git commit paths...", the new --only semantics happens.
By that time (a month is a long time in git timescale) everybody
knows "git commit paths..." mean --only, so if the newcomer has
trouble with "git commit paths...", people can help him with
shared knowledge on what that command means.  And what the
command does is less surprising than the current behaviour.

It is a Good Change.  I am agreeing with you that if --only were
the default from before I inherited git, things might have been
better.

But let's say you make that "some day" today, or in the 1.2.0
that is hopefully imminent.  That newcomer is not using git yet.
Many people and their scripts are already using git, expecting
"git commit paths..."  to mean --include semantics.  What kind
of surprise are you giving them?

That is this '--only/--include are available but currently the
traditional --include is the default' is all about.  It is about
not breaking current users during transition.  And People's
Scripts.  If a tool wants traditional semantics, it can hardcode
"--include" (or --only if not), and does not have to worry about
the default getting switched "some day".

Once things are prepared that way, we can switch the default any
day, as long as we give users enough advance notice.

It is possible that you are well aware of all of the above, and
are arguing that "enough advance notice" period should be zero
days.  But I don't think that is nice.  When was this temporary
thing formerly proposed in this round of discussion to make
everybody realize that is what is happening?  4 days ago?  And
the actual code that claims to do --only hit the "master" branch
only 8 hours or so ago.

I was hoping that before 1.2.0 I can take a final "just in case"
quick poll to see everybody agrees making --only the default is
the way to go, then state it clearly that 1.3.0 will have the
default switched to --only in the release announcement.
