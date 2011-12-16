From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] attr: map builtin userdiff drivers to well-known
 extensions
Date: Fri, 16 Dec 2011 14:28:31 -0500
Message-ID: <20111216192831.GB19924@sigill.intra.peff.net>
References: <20111216110000.GA15676@sigill.intra.peff.net>
 <4EEB8517.2030304@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Brandon Casey <drafnel@gmail.com>
To: Mark Levedahl <mlevedahl@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 16 20:28:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RbdSQ-0004H8-MR
	for gcvg-git-2@lo.gmane.org; Fri, 16 Dec 2011 20:28:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760585Ab1LPT2f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Dec 2011 14:28:35 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:44272
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756656Ab1LPT2e (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Dec 2011 14:28:34 -0500
Received: (qmail 7167 invoked by uid 107); 16 Dec 2011 19:35:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 16 Dec 2011 14:35:15 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 16 Dec 2011 14:28:31 -0500
Content-Disposition: inline
In-Reply-To: <4EEB8517.2030304@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187305>

On Fri, Dec 16, 2011 at 12:51:19PM -0500, Mark Levedahl wrote:

> On 12/16/2011 06:00 AM, Jeff King wrote:
> 
> >+	"*.m diff=objc",
> 
> Please don't do this: Matlab files also use .m as a suffix, and there
> is little to no compatibility between objective c and Matlab syntax.

Thanks for the feedback. Unlike JSixt's objection, I think this one is
at the heart of the patch: using file extensions to map to file types is
just a heuristic, and that heuristic can be spectacularly wrong.

And that's why we took the conservative approach until now, and simply
left it up to projects to define their own attributes mapping files to
types (even though we provided funcname patterns for some types).

So I think it is really worth weighing the convenience of "user does not
have to bother configuring attributes for each project" versus "we might
get it wrong".

Fortunately, the "might get it wrong" side is pretty easily mitigated by
making .gitattributes file (i.e., the same thing they would have to do
without this mapping heuristic). So the question is not "did we get it
wrong", but "how much worse is the objc funcname pattern versus the
default one for matlab files". I'd be interested to hear results from
Matlab people.

And of course there's the question of how good or bad each heuristic is.
It sounds like ".c" is more likely to be C than ".m" is to be objc, for
example. So maybe the concept is sound, but "*.m" is too overloaded an
extension to make the default list. I dunno.

-Peff
