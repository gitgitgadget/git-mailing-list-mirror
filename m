From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH] fsck: do not canonicalize modes in trees we are
 checking
Date: Tue, 23 Sep 2014 12:30:09 -0400
Message-ID: <20140923163008.GA21591@peff.net>
References: <20140923154751.GA19319@peff.net>
 <20140923162343.GA20379@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Edward Thomson <ethomson@edwardthomson.com>
X-From: git-owner@vger.kernel.org Tue Sep 23 18:31:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XWSyo-0008Cm-Hd
	for gcvg-git-2@plane.gmane.org; Tue, 23 Sep 2014 18:30:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755856AbaIWQaM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Sep 2014 12:30:12 -0400
Received: from cloud.peff.net ([50.56.180.127]:51001 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755056AbaIWQaL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Sep 2014 12:30:11 -0400
Received: (qmail 27683 invoked by uid 102); 23 Sep 2014 16:30:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 23 Sep 2014 11:30:11 -0500
Received: (qmail 29581 invoked by uid 107); 23 Sep 2014 16:30:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 23 Sep 2014 12:30:36 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 23 Sep 2014 12:30:09 -0400
Content-Disposition: inline
In-Reply-To: <20140923162343.GA20379@debian>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257427>

[-cc Kirill, as his address seem out-of-date]

On Tue, Sep 23, 2014 at 04:23:43PM +0000, Edward Thomson wrote:

> On Tue, Sep 23, 2014 at 11:47:51AM -0400, Jeff King wrote:
> > As far as I can tell, fsck's mode-checking has been totally broken
> > basically forever. Which makes me a little nervous to fix it. :)
> > linux.git does have some bogus modes, but they are 100664, which is
> > specifically ignored here unless "fsck --strict" is in effect.
> 
> I'm in favor of checking the mode in fsck, at least when --strict.  
> But I would suggest we be lax (by default) about other likely-to-exist
> but strictly invalid modes to prevent peoples previously workable
> repositories from being now broken.
> 
> I have, for example, encountered 100775 in the wild, and would argue that
> like 100644, it should probably not fail unless we are in --strict mode.

Yeah, I'd agree with that. The big question is: what breakage have we
seen in the wild? :)

I think treating 100775 the same as 100664 makes sense (want to do a
patch?). Do we know of any others? I guess we can collect them as time
goes on and reports come in. That's not the nicest thing for people with
such repos, but then again, their repos _are_ broken (and it's only
really a showstopper if they are trying to push to somebody with
receive.fsckObjects turned on).

-Peff
