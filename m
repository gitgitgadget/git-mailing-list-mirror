From: Jeff King <peff@peff.net>
Subject: Re: [Bug] %[a|c]d placeholder does not respect --date= option in
 combination with git archive
Date: Thu, 3 Mar 2011 10:10:19 -0500
Message-ID: <20110303151019.GC1074@sigill.intra.peff.net>
References: <4D6F5FA8.5030105@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Dietmar Winkler <dietmarw@gmx.de>
X-From: git-owner@vger.kernel.org Thu Mar 03 16:10:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PvAAe-0004lZ-4Y
	for gcvg-git-2@lo.gmane.org; Thu, 03 Mar 2011 16:10:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755733Ab1CCPKW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Mar 2011 10:10:22 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:58962 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753982Ab1CCPKW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Mar 2011 10:10:22 -0500
Received: (qmail 27776 invoked by uid 111); 3 Mar 2011 15:10:20 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Thu, 03 Mar 2011 15:10:20 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 03 Mar 2011 10:10:19 -0500
Content-Disposition: inline
In-Reply-To: <4D6F5FA8.5030105@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168395>

On Thu, Mar 03, 2011 at 10:30:16AM +0100, Dietmar Winkler wrote:

> In my file I have the place holder $Format:%ad$ and in .git/config the
> setting log.date = short is present.
> [...]
> Now if I run on the same repo
> 	git archive --format=zip HEAD -o out.zip
> and check the place holder in the exported zip file it is actually
> replaced with:
> 
> Thu, 3 Mar 2011 10:06:43 +0100
> 
> and not
> 
> 2011-03-03

I am not sure that this is a bug. The log.date parameter is about the
log command, not necessarily other format substitutions. If it were any
other date format, I would say the right answer is that you should be
using one of the format-specific date specifiers. But annoyingly, there
is no such specifier for "short". Which means there is no way to
actually get the output that you want.

I remember at some point discussing extending the specifier syntax to
allow things like "%(ad,date=short)", but it was never implemented. I
think that would be the cleanest way to do what you want.

The second cleanest would be adding an archive.date variable. Which is
much simpler, obviously. But I think making "log.date" start applying to
archive substitutions is going to surprise some people and possibly
break their setups.

-Peff
