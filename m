From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] log --decorate: do not leak "commit" color into the next
 item
Date: Thu, 19 Feb 2015 20:42:31 -0500
Message-ID: <20150220014230.GA16124@peff.net>
References: <xmqqzj8b0w6t.fsf@gitster.dls.corp.google.com>
 <xmqqpp9628tl.fsf@gitster.dls.corp.google.com>
 <20150218230728.GA17302@peff.net>
 <xmqqvbixzsnv.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 20 04:29:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YOeHH-0007SA-D9
	for gcvg-git-2@plane.gmane.org; Fri, 20 Feb 2015 04:29:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753417AbbBTD3P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Feb 2015 22:29:15 -0500
Received: from cloud.peff.net ([50.56.180.127]:51347 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753392AbbBTD3P (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Feb 2015 22:29:15 -0500
Received: (qmail 28158 invoked by uid 102); 20 Feb 2015 03:29:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 19 Feb 2015 21:29:15 -0600
Received: (qmail 5427 invoked by uid 107); 20 Feb 2015 01:42:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 19 Feb 2015 20:42:32 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 19 Feb 2015 20:42:31 -0500
Content-Disposition: inline
In-Reply-To: <xmqqvbixzsnv.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264131>

On Thu, Feb 19, 2015 at 10:02:12AM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Yeah, I think this is a good fix. I had a vague feeling that we may have
> > done this on purpose to let the decoration color "inherit" from the
> > existing colors for backwards compatibility, but I don't think that
> > could ever have worked (since color.decorate.* never defaulted to
> > "normal").
> 
> Hmph, but that $gmane/191118 talks about giving bold to commit-color
> and then expecting for decors to inherit the boldness, a wish I can
> understand.  But I do not necessarily agree with it---it relies on
> that after "<commit-color>(" and "<commit-color>, " there is no reset,
> which is not how everything else works.

I don't see anybody actually _wanting_ the inheritance. It is mentioned
merely as an observation. So yeah, we would break anybody who does:

  [color "diff"]
  commit = blue

  [color "decorate"]
  branch = normal
  remoteBranch = normal
  tag = normal
  stash = normal
  HEAD = normal

and expects the "blue" to persist automatically.

But given that this behaves in the opposite way of every other part of
git's color handling, I think we can call it a bug, and people doing
that are crazy (they should s/normal/blue/ in the latter config).

> So this change at least needs to come with an explanation to people
> who are used to and took advantage of this color attribute leakage,
> definitely in the log message and preferrably to the documentation
> that covers all the color.*.<slot> settings, I think.

I'd agree it is worth a mention in the log (and possibly release notes),
but I don't think it is worth polluting the documentation forever
(though explaining that we never inherit might be worth doing, and that
is perhaps what you meant).

-Peff
