From: Jeff King <peff@peff.net>
Subject: Re: Fwd: [PATCH 2/2] pretty.c: allow date formats in user format
 strings
Date: Mon, 7 Mar 2011 14:26:41 -0500
Message-ID: <20110307192640.GB20930@sigill.intra.peff.net>
References: <20110305195020.GA3089@sigill.intra.peff.net>
 <20110305200010.GB32095@sigill.intra.peff.net>
 <AANLkTinH8zwX2sbd5bpk=x4R3zOAg3Dc92Fbspfdv03T@mail.gmail.com>
 <AANLkTikaN=wsg6RLFaFxh=L3RCYjKkVGFR4VTrQ=KRZk@mail.gmail.com>
 <20110307161758.GB11934@sigill.intra.peff.net>
 <1299518898.3024.10.camel@wpalmer.simply-domain>
 <1299523834.1835.17.camel@walleee>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Will Palmer <wmpalmer@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 07 20:26:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pwg4x-0007gR-R0
	for gcvg-git-2@lo.gmane.org; Mon, 07 Mar 2011 20:26:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754781Ab1CGT0q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Mar 2011 14:26:46 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:56503 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752610Ab1CGT0q (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Mar 2011 14:26:46 -0500
Received: (qmail 7193 invoked by uid 111); 7 Mar 2011 19:26:44 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Mon, 07 Mar 2011 19:26:44 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 07 Mar 2011 14:26:41 -0500
Content-Disposition: inline
In-Reply-To: <1299523834.1835.17.camel@walleee>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168605>

On Mon, Mar 07, 2011 at 06:50:34PM +0000, Will Palmer wrote:

> I'm home now, and apparently that should have been:
> https://github.com/wpalmer/git/tree/pretty/parse-format
> 
> I assume the code is very hard to follow, as it was pretty much written
> with the mindset of "get it done now, fix it later". Looking into it
> again, I see that part of the reason I abandoned it was not being able
> to determine a good way to split things into logical commits. It's
> almost entirely an "everything works or nothing works" change.

I haven't looked at your code yet, but the breakdown of patches I would
expect / hope for is something like:

  1. introduce infrastructure for creating parse-tree from strbuf_expand
     format, with some tests

  2. port format_commit_* over to new system; I would expect that the
     caller code will have to be part of both the parsing and the
     expansion, since the generic code can't know that "%ad" is
     meaningful (and we want to keep it for backwards compatibility).
     Leave format_commit_message as a parse + expand wrapper for simple
     callers who don't care about speed.

  3. Add generic "%(key:option)" support to the new infrastructure,
     forward-porting format_commit_* as necessary (and hopefully the
     change are minimal...).

So those are all big commits, obviously, but hopefully it lets us review
in three stages: does the new infrastructure look good, does porting an
existing caller (and probably the most complex caller) clean up the
caller code, and then finally, does the new syntax look good?

But of course the devil is in the details, so probably that breakdown
has some flaw in it. :) I'll see when I look at your code how close to
reality I came.

-Peff
