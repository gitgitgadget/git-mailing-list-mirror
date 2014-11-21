From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] copy.c: make copy_fd preserve meaningful errno
Date: Fri, 21 Nov 2014 12:54:47 -0500
Message-ID: <20141121175446.GA26650@peff.net>
References: <1416262453-30349-1-git-send-email-sbeller@google.com>
 <546F0284.7050904@alum.mit.edu>
 <546F033F.7030201@alum.mit.edu>
 <xmqqa93k1m3g.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
	Ronnie Sahlberg <sahlberg@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 21 18:54:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XrsQ1-0003O4-HM
	for gcvg-git-2@plane.gmane.org; Fri, 21 Nov 2014 18:54:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751152AbaKURyu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Nov 2014 12:54:50 -0500
Received: from cloud.peff.net ([50.56.180.127]:43287 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750770AbaKURyt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Nov 2014 12:54:49 -0500
Received: (qmail 14943 invoked by uid 102); 21 Nov 2014 17:54:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 21 Nov 2014 11:54:49 -0600
Received: (qmail 25721 invoked by uid 107); 21 Nov 2014 17:55:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 21 Nov 2014 12:55:02 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 21 Nov 2014 12:54:47 -0500
Content-Disposition: inline
In-Reply-To: <xmqqa93k1m3g.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 21, 2014 at 09:48:19AM -0800, Junio C Hamano wrote:

> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
> > On 11/21/2014 10:14 AM, Michael Haggerty wrote:
> >> Couldn't we save ourselves a lot of this "save_errno" boilerplate by
> >> making error() and warning() preserve errno? [...]
> >
> > Never mind; I see that Peff already submitted a patch to this effect.
> 
> My understanding of the conclusion of those four patches was that
> only a single updated one is needed, and "moving save/restore inside
> error()" did not have to survive.
> 
>   http://article.gmane.org/gmane.comp.version-control.git/259911

Yeah, the callsite I had intended ended up needing to save it across
more than just error(). And I think that is probably why we have never
done any errno-handling inside error() before (it is certainly not the
first time I thought of doing such a thing): real-world cases tend to be
a little more complicated.

That being said, if this copy() case is one that could benefit, I do not
have any problem with picking up (or just reusing the concept of) my
1/4 from that series. It probably does not _hurt_ anything, and if it
can help in even a few cases, it may be worth it.

-Peff
