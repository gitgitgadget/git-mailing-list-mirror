From: Junio C Hamano <junkio@cox.net>
Subject: Re: Making note, in the repository, of push/pull relationships
Date: Tue, 16 Aug 2005 14:09:08 -0700
Message-ID: <7vll318u8b.fsf@assigned-by-dhcp.cox.net>
References: <20050815162519.GB9719@hpsvcnb.fc.hp.com>
	<7vzmrispi4.fsf@assigned-by-dhcp.cox.net>
	<20050816171142.GB20016@hpsvcnb.fc.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 16 23:10:47 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E58gM-00020q-83
	for gcvg-git@gmane.org; Tue, 16 Aug 2005 23:09:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932718AbVHPVJL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 16 Aug 2005 17:09:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932720AbVHPVJL
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Aug 2005 17:09:11 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:1192 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S932718AbVHPVJK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Aug 2005 17:09:10 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050816210908.UXJJ8651.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 16 Aug 2005 17:09:08 -0400
To: Carl Baldwin <cnb@fc.hp.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Carl Baldwin <cnb@fc.hp.com> writes:

> If I may, let me give an example of something I think could serve the
> purpose a little more simply and generically.
>
> Let's say I start with the following:
> % ls .git/refs/heads
> master
> mylocalbranch
> myremotebranch
> ko-master
> % cat .git/branches/ko-master
> master.kernel.org:/pub/scm/git/git.git
>
> I would add something like this:  (I didn't put much thought into the
> actual directory and file names, forgive me.  ;-)
>
> % cat .git/branches/relationships
> pull:ko-master:master
> pull:master:mylocalbranch # The next two document my flow locally
> pull:mylocalbranch:master
> push:master:myremotebranch # I push my master to a remote that I control

And presumably you have .git/branches/myremotebranch file that
says something like "master.kernel.org:/pub/scm/git/git.git".
Or should the last line of relationships file be spelled just
push:master:ko-master?

> % cat .git/remotes/ko
> push: master:ko-master pu:ko-pu rc:ko-rc
> pull: ko-master:master ko-pu:pu ko-rc:rc
>
> I might argue that this is now a job for a porcelain script or
> something.

Probably.

My primary interest in discussing this is to see Porcelain folks
agree on what notation and semantics to use, and probably set an
example by having the minimum base in the barebone Porcelain.

Personally I think there are two kinds of patch-flow: one that
is pretty much static that can easily be described with
something like your relationships notation, and ad-hoc one that
I think should not automatically contaminate the established
static flow your relationships notation nicely describes.  The
corporate world may put disproportional stress on the importance
of the former, but my feeling is that ad-hoc patch-flow that is
outside your usual static patch-flow is just as important; see
Documentation/howto/using-topic-branches.txt for why.
