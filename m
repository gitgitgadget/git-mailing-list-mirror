From: Peter Baumann <waste.manager@gmx.de>
Subject: Re: git-bisect working only from toplevel dir
Date: Wed, 23 Nov 2011 21:26:43 +0100
Message-ID: <20111123202643.GB6291@m62s10.vlinux.de>
References: <20111123145034.GB17927@angband.pl>
 <7vd3cibqqe.fsf@alter.siamese.dyndns.org>
 <20111123192329.GA21630@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Adam Borowski <kilobyte@angband.pl>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Nov 23 21:26:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RTJPC-0004M7-N8
	for gcvg-git-2@lo.gmane.org; Wed, 23 Nov 2011 21:26:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752941Ab1KWU0s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Nov 2011 15:26:48 -0500
Received: from mailout-de.gmx.net ([213.165.64.22]:49848 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750990Ab1KWU0s (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Nov 2011 15:26:48 -0500
Received: (qmail invoked by alias); 23 Nov 2011 20:26:46 -0000
Received: from m62s10.vlinux.de (EHLO m62s10.vlinux.de) [83.151.21.204]
  by mail.gmx.net (mp014) with SMTP; 23 Nov 2011 21:26:46 +0100
X-Authenticated: #1252284
X-Provags-ID: V01U2FsdGVkX18J6GgpHRcJqO/fNanZctiDUFm2RgVlzcJ6cw6OSw
	l7RkgfVkG65uDA
Received: by m62s10.vlinux.de (Postfix, from userid 1000)
	id A5802D4003; Wed, 23 Nov 2011 21:26:43 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20111123192329.GA21630@sigill.intra.peff.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185869>

On Wed, Nov 23, 2011 at 02:23:29PM -0500, Jeff King wrote:
> On Wed, Nov 23, 2011 at 11:09:29AM -0800, Junio C Hamano wrote:
> 
> > As to the approach, I suspect that it would be far better if it made
> > workable with cd_to_toplevel at the beginning, instead of saying
> > SUBDIRECTORY_OK.
> > 
> > After all, the current directory may disappear during the course of
> > bisection, upon checking out a revision that did not have the directory
> > you started your bisection from.
> 
> But from what directory would you expect:
> 
>   git bisect run make
> 
> to run from? If you use a GNU-ish layout with all of your code in
> "src/", then I can see it useful to do something like:
> 
>   cd src
>   git bisect run make
> 
> If we cd_to_toplevel, we can remember the prefix that we started from
> and cd to it before running the user's command, but there is no
> guarantee that it actually exists. Maybe that commit should be
> considered indeterminate then?
> 

Why not simply fail the run with exit(-1)? If the directory doesn't exist
in an older commit (which I think is not that common) git bisect should
simply stop and let the user proceed. 

And yes, I find the current behaviour to forbid running git bisect from
a subdirectory slighly annoying and I'm glad somebody took a stab at it.

-Peter
