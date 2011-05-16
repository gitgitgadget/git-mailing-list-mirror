From: Jeff King <peff@peff.net>
Subject: Re: RFC proposal: set git defaults options from config
Date: Mon, 16 May 2011 07:05:45 -0400
Message-ID: <20110516110545.GC23889@sigill.intra.peff.net>
References: <D80C1130-8DE6-457E-B203-FCF25B8ED72C@gmail.com>
 <4DCB88C1.20105@drmicha.warpmail.net>
 <20110512080425.GA11870@sigill.intra.peff.net>
 <4DCB96F9.2020700@drmicha.warpmail.net>
 <20110512082210.GA16813@sigill.intra.peff.net>
 <4DCBF01F.9040009@warpmail.net>
 <2235D93D-4F02-42D7-88B1-74F692D58AA5@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael J Gruber <drmicha@warpmail.net>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	GIt Mailing List <git@vger.kernel.org>,
	Git Maintainer <gitster@pobox.com>
To: David Pisoni <dpisoni@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 16 13:06:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QLvcc-00089b-VO
	for gcvg-git-2@lo.gmane.org; Mon, 16 May 2011 13:05:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754896Ab1EPLFt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 May 2011 07:05:49 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:33352
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754447Ab1EPLFs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 May 2011 07:05:48 -0400
Received: (qmail 13435 invoked by uid 107); 16 May 2011 11:07:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 16 May 2011 07:07:49 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 16 May 2011 07:05:45 -0400
Content-Disposition: inline
In-Reply-To: <2235D93D-4F02-42D7-88B1-74F692D58AA5@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173727>

On Thu, May 12, 2011 at 03:36:16PM -0700, David Pisoni wrote:

> This has some interesting implications.  Consider the case at hand:
> git-stash --index is a boolean switch.  It was not the default state,
> and it lacked any configuration override, so there was no
> '--no-index' switch provided.  If we make this change to git,
> presumably EVERY boolean flag like this in all the git subcommands
> needs to be backed with a '--no' counterpart.

Most of them already are, by virtue of parse-options. And I don't
think it's a bad thing for those that don't have one to get one.

> Thinking this through a little further, there is the potential to
> want to override the configured value (in the case of non-booleans)
> with an explicit command line switch.  So now we have "precedence
> rules" for subcommand options. Probably simple to handle this for
> single vars, but harder for multivars.

For single vars, which are most of it, it is pretty simple. For
multivars, mostly "--no-$option" should reset the multivar list
explicitly. I expect there are some oddballs where that is not the case,
though. For example, we just recently found some confusion with
resetting "git status" to its default after seeing "--porcelain".
So there would probably be some cleanup work there.

-Peff
