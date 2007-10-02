From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (topics)
Date: Tue, 2 Oct 2007 13:39:41 -0400
Message-ID: <20071002173941.GA7187@coredump.intra.peff.net>
References: <7v1wd1d0le.fsf@gitster.siamese.dyndns.org> <7vfy11yyxk.fsf@gitster.siamese.dyndns.org> <20070927023633.GA28902@coredump.intra.peff.net> <20071002041652.GA32133@coredump.intra.peff.net> <7vsl4up0tf.fsf@gitster.siamese.dyndns.org> <20071002050820.GA4261@coredump.intra.peff.net> <20071002051332.GA4462@coredump.intra.peff.net> <86ejge6o8b.fsf@lola.quinscape.zz> <20071002161114.GC6828@coredump.intra.peff.net> <86ve9p32cp.fsf@lola.quinscape.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Tue Oct 02 19:40:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IcljB-0005OD-Lj
	for gcvg-git-2@gmane.org; Tue, 02 Oct 2007 19:40:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753198AbXJBRjp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Oct 2007 13:39:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753448AbXJBRjp
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Oct 2007 13:39:45 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4584 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753016AbXJBRjo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Oct 2007 13:39:44 -0400
Received: (qmail 29910 invoked by uid 111); 2 Oct 2007 17:39:42 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Tue, 02 Oct 2007 13:39:42 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 02 Oct 2007 13:39:41 -0400
Content-Disposition: inline
In-Reply-To: <86ve9p32cp.fsf@lola.quinscape.zz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59700>

On Tue, Oct 02, 2007 at 06:31:18PM +0200, David Kastrup wrote:

> This does not actually require an actual merge _sort_ AFAICS: do the
> "sort file.hashed" step using qsort.  The comparison step does not
> actually need to produce merged output, but merely advances through
> two hash arrays and generates statistics.

Right, that's why I used "merge" in quotes. The sort used in the O(n)
step is irrelevant, but we are doing a merge-sort-like behavior in the
second step (except instead of actually merging into a new list, we are
summarizing the comparisons in a numeric "difference" variable). But I
think we are on the same page.

> This should already beat the pants off the current implementation,
> even when the hash array is sparse, simply because our inner loop then
> has perfect hash coherence.

Yes, I hope so. We'll see. :)

> Getting rid of this outer O(n^2) remains an interesting challenge,
> though.  One way would be the following: fill a _single_ array with
> entries containing _both_ hash and file number.  Sort this, and then
> gather the statistics of hash runs by making a single pass through.
> That reduces the O(n^2) behavior to only those parts with actual hash
> collisions.

Interesting. Care to take a stab at implementing it?

-Peff
