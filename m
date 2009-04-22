From: Jeff King <peff@peff.net>
Subject: Re: dangling commits and blobs: is this normal?
Date: Wed, 22 Apr 2009 15:58:54 -0400
Message-ID: <20090422195854.GA14146@coredump.intra.peff.net>
References: <450196A1AAAE4B42A00A8B27A59278E70ACE0502@EXCHANGE.trad.tradestation.com> <20090422152719.GA12881@coredump.intra.peff.net> <W0cjdA0pSHr_AbT2c-k5hDf7LyNvwkc38qIIhTtJJRwFnGBxaBsEiw@cipher.nrlssc.navy.mil> <alpine.LFD.2.00.0904221331450.6741@xanadu.home> <vpqws9cd06b.fsf@bauges.imag.fr> <20090422190856.GB13424@coredump.intra.peff.net> <I5p8gPPuE_qW2RDhwiqxCWDuMtnuvvgtSkeTkxby6rlj_FKtpERaBA@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, Nicolas Pitre <nico@cam.org>,
	John Dlugosz <JDlugosz@TradeStation.com>, git@vger.kernel.org
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Wed Apr 22 22:00:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lwich-0003Zf-RB
	for gcvg-git-2@gmane.org; Wed, 22 Apr 2009 22:00:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754955AbZDVT7G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Apr 2009 15:59:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754721AbZDVT7F
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Apr 2009 15:59:05 -0400
Received: from peff.net ([208.65.91.99]:43882 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754641AbZDVT7C (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Apr 2009 15:59:02 -0400
Received: (qmail 17856 invoked by uid 107); 22 Apr 2009 19:59:07 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 22 Apr 2009 15:59:07 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 22 Apr 2009 15:58:54 -0400
Content-Disposition: inline
In-Reply-To: <I5p8gPPuE_qW2RDhwiqxCWDuMtnuvvgtSkeTkxby6rlj_FKtpERaBA@cipher.nrlssc.navy.mil>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117246>

On Wed, Apr 22, 2009 at 02:45:29PM -0500, Brandon Casey wrote:

> > Yes, it's a bit more work for you, but having "git gc" optimize by
> > default for git's performance seems to be the only sensible course.
> > Your idea of what is "big enough" above is somewhat outside the realm of
> > git, so you have to pay the price to specify it by tweaking the
> > keep-files.
> 
> But isn't git-gc supposed to be the "high-level" command that just does
> the right thing?  It doesn't seem to me to be outside the scope of this
> command to make a decision about trading off speed/io for optimal repo
> layout.  In fact, it does do this already.  The default window, depth and
> compression settings are chosen to be "good enough", not to produce the
> absolute optimum repo.
> 
> I'm just pointing out that everything is a trade off.  So I think saying
> something like "gc must optimize for git's performance" is not entirely
> accurate.  We make tradeoffs now.  Other tradeoffs may be helpful.

Sure, but my point was that git doesn't even know _how_ to make that
tradeoff. It doesn't know what you consider a reasonable size of backup
for your incremental backups, how often you might want to rollover your
keep files, how often you expect to commit and how big the commits will
be, etc.

So it does the most reasonable thing, which is to optimize for git
itself based on what it does know. If there is any improvement to be
made, it is probably to make a simpler way for the user to specify that
external knowledge to git (because tweaking .keep files really is
unnecessarily complex for Matthieu's scenario). And maybe that is just
adding a config variable analagous to "gc.autopacklimit" to be used for
regular gc, but that would default to 0 (i.e., default to the current
behavior of always repacking).

But I don't think it makes sense to change the default.

-Peff
