From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Disable USE_SYMLINK_HEAD by default
Date: Tue, 15 Nov 2005 02:24:30 -0800
Message-ID: <7vd5l2mco1.fsf@assigned-by-dhcp.cox.net>
References: <1132034390.22207.18.camel@dv>
	<7vveyuqto5.fsf@assigned-by-dhcp.cox.net>
	<1132042427.3512.50.camel@dv>
	<7vpsp2qpx4.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 15 11:26:05 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EbxzQ-0006o3-Bk
	for gcvg-git@gmane.org; Tue, 15 Nov 2005 11:24:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750752AbVKOKYe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 Nov 2005 05:24:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751417AbVKOKYe
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Nov 2005 05:24:34 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:22691 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1750752AbVKOKYd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Nov 2005 05:24:33 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051115102359.EYQJ6244.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 15 Nov 2005 05:23:59 -0500
To: Pavel Roskin <proski@gnu.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11893>

Junio C Hamano <junkio@cox.net> writes:

> Pavel Roskin <proski@gnu.org> writes:
>
>> In particular, StGIT still needs fixing.
>>> ...
>> I'm talking from my experience now.  If there is an option, there are
>> users that have it enabled and those who have it disabled (by
>> definition).  As is often happens, one of the configurations is more
>> popular with developers.  The other configuration almost inevitably
>> starts suffering from the "bit rot".
>
> That's a real concern, I should agree.

I think I need to qualify this comment.  It is a real concern
because we need to know when it is safe to start using textual
symrefs everywhere, *if* we would want to do that switch.

I wonder how ready StGIT and Cogito are, but also I wonder how
ready other things are.  People built homebrew scripts around
git without calling them Porcelains, and git is designed to be
used that way.  We do not know how many things we are breaking
if we switch to do textual symrefs by default.

I just checked the latest gitweb, and it does not seem to be
ready.  I do not, however, necessarily think it is a high
priority problem.  It does not feel to me a realistic issue that
you cannot serve a public repository on a filesystem incapable
of symlinks via getweb.  This change is breaking things for
gitweb running on kernel.org machines without real benefit.

Thinking about it a bit more, the current setup to use symlinks
on systems that supports them, and textual symrefs on others, is
looking more and more sensible to me.  If supporting
symlink-challenged filesystems become a real issue for a "third
party tool", certainly that will be updated, because people
would want it.  Switching to do textual symrefs by default
everywhere is a way to *force* people to scramble and update
their scripts everywhere, but I am not so sure that is worth it;
I cannot justify why I'd be forcing them to do so, especially if
supporting VFAT is a low priority for some of the tools.

"Bit rot" may first seem a concern, but actually it is not.  I
suspect that serverish applications such as gitweb view
supporting symlink-challenged filesystems as a lower priority
task, while more client-oriented applications rate it higher.
The core support for textual symrefs cannot afford to rot as
long as some Porcelain needs it, and worrying about it would not
be a good justification to break everybody "just to see what
breaks".  On the other hand, if the support for textual symrefs
rot, it probably deserves to --- the only reason that would
happen would be because nobody uses them.

IOW, if we see real breakage in either git itself or Porcelains
that use git, send in fixes to appropriate parties.  I think
that's being constructive.  Otherwise, let's not break things
just for the sake of consistency.  I do not think that is
helping anything.
