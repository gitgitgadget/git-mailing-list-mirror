From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [PATCH 2/5] add object-cache infrastructure
Date: Thu, 14 Jul 2011 10:04:53 +0200
Message-ID: <20110714080453.GA6690@toss.lan>
References: <20110711161332.GA10057@sigill.intra.peff.net>
 <20110711161754.GB10418@sigill.intra.peff.net>
 <7vliw4d1hu.fsf@alter.siamese.dyndns.org>
 <20110711220107.GC30155@sigill.intra.peff.net>
 <7vk4bo9ze5.fsf@alter.siamese.dyndns.org>
 <20110712000304.GA32276@sigill.intra.peff.net>
 <20110712193844.GA17322@toss.lan>
 <20110712194540.GA21180@sigill.intra.peff.net>
 <20110712210716.GB17322@toss.lan>
 <20110712213607.GA12447@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>, Ted Ts'o <tytso@mit.edu>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jul 14 10:05:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QhGv8-0007mY-Va
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jul 2011 10:05:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753841Ab1GNIFK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jul 2011 04:05:10 -0400
Received: from bsmtp3.bon.at ([213.33.87.17]:16340 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753680Ab1GNIFD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jul 2011 04:05:03 -0400
Received: from localhost (unknown [80.123.242.182])
	by bsmtp.bon.at (Postfix) with ESMTP id 3B1B0CDF9C;
	Thu, 14 Jul 2011 10:04:55 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20110712213607.GA12447@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177104>

On Tue, Jul 12, 2011 at 05:36:07PM -0400, Jeff King wrote:
> 
> In the normal case of applying patch B on top of patch A, it doesn't
> matter if we use per-hunk patch-ids or normal patch-ids. Because even if
> we decide to actually go through with the merge of B on top of A, any
> hunks that _would have_ had their per-hunk patch-ids match will merge
> cleanly.
> 
> But in the real world, it is about applying patch Z on top of patches
> A..Y, where Z has similar hunks to patch N. And then it _does_ make a
> difference, because it is about skipping hunks from Z that are already
> in N, but will end up applied on top of Y. And what's in Y and what's in
> N may be quite different.
> 
> Does that sound right?

Yes, exactly.

And one possible solution would be to drop all hunks from Z which
are already somewhere in A..Y. But that undermines the whole
changeset idea.

If we detect the similarities between Z and N, then we could rebase
Z to N, make the user resolve any conflicts, which should make more
sense than what we would have between Z and Y. Then we have Z' on
top of N:

  Z      Z'     Z"
 /      /      /
A--..--N--..--Y

Subsequently we rebase Z' to Y, at which point only changes remain
that we disagreed with. For those we may have to do conflict
resolution again. So, in some cases this approach could result in
more work.

Clemens
