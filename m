From: Jeff King <peff@peff.net>
Subject: Re: On Tabs and Spaces
Date: Wed, 17 Oct 2007 22:45:53 -0400
Message-ID: <20071018024553.GA5186@coredump.intra.peff.net>
References: <3awb7zw6.fsf@blue.sea.net> <alpine.LFD.0.999.0710161214530.6887@woody.linux-foundation.org> <1192565900.6430.16.camel@athena> <alpine.LFD.0.999.0710161559150.6887@woody.linux-foundation.org> <20071017015109.303760cc@localhost.localdomain> <alpine.LFD.0.999.0710161722320.26902@woody.linux-foundation.org> <3A9408D5-2667-43A6-A0CE-C0720B3A3987@vicaya.com> <alpine.LFD.0.999.0710170849590.26902@woody.linux-foundation.org> <20071018003256.GA5062@coredump.intra.peff.net> <alpine.LFD.0.999.0710171753020.26902@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Luke Lu <git@vicaya.com>, Christer Weinigel <christer@weinigel.se>,
	Tom Tobin <korpios@korpios.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Oct 18 04:46:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IiLOm-0000rD-SV
	for gcvg-git-2@gmane.org; Thu, 18 Oct 2007 04:46:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759100AbXJRCp6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Oct 2007 22:45:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758430AbXJRCp6
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Oct 2007 22:45:58 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4081 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759066AbXJRCp5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Oct 2007 22:45:57 -0400
Received: (qmail 31755 invoked by uid 111); 18 Oct 2007 02:45:54 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 17 Oct 2007 22:45:54 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 17 Oct 2007 22:45:53 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.999.0710171753020.26902@woody.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61452>

On Wed, Oct 17, 2007 at 05:59:27PM -0700, Linus Torvalds wrote:

> It happens. We do de-spacification in the kernel occasionally when it is 
> an annoyance. Usually it shows up in patches, though - exactly because 
> code which adds spaces instead of tabs won't line up correctly in the 
> diff.

You have made this claim several times, and I really don't understand
it. If I have 8 spaces, then a diff line will have either " ", "+", or
"-" followed by 8 spaces. If I use a hard tab, then the tab will end up
only taking up 7 spaces because of the nature of tabs.

This might matter if I'm comparing non-diff code to diff code. But in a
diff, _everything_ is indented by exactly one space, so it all lines up.
Is there something I'm missing?

> So it doesn't matter *which* one you use (all spaces or all tabs) in that 
> sense.

Yes, I agree with that (even with an all-tabs policy, there are still
mangled and incorrect patches that come in -- and the maintainer rejects
or fixes them).

Which was what I was trying to point out with my question (though I was
also curious to hear your answer): all-space versus all-tab is largely a
matter of preference. And that means that people who want git to change
to _their_ preference are just being silly.

> And smaller *is* faster. Do something like this on the kernel:
> 
> 	GIT_PAGER= time git grep sched_fair
> 
> and then do the same thing with the kernel sources blown up by 20% by 
> de-tabification. Guess which one is 20% slower?

I was about to tell you that you're full of it, but there really is a
slowdown:

$ cd linux-2.6
$ GIT_PAGER= time git grep sched_fair >/dev/null
0.34user 0.94system 0:01.30elapsed 98%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+7548minor)pagefaults 0swaps

$ find . -name .git -prune -o -type f | xargs perl -pi -e 's/\t/        /g'
$ git-commit -a -m de-tabify
$ git-repack -a -d
$ GIT_PAGER= time git grep sched_fair >/dev/null
0.42user 1.06system 0:01.54elapsed 96%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+7591minor)pagefaults 0swaps

It's actually about 16%.


Gah, I can't believe I've not only been sucked into a tab vs spaces
discussion, but now I've actually wasted time doing a performance
comparison on it.

As an aside, that commit was enough to trigger a "git-gc --auto", which
was my first experience with it. It's actually kind of annoying
(especially since I was about to repack -a -d).

-Peff
