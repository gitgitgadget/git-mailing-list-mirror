From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] diff: resurrect the traditional empty "diff --git"
 behaviour
Date: Fri, 31 Aug 2007 21:57:29 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708312154530.28586@racer.site>
References: <20070830072748.GF16312@mellanox.co.il> <7vmyw85uml.fsf@gitster.siamese.dyndns.org>
 <20070831080651.GA17637@mellanox.co.il> <7vabs82kcq.fsf@gitster.siamese.dyndns.org>
 <20070831081517.GB17637@mellanox.co.il> <7v4pig2j91.fsf@gitster.siamese.dyndns.org>
 <20070831152120.GC17637@mellanox.co.il> <7vr6lj1zg3.fsf@gitster.siamese.dyndns.org>
 <20070831160335.GA17761@coredump.intra.peff.net> <7vtzqfzcll.fsf_-_@gitster.siamese.dyndns.org>
 <20070831203250.GA19340@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	"Michael S. Tsirkin" <mst@dev.mellanox.co.il>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Aug 31 22:57:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRDYk-0004aK-3y
	for gcvg-git@gmane.org; Fri, 31 Aug 2007 22:57:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760843AbXHaU5i (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 31 Aug 2007 16:57:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760664AbXHaU5i
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Aug 2007 16:57:38 -0400
Received: from mail.gmx.net ([213.165.64.20]:41801 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756620AbXHaU5h (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Aug 2007 16:57:37 -0400
Received: (qmail invoked by alias); 31 Aug 2007 20:57:35 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp002) with SMTP; 31 Aug 2007 22:57:35 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/m5TtC6nLmGce/R/7LAXbfcPQpb6wj9HRHKmWL/0
	Cgwln24V8WA0lT
X-X-Sender: gene099@racer.site
In-Reply-To: <20070831203250.GA19340@coredump.intra.peff.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57205>

Hi,

On Fri, 31 Aug 2007, Jeff King wrote:

> On Fri, Aug 31, 2007 at 01:13:42PM -0700, Junio C Hamano wrote:
> 
> > If you set diff.autorefreshindex configuration variable, it
> > squelches the empty "diff --git" output, and at the end of the
> > command, it automatically runs "update-index --refresh" without
> > even bothering the user.  In other words, with the configuration
> > variable set, people who do not care about the cache-dirtyness
> > do not even have to see the warning.
> 
> Nice. This is much more sane behavior, IMHO, and I think it should make 
> everyone happy.

I could even imagine that this will eventually become the standard 
behaviour.

> >  Same here.  This patch saw only very light testing, but I
> >  personally think is a sane thing to do before 1.5.3 final.
> 
> Passes my light testing as well, but I have a feeling we just tested the
> same things...;)
> 
> One question on the implementation (and remember that I am somewhat
> ignorant of the structure of this part of the code, so the answer may be
> "it's too ugly"): is there a good reason to refresh _after_ the diff?

We do not need to do it always.  After the diff, we know if the index 
needs refreshing.  Before, we don't.

> It seems like when we are looking through the working tree and index the 
> first time, we notice that the stat information doesn't match; why can't 
> we update it then? That would save an extra working tree traversal.

But that would be intrusive in the diff machinery IMHO.  It should stay as 
read-only as possible.

BTW I was a little concerned that the locking would fail in a read-only 
setup, and that git would die(), but that has been taken care of, so I 
have no objections left.

Thanks, Junio.

Ciao,
Dscho
