From: Jeff King <peff@peff.net>
Subject: Re: git log --follow doesn't follow a rename over a merge
Date: Thu, 16 Jun 2011 13:45:54 -0400
Message-ID: <20110616174554.GC6584@sigill.intra.peff.net>
References: <BANLkTimjEp0ntq80qttT9uZN2YGuhsnZBw@mail.gmail.com>
 <m362o5vrhd.fsf@localhost.localdomain>
 <BANLkTik1-UvEXqzgdXwcK3x6_o8fDiwB7g@mail.gmail.com>
 <BANLkTi=4S08h=uMV5oo7S9qpruMot2kVfg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: James Blackburn <jamesblackburn@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 16 19:46:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QXGdm-0002wR-6S
	for gcvg-git-2@lo.gmane.org; Thu, 16 Jun 2011 19:46:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758485Ab1FPRp5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jun 2011 13:45:57 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:58829
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757906Ab1FPRp4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jun 2011 13:45:56 -0400
Received: (qmail 15415 invoked by uid 107); 16 Jun 2011 17:46:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 16 Jun 2011 13:46:07 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 16 Jun 2011 13:45:54 -0400
Content-Disposition: inline
In-Reply-To: <BANLkTi=4S08h=uMV5oo7S9qpruMot2kVfg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175905>

On Thu, Jun 16, 2011 at 06:01:25PM +0100, James Blackburn wrote:

> I see a lot of this has been discussed before... but just to add that
> Jeff's blame-log.sh:
> http://git.661346.n2.nabble.com/alternate-log-follow-idea-td1385917.html
> seems to work and show the full history of the file past the rename+merge!

You may want to also check out the "line-level history browser" work by
Bo Yang and Thomas Rast, which is a similar idea, but done much better.

You can find it here:

  http://repo.or.cz/w/git/trast.git/shortlog/refs/heads/line-log-cleanup

or pull it with:

  git pull git://repo.or.cz/git/trast.git line-log-cleanup

Use on a whole file is something like:

  git log -L '1,$':yourfile

But note that it is a work in progress, and I seem to be able to get it
to segfault on some simple tests.

> I was also interested in whether there's a better way of re-connecting
> history than grafting one repository's history into the commit which
> made it visible in another?  AFAICS the graft is no different to a
> merge commit which contains a rename in the merged node, so I'm
> guessing this is a reasonable thing to do?

Usually you would graft the tip of the old history to the root commit of
the new history. So it's not a merge, but makes it look like a
contiguous linear history near the graft. But that's only a
per-repository thing. If you want to join two histories in the actual
history graph, you would merge them; if one supersedes the other, then
you would use the "ours" merge strategy to ignore the other side.

I'm not 100% sure I understand your question. Does that answer make
sense?

-Peff
