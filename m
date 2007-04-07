From: Junio C Hamano <junkio@cox.net>
Subject: Re: How can git pull be up-to-date and git push fail?
Date: Sat, 07 Apr 2007 14:26:44 -0700
Message-ID: <7vy7l3c1uz.fsf@assigned-by-dhcp.cox.net>
References: <17940.59514.150325.738141@lisa.zopyra.com>
	<20070405134954.GA18402@coredump.intra.peff.net>
	<17941.655.192938.792088@lisa.zopyra.com>
	<20070405204604.GA24779@coredump.intra.peff.net>
	<7vodm2o6yl.fsf@assigned-by-dhcp.cox.net>
	<20070406025255.GA31909@coredump.intra.peff.net>
	<7vbqi1jhzx.fsf@assigned-by-dhcp.cox.net>
	<20070407170702.GC18972@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Bill Lear <rael@zopyra.com>, git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Apr 07 23:58:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HaIQr-0001BQ-ES
	for gcvg-git@gmane.org; Sat, 07 Apr 2007 23:26:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966349AbXDGV0q (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Apr 2007 17:26:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966350AbXDGV0q
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Apr 2007 17:26:46 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:41140 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966349AbXDGV0p (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Apr 2007 17:26:45 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070407212645.VUOA25613.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Sat, 7 Apr 2007 17:26:45 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id kMSk1W0091kojtg0000000; Sat, 07 Apr 2007 17:26:44 -0400
In-Reply-To: <20070407170702.GC18972@coredump.intra.peff.net> (Jeff King's
	message of "Sat, 7 Apr 2007 13:07:02 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43984>

Jeff King <peff@peff.net> writes:

> On Fri, Apr 06, 2007 at 02:44:02PM -0700, Junio C Hamano wrote:
>
>> was no "git push" wrapper).  Back then, the expected use was
>> really:
>
> Thanks for this for the historical information.
>
>> So I'd suspect "git push" (not limited to git-send-pack) without
>> explicit refspecs should only do "matching branch heads" these
>> days, to keep the original spirit but yet to adjust to today's
>> reality....
>
> Agreed. That was actually my initial feeling, but it meant changing the
> semantics of all of the other parts of the refs/* hierarchy with respect
> to publishing, which I was a bit nervous about.
> ...
> BTW, my gut feeling is that send-pack is plumbing, and git-push is
> porcelain, and therefore the decisions about what to push should be made
> at the push layer, and send-pack should only push what it is explicitly
> told to push. But changing the defaults of send-pack at this point is
> probably a bad idea.

Yes, that is exactly why I suggested "git push" without explicit
refspecs to drive the plumbings to push only matching branches.
So if you are worried about breaking backward compatibility for
real men (iow people who use git-send-pack directly), it would
be a less impact change to (1) add --matching-heads option to
send-pack and perhaps http-push, and change their behaviour only
in that case, and (2) pass that option when git-push did not get
explicit refspecs to send from the user, either from the command
line nor from the config.
