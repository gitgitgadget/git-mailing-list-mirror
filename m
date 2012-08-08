From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Enable HAVE_DEV_TTY for Solaris
Date: Wed, 8 Aug 2012 17:05:31 -0400
Message-ID: <20120808210531.GA12822@sigill.intra.peff.net>
References: <20120807003541.GA18219@sigill.intra.peff.net>
 <1344308862-24635-1-git-send-email-bwalton@artsci.utoronto.ca>
 <7v4nofxt89.fsf@alter.siamese.dyndns.org>
 <20120807040326.GA18682@sigill.intra.peff.net>
 <20120807041026.GA21918@sigill.intra.peff.net>
 <CABPQNSaUCEDU4+2N63n0k_XwSXOP_iFZG3GEYSPSBPcSVV8wRQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Ben Walton <bwalton@artsci.utoronto.ca>, git@vger.kernel.org,
	rctay89@gmail.com, schwab@linux-m68k.org
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 08 23:05:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SzDRn-0001sw-2C
	for gcvg-git-2@plane.gmane.org; Wed, 08 Aug 2012 23:05:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759307Ab2HHVFi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Aug 2012 17:05:38 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:57700 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753001Ab2HHVFh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Aug 2012 17:05:37 -0400
Received: (qmail 11798 invoked by uid 107); 8 Aug 2012 21:05:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 08 Aug 2012 17:05:44 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 08 Aug 2012 17:05:31 -0400
Content-Disposition: inline
In-Reply-To: <CABPQNSaUCEDU4+2N63n0k_XwSXOP_iFZG3GEYSPSBPcSVV8wRQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203132>

On Wed, Aug 08, 2012 at 04:13:03PM +0200, Erik Faye-Lund wrote:

> On Tue, Aug 7, 2012 at 6:10 AM, Jeff King <peff@peff.net> wrote:
> > Subject: [PATCH] terminal: seek when switching between reading and writing
> >
> > When a stdio stream is opened in update mode (e.g., "w+"),
> > the C standard forbids switching between reading or writing
> > without an intervening positioning function. Many
> > implementations are lenient about this, but Solaris libc
> > will flush the recently-read contents to the output buffer.
> > In this instance, that meant writing the non-echoed password
> > that the user just typed to the terminal.
> >
> > Fix it by inserting a no-op fseek between the read and
> > write.
> 
> My Windows-patches for git_terminal_prompt would probably also solve
> this problem. Instead of opening a read-write handle to /dev/tty, they
> open two handles to the terminal instead; one for reading and one for
> writing. This is because the terminal cannot be opened in read-write
> mode on Windows (we need to open "CONIN$" and "CONOUT$" separately).

Yeah, it would solve it, although it means opening /dev/tty twice (which
is probably not a big deal, though). I'm fine if we go that way in the
long run to share implementations, but let's treat it as a separate
topic.  This fix is an obvious one-liner, and is just fixing me being
stupid about actually following the C standard. So it's a no-brainer for
as a maintenance fix.

> You can have a look at the series here if you're interested:
> https://github.com/kusma/git/tree/work/terminal-cleanup
> 
> That last patch is the reason why I haven't submitted the series yet,
> but perhaps some of the preparatory patches could be worth-while for
> other platforms in the mean time?

Yeah, that last patch is really gross. There's no explanation of the
race issue, so I'll refrain from thinking about it until you are ready
to post a series. :)

-Peff
