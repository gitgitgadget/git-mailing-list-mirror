From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] diff-delta: produce optimal pack data
Date: Fri, 24 Feb 2006 12:53:05 -0800
Message-ID: <7vpslc8oni.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0602212043260.5606@localhost.localdomain>
	<7v4q2pf8fq.fsf@assigned-by-dhcp.cox.net>
	<20060224174422.GA13367@hpsvcnb.fc.hp.com>
	<Pine.LNX.4.64.0602241252300.31162@localhost.localdomain>
	<20060224183554.GA31247@hpsvcnb.fc.hp.com>
	<Pine.LNX.4.64.0602241350190.31162@localhost.localdomain>
	<20060224192354.GC387@hpsvcnb.fc.hp.com>
	<Pine.LNX.4.64.0602241152290.22647@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
	Carl Baldwin <cnb@fc.hp.com>
X-From: git-owner@vger.kernel.org Fri Feb 24 21:53:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FCjw9-0004mj-77
	for gcvg-git@gmane.org; Fri, 24 Feb 2006 21:53:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932437AbWBXUxJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Feb 2006 15:53:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932492AbWBXUxI
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Feb 2006 15:53:08 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:57585 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S932437AbWBXUxH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Feb 2006 15:53:07 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060224205030.MCAZ17006.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 24 Feb 2006 15:50:30 -0500
To: Nicolas Pitre <nico@cam.org>
In-Reply-To: <Pine.LNX.4.64.0602241152290.22647@g5.osdl.org> (Linus Torvalds's
	message of "Fri, 24 Feb 2006 12:02:51 -0800 (PST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16738>

Linus Torvalds <torvalds@osdl.org> writes:

> NOTE! Every SINGLE one of those heuristics are just totally made up by 
> yours truly, and have no testing behind them. They're more of the type 
> "that sounds about right" than "this is how it must be". As mentioned, 
> Nico has already been playing with the heuristics - but he wanted better 
> packs, not better CPU usage, so he went the other way from what you would 
> want to try..

I haven't looked at Nico's original or updated code closely at
all, but two things come to mind.

(1) if we could tell the particular data is intrinsically
    diff_delta unfriendly and diff_delta would waste too much
    time when tried to delta against almost _any_ other blob,
    then it might help to give an interface in diff-delta.c for
    the caller to check for such a blob without even trying
    diff_delta.

(2) otherwise, if diff_delta could detect it would spend too
    many cycles to finish its work for a particular input early
    on, we might want it to bail out instead of trying a
    complete job.
