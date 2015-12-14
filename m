From: Jeff King <peff@peff.net>
Subject: Re: git bisect with temporary commits
Date: Mon, 14 Dec 2015 16:26:36 -0500
Message-ID: <20151214212636.GG14788@sigill.intra.peff.net>
References: <20151214163726.GY13519@tonks>
 <87si34hphr.fsf@igel.home>
 <20151214210936.GD14788@sigill.intra.peff.net>
 <xmqqegeoivcg.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Andreas Schwab <schwab@linux-m68k.org>,
	Florian Bruhin <me@the-compiler.org>, git@vger.kernel.org,
	r.seitz@beh.ch
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 14 22:26:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a8adn-0005Qm-UQ
	for gcvg-git-2@plane.gmane.org; Mon, 14 Dec 2015 22:26:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753549AbbLNV0k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Dec 2015 16:26:40 -0500
Received: from cloud.peff.net ([50.56.180.127]:41530 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753212AbbLNV0j (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Dec 2015 16:26:39 -0500
Received: (qmail 19883 invoked by uid 102); 14 Dec 2015 21:26:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 14 Dec 2015 15:26:39 -0600
Received: (qmail 31920 invoked by uid 107); 14 Dec 2015 21:26:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 14 Dec 2015 16:26:45 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 14 Dec 2015 16:26:36 -0500
Content-Disposition: inline
In-Reply-To: <xmqqegeoivcg.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282421>

On Mon, Dec 14, 2015 at 01:17:03PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> >> You should instead tell git that HEAD^ is good, since that is what git
> >> asked you to test.
> >
> > Another alternative is to use "git cherry-pick -n" to create a working
> > tree state that you can test, but leave HEAD at the original commit.
> > Then "git bisect good" does the right thing.
> 
> I was about to say the same, and "bisect good" at that point does
> mark the correct commit, but does it always do the right thing?  I
> think the procedure must be
> 
> 	git cherry-pick -n $the_fixup
>         test
>         git reset --hard
>         git bisect good (or bad)

Hmm, you're right. I assumed "git bisect good" would do the equivalent
of "git checkout -f", but it doesn't. I guess it has been long enough
since I have had to cherry-pick a fix that I completely forgot that bit.

It might be convenient if bisect did pass "-f" to checkout, but I guess
it would also be destructive if you had hand-tweaks you forgot to save.

-Peff
