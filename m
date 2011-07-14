From: Jeff King <peff@peff.net>
Subject: Re: Git commit generation numbers
Date: Thu, 14 Jul 2011 16:07:17 -0400
Message-ID: <20110714200717.GF26918@sigill.intra.peff.net>
References: <CA+55aFxZq1e8u7kXu1rNDy2UPgP3uOyC5y2j7idKSZ_4eL=bWw@mail.gmail.com>
 <20110714183710.GA26820@sigill.intra.peff.net>
 <CA+55aFwuK+krTA4OcnYhLXtKM5HQ1yuPK+J_vC-5R7AthrHWbg@mail.gmail.com>
 <CA+55aFzvib7QF-J3fBj2brcQifXGqoeK1t7vfx6pcJmJAEO0dw@mail.gmail.com>
 <20110714194638.GE8453@thunk.org>
 <CA+55aFzuQnfo1iywnp-WAajMHe2+6_HOM85aw0bS+p0xv5RyhA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Ted Ts'o <tytso@mit.edu>, Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Jul 14 22:07:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QhSBy-0003Rd-3H
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jul 2011 22:07:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753328Ab1GNUHU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jul 2011 16:07:20 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:54277
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753065Ab1GNUHT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jul 2011 16:07:19 -0400
Received: (qmail 11206 invoked by uid 107); 14 Jul 2011 20:07:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 14 Jul 2011 16:07:44 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 14 Jul 2011 16:07:17 -0400
Content-Disposition: inline
In-Reply-To: <CA+55aFzuQnfo1iywnp-WAajMHe2+6_HOM85aw0bS+p0xv5RyhA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177170>

On Thu, Jul 14, 2011 at 12:51:39PM -0700, Linus Torvalds wrote:

> On Thu, Jul 14, 2011 at 12:46 PM, Ted Ts'o <tytso@mit.edu> wrote:
> >
> > Would it be considered evil if we put the generation number in the
> > pack, but not consider it part of the formal object (i.e., it would be
> > just a cache, but one that wouldn't change once the pack was created)?
> 
> That would actually be a major change to data structures, and would
> require some serious surgery and be hard to support in a
> backwards-compatible way (think different git versions accessing the
> same repository).

If we put it in the index, but not the pack, then it wouldn't be any
more painful than pack index v2. I don't recall there being huge fallout
from that; we just gave a reasonable deprecation period before switching
it on as the default.

I'm not sure it is much less crappy than having the cache in a separate
file. It does take less space, since the pack index already contains all
of the sha1s. But if we don't like the on-the-fly writing of what was in
my series, it would not be hard to generate the same cache during
pack-index time. Not having it in a separate file makes it hard to
invalidate the cache when the graph changes (due to grafts or replace
refs). But maybe we don't care about that. Or maybe it's OK to tell the
user to manually rebuild the pack index if they tweak those features.

-Peff
