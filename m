From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] tests: eliminate unnecessary setup test assertions
Date: Fri, 6 May 2011 18:29:51 -0400
Message-ID: <20110506222951.GA24474@sigill.intra.peff.net>
References: <20110503090351.GA27862@elie>
 <4DC1CE16.5030808@dailyvoid.com>
 <7vsjsuc704.fsf@alter.siamese.dyndns.org>
 <20110506205441.GA20182@elie>
 <20110506205851.GB20182@elie>
 <20110506214801.GA17848@sigill.intra.peff.net>
 <20110506221300.GB17848@sigill.intra.peff.net>
 <7voc3fxy6b.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Michael Grubb <devel@dailyvoid.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 07 00:29:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QITX5-0000fd-Hr
	for gcvg-git-2@lo.gmane.org; Sat, 07 May 2011 00:29:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753136Ab1EFW3z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 May 2011 18:29:55 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:55464
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752668Ab1EFW3y (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 May 2011 18:29:54 -0400
Received: (qmail 14318 invoked by uid 107); 6 May 2011 22:31:49 -0000
Received: from sigill-wired.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.8)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 06 May 2011 18:31:49 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 06 May 2011 18:29:51 -0400
Content-Disposition: inline
In-Reply-To: <7voc3fxy6b.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173023>

On Fri, May 06, 2011 at 03:27:08PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Two minor complaints on git-blame; maybe somebody can point out
> > something clever I've missed.
> 
> >   1. blame's "-L" understands patterns already.
> 
> Teaching blame to take multiple -L options has been one of many
> longstanding todo item for me.  Someday.

I think multiple -L is not quite enough. I want a single "-L" that
matches every instance of a pattern, like:

  -L "/ ()/,+0"

> >   2. Parsing the human-readable output blame output sucks. But parsing
> >      --porcelain is annoyingly complex for quick-and-dirty things like
> >      this. It doesn't repeat the commit information per-line.
> 
> Non-repetition was quite deliberate, as the reader was expected to have
> memory proportional to the number of lines in the range, but I agree it is
> not friendly for quick and dirty hack.
> 
> You should be able to add a command line option that disables the early
> return at the beginning of emit_one_suspect_detail() with a 5-6 lines of
> patch.

I tried that, and it is slightly more involved. You also need to break a
multi-line run of lines that blame to a single suspect into its
constituent lines. I am 75% of the way to such a patch if you are
interested. It's not a lot of code, but it takes some refactoring of
emit_porcelain.

-Peff
