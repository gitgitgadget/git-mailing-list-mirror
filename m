From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] diff: resurrect the traditional empty "diff --git"
	behaviour
Date: Fri, 31 Aug 2007 16:32:50 -0400
Message-ID: <20070831203250.GA19340@coredump.intra.peff.net>
References: <20070830072748.GF16312@mellanox.co.il> <7vmyw85uml.fsf@gitster.siamese.dyndns.org> <20070831080651.GA17637@mellanox.co.il> <7vabs82kcq.fsf@gitster.siamese.dyndns.org> <20070831081517.GB17637@mellanox.co.il> <7v4pig2j91.fsf@gitster.siamese.dyndns.org> <20070831152120.GC17637@mellanox.co.il> <7vr6lj1zg3.fsf@gitster.siamese.dyndns.org> <20070831160335.GA17761@coredump.intra.peff.net> <7vtzqfzcll.fsf_-_@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 31 22:33:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRDAm-000689-Rr
	for gcvg-git@gmane.org; Fri, 31 Aug 2007 22:32:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759712AbXHaUcx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 31 Aug 2007 16:32:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757947AbXHaUcx
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Aug 2007 16:32:53 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4561 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754116AbXHaUcw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Aug 2007 16:32:52 -0400
Received: (qmail 32695 invoked by uid 111); 31 Aug 2007 20:32:52 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Fri, 31 Aug 2007 16:32:52 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 31 Aug 2007 16:32:50 -0400
Content-Disposition: inline
In-Reply-To: <7vtzqfzcll.fsf_-_@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57203>

On Fri, Aug 31, 2007 at 01:13:42PM -0700, Junio C Hamano wrote:

> If you set diff.autorefreshindex configuration variable, it
> squelches the empty "diff --git" output, and at the end of the
> command, it automatically runs "update-index --refresh" without
> even bothering the user.  In other words, with the configuration
> variable set, people who do not care about the cache-dirtyness
> do not even have to see the warning.

Nice. This is much more sane behavior, IMHO, and I think it should make
everyone happy.

>  Same here.  This patch saw only very light testing, but I
>  personally think is a sane thing to do before 1.5.3 final.

Passes my light testing as well, but I have a feeling we just tested the
same things...;)

One question on the implementation (and remember that I am somewhat
ignorant of the structure of this part of the code, so the answer may be
"it's too ugly"): is there a good reason to refresh _after_ the diff? It
seems like when we are looking through the working tree and index the
first time, we notice that the stat information doesn't match; why can't
we update it then? That would save an extra working tree traversal.

-Peff
