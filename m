From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] filter-branch: resolve $commit^{tree} in no-index case
Date: Tue, 19 Jan 2016 21:00:39 -0500
Message-ID: <20160120020039.GD24541@sigill.intra.peff.net>
References: <xmqqbn8h9squ.fsf@gitster.mtv.corp.google.com>
 <xmqq7fj59rs2.fsf@gitster.mtv.corp.google.com>
 <20160119213705.GA28656@sigill.intra.peff.net>
 <xmqq37tt9r9g.fsf@gitster.mtv.corp.google.com>
 <20160119215100.GB28656@sigill.intra.peff.net>
 <20160119215928.GA6556@sigill.intra.peff.net>
 <20160119222802.GC6556@sigill.intra.peff.net>
 <20160120012253.GD16090@google.com>
 <20160120013436.GA24541@sigill.intra.peff.net>
 <xmqqbn8h6mrl.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	John Fultz <jfultz@wolfram.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 20 03:00:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aLi4l-0007KH-Dh
	for gcvg-git-2@plane.gmane.org; Wed, 20 Jan 2016 03:00:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933419AbcATCAn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jan 2016 21:00:43 -0500
Received: from cloud.peff.net ([50.56.180.127]:56655 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933107AbcATCAm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jan 2016 21:00:42 -0500
Received: (qmail 28793 invoked by uid 102); 20 Jan 2016 02:00:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 19 Jan 2016 21:00:42 -0500
Received: (qmail 28926 invoked by uid 107); 20 Jan 2016 02:01:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 19 Jan 2016 21:01:02 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 19 Jan 2016 21:00:39 -0500
Content-Disposition: inline
In-Reply-To: <xmqqbn8h6mrl.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284413>

On Tue, Jan 19, 2016 at 05:51:58PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> >> Mph.  We could get the best of both worlds by introducing a "git
> >> rev-parse --compare <a> <b>" that compares object ids.  Actually...
> >> 
> >> How about something like this?
> >
> > Thanks. I had in my head that we could do something like that, but
> > hadn't quite worked it out. I think what you wrote works.
> 
> But wouldn't "diff-tree --quiet" essentially be that command?

I think Jonathan was responding to my point that "diff-tree --quiet"
_isn't_ quite the same, if you have mis-formatted tree objects. If the
sha1s are different, a rev-parse comparison will keep the commit. But
"diff-tree" will actually do the diff, and may consider different sha1s
to have the same content, dropping the second one.

It's a minor point, but I find one of my primary uses for filter-branch
these days is massaging out bogus objects made by older or buggy git
clients (not that I see _that_ many of them; I think it speaks more to
the fact that I don't really use filter-branch much these days).

> > If you want to wrap it up into a patch, I'd be OK with it, but note that
> > it still falls afoul of changing $tree in a user-visible way (so you
> > should note that in the commit message).
> 
> Yes, I think we should take your conservative variant for that exact
> reason.

I'm fine with that, too. We could also do the conservative variant for
"maint", and then do the other with a deprecation warning. I think I
decided I don't care enough to go through those motions myself, but I
don't mind if somebody else wants to.

-Peff
