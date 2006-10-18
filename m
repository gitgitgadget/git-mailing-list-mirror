From: Junio C Hamano <junkio@cox.net>
Subject: Re: heads-up: git-index-pack in "next" is broken
Date: Tue, 17 Oct 2006 21:16:26 -0700
Message-ID: <7v64eii7hh.fsf@assigned-by-dhcp.cox.net>
References: <7vy7rfsfqa.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0610171134130.1971@xanadu.home>
	<7vslhnj58e.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0610171251210.1971@xanadu.home>
	<7vbqoake1v.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0610171437250.1971@xanadu.home>
	<20061017233630.72a0aae5.vsu@altlinux.ru>
	<Pine.LNX.4.64.0610171615340.1971@xanadu.home>
	<Pine.LNX.4.64.0610171339030.3962@g5.osdl.org>
	<Pine.LNX.4.64.0610171706260.1971@xanadu.home>
	<Pine.LNX.4.64.0610171440080.3962@g5.osdl.org>
	<Pine.LNX.4.64.0610171959070.1971@xanadu.home>
	<7vac3uif6i.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0610172209070.1971@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 18 06:16:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ga2r1-0004OF-Cd
	for gcvg-git@gmane.org; Wed, 18 Oct 2006 06:16:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751366AbWJREQ2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Oct 2006 00:16:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751364AbWJREQ2
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Oct 2006 00:16:28 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:56280 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1751366AbWJREQ1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Oct 2006 00:16:27 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061018041626.CGMX28934.fed1rmmtao07.cox.net@fed1rmimpo01.cox.net>;
          Wed, 18 Oct 2006 00:16:26 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id bgGD1V0031kojtg0000000
	Wed, 18 Oct 2006 00:16:13 -0400
To: Nicolas Pitre <nico@cam.org>
In-Reply-To: <Pine.LNX.4.64.0610172209070.1971@xanadu.home> (Nicolas Pitre's
	message of "Tue, 17 Oct 2006 22:23:30 -0400 (EDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29186>

Nicolas Pitre <nico@cam.org> writes:

>> but if somebody did so then it would mean a disaster to have an 
>> accidental collision of an 8-byte offset value plus 12-byte traiing 
>> NUL and another base object whose object name happens to match that 
>> pattern.
>
> Not really.  The only effect that would have on the sorted list of 
> delta entries -- such sorting used to bring all deltas with the same 
> base object contigously -- is that those deltas might not be perfectly 
> contigous wrt their base object.  This is why there is a test to skip 
> deltas if they happen not to be of the expected type.

Ah, I misread the code that uses union actually checks the type
in struct delta_entry (which embeds the union).  There won't be
any collision problem and you support both types at the same
time just fine.

And your patch to compare only the first 20-bytes makes sense
(assuming ulong is always shorter than 20-bytes which I think is
safe to assume).
