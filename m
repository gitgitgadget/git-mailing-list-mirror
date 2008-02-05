From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFH] revision limiting sometimes ignored
Date: Tue, 5 Feb 2008 22:34:42 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802052228280.8543@racer.site>
References: <20080202122135.GA5783@code-monkey.de> <20080203030054.GA18654@coredump.intra.peff.net> <20080203043310.GA5984@coredump.intra.peff.net> <alpine.LFD.1.00.0802040922480.3034@hp.linux-foundation.org> <7vr6fsk08w.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.1.00.0802041146060.3034@hp.linux-foundation.org> <alpine.LFD.1.00.0802041223080.3034@hp.linux-foundation.org> <7vir13g9hx.fsf@gitster.siamese.dyndns.org> <alpine.LFD.1.00.0802051300050.3110@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Feb 05 23:36:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMWOU-00067o-A1
	for gcvg-git-2@gmane.org; Tue, 05 Feb 2008 23:35:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758116AbYBEWfZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Feb 2008 17:35:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759455AbYBEWfZ
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Feb 2008 17:35:25 -0500
Received: from mail.gmx.net ([213.165.64.20]:46928 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756993AbYBEWfY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Feb 2008 17:35:24 -0500
Received: (qmail invoked by alias); 05 Feb 2008 22:35:22 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp025) with SMTP; 05 Feb 2008 23:35:22 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19cEBVhEaxcAE/0fKvsSSGkjW0GvZ7FV48EFOAGgR
	voxPzhFgdMPtZL
X-X-Sender: gene099@racer.site
In-Reply-To: <alpine.LFD.1.00.0802051300050.3110@woody.linux-foundation.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72712>

Hi,

On Tue, 5 Feb 2008, Linus Torvalds wrote:

> I really wonder if the right thing is not simply to admit that we consider 
> the commit time meaningful (within some fudge factor!), and then do:
> 
>  - make commit warn if any parent commit date is in the future from the 
>    current commit date (allow a *small* fudge factor here, say 5 minutes).

5 minutes seems a little narrow to me.  I think we can even go with 86400 
seconds.

>  - teach fsck to complain about parent commits being in the future from 
>    their children (allow the same small fudge factor).
> 
>  - make the revision walking code realize that if times are too close to 
>    each other, it should walk a bit further back...

There is one big problem, though.  Sometimes your clock is set wrong for 
all the wrong reasons.  Look at

	http://article.gmane.org/gmane.comp.version-control.git/67848/raw

for example (look at the Original-Date).  If that happens without being 
noticed (and it happened here!), and it is pushed, you have to live with 
it.

_However_, I could imagine that you can get most of such errors by doing 
the same as gmane: realise that the clock skew is into the future, and 
just take the sensible date.

In our case, this would mean that the revision walker should realise that 
a child whose date is not older than its parent commit must be wrong.  And 
just take the parent's date instead (but maybe only for the purpose of 
limiting).

Hmm?

Ciao,
Dscho
