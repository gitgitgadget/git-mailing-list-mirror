From: Junio C Hamano <junkio@cox.net>
Subject: Re: Difficulties in advertising a new branch to git newbies
Date: Wed, 31 Jan 2007 12:20:33 -0800
Message-ID: <7vhcu7uewe.fsf@assigned-by-dhcp.cox.net>
References: <87odognuhl.wl%cworth@cworth.org>
	<20070130231015.GB10075@coredump.intra.peff.net>
	<7vzm80vv1s.fsf@assigned-by-dhcp.cox.net>
	<20070131032248.GA17504@coredump.intra.peff.net>
	<Pine.LNX.4.64.0701310932320.3021@xanadu.home>
	<20070131170752.GA19527@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>, cworth@cworth.org,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jan 31 21:21:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCLwc-0006cp-Ua
	for gcvg-git@gmane.org; Wed, 31 Jan 2007 21:20:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161014AbXAaUUf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 31 Jan 2007 15:20:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161017AbXAaUUf
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Jan 2007 15:20:35 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:45426 "EHLO
	fed1rmmtao05.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161014AbXAaUUe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Jan 2007 15:20:34 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070131202034.EWQ15640.fed1rmmtao05.cox.net@fed1rmimpo02.cox.net>;
          Wed, 31 Jan 2007 15:20:34 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id HwLZ1W00X1kojtg0000000; Wed, 31 Jan 2007 15:20:34 -0500
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38291>

Jeff King <peff@peff.net> writes:

> On Wed, Jan 31, 2007 at 09:59:08AM -0500, Nicolas Pitre wrote:
>
>> Also the warning when moving to a detached head is useful to make the 
>> user aware of what just happened because there is really something 
>> special about such checkout.  It is not meant to frighten users and if 
>> it does so then maybe it should be reworked some more.  But IMHO it is 
>> important that the user be aware of this special state.
>
> What is so special about it? My argument is that it is not really very
> special _until you make commits_. Are there other operations which we
> should be warning people about if they have a detached head?

I think you (and others in the thread) are forgetting that
moving to a particular state by resetting can create a state
that you may want to keep a pointer to, but you do not have any
existing ref.  That's one of the reasons why we do not merely
check if the detached HEAD is not reachable from any of the
existing refs when coming back.  Instead, we check and warn if
the detached HEAD does not exactly match one of the existing
refs.

Imagine "git bisect" did not exist, or was not powerful enough,
and the user was doing it by hand using something other than
"git bisect" to guide him which state to go next, or the user
did not want to use the special "bisect" branch, or some
combination of the above.  You move your detached HEAD around
and finally you are at the commit you are interested in.  You
haven't marked it in some way (perhaps "git tag") yet.  You
haven't made any commit, and the commit is reachable in some
way, but all the work to reach that state will be lost unless
you jot its commit object name down somewhere.

So "until you make commits" is not sufficient, which means that
covering all the way you can make commits isn't, either.
