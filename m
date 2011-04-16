From: Jeff King <peff@peff.net>
Subject: Re: git status -s -v: no override
Date: Fri, 15 Apr 2011 21:37:23 -0400
Message-ID: <20110416013723.GA23105@sigill.intra.peff.net>
References: <BANLkTimKO7ihPpJ80Ad1kbYaMv1ycu0y9A@mail.gmail.com>
 <20110416000918.GB9334@sigill.intra.peff.net>
 <20110416004544.GA5628@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jacek Masiulaniec <jacekm@dobremiasto.net>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 16 03:37:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QAuSH-0002LE-4g
	for gcvg-git-2@lo.gmane.org; Sat, 16 Apr 2011 03:37:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754271Ab1DPBh1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Apr 2011 21:37:27 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:38631
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753964Ab1DPBh0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Apr 2011 21:37:26 -0400
Received: (qmail 15718 invoked by uid 107); 16 Apr 2011 01:38:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 15 Apr 2011 21:38:17 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 15 Apr 2011 21:37:23 -0400
Content-Disposition: inline
In-Reply-To: <20110416004544.GA5628@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171653>

On Fri, Apr 15, 2011 at 07:45:45PM -0500, Jonathan Nieder wrote:

> Jeff King wrote:
> 
> > There is no option that means "counteract -s or --porcelain seen earlier
> > on the command line and use the default long format", which I think is
> > what you want.
> 
> Doesn't "git status $opts --no-short --no-porcelain" work?

Hmm. That does work (with either option, or both), but it is somewhat of
an accident. There is an enum specifying the format the user wants. We
hand it to parse-options for those options, telling it that the value is
an int.  Parse-options will treat --no-foo on an int as setting it to 0.

The enumeration list does not have explicit integer values, but does
happen to have the constant for the long format first, which in ANSI C
guarantees it to be 0.

So yeah, it works, but I will admit to being surprised by it. And
certainly as a user, I wouldn't have thought of that.

I think it probably should have been a tristate like:

 --format={long,short,porcelain}

all along, though I don't know that it is a particularly big deal. We
can still do that if we want, and just keep --short and --porcelain as
aliases.

-Peff
