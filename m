From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 00/15] git-note: A mechanisim for providing free-form after-the-fact annotations on commits
Date: Mon, 28 May 2007 13:45:31 -0700
Message-ID: <7vwsysbrtg.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0705091406350.18541@iabervon.org>
	<200705281840.50814.johan@herland.net>
	<alpine.LFD.0.98.0705280957070.26602@woody.linux-foundation.org>
	<200705281948.27329.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Mon May 28 22:45:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hsm60-0006A4-KT
	for gcvg-git@gmane.org; Mon, 28 May 2007 22:45:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751660AbXE1Upe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 28 May 2007 16:45:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751554AbXE1Upe
	(ORCPT <rfc822;git-outgoing>); Mon, 28 May 2007 16:45:34 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:39602 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751457AbXE1Upd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 May 2007 16:45:33 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070528204532.XAXM2758.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Mon, 28 May 2007 16:45:32 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 4klY1X0011kojtg0000000; Mon, 28 May 2007 16:45:32 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48640>

Johan Herland <johan@herland.net> writes:

> On Monday 28 May 2007, Linus Torvalds wrote:
>> 
>> On Mon, 28 May 2007, Johan Herland wrote:
>> > 
>> > I still don't see what makes note objects inherently more expensive than
>> > commit objects. Except for the refs, of course, but we're getting rid
>> > of those (at least replacing them with a more efficient reverse mapping).
>> 
>> It's exactly the refs that I worry about.
>> 
>> Anything that needs to read in all notes at startup is going to be _slow_.
>> 
>> In contrast, commits we read when (and only when) we need them.
>
> Ok. But the reverse mapping will help with this, won't it?
> We'll look up the interesting commits and find their associated
> note objects directly.

The issue Linus brought up worries me, too.

The "efficient reverse mapping" is still handwaving at this
stage.  What it needs to do is an equivalent to your
implementation with "refs/notes/<a dir per commit>/<note>".  The
"efficient" one might do a flat file that says "notee note" per
line sorted by notee, or it might use BDB or sqlite, but the
amount of the data and complexity of the look-up is really the
same.  A handful notes per each commit in the history (I think
Linus's "Acked-by after the fact" example a very sensible thing
to want from this subsystem).

I am not saying that it is impossible to make the set-up cost
for the "efficient lookup" almost zero, and to make it lazy and
on-demand.  The concern above just adds one design constraints
to that "efficient reverse mapping" code yet to come.
