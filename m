From: Jeff King <peff@peff.net>
Subject: Re: [BUG?] fetch into shallow sends a large number of objects
Date: Tue, 8 Mar 2016 07:21:26 -0500
Message-ID: <20160308122126.GB18535@sigill.intra.peff.net>
References: <20160307221539.GA24034@sigill.intra.peff.net>
 <xmqqio0xn93q.fsf@gitster.mtv.corp.google.com>
 <CACsJy8C-Wfh16jroWACEFybtnhwYX91GvgGwk8XxJRft4ZURSw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 08 13:21:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1adGdr-0005qc-Ds
	for gcvg-git-2@plane.gmane.org; Tue, 08 Mar 2016 13:21:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932287AbcCHMVb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Mar 2016 07:21:31 -0500
Received: from cloud.peff.net ([50.56.180.127]:56201 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932140AbcCHMV3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Mar 2016 07:21:29 -0500
Received: (qmail 5337 invoked by uid 102); 8 Mar 2016 12:21:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 08 Mar 2016 07:21:28 -0500
Received: (qmail 1611 invoked by uid 107); 8 Mar 2016 12:21:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 08 Mar 2016 07:21:43 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 08 Mar 2016 07:21:26 -0500
Content-Disposition: inline
In-Reply-To: <CACsJy8C-Wfh16jroWACEFybtnhwYX91GvgGwk8XxJRft4ZURSw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288428>

On Tue, Mar 08, 2016 at 07:53:35AM +0700, Duy Nguyen wrote:

> > I also do not offhand think of a good way to use the topology or
> > timestamp to figure out the best "depth" to truncate the side branch
> > at.  The server side may be able to figure out that things before 'F'
> > in your picture is not relevant for a client that has the shallow
> > cut-off at 067f265, but the side branch can be forked arbitrarily
> > long in the past, or it may not even share the ancient part of the
> > history and has its own root commit.
> 
> If a shallow point can reach root without seeing another shallow
> point, we can mark all reachable commits from it shallow. If it sees
> another shallow point, maybe we can mark at the merge point of them..

Hmph, I read your email before sending my other response, but somehow I
didn't quite understand what you were saying. Now after having written
my long-winded other one, I think I just re-invented the same thing you
are proposing here. ;)

> We can also send "here is --depth=10, but only apply it on new refs".
> That should mitigate the problem a bit. But I'm not sure if I can
> solve it completely.

I think "new refs" isn't something we can rely on. For example, in this
case the old history may have been merged in and the ref deleted before
the fetcher shows up.

-Peff
