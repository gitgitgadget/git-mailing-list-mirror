From: Ian Kumlien <pomac@vapor.com>
Subject: Re: git hangs on pthread_join
Date: Wed, 29 May 2013 10:29:03 +0200
Message-ID: <20130529082903.GC22308@pomac.netswarm.net>
References: <20130523130143.GA6376@pomac.netswarm.net>
 <20130528175108.GA21210@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Fick <mfick@codeaurora.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed May 29 10:51:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uhc6q-0002np-Tl
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 10:51:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965185Ab3E2Ivr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 May 2013 04:51:47 -0400
Received: from mail.vapor.com ([83.220.149.2]:54260 "EHLO nitrogen.vapor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965117Ab3E2Ivq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 May 2013 04:51:46 -0400
Received: from twilight.demius.net (c-297271d5.013-195-6c756e10.cust.bredbandsbolaget.se [213.113.114.41])
	by nitrogen.vapor.com (Postfix) with ESMTPSA id 4C45929AC2C;
	Wed, 29 May 2013 10:51:33 +0200 (CEST)
Received: by twilight.demius.net (Postfix, from userid 1000)
	id 940498E36CB; Wed, 29 May 2013 10:29:03 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20130528175108.GA21210@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225779>

On Tue, May 28, 2013 at 01:51:09PM -0400, Jeff King wrote:
> On Thu, May 23, 2013 at 03:01:43PM +0200, Ian Kumlien wrote:
> 
> > git 1.8.2.1 is started by xinetd
> > [...]
> > I have found "git receive-pack"s that has been running for days/weeks
> > without terminating....
> > 
> > Attaching gdb and doing a trace results in:
> > #0  0x0000003261207b35 in pthread_join () from /lib64/libpthread.so.0
> > #1  0x00000000004ce58b in finish_async ()
> > #2  0x000000000045744b in cmd_receive_pack ()
> > #3  0x0000000000404851 in handle_internal_command ()
> > #4  0x0000000000404c9d in main ()
> 
> I recently fixed a deadlock that could happen in receive-pack when
> clients hung up before sending a valid pack header. The fix is commit
> 49ecfa1, and it's in git v1.8.2.2.

With dodgy connections this could easily happen =)

Really nice catch!

> The stack trace for the deadlock fixed by 49ecfa1 would have
> unpack_with_sideband between #1 and #2 above, but it is entirely
> possible that it is simply inlined in your build of git, depending on
> the -O level of your build (it is a static function that is only called
> from one place). So it seems likely that it is the culprit.

Yeah, since it's a RHEL 5 machine i don't even get a debug rpm package
=P

I will upgrade all machines and keep monitoring, thanks!

> -Peff
