From: Junio C Hamano <junkio@cox.net>
Subject: Re: Last mile to 1.0?
Date: Fri, 29 Jul 2005 19:11:25 -0700
Message-ID: <7v4qad82lu.fsf@assigned-by-dhcp.cox.net>
References: <7vwtnqhcfb.fsf@assigned-by-dhcp.cox.net>
	<20050729224148.GB22530@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 30 04:18:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DygvZ-0001xd-1X
	for gcvg-git@gmane.org; Sat, 30 Jul 2005 04:18:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262934AbVG3CPJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Jul 2005 22:15:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262924AbVG3CN5
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jul 2005 22:13:57 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:8919 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S262929AbVG3CL2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jul 2005 22:11:28 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050730021112.XUPC19494.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 29 Jul 2005 22:11:12 -0400
To: Petr Baudis <pasky@suse.cz>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Petr Baudis <pasky@suse.cz> writes:

> Note that I really _loved_ the Daniel's tools while they lasted. What I
> loved most about them was that they really only pulled objects I needed
> and not a single worthless one. Does the current HTTP transport share
> this property?

I am a big fan of Barkalow puller, too.  It is conceptually
simple, very easy to explain, and quite nicely done to be
transport independent.  Performance sucks, but that is not Dan's
fault.

If we are talking about a dumb HTTP server that has packed and
then prune-packed its repository, "not a single worthless one"
is asking for moon.  If Jeff packed all his 50 branches into a
single pack and prune packed his repository, the only thing a
dumb server could do when you ask for one of his branches is to
give you that statically prepared single pack which contains
everything, because there would be nothing in .git/objects/??/.
You need some CGI support that pulls only needed objects out of
that pack and talks a moral equivalent of the upload-pack
protocol for that.

Barkalow puller is still useful when all the objects you still
need to pull from the remote are unpacked on the remote end.
That's how I resurrected "git clone" over http with packed dumb
servers.  For "clone" case, I just slurp all the available
packs, and have Barkalow puller take over the rest.

I have an early WIP for "git fetch", but I have backburnered it
for quite some time.  I'll push it in its current form into my
proposed updates branch, so interested people can hack on it.

> Note that I also want to setup a simple "proof-of-concept" GIT homepage
> tomorrow. Well, write it, where it should be hosted can be worked out
> later and I have places for it to reside at for now. (Suggestions for
> final hosting welcome. In reality, how nice (and persistent) the URL
> gets is probably the only thing that really matters. My attempt will
> live at http://git.or.cz/.)

I hope nobody starts another SCM project called CZ ;-).
