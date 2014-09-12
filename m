From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] pretty-format: add append line-feed format specifier
Date: Fri, 12 Sep 2014 00:49:01 -0400
Message-ID: <20140912044901.GC15519@peff.net>
References: <540F426E.6080908@exec64.co.uk>
 <xmqqmwa8k3lg.fsf@gitster.dls.corp.google.com>
 <540F554C.5010301@exec64.co.uk>
 <xmqqegvkk2k3.fsf@gitster.dls.corp.google.com>
 <20140909214520.GA13603@peff.net>
 <xmqqtx4fgzqe.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Harry Jeffery <harry@exec64.co.uk>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 12 06:49:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XSInH-0005HF-Oa
	for gcvg-git-2@plane.gmane.org; Fri, 12 Sep 2014 06:49:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751066AbaILEtG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Sep 2014 00:49:06 -0400
Received: from cloud.peff.net ([50.56.180.127]:47324 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751096AbaILEtF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Sep 2014 00:49:05 -0400
Received: (qmail 656 invoked by uid 102); 12 Sep 2014 04:49:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 11 Sep 2014 23:49:04 -0500
Received: (qmail 31751 invoked by uid 107); 12 Sep 2014 04:49:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 12 Sep 2014 00:49:24 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 12 Sep 2014 00:49:01 -0400
Content-Disposition: inline
In-Reply-To: <xmqqtx4fgzqe.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256898>

On Wed, Sep 10, 2014 at 10:19:21AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Something like the patch below might work, but I didn't test it very
> > thoroughly (and note the comments, which might need dealing with). Maybe
> > it would make a sensible base for Harry to build on if he wants to
> > pursue this.
> >
> > With it, you can do:
> >
> >   git log --format='%h %s%if(%d,%n  Decoration:%d)' origin
> > ...
> > You could also make "%d" more flexible with it. We unconditionally
> > include the " (...)" wrapper when expanding it. But assuming we
> > introduced a "%D" that is _just_ the decoration names, you could do:
> >
> >   %if(%D, (%D))
> >
> > to get the same effect with much more flexibility.
> 
> Yup.
> 
> I do not think we need to go overboard to support nesting and stuff,
> let alone turing completeness ;-), especially when we are going to
> test the condition part only for emptyness.  Even with this simple
> patch, I sense that we are near a slipperly slope of wanting to add
> %unless(%d, ) or %ifelse(%d,%d, \(undefined\)), so I am not 100%
> convinced yet.

What compelled me is the fact that we already started down the slippery
slope with %+ and friends. Providing conditionals but then only allowing
certain characters seems weirdly limiting. But I guess it is all part of
the same slope.

I dunno. I wrote that original set of lua pretty-format patches to try
to stop the insanity once and for all. But I realized that I do not
actually want to do anything complicated with the output formats, and
"--oneline" and a few simple "--format" calls usually are enough. And if
I do want more, I pipe it into a perl script (typically using --format
to make it simple to parse).

We could also provide the data in some standard structured format like
JSON to make the "pipe to your language of choice" option easier on
people. But using custom --formats to do so is not that hard, and is way
more efficient than dumping all of the data.

-Peff
