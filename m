From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [PATCH 2/5] add object-cache infrastructure
Date: Tue, 12 Jul 2011 21:38:44 +0200
Message-ID: <20110712193844.GA17322@toss.lan>
References: <20110711161332.GA10057@sigill.intra.peff.net>
 <20110711161754.GB10418@sigill.intra.peff.net>
 <7vliw4d1hu.fsf@alter.siamese.dyndns.org>
 <20110711220107.GC30155@sigill.intra.peff.net>
 <7vk4bo9ze5.fsf@alter.siamese.dyndns.org>
 <20110712000304.GA32276@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>, Ted Ts'o <tytso@mit.edu>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jul 12 21:38:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QginH-0001jz-0z
	for gcvg-git-2@lo.gmane.org; Tue, 12 Jul 2011 21:38:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754845Ab1GLTiv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jul 2011 15:38:51 -0400
Received: from bsmtp3.bon.at ([213.33.87.17]:25575 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754107Ab1GLTiu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jul 2011 15:38:50 -0400
X-Greylist: delayed 92495 seconds by postgrey-1.27 at vger.kernel.org; Tue, 12 Jul 2011 15:38:49 EDT
Received: from localhost (unknown [80.123.242.182])
	by bsmtp.bon.at (Postfix) with ESMTP id 90E0410011;
	Tue, 12 Jul 2011 21:38:45 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20110712000304.GA32276@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176971>

On Mon, Jul 11, 2011 at 08:03:04PM -0400, Jeff King wrote:
> On Mon, Jul 11, 2011 at 04:21:54PM -0700, Junio C Hamano wrote:
> 
> > Actually I do not think identifying the ones that can safely skipped is
> > such a big issue. The case I am most concerned about is when you see that
> > "two reverted back to one" (which you obviously want to avoid, to keep the
> > effect of the commit the upstream has to have "two" on that line), but at
> > the same time when you do not agree with the change that the upstream took
> > for the _current commit_ you are replaying (i.e. you want the final result
> > to have "one", not "modified one" which the upstream has applied).
> 
> I'm not sure there's a general solution to that. You can't keep the
> commit you want intact, because you are rebasing and therefore building
> on top of the other broken commit. So in a history like:
> 
>     B'--C'
>    /
>   A--B--C
> 
> You really want to perform the transformation of B to B', but on top of
> C (i.e., "git checkout C; git diff B' B | git apply"). But if B and C
> are textually related, it's going to conflict horribly. And I don't
> think there is a general solution short of a darcs-style patch algebra.

FWIW, I tried this in darcs and it has exactly the same problem.

It does have better granularity when detecting changes. For
example, it will recognize the changes of B' in B, even if B
contains non-conflicting hunks on top of the changes in B'. Git
only recognizes identical commits, and this is something where we
could improve without too much difficulty (think per-hunk
patch-ids).

But if the changes in B and B' have conflicts, then darcs will
present the user with the options B' and C, which looks like we
were trying to revert C, just like it does with git.

Clemens
