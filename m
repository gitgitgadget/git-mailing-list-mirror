From: Jeff King <peff@peff.net>
Subject: Re: HTTP tests fail on OS X
Date: Fri, 21 Jun 2013 14:03:34 -0400
Message-ID: <20130621180334.GA4499@sigill.intra.peff.net>
References: <C44E969B-A5AE-44EF-BFCA-CAEF69516BEB@gernhardtsoftware.com>
 <20130621043052.GA5318@sigill.intra.peff.net>
 <20130621044236.GA5798@sigill.intra.peff.net>
 <26902D6D-D105-4943-BC67-461CEF82D888@gernhardtsoftware.com>
 <20130621044953.GA5962@sigill.intra.peff.net>
 <D0852D0F-3282-41DF-8A5A-4BEF1B39ED66@gernhardtsoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "git@vger.kernel.org List" <git@vger.kernel.org>
To: Brian Gernhardt <brian@gernhardtsoftware.com>
X-From: git-owner@vger.kernel.org Fri Jun 21 20:03:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uq5gb-0003jJ-64
	for gcvg-git-2@plane.gmane.org; Fri, 21 Jun 2013 20:03:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423560Ab3FUSDl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Jun 2013 14:03:41 -0400
Received: from cloud.peff.net ([50.56.180.127]:40235 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423388Ab3FUSDj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Jun 2013 14:03:39 -0400
Received: (qmail 20526 invoked by uid 102); 21 Jun 2013 18:04:39 -0000
Received: from c-98-244-76-202.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (98.244.76.202)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 21 Jun 2013 13:04:39 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 21 Jun 2013 14:03:34 -0400
Content-Disposition: inline
In-Reply-To: <D0852D0F-3282-41DF-8A5A-4BEF1B39ED66@gernhardtsoftware.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228638>

On Fri, Jun 21, 2013 at 01:03:40PM -0400, Brian Gernhardt wrote:

> On Jun 21, 2013, at 12:49 AM, Jeff King <peff@peff.net> wrote:
> 
> > I'm not sure what else to look at...I guess try ratcheting up the
> > debugging/log level on your failing copy and see if it prints anything
> > useful.
> 
> I found this error in the error.log:
> 
> [Fri Jun 21 12:59:59 2013] [emerg] (2)No such file or directory: Couldn't create accept lock (/private/var/run/accept.lock.64288) (5)

Hmm. I am far from an apache expert, but I believe that is what would
happen if the LockFile directive was not there at all. IOW, it seems
like your apache is treating "<IfVersion < 2.4>" as false. Which seems
weird to me.

It's possible I'm using IfVersion wrong, though it does seem to work for
me elsewhere.

IfVersion comes from mod_version. I assume that if it were not loaded,
apache would complain about the directive entirely. But it's true that
we don't load it until later. Maybe try moving the IfVersion/Lockfile
stanza down below the mod_version LoadModule line?

-Peff
