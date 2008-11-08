From: Jeff King <peff@peff.net>
Subject: Re: [RFC PATCH 0/4] deny push to current branch of non-bare repo
Date: Sat, 8 Nov 2008 09:27:56 -0500
Message-ID: <20081108142756.GC17100@coredump.intra.peff.net>
References: <20081107220730.GA15942@coredump.intra.peff.net> <7v3ai3f7oa.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Sam Vilain <sam@vilain.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 08 15:29:15 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KyooM-0004rY-90
	for gcvg-git-2@gmane.org; Sat, 08 Nov 2008 15:29:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753269AbYKHO17 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Nov 2008 09:27:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753286AbYKHO17
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Nov 2008 09:27:59 -0500
Received: from peff.net ([208.65.91.99]:2728 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753060AbYKHO16 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Nov 2008 09:27:58 -0500
Received: (qmail 6307 invoked by uid 111); 8 Nov 2008 14:27:57 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sat, 08 Nov 2008 09:27:57 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 08 Nov 2008 09:27:56 -0500
Content-Disposition: inline
In-Reply-To: <7v3ai3f7oa.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100403>

On Fri, Nov 07, 2008 at 03:16:53PM -0800, Junio C Hamano wrote:

> > The FAQ even says "don't do this until you know what you are doing." So
> > the safety valve is configurable, so that those who know what they are
> > doing can switch it off.
> 
> "We are breaking your existing working setup but you can add a new
> configuration to unbreak it" should not be done lightly.  I think as the
> end result it is a reasonable thing to aim for for this particular
> feature, but we do need a transition plan patch in between that introduces
> a step that warns but not forbids.  We can ship 1.6.1 with it and then
> switch the default to forbid in 1.6.3, for example.

Yeah, I was kind of hoping we could assume that anybody relying on this
behavior was somewhat insane, and wouldn't be too upset when it broke.
But you're probably right that we should be more conservative. I'll
rework it with a "yes/no/warn" option for the config, and we can set it
to "warn" (and those who really do want it can shut off the warning with
"no"). Or we can even start with just leaving it on "no", but I think
the deprecation period should begin when we switch it to "warn".

> > Patch 4/4 is the interesting one. 1/4 is a cleanup I saw while fixing
> > tests. 2/4 is a cleanup to prepare for 3/4. And 3/4 fixes a bunch of
> > tests which were inadvertently doing such a push (but didn't care
> > because they didn't look at the working directory).
> 
> I wonder if you can use the tests 3/4 touches as the test for your "keep
> existing setup" configuration variable, pretending that they are old
> timer's repositories?

Yes, they do break with 4/4 applied without 3/4 (that was how I found
them, but "git rebase -i" let me pretend I had the proper foresight. ;)
). We can keep 3/4 back until the switch from "warn" to "yes", if that's
what you are suggesting.

-Peff
