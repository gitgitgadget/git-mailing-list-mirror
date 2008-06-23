From: Jeff King <peff@peff.net>
Subject: Re: [RFC] Re: Convert 'git blame' to parse_options()
Date: Mon, 23 Jun 2008 14:15:17 -0400
Message-ID: <20080623181517.GA28527@sigill.intra.peff.net>
References: <alpine.LFD.1.10.0806222207220.2926@woody.linux-foundation.org> <20080623082223.GA12130@artemis.madism.org> <alpine.DEB.1.00.0806231312130.6440@racer> <alpine.LFD.1.10.0806230912230.2926@woody.linux-foundation.org> <20080623164917.GA25474@sigill.intra.peff.net> <alpine.LFD.1.10.0806230953550.2926@woody.linux-foundation.org> <20080623171505.GB27265@sigill.intra.peff.net> <alpine.LFD.1.10.0806231027210.2926@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Pierre Habouzit <madcoder@debian.org>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Jun 23 20:17:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAqbF-0003Q5-9u
	for gcvg-git-2@gmane.org; Mon, 23 Jun 2008 20:17:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761813AbYFWSPX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2008 14:15:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761802AbYFWSPW
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jun 2008 14:15:22 -0400
Received: from peff.net ([208.65.91.99]:1213 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761727AbYFWSPU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jun 2008 14:15:20 -0400
Received: (qmail 27949 invoked by uid 111); 23 Jun 2008 18:15:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Mon, 23 Jun 2008 14:15:18 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 23 Jun 2008 14:15:17 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.10.0806231027210.2926@woody.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85896>

On Mon, Jun 23, 2008 at 10:32:21AM -0700, Linus Torvalds wrote:

> > How can that be correct, if you don't know whether "-b" takes an
> > argument?
> 
> Did you read my post or not?
> 
> If you have that case, then use STOP_ON_UNKNOWN.

How do you know that is the case, unless you know what the other option
parsers are going to do? Or are you suggesting that I check every other
downstream option parser to make sure that it's OK in this particular
instance, use IGNORE_UNKNOWN, and then laugh maniacally when somebody
adds such an option to the diff option parser later?

> Umm. Helloo, reality.. There are actually very few options that take a 
> flag for their arguments. In particular, the option parsing we really 
> _care_ about (revision parsing - see builtin-blame.c which is exactly 
> where I wanted to convert things) very much DOES NOT.

Reality: revision.c, lines 1008-1012. "-n" takes an argument.
Reality: revision.c, lines 1075-1080. "--default" takes an argument.

> Try just looking at the code!

I did. Or maybe you missed the thread where this exact feature was
mentioned, and I already looked at the code and mentioned those two
spots. It's right here:

  http://thread.gmane.org/gmane.comp.version-control.git/85354/focus=85355

> So I'm really not interested in arguing about "theoretical issues", when 
> we have a real-life *practical* issue to solve.
> 
> Solve builtin-blame.c for me. I sent out a patch yesterday, but in the 
> description of that patch I also described exactly why I want 
> CONTINUE_ON_UNKNOWN.

There is already a discussion underway about the proper solution. This
isn't just a git-blame issue, but rather an issue with all commands that
have their own options and take revision parameters. So I think rather
than doing a halfway fix that happens to work with git-blame, it is more
useful to focus on a solution that works everywhere and fix _all_ of the
problems.

-Peff
