From: Jeff King <peff@peff.net>
Subject: Re: [BUG] - git rebase -i performs rebase when it shouldn't?
Date: Sun, 11 Apr 2010 21:01:23 -0400
Message-ID: <20100412010123.GA11051@coredump.intra.peff.net>
References: <z2q76c5b8581004091235ucd9b2a52i223b3191b288c42a@mail.gmail.com>
 <4BC0D87E.70001@kdbg.org>
 <20100411101526.GA20484@coredump.intra.peff.net>
 <201004111954.38156.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Eugene Sajine <euguess@gmail.com>, git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Mon Apr 12 03:02:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O182T-0005ME-7O
	for gcvg-git-2@lo.gmane.org; Mon, 12 Apr 2010 03:02:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753290Ab0DLBBu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Apr 2010 21:01:50 -0400
Received: from peff.net ([208.65.91.99]:35772 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753212Ab0DLBBt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Apr 2010 21:01:49 -0400
Received: (qmail 11999 invoked by uid 107); 12 Apr 2010 01:01:50 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 11 Apr 2010 21:01:50 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 11 Apr 2010 21:01:23 -0400
Content-Disposition: inline
In-Reply-To: <201004111954.38156.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144701>

On Sun, Apr 11, 2010 at 07:54:37PM +0200, Johannes Sixt wrote:

> On Sonntag, 11. April 2010, Jeff King wrote:
> > Good point. Originally, we did the rebase directly on the branch, though
> > I'm not sure if we did "checkout $branch && reset $onto" or "branch -f
> > $branch $onto && checkout $branch". These days we operate on a detached
> > HEAD, and we seem to "checkout $onto^0", which should do the
> > optimization you mention.
> 
> But before this "checkout $onto^0" happens, some (all?) variants still 
> do "checkout topic && rev-list upstream..HEAD" instead of just "rev-list 
> upstream..topic".

I don't think this is the case any longer for regular rebase, from my
reading of the code and doing a rebase under GIT_TRACE. Grepping the
history turns up 0cb0664 (rebase [--onto O] A B: omit needless checkout,
2008-03-15).

But doing an interactive rebase under GIT_TRACE, it looks like it still
does the unnecessary checkout.

-Peff
