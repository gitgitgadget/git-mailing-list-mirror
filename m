From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/8] config-include fixes
Date: Thu, 16 Feb 2012 19:14:38 -0500
Message-ID: <20120217001438.GD4756@sigill.intra.peff.net>
References: <7v4nuuea7r.fsf@alter.siamese.dyndns.org>
 <20120214214729.GA24711@sigill.intra.peff.net>
 <7vmx8l5aw3.fsf@alter.siamese.dyndns.org>
 <20120214220953.GC24802@sigill.intra.peff.net>
 <20120216080102.GA11793@sigill.intra.peff.net>
 <7v1upuzgfr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 17 01:14:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RyBTK-0005IT-02
	for gcvg-git-2@plane.gmane.org; Fri, 17 Feb 2012 01:14:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753981Ab2BQAOk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Feb 2012 19:14:40 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:38859
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752503Ab2BQAOk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Feb 2012 19:14:40 -0500
Received: (qmail 2044 invoked by uid 107); 17 Feb 2012 00:21:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 16 Feb 2012 19:21:51 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 16 Feb 2012 19:14:38 -0500
Content-Disposition: inline
In-Reply-To: <7v1upuzgfr.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190926>

On Thu, Feb 16, 2012 at 12:11:52PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I prepared this on top of what you have queued in jk/config-include.
> > However, all of the cleanup is semantically independent of the topic
> > (though there are a few minor textual conflicts). If I were re-rolling,
> > I would put it all at the front, then squash patch 8 into my prior
> > "implement config includes" patch.
> 
> Sorry for being late in answering the "revert or build on top" question; I
> was mostly offline yesterday afternoon.

No problem. I did it as build-on-top because it's much easier to squash
and reorder the commits later than it is to pick a re-roll apart into
multiple commits.

Which way did you want me to go with it?

> Looking at the rebased result, it strikes me that with_options version
> 
>     Furthermore, by providing a more "advanced" interface, we
>     now have a a natural place to add new options for callers
>     like git-config, which care about tweaking the specifics of
>     config lookup, without disturbing the large number of
>     "simple" users (i.e., every other part of git).
> 
> perhaps wants to get a pointer to struct config_lookup_options, instead of
> us having to add a new parameter to all callsites every time a new need
> is discovered.

I considered that, but I noticed that the only callers who are really
going to care about the _with_options version will be in
builtin/config.c, and they all care about every option. And dealing with
creating a struct for each call seemed like more hassle.

OTOH, I could probably just make a single static global
config_lookup_options, and have all of the option parsing tweak it
directly (i.e., replace the given_config_file and respect_includes
static globals).

-Peff
