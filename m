From: Jeff King <peff@peff.net>
Subject: Re: [IGNORETHIS/PATCH] Choosing the sha1 prefix of your commits
Date: Thu, 20 Oct 2011 00:25:59 -0400
Message-ID: <20111020042559.GA5466@sigill.intra.peff.net>
References: <CACBZZX5PqYa0uWiGgs952rk2cy+QRCU95kF63qzSi3fKK-YrCQ@mail.gmail.com>
 <20111019190114.GA4670@sigill.intra.peff.net>
 <20111019193834.GA14168@sigill.intra.peff.net>
 <20111020025149.GA31549@sigill.intra.peff.net>
 <CAGZ=bqK2oVPxW3mm-WHMd1+KSiPquympJyhRqLWr1F=G74p+BA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Kyle Moffett <kyle@moffetthome.net>
X-From: git-owner@vger.kernel.org Thu Oct 20 06:26:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RGkCn-000514-78
	for gcvg-git-2@lo.gmane.org; Thu, 20 Oct 2011 06:26:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751251Ab1JTE0E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Oct 2011 00:26:04 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:35971
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750978Ab1JTE0C (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Oct 2011 00:26:02 -0400
Received: (qmail 6202 invoked by uid 107); 20 Oct 2011 04:26:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 20 Oct 2011 00:26:08 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 20 Oct 2011 00:25:59 -0400
Content-Disposition: inline
In-Reply-To: <CAGZ=bqK2oVPxW3mm-WHMd1+KSiPquympJyhRqLWr1F=G74p+BA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184001>

On Thu, Oct 20, 2011 at 12:15:03AM -0400, Kyle Moffett wrote:

> On Wed, Oct 19, 2011 at 22:51, Jeff King <peff@peff.net> wrote:
> > Keep in mind that each hex character you add increases the search space
> > by a factor of 16. deadbeef took about 70 seconds to find on my machine.
> > I'm tempted to look for "3133700..0031337", but it would probably
> > take about 4 hours.
> 
> Heh, there's one other practical downside I can think of...
> 
> If you create a bunch of commits with the same 8-hex-character prefix
> then suddenly the "git describe" logic for using the first 7 commit ID
> characters gets a whole lot less useful.

Actually, git will generally find a unique abbreviation among all of
your objects when using abbreviated sha1s, so you'll just get longer
abbreviations. Of course, it is only unique at the time of generation,
so new objects may make it ambiguous. Which is why the default minimum
is 7, not 1.  But of course with this trick you've effectively removed
all of the entropy from those initial 7 characters, and you effectively
only have 1 or 2 non-uniform characters.

So yeah, it is worse.  But really...spending millions of CPU cycles to
get a preimage collision with the partial sha1, and hack-ishly embedding
random crap after a NUL in every commit message, and _this_ is your
complaint? ;)

-Peff
