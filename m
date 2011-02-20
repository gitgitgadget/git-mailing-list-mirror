From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH 4/4] inexact rename detection eye candy
Date: Sun, 20 Feb 2011 05:04:24 -0500
Message-ID: <20110220100424.GB988@sigill.intra.peff.net>
References: <20110219101936.GB20577@sigill.intra.peff.net>
 <20110219102533.GD22508@sigill.intra.peff.net>
 <AANLkTi=s6FxnYVv3UinV4Q+4C_9dX9rCLQQoCFD7kG9S@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 20 11:04:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pr69i-0001or-CX
	for gcvg-git-2@lo.gmane.org; Sun, 20 Feb 2011 11:04:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753005Ab1BTKE2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Feb 2011 05:04:28 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:60318 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752654Ab1BTKE1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Feb 2011 05:04:27 -0500
Received: (qmail 16598 invoked by uid 111); 20 Feb 2011 10:04:26 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Sun, 20 Feb 2011 10:04:26 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 20 Feb 2011 05:04:24 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTi=s6FxnYVv3UinV4Q+4C_9dX9rCLQQoCFD7kG9S@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167411>

On Sat, Feb 19, 2011 at 11:29:33AM -0500, Martin Langhoff wrote:

> On Sat, Feb 19, 2011 at 5:25 AM, Jeff King <peff@peff.net> wrote:
> > During a merge, we might spend many seconds doing inexact
> > rename detection. It's nice to let the user know that
> > something is actually happening.
> 
> Given that we're doing costly work, could the results of rename
> matching be recorded in a .git/MERGE_RENAMES file?
> 
> If that file's available, the simple merge-helper script I've
> described is possible...

Yeah we can if it's useful, but I'd rather see a prototype merge helper
first. In particular, your merge helper seems like it would help in two
situations:

  1. In a rename/rename conflict, you have X becoming Y on one branch
     and Z on the other. You want to say "X should have become Y", and
     then have it 3-way merge X, Y, and Z, storing the result under the
     name Y.

     For that do we actually want the rename list, or just the list of
     rename/rename conflicts?

  2. If git misses a rename, then by definition won't that rename not be
     in the MERGE_RENAMES list? I guess it may have picked up the rename
     on one half of history, and you could use that?

     I'm not quite clear on the exact usage.

So it makes sense to me to get a working merge helper that just uses
"git diff" as appropriate to look up old renames, and then we'll know
what information is required.

-Peff
