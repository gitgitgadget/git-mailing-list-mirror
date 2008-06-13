From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] git-gc: skip stashes when expiring reflogs
Date: Fri, 13 Jun 2008 13:30:42 -0400
Message-ID: <20080613173041.GA7974@sigill.intra.peff.net>
References: <OLvkESB0JjBNs9kF8Q2M5UFNBJqq4FjbgGeQVyWstGwcXqCOq16_oomM0y-utOBbV7BnndyrICE@cipher.nrlssc.navy.mil> <5vuJsx6Kidj7e8EABk_d63dLAYuWF-S880RrJKu83cJo_ejU3VN-VA@cipher.nrlssc.navy.mil> <20080611213648.GA13362@glandium.org> <alpine.DEB.1.00.0806112242370.1783@racer> <20080611230344.GD19474@sigill.intra.peff.net> <co7kgJpJNdIs2f8n_PwYKAS7MwV9t1G_P3BPr1eXTZ4ytUHcsPvVaw@cipher.nrlssc.navy.mil> <20080612041847.GB24868@sigill.intra.peff.net> <u5dYyGz0Q8KNQXnvGOEGmG2BTfT-vJCEFeSUa2I_99Q@cipher.nrlssc.navy.mil> <20080613054840.GA27122@sigill.intra.peff.net> <GL75k5fYVorDQQh654Db9qgZ3DAr5EfRqLBwQe-VpacRGGbsy3c7WA@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mike Hommey <mh@glandium.org>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Wincent Colaiuta <win@wincent.com>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Fri Jun 13 19:31:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7D7r-0006nD-NV
	for gcvg-git-2@gmane.org; Fri, 13 Jun 2008 19:31:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751372AbYFMRaq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jun 2008 13:30:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751360AbYFMRaq
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jun 2008 13:30:46 -0400
Received: from peff.net ([208.65.91.99]:2904 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751359AbYFMRap (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2008 13:30:45 -0400
Received: (qmail 8597 invoked by uid 111); 13 Jun 2008 17:30:44 -0000
Received: from lawn-128-61-17-201.lawn.gatech.edu (HELO sigill.intra.peff.net) (128.61.17.201)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Fri, 13 Jun 2008 13:30:44 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 13 Jun 2008 13:30:42 -0400
Content-Disposition: inline
In-Reply-To: <GL75k5fYVorDQQh654Db9qgZ3DAr5EfRqLBwQe-VpacRGGbsy3c7WA@cipher.nrlssc.navy.mil>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84905>

On Fri, Jun 13, 2008 at 11:43:42AM -0500, Brandon Casey wrote:

> > No, but it would have to be performed _after_ the expiration, but
> > _before_ any auto-gc happened. So it is a smaller window than "anytime
> > after expiration" but not as small as a particular 30-second window.
> 
> Right, that's why I showed the 'git-stash list' which still had the
> stash entry before the 'git-pull'.

Right, but I meant that you would have to perform the example commands
you gave after the expiration, but before you had done anything that did
an auto-gc. So you could do it at day 31, unless on day 30 you had done
a "git pull".

But somebody else mentioned that they leave cloned working trees sitting
around, and then find them later. So they might truly have done no
commands.

At any rate, I don't think is especially relevant.

> Funny you should mentioned that since I had thought of using a similar
> example in defense of my point of view. So I offer a question: after how
> much time after you have yanked some text into a register in vi do you
> expect vi to clear that register?

After 10 other yanks? ;)

I was referring not to the named registers, but to the unnamed ones.
IOW, I know that vim will keep my registers from session to session. But
when I yank, it implicitly goes into "0, and the old "0 bumps to "1, "1
to "2, and so forth. "9 is thrown away.

And I think that works pretty well in practice. The size is bounded, but
text stays around long enough for me to use it. And if I want storage
that is guaranteed to last (and I sometimes do), then I use a named
register.

Now here we are bounding by time rather than by number of stashes, but
it is the same concept.

> yanks as being tied to the session. Similarly with something like X11
> when you highlight text, you expect it to be there in the copy buffer
> until other text is highlighted or until X terminates.

Ah, if only that was how X cut buffers actually worked. ;)

> I see it as less of a workflow issue than a safety issue, and a user
> interface issue. I don't know if there are workflows that would be
> made possible by not expiring the stash. I do think the benefit of
> automatically cleaning out the stash so it doesn't accumulate old
> cruft is less important to me than an intuitive interface and
> predictable behavior.

At this point I am inclined to agree. Enough people seem to want to
leave things stashed for long periods that it is a potential hazard to
people who don't know about the expiration. And while I prefer the
expiring cruft behavior, not expiring it isn't _that_ big a deal to me,
compared against the potential for loss.

-Peff
