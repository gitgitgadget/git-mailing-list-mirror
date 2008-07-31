From: Jeff King <peff@peff.net>
Subject: Re: git blame not respecting --find-copies-harder ?
Date: Thu, 31 Jul 2008 03:21:49 -0400
Message-ID: <20080731072149.GA2304@sigill.intra.peff.net>
References: <20080730093903.GA14330@cuci.nl> <20080730150123.GB9758@atjola.homenet> <bd6139dc0807300843l1d42d6fep95f6c99fe6e0ea0@mail.gmail.com> <20080731064814.GA32431@sigill.intra.peff.net> <7vfxpq3559.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: sverre@rabbelier.nl,
	=?utf-8?B?QmrDtnJu?= Steinbrink <B.Steinbrink@gmx.de>,
	"Stephen R. van den Berg" <srb@cuci.nl>,
	Git Mailinglist <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 31 09:23:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOSUw-0001Qn-Hd
	for gcvg-git-2@gmane.org; Thu, 31 Jul 2008 09:22:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753069AbYGaHVw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jul 2008 03:21:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753292AbYGaHVv
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Jul 2008 03:21:51 -0400
Received: from peff.net ([208.65.91.99]:4997 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753042AbYGaHVv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jul 2008 03:21:51 -0400
Received: (qmail 21635 invoked by uid 111); 31 Jul 2008 07:21:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Thu, 31 Jul 2008 03:21:50 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 31 Jul 2008 03:21:49 -0400
Content-Disposition: inline
In-Reply-To: <7vfxpq3559.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90904>

On Thu, Jul 31, 2008 at 12:05:22AM -0700, Junio C Hamano wrote:

> We can probably pick up the result revision parser parsed out of
> revs.diffopt, and then tweak "opt" with it, perhaps like this.

That is a sensible solution for this option, but I have to wonder: how
many other such ineffective options are hiding? How many of them
actually have a matching meaning in git-blame? E.g., what does "git
blame --name-only" mean?

Perhaps we should simply not worry about those ones, as people are
unlikely to try using them, and it is easy to say "has no impact,
because it doesn't make sense with blame." The truly confusing ones are
ones you _expect_ to do something, but don't (like
--find-copies-harder).

I took a look at implementing a "don't parse the diff options" flag, but
it is much larger than that. The revision parser understands a lot of
options that don't really make sense for blame (or shortlog), like
"--full-diff". So perhaps it is best to just fix this one (which we have
actually had a bug report about) and not worry about the rest.

-Peff
