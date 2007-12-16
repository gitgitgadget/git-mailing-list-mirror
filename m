From: Jeff King <peff@peff.net>
Subject: Re: trim_common_tail bug?
Date: Sun, 16 Dec 2007 16:21:04 -0500
Message-ID: <20071216212104.GA32307@coredump.intra.peff.net>
References: <20071215111621.GA8139@coredump.intra.peff.net> <20071215155150.GA24810@coredump.intra.peff.net> <7vprx7n90t.fsf@gitster.siamese.dyndns.org> <20071215200202.GA3334@sigill.intra.peff.net> <20071216070614.GA5072@sigill.intra.peff.net> <7v8x3ul927.fsf@gitster.siamese.dyndns.org> <7v7ijejq6j.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Dec 16 22:21:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J40vV-0002Ve-1i
	for gcvg-git-2@gmane.org; Sun, 16 Dec 2007 22:21:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758002AbXLPVVK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Dec 2007 16:21:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758003AbXLPVVJ
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Dec 2007 16:21:09 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3247 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754969AbXLPVVI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Dec 2007 16:21:08 -0500
Received: (qmail 3527 invoked by uid 111); 16 Dec 2007 21:21:06 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sun, 16 Dec 2007 16:21:06 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 16 Dec 2007 16:21:04 -0500
Content-Disposition: inline
In-Reply-To: <7v7ijejq6j.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68491>

On Sun, Dec 16, 2007 at 01:16:36PM -0800, Junio C Hamano wrote:

> > I wanted to recover to the end of the line that includes the cut-off
> > point, even when (ctx == 0), to be extra safer, but I do not think it
> > was necessary.
> 
> I have to wonder what happens if the last line which is incomplete has
> more than block bytes that are identical at the end?  We need to recover
> the whole thing to show the correct diff, don't we?

No, I think it's right as-is. We forget about the blocks during the
recovery section of the code. IOW, we just keep reading forward until we
find all of the context lines, or we run out of trimmed content. In the
first case, we are fine (we restored the right number of context lines).
In the latter case, we are also fine, because we end up trimming nothing
(IOW, there _weren't_ enough context lines in the first place).

-Peff
