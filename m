From: Jeff King <peff@peff.net>
Subject: Re: Git commit generation numbers
Date: Thu, 14 Jul 2011 15:12:52 -0400
Message-ID: <20110714191252.GB26918@sigill.intra.peff.net>
References: <CA+55aFxZq1e8u7kXu1rNDy2UPgP3uOyC5y2j7idKSZ_4eL=bWw@mail.gmail.com>
 <20110714183710.GA26820@sigill.intra.peff.net>
 <CA+55aFwuK+krTA4OcnYhLXtKM5HQ1yuPK+J_vC-5R7AthrHWbg@mail.gmail.com>
 <CA+55aFzvib7QF-J3fBj2brcQifXGqoeK1t7vfx6pcJmJAEO0dw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Jul 14 21:13:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QhRLH-0006Uq-Kh
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jul 2011 21:13:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753802Ab1GNTMz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jul 2011 15:12:55 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:59383
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753711Ab1GNTMy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jul 2011 15:12:54 -0400
Received: (qmail 10381 invoked by uid 107); 14 Jul 2011 19:13:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 14 Jul 2011 15:13:19 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 14 Jul 2011 15:12:52 -0400
Content-Disposition: inline
In-Reply-To: <CA+55aFzvib7QF-J3fBj2brcQifXGqoeK1t7vfx6pcJmJAEO0dw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177161>

On Thu, Jul 14, 2011 at 11:55:39AM -0700, Linus Torvalds wrote:

> I'm actually much more nervous about a cache being inconsistent than I
> would be about having generation numbers in the tree. The latter we
> can (and should - but my patch didn't) add a fsck test for, and then
> you would never get into some situation where there's some really
> subtle issue with merge base calculation due to a corrupt cache.

Interesting. I'm nervous about that, too, which is why I _favor_ the
cache. Because we calculate the cache ourselves, we know its accurate
according to the parent pointers. If we find a bug, we fix it and bump
the cache version, which forces it to regenerate.

Contrast that with a bogus generation number that makes its way into an
actual commit object. That's there for eternity, just like the commit
timestamp skew we already have. I find it much less likely to happen
than skew in the commit timestamp, if only because generations are a
dirt-simple concept. But it is a case where there is duplicated
information in the actual DAG, and if that information doesn't match up
we are screwed.

-Peff
